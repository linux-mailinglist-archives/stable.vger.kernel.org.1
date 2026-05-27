Return-Path: <stable+bounces-254569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH8UERnfFmo9uQcAu9opvQ
	(envelope-from <stable+bounces-254569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:10:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA65E3DFA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75E253011787
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F193C6A41;
	Wed, 27 May 2026 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="lKNZf8y8"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C6346AF8;
	Wed, 27 May 2026 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883768; cv=none; b=FmGqcqZFjXVNcfWSjO1ZUPteMkg3sn/4OmAB2otbfIsxfemW/tDM/LXGfD7CJrHoXY1WgLshYFUVOcHe1I3NK6A7Wxg8ccFmeF7ewkLICchOFl1WRljuKlbVlbM5Rv/FAuciLKt3ArgjxMWif6tUA1LmM/eWNisEL+pC56roMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883768; c=relaxed/simple;
	bh=wM57othNS2LiPV/R1fMu7JI5uN71OBy4CwG/YcRLDYE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jbmRXpCfOnhiBr02mv9akCnMTyzj6jeOGRtJwA3EUh2lYuH41t82fOtpEoz2msHnCY0w1evQ0VgpnOt9jItebn0QUYnKAyuxjGqBt1R7bgjvef9DwWSW2V/9dW1KOaocbVLkl8Mog3wDvcDulI+J/G1ZZRNsqBo087LpUfIrc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=lKNZf8y8; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779883763;
	bh=cHj3Y1OCJCcMT6QNnbQHIICCMcMEtH4XIj8Y40fElK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lKNZf8y8iLIh6ty8HswIzDgg2o0nwIlC7VM6zdXtOz++BT03VCHKXdMAd1ZlvopJX
	 DZsJcIjGBJ1eGLfH7hP7ZhJWx4lbXo7pXj0+czoQg8s+u/7NTi1Ehb5x8gmjj8OFk/
	 LK8aRXniRVVAc2C74zv1VmKZaIWAGLO50MhHEkbg=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 2518B808; Wed, 27 May 2026 20:09:17 +0800
X-QQ-mid: xmsmtpt1779883761tb1cy62r9
Message-ID: <tencent_F644A3DCAD32945D62DB2FEEBE8A996F6809@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnL0S17szsTLDmVLa86WKQDGLNOFE1E5ZzPjtf0rkFqUypYrXzUWL
	 ZM9ElJgm8E/QjPw5VuvUWjznC+BRKfhDST/qpaXtZDKmm3bUZxDxHNsnuQ8oh+l9BQwtmKeESQoz
	 83KWFYPvd2Mrv0z7sZ+i+dwuQYf/T/vqCpkdbS1UN/1xwYfeNzh5u5amSfHfFvQEnioVrBHUyhf9
	 IWgCPaghQP1a3HZ+v0VK0upnT9kqAx4LYMufnHoZvGuh0NZYSOOKtnh9Jhs9+8mqea5mvJbmtGmn
	 31Igj+27TjpgXp+/CnfKy/xSmOibh0BFb1Pvj3uEbCui6wZhhpHr2FWNH0Fxb0qfbIVPV3dZb1Go
	 BXdnLsP6GJC4NdxlOo/sxFR1dQ2K1FHokQfQW3BFxicLTg+/cnijLcmFebuE+0l1a01cD4ei6g+h
	 fruZUBgWQL00cO2t3d2k25y+erJwXfSehRsznD4M7F6rXjNnCUn+yUFRXRXEEMwwDKSxqjQ9bh6J
	 ttCJw25aLXcRBQfNAZ9H3q2lwQYoukx2Dwcl9A8xScaSRbwzuZCspG8ShL8njtmn+OiEoilSgSv2
	 7MFiA8TsKvjhdkfaGF/F7/LcsTgIWuwRKF1ItcIwKJcAwuP2ZytN/mFJDABP+Lzimy7xGKxm7Mto
	 rBT4EBXcWlzSJobQVOeL7JuMZ4jPHh+C4w2Dup41xnzYTfblKFpMHtURu0ivciDy0p2vwRObhXpP
	 rotXA/zYmo5n1+zNlDNrhzCX/78pxmLBGUDkhqR5zSc1Kse6K37BxLDOHOAhyp2OPglJrMmoTCLU
	 sjWEWfj114CZxel7y5axoUIDNFpaYjR3pzIj3sixrKX8cmj94gTWMSX+DMZ/Nsnyaxfcx0el+rKa
	 R6KUDVHXHtVsDIjrAowh/0/0RNjnKT0hCO368QcUS+fgGua8VWN9HbHwO2U4PHzDOa0RPm2hKcaw
	 ggtf5Qd5TSC6cSXs3ZrHu3V4uTBUfz/UlB41ogvmKcbybqCZ08KHpNZBNBXer5bTy7V4PILdcxky
	 17WtOac7djGIXcE839ziM9t4vH42EDPkRm6AqhA8JvvvWmehN11DF70/Ql97avHja/2Y1xkiX4QL
	 HueLIjpt+jA2iFhaw=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Zhao Dongdong <winter91@foxmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/6] ALSA: gus: check snd_ctl_new1() return value
Date: Wed, 27 May 2026 20:09:10 +0800
X-OQ-MSGID: <20260527120914.515037-3-winter91@foxmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254569-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qq.com:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: F1AA65E3DFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

snd_ctl_new1() can return NULL when memory allocation fails.
snd_gf1_pcm_volume_control() does not check the return value before
dereferencing kctl->id.index, which can lead to a NULL pointer
dereference.

Add a NULL check after snd_ctl_new1() and return -ENOMEM if it fails.

Assisted-by: Opencode:DeepSeek-V4-Flash
Cc: stable@vger.kernel.org
Fixes: c5ae57b1bb99 ("ALSA: gus: Fix kctl->id initialization")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 sound/isa/gus/gus_pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index a0757e1ede46..08ccb4d80ade 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -851,6 +851,8 @@ int snd_gf1_pcm_new(struct snd_gus_card *gus, int pcm_dev, int control_index)
 		kctl = snd_ctl_new1(&snd_gf1_pcm_volume_control1, gus);
 	else
 		kctl = snd_ctl_new1(&snd_gf1_pcm_volume_control, gus);
+	if (!kctl)
+		return -ENOMEM;
 	kctl->id.index = control_index;
 	err = snd_ctl_add(card, kctl);
 	if (err < 0)
-- 
2.25.1


