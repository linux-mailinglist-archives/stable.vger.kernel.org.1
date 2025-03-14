Return-Path: <stable+bounces-124421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D745FA60CF6
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 10:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B8719C5305
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E70419C569;
	Fri, 14 Mar 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="sn7xSLH5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46611E9B37
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943839; cv=none; b=Ek7LJNnL+t0gMFuR5kyjwVCcCwNFraw0PnRUwxLGzI+hoNhre31V8fGIM9bwxzEbJc8+M6zbU593c/Zv5+ZsCoiBypznuB2hLYrG6EQemfeS0hZ7MqDahtuxIpRzdyr3wTFiAfP2WgwSoi8g3NrdTWAAGOhr5jrImnHMrYgtLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943839; c=relaxed/simple;
	bh=KUctck5B55TBuotnv0g4TVm9b/ov5ZebjgiW7exjsQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTGRR3iW6hprsmls3yDmGcZCszZGjkAG5ITk1WtjmSuvTG5I7F41rQi6XQN1lnGO4OKe0emZX+/4gx/m/EBC3wWWyg+pbfbPX9409Of2iFv6qtpfTgRLYhDVtNHNPYW4RxPzX5L5Dc3zkDdjv/FfiVnKFzvLQaFvnkGgUEQrJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=sn7xSLH5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab78e6edb99so278857666b.2
        for <stable@vger.kernel.org>; Fri, 14 Mar 2025 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1741943834; x=1742548634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DduIjgVbqMB+YIwUT9DVdolqDatgrNDkgwKYlFwXCYM=;
        b=sn7xSLH53u/FyO8GYZzU+bXDy6EiauK2H6aQb+V9p7JBxxG4EAA6wooCde0WxQDXaa
         xp1xbHGuAU1x5bTLqESpzj8taA8S7/9VxO+TbGR/tjiv9axNa4IqUmizoyR9smr2SFlC
         k2Q3ESEFgCMgdaeCgzbpVUeOZNqJBXQMyU564+bPoW60/rEyDzicwhcyfW7VKy2spYe/
         V6IJ9l3p/+JBPOLBXM+uhXK0CDjeUQDXQL8W4JkFiW9Wz4+xnlDlLk1DZYnqD2r4QfaS
         8xtV74OHr1xbF1YESBdmDECAzxjorEpjUMCRtmnskNjDMMxO3wMszLJ50okCSYCeTBci
         HiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741943834; x=1742548634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DduIjgVbqMB+YIwUT9DVdolqDatgrNDkgwKYlFwXCYM=;
        b=M5xbymMWSi811D6JbwyOdH1Qau0PkzavPgbbNRtUVZYO0pSaBpddSYNhoSo50Na4RS
         I0VhENcnaxvPnFY6d+Uj0GeQ+3vpvbUf4Z2fZaZEnze9WX4nHKSdT5Embo2kHOHyAXkw
         f0GEmHLKq82Oni9XPY9UrcnV+v4UT6cWCi3TuITNXYfAqq12mCfJAjMI0GBqcBVMu3QV
         t4LjTxHlLffiV/AqtdlEDLY4bxBewEMU0Pv0SAnZrD4WW2sklnoMsmfHdd2FD2WzXfMt
         knyKPIOzpVD+E6F+UaTLPGFRq7wmp6c2TxSITA0yoHk0cE7/5MCiMhDCH1ikqm/eyvIS
         hDTw==
X-Forwarded-Encrypted: i=1; AJvYcCXkDz3wGauv3yoZywkAYPRGiFfXbItEhzSn3bT/9t0s38NqpF8nHpLmwBozqtoX23Hk+LUmr84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmbLxywA/DCYQAextO+aBQh8nuY27+5DiTW+RHP4ACW0WPseoL
	RFjsOFlhyCH28C6kjD4gZBbTSgQdRIXsTkSQARcLREby7wTtxT/EO2gopc30mS4=
X-Gm-Gg: ASbGncvdf0J6g8G91muyyLdWv9bS2fD6wzSbxFUxLfopxKKCScRP1Op6SgsH4SiUm8D
	LM+kbGXQMQyIXcRxTMwa1XU6JVZQ6yuqbd2oiBYae4rdLzAyFNMCOqA+MKEGGpfT57FF/bewX0X
	KzPa0Aa9Gz6Nsn/IgC5kH1sGbHpSJ0hF6oVNBzsodd+tPkHHEYwrOTJGxArKT2a+GNRDxKx7v00
	EkE5lPF06VEQFqhIti2LJdnV91/Ih84K/Sg0cSVgYYh5QsGThxKnJTSjz6CEEJc7YdJEcJJDoSi
	S1kIsFILv+wn+IE5gRrdXIqJaP1d3Kq37jb0/He5zZFR4WaK1ZLapRBeRR/An8DVJpVmZGavs3+
	spzNMgFu3uXQM0suL7wi6lZAO+0GP
X-Google-Smtp-Source: AGHT+IF2fMs8v6rvbwb4avWb30H2q3Lx24BGBU4BTH0RNBEh5rOJldaU2Obk6124KsZ+HU4ZWVHV7w==
X-Received: by 2002:a17:907:7241:b0:ac2:4d65:bd72 with SMTP id a640c23a62f3a-ac330441d57mr197243166b.36.1741943833904;
        Fri, 14 Mar 2025 02:17:13 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeadbsm195582166b.29.2025.03.14.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:17:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 14 Mar 2025 10:17:02 +0100
Subject: [PATCH 1/3] arm64: dts: qcom: sm6350: Fix wrong order of
 freq-table-hz for UFS
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sm6350-ufs-things-v1-1-3600362cc52c@fairphone.com>
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
In-Reply-To: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

During upstreaming the order of clocks was adjusted to match the
upstream sort order, but mistakently freq-table-hz wasn't re-ordered
with the new order.

Fix that by moving the entry for the ICE clk to the last place.

Fixes: 5a814af5fc22 ("arm64: dts: qcom: sm6350: Add UFS nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 00ad1d09a19558d9e2bc61f1a81a36d466adc88e..e6df0b7dae8baf39bfa7ff3856759e8cd200f0c8 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1177,11 +1177,11 @@ ufs_mem_hc: ufshc@1d84000 {
 				<0 0>,
 				<0 0>,
 				<37500000 150000000>,
-				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
 				<0 0>,
-				<0 0>;
+				<0 0>,
+				<75000000 300000000>;
 
 			status = "disabled";
 		};

-- 
2.48.1


