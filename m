Return-Path: <stable+bounces-203371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37161CDC0DE
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 11:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A5D5304569D
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333F2319608;
	Wed, 24 Dec 2025 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BRiG84RN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YvuDym8s"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028529DB64
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766573632; cv=none; b=Cq9V7WBf0XlHQSK/bQuX1TP8X+Q8PN0yWw/uRqT2ZP7rkomDzKsSeA8/T95H+vHFLHQbEYHTsv802jO7jHWo613b083AoYtBD++FFXJIF8i1P/OlIfOFKjHxFuxy1eAS6I8Bz8/dRj0FhY+BswxT9vheorQQUbIlc/Lne59FfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766573632; c=relaxed/simple;
	bh=UEqwWgA4eY1trHsHO9E8LHZDjJ0i6VTelWd/QktAPfk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Slgo0xGe2IlxsD43VpunrG/GCt/624cIUzpEaDnuvR/HylIsUYM4Ijs/0y8PixvF7IvnVAfimykOsy0FlCixxT2dThSjWjqQ4pypoYzCCenG3fwKrgFAbQ5q+z2v4DdrWeOqPUl1/d+w822t2XWkRitgzdk8NWXIw+te0eE4lEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BRiG84RN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YvuDym8s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO8m1hg1206657
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 10:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rieNRr2oJhj28iSYb1CzIg
	qJgKQi08tHB8PfRxFDRCA=; b=BRiG84RN7bl3xX391ojCSvhkM8FnI5cZy6TwTj
	Qby9Sgg6TKk9NBwezFXqDonoBgJOHJEmhXQDhRUlZkq5LjhaLs/9osm2qwa8KTwl
	eEc8XCtpGfJy1fk9m3DgTMZgskJOxXudbRtKy+7yIV5meSDUUOQiVHY45COpNBWq
	AdPg5C497ebE43WEXht3AxP9Jq9mX8HiOQmuoVRjvDpfvjqXJIGprCwxPnqxtXim
	guF6ZtsKQ3fyON+DuDhkCZWWFKRiJyxqh80aLRLU7+uKaGkRqHBOkWhF9C67lXdp
	FnzOnuo4vL6NCeVKrZYd7pYqmo3iy8UM8pdhWYEy+Z/KmP6g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b827r1vg7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 10:53:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed7591799eso140321251cf.0
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 02:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766573627; x=1767178427; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rieNRr2oJhj28iSYb1CzIgqJgKQi08tHB8PfRxFDRCA=;
        b=YvuDym8sFHOizNlC12WDMuGExdWDSgAqO/+y0BY4LmjsnB8dhdGlpQ64rphrqG2G7S
         hQXOl1K1oTf5OZIy49hJNvpY/ZFHQQlecDrYQWHieQWbOBHYKwmi7il/0hrVhllFO5jJ
         e2ILtSO9KiP1oOlorJ2a7i//lqp/IjLUHRltIzbiZ/HnNPNlzj+VQ69p+vzp+/CDo8ma
         2JCvhmT+wI29jff0EIPOC2tG3IEOeUfdVkprJZCk6M4vuNwYkGMdwLsVd98n7q5yjLML
         8qzPSfJafGM6cCrFzDz5/qBIae9RSeP3xV4TUaPlc973Nqvq3fAFUFRkLkEFGTNXPVQb
         nuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766573627; x=1767178427;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rieNRr2oJhj28iSYb1CzIgqJgKQi08tHB8PfRxFDRCA=;
        b=SQVtkx4LkvaAHBccS64hWULfVCecva9kdMwLFL1j0dw5J9zsfJ/4Sc0VgyFNjMYMdD
         krB3YJcpRKWfe4jIOepur0EAF9cNNWapmcKNjVBS17UlkZhuhh91lMbJaOFSTeDN7My2
         0NxqxP+hTA3Xt1IAzNiSHZJtdSeWK2D34/YZnc2JDbBgcfqvdkM3ESjkBEvptAnlqvMV
         ILGmMcpK8uXZAaLGW+QerI1NxK16Zqt96S7XklOei4uHOXYWmUPLc6zPqhShUNjFOMMH
         lgJaZ+9oooizzO+07MKUjrix7Gea9ujOpUsg1GkpKHjA9WW+6lSAj+UboADa2JEEME2m
         X1nw==
