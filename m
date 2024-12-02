Return-Path: <stable+bounces-95935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0555D9DFBB8
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8E2160821
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EC61F9EDB;
	Mon,  2 Dec 2024 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iERyl+iD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB61F9EA3
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127377; cv=none; b=RtT/DnCB3RYMC95tBQZWngLHZecfF2ASnEWJPWpbR0nyXncRxovExWZtNY3vxejOVnJNgzxsftgGte0hZlo0MFjsF0uyp1ymINenO61qSyJdjhhAELxwPhzcfX7+maoQyV5yUwQBUo3xben/uk9RNSDpABzoyFHgp/SAQyEtnrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127377; c=relaxed/simple;
	bh=wyRBTDJhchh2VRwMqvWdPrsDGYSLS50T4XeRr0/TSKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZ4AC5rfYXC6x5QwgemVevUM119+zqMPK2VOiUK7W8FzbgmsUB7cInnY9uEGX/MW+HB6xvZJ7DoEe9O8ys15GM5kAbM4tz902ndh4Npi/M+79fGowUDthnUR7xU87MZnEKg0iWDdPo6f3gwzoJYD2VZX2VqZnlbnTJX/F5wmOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iERyl+iD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7251731d2b9so3471994b3a.1
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 00:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733127375; x=1733732175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFwz407Fv/XwMseJNTNI7dRyydn8B5G2ldLHp0TZ1PA=;
        b=iERyl+iDp5FrZNcCyxogxqh/5MFzkP8MTuGNjQgWatdpo3G78veboJ7oQxzUa8vxDz
         +Qh/gBQFrWHBz10293+gIwzNkFTeHoOSNwUn2dcZxyZhM6gopAJHhwqrqJ3VmF+yztTf
         MYpRppABgbp0IbSrYVBqD+5uyTvX+0c6C2HuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127375; x=1733732175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFwz407Fv/XwMseJNTNI7dRyydn8B5G2ldLHp0TZ1PA=;
        b=ccRmydBhgMRvtZuvVkPXHkn5YLqAJGKz3XgAtyhNOhEZyHeeC+087KrEf2Lxc4icce
         k2NPsPcJTSwEO6F74MLb5xWmAl3XRf/nH0H7itXGIGTHB7oDv+OdjO9l1LU+16FL6ZDl
         KThw9SotjGvhGJXDa07g2Iizek2w8cyX60FR0kqnk/NBRS/LCgJB0QLHbisrDBQsbn+S
         i8bsH1iOWrBIOWt7hDLfY6VYOyB0KRFVK9NtUMre/71Ar9fG+s86OKOwjOEf5GX+JOmv
         nGhDy2SIRgoXzZZsG93yC5pX2wEriFiEtzqF17RLJd0Cjz2maNT2FquYsRMt/anJVyoW
         f6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9WlaTC2n32+qU1hPD7dS0KSgpKX3641pAn/LIe1O9sa0T06GUXsufkuVOWa/J1DDzesvr8ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHo3yuFHPaTZFQPoscvqsThn3ia7+3dHsfUykk3psDMWeOWu2
	UC9sUcgA0zV7x664vpw1zPOAxRPiNSyG5zI4V45Wrmt/Qqy85xKK0pvxL9kweA==
X-Gm-Gg: ASbGnctdp1M4hfmdqbfJuFDBs4Xz0k1e3G2e8AK+fw0QBd90mUmeM9oBTpHgPbIBEl8
	KLisAm11xzB/l8WC6YrXHGKo5qQXMEf3V86CC5knuVqdMhwljFl2RaBTQyLxFaIxf66oJe7l2wk
	2CaiwsAv7NB7wzcWV0IA/+rJRa747ZDcXg4kCKLHtKncTHa8KhadVEEmsKzeo3y1q8GvxSD6gvQ
	pDtdm2Ru5ZNUCuaAVdQQcld+m8caMMMzcYSJYufBFuWrKYCD17vJc+r9SEUt/pv3JU2
X-Google-Smtp-Source: AGHT+IGVKJH1h0FeZuaxYpdL1EkQ7vtbsLObgOmtsoxPqtC7AsSUKW71maa+1Cg0tbmdqz/W2Hd3KQ==
X-Received: by 2002:a17:90a:fa45:b0:2ea:61c4:a443 with SMTP id 98e67ed59e1d1-2ee25abf59cmr26106958a91.4.1733127375376;
        Mon, 02 Dec 2024 00:16:15 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:94c8:21f5:4a03:8964])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848505sm7891833b3a.178.2024.12.02.00.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:16:14 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Koichiro Den <koichiro.den@canonical.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH 6.6 2/2] arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled
Date: Mon,  2 Dec 2024 16:15:50 +0800
Message-ID: <20241202081552.156183-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241202081552.156183-1-wenst@chromium.org>
References: <20241202081552.156183-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit 09d385679487c58f0859c1ad4f404ba3df2f8830 ]

USB 3.0 on xhci1 is not used, as the controller shares the same PHY as
pcie1. The latter is enabled to support the M.2 PCIe WLAN card on this
design.

Mark USB 3.0 as disabled on this controller using the
"mediatek,u3p-dis-msk" property.

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
Fixes: b6267a396e1c ("arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240731034411.371178-2-wenst@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index b78f408110bf..b21663b46b51 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1296,6 +1296,7 @@ &xhci1 {
 
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
+	mediatek,u3p-dis-msk = <1>;
 };
 
 &xhci2 {
-- 
2.47.0.338.g60cca15819-goog


