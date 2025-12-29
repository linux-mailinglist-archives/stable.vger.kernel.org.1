Return-Path: <stable+bounces-203481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2300ACE657F
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E82E30053F9
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 10:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539AE27AC3A;
	Mon, 29 Dec 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5M2HxN9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E848222590
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767003144; cv=none; b=gISrIO0aPs6O5cFlF7D3OWjwbSSDnNeMV63DZL3ESgkMmqLwVtXhRi94Sb4TKwYdW8At1wCdqCpJ9j0Xb0uqIMVmGFeF87Sbh0262chsePQapGHpIb+n9qATlXeWNMZsD33skH/4G9w5/8ZVSSiY9kMRflhHVwKegvVpm6xJWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767003144; c=relaxed/simple;
	bh=LCiGByx44aPo6I9zaG1ReBsxglHofWHA8KNEqBtCywk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KHHnRXxqpciKRhxfVPL8Lekbx/wFWdEsUz+12Hvx8tg0nvdFFPGI3RQ6P3ppR4CImEFLG4lIkJGiRoRaAlScfGTeFahv3LvJESyMT6IrGDeHnQGDmZyCmnAcVZssDdXunleIRNG2BzMwq4Llhq+4HSduU9ceAB4tp35F11zoteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5M2HxN9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so56511985e9.3
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 02:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767003141; x=1767607941; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J1vSgRP+Bs5qbIakzCpHlzr7o7ydag8RKKrO3j8O608=;
        b=Z5M2HxN9yV2atm05wilpkDGHYQ55FvGyBBbpFGyeQ0XscOKTfKPdZovM0quqtiumDo
         wkLJY9NQ+8/2Ny/h6mfPogEI4+P0o099kTWnKS/aJ0cSJy58GFvC5wKClFTFqZuVjZ23
         o/jPX2WhZOkzQK5+rTFyZ9kak/oHi8+XO5p87EQnWmMldaF70m1tZEx+/awGSc//el8U
         cdpPSqAdoFrEmU2oa0g/X/C+XJsB26ioXaBTieXHZK08gTLWrsPPRh48pOw3RgmBVhov
         QO2ywaNFWSwOxxWYuLbbmBBh2in9sK/sZT4yf3krDgbh+XPpilQ/8vHWYOrZMZogXHKE
         9aFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767003141; x=1767607941;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1vSgRP+Bs5qbIakzCpHlzr7o7ydag8RKKrO3j8O608=;
        b=Cgo5je+JfOro7iUvduQQi4cufLjbPjOJ5OXB0K0SS66SLb0JezU9cx+8ZQ9ab6KI3P
         lxGqIfz9g6tGKLd2Hzna3/WaaCll3FTpD7Ow1GWsegVT+MLrzAIFW9XZfA48T//DQTkj
         51ZP562mslwJ5OrxP05iMoEBsRF+B9EJ3vr33gVgJFSoYGvkjDrUGd+OAw3soScDz5tC
         uHpwsKV4V0QGJXJiZ1iyA6sGpTAJbvYK+hD95nJ0GJuRdDiDfgl7JIpjVOhc1es235wc
         jVQfaGpHXOat/HoxwMtc+y4BVMM/3LW09ffTjfOhDkjvSf9SJckFDU2HkQjsLQEtRxed
         jcGA==
X-Forwarded-Encrypted: i=1; AJvYcCWge5h7VVzlYAbh+iveSNU0FefU6Efjk0JkyEtVjm2SzUCSUDAHn1qLAUkAEEV4FU+YJkpddU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9uFbLS7xQqDkMCxC+N8VotCVWLA0ZtcJ1DkpAwz3q9xYMJbY
	mKfpaoZreobzGvy+Attr3DzN20JcMSJ/e7qxXzeEkcaSHsSAbglNhmFj
