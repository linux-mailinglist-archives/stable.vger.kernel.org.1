Return-Path: <stable+bounces-247198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGcOLm3GBWrDbAIAu9opvQ
	(envelope-from <stable+bounces-247198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:56:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D91542009
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB5823068EC1
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B513C4165;
	Thu, 14 May 2026 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwAvaq2s"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A43D8910
	for <stable@vger.kernel.org>; Thu, 14 May 2026 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763317; cv=none; b=uXqMqfXXaTMFIXg/vpjKfU8iCnnDK5i5Ed0Tf5mrSAP1wL+xTkiC7YB0hZD0X2FANRe4XT68t/4I8fUz9nN8BLIGz5r6PqoPEER5XGqhMST2/Nhv0nK5/MaC8uaj5JmKGoBH/ZTrSJ2K+BPf8YJU5Nk1Rh2wzPbPXncRWdCdvy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763317; c=relaxed/simple;
	bh=nn573OmNpZxrFI75wUW33iuDsPMZUxrP0CYhUYOBpec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ICD22KiC7yGog5rpkrQOciNR9psio+M9hIJpTGUqQbsXLu0bUgJoMqnBKhmxm1GIWDzlZDPR/6LTWSrK2H+0mo2Mf+Qjl/TUP7jRgfBf7lcCqRUNhq1kKav3H4RYM5ZDvhCD31o/VjUJxOaQHyEKexk1pxFRMEo/hCn0K5VhotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwAvaq2s; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so4200922a91.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778763314; x=1779368114; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1mOb+TPDTl0fQa5/hkU2v6gAp5LJjCUHg1aRjdDAAoU=;
        b=TwAvaq2sBAvakzFByMNpMcRApC9mP+ghb+jrveABegxcTQArplj4naEGaVlxF2Tcp7
         11O3SvC6q9nPIW1RaAe4uRF1rBtFc1Pv2L+KMBF+50pJH5IyR2Jp3+TEX4/YK5WL2FHS
         TlV/ip9Dmpw96XpGE4Q3mFLCh7rkshXldnQ7k+GCodA1bOWKekXeiU+XpBBHlQURuPOi
         XOOVS0PryBFUko13pQOcR1CP2wHaBekum4S8PoBgczStJigEHEhjY29zQPARwIbKgZhF
         XZeJ6sQ8Unmjj29QSvnSxSN/7naqmSbwYCO8TT1gZFiasN1teMzG14xT83v3JG18IMlQ
         zmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778763314; x=1779368114;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mOb+TPDTl0fQa5/hkU2v6gAp5LJjCUHg1aRjdDAAoU=;
        b=Z+brmDPf7UIuE+DIrF/4eQjz3RRsVxO8Q8ZdH7o59UHNi6Ijmhvy9z6rhRAHuPI7DM
         wJ3LJ/He1KlIkMcUIkmtXJjMlKPZk9XU85KXZbHdmn3xfnolv/nTwdPTuvgNf1YEUm9C
         L1OtM64GsCBd4l9gir19zo+072r7OKE6l9FLdIBNBmSpy2icdnE4EcMQIfn88WNLKwDq
         5kvzYl+rIBXXLVg2IHaWsTQzOEjOgMr79ScN2+bbucNkjszecFcHYVhyIkZZUPYhd8hs
         OSRdtWmOpzOreZQ29Jm9B7Oos+uWuNT+zBSHZLrC5p77ZJfsWzEFqSO7eFQPGkQa5/gx
         gifw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ct8fM6NOQLL94ZClErTl3F3rFMD8Zhy/QyXBEzu5quA9rOMM676VN8LIdX2Usxv1WA/lUX0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFmqyf7J7wa0rK9KdtLyPIH6rYHpLcgCkCaqEkQ3zTVgIIM6T4
	qYbJ1ujMSSym1R6JnhlJbBcgi2VmbWH7DXWEhdvd/LJNvs5WKHXnHMXM
X-Gm-Gg: Acq92OEy2uM1O12iVGD7urC829+Wj6311VBm/FD990T1dVMS+ZxLI6gCNGYSCHt1Y0w
	CX0DQksBq4YJsjtKcUBlHmR77sNkbAfyLpPS7DNkHt+nQv3najHFazs9JHlJEiMEcILfuGgIGjM
	bTIg2Zyf2teNMOotCVB6s6xYThjM0q+Xvecdj6uCI6psUjsD/tMDmKQo9yRTmgKUdPsB+78Rp88
	xRC+kQvuNLOx0LAOtp9hciiuHPRV0X7MIFybf78x6161OTAPtThqndIeQlV+5oGT0FMAWK/k0LC
	UNeM9Dp46cRG4ET66KyQZIDPiU8119jqOaB6mJqqBNIQBRVCFC3VI8o499JQAQHQC93biBVPTqv
	Nc7qD4jTL+aAbp8Uk5nLoiF+hBsRIvCVgn4D2MBf2t0ZnP7oJznp4CQrzblnWCVeKz8EFkuCobK
	yDToKOdsR/ggz9+I7nvJFG6DbzK3ZD1sDHWEg=
X-Received: by 2002:a17:90b:540b:b0:366:4a47:f267 with SMTP id 98e67ed59e1d1-368f3d25591mr8265697a91.16.1778763314268;
        Thu, 14 May 2026 05:55:14 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-368ede204a4sm6464784a91.4.2026.05.14.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:55:13 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 14 May 2026 20:54:59 +0800
Subject: [PATCH] nvme-apple: Reset q->sq_tail during queue init
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-nvme-apple-sq-reset-v1-1-8931e455281e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0MT3byy3FTdxIKCnFTd4kLdotTi1BJdU+NUI6NUC4tk8yQDJaDOgqL
 UtMwKsKnRsbW1ABy3rQtlAAAA
X-Change-ID: 20260514-nvme-apple-sq-reset-53e22e88c7b0
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=nn573OmNpZxrFI75wUW33iuDsPMZUxrP0CYhUYOBpec=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBqBcYnd58loG/sMZgnDZXeeue5linXTCbmSdFv7
 Usj8arhSQKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCagXGJwAKCRABygi3psUI
 JE8sEACSOkv0EB3TanSxWricudH11RnYjW39i89ufhg2B/KmfgK6LwCcWQlCS88vsW2iMGH7C76
 jViheEwfPWQoZqBtU3rTlXpOVbxckR2wovC71lItN8M3LCZ8pbWlh4W7MH4bzV7L7cSxBzBxGfK
 vNRFhGCI5hRheRFMOcTNQ7wVUqQXMYfEoss6qaxUZJcUwtq4lA6zsVGov9uGyMhxACrDZn/OtkG
 p3E+Ew1PYIikq40kUgX/2D6+wlmv32nho4ZX/SchpQJOpesTa5IY3mfW998qY6TuW6lDfSFPvXG
 AGPnBsEh6EChTa7vlkwjRhOegY0rKM0WcVy3RUYd8nGoeyrD61W5GAjSH/iuNG3PUWIPOoZCZwS
 bnjMn4Z0N3ivYg9Ce87FNy2Huiq+13T7geSfxZhbRktPjsvNtku3X9H5w+l6Lr487cG7m8hVDN7
 ISYLTNhdKCWWrT11/J212YFd+F2902x1QhhSbZoGa75UACZ3iYtD6IHMIR9chRj/FFcKKkKAVwb
 vZVb1urcw94MuuJlZGZy/RE7CMpADRgx2zQU69YRcp/zPOufafs2ffge4zm98IEwClXrVwP8a0S
 Hb89KP//znnoY53t0c6L6RTTxOUrE9uNRkSy4EeVYr113m7OV/tqdC8zMlY+LMOnqnPbB2WMOPB
 KD7ZiDqGTRNh0BQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-Rspamd-Queue-Id: 25D91542009
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-247198-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[towinchenmi@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Fixes controller reset on Apple A11 / T8015.

Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
Suggested-by: Yuriy Havrylyuk <yhavry@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/nvme/host/apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 423c9c628e7b..c692fc73babf 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1009,6 +1009,7 @@ static void apple_nvme_init_queue(struct apple_nvme_queue *q)
 	unsigned int depth = apple_nvme_queue_depth(q);
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
 
+	q->sq_tail = 0;
 	q->cq_head = 0;
 	q->cq_phase = 1;
 	if (anv->hw->has_lsq_nvmmu)

---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260514-nvme-apple-sq-reset-53e22e88c7b0

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


