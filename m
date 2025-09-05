Return-Path: <stable+bounces-177906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ECFB466A2
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 00:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10A21CC1E4F
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AA927E040;
	Fri,  5 Sep 2025 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wwU+PRLJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA5528505E
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110941; cv=none; b=hiUb03m3I2D0UQi1T7+zajzY3ieSvMvA9ee2v2biY3Wh9uSC7WJcAsCygNfUcPeJqidj4VA4Ixm+M9iXM3msietJ1016bihQyuFQgc33ylDl5p8xuz8LsJ5tChtWuJ4upsGRlFo0Ne4N0ZTCifdAm/3WsVb8vLZn9uQsWL2SZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110941; c=relaxed/simple;
	bh=659ccuPtSirr1zl00uU5A9iv2ysWSzQ97IzY0N3/LQ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MXDu3LoGRJkU3kcFACsaDfgclMjuKEHkuJ9cvQJWIZc1EGOJLkw9Md6JXZXmwcnIvARFuy3z3LaWqpegh955h1aqEBTehe3UE4Fkuh2WrPKtDuKzeXp4rSP9ZYHbppehfHXk1gTNqy1zca3Ka0pz6e2VRsadjDUrmE6ynMihoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wwU+PRLJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445824dc27so26497215ad.3
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757110939; x=1757715739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg9V7A+vveZVwEgb6/4ZFeGTdbh9RAwHCgZXiFP+1HU=;
        b=wwU+PRLJ6cY93mx72ruoWa+plZJfmNDw0FkrC9Uc3/03PufF8FtvLY2XeuhSB7NAt3
         I2tWnWFVUPRcsxUq/PVK2UBRHRpuxjxQyfP/UQEpvy/8DSzilbQKtsbA218l09M6/w6l
         6qhW1vvgFCKC3HKhvs3ye5JaAGeNAsKf/eqvtGjE3dlZGY7TMCIx5CyIzHjSalI6yVzJ
         RG2Vvz6Md/bIq1Vl5O+F3Ai5sbhMUYLfrLGsW6ZRsw5Gh/UVFGasPqglA3KzMN8zBEc1
         eVVza+kQYfInl845IV6eOevZ0hHa3NljwUy7zE2XGTwKI/h/z9ggMrAylUEx6PjsUTcw
         HyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757110939; x=1757715739;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sg9V7A+vveZVwEgb6/4ZFeGTdbh9RAwHCgZXiFP+1HU=;
        b=cjv7jWKBErh4fa8Jsj2+3/wb8rgws6ecrptsp+xSeH2fnbtnTuRxHAlgIQzCuuyaBi
         vgcBte2T2SG7iXaNxAOt8Jwt1jtyzTaL029nClNnLp8D19D+Up7oYCCU60dKDXWNc0qg
         106KzpKcLmS9dZVSUs+qWkrJlZ3BcN7CHC8eLhNu52aFqiL+IXZr4Y+0SP8l2pbqyc4J
         znsu6d7fxmB+Gt9ELUtlD4G0qtUiutzy43XJsABHYskf30PumgJV8WumUKDtiK71x3oL
         UhwNOYNFViODhPXAGS8nB9stz7ZQs6O8jbS8imWEiMxeFjjN7mjn5xGJkrbk4zULwCwo
         28Eg==
X-Gm-Message-State: AOJu0YwT0L9Z/AQ8gQv+eJ3l1mlO8xlyfUFs4p8r9KDNA128P5XVKQkx
	uxb11eh1R3pdyuqITg+8nZjcH8ch3W+wbhlI8r9++ym2qk5ecqREgOFMu2hBSFGkutk=
X-Gm-Gg: ASbGncsZ0hyH4Fzkj+3iIDXALaxpUVntrQzM5cvrt5StPfpO8k+62uqxjNf/glvjPhb
	yrRHr2Usm1yYPMTBmNPAo+lCmPlXIvhAgQd7qJFiYoK2EAhQ+hRzzxCW2KEMlg0PYpG9yskI718
	FothHjjV4Hywx4ror82QG9a5pkKkHQcgisc6RB7hkrxo6AzzWxBg6hnMIbvHGrBm8/M9WVRlWye
	m3f7mOw9JAYaNiWR+/hvGJ+4feyjHgnxwLpw784iGmrtcUeJ7e7Smc07YYbYBfw+iDTJNw3/6qI
	fuHdSXEOf2yrdj9Lgli7vibapPsTIqoNg/Qx2W4wYGb0HjgG8Tq1I8YXirE5yqPFhctMU4YlZ+6
	7KwgqDL5OS9QXAe5dlFWSs9hFkQC4zPk=
X-Google-Smtp-Source: AGHT+IEgDKOlBK6x0QOw3W3CHGpa5Cc8uz1T8qU/XEUIc8y0zuEtK7ONrjwU8Ktw48bTs0lLqjmlXw==
X-Received: by 2002:a17:903:3bc7:b0:24e:e5c9:ed02 with SMTP id d9443c01a7336-25174470d47mr3109805ad.54.1757110939089;
        Fri, 05 Sep 2025 15:22:19 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329cb6a2ec2sm13579564a91.21.2025.09.05.15.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:22:18 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
 Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Miaoqian Lin <linmq006@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20250902075943.2408832-1-linmq006@gmail.com>
References: <20250902075943.2408832-1-linmq006@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: pm33xx-core: ix device node reference
 leaks in amx3_idle_init
Message-Id: <175711093813.666031.2668373270360080348.b4-ty@baylibre.com>
Date: Fri, 05 Sep 2025 15:22:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Tue, 02 Sep 2025 15:59:43 +0800, Miaoqian Lin wrote:
> Add missing of_node_put() calls to release
> device node references obtained via of_parse_phandle().
> 
> 

Applied, thanks!

[1/1] ARM: OMAP2+: pm33xx-core: ix device node reference leaks in amx3_idle_init
      commit: 74139a64e8cedb6d971c78d5d17384efeced1725

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


