Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231547D3210
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjJWLQW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjJWLQS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:16:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1729510D5
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:16:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A24CC433C7;
        Mon, 23 Oct 2023 11:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059772;
        bh=4QixJixl/+aW481EHp1kcFYiBbymp5BQhsqpCbtc0vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTNmU2QQufCPqiiJwGtgkXc77tw3tf+NzGYi6bj0Q5Cas6+vIJ3txilMKbIqmiAvJ
         Y6KIS6ucWYFF6K/toaYpom8Roh9yy9GAjNx2+4yzhN5kflNgFe7cJlgYqEqqHOHhFy
         pTdpggiGYc/GBuuvgDuHSCpAi4o2tKuIgYxAwnaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?=E9=BB=84=E6=80=9D=E8=81=AA?= <huangsicong@iie.ac.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 48/98] nfc: nci: fix possible NULL pointer dereference in send_acknowledge()
Date:   Mon, 23 Oct 2023 12:56:37 +0200
Message-ID: <20231023104815.310441892@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 7937609cd387246aed994e81aa4fa951358fba41 upstream.

Handle memory allocation failure from nci_skb_alloc() (calling
alloc_skb()) to avoid possible NULL pointer dereference.

Reported-by: 黄思聪 <huangsicong@iie.ac.cn>
Fixes: 391d8a2da787 ("NFC: Add NCI over SPI receive")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20231013184129.18738-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/nci/spi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/nfc/nci/spi.c
+++ b/net/nfc/nci/spi.c
@@ -163,6 +163,8 @@ static int send_acknowledge(struct nci_s
 	int ret;
 
 	skb = nci_skb_alloc(nspi->ndev, 0, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
 
 	/* add the NCI SPI header to the start of the buffer */
 	hdr = skb_push(skb, NCI_SPI_HDR_LEN);


