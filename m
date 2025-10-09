Return-Path: <stable+bounces-183697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BD6BC90B1
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C93874EC07A
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575682E22BE;
	Thu,  9 Oct 2025 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgSAjyof"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626A823E334
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013277; cv=none; b=eCsg/DkARQITI5hdiCncS342T8oV8mV4K8Mk4vF8Qh40wfHeAAuoqIk0NmBNrDH+4eULoQsOG0SMA8vWPS8fdp9NgWpC3R/9/WX/aigXc+XzZRP6APZ9vwfbYJN3/sAhy0yUr2aFEZmfcaNFDQUqBXuBQsDrioyTdCsZ86DrqiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013277; c=relaxed/simple;
	bh=a4GlgwvcqPDJxB9eGC77cLnTgj/F4o2Kt+bX3hdWo68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RbyFVBliexmn3vSOHG6LRTlzqNOn8cVG9e8o1sVgiADmoSK2kQcI8symzwWWIdcpUW2BAhjPUErOx2trilTugMeQnrC3g91JUJDaC9MLRv3DJkjOxpuvETOtcI1b/Fdzu7fUUdidUt0hV4QJN0nG3gSOdIIA+euPvX7/PS98xk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgSAjyof; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3ee18913c0so138480366b.3
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 05:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760013274; x=1760618074; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nyerg8bw/pkBgKExI4csMFP+hBYhO0IhRcEHv3iMtPw=;
        b=FgSAjyofjvIDBNDleCeWfMN6ipuZNaX5mATThz+0IXJOY233F8cr8Cw8OYz0T7KoVl
         a5pgRouI//Pb6dVSjLWJTOp1XVu9u07DFXOfgxBNXqtdpwKGMb/oQm8r/4+ni0W4QG4E
         faGNXAj4fPTp5BVrwTneOC0398ka1V953Ym8QkK9+XsLAXtQnw1kxvKpne3y/sW5JUEu
         LG75E1vsUn1VmX8Bp+oCxhG5kIbiv8F2nqWm39jjwilh8V+HnoL+Qlp4vr6O02Mo9jR2
         uhheGW2PBEXK1xP/U8M22MNkPiedbhO5T5TV0tmajInmSGzWtnNyFFIjMyd4ZlCrpfCf
         jksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760013274; x=1760618074;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyerg8bw/pkBgKExI4csMFP+hBYhO0IhRcEHv3iMtPw=;
        b=oRrqlMmGHtip8c9Pmp6evWQvlIuRvN12TyfirrG+r9DZp5+5Eps/pMsBvcsknM5isy
         Z16p4FiXYFEGv0p7bUALPEXrScSroRB25wUdobVYtKRz1QMf3VzEOkhE+3pwWXGWadiG
         +ybLIMc22QCmtO6ZnM/s0konPUdToiClYY5Y8O57pq7jVA1T3BDGLQTX48ZHfdAqNKQx
         d8K53C7qvb72Q0d/BvL1dwrxXzaNIErE7f62HCB7POcMIO9q1QxdtWdVh4/hOpCJ0jeN
         2f5s5DhdDrdIanCYmOhJjZnRQkIGQtMclx4HmWc3onanyujwRTVOPGUj+7ZaCPCh3Cvd
         0IJw==
X-Forwarded-Encrypted: i=1; AJvYcCWzmb8rAWCCQCECyd+/LxGJcEJT7eKrCTl4agcmnd9NDwtQ+tIRxYu7IqMp3ai1hdD1fOWX45s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIG9aRfb6RUzG+HtRU2MblP8IQxlH6L048V/NDWlkIjirqls2
	d2G0sztIKsSMCydxavfZPRr/zjjbLtvVMuYTfSedj7sDMmpDPq+rrHBu
X-Gm-Gg: ASbGncsPOznG1y5Ga1lAhWpGTSIBnjVMeQ4LfBmMLMl5v0ed5AkyLwsYPAuDeIW6Ptx
	aMxYbYGEkwozPw/Lbd2s4hn0Fg3mddmSk6XFO59aDPj9ec59NFYCfEkEwkgsw3zLm4iZk3+i0O8
	ov5dxBeTvUJfTXFZ+fgWShG16j2KhtC0qFJBStIb2fqW4HwjQo8JEBZJ0U0gO7KtBCcjh9ntugi
	C/cLFtU6Wit8rMtX/bbt1UC7AGwNicp3QMOqOHvvNbujR21/qu45eEcBOffoPIDE/kZ2YYi8Mis
	8mtFrUUhspVkFaEz4imTZMxgW9dHzjj+7PsNtJ4bVG+HDW1CUQVYeZK6+9pcgleLr3Ij5b7ixJy
	xRvc8xZa8R6NHHcv8xTGua1MZpdXh3gkznEQwivNRKD9YaN+nJl4CDUBvJJqb5plE
