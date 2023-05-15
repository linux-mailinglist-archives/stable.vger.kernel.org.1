Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F52B7033BA
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242855AbjEOQko (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242885AbjEOQkj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:40:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF9B19A5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B2E86287D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8332EC433EF;
        Mon, 15 May 2023 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168837;
        bh=/UKr004evnkdD0XLmmaPB9duSQxXefbAZojm1CbZ/EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kj+JpfcTglJuUiJHICoZMRKsZx1GRceLYYqMCT/bDALq/ywu3pU00UbteNuit+jxj
         i0R4Rki1q85qx9b/R5Hnw6n2uj/3tieEBV/zjtNNvgHXQqLJw/HHwTug3ca2uIeRUd
         isDcpOEO3SiHB4IXkfzDLF+ReAuRYo6FrOQ9ytO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Feng Xu <feng.f.xu@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/191] EDAC/skx: Fix overflows on the DRAM row address mapping arrays
Date:   Mon, 15 May 2023 18:24:26 +0200
Message-Id: <20230515161708.230654196@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[ Upstream commit 71b1e3ba3fed5a34c5fac6d3a15c2634b04c1eb7 ]

The current DRAM row address mapping arrays skx_{open,close}_row[]
only support ranks with sizes up to 16G. Decoding a rank address
to a DRAM row address for a 32G rank by using either one of the
above arrays by the skx_edac driver, will result in an overflow on
the array.

For a 32G rank, the most significant DRAM row address bit (the
bit17) is mapped from the bit34 of the rank address. Add this new
mapping item to both arrays to fix the overflow issue.

Fixes: 4ec656bdf43a ("EDAC, skx_edac: Add EDAC driver for Skylake")
Reported-by: Feng Xu <feng.f.xu@intel.com>
Tested-by: Feng Xu <feng.f.xu@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/all/20230211011728.71764-1-qiuxu.zhuo@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/skx_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/skx_edac.c b/drivers/edac/skx_edac.c
index b97803580d70f..38a82a3f45167 100644
--- a/drivers/edac/skx_edac.c
+++ b/drivers/edac/skx_edac.c
@@ -825,13 +825,13 @@ static bool skx_rir_decode(struct decoded_addr *res)
 }
 
 static u8 skx_close_row[] = {
-	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33
+	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33, 34
 };
 static u8 skx_close_column[] = {
 	3, 4, 5, 14, 19, 23, 24, 25, 26, 27
 };
 static u8 skx_open_row[] = {
-	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33
+	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34
 };
 static u8 skx_open_column[] = {
 	3, 4, 5, 6, 7, 8, 9, 10, 11, 12
-- 
2.39.2



