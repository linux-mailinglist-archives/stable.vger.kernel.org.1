Return-Path: <stable+bounces-251518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ATBOUEbDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:36:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D32599D38
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 271B433E9228
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939E12DC76C;
	Wed, 20 May 2026 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S125akIy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDC331220;
	Wed, 20 May 2026 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298190; cv=none; b=iY/SqrLcXfZutyEAPPShJeNqql2PmKZ6xgJAlEiDabYSIRGL+piBN/qfQew0r4wk5lce6u77sHRz5W8xhIoakbYggPRsQqBkr6ky+ZiFUvDKjPdjbhM7frluukYFtmAmzU0H2LTd8DpkcmU219JylRELBHuhpR59r3i7WQLODPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298190; c=relaxed/simple;
	bh=U7GhfzBoy4iJeafwoCpYNMet7JYFlaUunob7qtHDqxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sE27a4brkHv3/Fwr5a1M3IhzQS6sJgayuOwVdUCqER6F4hj/I5GHJltlLzz+EyJV5t4EaAs15cEeg6sdbpD6Eoe1BxqQVGBoXfp7nbNZHAUJKQ4Cp1NIS7i/hJy4umjigrFUki5kjdLjoGEnk6TP71bipRsJgr+P/pxvetvglDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S125akIy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0CD1F000E9;
	Wed, 20 May 2026 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298189;
	bh=A3lDS8ymGEkvWAE/2pyhfzDf02YlJ0GLkdFrAFBZ7Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S125akIyTQKaV4HZGgl0vdaIfLlVRA4gJ5u0hpvGiFKWFIykiEYtKwXa9yMU2eH92
	 7/9cBsDO5+AsE/S3o5s790hLEMF7hTHCWKDrwXuKxpHjpk3bZt38Y+0cZaeBUgAEHn
	 yKnPbveRk6CzljJKmw4Wg33yxSpW61CC9ffpYpm0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	songxiebing <songxiebing@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 317/957] ALSA: usb-audio: qcom: Fix incorrect type in enable_audio_stream
Date: Wed, 20 May 2026 18:13:20 +0200
Message-ID: <20260520162141.407427163@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251518-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,kylinos.cn:email]
X-Rspamd-Queue-Id: 38D32599D38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: songxiebing <songxiebing@kylinos.cn>

[ Upstream commit 292286b2d229fb732421429b027d38ac3f969383 ]

Fix sparse warning:
sound/usb/qcom/qc_audio_offload.c:943:27: sparse: incorrect type in argument 2
expected unsigned int val but got snd_pcm_format_t.

Explicitly cast pcm_format to unsigned int for snd_mask_leave().

Fixes: 326bbc348298 ("ALSA: usb-audio: qcom: Introduce QC USB SND offloading support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604062109.Oxi8JjWW-lkp@intel.com/
Signed-off-by: songxiebing <songxiebing@kylinos.cn>
Link: https://patch.msgid.link/20260408083311.774173-1-songxiebing@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/qcom/qc_audio_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 542eae3a57d9d..fc25e709ed4b2 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -948,7 +948,7 @@ static int enable_audio_stream(struct snd_usb_substream *subs,
 	_snd_pcm_hw_params_any(&params);
 
 	m = hw_param_mask(&params, SNDRV_PCM_HW_PARAM_FORMAT);
-	snd_mask_leave(m, pcm_format);
+	snd_mask_leave(m, (__force unsigned int)pcm_format);
 
 	i = hw_param_interval(&params, SNDRV_PCM_HW_PARAM_CHANNELS);
 	snd_interval_setinteger(i);
-- 
2.53.0




