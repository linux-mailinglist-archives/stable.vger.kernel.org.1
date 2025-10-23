Return-Path: <stable+bounces-189081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3E5C00120
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 11:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74161A009ED
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 09:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7BF2FB61B;
	Thu, 23 Oct 2025 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYR8Ad8x"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F12F6587
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210181; cv=none; b=ROu35zMfxP9ldHBekTtgmb80r7cJF3T2lrGU2Xea8TymUV3aJHn+Tek0OQnqp6Ia2jcESKf6CfSVVbfkYy0r/I9QsjRbtNevSjrrzFivoHtH6Ne7YFJ40gEUxsPfrIVGqQ6h7ELZdqKR/Q/2vuI6Noiv1msvZLYl8JB8GpIEYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210181; c=relaxed/simple;
	bh=yThxXVSm3+hK2gArS0hottDcHjOB+llPRjJdv2JM2fU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UX+JHMXkjHWvALcMsUgzEoDJBNseVonOVcOjLh6z1dysC92fo96ZOUfYyzfwUnKYUr4FBw74GGEkASZETt6gM8tPkUSoQC88LE0o7EslEQJMk9ua5UN5WT18RhpBxyKzUoWrfnhpfmumic1iUqADnBWX/8SP1yYUZRLkNLA3rsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OYR8Ad8x; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4271234b49cso81906f8f.3
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761210178; x=1761814978; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFuE0Qcs0juStrOxen2a+4uOIfGC8uiPTlRJqX3Rs48=;
        b=OYR8Ad8xdRpXqnLxdOiHx/F+ZVayo+t7QvNTuLKlohSM/VcwWJqGuz6w4Gs9cabP/N
         lGR5OD4MRbS5ijRqqGr9iVAlt3Aozit702/CzvpDuGPptptwxvD2RH3cDwpLsJgo+OO7
         MFlFVbLEMcAGJ6Mz6zcphhSViUTzbUFH5bY4S1LpkqrGVbDLCkESrgKY6SaB3L0YmKo9
         zgU4MC1KONRZZF1SCE31L6nilGYg4+yh2uEEUcb5erXGgFtOozrvPSwdp9dIzR300woo
         bVCKegVriSqdWH/OZ4Xj4sBtjStcw31QSrzSo1Af7UW9MLHBQIDRQicXj6tOUn4KhXcd
         N+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210178; x=1761814978;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFuE0Qcs0juStrOxen2a+4uOIfGC8uiPTlRJqX3Rs48=;
        b=VlTFDRQoYXSy6TrPF1InuhQuUOvyyrzrnUKsWjtKh9Q3AMtFMzUIbOewPXftNNYrzW
         V2boFyLKjXyUMX0Hhshl5Xy1WiOwl8m6S5IIMqtvh5Ix13PKtzoYR3S/+3XTfSgYcXEl
         CJpze+faebayMLiNY91YEIdNWr66nEfMnXdJ6C2YYTsmJf67uhJWklUlLqOU2DunX/wo
         Lju8pMBzXirAKLZJWT5+BJ+ezis23dJqpN6iJXxk4Nq26FkXC02kqFBdRFfg+Q1o+b4r
         XYx6rJT4ItRszyRzkW6iEnmgy3egWZ0X96J6i3hT/66J2M0flmYkhq7vroVVT5DBX5jp
         ZLQw==
X-Forwarded-Encrypted: i=1; AJvYcCWIR6phn2xWuAKnJQYa5bGt3Xf/hSuKhhq4fBkn6Gh9XomR7TfycVzC1tFC/SfX8hoXTlKC3vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUZ3F8ywD4NhE9RNJQXU4hxaA6Pue1j2NPu/g5t+3E3tYaU6H
	YOlcPC0pulub3d25Sbe391/uUVb6Z3j2GBx0wGeg9x8AY216/kB80N9cM71hzlsnsBo=
