Return-Path: <stable+bounces-20413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 594898590CD
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 17:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6CDB217A3
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92D77CF0F;
	Sat, 17 Feb 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjuPYK4N"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA41D53D
	for <stable@vger.kernel.org>; Sat, 17 Feb 2024 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708186323; cv=none; b=VSR8G1MIpiufpiSuoNdmGvyJqwQiBM6j5rw3xl9I/fcJ5TjMX7FXAGcpFDPAnvFTP+6J5vCHxD0ZI2V1mrgvWORCNj3osL0pC/eQY0yR0FHwAfcc0itGPzz+ZDrwjEpXu2X1ylI/zFuKoRHsf/hHwQtqjUaIuD1T97YipKv2M+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708186323; c=relaxed/simple;
	bh=//jFhN04ukC3yxDguQ0jtOTAFVU7sIQOFFBcX8meml8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L36y9iTrs5J5Tb97KDdDdZPw+lm1u8mpbSPmRj4tjwejPujilWeOGvHhWd98sUZAiLFCYv6QvTBK9kfGOGIa0ZO1+Gf2ay/vCscQ3tfxNBot312TEye4I/Pr22Armrc0VWxCzFSMieOvJ18xt5Z7S1szlFZKPxxcwmQgGvH/z6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjuPYK4N; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-412565214c3so4250935e9.2
        for <stable@vger.kernel.org>; Sat, 17 Feb 2024 08:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708186320; x=1708791120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m9SfzbO/v5DyT0VgbSMJGtK+U1Om1O/FapLX4UOxOfQ=;
        b=VjuPYK4NPHrp3Qlt2Os1W8QUIyVk213TTcBPxnSMxJYH06gbjOQEM9UGykFwtLl35C
         WMOmJhPJoKFImBSU6i1zejBTvsJ66WCEesSykOephreGIQC+f+HsZng0bk8jTCUndnYc
         NbWaGBrANnkYHB2uXeCueMsi2RcSSIKb9N7lyt+LdfG5U+vEfsXbrw2RRz7AhxxXe2I/
         44DIXrkUCbeCEoB3C7unETClQe68wjAcy96NmtPD9oCU+b02MJpe9gMNvaxdH1pKC1lg
         mZKKE5V5mgvJi5eKTbujM3ASGVJQ1KhO2//ZlfKmeyv4F5sYzT4oZqyGTSPrgtLwFQhj
         PIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708186320; x=1708791120;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9SfzbO/v5DyT0VgbSMJGtK+U1Om1O/FapLX4UOxOfQ=;
        b=dSdMyuqQkS9GByH/M8V7VYMv9WSV66VOdYjE/urHjv8y//PiADZQW2a4n1FhMTtNDG
         bly2HadTHrYbviAVi5ihrj5bHcpPV+bVSgpo0G2m+5SwFCi/MuONyjP8UCWSmxOyHPOc
         rdz/ZiYuPCL5qA5FuS9dhM+inxPfePVFkn3wp49eTzG2guCf0fyZQu6pPYKWqFasJEck
         3UsnwkafoLszFaBmXj2zKgRF+vB1k03aOwGybEsUdb6UPYWzq7+7A3nuQiIMUJUQVJ2Z
         IP/4CovbtgQ0MI5aIkFVR45eqZraprJJZtNdkGBzvwq7DVgZt0ANSAUoephPn1gSRAZT
         ooIw==
X-Forwarded-Encrypted: i=1; AJvYcCWL08ERur1vYSFymzuF2lZq7HJ2y8jT7nqUkUZiT3cvPnQGqTe6b+LqPQkl9nqQbIv6c0DK1/C7p44PKnQNEuE8cjqdMbLv
X-Gm-Message-State: AOJu0YzUCPvDFBTfIfnjSRKYmhbZ26u+GQWCL6hFhX+TjGnFugocexaW
	EbWvkafzpsHvkyRHpFmmNB6uwojhWba2xvoDSzmdIYBofU9qStQ2tyxxAuY8UcpfW15nIw==
X-Google-Smtp-Source: AGHT+IFBZP4DFj4vhDAa5KnQ7hVvpxKuARnSVEvPzJ5VgTcwET5qZqOeDA9iFX8ynxPNMKGaM2boiPtd
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1e11:b0:412:3319:a4ba with SMTP id
 ay17-20020a05600c1e1100b004123319a4bamr126112wmb.2.1708186320095; Sat, 17 Feb
 2024 08:12:00 -0800 (PST)
Date: Sat, 17 Feb 2024 17:11:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; i=ardb@kernel.org;
 h=from:subject; bh=kQSpunytiSvEJTokt5LUuc9TDyle0d+ltgcJbDqHVkA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXCrROa63WNLRvSN798WD/9yfqPEdIb844vya81u/Zz5
 umdU8VWdpSyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJvCxjZPjGuJQ5/VlMqe5e
 rryWtLmMUxm/Z64z/X7gkYvWku4q3XaG/8FX49mWtq4Q/bZU9sS5vMBpXh/W/BZ12XaOiz3cqv+ bDQcA
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240217161151.3987164-2-ardb+git@google.com>
Subject: [PATCH] crypto: arm64/neonbs - fix out-of-bounds access on short input
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org, 
	syzbot+f1ceaa1a09ab891e1934@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The bit-sliced implementation of AES-CTR operates on blocks of 128
bytes, and will fall back to the plain NEON version for tail blocks or
inputs that are shorter than 128 bytes to begin with.

It will call straight into the plain NEON asm helper, which performs all
memory accesses in granules of 16 bytes (the size of a NEON register).
For this reason, the associated plain NEON glue code will copy inputs
shorter than 16 bytes into a temporary buffer, given that this is a rare
occurrence and it is not worth the effort to work around this in the asm
code.

The fallback from the bit-sliced NEON version fails to take this into
account, potentially resulting in out-of-bounds accesses. So clone the
same workaround, and use a temp buffer for short in/outputs.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+f1ceaa1a09ab891e1934@syzkaller.appspotmail.com
Tested-by: syzbot+f1ceaa1a09ab891e1934@syzkaller.appspotmail.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/aes-neonbs-glue.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/crypto/aes-neonbs-glue.c b/arch/arm64/crypto/aes-neonbs-glue.c
index bac4cabef607..849dc41320db 100644
--- a/arch/arm64/crypto/aes-neonbs-glue.c
+++ b/arch/arm64/crypto/aes-neonbs-glue.c
@@ -227,8 +227,19 @@ static int ctr_encrypt(struct skcipher_request *req)
 			src += blocks * AES_BLOCK_SIZE;
 		}
 		if (nbytes && walk.nbytes == walk.total) {
+			u8 buf[AES_BLOCK_SIZE];
+			u8 *d = dst;
+
+			if (unlikely(nbytes < AES_BLOCK_SIZE))
+				src = dst = memcpy(buf + sizeof(buf) - nbytes,
+						   src, nbytes);
+
 			neon_aes_ctr_encrypt(dst, src, ctx->enc, ctx->key.rounds,
 					     nbytes, walk.iv);
+
+			if (unlikely(nbytes < AES_BLOCK_SIZE))
+				memcpy(d, buf + sizeof(buf) - nbytes, nbytes);
+
 			nbytes = 0;
 		}
 		kernel_neon_end();
-- 
2.44.0.rc0.258.g7320e95886-goog


