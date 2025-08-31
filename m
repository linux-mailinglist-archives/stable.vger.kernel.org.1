Return-Path: <stable+bounces-176751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E918EB3D288
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 13:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3FF3BD01F
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 11:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD6E258EF0;
	Sun, 31 Aug 2025 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ7DdF+w"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC311DB125;
	Sun, 31 Aug 2025 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756640196; cv=none; b=O+DqyBMg1FQ/MXf3USJ5s/lUOldGJdo2+WXlmn2JDrYmmwfgRvJ9kqZxPAPUOz9qKs6NSkkSrSugNw5plRMMmnjSr6262Tf9pYQlcArGkug79ozR35EqLtYGTkS/4EoNP7U7xIdwtMDHLQElLz23TkdKzn5mKAF8EvKWUYjyJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756640196; c=relaxed/simple;
	bh=LfoZx3TjTj6uwJ1O/VBARwGIA99pc3EHjHaCgfE9NuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICsEN2JkZ7iB9AWk61Ttahq7t2msjJaFp2QOxwyuAnzDbjrx7hzj8fsfd53akuzuJaMkapGJOUIbeReWDYtWfpE74Cj74KtFUDkV7IcWTAAT7WwQYWcLDN7XBwjPGlFYgYaix3BvhpYhOsgm0/0VRFgnMigcmqakDYZh1HBz5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ7DdF+w; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70dea0c6759so42776356d6.3;
        Sun, 31 Aug 2025 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756640193; x=1757244993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imvbS76XoT7vPDnoNBAMw6pY77bkDW1TJhU+1nyBJGA=;
        b=MJ7DdF+wmZbEc5br/TVmnCuBYkze9zYILObGS2fYLI9T7FABbQzDOWCuJcoZ6JnH0S
         XkBB1Rkl7nOY0ehR1+bgbQ55GP9HMNXF47jugM9wBFaT1du1ZLddURadoRBCVPMWX2y4
         99Q3Ji88TVFKb/N3vmrrkWWVWKBvsrLLUoaF3m4jSVU8O76dfplcJwObS5UJroej3wRQ
         2OhgGBNaE4F0yTEzsO0W7FjyEkJ90m9qMMOgWOsXNKoAf9WrPdPeX5APoWY6OKap7FBV
         QXJvGpu7B8PeI+QY/m6veT6JSy0j3R8xRW4aITY/etuq7ypzU6LSl+GtB2gqp8ncuUH/
         L01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756640193; x=1757244993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imvbS76XoT7vPDnoNBAMw6pY77bkDW1TJhU+1nyBJGA=;
        b=SifvPWYOoliCiJlFEN06nqByLh17Yu4R2nbSE5CXYsn5DuV4LifX7kmpw4nAoEWvW6
         v0kyF+5eDqtFWxnj2pema+OdSgh4qIDiqoBQlGavEhybIirZ4JX5iqVrNtbm9OwzZt8x
         dHNPP25BnPzNTUmGsxYo5LVKIfUE4L0iJ/zadJPMex+aBvyR4p8F+3wYxBRWlVtf4Qai
         waEdUgM/fiEKLLWZ1i91HjhbPP9I84SvJoo0baVeC4DNouo0opNmiWU7VIpxN+VZZ4wZ
         ExwI2Txhz1uPCvU8z2Rm/nTYoF5IWLyZ4fjsK52EsU9kQ6Cv/upINXrJfir4yvJgv+Na
         hTBg==
X-Forwarded-Encrypted: i=1; AJvYcCUrY3s94/A3AAwZ6r67YWVUaBfWWn4vv9iOClDc9p5CXOhKYYdldh+cAQc0tZs0DhnHah9PEQBv3FCZLJZg@vger.kernel.org, AJvYcCVD9ZtafDnfTHDGBKj7JuYgvDpe7qW3C2P81gaM58KBnIDZbmRy2tGuUhO2NLoK9TbMuungxC3+@vger.kernel.org, AJvYcCVgKuM8FjGDG9S6PvC97+STstTN0Yl1b8jFmDrjpKSDrKF9S7FTwVi0A7OrVPYvqq9XFNfQ9ORAjJ9m@vger.kernel.org, AJvYcCWrMdhtHGh2J0wNWxUalT/3SZwcQTWf08Mdm1CbNcH+7u1J6KMM2BuTuHamhIYfY9NfDgwpEmq8Zkoo@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0cJ7RULKm52GWBhVngNA1O8Jxdwv/gOxydTnQqwsRl4WgLIE
	KDDIq1Q+DrrKAQLecO3z5jNzAcC+lG46oc/pkQfdDw+ni+gBZTjPj0qGMQX3tjyh1KI=
