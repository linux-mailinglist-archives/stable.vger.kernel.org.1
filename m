Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7026672AE35
	for <lists+stable@lfdr.de>; Sat, 10 Jun 2023 21:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjFJTAf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 10 Jun 2023 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJTAe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Jun 2023 15:00:34 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F9C30F8
        for <stable@vger.kernel.org>; Sat, 10 Jun 2023 12:00:33 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53fe2275249so1372995a12.2
        for <stable@vger.kernel.org>; Sat, 10 Jun 2023 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686423632; x=1689015632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6yk9cjAETDeQXC7gW5sz4TZUUZTSRbwKlM0y3j72/Uo=;
        b=Y1rYLLqwSmIs0mb99s3fiztpAyrLl8ZhfPDh1S15gpka2HfQPnEGtj+wp7gHugqjhN
         QZBA4oo7JBsu+xH/MCEtlewctqG9V/LDtMpUdI9EUmTHsg0k36io5KtRnaZCGK3cpgtL
         dIsKj/B3c68AgNPKcOU8WJd3Kns89NYk2pKQnVL4qvgnK8ESBsLg70MwBxUiIp4oPk+3
         /IthYXNJAkyi8uLhrRYzfwNYYeNOgxHeZ6rtXvt4gghGAzqTie4NqklrdZBQbAB44wyI
         mezUjXLOGCoedrDnzA9RGUYvaSHl9ULe6b6Zo3W0zU0hnlUsZX0/pg4DV99sYr0A5UlB
         VNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686423632; x=1689015632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yk9cjAETDeQXC7gW5sz4TZUUZTSRbwKlM0y3j72/Uo=;
        b=NFVytoBSmq2amDxJlZvVAEoaCafIyjoIpVE4xdmNKKG/G7gHmTY+V9+UMnctym7Dil
         0wViIDExoLyW2klDx0EoC6KJN5LFLa79FgiE5bAYbPthr8jHAgDUR5tyAG3B1T1eXJdd
         8ubPs3en80i2bW7K8nuAzLB8G9yPybbknvbmdkYTFDYdkf7s1sN04zqHyK/AHLIesdHg
         llJpJP3k3pTjzOPl+1XsMQ+GORADsQGDODcMBzM6ttd8ZmM6R2uYkDEVg0dk4fVQ1m1l
         StjEb3FZie9LTOvGmYLPxOtIExK6TyDbRaO98ug6sad4oBmd73Rezio0Bi0zZfyJFbqw
         UKWg==
X-Gm-Message-State: AC+VfDzq9Ha5qyRLPYoVYv13IFs7YGkZWXVQi8zE8iOM7+w18pWVVMjS
        ngp8Jz4TX+/08MkBJAcY/Lw8hfLOrdI=
X-Google-Smtp-Source: ACHHUZ7VfuweHwp+B3lKYBKEeJnmxdmEX3Bj1atMXu8oCP+tTY/qgAqcEW3Ei11sg/EJeE27/J/C9g==
X-Received: by 2002:a17:90b:e85:b0:25b:c8b7:9e58 with SMTP id fv5-20020a17090b0e8500b0025bc8b79e58mr836532pjb.25.1686423632383;
        Sat, 10 Jun 2023 12:00:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a005700b002568073d6fbsm5161665pjb.13.2023.06.10.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 12:00:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rui Wang <wangrui@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.10.y] MIPS: locking/atomic: Fix atomic{_64,}_sub_if_positive
Date:   Sat, 10 Jun 2023 12:00:19 -0700
Message-Id: <20230610190019.2807608-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rui Wang <wangrui@loongson.cn>

commit cb95ea79b3fc772c5873a7a4532ab4c14a455da2 upstream.

This looks like a typo and that caused atomic64 test failed.

Signed-off-by: Rui Wang <wangrui@loongson.cn>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I recently enabled atomic CONFIG_ATOMIC64_SELFTEST, which results in
a crash when testing 64-bit little endian mips images in v5.10.y.
This patch fixes the problem.

 arch/mips/include/asm/atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 27ad76791539..fd0e09033a7c 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -203,7 +203,7 @@ ATOMIC_OPS(atomic64, xor, s64, ^=, xor, lld, scd)
  * The function returns the old value of @v minus @i.
  */
 #define ATOMIC_SIP_OP(pfx, type, op, ll, sc)				\
-static __inline__ int pfx##_sub_if_positive(type i, pfx##_t * v)	\
+static __inline__ type pfx##_sub_if_positive(type i, pfx##_t * v)	\
 {									\
 	type temp, result;						\
 									\
-- 
2.39.2

