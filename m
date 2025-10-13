Return-Path: <stable+bounces-184203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01696BD24FD
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47393B83D7
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0603B2FDC3A;
	Mon, 13 Oct 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnx1SxTk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA02EA46F
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348103; cv=none; b=qpjRqOrosDcGod/W6uYBYAyS0C2rBPSkwbA6GEnUStVP3MMqTe7y7BOi3csHEcTLvTVartdklbv30SUb8NrdsovYe0GOuBHGPPQYVMH35LA0PxuUyx4l6yKprPGLwJKuaA4/Bn8KDQx0+12fAJEjKeRoZQVmeJCEE36xVVPwdEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348103; c=relaxed/simple;
	bh=h/7JTy6TbprU+dCtnUq5sVaFosiidQqOxR/pPvZSvKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vFCtYpF2WeJFqPytoiPS71BAGpgu4viaWSI1fAPRsai3crqoFwDOHY7tW+hFVMb/DEIr6nCGisCvkvTEej5qUSsVB+qSXxHlI0QU+ct4uIZ3BHk+hsEGbCmQi4zm1iSFTBNhUkTsCC6ePguYWvFX5+II+8gEKqQvCY9YT70BWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnx1SxTk; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-781001e3846so3913131b3a.2
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760348101; x=1760952901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5bKclxFecJJ5GNJZlIb9xGDoD2UnMroqAQc+H9CWag=;
        b=mnx1SxTkrQzHYji3aeb3q4OJ91PiRt+A7UU+c/8zJExuePN2QeB0IklJwTH08iodb9
         88kDaaj4FBNqNOtBTe+OejuT3GlNCJcZwjgASUnCU4a0lR1yY7M6QZR6UMYWSiSh5+GO
         Tx9y1tJ+iZiuZITt5suiuPdQ8g+j6ane0nytRhF/zsYd6TqiinT29kbbjZ70akhtMZz1
         gFItwEi5eZMaL56EE8dNlJGvP1yNkZmlgkCw3CxS2OJ+o/H2ayhEoUVgXk9QYP8jfPEG
         9VDEIuB/nihlBX/vMp1CSrmHCqgPinTh+LVg7YqCqf5zQyg0oGEC9NUJm0Go6V+SR27i
         L8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348101; x=1760952901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5bKclxFecJJ5GNJZlIb9xGDoD2UnMroqAQc+H9CWag=;
        b=hBCF0hSxCd8065mYteAmRhOEggfMNVElqvTDQdRRi6HvyYtrygX+ViBJdmi3IKbApi
         adQZr5warP/mYCVvV9Wrsd1Fk6HH50ILHZGZ+GLFR5yiscq04i/o9+uxXrD3wPh4lov3
         giDoXOx8bUy/hqsAFIT6Rdtu3N66MWf901pXreJIa9aef9HlpvcMBDzCyv3/TfVP5NHS
         kynG06dmUe+zklwUFe2KyylayVOUexM53GQvxjXP92Ayr4g5WJPGTcqR++fLj5yK2Ipj
         YNBOxIJ+zXZfqoO+0Il8Bzewswz04I1sgbXBBxnQ6JliFuNYCDHt+Y21B0ZfIJPkw6Om
         PU2g==
X-Gm-Message-State: AOJu0YwPEEoaDBEN6auIqBGANk9Vt7RGWTCOIs2QWgs/VSZOfPNev/Cw
	Xscj/OBVjwx8WJoNiG3By7qJuGkZfNKjXqhAKWvO2M7oVmTyUCve5r5WDo1XJHwohT83Ow==
X-Gm-Gg: ASbGncs499IUX4Hfl7LtOFp/HiHg5zSvWxrsCmRjqvNr+37uk37N+IJ7S/EMG4uj2ph
	AHSKXXRmndogSHiKCNpWkI0Gkzq2cU/dtwtdnv+FYqKZP0Ow/I/6jfZMNvtkHi8toMWy21/IZy/
	5q/vJ/pBy5JBG9+xvqJ6cwKeXSDkVX3GcaWNg9TnfFf/SF5OgT+ELhENbBQSwy7kMfJE0n/s95e
	SpqWrTlzj80kL7FJMU3f5deJajUDDx2rjp70ynpoUT2Usb3AtHD0MEPuC7V3qnDepgSBKZPnoka
	Q+AadP6V6V0Omf+Bq2mmdORWhOPIyZJOWiS5QbcvNoB6akPIuMRhaUoQWdQtNAvJ9gO5g/7+poI
	ZDpgtHLsqgxMjMgXETjhndguj9P4iC3ME3L453qGs1aWQ36u6xsGM0rID66A0WTdoDojarptGDQ
	==
X-Google-Smtp-Source: AGHT+IGPAzAetlOptAzw9GaNxbD3zKkFT2GadJ1WyMX5hnKkmmcKAsypxbC/VTf8veeCOAjENtE2yQ==
X-Received: by 2002:a05:6a20:7291:b0:2fc:a1a1:4839 with SMTP id adf61e73a8af0-32da80da6dfmr27467709637.10.1760348101035;
        Mon, 13 Oct 2025 02:35:01 -0700 (PDT)
Received: from LAPTOP-PN4ROLEJ.localdomain ([222.191.246.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df952cbsm8693944a12.45.2025.10.13.02.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:35:00 -0700 (PDT)
From: Slavin Liu <slavin452@gmail.com>
To: stable@vger.kernel.org
Cc: Slavin Liu <slavin452@gmail.com>,
	Julian Anastasov <ja@ssi.bg>,
	Florian Westphal <fw@strlen.de>,
	Simon Horman <horms@verge.net.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org
Subject: Backport request for commit 134121bfd99a ("ipvs: Defer ip_vs_ftp unregister during netns cleanup")
Date: Mon, 13 Oct 2025 17:34:49 +0800
Message-Id: <20251013093449.465-1-slavin452@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I would like to request backporting 134121bfd99a ("ipvs: Defer ip_vs_ftp 
unregister during netns cleanup") to all LTS kernels.

This fixes a UAF vulnerability in IPVS that was introduced since v2.6.39, and 
the patch applies cleanly to the LTS kernels.

thanks,

Slavin Liu