X-Gm-Gg: ASbGncv0+V8yOFugNAlVNbO1m1vROiJDs7W0kx7Y1m0nf6uvZ0baBfkrzaBMtzRsCHh
	4cLDB2o63DYV4La2daokjvQBcwN5Hf4X1yYM73QlNtqvtMizVyzmRgt0jgkpfn0fdcuUUvTMLcq
	biogXa9QOUJFjme89JBNSWs34wJG+vT4h1tk1GGsVCVwQaO5jY+a2BpZEp+ZRoyx+qmFYWyHjoq
	/Z5fwkyWyqSGmRrlI/W//s4N5Xw8nJ8zuVXaAWIwrxYm6vnwDLsQUCGlgP4OyMZ2oOsL/uPlLH3
	6FyQZ+YCTQqvLUk2PpE/mTzHjj2OOdJ4T8ZUY2wHCbZCh697Sz0Pj7/mCO7UEDR5SqV9u+uIv5Y
	HiGTAxWpPnjuFjQtJ5IMMPHjVxaxHH2ZFz5bMZh593QhHL7uVUVQlPnYLZKtv6jWZvcRRAMpuM3
	aGC4fAzhFZWh3mcHFGs+rd2uBNZtA=
X-Google-Smtp-Source: AGHT+IHpSYP1sR+pts4n30k13thGKI4DumOkmgxbujGbWwk5uMEc7QI6iqGk/fbOCQUf2LU81yrRFw==
X-Received: by 2002:a05:600c:154f:b0:46e:46de:ebdb with SMTP id 5b1f17b1804b1-474943c0ffbmr41606205e9.7.1761210178110;
        Thu, 23 Oct 2025 02:02:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949e0a3csm57557415e9.0.2025.10.23.02.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 02:02:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFC 0/2] ASoC: codecs: pm4125: Two minor fixes for
 potential issues
Date: Thu, 23 Oct 2025 11:02:49 +0200
Message-Id: <20251023-asoc-regmap-irq-chip-v1-0-17ad32680913@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADnv+WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNj3cTi/GTdotT03MQC3cyiQt3kjMwC3aQkIwNT42RjI0MzCyWg1oK
 i1LTMCrCx0UpBbs5KsbW1AIGHIodrAAAA
X-Change-ID: 20251023-asoc-regmap-irq-chip-bb2053c32168
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=693;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=yThxXVSm3+hK2gArS0hottDcHjOB+llPRjJdv2JM2fU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBo+e8+VfBvCz453H9L48zweVlc/PFeRm25E9jrU
 tSxJu2g8uWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaPnvPgAKCRDBN2bmhouD
 14pJD/43Ii/e8xuhwekZG8etRDVFVJAQrqlZeYMDNGzRRB+xOv6Kzypn0PKvQO1KxGjldLwKAcs
 zDULHHeCoTX5dyYh0E5lCrk6qbeCGFQXw+JmLbiRSpYPfeb3BXfqb5EotnWGdIeSGP+nzhffuJM
 uZxOMvMnuc+EW1LRZacYeS/Ab/9uJLyh8fYErntpt6FIs5kGGGtR9HBlj2wKRgtXwcGGkyL0TZB
 Xzz9K60En3o+7h4Tvs6oQdzY7DGCsNRxOKQRSgJCOKsZUG/fZbpuNX/OJf5va5wnuhZE570m3Il
 1rMiBgkKilzSimDCdKM3fgHyH5kxxh6Z/oNCpeuO+X3Df45EbwqE3OH6vKe4pOblKxD1zV+NT+1
 cWlkMmRS9r3GpQhjnzye4L5PFzbm7xVZablBNnn3CzWrcfUVmv0Sk0dv2zz8r8/zBK8Y3bl/eo+
 bfD1/+C0PL75HaUTzVtsJtLyBgyc4seIrzYxJnOF4vxYlYYfmDybHeqiUh1snrBjanHNEruyjOr
 md4uAvNuY+7/Ak6E6Su2GmYQDga1qNTn8tiDuYKyS8/qoIxPNbIqwTsjrXEVHVe6fYM4HICBlCB
 Y4cOFDND8kG4YXAKZiuEiYZLJd9GP2/kMzJcm+sSJVndHvdWvBE3ddZFKYblbOmw2FC2AMmj4U8
 it9HZ/qA3cuuVfQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

I marked these as fixes, but the issue is not likely to trigger in
normal conditions.

Not tested on hardware, please kindly provide tested-by, the best with
some probe bind/unbind cycle.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      ASoC: codecs: pm4125: Fix potential conflict when probing two devices
      ASoC: codecs: pm4125: Remove irq_chip on component unbind

 sound/soc/codecs/pm4125.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)
---
base-commit: d22122bd89bc5ce7b3e057d99679ca50a72a8245
change-id: 20251023-asoc-regmap-irq-chip-bb2053c32168

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


