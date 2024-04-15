Return-Path: <stable+bounces-39815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35D08A54E0
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119981C2222F
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3762E81AB5;
	Mon, 15 Apr 2024 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b6H12YUU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E188174F;
	Mon, 15 Apr 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191897; cv=none; b=E8jGa0VhCcQevbwTlIBbG9fCqApSB6dSq/v3qVilT7gWedDGaC0ikQb5fp3H2fw839vV9C8PtTzu7YFHtmeBwkWLYGDMZ16OqcnUMor2elwby8g/mui9t2pVTCUXmqJWLpBmMdfKDcm5/GWfmlJkPPuKLcxwZFyEyc/L5kGZ4Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191897; c=relaxed/simple;
	bh=hbYQfDp9P6hJw3Sad6q0sXHSHKLin2fG52nZZC8XPSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKL3wqLqFCX6wWayD3kq9msh2GNqJAqqRvh23jzuEEd9UpblrhR4u//ehsYUAmPxIa4bsSredZrztYakNqXw07AlZnPuO3tNhRAGom1hydABFnAJdb+BR8VLEXvuONbwq4H4ZbcMbfwBzWp+Yqyayx+UjUhdFuKZMhNN2rTkqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b6H12YUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE6DC113CC;
	Mon, 15 Apr 2024 14:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191896;
	bh=hbYQfDp9P6hJw3Sad6q0sXHSHKLin2fG52nZZC8XPSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b6H12YUUbABDZaUmTRg+UB9WEWLBTaW052EZLw41mrsSn4nQFIo0bexnURR7JAiSM
	 d2mc3K3sZZmk2ZFNRdlsgiEG70pHSfxLhbHtj8EmbUazA9/XEnkd5u2M/6zLyfLneu
	 9XDq0NXNJ296iFwfaKj3Zgpzh4uE7cpWedF1gpms=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Agustin Gutierrez <agustin.gutierrez@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 121/122] drm/amd/display: Set VSC SDP Colorimetry same way for MST and SST
Date: Mon, 15 Apr 2024 16:21:26 +0200
Message-ID: <20240415141956.999203893@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
References: <20240415141953.365222063@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Wentland <harry.wentland@amd.com>

commit c3e2a5f2da904a18661335e8be2b961738574998 upstream.

The previous check for the is_vsc_sdp_colorimetry_supported flag
for MST sink signals did nothing. Simplify the code and use the
same check for MST and SST.

Cc: stable@vger.kernel.org
Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6129,15 +6129,9 @@ create_stream_for_sink(struct amdgpu_dm_
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
 		//
-		stream->use_vsc_sdp_for_colorimetry = false;
-		if (aconnector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-			stream->use_vsc_sdp_for_colorimetry =
-				aconnector->dc_sink->is_vsc_sdp_colorimetry_supported;
-		} else {
-			if (stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
-			    stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
-				stream->use_vsc_sdp_for_colorimetry = true;
-		}
+		stream->use_vsc_sdp_for_colorimetry = stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
+						      stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED;
+
 		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
 			tf = TRANSFER_FUNC_GAMMA_22;
 		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);



