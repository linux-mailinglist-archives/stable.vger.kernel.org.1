Return-Path: <stable+bounces-254558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M6OLlPbFmrVtwcAu9opvQ
	(envelope-from <stable+bounces-254558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:53:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C94B5E3B04
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1528F303FFF3
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D59401494;
	Wed, 27 May 2026 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="SnONaVxY"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A39D3FF889;
	Wed, 27 May 2026 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882530; cv=none; b=Zv1fPWtUIQ+5f6jig0zi+eg4JHmulGpuAoe6l3UVs/vatWHJdX+DBx3o4dNCgTMwfiFSm21SPtVCKMaym9o/Fu8GZzZvAJL11KTO9VMBWWTp5IkGQ0Ry+2LiTW1i6CEch8EHVQGD6z8kmOtYZlb6neb7u6ArhuqDVSP4AATlK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882530; c=relaxed/simple;
	bh=ntejZ8F2g+1h9d0gwDnkRm7MnzDDRK0VZ4p55Q40HXM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XxnjPBynq8kOsD7NFzqve6yTibDMc8C/LufC/3hJKBzzH3x+OpeHHTuSA1xBvQetw/8fBfBJ5MpdiEZJus6et0GBN77QNikLe6IGVxmPah3TUnS0+E4ibcKv1u9QpP5tuhLM+nQOm43a1kpwD0Jfsq/FD4DRiomro7T9kfW3mHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=SnONaVxY; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779882526;
	bh=o+fF+CauGdRVwmpcniZzu/zZ4kvK8ZGLidripJ2JjkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SnONaVxYaDby/nyMxCrvDzqht5/eFIXxuNy6OstWYzJEdL/znt1SZJc62NxVUnkq1
	 djUGmEc2hM2l6LN6+dt1I+rg+QJIuMmYnkZWvDz5L+/63PJPqTm1MPnh6qGqCj5Qm7
	 RPgBa3DDMOcvRuGzAAhGjpz5AyJUjPtlfW3w6GwQ=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id C15A3CA3; Wed, 27 May 2026 19:48:21 +0800
X-QQ-mid: xmsmtpt1779882523t6x0d9677
Message-ID: <tencent_71E1C5E737E2A270EE4719712E6CED657708@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GScwGGuFXysoHbWBwE5E7zDu5aB8oH5dRfR+zcxzijOrafkL8wY
	 KKsuBx+iciEMPY25nH2OBaShs4HxxqEcwAupm6d654Mcmr2bX999N+GpbpeaFPqrWRaW3lSx3vI+
	 vxmPyYvpiwGDh/ps8+EQG76UPwK/eR1Tnv8CGacmVltjcBQxbGe6Frx97/E2icbdGoZSAQyGX9U6
	 gL5uJsTT3nfV4F+XvK+kn4cERd8egKnWQlzxVCILUswrIiYg55zSlUWawy4YNL9pvXtbVy442oaN
	 XbGYj+Mgt5mNzqfaOu01TKLCo+MOIgMf779JiLTzk5I66nJvkABURV6pPrgszSqrk0Fbi8OYMISY
	 iLwYf1zEHn5iHSxQp7FGDb38OFmVomeAfK6S96mV6rI3aGgphfyx14b/SBzjZacQGhkSJE/UZDMq
	 6KjQE4Rh0dcacHzJ1nAM5+jiuKtvRySb3NfKLl2GQ12I4lfWzo9QBBH7f/cevWg0Q+vViSLPz8MJ
	 Ct1NTXFdm+bUwD/FaIOX5crtf/7EK3+pzIngLsvXJtiardGKE5Cq7ZlMCyLx1ZHxafUqh6sUcYau
	 /DncVdnz/q0NnaUroEKH4wgW8Pnff6AAz575eTjsDDipF43jmMjB3tAQgrU6DwOs11A75UxQrgeA
	 PuIwJahPJGVSAJMeRu6rE+oF6SsneEC3Sdt/fW/RQtLmQKlUX56cc+MXaiIlLk6BXYlV+Aw6bGth
	 xqgtT2J76QVLJcGAmO5hs3qybNsRgSrCHxEptqVS/OZIchOTAR5b/mIkx+sxvdCkZhBT2AQ3dxoT
	 KX1vXaXbmpijU9H/qNtnyPxkCsCn+TsVUWf1ddu4JYgqbX8HwECJQPJCcG43oGmOtPyGABGGQQBm
	 UYFga6nnARhZ3PQyX/relQVhp2mgQyBP/iJCIkrVnosxQCCLafKeIM4R2+xyr+5Con4yh3+udUIj
	 0IXvnq15AX33+7GpEkXDp0Bfj2SsceFCoaZ9DOzmWe3vyp8f9oQYjn40X6h7fvrhwdPkw6Wwidws
	 hWVdzvSbX8/OFgMThPED86vurUmPq6jzewEtpd/3VDo2u+s++Rr2xZax00pT7tZBKnlG06nMPlfc
	 zjjnK4
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Zhao Dongdong <winter91@foxmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/6] ALSA: ymfpci: check snd_ctl_new1() return value
Date: Wed, 27 May 2026 19:48:17 +0800
X-OQ-MSGID: <20260527114819.498119-5-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260527114819.498119-1-winter91@foxmail.com>
References: <20260527114819.498119-1-winter91@foxmail.com>
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
	TAGGED_FROM(0.00)[bounces-254558-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1C94B5E3B04
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


