Return-Path: <stable+bounces-106687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFFEA006CE
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 10:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0381612FB
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F651C07E4;
	Fri,  3 Jan 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="aswxTjXG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811521CDFCB
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896112; cv=none; b=FQVoY7DhwU4JFGtml2uYRhXm4K3PEVW2LB/7PfbOeFxEUd/eOggl4bxnQbk+FWJDuclKDrbng90H7MvH6VmGMjEY/tUwmIcer2S+sqhzJ2QgEIeHJwGr2FDhAw0Jr7R9JuQ6Rmyv2tTHzjxgfxRGT/U26stkDsLvDjJS1cnb8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896112; c=relaxed/simple;
	bh=dgmlLrpBpnhcVRatzmA3ElIe9dEfB/vT6wgPvY7RCLQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CpJ/XRQy5nh+9Kx/YwHvQJwJfvHmeA2ZsnZJUQTog3OsVOoySmTkk/VhvxERg7fir6DQpnqcpwbut9LLqx3p2wuamPZlSfD5JMGm+F3/0cmhdJ+Y4tCjOHJV3QgGGHY4xBiMjNkapa122xf5X2rjg6yVSMhaYczQstmAiC4lXEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=aswxTjXG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso14854905a12.0
        for <stable@vger.kernel.org>; Fri, 03 Jan 2025 01:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1735896103; x=1736500903; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9kNqfgWGfkfVt/bxXFgxNqi23umuLOBb02EY+IZ1jc4=;
        b=aswxTjXGLxzjoLMW5SHu4fVmkMiVljtM3OkwajI5EQlnP0VHdW6LqcvIHGjrVt3s0/
         BhfS3eQjR3H06pVAQasQFRkn36pYZ9uspuxqMcZbVN3ShbPYcmVUuLSDyiFEOR+oeMPy
         zYTXJ2KHNW5ttMK0GG15UwyafN4h9hZG/n3q4gBHQSn6bi8NPQNT8FLNdEh+17yG9qVW
         /GATNzZ9O2iDHkhykVKyByUWrE0AMRez56K8uHzEhgcc08xmNxs2z4iq7J32M5uq0YGG
         xERD9oFS1cpRD0mFG214oBYEVlAwXPC8m4ZUykljDKJM+R1hw/cYHRHEqEkd6tInImDo
         mLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735896103; x=1736500903;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kNqfgWGfkfVt/bxXFgxNqi23umuLOBb02EY+IZ1jc4=;
        b=MI1FwwrG4Fh3VY005SlfjJF62bDJzf8MJ4U9nllw2CFGOQOmzv2cGcCM7M9QROzMjA
         KQ6zGPUPWBbBKKyYwpFcxqrd2knRhLKXxZvQ6g0FSHwNCK/L9He2fKQm86KWftDmzzQQ
         gQ6aBy07Q2l42g0FO5RKsl0WhlRhev9DKb1HU21VWWtFGXMtNCC3KyHcJQmnTS7gip7j
         /pYEbFyPPtb7M0ZNaabE6HKLO317j6Q43gXaxb5eCEi6IEiUPKj0I2QJe7aqdI97Dqra
         v4dQO35/gYYj6RMzGzr1/rRfUV8r8NVgyOx5axmnFTCeTmDBdVsxii4rCXdarwAtXW1Q
         P7fg==
X-Forwarded-Encrypted: i=1; AJvYcCWRaMbmFURXNPSDKFDZQoIjNivnwFgYXDUhlgYlX5tVbXtQul5wQtXwSFEKUnq5dXHOx1LRpfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4JY0B24Tq+amcWCtxbYhQkr9HDGUtPd9gB6awthVB0Vsik3Nu
	I10g/ay77CSYw1fq/luAKTOtQ7wHYVlH2YBY0hTPy2f0S3t2ZSnSQMT0FKiyTPE=
X-Gm-Gg: ASbGncuJ+sc7iQ1m6h/3UDFiU6an6+xe07d4iIXHUaftH6LmH2rA1Q+2DfRSU3EW6CD
	fEo5HXruhvjZFywjVYpTlI3FsMZC+JvN5syXYf0qEz9X2xboxbvcNKbtIVvEe1pWhZbd2IrxOzl
	WBvrLoodhTJrJQpdFnOQfKnHSLC5JAOCUXooo+BS2yZXDCtWOaeM7cDdwwl+p+To9x+ZYf1g4cm
	WOla0DDqJxAL71Rpu2CF6AOeLFSpCnTQxkHstcRW0ic4NZVaU99AOFz8DCculZT1/4lkj9MI4BD
	3kI4Jxs9PSw8XhoAJ+ybZoxa9w==
X-Google-Smtp-Source: AGHT+IGu1+xTSi3G3Zc/mqzPzvlJdEDQOTlLhsMMlE3lvBvhvdWDIBE8fThcf6LjLSwmrDncRUMvXA==
X-Received: by 2002:a05:6402:3581:b0:5d3:bc1d:e56d with SMTP id 4fb4d7f45d1cf-5d81de086afmr41880660a12.31.1735896101632;
        Fri, 03 Jan 2025 01:21:41 -0800 (PST)
Received: from [192.168.178.188] (31-151-138-250.dynamic.upc.nl. [31.151.138.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f0e4sm19235306a12.42.2025.01.03.01.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 01:21:41 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Some fixes for Goodix Berlin touchscreen driver
Date: Fri, 03 Jan 2025 10:21:34 +0100
Message-Id: <20250103-goodix-berlin-fixes-v1-0-b014737b08b2@fairphone.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB6sd2cC/x3LQQqAIBBA0avErBsYi5K6SrQwHW0gNBQiiO6et
 Hx8/gOFs3CBuXkg8yVFUqxQbQN2NzEwiquGjrqBFPUYUnJy48b5kIhebi5IXuvRTWSN0VDPM/M
 f6ris7/sBxta0DWUAAAA=
X-Change-ID: 20250103-goodix-berlin-fixes-0f776d90caa7
To: Bastien Nocera <hadess@hadess.net>, Hans de Goede <hdegoede@redhat.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Jeff LaBundy <jeff@labundy.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Charles Wang <charles.goodix@gmail.com>, Jens Reidel <adrian@travitia.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

One is a simple comment fix, and the second one fixes a discrepancy
between dt-bindings and driver, aligning the driver to match
dt-bindings.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      Input: goodix-berlin - fix comment referencing wrong regulator
      Input: goodix-berlin - fix vddio regulator references

 drivers/input/touchscreen/goodix_berlin_core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)
---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20250103-goodix-berlin-fixes-0f776d90caa7

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


