Return-Path: <stable+bounces-182968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04E6BB136E
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 18:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B714C25C1
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737992836A0;
	Wed,  1 Oct 2025 16:07:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CD5248F72
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334835; cv=none; b=H9Doa0xqsyF/uUuqLENpKJ3XfG+Y65dBlSi71Bx08Dj8sSJ4IzeR/WewbLXSGUG25gcQm9fDrYr+FUOdot55ZSd9wEujKYpZbqAZW8y6VckQLn5P/OoK/kk/u6rmBNUgNVxdn1L7wq5VDPolsd4HfD3/40aDwaKuYehxOCCmJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334835; c=relaxed/simple;
	bh=yGthKrJgjptv1SsVBgVQ+xaQq3apEw2V386nO3JE0tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CW3x3QKRRHQw042pdwLiGq1QpYusw32raT+N7MNaiw1GYqc8i93VKmvCZz0f6dM0kOYKAOdEGYW86/r88p6gtM7rEFt1SzYWmFVlWPu+P9rYRVAzIErcrAB0Aq/kwp4b5vJeC1BIihzLlJHIYmAinq83/4IkOfmns8pU3bbvidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso6723166b.3
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 09:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334832; x=1759939632;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5F/ZlmahY4v9ng57M3b3RixWviloAxPsx1h4/uNyS2w=;
        b=AZQYqIB7b/3SnSaPkQ7tO9ys5fdyPZagmEYKgkDRn7qAx09rOQqWfgXSmd+aW52Zwx
         famGhamcZXHqMJHjx3eZOZWVa/WaHEetKZz9UsmSET7lClYcZIamJmOCSSUv2IbmZnmV
         PZimb+PPPkTQdPk2SWK750OcA4a/t/wlDtLLlUtNi5UBUR5k+XoSeuPUSVQblgjG008E
         OSJ8LVqIc29YaMOKHUtX8+6j7ai4LAhJ0izO/acwJSv+k0l6uYYokxkLCkbidmve9OL2
         TCmB+ydPkig3kUC84QvKBm7EL8nsYtqzJvLET5K3Ymr6F94OJj9l7tVZ6SHDyor7Ob7c
         eOTQ==
X-Gm-Message-State: AOJu0Ywmf1aBdg61TFcFBbA43WaDz7BmZErfUG0xKinmOuAs+OB/zDDf
	6Kid4AvA/L38P/LUF9vqLbpszq5CcGyT+YTUPl3E4Dg5FDkdPLyiX7R+
X-Gm-Gg: ASbGnctt3htuq8EjarARu68xVLMNgj4AhyDe84sYxlUVKIPwdp8U8H7xq8v39QTLl3a
	XppXoRpJHSOFTpPS4K37sitqFpoM9AIr0YaNKwiifQ6GeyucK9miPOIowfu5nlfnC+1df/Z5N+s
	OVzOfT1SU94FzvYZYTCLux5i3+RpHzDtX8UTbdNJ+jkGlFYLqKt+I8A/lA8DjkzbEHO9C905PoS
	UX9Ct0tZBAvU83fEpXO7srynIBPDoNzhv1EyNzjAgx82N70cXDaOOu1Z3XTXh2Kbd82KUKrzdOH
	/eBATy9d1kV5egDR7k6SE4L7BvHFoEIZ4n8YTPD7k0oMoJXNgrUpCGlNLnCSeeV+yfeSdJGNsS2
	Mh05YEmoABSffB4UwqhAQKuc/rzznsELWLruV
X-Google-Smtp-Source: AGHT+IGU2oV2XoghFFNjXpeXFR8ZpMH3QCRErktbMJOKfZuJaKAV1DQAvKt87juoFqsJakAyIPoG8w==
X-Received: by 2002:a17:907:7212:b0:b43:b7ec:b891 with SMTP id a640c23a62f3a-b46e3ae19e4mr491578466b.28.1759334831631;
        Wed, 01 Oct 2025 09:07:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3b8df3sm51976a12.13.2025.10.01.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 09:07:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 01 Oct 2025 09:07:07 -0700
Subject: [PATCH] stable: crypto: sha256 - fix crash at kexec
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-stable_crash-v1-1-3071c0bd795e@debian.org>
X-B4-Tracking: v=1; b=H4sIAKpR3WgC/x3MQQqDMBAF0KsMf20gk+omVymlJHaiAyVKRkSQ3
 L3Qd4B3w6SpGCLdaHKq6VYRiQfCvKa6iNMPIiH4MLH37OxI+SvvuSVbXQk8cU7Fj4+MgbA3KXr
 9u+er9x9vAtTRXgAAAA==
