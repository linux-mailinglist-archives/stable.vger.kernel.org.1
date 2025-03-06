Return-Path: <stable+bounces-121292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA2CA55461
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384CA17B0DD
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCAA26BDB5;
	Thu,  6 Mar 2025 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKgYoExK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4E26B0A2;
	Thu,  6 Mar 2025 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284493; cv=none; b=gyOxxsqTCpdQriqPA6Q07DIImkBD7EoLVB0ZysiwxL0bPNU/x+Vx5+pSlCBdbIo2sxhgyV9QYcwDx41aMFAmghckEVvTYUGAG/WP/EC2vO73x97b+JrMs7GTRxlZUs3+c2pMH2G+A7OS05u58p570z+6oSxNVp1yZDqKW89L/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284493; c=relaxed/simple;
	bh=j06EL31i3IPFuTmvGwiP0spu12Gs946czl/F1iE3NA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8sLvsd8O2sOWNrmDcKIQg5t+AKhh4bdIShQrdQX6xqCow5Qii2eoVDWgNUMO4gPXkAl215coXp6Hy0ZZhTdk8dVUYW2hoEiidX8H6wSBDAYw1fcovXUGCXTGxaJhurQ/27rV9aroeCytdjXBm0ErBbXPrFWS4L7FkfCx5HwR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKgYoExK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so11864865e9.3;
        Thu, 06 Mar 2025 10:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741284490; x=1741889290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbZ7rV9PIZhbR6mjMktwzWQBoJPQWYVRr14tM9aOJxE=;
        b=SKgYoExK8+lFyohMPSopbbvkN3QDt5r8dpgnDYtMMGWgzI4W0jNNbzQ8qwvmCwhiW3
         VMBxxiGlDcJd12L+iwLgAflDyIiSAhO9ENqWlF7eK1QThBGtRJ6+mBGByLEmB7mKv662
         exJP0GQTycBcJPKG/YF9gDcBD0aWDwNMUANucKb22AUHgDxZiDkXbQK9zuYsFvQ7hN7W
         sC9CM0trrPpSf8qmJNmcLzC+L+DUH45/r0TYeaPC6Ei14P/vnm35GoMNgbSbGSN2LwxI
         fa992N3/GmHDPHYj1NjG8sP5Iisp7A5TibUI1SyejYca2hWzuNkdpRHbsfMTL0m6QL6B
         ixGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741284490; x=1741889290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbZ7rV9PIZhbR6mjMktwzWQBoJPQWYVRr14tM9aOJxE=;
        b=hlbU5Fzg7hnE2xUGv/J4u7Ic13uPgsSsfQ+er71yoWhN2QlHbKB5V3a95JfZDUf5pE
         jeD/sOhe2dre919ohvWGVBSXz+ekC5ZrhGNxgatQL7KDZkd56GG3RXqSenxlioOJ03FU
         fxMcRKLQef2RrOV/05So6NwRp2pymvZshBfY2wCDUVu1nnzItBs7BYAMLp2PLVwjJ9BI
         uCuSWoMqpJyymmpXuK1R/IE3fuQ+vkODU7mclsQ4k88LqV1k3YTZQz+VecGT7gk8eUGE
         B8xeNnY87XOocOX7KjwDLRu2yJv8Eks2Lk1I9LpgwQcCvqUzkIpuuQLyeDmBImpXc9aX
         I9BA==
X-Forwarded-Encrypted: i=1; AJvYcCUELXPobPgVU1Q6cATVWTPhtmy3KirYUPKcstxWUgRHJVB/jUFygawGaPS1nbHaZfJNBi35NMmH+dwSy4Y=@vger.kernel.org, AJvYcCUmgFVdtlPLWev34QCbHkZrbBtnVtk8ef0HysmDMmgI4akxrT4OU62w7XSsV4e4G0yGFdbiqQ1m@vger.kernel.org, AJvYcCVR1paXbr6fCWyyCCEB7vAQW9YnGYklLi7f53jkcR4FX7/qwwxmDU3yokDlwWg1VIZp4pO1xmDLi/ak@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+MnMrkOh50HDCGx48CSjHqPRsVOq7715ge+WbSGhE76hsn3JX
	59jKymv5OdxxZF2H+6L2XAPOZG09qv5R5z0ndgpf5pvkA/P09qu/tQGX3A==
X-Gm-Gg: ASbGncv5NzrQ6wfTERe/glnteUNWezYIVenJxPaiYI8Xs8KYG5XAsET85SNY6r6w6tJ
	i3/SMHoeF+8AY9Z4mMFxFCrv7cUBbxsLYvLwQEzfeaosYlBVntu09a/3creavaOIefUNes2yQs4
	4KySRb3QhQi40wwzo+2+dveOc7jAoLvhgTXYyDw0NaUne84cd3IaOxTpArr4vGacEb2MlmyV3Ks
	BKq2+y78j/ZoW8Fdy7C+TmcGk1vV5liHAFqcMTz3tNWj0O6se4mdyI233JHHgj1xCsF7sSb80hw
	Ep9skDgyDnLg0t2wO38ws6HPMVRuJMXjSZT1PmDLXIJVzhI0EJM2QyK/7hs6KF1y69wDh3kdIdW
	0lAu98147z4Pw27s2CfE7d2pmDCIrIS6mtApd
X-Google-Smtp-Source: AGHT+IGlO67Hk1Kj9iKqLPiU517t7iWkn79CeIVJF8espGBKzHLJoK7xjAHMRKlXW7hxXZb4oOjWNA==
X-Received: by 2002:a05:600c:5112:b0:43b:8198:f713 with SMTP id 5b1f17b1804b1-43c5a630255mr5445205e9.4.1741284490027;
        Thu, 06 Mar 2025 10:08:10 -0800 (PST)
Received: from localhost (p200300e41f3a9f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3a:9f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd42b7245sm56685215e9.17.2025.03.06.10.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:08:08 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Brad Griffis <bgriffis@nvidia.com>,
	Ivy Huang <yijuh@nvidia.com>
Cc: Ninad Malwade <nmalwade@nvidia.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: tegra: delete the Orin NX/Nano suspend key
Date: Thu,  6 Mar 2025 19:08:06 +0100
Message-ID: <174128447779.2030480.8261977491890867272.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206224034.3691397-1-yijuh@nvidia.com>
References: <20250206224034.3691397-1-yijuh@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Thu, 06 Feb 2025 22:40:34 +0000, Ivy Huang wrote:
> As per the Orin Nano Dev Kit schematic, GPIO_G.02 is not available
> on this device family. It should not be used at all on Orin NX/Nano.
> Having this unused pin mapped as the suspend key can lead to
> unpredictable behavior for low power modes.
> 
> Orin NX/Nano uses GPIO_EE.04 as both a "power" button and a "suspend"
> button.  However, we cannot have two gpio-keys mapped to the same
> GPIO. Therefore delete the "suspend" key.
> 
> [...]

Applied, thanks!

[1/1] arm64: tegra: delete the Orin NX/Nano suspend key
      commit: c695ff32564a4e9532f2c1892ef0a7cb27cfb34c

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

