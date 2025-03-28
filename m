Return-Path: <stable+bounces-126905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F2A74223
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 02:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CE1189F750
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92756188734;
	Fri, 28 Mar 2025 01:48:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDE81F5E6
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743126487; cv=none; b=FwZJC4rSEUZDFKWCOxX7w9oRgVpgNoyQB5+NljPcWh2fLknJWWnzfHz4h4Nn9uYqZ2OcMzjmC06pA3tmtDxh4Sz+I/OkoAOevgt4TFwllTM3JStxZpG3oHNCm5XJHbm3liYMv9hyPoHrQowrFPnA7H921x9Gqvw+xQPDmuxRjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743126487; c=relaxed/simple;
	bh=xAQ0px3+SNPSvpFZoJtz/zUaCmD/ubF34cju4R7uVkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S7QjUkkZdi29WaRGJlfg8Ifiz/UZchyovsOQPBZ9TyWA9X8STjuxHBhdxMaU9b7beCzAM2wV+y9FZb5OqJA1Cw5vUsKQxPuf6tTKoMLdkuIAOLpW4aOGBgHCiZJuIUvdv97Vz/pFgV/g67ycAQ4sxP1S6mcJZQkVqQp47bOOkOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.9.245])
	by gateway (Coremail) with SMTP id _____8CxbWvK_+Vnl+CoAA--.21160S3;
	Fri, 28 Mar 2025 09:47:54 +0800 (CST)
Received: from code-server.gen (unknown [10.2.9.245])
	by front1 (Coremail) with SMTP id qMiowMDxu8TH_+VnqOZjAA--.33647S2;
	Fri, 28 Mar 2025 09:47:51 +0800 (CST)
From: Dongyan Qian <qiandongyan@loongson.cn>
To: chenhuacai@loongson.cn
Cc: airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	chenhuacai@kernel.org,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	simona@ffwll.ch,
	stable@vger.kernel.org
Subject: Re: [PATCH V2 3/3] drm/amd/display: Protect FPU in dml2_validate()/dml21_validate()
Date: Fri, 28 Mar 2025 09:47:51 +0800
Message-Id: <20250328014751.674244-1-qiandongyan@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250327095334.3327111-3-chenhuacai@loongson.cn>
References: <20250327095334.3327111-3-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxu8TH_+VnqOZjAA--.33647S2
X-CM-SenderInfo: htld0v5rqj5t3q6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Hi Huacai,

Tested successfully with `glmark2` on both x86 and Loongson platforms, using AMD Radeon RX 9070 XT.

---

**Intel i5-10400F Platform:**

- **Board / CPU**: Intel i5-10400F
- **Firmware Vendor**: American Megatrends International, LLC
- **Kernel**: https://lore.kernel.org/all/20250327095334.3327111-3-chenhuacai@loongson.cn/
- **GPU**: AMD Navi 48 [RX 9070/9070 XT]
- **Result**: `glmark2` score 18703

---

**Loongson 3C6000 Platform:**

- **Board / CPU**: 3C6000 AC612A0
- **Firmware**: EDK2025-3C6000-7A2000_AC612A0_Rc2502pre0313
- **Kernel**: https://lore.kernel.org/all/20250327095334.3327111-3-chenhuacai@loongson.cn/
- **GPU**: AMD Navi 48 [RX 9070/9070 XT]
- **Result**: `glmark2` score 10893 

---

Tested-by: Dongyan Qian <qiandongyan@loongson.cn>

Best Regards,  
Dongyan Qian


