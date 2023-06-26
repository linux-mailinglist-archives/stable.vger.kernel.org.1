Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9636E73E798
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjFZSQx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFZSQv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:16:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E5494
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9570260F51
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69C9C433C0;
        Mon, 26 Jun 2023 18:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803410;
        bh=FhJZJRPNIXTaEBoiLJSDbJtYs+v14axgV5dNVJVdOZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfbpC4dh4LtPtwRuTFiFjBaqLm/WnVJyMeWw0oNsJn0OFgEXubMMGL75h3AkIAP3m
         FAk4D+Urc7n8/ueJYNu5HSAx2xNdSpx/zBA0qMLNiQdKu4d3dxR/4/XdSHblZRmcZt
         ccOMCNqadcE92KhjPFaV6RZ3rgrYhsOwZ0CMwgQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>,
        Marc-Andr Lureau <marcandre.lureau@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 051/199] memfd: check for non-NULL file_seals in memfd_create() syscall
Date:   Mon, 26 Jun 2023 20:09:17 +0200
Message-ID: <20230626180807.822495989@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

commit 935d44acf621aa0688fef8312dec3e5940f38f4e upstream.

Ensure that file_seals is non-NULL before using it in the memfd_create()
syscall.  One situation in which memfd_file_seals_ptr() could return a
NULL pointer when CONFIG_SHMEM=n, oopsing the kernel.

Link: https://lkml.kernel.org/r/20230607132427.2867435-1-roberto.sassu@huaweicloud.com
Fixes: 47b9012ecdc7 ("shmem: add sealing support to hugetlb-backed memfd")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Marc-Andr Lureau <marcandre.lureau@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memfd.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -375,12 +375,15 @@ SYSCALL_DEFINE2(memfd_create,
 
 		inode->i_mode &= ~0111;
 		file_seals = memfd_file_seals_ptr(file);
-		*file_seals &= ~F_SEAL_SEAL;
-		*file_seals |= F_SEAL_EXEC;
+		if (file_seals) {
+			*file_seals &= ~F_SEAL_SEAL;
+			*file_seals |= F_SEAL_EXEC;
+		}
 	} else if (flags & MFD_ALLOW_SEALING) {
 		/* MFD_EXEC and MFD_ALLOW_SEALING are set */
 		file_seals = memfd_file_seals_ptr(file);
-		*file_seals &= ~F_SEAL_SEAL;
+		if (file_seals)
+			*file_seals &= ~F_SEAL_SEAL;
 	}
 
 	fd_install(fd, file);


