Return-Path: <stable+bounces-219784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDvUOIEaoGmzfgQAu9opvQ
	(envelope-from <stable+bounces-219784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:03:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3921A3EA0
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECBED300889C
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EB23A0B2E;
	Thu, 26 Feb 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwsTHl8N"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E3A39E6D4
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099877; cv=none; b=OGNqqkxqihFTpOgf8CcTakts+c6Di+bsAat1Jj5qElhBGeB6neiH9phzLRVSQJL8X6g/mF3Uncgq6AHoRLBp0gPGDkTIWRqiwT3nzr41+qyobafbKUpAOqrD2m8qUzazpwwwRTOdKYgSd20DH/FokbbB+T1uI1LJS+f+3KqHYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099877; c=relaxed/simple;
	bh=KgxoeE94YfnQF4YHV1zLMb8C/XWeTglGt8+KlKtwE10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OFHt4C8UFHUSUaHkHuTGuuK+09uDYu+9UaVL4f9vB/IUjdS5A5F40K9OxC6JtPq+OsY/agF3rXFewBXiKEM+MQmoDyYGt40Zj1+y4DEIj8G5Ch/kXrp8jE8KT0O2tCEqPgyPfdg4ChPKIODpiz5xMlqgOSGh6M6xYRXSNJOHyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwsTHl8N; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806fd9033bso1383565e9.3
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 01:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772099875; x=1772704675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuicWvo8UINIZwVGDJGQjXx8SMx76VGu5TdPPW4dolQ=;
        b=KwsTHl8Np7OIrXAbgZ8KUGzSlDCkbOcrtti9bQu9MhMKHB3TGlcY4RdxYtKwu1IVI2
         OoDW2jeSlj3c79SgAfcSh0u/DvVMZyvkuUdk079Hja4Ny2oWLzEctCGsS9Sl4Z9ky4D/
         GQIid8kgzUz25MfPiG4Oj+kkDyCZGuNQLQXRJYTkV+V6j7hssh/d1F5PzpB0ZfvidjVt
         zxHfejtQRt9Yn+c3pV+uCz1clRyaaxv0C3g+8C3WMqG91lWyHC6CVnG83T/UEiiPYZbL
         ePyS5PWSVTRzuEGnZA0FIxBk9gHgCbwx5O5N7pUaQS9lHyNfR63Mj+2TCEXnwdEb/cpL
         6jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772099875; x=1772704675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuicWvo8UINIZwVGDJGQjXx8SMx76VGu5TdPPW4dolQ=;
        b=vkgFCR7fwyHqsmqBKTGUVMhu1Nt28atTkPVzULOwNmJ5+ax+TNBjX6jzMopS8PfJ8f
         zvQgtK58sNDGSMUplYO7NFKMMr1oq6QnKZxK2fZ9QY0Xp+kqu/vJKiaK63hg5FH710Pq
         nnKj2T1ylDxi6aGeL47q1HKdGRBD7p+eG8ghbwB9Mn+XdWQbmORnNO+AW9zLIUyhfBd5
         tW6bXEckieGNt7uhkO8HUsv1N0CDsijFDozSDjn9Gj9hMGucRNSAaeMjmJNmkkBBRkDu
         H6QXU2qS0JuSY84Pr6g3/7iOiTM5KLba18oS6kEb2LPGCKu/km6YdtK23j4ps9irKb/S
         JSsw==
X-Forwarded-Encrypted: i=1; AJvYcCUErM7EB9rMiu4pPy87mAPdhW1dQQehlAJO/V2nUPOSP9BD4rKxncXJxKo0OsFApaJ/gHx1P/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTicNjD/SwW+FFkD81TkgJ4J9qn1oPqALDrEaNgM5hEWddf2DQ
	2ji0fFQbkOh0sU25yh/vHRKkN0KYaLRJXUOcyUznAQr3xstaXcsJeHkh
X-Gm-Gg: ATEYQzwkTEMe+3C4pV54FdlSPygg7CGc91PXRAa2+GkhDi2J+86b1v4WWsQbLPXynzL
	aB25BCwCGTZUXWM4rVEfApqr0Z0UPwvq435XxbgzFs7J2pGKgRlkBLk7ClDiGCK9SMeFhjM2+Hf
	zWQn+nyVaII6ooFvE8rA1zCAeactsHrtVETad5ZavNJODD+agQukYDnNf36LdiUz0FoGqYKdKTJ
	15liPu9jr2ArHUb5ycQfWaCGuH0xv0/1GRFYZ8KlDpjpsyfLIheq6fGf21CEcaaIhTmiOb2WnY8
	Vy5rTK//aysJBPWbFhtIM7xOt/ka7kQLOlui7lXGvoOvUu9ML5SlWdj3eg456cPAd0fH6cn8TqZ
	OBd42hxbqtFKV1MxvSG/wk8xSmPmr99ktR2vTLvlMLaYefBFCsK+RNOGCkHo6FzOjXm4He0BOH4
	wz8wGXfVscvtBQXPNmD5n70quBYnnbHS60E28mypM=
X-Received: by 2002:a05:600c:1c24:b0:477:5ca6:4d51 with SMTP id 5b1f17b1804b1-483a95dc5bfmr209342875e9.3.1772099874447;
        Thu, 26 Feb 2026 01:57:54 -0800 (PST)
Received: from fedora ([2a04:cec0:1000:5e88:ea60:cef2:e186:48df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b84023sm34015355e9.12.2026.02.26.01.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:57:54 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Marek <jonathan@marek.ca>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/msm: Fix dma_free_attrs() buffer size
Date: Thu, 26 Feb 2026 10:57:11 +0100
Message-ID: <20260226095714.12126-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,oss.qualcomm.com,poorly.run,kernel.org,linux.dev,somainline.org,ffwll.ch,marek.ca,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219784-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D3921A3EA0
X-Rspamd-Action: no action

The gpummu->table buffer is alloc'd with size TABLE_SIZE + 32 in
a2xx_gpummu_new() but freed with size TABLE_SIZE in
a2xx_gpummu_destroy().

Change the free size to match the allocation.

Fixes: c2052a4e5c99 ("drm/msm: implement a2xx mmu")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - Fix subject prefix

 drivers/gpu/drm/msm/adreno/a2xx_gpummu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpummu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpummu.c
index 0407c9bc8c1b..4467b04527cd 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpummu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpummu.c
@@ -78,7 +78,7 @@ static void a2xx_gpummu_destroy(struct msm_mmu *mmu)
 {
 	struct a2xx_gpummu *gpummu = to_a2xx_gpummu(mmu);
 
-	dma_free_attrs(mmu->dev, TABLE_SIZE, gpummu->table, gpummu->pt_base,
+	dma_free_attrs(mmu->dev, TABLE_SIZE + 32, gpummu->table, gpummu->pt_base,
 		DMA_ATTR_FORCE_CONTIGUOUS);
 
 	kfree(gpummu);
-- 
2.52.0


