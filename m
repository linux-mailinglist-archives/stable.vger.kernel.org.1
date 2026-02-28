Return-Path: <stable+bounces-220251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA3HDSkwo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4029F1C5899
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8229D30F0BA0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66942375AD5;
	Sat, 28 Feb 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLC3034G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE5375ACB;
	Sat, 28 Feb 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300155; cv=none; b=kCldUj23yX1l4jigLvh0fsaGAE8t1YR67c1F1d1hprl6p1J3h8kzlCjH8GJeLO7VUicZjVL49K6OI7LkZxnYYUdvUQUiXzbljPQKP8QlYxkoTBT11Vs7JSVk8LYApRoVgQcMCtAVv5g9WwmMXHpYMwswYRU22VxutIPoCB4Se5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300155; c=relaxed/simple;
	bh=pATswG/kTZy1LXGkjTLon4uSoyIvBh8iGU+Rtxrjz9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmEaSPhQxZmjd82D/jBitELs/DlZuGaJq25ciTmyI+/2ilzOOMlsouIMhkQ5pBo6j01Jyx524gv53HkpH9AYai6Jt5y0lg+VBRysGZBBoj47k5sPHigZW9/VQFSk7Nsyr+xqmsym4HilJFAafarzqhqSl5O66s1rOCr6a7bB3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLC3034G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549EBC19425;
	Sat, 28 Feb 2026 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300155;
	bh=pATswG/kTZy1LXGkjTLon4uSoyIvBh8iGU+Rtxrjz9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLC3034G1vHO2IK0FR4HTnU6V/oMsige2T7l62d5XK8K6FlLKakOXJkHw7ecxX0xM
	 WoEMptbHkvW3HWIGpT/Glqv7/Bh/ohuyMn+R1hG8G5xHqCQK0un8RgNrovGJSfVe9u
	 oJ+mPTrmEJLEjiP3qVJdvEbPSR1uDgWngVPSglRpM5ZP/ytJfGOzEXykn1TODLG1ai
	 vf6Hsvk12sRWiUhcmupybEXdVTonBLL7g6QGgt0JthIbSr0B+Te1aJxvrVKk1WTsi2
	 0kP34N2LgPB/yapR06UEd9szsO+DyfpOHndEScKfhYtShJwtHz8Rj7ndjGvI/OQlU+
	 rsno74Iz04fzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 173/844] ASoC: wm8962: Don't report a microphone if it's shorted to ground on plug
Date: Sat, 28 Feb 2026 12:21:26 -0500
Message-ID: <20260228173244.1509663-174-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220251-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,cirrus.com:email,puri.sm:email]
X-Rspamd-Queue-Id: 4029F1C5899
X-Rspamd-Action: no action

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

[ Upstream commit e590752119029d87ce46d725e11245a52d22e1fe ]

This usually means that a TRS plug with no microphone pin has been plugged
into a TRRS socket. Cases where a user is plugging in a microphone while
pressing a button will be handled via incoming interrupt after the user
releases the button, so the microphone will still be detected once it
becomes usable.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20260105-wm8962-l5-fixes-v1-3-f4f4eeacf089@puri.sm
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 1040740fc80f8..bff8644674163 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -67,6 +67,8 @@ struct wm8962_priv {
 	struct mutex dsp2_ena_lock;
 	u16 dsp2_ena;
 
+	int mic_status;
+
 	struct delayed_work mic_work;
 	struct snd_soc_jack *jack;
 
@@ -3081,8 +3083,16 @@ static void wm8962_mic_work(struct work_struct *work)
 	if (reg & WM8962_MICSHORT_STS) {
 		status |= SND_JACK_BTN_0;
 		irq_pol |= WM8962_MICSCD_IRQ_POL;
+
+		/* Don't report a microphone if it's shorted right after
+		 * plugging in, as this may be a TRS plug in a TRRS socket.
+		 */
+		if (!(wm8962->mic_status & WM8962_MICDET_STS))
+			status = 0;
 	}
 
+	wm8962->mic_status = status;
+
 	snd_soc_jack_report(wm8962->jack, status,
 			    SND_JACK_MICROPHONE | SND_JACK_BTN_0);
 
-- 
2.51.0


