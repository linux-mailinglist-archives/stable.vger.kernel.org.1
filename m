Return-Path: <stable+bounces-254571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIvuJLXgFmo9uQcAu9opvQ
	(envelope-from <stable+bounces-254571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:16:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E485E401A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA20B306C854
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2573D1A98;
	Wed, 27 May 2026 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="y2p1h7Hy"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5A3D0C18;
	Wed, 27 May 2026 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883776; cv=none; b=mKmXKpDxuXRCRz1DH0UsP1zPs7a1pYTL9pyG3JpDHc6Q00cO2LLps4cUWNOPOD8KwZu+pBWYRjknJSFutcNmDuLbuL8OiPhlFGZNSWKbOd1nfntqIe/YDAY+pk9VlqmJZ9bWfF/CkAlNS8OcThvaeejh5MBHB8wnXyzRvfdrdak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883776; c=relaxed/simple;
	bh=ntejZ8F2g+1h9d0gwDnkRm7MnzDDRK0VZ4p55Q40HXM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=e75hqLJrvest97uBfvNpTN+jwBHLoF+7UYVPr6qWqFfGdBcy4VrWgVp7nEWRE+PNCgNee8Ohn+6MjWKqyX0YVLdJevQwW3zzixvrJGGVF9hNLlRS9wheFgyLDyBeWOsU744O69jGyHNExmll0nsNbjhUBFberDF0Cc8m3Rc54cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=y2p1h7Hy; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779883766;
	bh=o+fF+CauGdRVwmpcniZzu/zZ4kvK8ZGLidripJ2JjkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=y2p1h7HypxCI7OvHhVlVC9xstP+AhjSknEqGkiTjO8faFM4A93yt79wkHxT3pi1dU
	 2ZuMYGt5WKVBgYM4GgO3wo5izIi6shaw6RJi+htP84I/H3QiDtIMtS5O5oZOuJ4JJ7
	 tGfBJeQCOCh7ksS49PaI34GpAwzuUeYHZQQHzXlk=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 2518B808; Wed, 27 May 2026 20:09:17 +0800
X-QQ-mid: xmsmtpt1779883764t2xh59dkg
Message-ID: <tencent_4745C5DC2333325C0EDAB1EFC88A136E6809@qq.com>
X-QQ-XMAILINFO: OT0WjiHamhvjIWyBzf5ztUj8jEL220jTPLNzjz8RE0Loh1GC34xMECigpjORAn
	 +rFnKXs9OKv/vHN6IKBvXu5eEfwGK8ksVc3b6ZCtW7rFpXprhPoYjoXwX4B5FVTHMSAPOWMhUMwH
	 lnWDpnXkMZnmmXeD2P7KTwKc2rnzfh41lq3s0SJq+DDTfXpVoDl1wONgL/R4NKwbB8wkxAcZfBG8
	 6t3tJ71Z7ZKsnT4H+2L9VM43oFJzlXVr/4DtEs9FISWfxAw4CnT9UoidaMbv5SBYxDdiQC6VKbho
	 qpLqnADVVPZ5chSvxXtvlQXXBN0YJa8cN8jOR4qwXvb1B7AOVYWRhmjIo0Kubu/sX5/U+G1sJ8Hc
	 I7+fZwN7ip9renk4n95YSwvXxUILL71p3cRcGP00ylevGN9Mm2W6xB8GgCPWo5ZeixxxKyN39HWo
	 c4lgKabp/1LyHAyQpctXJ11egKE/LaLiSXJjPfCUwLkxweJ59fORsLoIU5H2sDtkW/fTQG/NYPCg
	 91OLNkunSqoz45POP2SqVNwDbbh41uGq9wSMhCkYJQR9yr0tefSB4CklUvQci9u4OJt5Z/Z/khCx
	 z/FBzVh0ishQXd1nmlprI8ozYBaovYNUIedSlq4vbeEFcpGd/dV6mK28c+xlaEe0y3iHntjtb9wI
	 1/vocueAYof7cPkr3Gk5NgjSL9EaDkasdkyC8coEeIK/IqSRBLSj1TL0JYHN+JALqNuXBCAZ3H6O
	 zmhe2R9i7ZisVbAKrbbvs9ze5e8jVjgZbP0tGxHAz4haWrNO29z3aQLFEyHUDaS5/Q4Xy3eyY8wQ
	 0o55d+Tl/2nVjNEYnAIzcaD6w4s+ORRNW15GeP2KG/x6X8gLAGPQ93PehYYVgvYJQMeHpJfOwEMQ
	 xtOc8zTAgJqTOiMnoWy4lRmf7iwAjmhqfD3fjVosqMdxjSH4G4DN9e4AyzmDaD+at6cEef24X5LT
	 8D2pt9/OE58JlSAQW6Pr2z34980g1ftyc4Qe6R0tMx94m52ge65SvQyY73me29Q0SFQlaA5FAAuY
	 9vgufVuRvQnVFGJh2arJ0PNq+ILqBNqRdOxqJJdd/ncblQ/7IXXJQKgZ4mRp28/niTjCN4+oGMYQ
	 nJjK33SUXhafCX2y7g+HylxhP0pw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Zhao Dongdong <winter91@foxmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/6] ALSA: ymfpci: check snd_ctl_new1() return value
Date: Wed, 27 May 2026 20:09:12 +0800
X-OQ-MSGID: <20260527120914.515037-5-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260527120914.515037-1-winter91@foxmail.com>
References: <20260527120914.515037-1-winter91@foxmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TAGGED_FROM(0.00)[bounces-254571-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 13E485E401A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

snd_ctl_new1() can return NULL when memory allocation fails.
snd_ymfpci_create_spdif_controls() does not check the return value
before dereferencing kctl->id.device, which can lead to a NULL pointer
dereference.

Add NULL checks after snd_ctl_new1() calls and return -ENOMEM if any
fails.

Assisted-by: Opencode:DeepSeek-V4-Flash
Cc: stable@vger.kernel.org
Fixes: c9b83ae4a160 ("ALSA: ymfpci: Fix kctl->id initialization")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 sound/pci/ymfpci/ymfpci_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index b9a09568afc9..2ccb976e68e0 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -1781,16 +1781,22 @@ int snd_ymfpci_mixer(struct snd_ymfpci *chip, int rear_switch)
 	if (snd_BUG_ON(!chip->pcm_spdif))
 		return -ENXIO;
 	kctl = snd_ctl_new1(&snd_ymfpci_spdif_default, chip);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = chip->pcm_spdif->device;
 	err = snd_ctl_add(chip->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ymfpci_spdif_mask, chip);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = chip->pcm_spdif->device;
 	err = snd_ctl_add(chip->card, kctl);
 	if (err < 0)
 		return err;
 	kctl = snd_ctl_new1(&snd_ymfpci_spdif_stream, chip);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.device = chip->pcm_spdif->device;
 	err = snd_ctl_add(chip->card, kctl);
 	if (err < 0)
-- 
2.25.1


