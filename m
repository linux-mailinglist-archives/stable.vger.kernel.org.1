Return-Path: <stable+bounces-254586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDJhM8P2FmrJzAcAu9opvQ
	(envelope-from <stable+bounces-254586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:50:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 338395E5588
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2424303DA9F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90854218A6;
	Wed, 27 May 2026 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIuJ110U"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31B4218AE
	for <stable@vger.kernel.org>; Wed, 27 May 2026 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889329; cv=none; b=ARg+ylAVbd4kPhiWTeojAbDlJTVeKteD7l8ddn4oqR03esT4C5+iBK9RK/9i24CNx412rONmAki8xmiCU9Nfa5R02a6g0iEoIVo+kjxBiEN2yCawW53WABwT/1Do2uHxiZ741LzcpjDnaH4IKv2Log3f9674MtP4wt/U3W4o3b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889329; c=relaxed/simple;
	bh=2Q7+zlygQDiWGfxx9oKNM/G5wMI/KwIzH9dxAE1Eg+8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nvjfToe2lKqFeMW5C8HyTAKxFSch/sC4PGhzwTXPRH1QqXdbOgnp4x0pC6D6GiLmpCT+E8BPtApi82T0dUETaGLenb7F19LHRoYrJONL+B0zxwHLSCZ4aoTowkbABTBD6esblRi4M4KkG8Wl0Ea2NGhq14VKqiQkrSh+9sF8cNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIuJ110U; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-133466cf955so31108944c88.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 06:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779889327; x=1780494127; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkzyEKL9NR5CB1YGybIU9XChAPif6lvYie49X9D74OY=;
        b=qIuJ110U0FgQ/UemqwDsvuky+Bi/ttQfZuEyvByVQrWHyOlay4P++QB/XDThNO0Ikf
         d02wGTRHx8qZO7zPB3oAGppp86ryOcJKVUbfCsZ9vfuxvTJnD4L4CZ2WVL1z7ElB+z0Z
         ZVspVNe5DdXTbOpXWtRrG29SpHB5pJ5j/ZBLSegfbv7MnzqViWjD90DCwnT1WXpOouV4
         Rj/5uG0xSy8kLbVgrEaPEa0TtBRAjbk9QK0bbxbwwI3Vt01MZjJEg9czvk5BVoHR7ITK
         jJGVCiDpRpO8fhjYasVAThrLzhX1j2np4sLODtWG3e+bixa5hlr9BJqA8E0+1w+F2E80
         /U0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779889327; x=1780494127;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkzyEKL9NR5CB1YGybIU9XChAPif6lvYie49X9D74OY=;
        b=EBZLMYAQL0WXJFS2vRULxlCzHJCeS2GZiH8sG3ruW5dZxyBvCv3biuZVFctu/apzMb
         xNWikgGVdCTC/5/FrIPeMvAb5DXxjyepT3y1zfBbCy2jAqrRszYol6AcSXUuaHXfVcfC
         yO8/LsEurqVHsi2r0XW285WkIjMR3VoZPp2maxsyTuqFfOySo7V8Djy0fDKtlL0rTNUK
         S/xMHK+kd3NLtmkADVt38AoQZQc6nEOVPhRBPzX4pBEH/5VSBdbvLojjSdfsIVLakolG
         qqYnuq+AtgqS4xWscqO5lfgLCGe5sABtmvh94uUxqyJPBCwn5whR2QDbvs9RSxjCV1e/
         OqIA==
X-Forwarded-Encrypted: i=1; AFNElJ/H6Rc4uGnVgTo3SNQIsxSV5cZ8AiIzuSbCj453vSeGkq8e8zhFT1BX+pTI0RTHzSVgGJqPzDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ndk9Ew5aUQw5oVbd9ek94E3jExtusfhdc/bG/CEMEvOx5PQK
	3vBDklqxbFGGV2PPJc0FcrRm3O2G2bWFRb/YtzihUJkAtGUPVM3kOGwS
X-Gm-Gg: Acq92OEj+2USaRQbyxKcVrPqoy4NYuLMVFkrOLKcv2S+JjsdCF5QYQo4PUapy+qRzil
	8jbINMI+fbjr6uDVX8yycSrM8MqjgKrZ7ygcdBT0TdUwQ678b2ZuuEwGM5FV4iqndH3Tm5wnGi3
	4FQ2WBhHGNNYq3vD50vKL6MdJkbuZZE08Vcmyo/FAxuNfMXV6Y76yw7AV52vafEUPRKr3HWIaj1
	9yUi3dZfnunG/5PgGt55fvuKq0ViAqtrMUfQZVHB9UuJ3MCy/27I9kpbZscQcxpBe9QzEiQ82Et
	ULKdiKp9Y9iUk+Hb6gmJAu0isktyMi5CG11HkE9w0JyM1awcj8lCUTVA+cF65gpYvrsJmTSHxfF
	m81fMg4HXR4BD6WVMLTgDBLIj/ljRVo82NHNVX2lAP2WvYiJEvxK3/fBbWAI8hurZDvjRLbhps/
	a7VR7bp/NKzygp09qdcUNxOiuou2XiBTSs1GPxo+WmlHeC2/KaC99fPPYRVtdPvwbxpEYEVWFzh
	7hm1NDcdRKS
X-Received: by 2002:a05:7300:1489:b0:2dd:6937:79d1 with SMTP id 5a478bee46e88-304490c3717mr11002170eec.15.1779889326738;
        Wed, 27 May 2026 06:42:06 -0700 (PDT)
Received: from [192.168.1.18] (177-4-162-74.user3p.v-tal.net.br. [177.4.162.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ccdaa124sm311702eec.11.2026.05.27.06.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:42:06 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Subject: [PATCH 0/2] ASoC: mediatek: mt8183: Fix probe resource cleanup
Date: Wed, 27 May 2026 10:41:47 -0300
Message-Id: <20260527-asoc-mt8183-probe-cleanup-v1-0-4f4f5593c8d1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBA0auUWTvQRKPBq0gX6XSiI5qETCtC6
 d2NunyL/1dQrsIK526Fyi9RyanB7DqgW0hXRpmawfb22DvrMGgmfM7e+D2WmkdGenBIS0GO0Xm
 y0+FkHLS+VI7y/r0vw9+6jHem+TuEbfsAiwD/V30AAAA=
X-Change-ID: 20260525-asoc-mt8183-probe-cleanup-eff58c2d4715
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Shunli Wang <shunli.wang@mediatek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 notify@kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=2Q7+zlygQDiWGfxx9oKNM/G5wMI/KwIzH9dxAE1Eg+8=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFliX1Zej3nUwndl6QHG3JC4CezSWbm7z/btUjCI//CyX
 HrFjumLO0pZGMS4GGTFFFlWJy2y3NP14Gp93AoPmDmsTCBDGLg4BWAi/7cyMqxtUwvPNtl567XI
 6ta1Anf9/LUY8tZdY1tqY/5/vYzfxxOMDL3B1oeixFaZbl5TmlPlpepdl3T8//N1M6P8cmQf/Hz
 CwQEA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254586-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,suse.com,perex.cz,collabora.com,chromium.org,mediatek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 338395E5588
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MT8183 AFE probe has two cleanup gaps that match issues
recently fixed in newer MediaTek AFE drivers.

First, reserved memory assigned with of_reserved_mem_device_init()
is never released on driver removal or later probe failures.

Second, the probe-time runtime PM resume used before reinitializing
the regmap cache is unchecked, and a regmap_reinit_cache() failure
skips the temporary PM put.

Fix both issues with a devm reserved-memory release action and
checked runtime PM resume handling.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
Cássio Gabriel (2):
      ASoC: mediatek: mt8183: Release reserved memory on cleanup
      ASoC: mediatek: mt8183: Check runtime resume during probe

 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)
---
base-commit: 8cd773d4f8235aaf0b04927b3c9d2d0326def09b
change-id: 20260525-asoc-mt8183-probe-cleanup-eff58c2d4715

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


