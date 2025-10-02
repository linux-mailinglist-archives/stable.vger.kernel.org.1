Return-Path: <stable+bounces-183032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C293BB3BC8
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7DD17EBCA
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 11:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C206F30FC1C;
	Thu,  2 Oct 2025 11:26:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BBF1514DC
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404394; cv=none; b=aGi1OI/R0+kC/ujxG8u042VNjG3GHhwQj2Z87T1HwGJECsVcI4u4KeO56GDIXZ+7stPwvjain8DoA8Do6UZMl118GDkcwvBH36EPBaxFIT/QVf2r062jomIxF55+S8fT9AcC/m7dvhHyPxXCef7cV076drHsiQqXOAqXaL1a4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404394; c=relaxed/simple;
	bh=L2gyy5R2PGRsyNpSJCw6YF43D0THBoN3Fpu7eFNWOsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Te10Npi8AdATDHQCkLZKtbCB22O//aAK3dpjvMcMkoJTtdztFH+O7mw7l3joly+8Xor3aHFWyS3QA35lBlDX9LsUbXkvl4Wcp7FmKJ/h6UlDEPlQbdwawroI7ZDgVeSHlXWXQ0dj3kY3lqtuQzVQNTeOz3qhZXXAcbkE57jtoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-636688550c0so1802435a12.2
        for <stable@vger.kernel.org>; Thu, 02 Oct 2025 04:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404390; x=1760009190;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0nIdEO3nCxjYmoEiKbLvMDM6O2oTNOpG3jz3yT7Mfc=;
        b=B9hFUn9ht0at4EkTWBK5UNsQ3nHyuntA61RwXBHLD2Sq1g5Z/kQFeQWeq5XdbcebSa
         ls16eV46um6y/YFd10vnmsRxRZNj9kg87leJivkNFXruU/BC04eayctb1+88j/8xugQe
         s58v7z8OOo1eqVzP4VfgidhqxJvDflvKW8yagvuxMoaPwG8Q/rWwEfpaxfp13FQzVrbS
         6a+uijmjtUW+PCIDR8Vku3s0D2ezN7qE+hW/BrBUdYsIwbk1EtXMQazjt++Y+zEyXkzZ
         tegmGEtABK0Yh3o0h99TQ6GKUjEAWse64BE5UKkuzvIZK5EzWFgDUvt0ZlDPF+loUnBc
         x4DQ==
X-Gm-Message-State: AOJu0YzcidAFDmDAHE+uLFIogjxWHrlr8qeBYPBpC0x80b8tgLGkirN7
	kd9BlIKTWsEHC38twhoUTvYjOws21VAqpvPmhdyD+IHrqj4nk7ALMRSj
X-Gm-Gg: ASbGncuEEuXOiFvhD/dXw3vdrug5dJeIQQlc0l0OQFanG+/PIZfy7q5T9q/jhwHzUva
	dnePMOaLNlUCQvjx32xaLroJTAUEflpA1IrZFCu6CyHfBdDXaXP18AjrFDC01mjD0d6cQDtcU6p
	sp7Mk51sgXhW/2wgnfVxfdGrYQfj18AEui9YYIH/mIpTjK/tD6h1p+y2KABr2rmWTAurnrJVysL
	TMDRrfdsGvTJ1mva2VmuMbUfc1i5RptiKFpKtCXkiw+rjMjnrFrKjEMShZBo7uVRNTIVVhqT8Bk
	zrubUf9WlLBWXkhv49WMqjXRtXesWfhAT6yFhiOPV+LsiWM9g69m+qGjA+adzfmI5orlWGZci31
	sy6bb8u4TtvWv2+ysMCU2VBBSb8xnW7GH0pss
X-Google-Smtp-Source: AGHT+IG9HhGolfHHMg6Ad2wpoa5xY0rqQothguiF1qQAIawwu0gA0HdvZrHHIiYXFOGXFbUci2Ul9w==
X-Received: by 2002:a05:6402:1ec9:b0:634:5fb4:10e6 with SMTP id 4fb4d7f45d1cf-63678c4d06amr8314834a12.23.1759404390054;
        Thu, 02 Oct 2025 04:26:30 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6375eb397fbsm1647457a12.0.2025.10.02.04.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:26:29 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Oct 2025 04:26:20 -0700
