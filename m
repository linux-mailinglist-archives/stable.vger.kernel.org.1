Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED267A7EB6
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjITMUU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbjITMUJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:20:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C449CA
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:20:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2154C433C7;
        Wed, 20 Sep 2023 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212402;
        bh=/9/hDD6o6n0s7IFMLO5iWWa12FMRlRD2FXX17IBQLco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gcUBqeSCy1+FQIee1Wrkg/f8HSAKP5HNu/sECn7bM9nuFAi8/A+KS/uvc9/Q7RYcy
         vHCxJCOihKBg0LJRDglwOmN9cG+HsB1CzxHlTer2Jxgq3U7wnWcwmYRRJCE5vMA9jd
         OeCsTHvH0rUGMHsIK9v8Xx1wrD8Gq3U1oa8x2nuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ma Ke <make_ruc2021@163.com>,
        Li Yang <leoyang.li@nxp.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 262/273] usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc
Date:   Wed, 20 Sep 2023 13:31:42 +0200
Message-ID: <20230920112854.347747562@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make_ruc2021@163.com>

[ Upstream commit ce9daa2efc0872a9a68ea51dc8000df05893ef2e ]

We should verify the bound of the array to assure that host
may not manipulate the index to point past endpoint array.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
Link: https://lore.kernel.org/r/20230628081511.186850-1-make_ruc2021@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 2707be6282988..63109c6e55068 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1950,6 +1950,8 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
 	} else if ((request_type & USB_RECIP_MASK) == USB_RECIP_ENDPOINT) {
 		/* Get endpoint status */
 		int pipe = index & USB_ENDPOINT_NUMBER_MASK;
+		if (pipe >= USB_MAX_ENDPOINTS)
+			goto stall;
 		struct qe_ep *target_ep = &udc->eps[pipe];
 		u16 usep;
 
-- 
2.40.1



