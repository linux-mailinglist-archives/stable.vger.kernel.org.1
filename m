Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D267555FC
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjGPUqe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjGPUqd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA7F10C8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C20F860EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF02C433C7;
        Sun, 16 Jul 2023 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540386;
        bh=eGcAX/1bW5tKG8PuNnYX4jFIAjuCwurlRGbFLQ654Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAGs2RcUP2pcEg2/X5XoLL7dwTEgEFKzWiWbeUkxD6/8p0RvQeR9njfEnLqEs4VtV
         rrM3OCT9Eq1EvSJNOS6OszxS0aqIz0LyxbLk+B3tq0qiboFVTPOK7AvxeaRcDckoMe
         2cs5FnrI/jq+byBYtIzoxYuT+spy1Evyysgx75RY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Colin Ian King <colin.i.king@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 318/591] powerpc/powernv/sriov: perform null check on iov before dereferencing iov
Date:   Sun, 16 Jul 2023 21:47:37 +0200
Message-ID: <20230716194932.118658136@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit f4f913c980bc6abe0ccfe88fe3909c125afe4a2d ]

Currently pointer iov is being dereferenced before the null check of iov
which can lead to null pointer dereference errors. Fix this by moving the
iov null check before the dereferencing.

Detected using cppcheck static analysis:
linux/arch/powerpc/platforms/powernv/pci-sriov.c:597:12: warning: Either
the condition '!iov' is redundant or there is possible null pointer
dereference: iov. [nullPointerRedundantCheck]
 num_vfs = iov->num_vfs;
           ^

Fixes: 052da31d45fc ("powerpc/powernv/sriov: De-indent setup and teardown")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230608095849.1147969-1-colin.i.king@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/pci-sriov.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 7195133b26bb9..59882da3e7425 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -594,12 +594,12 @@ static void pnv_pci_sriov_disable(struct pci_dev *pdev)
 	struct pnv_iov_data   *iov;
 
 	iov = pnv_iov_get(pdev);
-	num_vfs = iov->num_vfs;
-	base_pe = iov->vf_pe_arr[0].pe_number;
-
 	if (WARN_ON(!iov))
 		return;
 
+	num_vfs = iov->num_vfs;
+	base_pe = iov->vf_pe_arr[0].pe_number;
+
 	/* Release VF PEs */
 	pnv_ioda_release_vf_PE(pdev);
 
-- 
2.39.2



