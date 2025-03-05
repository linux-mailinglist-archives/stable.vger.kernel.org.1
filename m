Return-Path: <stable+bounces-120687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CD4A507DC
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E797A337D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A46A1C6FF9;
	Wed,  5 Mar 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EthSHLct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F2A14B075;
	Wed,  5 Mar 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197682; cv=none; b=laU6LA5ZB/N9Rg9NY2Ly+X0AXfPFKpNqI7c7sYkcnCp9pMWEV5yx4qPeVtRiNIhGODJi9EbnRA92RcHGEMt5R3XBGCpjXWgOB85M89yRkhQs263q47VygRhvRc7T1yGMngXfgfRIzdo6YVRRA2AMTZOkRyFeX6dLIJmeR1+MZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197682; c=relaxed/simple;
	bh=hu/lBWcLZzEuFFm1hTIrRnb8/xlWJAx8vhrSKkLyg7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OH5x4x/TDX16edKEyPjDLbmNiPuz0Ysj2yv7Bl8NiMosvPT4oRGpdPwbIdUMGD1OzjrnlPA3t7+AC7pVoWtzXMxrcXxIrSs91JmRNu1QzWpd4hr6xKZdU9BxOVDSB0I0nW+0+0REjkF1GAY0plSE99lHUV20iYapfIJt2yWFX9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EthSHLct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EE0C4CED1;
	Wed,  5 Mar 2025 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197681;
	bh=hu/lBWcLZzEuFFm1hTIrRnb8/xlWJAx8vhrSKkLyg7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EthSHLcthPkwFWdImTbUMLErOrmvJAof3WS3pmAVfQFOg6of6nNE5I8DA9ZGmfdOz
	 k58wFRJtoX64Q08y11T2yz2gsSMZZSA/1l2/pqAK4s/2yqCs14bANspY1LnryFqlrR
	 nRTYC9C+scm52CUpobbdHtB5OMetV4OM5RHno70M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Panchenko <dmitry@d-systems.ee>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 063/142] ALSA: usb-audio: Re-add sample rate quirk for Pioneer DJM-900NXS2
Date: Wed,  5 Mar 2025 18:48:02 +0100
Message-ID: <20250305174502.870864877@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Panchenko <dmitry@d-systems.ee>

commit 9af3b4f2d879da01192d6168e6c651e7fb5b652d upstream.

Re-add the sample-rate quirk for the Pioneer DJM-900NXS2. This
device does not work without setting sample-rate.

Signed-off-by: Dmitry Panchenko <dmitry@d-systems.ee>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250220161540.3624660-1-dmitry@d-systems.ee
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1775,6 +1775,7 @@ void snd_usb_set_format_quirk(struct snd
 	case USB_ID(0x534d, 0x2109): /* MacroSilicon MS2109 */
 		subs->stream_offset_adj = 2;
 		break;
+	case USB_ID(0x2b73, 0x000a): /* Pioneer DJM-900NXS2 */
 	case USB_ID(0x2b73, 0x0013): /* Pioneer DJM-450 */
 		pioneer_djm_set_format_quirk(subs, 0x0082);
 		break;



