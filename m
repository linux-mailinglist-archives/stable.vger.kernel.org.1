Return-Path: <stable+bounces-191604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAD7C1A819
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 14:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69E9C561E74
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404E134DB74;
	Wed, 29 Oct 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="REWmlRrE";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="doUUtGg+"
X-Original-To: stable@vger.kernel.org
Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14034AB06
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=38.105.200.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741736; cv=none; b=gNAMIWU5NgZlPWeERgo8ahrEZnk3sWxTYW40d8BALk44Q8GMIHcdRhz6G29Pwkd1io7QfzwADXHLP0JrrFVoisbzmYZB3X6iD0NcKin+M2/SgnYM8hSq+WNye6j3BoWplrNTtIpd7n+z5B/59VaHD8kPxtj8JFiJilc8VLcp1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741736; c=relaxed/simple;
	bh=bgSORK1RfENccYbASrCDl4RViT0yZ/On2C+kIQDAVQ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pTkE4mceTxNMNGRurtF0WcpkS6CTu38fmBG8GPkyOTXFj4SPjFXXFXEwpSGKCzd8BbBt5PDghrD6n0uDmuaxwEFNedDSB/Rb8WiJZwDuwCaZyyb+0/rxuNeR3RQBvzbJgYhJrtnkOBtYpnhNHrPo2D7dsNfN8J4LHl4Ff1u7Sn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=REWmlRrE; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=doUUtGg+; arc=none smtp.client-ip=38.105.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Received: from mail-lj1-f197.google.com ([209.85.208.197])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.98.2)
 	id 1vE5Px-00000009rTE-2iSS
 	for stable@vger.kernel.org;
 	Wed, 29 Oct 2025 08:36:45 -0400
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-378db70438fso4109151fa.1
         for <stable@vger.kernel.org>; Wed, 29 Oct 2025 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1761741404; x=1762346204; darn=vger.kernel.org;
         h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
          :date:message-id:reply-to;
         bh=X+7W1X4jp+y4Os4v3QFnUhokwexod3vaiPOzJqoawqw=;
         b=REWmlRrE+aurfB4sSKirCeVxyLIcgtdhYDube8S+34lx6gVoZCPK63qmSfndAdaIqU
          NogcIHwkPjjLNLkc1dTeB+wEZmjICHIdFNdhQuTUyW78ao85vK1McZAHnI17hKLY6mJ/
          XMUv2JwARG9nIPmxYGRbn0XOHvFFcYCrOwyo0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1761741405;
  bh=X+7W1X4jp+y4Os4v3QFnUhokwexod3vaiPOzJqoawqw=;
  h=From:Date:Subject:To:Cc;
  b=doUUtGg+t9pEetb41axKdIFuzsbuhhjm/qx5giYhQTd1Dyn2m/L5iTLxL/8ZJw0K0
  Do9tGJoq0DkX7Ut6HOg3ZhpA5LGSYwYelccAGwKo67LE2imxwDrLqs0+jZT8fJrpec
  Iu2J464Y4zwmZDyyFvgrVGgMNVwV7ZQudgp092MCb7VH4aOieKWWnPR6QAvTZEb3OR
  Cx5Yo2wKBgQM0FmdtUDeV1nRlYDyyfbbq6G3Ep1kPpyfRu/TURWy676zic505Xn18X
  35RPiD5OoBi36b1fPUhJmxxMMJ1X+qOuGzewHhBC2Z/LoNtFVxgoU1AIo0zarrlVz8
  503WwjOgMrWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20230601; t=1761741404; x=1762346204;
         h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
          :from:to:cc:subject:date:message-id:reply-to;
         bh=X+7W1X4jp+y4Os4v3QFnUhokwexod3vaiPOzJqoawqw=;
         b=Qq8UGIOtupFf58Nlk0Uj95TiyZmCAXOvbwY7JjtwqRA5qutm89emTPZjnCuPUhjZYN
          Gs7c6BA4sFCYIifNeKZz6ZEITBLMwjPSSEMQqeMfjwglhzpcAF0KD/wiKWCcA2waZ2FT
          aiQ4The+6xotnjgydggEkxET9vVumtMTDBdeGfqVLafqb9WoDfqAu9ke55w8+7jOIWsJ
          16dVEj+MzW/00K7BkBk6NppYVOYryOg3M84YL5HhJV4XZqq7HZ48m608Q/+HdAZ3uKSj
          EyoQqYUa9cRyraS3RU7fEXHkeqX8lDbGq+oHoegOYOyS6LkpHPDwTJ3eUJfvJallx/4K
          Kslw==
