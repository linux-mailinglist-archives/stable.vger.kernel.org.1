Return-Path: <stable+bounces-224823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Co/HRF+smkcNAAAu9opvQ
	(envelope-from <stable+bounces-224823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:49:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87B726F266
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9650312953E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A08C38AC8D;
	Thu, 12 Mar 2026 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzNG5t3f"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF9038AC75
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305282; cv=none; b=Lqv73uoUJbS9BwVoqPW9VYts9N9BHVdupop4wSR/6jxpN+aRpFsHuTPg7QoFEvApMaNasteOPrh2ny3z9H9tG1jGMNa/aO1FxYC0rbQo+ZE7sHHduh7/ySnPf9aVCzdaFpOQ1LaXiu9Zb+0Db0LFAv85KNt0Xwx+4PKQtM+nKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305282; c=relaxed/simple;
	bh=jshvpbbqyCJXJFnCiNXC8f1p7ofXuAPUjoLyT+Hay3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RosmgPxACfid2fiFb4N3Unry3EQQpVO4XCV8Vy8Rs4IcTDnE3n8sd+bgbm8txQDS81uw1OdAgy8pHjuqrKA4Z/JDc7CZ8UT+5NAMiyuFvRD1OYF6stHUW0+QWhqaHYqNRbPfCeT1+67TFuUKfFT94CGJxrQce/vDHDhvryzrRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzNG5t3f; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c73bc3dd25fso297246a12.1
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 01:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773305281; x=1773910081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L+iYefIZxKcaeucX4XcH147M85Qnaa9Ph+8tLAQwycQ=;
        b=XzNG5t3f34igxRlf/2lzTPx3qRXAuvGRjDTGnjzRUO/xZ41CV6cccJlB2csMSHF/tZ
         8+9qqkGzFoxeF+dnDpURB8Lu4uj8/hUpDZ11STBy4wSEvIuMMHvCODFdGfk6jTeKX751
         XOmOJeTbTP9UIiSRhTsaYvnJ9wyQoqHTA17LbOCMFTzW7CQrtZSNRwyq3Zjeua84YQAP
         jkLyb0qacYF83Jz1R4S4k0plxaNKDF6NNGwXDibqLB+7X1u6M3MXzciRaDzvGTQJaWHP
         nMB6xOa28TFZt/ki8J5EdhGA3Ttc55Aq4GsH5qi4M+R1XngMo5iVcoG4ud//Im9KWNC+
         jbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773305281; x=1773910081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+iYefIZxKcaeucX4XcH147M85Qnaa9Ph+8tLAQwycQ=;
        b=ZaOzDJBCv6cZyEEx2cMdN6WX4uuKYIuQTsYRcjzmOSnZBjf0OsN0myJNPoR4dZurZ2
         QPGAzCIkqGp3zaFbPIjqANVVISH3QKLxgLxPIUOY3ofMgNA39u/YiNS0d4pVKM7DKa0X
         GH3OCTcloy+UMlp5o84k61CvC1knpqImJs+VGgIvVzDY0mPF6SnuJEZ5GwO+5wTj2tVg
         Qml4lVU7v/M9u0Iywe3Yd8yS2wZTzPOgHIa0a4N2juTdKRlyEWMsCEtMVY055pU0f/EY
         2L/YYzfA1bjCcoU/14zLfrTIbfLNswA3CIPJsqvFARKpN5+N+p56kuVVC5BjUcZ8XFRa
         KC1A==
X-Forwarded-Encrypted: i=1; AJvYcCX2EJrlaX974Pey2tgj8mlIOdnABtdgc47YUxgi9vGrYmjfgt4h52/YV3nMF6/GVDUr+YDVLFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmKari/9xWPHVvVaIZcCKW4q1NuiG/U3K3QrxJQkEy3a5dVe5
	vANNzF3xYMCyDxneaqYt86zKn0DjbZpn9aCAB+iD/1cyvqTl4s0jYfVB
X-Gm-Gg: ATEYQzzjV1B8/s6SedHNgRqyPR2jJ3Wk76hVoOCTSRye0k8rX+OFdNJbV2Yg++MDiy1
	xt1w++7Atu55grFDHG7lOava4YeKbWZ0Rf4mWU4gh27qU5W4FjYowKGnRh0h4Jm39tadXC/xf7h
	tPFkvgF+nW0Y5xe0SJk/ozBScpvfsThEj/1pgETUtXIOBFEMEmMuN4+77NzBXVqZ/2XE1n5kyLJ
	V1cvxXscP+4DOrynHFs7zdR7DkiLUhXRiJkoCt7HiwerrqA+czlSZdGw3L524vmwYeulfmollhO
	5erz+E6bGCdw0iIfu7bNeQh+Z13EMwBPXSiKM2DCd6bsgmhXr5ZdpDmgKDXgIjKRNyKOUf9MttK
	VUO2Nm1KnXXTuu/YRUXlkz5M55Bv8hTBlG+yLLEf9ACr1G5oupKh2lUAjcE4DL4YaUyAaiBDZnr
	x8ciGWVkDQL/Yc4A==
X-Received: by 2002:a17:902:d506:b0:2ae:aa16:acfb with SMTP id d9443c01a7336-2aeae80cc3fmr54507325ad.22.1773305280599;
        Thu, 12 Mar 2026 01:48:00 -0700 (PDT)
Received: from lgs.. ([36.255.193.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae2228easm48508975ad.3.2026.03.12.01.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:48:00 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Kiseok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: sma1307: fix double free of devm_kzalloc() memory
Date: Thu, 12 Mar 2026 16:47:49 +0800
Message-ID: <20260312084749.365325-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224823-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[irondevice.com,gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D87B726F266
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A previous change added NULL checks and cleanup for allocation
failures in sma1307_setting_loaded().

However, the cleanup for mode_set entries is wrong. Those entries are
allocated with devm_kzalloc(), so they are device-managed resources and
must not be freed with kfree(). Manually freeing them in the error path
can lead to a double free when devres later releases the same memory.

Drop the manual kfree() loop and let devres handle the cleanup.

Fixes: 0ec6bd16705fe ("ASoC: sma1307: Add NULL check in sma1307_setting_loaded()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 sound/soc/codecs/sma1307.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index 4bb59e5c0891..3a01aca17e75 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -1759,8 +1759,6 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 				   sma1307->set.mode_size * 2 * sizeof(int),
 				   GFP_KERNEL);
 		if (!sma1307->set.mode_set[i]) {
-			for (int j = 0; j < i; j++)
-				kfree(sma1307->set.mode_set[j]);
 			sma1307->set.status = false;
 			return;
 		}
-- 
2.43.0