X-Google-Smtp-Source: AGHT+IG5+niC5l+3hZxoFmTdeEk+aq9D5d4xuawADwnDB5QSeo27pDH2M5zv9nhRFISRnH+oe0SscQ==
X-Received: by 2002:a17:906:abc4:b0:b46:1db9:cb76 with SMTP id a640c23a62f3a-b50aba9f7aemr661934966b.39.1760013273388;
        Thu, 09 Oct 2025 05:34:33 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.209.196.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865f741f1sm1897957766b.39.2025.10.09.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:34:32 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 09 Oct 2025 16:34:01 +0400
Subject: [PATCH] arm64: dts: rockchip: Remove non-functioning CPU OPPs from
 RK3576
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-rk3576_opp-v1-1-67f073a7323f@gmail.com>
X-B4-Tracking: v=1; b=H4sIALir52gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNL3aJsY1Nzs/j8ggJd86TEtOTElNQ0CyMDJaCGgqLUtMwKsGHRsbW
 1ADNSMK9cAAAA
X-Change-ID: 20251009-rk3576_opp-7bafcadef820
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Liang Chen <cl@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003; i=alchark@gmail.com;
 h=from:subject:message-id; bh=a4GlgwvcqPDJxB9eGC77cLnTgj/F4o2Kt+bX3hdWo68=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQ8X30+rrirJKPy35cLE6vzVzz96aV/79ybX/OypNb8F
 OO4e5xFsqOUhUGMi0FWTJFl7rcltlON+Gbt8vD4CjOHlQlkCAMXpwBMJOgHwx+Odob8xd+tJv0V
 WjN1YuJaEdNUwe7spqTeh035uhb/HzEx/BX76hJQJrf02J/iedG3gh7xfOm3EHRcvUljvnRcb8E
 6aVYA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Drop the top-frequency OPPs from both the LITTLE and big CPU clusters on
RK3576, as neither the opensource TF-A [1] nor the recent (after v1.08)
binary BL31 images provided by Rockchip expose those.

This fixes the problem [2] when the cpufreq governor tries to jump
directly to the highest-frequency OPP, which results in a failed SCMI call
leaving the system stuck at the previous OPP before the attempted change.

[1] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/rockchip/rk3576/scmi/rk3576_clk.c#L264-L304
[2] https://lore.kernel.org/linux-rockchip/CABjd4Yz4NbqzZH4Qsed3ias56gcga9K6CmYA+BLDBxtbG915Ag@mail.gmail.com/

Fixes: 57b1ce903966 ("arm64: dts: rockchip: Add rk3576 SoC base DT")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index fc4e9e07f1cf35fb57f132c6d82c48c62bd6265d..f0c3ab00a7f3447a1dbf7874c7bf758e82e04f25 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -276,12 +276,6 @@ opp-2016000000 {
 			opp-microvolt = <900000 900000 950000>;
 			clock-latency-ns = <40000>;
 		};
-
-		opp-2208000000 {
-			opp-hz = /bits/ 64 <2208000000>;
-			opp-microvolt = <950000 950000 950000>;
-			clock-latency-ns = <40000>;
-		};
 	};
 
 	cluster1_opp_table: opp-table-cluster1 {
@@ -348,12 +342,6 @@ opp-2208000000 {
 			opp-microvolt = <925000 925000 950000>;
 			clock-latency-ns = <40000>;
 		};
-
-		opp-2304000000 {
-			opp-hz = /bits/ 64 <2304000000>;
-			opp-microvolt = <950000 950000 950000>;
-			clock-latency-ns = <40000>;
-		};
 	};
 
 	gpu_opp_table: opp-table-gpu {

---
base-commit: ec714e371f22f716a04e6ecb2a24988c92b26911
change-id: 20251009-rk3576_opp-7bafcadef820

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


