Return-Path: <stable+bounces-204911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82529CF57E1
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 21:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFF1730A7C22
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8BC3314DE;
	Mon,  5 Jan 2026 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lrM8fBzg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994513090FB
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767644163; cv=none; b=p/DIVq7Vt50zIQCMkM1qRj9mKnMtO7ozZzljc/+Xpo6NajSRBPVuxngAU4EQtbttiJnJ6mk0ynbnOs0cg5FPzvRMrHCbqCWMFj34STA1+Qe7ZsRg7GaP8Ni8NubgRpRoyxeAf6tQBD9eEIlsmTf+d8sjE8UuhdMRqTUVLNoZJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767644163; c=relaxed/simple;
	bh=GlAGxw60887sAVyf2r1P8gsyI6ZDN3dTFENSsBfZeRc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FgJfdb3Dd8+E0nA/A2MHVIzyuZ9y3pvuZXxhEpWS6egZ5LLwsLhyLciVA3rYRnMf+pNTbqPrYT1M3gDf5BHOTVjSskx3G/VNN0JDUpeZv/3Pc2IO7x7C7iihvccK7TKFwAuOh1mg0/ZcVLq24phTR6oS9A2NXo5stMYPFlakQzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lrM8fBzg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so300360b3a.0
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 12:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767644160; x=1768248960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZSZZ0NcHIRuKJcx81Mh2IbInHyMIKpBF4sIqpjFN2E=;
        b=lrM8fBzg0mP8LvWc99uydqSvaZKMe4TXqcPBJR+PmMydhJ+yCbBV7QnqioTGPSF1E9
         TQCBvW7cWFDkNzTfhG97dzIdVZjBm4AfuNyNH/k35DtfEROf9AXXSDfWQtypagGgeGvW
         D43xqTTuHnd8qnepmJiii4BdsnFTEe1vFTOvYc8qberS/TIunFh27eXdSz1oegL/zdzj
         YZ6klUjPsTjrxnGJjz6zz0sf0jkFBn7wk4i8Ok87gP+0BR29g0peMO7tD4s7BNVZ/Rx0
         DZT2xEnzpZhw/MN2X4d62gjHJr0Y2kDiKgn9iMiYBvYwi7hVfm4BDXdrlXYorCs9eE+J
         4xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767644160; x=1768248960;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kZSZZ0NcHIRuKJcx81Mh2IbInHyMIKpBF4sIqpjFN2E=;
        b=SBNzPMObiTPawss+Stzl8n0mOrvSVdeO7qhsksUkZ+Jihq2DcDKr0WE1Mz9wgT7Q0+
         8fwXDr4QqRz3COQA9fOqDDohGJ+Z0GPd/jjnYZ0voCI8Xnc9sUIwVwEk7HEnj07QOV/r
         Kqr06kMqqEIPuq1mMeonY/qb+kON2dvsc25StlIDZ/2yKXGfkRbtt7kXBoLyeR1Ij02N
         nWCjBGvvmwS69PzGrCTgkcjnpBXPG13YAVK2Fck3svzt0Sds2FfKarx6Z1+yb//qt++f
         bMybAofcGwicZ8Ov25Sw7JLBs6RUw/pMchRPHaq9/TpavT5QqLnRvL0b01zDibJuDtR4
         2gTA==
X-Forwarded-Encrypted: i=1; AJvYcCVmbK++mwVbrQKe8Caqw/oYi+teYjSY1DIY1CZzScrQtCo4xfyGXwaJcL/fRPLQrapffGf6KaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6y12ys5kDqtWy8Qn+CMUURu9LoS+p9wD50ZhykoAallGSgzX
	gD3b9eIn+7LmzQm/PLWt4o4JHD3Ni2lpzqr0xQK9+f+uEwj8k9kkzXPXxGJiVSuqssY=
X-Gm-Gg: AY/fxX6gcAZpgfdgdzpHC+53iHq0Q2k5s+f3fMXdOPcsgm92cZQ62SDPDfcTfQGqSsG
	kChhqLyBGwoEim6A3tusRwI8qXiYSsKApAwiymT9jVgSe/0zwSxhMmeFdZ8zzpMuQYC5XvwWkEX
	luVwgub3Kj/EggzgnZ4ure5bpPBZXQRQ0PfrGdeJ0VRlJicc1ZqjsoxdQmHeDVSW8173Qt1q2Az
	kkbCY5kBmZXqbtffdLBCO01aAxM4wT/aVofhWBcrJDSDIUYAOkAb+tj6VHCsQ1uRe8Igh4LL35M
	YcQ/d6YjDnlLOf2b2Lc59K3ZlAILwnqetjafM5xLSPbxrC6nMKsDoyH2IMK8+MPhvw6IDldtfzP
	/6tVBLy640fbBP0ZVAqEu6lymFuROybzhLoG2fuLeiKg2Zj6M4Q53nes0corJKgsZY9JL/aZKGl
	J4Mho1aizU
X-Google-Smtp-Source: AGHT+IEHjjpFYWzc2Wq0J1oiLBzWArBe54oz0YlfSqH0xF0+40Jt6FjOez5/4L3fR9/GkZAWrm4pOQ==
X-Received: by 2002:a05:6a00:430b:b0:7e8:43f5:bd59 with SMTP id d2e1a72fcca58-81880383fddmr689923b3a.69.1767644160587;
        Mon, 05 Jan 2026 12:16:00 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5302c61sm22217b3a.42.2026.01.05.12.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 12:16:00 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: aaro.koskinen@iki.fi, andreas@kemnade.info, rogerq@kernel.org, 
 tony@atomide.com, linux@armlinux.org.uk, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20251217142122.1861292-1-vulab@iscas.ac.cn>
References: <20251217142122.1861292-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ARM: omap2: Fix reference count leaks in
 omap_control_init()
Message-Id: <176764415968.2561401.11587667060875531413.b4-ty@baylibre.com>
Date: Mon, 05 Jan 2026 12:15:59 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Wed, 17 Dec 2025 14:21:22 +0000, Wentao Liang wrote:
> The of_get_child_by_name() function increments the reference count
> of child nodes, causing multiple reference leaks in omap_control_init():
> 
> 1. scm_conf node never released in normal/error paths
> 2. clocks node leak when checking existence
> 3. Missing scm_conf release before np in error paths
> 
> [...]

Applied, thanks!

[1/1] ARM: omap2: Fix reference count leaks in omap_control_init()
      commit: 93a04ab480c8bbcb7d9004be139c538c8a0c1bc8

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