Subject: [PATCH v2] stable: crypto: sha256 - fix crash at kexec
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-stable_crash-v2-1-836adf233521@debian.org>
X-B4-Tracking: v=1; b=H4sIAFth3mgC/3XMQQrDIBAAwK/InmNxTSXUU/8RQtFkjQtFiwZpC
 fl7ae69zmF2qFSYKlixQ6HGlXMCK3QnYI4urSR5AStAK21QKZR1c/5Jj7m4GmXQaNC7oK69h07
 Aq1Dg99mNUycgct1y+Zx7w5/+iRpKlL0acFZ+GW6G7gt5dumSywrTcRxfUTnH3KkAAAA=
X-Change-ID: 20251001-stable_crash-f2151baf043b
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 Michael van der Westhuizen <rmikey@meta.com>, 
 Tobias Fleig <tfleig@meta.com>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2616; i=leitao@debian.org;
 h=from:subject:message-id; bh=L2gyy5R2PGRsyNpSJCw6YF43D0THBoN3Fpu7eFNWOsQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo3mFk4r6DYmopianNWZQlWi3FjU3x2aPyn4g6Z
 GPHyjdKO4mJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN5hZAAKCRA1o5Of/Hh3
 ba7wD/0bKMhDOdDE3/MMo0aZ/Scql4DlORNBiC9qjeNJFyFeSO6OBfIUAzIoUbtrm0f03PdRJdn
 bv36lxyUK0N12VhVzFx1xXwaUjgY10Wz4nlMwNFF6is8p0nvKpZ7S79Tzmms9SizXhhyVSu4uwi
 s+HOPjFgXlotiUhiuFF9MrU8dnLlwOBAvrDcWjgS0qod9A7iFBgfkywjEpYU3pFSvd7kuEhW3TI
 4Dlq+eyXukilJj7KDqzBG0x/5dwlAPzQMDaEq2Ovm2D2cQMDDlKry05sq6hWDC6rinUK2ckzgTT
 4u3BA9KQsVh+sKmXSaxJEcsi0vQB58b1xtx1nxgA5wp0tEx2emQQskXF5OpmkrJSmN0kQYyYteh
 FLxsAyuLaii0vMg1wka4Ij4jzSAGIgiTlr4GmB4F00DKMFNXwmjF80atG9vCzZTp20iyWGuNn96
 7zqm/wQMDPh2yVDC+qLAmQNPDRMjV3pcGYF7g7uQk/CqOX7b7vA+u+MvJT8FCR2PnkEtZCJPXDx
 gzSLxhlFIWdwFw0ispSGOaxTYbHnM/IAlO3a6t71OVYpwjGW4mrb0UzgkcN3KtnK31KlJOTKxl3
 D+Qdq1BY3M/N4DTCY+EzcEwmS1e+BVT0ryCQ09HINk0zxDjHoH10Zn0LQzsD8ATubhmGcX3Sbvg
 dTf48fpB3rSL5Ag==
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

This started happening after commit f4da7afe07523f
("kexec_file: increase maximum file size to 4G") that landed in v6.0,
which increased the file size for kexec.

This is not happening upstream (v6.16+), given that `block` type was
upgraded from "int" to "size_t" in commit 74a43a2cf5e8 ("crypto:
lib/sha256 - Move partial block handling out")

Upgrade the block type similar to the commit above, avoiding hitting the
overflow.

This patch is only suitable for the stable tree, and before 6.16, which
got commit 74a43a2cf5e8 ("crypto: lib/sha256 - Move partial block
handling out"). This is not required before f4da7afe07523f ("kexec_file:
increase maximum file size to 4G"). In other words, this fix is required
between versions v6.0 and v6.16.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: f4da7afe07523f ("kexec_file: increase maximum file size to 4G") # Before v6.16
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
---
Changes in v2:
- s/size_t/unsigned int/ as suggested by Eric
- Tag the commit that introduce the problem as Fixes, making backport easier.
- Link to v1: https://lore.kernel.org/r/20251001-stable_crash-v1-1-3071c0bd795e@debian.org
---
 include/crypto/sha256_base.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/sha256_base.h b/include/crypto/sha256_base.h
index e0418818d63c8..e3e610cfe8d30 100644
--- a/include/crypto/sha256_base.h
+++ b/include/crypto/sha256_base.h
@@ -44,7 +44,7 @@ static inline int lib_sha256_base_do_update(struct sha256_state *sctx,
 	sctx->count += len;
 
 	if (unlikely((partial + len) >= SHA256_BLOCK_SIZE)) {
-		int blocks;
+		unsigned int blocks;
 
 		if (partial) {
 			int p = SHA256_BLOCK_SIZE - partial;

---
base-commit: da274362a7bd9ab3a6e46d15945029145ebce672
change-id: 20251001-stable_crash-f2151baf043b

Best regards,
--  
Breno Leitao <leitao@debian.org>


