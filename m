Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA207BDFCE
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377144AbjJINeQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377141AbjJINeP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:34:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9171194
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:34:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F2FC433CA;
        Mon,  9 Oct 2023 13:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858452;
        bh=IRdLXW6uTg+ujRIqye0wdO6MyhRWi7K4KHfq7piC0/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzOn1Cie8Le/0uQwHrcLLkkWMglL3t75dfOAmFRweppI0ocSDLUZA+Vous2UiN9JS
         wAkt+pawmWk4MkyUoeV6SPHmU8LBHG+NdA8KQvhmEaciQsi8S4z1bG74q0ZDBxt5W5
         ri3c34DvXFbtDsmcJ1b4+QbRqvvFY2pDvjw2VYYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.4 126/131] RDMA/uverbs: Fix typo of sizeof argument
Date:   Mon,  9 Oct 2023 15:02:46 +0200
Message-ID: <20231009130120.277769924@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>

commit c489800e0d48097fc6afebd862c6afa039110a36 upstream.

Since size of 'hdr' pointer and '*hdr' structure is equal on 64-bit
machines issue probably didn't cause any wrong behavior. But anyway,
fixing of typo is required.

Fixes: da0f60df7bd5 ("RDMA/uverbs: Prohibit write() calls with too small buffers")
Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Link: https://lore.kernel.org/r/20230905103258.1738246-1-konstantin.meskhidze@huawei.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/uverbs_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -633,7 +633,7 @@ static ssize_t verify_hdr(struct ib_uver
 	if (hdr->in_words * 4 != count)
 		return -EINVAL;
 
-	if (count < method_elm->req_size + sizeof(hdr)) {
+	if (count < method_elm->req_size + sizeof(*hdr)) {
 		/*
 		 * rdma-core v18 and v19 have a bug where they send DESTROY_CQ
 		 * with a 16 byte write instead of 24. Old kernels didn't


