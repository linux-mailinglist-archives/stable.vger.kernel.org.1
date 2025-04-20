Return-Path: <stable+bounces-134751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A9DA948D3
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E574A3B009A
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4341D20CCD8;
	Sun, 20 Apr 2025 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSrHlgmA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6C1E7660;
	Sun, 20 Apr 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745173690; cv=none; b=Kb6hBPbbvaVn8C3EZuH4E8bBgDv613fP1KgqzEwhYACJW4L9dPBSoMwuqmWhNG4Csm/yEjP6C8cAEod3z+tLO7F8BHCEDuehqVO4O+IoY1HtvB00BX8iRii5HyAfohF6wjIV6/eODEX4bllk+g3mHLdWvs4w1QODcpUAd3fGa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745173690; c=relaxed/simple;
	bh=A28BMqEM5XRskObtd5FGXGO5L9lP2inxSmwMszehi4I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eXjJHPQG1O5fCGPZ5NP41oiM46EfkJ15I5jLQ9uCaGnwEHkMiXwonRzM1SqnHbFfYgBlS/Si7hB/iYJXFBRHq6OKT15b77eetwgp61VP7zhs+wuVBYmmrwuqXLhy+x9SIU6/uivanj/RpAyRHRzaTjWzsp0kDYa2+6yAojKMJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSrHlgmA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224171d6826so49072325ad.3;
        Sun, 20 Apr 2025 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745173688; x=1745778488; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+trkXrRRKx/OxRun+UYOcpJ7PjoXN8nrk3yxYTiKZ1U=;
        b=TSrHlgmAPtKmYGXLgG3HZvkXraqmeOGOVGvTKC5QDRxK1vq3vg+W06SV6MppfSA7Yr
         6xvUB0kYppPfo6hsj0JC7D78rQDVWu+H6QuPRhux9d/8sOgSIlwotANg1omHqtvvegLN
         SxmmH9o9U4oiSh/dgMuSPvd1WGJRFaSH7IznJ7nC206Fv6182LR+mvy3fTrmtShD0ql4
         pc65jieEFJG3bjH6lcFEVXtvy3lAjDRODGTX1pM1cEAg7zKfuzNkfh3B7cDZq0TlYIyn
         HNlP6QrSqykFexgYHptmTxt7Hih4YVlw5vZdoMuTqmh8mIbg3hk9o+AtR3c0+HImVUYd
         4HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745173688; x=1745778488;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+trkXrRRKx/OxRun+UYOcpJ7PjoXN8nrk3yxYTiKZ1U=;
        b=RWLVHrdvWBYXzEZ86NSpgbvu/epEYrDMxdGQnMfQ99Yp4CviDljzrVZ4mSYmrV0JiX
         2cswUjmrS7Wl2Ark+qMWIdPes/k0IA6bhZT9T7Zyd3wvELgck/AX/8Wb5Av/KqQB/2hb
         VdJSuqcW21PfNszGkpH8j0bLPmPi2x4FoGsDvXH0W6lcoNdQMm+cLUQLDX+Ho+7s0Oxb
         xWgNRLC/iyYi7RFmpcLebOVc6gb/1wmw/yjn+spmGlQS7Hmm9R1CjChEEajmm0J1hWvY
         6dEy+T4SrK+By97uBtMm0Wx+atMZDrblw/ltqcqRE5m8yJH1LDyd1C11ff+AlgMZJzkQ
         yI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFkzLKcWQAqq9U1WRwXxpQMZHGplXh/qxeg0+QXtgz9d+WEejqqbYbqmUq92DVw22v3Oxfe6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXqMWZH3RiadeqKWZkCiNHhWjBFaGlDxL+M5Ly0KZx1AVK77rb
	b6OYeR+JmLOZOzNRd1KXhyOANavA5aN4kncvpHg6MdmZJ/WZEwAU
X-Gm-Gg: ASbGncsIeJd8GBVFv3Csb0UcMREgBaQg8265eBLkKhqEGfTN8ElgXgixMfK1io7HURj
	shQMQZQQ/HlDLIbWz4sXz8UdVpf2ISCNMabIQPAuDS0JJPL98DRtRppiXkeldFbeHIYY18+61Ng
	+FJkArUi7jVvZamMPJnPcsMoM2Y8pkKfeLkA0raPr1FrjHz9emXT6aFA0IgJghZkoRcMIFxHkz1
	5ErSDuX0BhPaAWngiQCOa023lI0ug7KuX+CfgvqZmPhELziOPr0EqsNPIkTzeRfXH+lglrjHpxq
	bQ71WPW9XbMzCFEHrE6g5KYShFJBjDsuWxjKx0eKQRTaTOs/Qb+UElhN9sWb
X-Google-Smtp-Source: AGHT+IH0EqSLhfnWbXQaiPgwk7p2UenbM3xRhJcGrt8wqTu+7alWiNw+4a2gxlWYtHrDCTRU/DO+SA==
X-Received: by 2002:a17:902:d4c4:b0:224:5a8:ba29 with SMTP id d9443c01a7336-22c5361b3afmr139842215ad.43.1745173687971;
        Sun, 20 Apr 2025 11:28:07 -0700 (PDT)
Received: from [192.168.0.6] ([2804:14c:490:1191:f66d:1f0e:c11e:5e8b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eceb74sm50550055ad.166.2025.04.20.11.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:28:07 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
Subject: [PATCH 0/2] regulator: max20086: Fixes chip id and enable gpio
Date: Sun, 20 Apr 2025 15:28:00 -0300
Message-Id: <20250420-fix-max20086-v1-0-8cc9ee0d5a08@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALA8BWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyMD3bTMCt3cxAojAwMLM10TY4NEM+M080TL1CQloJaColSgPNi46Nj
 aWgCG/JZ3XgAAAA==
X-Change-ID: 20250420-fix-max20086-430a63f7a9eb
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Watson Chow <watson.chow@avnet.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Hello,

I'm working on integrating a system with a MAX20086 and noticed these
small issues in the driver: the chip ID for MAX20086 is 0x30 and not
0x40. Also, in my use case, the enable pin is always enabled by
hardware, so the enable GPIO isn't needed. Without these changes, the
driver fails to probe.

Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
---
João Paulo Gonçalves (2):
      regulator: max20086: Fix MAX200086 chip id
      regulator: max20086: Change enable gpio to optional

 drivers/regulator/max20086-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 6fea5fabd3323cd27b2ab5143263f37ff29550cb
change-id: 20250420-fix-max20086-430a63f7a9eb

Best regards,
-- 
João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>


