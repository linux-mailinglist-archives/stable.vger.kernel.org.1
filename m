Return-Path: <stable+bounces-105402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92609F8E73
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 10:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89869188DED9
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 09:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8281A841E;
	Fri, 20 Dec 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="srA+c5mv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E241A76D5
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685198; cv=none; b=ZzoHKyCw1alhFk4K4dUUtWQTViQqcKRzgDYeyaMlmJa9HWrUkO00ZmRr7Wqjwbd68F2X65dpuOh4CLmmaGA4mUh5CBenEHbQQgsosQvGoHYS7iBunT1bWUz78VGjMh9OMv5JcUFOhBjX/pr4bRlNfK3dOPZn2zSnHGcvI5t/KyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685198; c=relaxed/simple;
	bh=B/CSxh8bc02YGzxj4Cp8fAYbQzfHZ0MyOHkF9uHAlPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TzX0VTvz4QdzWXinV1Xa+611sDr8Tfnq9cTWlXa703GTUBQulUTBs65TBay3wK++HeKu3q8LMh+oDlZJ2fzGcAdVNf7D2zGC7SAeEeEdrtmh9luxNKOJ5gIrh92nTeUeWtJRIaHa0ElO8RfQszg8MDtGZpDqgBvtKT5L9IrdfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=srA+c5mv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9e44654ae3so249494166b.1
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 00:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1734685194; x=1735289994; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AvLjk+c7NI0W4wMRUe8v0vkFjUGPpNKl7JTlpY6nKSM=;
        b=srA+c5mvSf5bH9gWc20ubWKiWy4hWZUtrPSmLYZE+W1mCrP7mP2V8v+KmNj0qDBAza
         NZrudquBDpd5p+vy4Z2LK4MqUU/9YCPdi/7prh7cZjkIFTNMAGdfcScpUlwfXEVksere
         xZ6QA56KqrZAvzU+KnscMXM26sNFQnBiuKyaSAlS02EUEK+4HgAz7WbSGyftKnhVEvd5
         O1+3hjgo+M6zsg8JJxxyYuIpgM7JBKrDjpyHdw/CaOCWh9exAlixjWLoMkn9zIdt2XMD
         BSOv6TuPDPZqUKYl96Gc0NdrdQbU8fkd6VQAM6dkYSKA+jdM4cPS8v5JjKSlLTABC6Ss
         RilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734685194; x=1735289994;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvLjk+c7NI0W4wMRUe8v0vkFjUGPpNKl7JTlpY6nKSM=;
        b=ufT212wOf84k7TY6tdMY5gnFw9MZ4Sluv3Jpdf6DCbSz6hS9X1lEUV/LKwxDAPayvr
         Pw/f0miwbQzgWYSxZiIATbKmsC4sNvbDijqA6aQqg/I6jNOgr4eop+4p2bRC57HmhON4
         KfpuVHlNMhmBAjVzMb/ca0wAfDnWdiYvx+fmLgBbmDpL4/bmF7kEJbRo63KSxcs/mfO+
         Anig2surpQXQGV6ICu2P5Ub6yYW+RBlTRy/itloVDR6QJ/Ug1cb1N3qclZKuR4A+Cw4o
         wAf+E2/dBJZlJnOVCxwTUvNPmLGMrjC38ATzqXrC2JrB7aRgCMQyAglSFQGrdnA1cTv5
         np9A==
X-Forwarded-Encrypted: i=1; AJvYcCVKxp0htNWQJoJzCKRy61u0GH7qkIv+okGUiIjZ0gZvMZeHK8UMJTfNlUJWF1jAejwd8hhQgr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbnJuk5Fm51DrA+YIXlxsPMT0hMQdqpAqVVnmGQwXTOY48alwN
	hLeu30JNv3lBn8kwFHrZXXUlHCnzUOoGk0jHSK+fUBY5HD5SDx8PxJXODe+QXPw=
X-Gm-Gg: ASbGncsjPliXly8ULy5YslwO3lVbofEBivGFmtTyGbZAlYfcE+Jg+6fGizsG3UfSLHQ
	uikz12WEh77cpQldFou9kZHV5OJ21tys3a6/5ymNerCdJ1imNJK0CdNlMN5USZ2zXHvDL3t+MDA
	VYOpeJtK+QIa7r42w9zwMSp6AqtMF6bX4+howv7XC1Buhe/LQ9b11EPTktXReYNgWamByjDkNtB
	2piVSsG4JOXpm2eFti23gq/SVoVPmAtcopySjqOPiSCJEqI1XDZDVYPh90y0DcAjM6MdPnspNbB
	YoCHiFrKpv0YptvcxlafKj0KgRE3qw==
X-Google-Smtp-Source: AGHT+IG4raqmf5z3+Bbit2pptVJL+0AF6PrPFax/4lpRRdG7CllZm9cIM6vpTrrrMN18RRgqKa7m+w==
X-Received: by 2002:a17:907:6e8c:b0:aa9:1b4b:489e with SMTP id a640c23a62f3a-aac2ad8ea23mr156763466b.24.1734685194579;
        Fri, 20 Dec 2024 00:59:54 -0800 (PST)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f080c1asm151178766b.205.2024.12.20.00.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 00:59:54 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Dec 2024 09:59:50 +0100
Subject: [PATCH] arm64: dts: qcom: sm6350: Fix uart1 interconnect path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-sm6350-uart1-icc-v1-1-f4f10fd91adf@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAAUyZWcC/x3MOQqAMBBA0avI1A5kU8SriEVMRp3ChURFCLm7w
 fIV/yeIFJgi9FWCQA9HPvYCWVfgVrsvhOyLQQllpFIC49bqRuBtwyWRnUNPxgk7dUZqDyU7A83
 8/sthzPkDzf3AwmIAAAA=
X-Change-ID: 20241220-sm6350-uart1-icc-de4c0ab8413d
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

The path MASTER_QUP_0 to SLAVE_EBI_CH0 would be qup-memory path and not
qup-config. Since the qup-memory path is not part of the qcom,geni-uart
bindings, just replace that path with the correct path for qup-config.

Fixes: b179f35b887b ("arm64: dts: qcom: sm6350: add uart1 node")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8d697280249fefcc62ab0848e949b5509deb32a6..7b5c340df5f6f32233f4254db2012f84bdde6be2 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -936,7 +936,7 @@ uart1: serial@884000 {
 				power-domains = <&rpmhpd SM6350_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
-						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};

---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20241220-sm6350-uart1-icc-de4c0ab8413d

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