X-Forwarded-Encrypted: i=1; AJvYcCXQkHN08kpBINr/DFfK2KBePlEzGp0stn9qy/T8Wnf9zPRK4jdgAqgmD6sY+tvJccWT0bc20VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLtoGWPRyibAUxhUIq1YV1qEusFitlmkDG4rpmlDCkJIdz13PX
	XoZKZve9w4TKnnujWGf5k+aPrx+q5YIM/5a3sQsENHyGINt3mo6c93BlE2rnZTBGS50Ufm/9d3v
	VVWR0Of0lkoAnHUmREjP8eX17zkgtwodOu3/XITPtT/cj8sHOHmaMl63B9Jc=
X-Gm-Gg: AY/fxX75zF3xyEOPXHphdP2UaRsYKUtmF8UoQIW3JicgAjEONaldND+raNL37OYvc8y
	SnMZrNJz9wancOB2KJA/f4XfnNx9eIoiftVxMhiFcFUP/cdcYq1oDYj1fb0gSFzvjx5CqPIsutb
	r9w6MB3H0CJ8fQ8ioizvsXcasrnpgoH0UpL+vmHJXkbZ1oJsKogyZQGCXtV49eWhjHjQKswsk5t
	mqKB5G88SDQfno4auT/9YkUq3a4KfQgFLQkWUmvfcoacDpkinQWz+JU2nAXT+VaMrykzigKwuv/
	VgFORz3ibcRtk9Ns/2JkGsxCVXraVjNf2CI+SSjrnWnVgsOf52e2LD+9bmDtmgkhaqxiaHZQOSo
	slIB0zW82wfeZXBk=
X-Received: by 2002:a05:622a:4cc5:b0:4f1:aa2d:81cd with SMTP id d75a77b69052e-4f4abdb8a8emr240490251cf.65.1766573627122;
        Wed, 24 Dec 2025 02:53:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETazEDbIJBda+GTQOv1dPkraEbLtIPmiNvRi1Xo42NQLnzp14Ln+KWlN/ubdXGJHfrZEKtkw==
X-Received: by 2002:a05:622a:4cc5:b0:4f1:aa2d:81cd with SMTP id d75a77b69052e-4f4abdb8a8emr240489931cf.65.1766573626483;
        Wed, 24 Dec 2025 02:53:46 -0800 (PST)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab86cesm1737562566b.19.2025.12.24.02.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:53:45 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH RESEND v5 0/3] phy: qcom: edp: Add missing ref clock to
 x1e80100
Date: Wed, 24 Dec 2025 12:53:26 +0200
Message-Id: <20251224-phy-qcom-edp-add-missing-refclk-v5-0-3f45d349b5ac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2646;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=UEqwWgA4eY1trHsHO9E8LHZDjJ0i6VTelWd/QktAPfk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpS8YuxWVgYyB+jUMg7b1RFEbY4P4Sb1KSxHbhC
 mqlnZRveiWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaUvGLgAKCRAbX0TJAJUV
 VqYuD/9fo1rl9jefHGu1DOuP1zCkKx/VCFfo11G4rK3IbF+SvrgGxuhjJt/JTS61IlY9aYUG9Aq
 c6KsVkx9AOrudP9CwQmwyBLsUzwP6fLh/id87Jsik4nfOtKOhIXUFnwKGLhENA3115vwsClW7gm
 OWnc4KgYGRNCusTXGj4uTLnnkA7Dfu48sozRXxX2lkV9XsxFCSchhoXtvsDnvPrb6WebPRJLRAt
 2vSomz1pKG1UBn7SkFYktcXi6iv4jmGBQO1D3GtFmDfHysUEdMaqCLIOw5aMRy7Cqa+GeTOyEV5
 ob2WH691Yl5oZjQ7dGWMr3DDCFay6N1DYhgZl/EWsoJAMGdhXH4VHF6vUcQwQT+sLjfxIcw/rXv
 J+iPdekda8KhW+LYlnwkbwRoEe0ouL//xmt7D774kVA3OP6+1ETQ0QUfAL9X3TICwEq41bTdr40
 +2JfnqOWmanzno68eZJaRnrnrojtYGxpK5QAf2ec9SELNKJ9qW0O62qHaYP+JKiXqxNM//iYoUA
 /MIWnZdumi5eXxAzOyHCcCwCkAsDktL1MgYD1EGLPIPYL9PTqz45Ad1tN31m1cIzRynIXxyBKAq
 VMbE3J/HmRnMQo82VT2QnUrh5Bv+auNJC2STZu6DvYaFGThQBIfyIru+S7nDOa1TCV8yBSKU1pb
 r/nkegwmlCUd49g==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: cKphNQBmmOf896aS82J9hqPNKjJdUdvD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA5NCBTYWx0ZWRfX95Bwz5GNcyO4
 AaAQoIezIeZLukfwSknWICMgGNxx1z6rUdJmPMfc8nDfZOIPSXyL4W3A4GOIfW+aZqEiL7C0A0r
 TrN0SEomcdUv4YUdCvwdshDDg43VwBlhcmokRqN0M4Mp2b/I72doX4slnnETUdOfhRE2u89EfiW
 b99v1p3WE6RPxSgLZe2BAOa5xkdYImZ604LeO+7KIGYGuAMsDjnnWiL4px01XG6FT/gx+WSc9O2
 7XuhpGDTYzSvBTBqQr1r2+jIBUCwOtLJAk99cPDtG2uXISAN/QRPBXtFAF6UwLRJ77BWBUR4CyY
 F3pWci8s0FOPMqtZqrGkGse51KmxSvthQBn0ZpMZCAPLxG+yXVgRjq+X/d0vLxGAlNO9XXcDqcZ
 AU410PC9CYFfwE/dEzJ/urAZ8mJ/A0a3mGOZv3msDPW/A3+8w4gt7PRBz15o4hbyGZHe2AA9MLU
 sQXrYiHY4D5L5CrrSWg==
