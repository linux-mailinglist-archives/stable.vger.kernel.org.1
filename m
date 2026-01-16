Return-Path: <stable+bounces-210087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF5CD38481
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 19:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 229C03044871
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 18:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A54234D4D3;
	Fri, 16 Jan 2026 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFUIXkHd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8702040B6
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588749; cv=none; b=Emgdirw4aFeHuHj78NfpvOC72MGCj42DC6GXGP6Vf2PUMhSNzqoCTVAWqrsLWNpNjPg3lPdGeZRmru1WLT5cdozJWWIIWJdZqKJbVrTiDDucrK7r3iWEoZr1V/DR/cuKDoocefWIEVnG3u7Wa9WgVqMyOcoH0gIJ4coJ4mLkxC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588749; c=relaxed/simple;
	bh=d41syVwVZdKjv7cxV7/aihYb8fxPi9Y3sb0RmDUSMDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKfcFd2Gxrxq/DE5bK2efKkuf33tv5J5G2RP8l1P0s2Er5rzSiI11bm33RRmT9qBlkih1/MDA5pGMoj5n7r2GQATZ3h4WB/55PWC6+K5QPDiISPQFsUR2IZqj+V8tfh2F/z4JBXT2q1X7chKjwElaCWo26cIkY7SHe3IK27gXuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFUIXkHd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so1907229f8f.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 10:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768588746; x=1769193546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtATPDsxWorsaJSHrXqsG5j839hXtsmCTkBX1g557KA=;
        b=iFUIXkHda/MqoaTbXQCrPO43tvTtVMHYPOrm9QU7Q5LrHBNrH7gzLfFTezAiWik7Fj
         uhqGzfiej1o9M6gsFYrlc32cJo5t+QLm955fDlhCi4ClJg7V43Wnflp3jBDxWggtYuyE
         6xTF9LS60E5hiXa9532s6atejPcpc0vHP00q+oeaVbMSv2gGMQlIyOJQT4LGw4A/7rk8
         SfAd0icEf9e39M7EQe6gd+8VNpGFAIWMB+2NcDdqXU0CzyXJ0CKmZwjQRdGQfhMfIt9m
         osHOV/5ahP4fi7rCcaBmMyrqVZQBVBy7RJr6v9fa2bPoHInfxIKMtxAL/YmjO6L/v32A
         4ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768588746; x=1769193546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtATPDsxWorsaJSHrXqsG5j839hXtsmCTkBX1g557KA=;
        b=XmXJXujVONpL7wgExrpp5dqq+FVqkGaF6C+Ki7C4Kg2XpvQnd/2XYW7sbJk4vdB8ZI
         wrpyZrVJqufXuLKHvTUGhndrs4BAHrqFVUGeCC5+Bm799KNONHDWYa14zB7ieVQGAGCP
         1wjgMQto2wCLM0hHdf8PXUhpPOwdJwd998RcAxL3B23Q5J24UI/4ho4AOOWn8wSzzaUO
         GrkPPaMK0RgP9f0ScWAVI5yo2jFgLQJNqSRULM9Q5jCYLxez1BDETLPYAap0gFmmA3MH
         klxpMo+g41N3E5Mp6Lhca1RhaCewf4QDLZuTN1CvwclAvUhJAyXBFX4Un2YNCOkzddji
         kgzw==
X-Forwarded-Encrypted: i=1; AJvYcCXLKdjP1N+eQ7/+DO0tm0cjt/oIHubUDueRex9zVXw1UYgbRVmrY0VSnB3VTYboURocRzHG9NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcm5JD4gIdr1oLOAoHkYI28EJ6CwPXlTLgClebpSkXeQPR08WE
	dSAkm5CocxzKwGt+92Gv1e9H57dRvkr/p5znWbkz6GLzlknrqJcyZZVP
X-Gm-Gg: AY/fxX6lrH+EFQojgzb1SrUYLNvIPZm27jzPCE2t8cXR59ctHYAFpB7mG6Zkbw5lkHk
	+68vz5OxM1Q/QNqLGnSTi17La4brQ6zw8unPIUmATVdrSjHiKemau1CkzbOnjClLKVB86fm4Tjq
	b5yvVkGF86wC3acFFw08WfrlJhpMItTZHDjXca56tf48XZ4MS2E8UjqN2GmaRe+ZNDDVH1e5SxT
	W8h+D/4djtEWq06UGEUmixcRbM3NK4U4EWrhZnp6YHI82WqOr0jXvAi6eCpF1CuWOCOtEF7X2Em
	z1HTFHDqjoIDI2FUOL5um8SCLeisXbPIWkd7TDsfQdxSqKQBJDWt3QO22wdciZI3xMIycmSguLo
	jUgsW1qUp20W0S6HnSm8GLjcSBiybdfsPzewkK2bDln8sVP56Qptj1/OCWrjpGWWCngr+Ovb51f
	HIb7DMFCaH58TRcU2jxA0NV6hoAJgVl3RXAToiAEg4BL9Kr7LAVjwPUU338csu1xju+dwdIOXQe
	1SlCvY=
X-Received: by 2002:a05:6000:26ce:b0:430:f5ab:dc8e with SMTP id ffacd0b85a97d-4356996f129mr5220791f8f.13.1768588746076;
        Fri, 16 Jan 2026 10:39:06 -0800 (PST)
Received: from localhost (p200300e41f0ffa00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:fa00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb1fsm6846449f8f.35.2026.01.16.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 10:39:05 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: pdeschrijver@nvidia.com,
	pgaikwad@nvidia.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	mperttunen@nvidia.com,
	tomeu@tomeuvizoso.net,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: linux-clk@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: tegra: tegra124-emc: Fix potential memory leak in tegra124_clk_register_emc()
Date: Fri, 16 Jan 2026 19:38:58 +0100
Message-ID: <176858859966.165514.1542929598310125407.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115050542.647890-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260115050542.647890-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Thu, 15 Jan 2026 13:05:42 +0800, Haoxiang Li wrote:
> If clk_register() fails, call kfree to release "tegra".
> 
> 

Applied, thanks!

[1/1] clk: tegra: tegra124-emc: Fix potential memory leak in tegra124_clk_register_emc()
      commit: fce0d0bd9c20fefd180ea9e8362d619182f97a1d

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

