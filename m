Return-Path: <stable+bounces-182585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24B0BADB0A
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA211C41B7
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401D2FFDE6;
	Tue, 30 Sep 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mPTrHEMa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6727B328;
	Tue, 30 Sep 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245423; cv=none; b=kYMKizdOL5ZeG137o805ZNU2l8dqPK0GRLKxzFh5xBlyYXq+rKlg8IhGHRjaTZ2Iurwe3GKrPj785/P84mCrNI0kfkhDYv2Md25iVahMoFcSGt17pquMsl3V0myXeXJh1c0eEJJtg8i0LRbbxq81bymMbWjQPFk+hmyPNNSHRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245423; c=relaxed/simple;
	bh=vVKn9H3vUKqv5xIm3kHt7INwuucmrun3+fyqYgYC0LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uzt+f/+JMYwpL0BWW0mCxPXBpNO/LWhJEPv1btaP1p1uYWwqdytAFTjg109oEVRjiZMOxDjjY4IZPFNcLX1UQhya2AKFf7wkfP7B2PKSDgHqx5xp8qZC6aeAFj8vC5rJH1YNFK4lN1F1jN2P6z8MSm3/onqOBEF4MZ86HPgllxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mPTrHEMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A62C4CEF0;
	Tue, 30 Sep 2025 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245422;
	bh=vVKn9H3vUKqv5xIm3kHt7INwuucmrun3+fyqYgYC0LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPTrHEMa4VR47eR1fosRXl3trSWcwzTUlOa2AxAX3twP4O1coqSvtuQL8mMkgR0Fp
	 T16rAq9ccxYFD1F5D1FoxYqchtq/hvmM3uF4RmWdi77JlsB3SjSt//7EALwsmEJjAj
	 CRoIJ3aB/5O2keTdoFMq7AukR5uy7AkEWCmitF2E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"noble.yang" <noble.yang@comtrue-inc.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 14/73] ALSA: usb-audio: Add DSD support for Comtrue USB Audio device
Date: Tue, 30 Sep 2025 16:47:18 +0200
Message-ID: <20250930143821.151703090@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
References: <20250930143820.537407601@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: noble.yang <noble.yang@comtrue-inc.com>

[ Upstream commit e9df1755485dd90a89656e8a21ec4d71c909fa30 ]

The vendor Comtrue Inc. (0x2fc6) produces USB audio chipsets like
the CT7601 which are capable of Native DSD playback.

This patch adds QUIRK_FLAG_DSD_RAW for Comtrue (VID 0x2fc6), which enables
native DSD playback (DSD_U32_LE) on their USB Audio device. This has been
verified under Ubuntu 25.04 with JRiver.

Signed-off-by: noble.yang <noble.yang@comtrue-inc.com>
Link: https://patch.msgid.link/20250731110614.4070-1-noble228@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ac43bdf6e9ca6..d4f4466b028c8 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2303,6 +2303,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2d87, /* Cayin device */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2fc6, /* Comture-inc devices */
+		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3336, /* HEM devices */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3353, /* Khadas devices */
-- 
2.51.0




