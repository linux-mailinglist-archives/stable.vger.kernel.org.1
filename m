Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9497A7B43
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjITLuo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjITLul (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:50:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7877CE0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:50:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A35C433C7;
        Wed, 20 Sep 2023 11:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210636;
        bh=YwYgdfW/Q8ZaoP0KXcerIq9JqwxS5gG2iQtp5M5DcUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qnf3yTj3SHLositNJGUcgxdLpEi+yavqdJLD5OtypeR16Fi6a9+LFwUxR5hrpxByY
         54osanaxrhXoCvXdXEWrHB7J6WbtSU/198L70wnMUl7N1ucLjZGo9HNQlBIW6wE/yz
         Mq9EQGnGpRGkCUXk5HxlMGVDf3HALXpiWbQz90Lo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 148/211] efivarfs: fix statfs() on efivarfs
Date:   Wed, 20 Sep 2023 13:29:52 +0200
Message-ID: <20230920112850.448575957@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

[ Upstream commit 79b83606abc778aa3cbee535b362ce905d0b9448 ]

Some firmware (notably U-Boot) provides GetVariable() and
GetNextVariableName() but not QueryVariableInfo().

With commit d86ff3333cb1 ("efivarfs: expose used and total size") the
statfs syscall was broken for such firmware.

If QueryVariableInfo() does not exist or returns EFI_UNSUPPORTED, just
report the file system size as 0 as statfs_simple() previously did.

Fixes: d86ff3333cb1 ("efivarfs: expose used and total size")
Link: https://lore.kernel.org/all/20230910045445.41632-1-heinrich.schuchardt@canonical.com/
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
[ardb: log warning on QueryVariableInfo() failure]
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/efivarfs/super.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f38..996271473609a 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -32,10 +32,16 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	u64 storage_space, remaining_space, max_variable_size;
 	efi_status_t status;
 
-	status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
-					    &max_variable_size);
-	if (status != EFI_SUCCESS)
-		return efi_status_to_err(status);
+	/* Some UEFI firmware does not implement QueryVariableInfo() */
+	storage_space = remaining_space = 0;
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
+		status = efivar_query_variable_info(attr, &storage_space,
+						    &remaining_space,
+						    &max_variable_size);
+		if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
+			pr_warn_ratelimited("query_variable_info() failed: 0x%lx\n",
+					    status);
+	}
 
 	/*
 	 * This is not a normal filesystem, so no point in pretending it has a block
-- 
2.40.1



