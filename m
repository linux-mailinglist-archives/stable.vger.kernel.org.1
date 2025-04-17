Return-Path: <stable+bounces-133464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4738FA925CE
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7863A207D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8541125B663;
	Thu, 17 Apr 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LohNqXAk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D002571AC;
	Thu, 17 Apr 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913157; cv=none; b=X1pN3vZFxDdt20FOd5VzzXN49u5RJEV6ZjvCOBv97LrbxhWK7RHLQ9fYRLceDE8KiluCom40xfHqza3TsXPWOiYC/fmpIRT3Du5lN7nD69U4OUdu/7ZLK2dNeXBF5pyI6ytgVjGRpyatwChXVpoMlQEre3gVF4vNg4yfdzHFslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913157; c=relaxed/simple;
	bh=z8zam4u99w5AyE5FMA9JsQ38B/pjfWNXkAlsRjEntWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgFFY0sqSizsSXIR5GzBPK2w8OMhM9knHrkrJQDEq9qxGjnd7M2smmyZKj/o3GQN56Xt5c4hlHR9vVQVtnGqW9tykpqwAmxhY748g0KnRm3v2zIAqGziWkkZHlg03p52/V3D1wB/IelPdSstxZqOv2YZCNc1PTgqEKWXHm7tcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LohNqXAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64DCC4CEE4;
	Thu, 17 Apr 2025 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913157;
	bh=z8zam4u99w5AyE5FMA9JsQ38B/pjfWNXkAlsRjEntWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LohNqXAkKvkcmNWNYLkay4v0hhSKcaPTYyamyaB3jFz2iD+QmLiIO3+e6IA9GZj77
	 Gl9Pf/uYPByXjV9WLYhoZSyUN3PDFy/6Tcq8IDXyTfKVZBZLVTbVF/fpYXOZkKnksJ
	 pVNV3xqlJJfXLC+rfg2QXS/361vvsMgupeR1c9SM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.14 246/449] media: visl: Fix ERANGE error when setting enum controls
Date: Thu, 17 Apr 2025 19:48:54 +0200
Message-ID: <20250417175127.896580124@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dufresne <nicolas.dufresne@collabora.com>

commit d98e9213a768a3cc3a99f5e1abe09ad3baff2104 upstream.

The visl driver supports both frame and slice mode, with and without a
start-code. But, the range and default for these enum controls was not
set, which currently limits the decoder to enums with a value of 0. Fix
this by setting the decoder mode and start code controls for both the
H.264 and HEVC codecs.

Fixes: 0c078e310b6d ("media: visl: add virtual stateless decoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/test-drivers/visl/visl-core.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/media/test-drivers/visl/visl-core.c
+++ b/drivers/media/test-drivers/visl/visl-core.c
@@ -161,9 +161,15 @@ static const struct visl_ctrl_desc visl_
 	},
 	{
 		.cfg.id = V4L2_CID_STATELESS_H264_DECODE_MODE,
+		.cfg.min = V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
+		.cfg.max = V4L2_STATELESS_H264_DECODE_MODE_FRAME_BASED,
+		.cfg.def = V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
 	},
 	{
 		.cfg.id = V4L2_CID_STATELESS_H264_START_CODE,
+		.cfg.min = V4L2_STATELESS_H264_START_CODE_NONE,
+		.cfg.max = V4L2_STATELESS_H264_START_CODE_ANNEX_B,
+		.cfg.def = V4L2_STATELESS_H264_START_CODE_NONE,
 	},
 	{
 		.cfg.id = V4L2_CID_STATELESS_H264_SLICE_PARAMS,
@@ -198,9 +204,15 @@ static const struct visl_ctrl_desc visl_
 	},
 	{
 		.cfg.id = V4L2_CID_STATELESS_HEVC_DECODE_MODE,
+		.cfg.min = V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
+		.cfg.max = V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
+		.cfg.def = V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
 	},
 	{
 		.cfg.id = V4L2_CID_STATELESS_HEVC_START_CODE,
+		.cfg.min = V4L2_STATELESS_HEVC_START_CODE_NONE,
+		.cfg.max = V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
+		.cfg.def = V4L2_STATELESS_HEVC_START_CODE_NONE,
 	},
 	{
 		.cfg.id = V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS,



