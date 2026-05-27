Return-Path: <stable+bounces-254557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEKzITLbFmq2twcAu9opvQ
	(envelope-from <stable+bounces-254557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:53:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E24EF5E3AE4
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C43302C0FF
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4218400E1A;
	Wed, 27 May 2026 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="R2ahAyu3"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BBB3F9267;
	Wed, 27 May 2026 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882526; cv=none; b=tUNwRssTtsaID3/buxKNDmTjfEw6JszaK0cgWigmzj2Ec8I3NTzLkU7bldWjG8pS6LlME8xqJgaiIuibIqQpCFKY/V5Rs/XJSpbeN+yPJ/COKvBS1Y8X3SY5+KbANvXkt4HJy2AM2xZGOl3r89z+VmHtWyiN30X7e2WjQjHP+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882526; c=relaxed/simple;
	bh=wM57othNS2LiPV/R1fMu7JI5uN71OBy4CwG/YcRLDYE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rCJ+ftc3X5rj64wUz9C8aG4Qxwkpd92ltRtyU6aYyWZ4x7E28U5jISXBDWkAUZXf9NXN+0hyw81em1pxd0reun5xu3vaR4LMQqRKrfqTDZXTKPDI4No2bsU1Aw0WXn2qU6lUfqwg+YMfeocgLzRMfDth/+3SyvL6EP4ik4P/nbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=R2ahAyu3; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779882522;
	bh=cHj3Y1OCJCcMT6QNnbQHIICCMcMEtH4XIj8Y40fElK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R2ahAyu3SKfEJTPM3UKdpYzlYy3oaGlQkAkzEO1WYf/qIjLfuskB0/K7ilkm/UM3m
	 UT08glORVxXC1f6JRQREk56ZWr2Sc+e271ZTt7ruTPTNBPm9Uswqyrq1Id0hlT6C6G
	 NnNe2bBriaT5Vo6cV/GhKSnCDuvdAWMmNdborHPo=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id C15A3CA3; Wed, 27 May 2026 19:48:21 +0800
X-QQ-mid: xmsmtpt1779882519t5iyp8zdh
Message-ID: <tencent_EB19622E6FEDDE77ACC5873767A24BEE1D08@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNzn2xX+inAmW0uhdBafjF8PJdpJidsjpgb8rui3Clw/A+UlH5ohlb
	 wdbj0bOAuvLPpyu19ZANKJUwKKeYy/vopwfnGNfPat98uUY/ug2AemORx7zIdFNGbfhLbC2aAM+h
	 ZychNFSZPVwdU58bfqjwlZxgMH21/0DKkOB/obB/HVsYDt7KJ0iUGGgKWcJU+v9/GWm35UEooeYv
	 /n9j6yCXq0lSr5WpaKTaH38XuCa47kWP17Luh2bEzgnyAoPYKPqbgu9QpckMoBPsNIezQsh4m/Sa
	 tVHhrWhhcVOHPvFcZBjMYdbUGHjX3vpSWM1ox5y9pKZ5pSH60mxgA+erkWUhsgKqDz/4XndCn44+
	 WFTDCrL6n9C4wN8wVpoUKROZVGxJ3UVl3SrKJ/1R64wdFpT+qpLhtuqhlwUHi+769EioCFl4Nf4K
	 s/F8LZQP6SBdhbgcs3WIE+iDPyvM6l8XBY6xV2911OAFXtSmo7sGIHi+m6JksNXtV/yxJhi1bULW
	 aa41yMPTbPci/mVXO4jLzOr2+Etg6L5zvPOt/tr2X7iEcfhj6LAIrGDzg6C/IsVF2gIxFY3ckNNZ
	 T1u3G+TI3269PEbDRmkJTez4p0MaIWSCcZ+vGW9f0EQNYKS89FI02V+jSDE0dMfL8JHAJTWA610I
	 I5blEdCSQqThgvyX0gAoiysPiZ8ruV0cS6PGA5JPgApdrIng9VWroTbaCsKbM4ezhnGDuO//PGjP
	 gtT1HY3bjM+fkuOHaCi3B925Ij63eqJmAd1jrwZSMu7G2NTcWJR65Y1atiPjaE5oXKO9G5dnKeDI
	 D+Pe4xrhwsZqRkiD81iJRTv0VomX8GMAno52lIvr/vm3XDvkRm9A7d2fTmiwn/paAuKiMzeXQqou
	 099/RnU1XYLLJIKJjvudGqTo+jyIYYY0iZeAgMBbyS3GNeC+z9eoYQlOSqSYAeDv1Elc+qzpuZ/V
	 zKEsVYYqFltBsvo7P9XdArZochIv8A8hPRAetWhgSRXSQwRcMBwRY0y5UMNgbOQ8anuDNwqEgFRX
	 Te31XFw5JdhTYWz/NW3nQ6q2crea4Axd9Fye4a0qY7AP8vhTfkVUR24ou6ibEg5I/wQ/jt+c904X
	 iBtlSX7MzLZWy2Qxg=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Zhao Dongdong <winter91@foxmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/6] ALSA: gus: check snd_ctl_new1() return value
Date: Wed, 27 May 2026 19:48:15 +0800
X-OQ-MSGID: <20260527114819.498119-3-winter91@foxmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TAGGED_FROM(0.00)[bounces-254557-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E24EF5E3AE4
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