X-Change-ID: 20251001-stable_crash-f2151baf043b
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 Michael van der Westhuizen <rmikey@meta.com>, 
 Tobias Fleig <tfleig@meta.com>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; i=leitao@debian.org;
 h=from:subject:message-id; bh=yGthKrJgjptv1SsVBgVQ+xaQq3apEw2V386nO3JE0tA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo3VGuPtPcA/FbB8X5L3sATv/wd4PcV5twNu9J+
 9M1P703yCSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN1RrgAKCRA1o5Of/Hh3
 bYx/D/4oyRu9MKW9AfBVPio3fDNu8pXycH+g5imDGXWy45s4UXL9Ncnb/lNfMBFFL44hC8uAB/Y
 bycLfU3OJLP40P3WwHV+tXrT0cSU2N5Zwy2x21twyp59R/G6EkXhRQdXsAf8vTMuQAPXcZV0BLg
 Ok7fk1Jwsc4QD835ibz1CzTegXZtyye0LoCCbF2kuJHY0C82L2SsoVfsCf2K7SLc2vlWZCWMEOX
 zE7u8Q7Z7RJbA2nllYagJWW+byq3R2bO/f0gdbNhU9AtfkqgW5tAg8kNZb4cCYBqtbfgPANc6Nk
 eHRz6xvX2EZlABpCZfbxccm+km7nVlj+1jIS8zd5DCJKEup/wLEO31r7gYZ+N3h+RE8KidBKbp/
 DV/90DK0MoU2wFb+GT7rz+yRhBNmasapS4rocrCkCD0oWs0zPhmWScBnF1D2SbNvAunTFVBQDnn
 DdiKCFho3CfON96LAkZzpgEPbkIjW8ZzjA0nxNJ6Ts3TvZRatgNpt4qYxDSh6SurunNgYanK2Kv
 tzPEsvGghgTVWjMa5ViHlWTIEsVqSR3vzmIWXi0RyK3ZuEq0EwRfxdWgqNuCP4xwJAuUoE/w738
 024vq5PU3sfeOEcbA6wv9IIAKH7+wpVurdwQk5BgV9KoL36qQYRkW4ampOy0jJS8YZuF9YYJh83
 xSEprJRPwLiyb/A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Loading a large (~2.1G) files with kexec crashes the host with when
running:

  # kexec --load kernel --initrd initrd_with_2G_or_more

  UBSAN: signed-integer-overflow in ./include/crypto/sha256_base.h:64:19
  34152083 * 64 cannot be represented in type 'int'
  ...
  BUG: unable to handle page fault for address: ff9fffff83b624c0
  sha256_update (lib/crypto/sha256.c:137)
  crypto_sha256_update (crypto/sha256_generic.c:40)
  kexec_calculate_store_digests (kernel/kexec_file.c:769)
  __se_sys_kexec_file_load (kernel/kexec_file.c:397 kernel/kexec_file.c:332)
  ...

(Line numbers based on commit da274362a7bd9 ("Linux 6.12.49")

This is not happening upstream (v6.16+), given that `block` type was
upgraded from "int" to "size_t" in commit 74a43a2cf5e8 ("crypto:
lib/sha256 - Move partial block handling out")

Upgrade the block type similar to the commit above, avoiding hitting the
overflow.

This patch is only suitable for the stable tree, and before 6.16, which
got commit 74a43a2cf5e8 ("crypto: lib/sha256 - Move partial block
handling out")

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 11b8d5ef9138 ("crypto: sha256 - implement base layer for SHA-256") # not after v6.16
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
---
 include/crypto/sha256_base.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/sha256_base.h b/include/crypto/sha256_base.h
index e0418818d63c8..fa63af10102b2 100644
--- a/include/crypto/sha256_base.h
+++ b/include/crypto/sha256_base.h
@@ -44,7 +44,7 @@ static inline int lib_sha256_base_do_update(struct sha256_state *sctx,
 	sctx->count += len;
 
 	if (unlikely((partial + len) >= SHA256_BLOCK_SIZE)) {
-		int blocks;
+		size_t blocks;
 
 		if (partial) {
 			int p = SHA256_BLOCK_SIZE - partial;

---
base-commit: da274362a7bd9ab3a6e46d15945029145ebce672
change-id: 20251001-stable_crash-f2151baf043b

Best regards,
--  
Breno Leitao <leitao@debian.org>


