Return-Path: <stable+bounces-132967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAE3A918CF
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28625A25BB
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D8E22A7E3;
	Thu, 17 Apr 2025 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ihi5/LsK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3A1D63D6
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884571; cv=none; b=c4To+qZE9JDfhIm8vakUFtUfYii23gn0dHnuF0J5gSQnzGb7dFr8BHwkHJIsQK5dAeWlg8mDsJlqG46UQmGHQ/ayzrJrGI8fdrYIOG5Hq4PIvLEkbFPdUW4cl33wUMg61MP4SwZy0Dmr2a5y1RBl/AuHLLCR2dGRk/c64Eo5jM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884571; c=relaxed/simple;
	bh=iS0VZ7RbKwniYzMGiVLD9WPIBx1t1feGxn0zOAFY6WQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hyf6ybOaD/n725m24TL5Ua6X8XWPBibmduw+P/ZOWxgmtXYgBvYcm4/BoF/W1GlNNTYntrBsBj7c37C+cQXUEYFALss8xFa0d7i7hcOhE2aO0zhTMAtIELYbhhJWS6BYmibPWnh8ADus+Qdug2gIAxUIttLhpqDvjvyXL63tnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ihi5/LsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4373CC4CEE4;
	Thu, 17 Apr 2025 10:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884570;
	bh=iS0VZ7RbKwniYzMGiVLD9WPIBx1t1feGxn0zOAFY6WQ=;
	h=Subject:To:Cc:From:Date:From;
	b=Ihi5/LsKulzwgakgplr4JOwHpZYFNt+oY2DXT3mabI7zKs6hCA2PozBahGgCpTlPp
	 0xwZ2EK8fgx+S6rs8RJQG+qbVk25kvt3Rs99xp0cA93O6Tq+sYvq5Y+QzdUwS8D/+L
	 amhZpLUWtTgfPPeg/G5pKW1sP/5x/VIA3UOLfy2k=
Subject: FAILED: patch "[PATCH] media: venus: hfi_parser: refactor hfi packet parsing logic" failed to apply to 5.10-stable tree
To: quic_vgarodia@quicinc.com,bryan.odonoghue@linaro.org,hverkuil@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:09:27 +0200
Message-ID: <2025041727-carbon-stereo-7047@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9edaaa8e3e15aab1ca413ab50556de1975bcb329
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041727-carbon-stereo-7047@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9edaaa8e3e15aab1ca413ab50556de1975bcb329 Mon Sep 17 00:00:00 2001
From: Vikash Garodia <quic_vgarodia@quicinc.com>
Date: Thu, 20 Feb 2025 22:50:09 +0530
Subject: [PATCH] media: venus: hfi_parser: refactor hfi packet parsing logic

words_count denotes the number of words in total payload, while data
points to payload of various property within it. When words_count
reaches last word, data can access memory beyond the total payload. This
can lead to OOB access. With this patch, the utility api for handling
individual properties now returns the size of data consumed. Accordingly
remaining bytes are calculated before parsing the payload, thereby
eliminates the OOB access possibilities.

Cc: stable@vger.kernel.org
Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 1425c69d9006..1b3db2caa99f 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -64,7 +64,7 @@ fill_buf_mode(struct hfi_plat_caps *cap, const void *data, unsigned int num)
 		cap->cap_bufs_mode_dynamic = true;
 }
 
-static void
+static int
 parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_buffer_alloc_mode_supported *mode = data;
@@ -72,7 +72,7 @@ parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	u32 *type;
 
 	if (num_entries > MAX_ALLOC_MODE_ENTRIES)
-		return;
+		return -EINVAL;
 
 	type = mode->data;
 
@@ -84,6 +84,8 @@ parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 
 		type++;
 	}
+
+	return sizeof(*mode);
 }
 
 static void fill_profile_level(struct hfi_plat_caps *cap, const void *data,
@@ -98,7 +100,7 @@ static void fill_profile_level(struct hfi_plat_caps *cap, const void *data,
 	cap->num_pl += num;
 }
 
-static void
+static int
 parse_profile_level(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_profile_level_supported *pl = data;
@@ -106,12 +108,14 @@ parse_profile_level(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct hfi_profile_level pl_arr[HFI_MAX_PROFILE_COUNT] = {};
 
 	if (pl->profile_count > HFI_MAX_PROFILE_COUNT)
-		return;
+		return -EINVAL;
 
 	memcpy(pl_arr, proflevel, pl->profile_count * sizeof(*proflevel));
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_profile_level, pl_arr, pl->profile_count);
+
+	return pl->profile_count * sizeof(*proflevel) + sizeof(u32);
 }
 
 static void
@@ -126,7 +130,7 @@ fill_caps(struct hfi_plat_caps *cap, const void *data, unsigned int num)
 	cap->num_caps += num;
 }
 
