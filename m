Return-Path: <stable+bounces-177658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DF0B42925
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 20:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E42682F6F
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 18:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEDB36932F;
	Wed,  3 Sep 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="IKQmId3w"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63331362098
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925624; cv=none; b=HBynkUwzwpJuHM1gznYHBrROL9KRtV5qaim1/H6SiH15ii1e+xf0rEIVzRQ1xQz8U/qooWsi+Aa/uX9ob3fS32afJnHJjl/EC05CDHXA/QQ9QbEkIqiH8QkL5B8stmz5hs0uXiXvQg8Ly0MdM2xs2fzZO80+Cj83sxmrwWqP4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925624; c=relaxed/simple;
	bh=tb01GjZKeVYDMqeiQU+MbdxDJ+LoCTMzjQNhhcNJEgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQB5tUdPWUEG+lYwh/ccthUB9XhAyDZZ+jpEV1DhOksYmGdE1aVd2LIMBPDDehoa6C3pMI/94CvBqPdr0QBusolQzObqnnX7QynRvxLjYvYtJKB0c3u7yzIbXho7ssTqOrE+IvUl+ExnO93bMUl6PLDDO0yjmcemif03vGS51Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=IKQmId3w; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b89147cfbso2539655e9.3
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756925621; x=1757530421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AquE8JHU3wpKOnx9hZ4dVcOYBLYMLbey8qkeKp2ZqhQ=;
        b=IKQmId3w1XpsuZwgjqa+9vypfvBHLDUZGGKC/Ez1Fo+AtxRZs2IgRQrXEWiKrpi1mR
         K7lB4CBlzxWPsSLGOZxZbVMhbcsz/dHojRYg0cPESEm8YAtAfxBlehuoacAMdGIHsmg/
         Efv0Z0Y9QbOsCIl+ILcJb4x/qg4lG20Xs6Cr4LcNYve6vlHevmicqH1MpI7O/R6wuGd+
         Vym0D83i3huWRlTJxbwLOJy7V4QV8F0KmcHqDB8301NnBsa3yaFjM3ZkCWgRANFS+4KW
         txnvJn0Z9CP/k/hRZcyd9WdXmEWnVeDFyLdn0exrPERZVk1OR2AE2DA4V5+VfBIQ8iSG
         NAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925621; x=1757530421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AquE8JHU3wpKOnx9hZ4dVcOYBLYMLbey8qkeKp2ZqhQ=;
        b=YLUA0qGu+wZYsYQUGuYEBUyTcwg+NxFF6iwvfhegW+dikZqRsZUPG6+7N6eZtT67O0
         VFU6q5BqNmxuO/wCIp2fyZjhqFYgTui51GkErUNjrROmOr5KNZgpjFB6HVeWPoLMfpE8
         8MQ7ez0qBDZqrTvOF/PQ7piwk8dmbFf65eHDXhIck95cf08cQOPlmxgaK6f1/EHUByyB
         luR8J+T9HGcEEkzw0v5hcIHK8P10qgn3HYdBw/vuEJxePx5/3Ko+n6Y3sq5U5QlG3vVH
         ikI4zlkcwO9v5c8vx6T+GkzIwhqZCVr1uigKxKVoMvhLvxEyBjXhSjgHSyjJHIqutsud
         kdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3qKO4G102/VtEzvnvMh8TxN5aMrbGO9GkjmpqFMeiTXsb0cHRP8P30RSAEnPE07lNweNan2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza0UNTQVpjHMn4SW6MbzzELbwmIVzvYHMFfEYQN0XqWBh03Bvk
	VRbbCY9apCHp1DKNtPZBssOkeoCD5Kso3nwhzRgMOWBrUsVgfgZJGbVtZaxE1lyHxuc=
X-Gm-Gg: ASbGncucNvpoclLOUzsRfY3TMy7NMuot5ES1JbQAs56iMZvpkitOOLafBATaW7Ps/G1
	F5hBzd0YefGfGqNXw37ww8GTPQikWpy9YCpkzSM/wmDzdH5sMaFWDQk6LaX326aojDQC5VxD8j/
	8lgsBeMPOnz4g9q5Tgm9ZyFPZA/nJHZufynGb7OoC+uJzD69pNUm/hKRHjsjgJkLTerFDKCV2N/
	MRNug5+GSvFx/FC4h1ppt9ernbsvTLiJu2tTeiL24LiYxFIOuTt5tyXlqWu3TPYOL4r0Nh+bjBd
	r+cuUab9zsIf0dNumhFDtWYeoJI7JNkk2BtIDhmAFt3iU2JAPv6ivviGwRKyXMD+ilzTsdAklHh
	lJZ+eCJSq95sGFyein1pY1RlK+6IM9ptWXZoB6kRaOCKvywyu2Bm9CFrHjNUeiFUKC6NwW8Qqpt
	34sdo+
X-Google-Smtp-Source: AGHT+IERl6smvjSqMpuCaH/LYojC/JM0ih8kKGx0MImSuDXXr6hrLMvQiHu6Ro0U1pMEYuo7OfIbrQ==
X-Received: by 2002:a05:600c:4f8f:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-45b85550704mr136866395e9.4.1756925620576;
        Wed, 03 Sep 2025 11:53:40 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d690f2edf1sm13920647f8f.16.2025.09.03.11.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:53:40 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 03 Sep 2025 18:53:08 +0000
Subject: [PATCH 1/2] riscv: Fix sparse warning in __get_user_error()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
To: kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Cyril Bur <cyrilbur@tenstorrent.com>, 
 Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=tb01GjZKeVYDMqeiQU+MbdxDJ+LoCTMzjQNhhcNJEgk=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDJ29G3SnJAmn34r1vLZRsOeyyGHZpo9PH76uxIva6PxS
 96P+1d7dJSyMIhxMMiKKbIomCd0tdifrZ/959J7mDmsTCBDGLg4BWAibocZ/kcbd8yp174kdHxF
 6sf3i4o/3NqR2Hv9xkQ9ebk5od7bdN0Y/gd3lPq5tRpbKH/3+XHc/Xu55pram/3feFas3LDyk63
 JcX4A
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

We used to assign 0 to x without an appropriate cast which results in
sparse complaining when x is a pointer:

>> block/ioctl.c:72:39: sparse: sparse: Using plain integer as NULL pointer

So fix this by casting 0 to the correct type of x.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508062321.gHv4kvuY-lkp@intel.com/
Fixes: f6bff7827a48 ("riscv: uaccess: use 'asm_goto_output' for get_user()")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 22e3f52a763d1c0350e8185225e4c99aac3fc549..551e7490737effb2c238e6a4db50293ece7c9df9 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -209,7 +209,7 @@ do {									\
 		err = 0;						\
 		break;							\
 __gu_failed:								\
-		x = 0;							\
+		x = (__typeof__(x))0;					\
 		err = -EFAULT;						\
 } while (0)
 

-- 
2.34.1


