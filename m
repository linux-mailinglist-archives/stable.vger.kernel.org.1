Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBD173EA53
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjFZSp7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjFZSp6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFC697
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A68F60E8D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F57C433C0;
        Mon, 26 Jun 2023 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805155;
        bh=yT6nokENrCHLciP+rMGK+fmdcAvNa5ZyGosY0qkP1NE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zwyrtb0Z60M3+PyL9z2ljp2zX1J7Nq2BW3HhkF7dQ1NAulmMEQz8usR4IG3YK9P9o
         +gixlrPCtu3X4az2Ufp7wC8K2As3kqB7fz4W/i38aDaZjyWKbQKDqaCy+ou9uIykwa
         s9SrlkuDWzKKKP8CEBC88xSyg75Rv7/40zWN7X9Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roberto Sassu <roberto.sassu@huawei.com>,
        Marc-Andr Lureau <marcandre.lureau@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 30/81] memfd: check for non-NULL file_seals in memfd_create() syscall
Date:   Mon, 26 Jun 2023 20:12:12 +0200
Message-ID: <20230626180745.702623352@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
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

[ Upstream commit 935d44acf621aa0688fef8312dec3e5940f38f4e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index fae4142f7d254..278e5636623e6 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -330,7 +330,8 @@ SYSCALL_DEFINE2(memfd_create,
 
 	if (flags & MFD_ALLOW_SEALING) {
 		file_seals = memfd_file_seals_ptr(file);
-		*file_seals &= ~F_SEAL_SEAL;
+		if (file_seals)
+			*file_seals &= ~F_SEAL_SEAL;
 	}
 
 	fd_install(fd, file);
-- 
2.39.2



