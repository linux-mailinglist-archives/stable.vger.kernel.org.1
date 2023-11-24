Return-Path: <stable+bounces-2363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0687F83DB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA57E289175
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4E321AD;
	Fri, 24 Nov 2023 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p/ZTRJUE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7082E64F;
	Fri, 24 Nov 2023 19:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CF2C433C7;
	Fri, 24 Nov 2023 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853698;
	bh=lNQWSvBK3+GsjSjXxNeUB7I7tgKm2g+fj5rNBklVi7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/ZTRJUEqAPU0svbOM9vUkZ4MsMYq+ZP7369oC0vokMSeHgqQfL/iS8VOqcS7D+B9
	 y52fe8Dao3GiImBcoWFIOZlK2e1gM7QWezOGaqEgo3GjPd1MqVMrLerJMG7z7Pcnor
	 ub+ovlD7InPTbAmu0kJEKy7F4L16GaugO5e3XUK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 5.15 268/297] media: venus: hfi: add checks to handle capabilities from firmware
Date: Fri, 24 Nov 2023 17:55:10 +0000
Message-ID: <20231124172009.526964764@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vikash Garodia <quic_vgarodia@quicinc.com>

commit 8d0b89398b7ebc52103e055bf36b60b045f5258f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/venus/hfi_parser.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -89,6 +89,9 @@ static void fill_profile_level(struct hf
 {
 	const struct hfi_profile_level *pl = data;
 
+	if (cap->num_pl + num >= HFI_MAX_PROFILE_COUNT)
+		return;
+
 	memcpy(&cap->pl[cap->num_pl], pl, num * sizeof(*pl));
 	cap->num_pl += num;
 }
@@ -114,6 +117,9 @@ fill_caps(struct hfi_plat_caps *cap, con
 {
 	const struct hfi_capability *caps = data;
 
+	if (cap->num_caps + num >= MAX_CAP_ENTRIES)
+		return;
+
 	memcpy(&cap->caps[cap->num_caps], caps, num * sizeof(*caps));
 	cap->num_caps += num;
 }
@@ -140,6 +146,9 @@ static void fill_raw_fmts(struct hfi_pla
 {
 	const struct raw_formats *formats = fmts;
 
+	if (cap->num_fmts + num_fmts >= MAX_FMT_ENTRIES)
+		return;
+
 	memcpy(&cap->fmts[cap->num_fmts], formats, num_fmts * sizeof(*formats));
 	cap->num_fmts += num_fmts;
 }
@@ -162,6 +171,9 @@ parse_raw_formats(struct venus_core *cor
 		rawfmts[i].buftype = fmt->buffer_type;
 		i++;
 
+		if (i >= MAX_FMT_ENTRIES)
+			return;
+
 		if (pinfo->num_planes > MAX_PLANES)
 			break;
 