X-Gm-Gg: AY/fxX5LGzCFD4CxX0zT6GDVW2rcpblx+vJhWmddboXWEuyjeEIijA8gx1q/xVx5gfJ
	w8zFZJwKhIbjoEdTaM3YBspTEam2qn4AuFyGZy3mEq1iiA9CWCD8ADcfJRTfCWbt2A1BGQ/2W2x
	Byg41hHdTJyLV4v38MAoc5OHAsnF4XsdZJlMHn2q2w4fDFMCJCJg3aWN4ikgKD3w4qh9APPuOtB
	WBoMHHHLyzyZRzdrLPbi/wNnsSC5efFVT0Y+Air/SrCRhfmPTkkpqzq2qtZxYQ7GkBfvf6yUYS/
	3/Jd3C9Y7ybCQ+YjVYe4GJOFT5X82ti81xqK8tOEgQCxRqoSc6E/pdSIERq8gpnQnRG7WwpohvK
	dXuBVS72za0+BAFPoZ/Unn+NdlswMdAu9s0LSU/sIH6vC10qkgK27Ms7ynlg+GenIM4kLS0OdCc
	6lVsVrqsGHrEjkXLre6/xBdmFRNpQ2LxfBNpd6dmOfG+SOt2tuZ3Q6ap3wLf+Y
X-Google-Smtp-Source: AGHT+IHlR0aXhu72J2TtWwVekmyRrRkDyvgOTcwGHqcoRX7TNY17EGN/wNGjrSuW2cqNhsN3lSNTHw==
X-Received: by 2002:a05:600c:444b:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-47d195468a6mr302386315e9.14.1767003140541;
        Mon, 29 Dec 2025 02:12:20 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-45-246.alshamil.net.ae. [94.59.45.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d583f42dasm19840735e9.6.2025.12.29.02.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 02:12:19 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH 0/7] arm64: dts: rockchip: Sound fixes and additions on
 RK3576 boards
Date: Mon, 29 Dec 2025 14:11:57 +0400
Message-Id: <20251229-rk3576-sound-v1-0-2f59ef0d19b1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO1TUmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyMj3aJsY1NzM93i/NK8FF2DZCOzVOMkQzNLIxMloJaCotS0zAqwcdG
 xtbUAxT+MhV4AAAA=
X-Change-ID: 20251222-rk3576-sound-0c26e3b16924
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 John Clark <inindev@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436; i=alchark@gmail.com;
 h=from:subject:message-id; bh=LCiGByx44aPo6I9zaG1ReBsxglHofWHA8KNEqBtCywk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQGhTCec14dG1Mwy2Gm4d01F2qTdhQ7tHWq/Y+L73eZK
 Rwj/YCxYyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNQx1jFi4OIUgKn2rWf4p5r7KSIt89RE3i/cnJ6Kggsvrjovefym0jzN6p+BblfftzD8Yi76xBR
 nNfHq4VjPX09OdLDs4fW4Oq3/zsbqY7575T/PYAAA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Here are some device tree updates to improve sound output on RK3576
boards.

The first two patches fix analog audio output on FriendlyElec NanoPi M5,
as it doesn't work with the current device tree.

The third one is purely cosmetic, to present a more user-friendly sound
card name to the userspace on NanoPi M5.

The rest add new functionality: HDMI sound output on three boards that
didn't enable it, and analog sound on RK3576 EVB1.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Alexey Charkov (7):
      arm64: dts: rockchip: Fix headphones widget name on NanoPi M5
      arm64: dts: rockchip: Configure MCLK for analog sound on NanoPi M5
      arm64: dts: rockchip: Use a readable audio card name on NanoPi M5
      arm64: dts: rockchip: Enable HDMI sound on FriendlyElec NanoPi M5
      arm64: dts: rockchip: Enable HDMI sound on Luckfox Core3576
      arm64: dts: rockchip: Enable HDMI sound on RK3576 EVB1
      arm64: dts: rockchip: Enable analog sound on RK3576 EVB1

 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts   | 107 +++++++++++++++++++++
 .../boot/dts/rockchip/rk3576-luckfox-core3576.dtsi |   8 ++
 arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts  |  22 ++++-
 3 files changed, 132 insertions(+), 5 deletions(-)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20251222-rk3576-sound-0c26e3b16924

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


