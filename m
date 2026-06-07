Return-Path: <stable+bounces-261558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PkonDFdLJWpFGQIAu9opvQ
	(envelope-from <stable+bounces-261558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:43:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8664FF27
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:43:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=EucgurWe;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261558-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261558-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 505783004420
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D371E98EF;
	Sun,  7 Jun 2026 10:43:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419E32A3C9;
	Sun,  7 Jun 2026 10:43:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829010; cv=none; b=ISQhbri5PhJbTixzTngbyR+K+c96WX31srSwKLfCSaSNgGXXIgrYbICo9EAzKyn7LrdYOyOvIvBiw5lbZUwwXxBZVQlA9wq5JGI8dSaqxEswv2OC5gFN4MiXsenQswrQfA1CDVlVq1YqLr5+Dh2JW4gqvT9PrRnRm56bkoVeY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829010; c=relaxed/simple;
	bh=R9xaKPGI12V+uZCOa+tkHctLCJlznjdpEEUxoe46sU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcbsECTxqha8cRwawPehypmveAOlyII+QrQVr8+hmT+TQE2oGWzBgGCtCxUiEqQuu1Qa7JsmQtCeUkmvGjlafVhsaw2AQ9sUx3GqaB9+vIDvJfV+MSRSUb/+8MiYL2T2+Gqnfxp949kpkwgJgD/W7qSbPVEE3/mnU2AbEXr9c+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EucgurWe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A283F1F00893;
	Sun,  7 Jun 2026 10:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829008;
	bh=vqZY43GL5hMco3bYsEx5w6276g7v8n1nearov0jvvcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EucgurWeY9cEPswpw0Xg0raZXe09ILzUENS83oIbYH/zTwnrg3VOITHPo2X1tZkuL
	 li7tvwlyr3ZiCeLCeix2ssifUJkUKXDz3qtk7aGslEuLk4eckIjAYC/y4rp5nkthHi
	 mFLWW3cTk3JC+dN5hUa5v2C316pLu7S7DbTFmqiM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Heng <zhangheng@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 209/315] ALSA: hda/realtek: Fix speaker output on ASUS ROG Strix G615LP
Date: Sun,  7 Jun 2026 11:59:56 +0200
Message-ID: <20260607095735.234169046@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261558-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:zhangheng@kylinos.cn,m:tiwai@suse.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,suse.de:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BD8664FF27

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Heng <zhangheng@kylinos.cn>

commit 20587302f8d700f26ee2c8a60ffb0a69ae0edf16 upstream.

Add quirk for ALC294 codec on ASUS ROG Strix G615LP
(SSID 1043:1214) using ALC287_FIXUP_TXNW2781_I2C_ASUS to
fix speaker output.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221173
Cc: <stable@vger.kernel.org>
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
Link: https://patch.msgid.link/20260526013611.1954949-1-zhangheng@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/hda/codecs/realtek/alc269.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7053,6 +7053,7 @@ static const struct hda_quirk alc269_fix
 	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	HDA_CODEC_QUIRK(0x1043, 0x1204, "ASUS Strix G16 G615JMR", ALC287_FIXUP_TXNW2781_I2C_ASUS),
 	SND_PCI_QUIRK(0x1043, 0x1204, "ASUS Strix G615JHR_JMR_JPR", ALC287_FIXUP_TAS2781_I2C),
+	HDA_CODEC_QUIRK(0x1043, 0x1214, "ASUS ROG Strix G615LP", ALC287_FIXUP_TXNW2781_I2C_ASUS),
 	SND_PCI_QUIRK(0x1043, 0x1214, "ASUS Strix G615LH_LM_LP", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x125e, "ASUS Q524UQK", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1271, "ASUS X430UN", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),



