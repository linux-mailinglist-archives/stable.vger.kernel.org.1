Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB64703B72
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244732AbjEOSDJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244740AbjEOSCw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:02:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925C31A3A2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECA9A62FDC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E327EC433D2;
        Mon, 15 May 2023 17:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173324;
        bh=7dmUiiLIqmSJh3Nu5guEigdCSnBpIDB7gUp91C6eAcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iogGTG4gx3hgvYMKfAg/WXR6rNYcoDxAngJUYggaaWE6Sc3c56WgVrbUGcnb/Rvrp
         W0ps7FAk5qbxQA34liT5hAYQTeKJruxHbYocHZyln1zUJ5OvcN4f/nChv7ECllDjon
         jzhHrUI5DoM9wfQ88XGr8H0boM+zZeA1ddUQSufE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Feng Xu <feng.f.xu@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 040/282] EDAC/skx: Fix overflows on the DRAM row address mapping arrays
Date:   Mon, 15 May 2023 18:26:58 +0200
Message-Id: <20230515161723.469621926@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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
 drivers/edac/skx_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index b1d717cb8df9f..f382cc70f9aaa 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -459,7 +459,7 @@ static bool skx_rir_decode(struct decoded_addr *res)
 }
 
 static u8 skx_close_row[] = {
-	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33
+	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33, 34
 };
 
 static u8 skx_close_column[] = {
@@ -467,7 +467,7 @@ static u8 skx_close_column[] = {
 };
 
 static u8 skx_open_row[] = {
-	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33
+	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34
 };
 
 static u8 skx_open_column[] = {
-- 
2.39.2



