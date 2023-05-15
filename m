Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671F7703652
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbjEORJD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbjEORIo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:08:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96909ED5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79FFA62B04
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802DBC433EF;
        Mon, 15 May 2023 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170406;
        bh=fFIITTqZj4Tpks68nbymJI6pymHbMQrYOSVdLreAt7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vF0guvtE1egFBRubGtMzU/58OtVm+efPSnMCTQD3ZQ1m0UnCJJZJbSH66P2zezIId
         /AbwXi5r36U7s6Xa1IQgB1vX6KKNazIMCicJJdvsiyixQIhVPgqWlgt8CD2tyWNx7a
         JUfJ4oQrdOXNRhvdTNDFruqeWdJeKoHobEF4vWyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 092/239] perf vendor events s390: Remove UTF-8 characters from JSON file
Date:   Mon, 15 May 2023 18:25:55 +0200
Message-Id: <20230515161724.431574414@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit eb2feb68cb7d404288493c41480843bc9f404789 ]

Commit 7f76b31130680fb3 ("perf list: Add IBM z16 event description for
s390") contains the verbal description for z16 extended counter set.

However some entries of the public description contain UTF-8 characters
which breaks the build on some distros.

Fix this and remove the UTF-8 characters.

Fixes: 7f76b31130680fb3 ("perf list: Add IBM z16 event description for s390")
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: https://lore.kernel.org/r/ZBwkl77/I31AQk12@osiris
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/pmu-events/arch/s390/cf_z16/extended.json | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/extended.json b/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
index c306190fc06f2..c2b10ec1c6e01 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
@@ -95,28 +95,28 @@
 		"EventCode": "145",
 		"EventName": "DCW_REQ",
 		"BriefDescription": "Directory Write Level 1 Data Cache from Cache",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache."
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "DCW_REQ_IV",
 		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache with intervention."
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "DCW_REQ_CHIP_HIT",
 		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Chip HP Hit",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "DCW_REQ_DRAWER_HIT",
 		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Drawer HP Hit",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
@@ -284,7 +284,7 @@
 		"EventCode": "172",
 		"EventName": "ICW_REQ_DRAWER_HIT",
 		"BriefDescription": "Directory Write Level 1 Instruction Cache from Cache with Drawer HP Hit",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestor’s Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestors Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
 	},
 	{
 		"Unit": "CPU-M-CF",
-- 
2.39.2