X-Gm-Message-State: AOJu0YwPLW625BUBba5FlAzVyrDbmXbTevuQgLVonbpP1ZBXltN5P686
 	xwLQLr+kV4maY8+JcIz5pNNeQW+9Xqn1a/XAU+t4q/r2OrhDQDUVtVD0rscQnJQm5MMgoaAySFw
 	0iB9lxFUr+VeEMVB5iGOkYLTTzvlnBOD7JpRCqylhLWuffqHlqRLWEYslttMyT8iREu1F7oGHch
 	ceWKQ8MJhn/QXKdyRQgmh2gcHRLdRVGkawH1AiYeQ1Iw==
X-Gm-Gg: ASbGncuop0ezyFza22RKfxplp+op40PJXr4+c02CQxKCTkXjRQrqcT8nZY6D73ftnup
 	iQkrcWjByq24swSSqdNRudA14rGdu4WuXLEfh7j7jU9sdGv9k7PHcsmZGZSvOgx09Td6F5VVRvs
 	cQUeCuyAbnuJ5schbGWIvSi2hpCfmSVypL1b4QZ9NU8eyV6b3+JMJyz2g=
X-Received: by 2002:a05:6512:3a86:b0:570:a8d4:a79c with SMTP id 2adb3069b0e04-59412a25732mr984850e87.0.1761741404202;
         Wed, 29 Oct 2025 05:36:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQAcb6zIXR95jgMxXfcTs0xkRj3LbkrZJtVY97fK0BCgstqyBmhGMf4E8+3tQF85hg33Lh8hBKSebQjB0H4FQ=
X-Received: by 2002:a05:6512:3a86:b0:570:a8d4:a79c with SMTP id
  2adb3069b0e04-59412a25732mr984838e87.0.1761741403760; Wed, 29 Oct 2025
  05:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Dolan <sdolan@janestreet.com>
Date: Wed, 29 Oct 2025 12:36:32 +0000
X-Gm-Features: AWmQ_bmjSjkwGCZMgz-ajeT0GAoGy1rWbDvRpMMXF4mqGxkNOZdrSFW_PGLCOPU
Message-ID: <CAHDw0oE0334gEJ=ga1PAnZ3Av8+tFkKF-MJCF7Jj3i6pBVJvFQ@mail.gmail.com>
Subject: [PATCH] x86/mm: Fix check/use ordering in switch_mm_irqs_off()
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 83b0177a6c48 ]
[ Patch for 6.1.y, 6.6.y, 6.12.y trees ]

To avoid racing with should_flush_tlb, setting loaded_mm to
LOADED_MM_SWITCHING must happen before reading tlb_gen.

This patch differs from the upstream fix since the ordering issue in
stable trees is different: here, the relevant code blocks are in the
wrong order due to a bad rebase earlier, so the fix is to reorder
them.

Signed-off-by: Stephen Dolan <sdolan@janestreet.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lore.kernel.org/lkml/CAHDw0oGd0B4=uuv8NGqbUQ_ZVmSheU2bN70e4QhFXWvuAZdt2w@mail.gmail.com/
---
 arch/x86/mm/tlb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 8629d90fdcd9..ed182831063c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -606,6 +606,14 @@ void switch_mm_irqs_off(struct mm_struct *unused,
struct mm_struct *next,
                  */
                 cond_mitigation(tsk);

+                /*
+                 * Indicate that CR3 is about to change. nmi_uaccess_okay()
+                 * and others are sensitive to the window where mm_cpumask(),
+                 * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
+                 */
+                this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
+                barrier();
+
                 /*
                  * Stop remote flushes for the previous mm.
                  * Skip kernel threads; we never send init_mm TLB
flushing IPIs,
@@ -623,14 +631,6 @@ void switch_mm_irqs_off(struct mm_struct *unused,
struct mm_struct *next,
                 next_tlb_gen = atomic64_read(&next->context.tlb_gen);

                 choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
-
-                /*
-                 * Indicate that CR3 is about to change. nmi_uaccess_okay()
-                 * and others are sensitive to the window where mm_cpumask(),
-                 * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
-                  */
-                this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
-                barrier();
         }

         new_lam = mm_lam_cr3_mask(next);
-- 
2.43.7