-static void
+static int
 parse_caps(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_capabilities *caps = data;
@@ -135,12 +139,14 @@ parse_caps(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct hfi_capability caps_arr[MAX_CAP_ENTRIES] = {};
 
 	if (num_caps > MAX_CAP_ENTRIES)
-		return;
+		return -EINVAL;
 
 	memcpy(caps_arr, cap, num_caps * sizeof(*cap));
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_caps, caps_arr, num_caps);
+
+	return sizeof(*caps);
 }
 
 static void fill_raw_fmts(struct hfi_plat_caps *cap, const void *fmts,
@@ -155,7 +161,7 @@ static void fill_raw_fmts(struct hfi_plat_caps *cap, const void *fmts,
 	cap->num_fmts += num_fmts;
 }
 
-static void
+static int
 parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_uncompressed_format_supported *fmt = data;
@@ -164,7 +170,8 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 	struct raw_formats rawfmts[MAX_FMT_ENTRIES] = {};
 	u32 entries = fmt->format_entries;
 	unsigned int i = 0;
-	u32 num_planes;
+	u32 num_planes = 0;
+	u32 size;
 
 	while (entries) {
 		num_planes = pinfo->num_planes;
@@ -174,7 +181,7 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 		i++;
 
 		if (i >= MAX_FMT_ENTRIES)
-			return;
+			return -EINVAL;
 
 		if (pinfo->num_planes > MAX_PLANES)
 			break;
@@ -186,9 +193,13 @@ parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 
 	for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
 		       fill_raw_fmts, rawfmts, i);
+	size = fmt->format_entries * (sizeof(*constr) * num_planes + 2 * sizeof(u32))
+		+ 2 * sizeof(u32);
+
+	return size;
 }
 
-static void parse_codecs(struct venus_core *core, void *data)
+static int parse_codecs(struct venus_core *core, void *data)
 {
 	struct hfi_codec_supported *codecs = data;
 
@@ -200,21 +211,27 @@ static void parse_codecs(struct venus_core *core, void *data)
 		core->dec_codecs &= ~HFI_VIDEO_CODEC_SPARK;
 		core->enc_codecs &= ~HFI_VIDEO_CODEC_HEVC;
 	}
+
+	return sizeof(*codecs);
 }
 
-static void parse_max_sessions(struct venus_core *core, const void *data)
+static int parse_max_sessions(struct venus_core *core, const void *data)
 {
 	const struct hfi_max_sessions_supported *sessions = data;
 
 	core->max_sessions_supported = sessions->max_sessions;
+
+	return sizeof(*sessions);
 }
 
-static void parse_codecs_mask(u32 *codecs, u32 *domain, void *data)
+static int parse_codecs_mask(u32 *codecs, u32 *domain, void *data)
 {
 	struct hfi_codec_mask_supported *mask = data;
 
 	*codecs = mask->codecs;
 	*domain = mask->video_domains;
+
+	return sizeof(*mask);
 }
 
 static void parser_init(struct venus_inst *inst, u32 *codecs, u32 *domain)
@@ -283,8 +300,9 @@ static int hfi_platform_parser(struct venus_core *core, struct venus_inst *inst)
 u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 	       u32 size)
 {
-	unsigned int words_count = size >> 2;
-	u32 *word = buf, *data, codecs = 0, domain = 0;
+	u32 *words = buf, *payload, codecs = 0, domain = 0;
+	u32 *frame_size = buf + size;
+	u32 rem_bytes = size;
 	int ret;
 
 	ret = hfi_platform_parser(core, inst);
@@ -301,38 +319,66 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 		memset(core->caps, 0, sizeof(core->caps));
 	}
 
-	while (words_count) {
-		data = word + 1;
+	while (words < frame_size) {
+		payload = words + 1;
 
-		switch (*word) {
+		switch (*words) {
 		case HFI_PROPERTY_PARAM_CODEC_SUPPORTED:
-			parse_codecs(core, data);
+			if (rem_bytes <= sizeof(struct hfi_codec_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_codecs(core, payload);
+			if (ret < 0)
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
 			init_codecs(core);
 			break;
 		case HFI_PROPERTY_PARAM_MAX_SESSIONS_SUPPORTED:
-			parse_max_sessions(core, data);
+			if (rem_bytes <= sizeof(struct hfi_max_sessions_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_max_sessions(core, payload);
 			break;
 		case HFI_PROPERTY_PARAM_CODEC_MASK_SUPPORTED:
-			parse_codecs_mask(&codecs, &domain, data);
+			if (rem_bytes <= sizeof(struct hfi_codec_mask_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_codecs_mask(&codecs, &domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_UNCOMPRESSED_FORMAT_SUPPORTED:
-			parse_raw_formats(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_uncompressed_format_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_raw_formats(core, codecs, domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_CAPABILITY_SUPPORTED:
-			parse_caps(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_capabilities))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_caps(core, codecs, domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_PROFILE_LEVEL_SUPPORTED:
-			parse_profile_level(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_profile_level_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_profile_level(core, codecs, domain, payload);
 			break;
 		case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE_SUPPORTED:
-			parse_alloc_mode(core, codecs, domain, data);
+			if (rem_bytes <= sizeof(struct hfi_buffer_alloc_mode_supported))
+				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+			ret = parse_alloc_mode(core, codecs, domain, payload);
 			break;
 		default:
+			ret = sizeof(u32);
 			break;
 		}
 
-		word++;
-		words_count--;
+		if (ret < 0)
+			return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
+
+		words += ret / sizeof(u32);
+		rem_bytes -= ret;
 	}
 
 	if (!core->max_sessions_supported)