X-Proofpoint-GUID: cKphNQBmmOf896aS82J9hqPNKjJdUdvD
X-Authority-Analysis: v=2.4 cv=RbSdyltv c=1 sm=1 tr=0 ts=694bc63b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=DdBtMnqNxkYIvXj6ev4VzQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=n6KyKBFS8jaI6nepwJMA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512240094

According to documentation, the DP PHY on x1e80100 has another clock
called ref.

The current X Elite devices supported upstream work fine without this
clock, because the boot firmware leaves this clock enabled. But we should
not rely on that. Also, when it comes to power management, this clock
needs to be also disabled on suspend. So even though this change breaks
the ABI, it is needed in order to make we disable this clock on runtime
PM, when that is going to be enabled in the driver.

So rework the driver to allow different number of clocks, fix the
dt-bindings schema and add the clock to the DT node as well.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v5:
- Picked-up Bjorn's R-b tags.
- Replaced "parse" with "get" on clocks acquiring failure.
- Link to v4: https://lore.kernel.org/r/20251029-phy-qcom-edp-add-missing-refclk-v4-0-adb7f5c54fe4@linaro.org

Changes in v4:
- Picked Dmitry's R-b tag for the driver patch
- Added x1e80100 substring to subject of dts patch
- Link to v3 (resend): https://lore.kernel.org/r/20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org

Changes in v3 (resend)
- picked-up Krzysztof's R-b tag for bindings patch
- Link to v3: https://lore.kernel.org/r/20250909-phy-qcom-edp-add-missing-refclk-v3-0-4ec55a0512ab@linaro.org

Changes in v3:
- Use dev_err_probe() on clocks parsing failure.
- Explain why the ABI break is necessary.
- Drop the extra 'clk' suffix from the clock name. So ref instead of
  refclk.
- Link to v2: https://lore.kernel.org/r/20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org

Changes in v2:
- Fix schema by adding the minItems, as suggested by Krzysztof.
- Use devm_clk_bulk_get_all, as suggested by Konrad.
- Rephrase the commit messages to reflect the flexible number of clocks.
- Link to v1: https://lore.kernel.org/r/20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org

---
Abel Vesa (3):
      dt-bindings: phy: qcom-edp: Add missing clock for X Elite
      phy: qcom: edp: Make the number of clocks flexible
      arm64: dts: qcom: x1e80100: Add missing TCSR ref clock to the DP PHYs

 .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/hamoa.dtsi                | 12 ++++++----
 drivers/phy/qualcomm/phy-qcom-edp.c                | 16 ++++++-------
 3 files changed, 43 insertions(+), 13 deletions(-)
---
base-commit: 131f3d9446a6075192cdd91f197989d98302faa6
change-id: 20250730-phy-qcom-edp-add-missing-refclk-5ab82828f8e7

Best regards,
-- 
Abel Vesa <abel.vesa@oss.qualcomm.com>


