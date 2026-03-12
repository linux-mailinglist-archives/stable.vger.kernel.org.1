Return-Path: <stable+bounces-224943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG0mEbAes2l/SQAAu9opvQ
	(envelope-from <stable+bounces-224943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:14:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A101278A25
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0AFC3007E30
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AC6346FB3;
	Thu, 12 Mar 2026 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/BfSlT1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94F38C423;
	Thu, 12 Mar 2026 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346299; cv=none; b=aT+fPnKGl+uAlA345wpEDDtDUboyf40QkV/UtZY50DN0/EpHKLZF+3lIFynUkUmQZ6hBfBzaE25muF5tdarI7f6/WoWfeuA03Nsppf0GRqn8ZrrRG8oP7FZVhU+kfe4XTy6tHdaKwG/0g9KGDI+S0oQRLkZ3Aqjg6e4cvidL6i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346299; c=relaxed/simple;
	bh=p2YAkrPK2fPUUnoy25r6w1kTJ6rVdXYJZcxzONirGbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqnRaDIEqu4fUKDv3vbnbIKBqcqb9+SVku9aGRZEMjwfbfabTUBqUR9W39SLN5yNaZprcFgVsFWZXmp5pERacN+wZdoAJr/PhM16ax7tSIXuwm2l/tGipAIhLlXVPMkkkHWl+mNO2F1RnewlxQOnKY+05frge83Y6W+j9CYwdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/BfSlT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09502C4CEF7;
	Thu, 12 Mar 2026 20:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346299;
	bh=p2YAkrPK2fPUUnoy25r6w1kTJ6rVdXYJZcxzONirGbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/BfSlT1UJ8R1/Hhi+mVzuJXUAnlPbgSsEN+4W9lRXDF3M/gOmU4AcQLUi9QG5Qac
	 TK39QuV3x7EB2YqFj0bhcmwZuKShikcDmMAC9yzogS/t5VK9+zn3AgXA7ytWDHzxWO
	 6zUwj0pxsuSfeUopJ5qyHY+NVOc7o5amO67dwJtU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 010/265] ALSA: scarlett2: Fix DSP filter control array handling
Date: Thu, 12 Mar 2026 21:06:37 +0100
Message-ID: <20260312201018.528732750@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224943-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,b4.vu:email]
X-Rspamd-Queue-Id: 9A101278A25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geoffrey D. Bennett <g@b4.vu>

[ Upstream commit 1d241483368f2fd87fbaba64d6aec6bad3a1e12e ]

scarlett2_add_dsp_ctls() was incorrectly storing the precomp and PEQ
filter coefficient control pointers into the precomp_flt_switch_ctls
and peq_flt_switch_ctls arrays instead of the intended targets
precomp_flt_ctls and peq_flt_ctls. Pass NULL instead, as the filter
coefficient control pointers are not used, and remove the unused
precomp_flt_ctls and peq_flt_ctls arrays from struct scarlett2_data.

Additionally, scarlett2_update_filter_values() was reading
dsp_input_count * peq_flt_count values for
SCARLETT2_CONFIG_PEQ_FLT_SWITCH, but the peq_flt_switch array is
indexed only by dsp_input_count (one switch per DSP input, not per
filter). Fix the read count.

Fixes: b64678eb4e70 ("ALSA: scarlett2: Add DSP controls")
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://patch.msgid.link/86497b71db060677d97c38a6ce5f89bb3b25361b.1771581197.git.g@b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett2.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 8c7755fc1519f..1242840104173 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -1294,8 +1294,6 @@ struct scarlett2_data {
 	struct snd_kcontrol *mux_ctls[SCARLETT2_MUX_MAX];
 	struct snd_kcontrol *mix_ctls[SCARLETT2_MIX_MAX];
 	struct snd_kcontrol *compressor_ctls[SCARLETT2_COMPRESSOR_CTLS_MAX];
-	struct snd_kcontrol *precomp_flt_ctls[SCARLETT2_PRECOMP_FLT_CTLS_MAX];
-	struct snd_kcontrol *peq_flt_ctls[SCARLETT2_PEQ_FLT_CTLS_MAX];
 	struct snd_kcontrol *precomp_flt_switch_ctls[SCARLETT2_DSP_SWITCH_MAX];
 	struct snd_kcontrol *peq_flt_switch_ctls[SCARLETT2_DSP_SWITCH_MAX];
 	struct snd_kcontrol *direct_monitor_ctl;
@@ -3415,7 +3413,6 @@ static int scarlett2_update_autogain(struct usb_mixer_interface *mixer)
 			private->autogain_status[i] =
 				private->num_autogain_status_texts - 1;
 
-
 	for (i = 0; i < SCARLETT2_AG_TARGET_COUNT; i++)
 		if (scarlett2_has_config_item(private,
 					      scarlett2_ag_target_configs[i])) {
@@ -5595,8 +5592,7 @@ static int scarlett2_update_filter_values(struct usb_mixer_interface *mixer)
 
 	err = scarlett2_usb_get_config(
 		mixer, SCARLETT2_CONFIG_PEQ_FLT_SWITCH,
-		info->dsp_input_count * info->peq_flt_count,
-		private->peq_flt_switch);
+		info->dsp_input_count, private->peq_flt_switch);
 	if (err < 0)
 		return err;
 
@@ -6794,7 +6790,7 @@ static int scarlett2_add_dsp_ctls(struct usb_mixer_interface *mixer, int i)
 		err = scarlett2_add_new_ctl(
 			mixer, &scarlett2_precomp_flt_ctl,
 			i * info->precomp_flt_count + j,
-			1, s, &private->precomp_flt_switch_ctls[j]);
+			1, s, NULL);
 		if (err < 0)
 			return err;
 	}
@@ -6804,7 +6800,7 @@ static int scarlett2_add_dsp_ctls(struct usb_mixer_interface *mixer, int i)
 		err = scarlett2_add_new_ctl(
 			mixer, &scarlett2_peq_flt_ctl,
 			i * info->peq_flt_count + j,
-			1, s, &private->peq_flt_switch_ctls[j]);
+			1, s, NULL);
 		if (err < 0)
 			return err;
 	}
-- 
2.51.0




