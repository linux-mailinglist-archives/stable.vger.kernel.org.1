Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9BE7D2FC9
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 12:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjJWKZX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 06:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjJWKZR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 06:25:17 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428B7D6B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 03:25:14 -0700 (PDT)
Received: from hverkuil by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <hverkuil@linuxtv.org>)
        id 1qus7U-005WYU-BI; Mon, 23 Oct 2023 10:25:12 +0000
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Mon, 23 Oct 2023 10:24:52 +0000
Subject: [git:media_stage/master] media: venus: hfi: add checks to handle capabilities from firmware
To:     linuxtv-commits@linuxtv.org
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        stable@vger.kernel.org, Vikash Garodia <quic_vgarodia@quicinc.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1qus7U-005WYU-BI@www.linuxtv.org>
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: venus: hfi: add checks to handle capabilities from firmware
Author:  Vikash Garodia <quic_vgarodia@quicinc.com>
Date:    Thu Aug 10 07:55:03 2023 +0530

The hfi parser, parses the capabilities received from venus firmware and
copies them to core capabilities. Consider below api, for example,
fill_caps - In this api, caps in core structure gets updated with the
number of capabilities received in firmware data payload. If the same api
is called multiple times, there is a possibility of copying beyond the max
allocated size in core caps.
Similar possibilities in fill_raw_fmts and fill_profile_level functions.

Cc: stable@vger.kernel.org
Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/qcom/venus/hfi_parser.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

---

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 6cf74b2bc5ae..9d6ba22698cc 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -86,6 +86,9 @@ static void fill_profile_level(struct hfi_plat_caps *cap, const void *data,
 {
 	const struct hfi_profile_level *pl = data;
 
+	if (cap->num_pl + num >= HFI_MAX_PROFILE_COUNT)
+		return;
+
 	memcpy(&cap->pl[cap->num_pl], pl, num * sizeof(*pl));
 	cap->num_pl += num;
 }
@@ -111,6 +114,9 @@ fill_caps(struct hfi_plat_caps *cap, const void *data, unsigned int num)
 {
 	const struct hfi_capability *caps = data;
 
+	if (cap->num_caps + num >= MAX_CAP_ENTRIES)
+		return;
+
 	memcpy(&cap->caps[cap->num_caps], caps, num * sizeof(*caps));
 	cap->num_caps += num;
 }
@@ -137,6 +143,9 @@ static void fill_raw_fmts(struct hfi_plat_caps *cap, const void *fmts,
 {
 	const struct raw_formats *formats = fmts;
 
+	if (cap->num_fmts + num_fmts >= MAX_FMT_ENTRIES)
+		return;
+
 	memcpy(&cap->fmts[cap->num_fmts], formats, num_fmts * sizeof(*formats));
 	cap->num_fmts += num_fmts;
 }
@@ -159,6 +168,9 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 		rawfmts[i].buftype = fmt->buffer_type;
 		i++;
 
+		if (i >= MAX_FMT_ENTRIES)
+			return;
+
 		if (pinfo->num_planes > MAX_PLANES)
 			break;
 
