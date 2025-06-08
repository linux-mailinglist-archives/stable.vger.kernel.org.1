Return-Path: <stable+bounces-151933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E0FAD12CD
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D131E188A81B
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5022024DCFE;
	Sun,  8 Jun 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrYMo5XZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB31FC0EA
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749394533; cv=none; b=AaVuxaMp557IYihuxPmwESTh8FB6EETQf4FRRC5+nKx+a/j7Hk+x0yygbAtI1QPjlh8ZRfv7rfcIwaa4j7nK6bMdDLHk6e1HJxYZ3MxkOoy6mgxwh0gaizVpHsLacJ70DnKemxCM1YMLVty5IYKB2BYZNNd1DtRSqraZdNv8J50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749394533; c=relaxed/simple;
	bh=zjFi9RG0+7dPu9Eyv0qvGLUM/MZh79yOvOLngFhHNzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGJrnczsSdmok6yVlClxDNWU97/33LBkixIyNIs6muTXZAeOEsWupvIx9VHvz9JQVWtc47e+jnkGxlNUBnlcwK7aVHrpzoGFg0GV7YUTgZxN4N9kPCLi8dNeTSkPleV2IIq1v2r+pTBvlnjQUPybwFuZdWIzuXRA0p+EYdX5ihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrYMo5XZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a365a6804eso2183336f8f.3
        for <stable@vger.kernel.org>; Sun, 08 Jun 2025 07:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749394529; x=1749999329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO6WnZBg6YLYAbce4j76OsnlJ7Vti7lMnDWyaUCCXIg=;
        b=KrYMo5XZTzRfH0E5va4YgrwcrkGLKa32cNtM8OBtwovJAzHb0dBSRFtkz7kYVKk+fi
         c6J7BRBDZHCQeCEAWglh62zm882BMi39zxZmnqaF0dePpr6PepM7UPM0atfNa+hn7gVV
         qnic3jrv8lKexL0q0rTfTmj6CYP2SloA8mIlOUTDcVeJQlVZkLwqoDn1VMT/jcMwbUEj
         EskoAuEWTLM4fflQvu/Oair7mlYpJ/9CI+OFT3E56HdbMajeCQPLkcaPdjYaIpFTAO6n
         3KLtmn9/7NQxlu1EkuYyZLmsfFGx4PCO86slmYTKQluCI7+rr66hSFqoVo2n8SS4GW4m
         tswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749394529; x=1749999329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO6WnZBg6YLYAbce4j76OsnlJ7Vti7lMnDWyaUCCXIg=;
        b=QQXVmqOwJVe/qGuSN2XvAQvCn5AHu0S9ojpoBxYCYltDoUb2CfLs2ewnMn351hlOWp
         N/oTVcInzTbugfeFUqko/8SJJRimht/Kdq6sO1mBmZUrkQi4qiGUM9j+CuFoQqkQGK1D
         nGnGgDh4NL9X2YDpbPxZqYjgtWskpO9OdzrrUXYBZLGyUiC9aqA08CnzTi9n7griTxVc
         hUT/qRab6/wmzf68v1/R9Uc89tZJIO0NxUVbZspB1Qf24BhTFkaZ2iE4Cb3dlpixduC6
         A1nBBHI7wKsXcl8m6A9dfwCWe/GXxykwnBi7CqK7NQBHduTv3egSrEX1P9d7ZaohKOx8
         /7jA==
X-Gm-Message-State: AOJu0YzMm8sS0DToYrIZfgoaf3D6cksCV4kc4iHZuEmTHxZcj5lxn319
	BTt9lsao6rG2b/OdIs7H3/iWohYadO6Xo8Pm8EzTM0+cldc9SFjvLuDwa5ZC54s+
X-Gm-Gg: ASbGncv2GtdMAMcH/fPljucLLyAPvT3aB9Vt02oeTTIZBSs6b5mZL7roKhx1l0LUc63
	/HLkKY2NFVJT0ThXX0bwznBBK3EonXo9MHpPQizwxfPnELteVyFzTfXC7Qc5Vggw5051bA7nfBr
	TmuV3AAcDFYxhc3AUjAV7VjuN4DY5m9+JA6uJVhXorC28wJFuOpwlKm6v7AsbCuoKz/Xb0fYBFi
	QQx5RfQFyfG9nflRzTwLtbbVxN4Z0RPPEoh8oVn8SuIFCffwkJwDaVG7mWaurCj0nDVcwjLtAWA
	CjM4nx2LUI1FHOgQTnls13RENLJDh5CV49jUdypPfqkMHtbV2HZLXytvhruT044Adk8hBdGWfTu
	utKi+AKSrCnXlhac=
X-Google-Smtp-Source: AGHT+IHtTJYJh0K2Oj5XCgRZIxdf2mAPDuLk6Omww/vW14A/EeYiN1gvbeqOW+v4l3enaAemwzlh+Q==
X-Received: by 2002:a05:6000:18ac:b0:3a4:dd8e:e16b with SMTP id ffacd0b85a97d-3a531ca742dmr8460867f8f.20.1749394529246;
        Sun, 08 Jun 2025 07:55:29 -0700 (PDT)
Received: from laptop.home (178.75.217.87.dynamic.jazztel.es. [87.217.75.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324520e7sm7345817f8f.84.2025.06.08.07.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 07:55:29 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
Subject: [PATCH 6.12.y 2/2] x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c
Date: Sun,  8 Jun 2025 16:54:50 +0200
Message-Id: <20250608145450.7024-3-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250608145450.7024-1-sergio.collado@gmail.com>
References: <20250608145450.7024-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

From Nathan Chancellor <nathan@kernel.org>

[Upstream f710202b2a45addea3dcdcd862770ecbaf6597ef]

After commit c104c16073b7 ("Kunit to check the longest symbol length"),
there is a warning when building with clang because there is now a
definition of unlikely from compiler.h in tools/include/linux, which
conflicts with the one in the instruction decoder selftest:

  arch/x86/tools/insn_decoder_test.c:15:9: warning: 'unlikely' macro redefined [-Wmacro-redefined]

Remove the second unlikely() definition, as it is no longer necessary,
clearing up the warning.

Fixes: c104c16073b7 ("Kunit to check the longest symbol length")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
---
 arch/x86/tools/insn_decoder_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 6c2986d2ad11..08cd913cbd4e 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -12,8 +12,6 @@
 #include <stdarg.h>
 #include <linux/kallsyms.h>
 
-#define unlikely(cond) (cond)
-
 #include <asm/insn.h>
 #include <inat.c>
 #include <insn.c>
-- 
2.39.2