X-Gm-Gg: ASbGncs1u4Q8BpTo0wjo9WIIKY/szCv1+K6RHA58b9v6UGlcQIzY/VTEENYU4h/Kta0
	1Aenj+8OYS+pxtSlca55RGJLAEeHXAY5A11hw/sPlNPbT75/V2N63mKn642swKGqg7LAXX+CV3o
	59UJdPKLtojH3qtMnlE23uCbwef6s+0H7fO8cIJ0jw1WdWFKDGMS6GWHFY1Wg56WrSChLlyr2Ik
	gFZYMM9gGHSAR3CgmrtJB9kA7oWXK+pOfH+GhJrDvmUgz6W4GRBETtsemviPSqt/RcFdUlhQOKW
	zwIordL9Zh95M988umemTv53V9mk2t/Qur/3dPoflg1CjSz/ITrmkxTob3Eke5EnV/teb+miDqw
	Ijh6uPDFrR9rF0C4XLoTvsFC85EE6i3pN3YJLJpzWz+3BdAW92Rjt
X-Google-Smtp-Source: AGHT+IHV630wqWGffYM6kShz7/qTYJvqOJRnSYz6I3w0weN4IBkM8Q5XyHS+gzuNT6ATIJlJwAut8A==
X-Received: by 2002:ad4:5948:0:b0:70d:d4d8:d3fc with SMTP id 6a1803df08f44-70fac8d3491mr45266476d6.46.1756640193195;
        Sun, 31 Aug 2025 04:36:33 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb28383b9sm20519076d6.37.2025.08.31.04.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 04:36:32 -0700 (PDT)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
Date: Sun, 31 Aug 2025 11:36:26 +0000
Subject: [PATCH 1/3] dt-bindings: clock: exynos990: Add LHS_ACEL clock ID
 for HSI0 block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-usb-v1-1-02ec5ea50627@gmail.com>
References: <20250831-usb-v1-0-02ec5ea50627@gmail.com>
In-Reply-To: <20250831-usb-v1-0-02ec5ea50627@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Denzeel Oliva <wachiturroxd150@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756640191; l=1077;
 i=wachiturroxd150@gmail.com; s=20250831; h=from:subject:message-id;
 bh=LfoZx3TjTj6uwJ1O/VBARwGIA99pc3EHjHaCgfE9NuY=;
 b=uLgDqC52/VYRAqkLs2JCoyEBud19Hv2fcWbUqQ6Rv42NnR1elkkUsxTwEF8CdS8DYjgEfI6hZ
 jnzGk50t/WPBvRxvltHhT7a9FhhOvTIoPabcMi47dkWersyeSL3KlXO
X-Developer-Key: i=wachiturroxd150@gmail.com; a=ed25519;
 pk=3fZmF8+BzoNPhZuzL19/BkBXzCDwLBPlLqQYILU0U5k=

Add the missing LHS_ACEL clock ID for the HSI0 block. This clock is
required for proper USB operation, as without it, USB connections fail
with errors like device descriptor read timeouts and address response
issues.

Fixes: 5feae3e79dbe ("dt-bindings: clock: samsung: Add Exynos990 SoC CMU bindings")
Cc: stable@vger.kernel.org
Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
 include/dt-bindings/clock/samsung,exynos990.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/samsung,exynos990.h b/include/dt-bindings/clock/samsung,exynos990.h
index c5c79e078f2f60fdb2c0f61ba6e7f3c6f2fbe9f2..c60f15503d5b18b11ca9bdce86466512dc933901 100644
--- a/include/dt-bindings/clock/samsung,exynos990.h
+++ b/include/dt-bindings/clock/samsung,exynos990.h
@@ -236,6 +236,7 @@
 #define CLK_GOUT_HSI0_VGEN_LITE_HSI0_CLK		20
 #define CLK_GOUT_HSI0_CMU_HSI0_PCLK			21
 #define CLK_GOUT_HSI0_XIU_D_HSI0_ACLK			22
+#define CLK_GOUT_HSI0_LHS_ACEL_D_HSI0_CLK		23
 
 /* CMU_PERIS */
 #define CLK_MOUT_PERIS_BUS_USER			1

-- 
2.50.1


