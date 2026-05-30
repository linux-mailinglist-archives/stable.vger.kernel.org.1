Return-Path: <stable+bounces-258548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG0tEtsoG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:13:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C992611459
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 605A83004DAB
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251A231F98D;
	Sat, 30 May 2026 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xv+nO3bP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB2223DC6;
	Sat, 30 May 2026 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164718; cv=none; b=i5a8qxr3Q4UyKScQvNrbuXY7Enkp9ot9q1Ipbabp4M7XBDnSSUOszZcBONaRLYTKKtrj9pnCUqJW31DH/H/sMqwX8RDoBvlnua+zwOPnYdI+f0Ldi/MBoBDE8VUVTgKnJEDFlgwLmbnHqNIbpNBjQ6Qe1umwtwXI+6DnsT1FfXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164718; c=relaxed/simple;
	bh=YWsvsHEIvyiuz0lnKQPT5FRsAeTnXsiklWqubEci3m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCZz1v7FVVMy7cJAcUUkOieDQsAGlT97Rb3e6ZykyQGGYs+RIbbpVyws6WM/k+bU5fNtly1gne7P8AXJcySDZihG0fk8GvzlM0f0sqmCkXkcgJRJkMfs3/3JKyM5TESmjUQZdFiFGGEQfD3l2sZlUZxKheUCPxMXez2jgKf75uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xv+nO3bP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476831F00893;
	Sat, 30 May 2026 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164717;
	bh=CIHjfGrPv+dXb4GLCXRNmkpvQ8DtKP2FYxbB4QUaRQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xv+nO3bP4pLi0H+/NYRUNPvGsW/mNGrVfRYjVWvBz1nuXowOc0n3DMPodI/EvAPvf
	 Ew1YAUVws4bIYo3h6Kk98VI4FK9kqisyoHKKPaD00eIyHr8+r3/UWKSkOMf1RTKHaw
	 XJqfP/Rb0qj3Le9gW4brCQZFLvWAmINHtU2uIQIE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	wangdicheng <wangdicheng@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 638/776] ALSA: hda/conexant: Fix missing error check for jack detection
Date: Sat, 30 May 2026 18:05:52 +0200
Message-ID: <20260530160256.445370068@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258548-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,suse.de:email]
X-Rspamd-Queue-Id: 4C992611459
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: wangdicheng <wangdicheng@kylinos.cn>

[ Upstream commit b0e2333a231107adedd38c6fcfe1adc6162716fc ]

In cx_probe(), the return value of snd_hda_jack_detect_enable_callback()
is ignored. This function returns a pointer, and if it fails (e.g., due
to memory allocation failure), it returns an error pointer which must
be checked using IS_ERR().

If the registration fails, the driver continues to probe, but the jack
detection callback will not be registered. This can lead to a kernel
crash later when the driver attempts to handle jack events or accesses
the uninitialized structure.

Check the return value using IS_ERR() and propagate the error via
PTR_ERR() to the probe caller.

Fixes: 7aeb25908648 ("ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140")
Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
Link: https://patch.msgid.link/20260428080450.108801-1-wangdich9700@163.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_conexant.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 7aeaccc9189c8..82186c4364c9b 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1199,6 +1199,7 @@ static void add_cx5051_fake_mutes(struct hda_codec *codec)
 static int patch_conexant_auto(struct hda_codec *codec)
 {
 	struct conexant_spec *spec;
+	struct hda_jack_callback *callback;
 	int err;
 
 	codec_info(codec, "%s: BIOS auto-probing.\n", codec->core.chip_name);
@@ -1215,7 +1216,12 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	case 0x14f11f86:
 	case 0x14f11f87:
 		spec->is_cx11880_sn6140 = true;
-		snd_hda_jack_detect_enable_callback(codec, 0x19, cx_update_headset_mic_vref);
+		callback = snd_hda_jack_detect_enable_callback(codec, 0x19,
+				cx_update_headset_mic_vref);
+		if (IS_ERR(callback)) {
+			err = PTR_ERR(callback);
+			goto error;
+		}
 		break;
 	}
 
-- 
2.53.0




