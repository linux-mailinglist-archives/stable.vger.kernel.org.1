Return-Path: <stable+bounces-167026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85CB205C8
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 12:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C754B7A6161
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1191E520B;
	Mon, 11 Aug 2025 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S5ddSIAj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37EE1D7E5C
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908681; cv=none; b=CkylgU5zVEtlpWuawDT9L9k2oOLGoqsdOr59keqN9EVArbNDeMRkrlkdgWwdR3kf+DerxP8ogq3nGHrmhvgYUGMJu8EjCtWqMoPGyS+6T70ZEDXEULsRfJVHW7IaTQc9RYvHNvFizkgLGh/TyCj5mXi7tTUsIRmAXjfemIPj67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908681; c=relaxed/simple;
	bh=KTA+LXFcxm8rSp9NxBybqhYS35EsghTwK6KMNtuOQOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jxbgHzDxqoSj+R+lXsdlWVCbDi8bE2WZI95RoXoq45U/7aDe8T5dlhHress3IAyp2S6Lp+yO3L2+aOXbPrke8QrG1yCeTDO9VQPVx/tho6cfaIV4oVEgqOHpYOXhnxXGeVQe88Dgl813iUWoHgrltJCWiu8R2Pb8ez+Nbj8Vbt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S5ddSIAj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dGot000789
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 10:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z3igM380Sl/mCHIaNQCGmITwSXOBNYs11tQRbhvnUek=; b=S5ddSIAja/HmRPvv
	wEdLE5bOOr/JOK0h6GpfDvdM2/kZ5LjJgp1DzU/9AHlcp/6TIWF47VixlMtGva+S
	GFBAbSXucMQ/IUB6zt04Epg0yk0V8vgHQXwAFnwuMHVK0GABUHML4QiU3M87r95h
	E+4NGc2BnSZD6w35GiW1G4sxBNtsU9vLp3MLr7IS/jj6im0/xPWVhqfihJV7wq+E
	IKFLKnTTrxsZi8fSuyjKiBmOFhBO2ivmxGcd1YmdIOwlDRD8bYQXo3JN5ue2GAOH
	9JQWudEF45gpDBR97CMcTrWENQQAW9xXwQJYENjoZ9LfOK2CZ59XBXUXCM24s3kd
	mSiVYQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxq6v083-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 10:37:58 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b3510c0cfc7so3191844a12.2
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 03:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908677; x=1755513477;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3igM380Sl/mCHIaNQCGmITwSXOBNYs11tQRbhvnUek=;
        b=PHRRNM0E9faoiOuB0XYn91Lj0YrcR2ppAIwTV9Sd+MdvlOcwXfHo1pOnytkk5ajzHk
         tBuh0FFNv27F+Vn/gfOAd3iaTLooc365ZYtF3wiOQqFt2Qk2tZqkuL4WPOurFQwFBbT3
         Ov/u+NMVOnlsEmKtqDjQerVOo5P+Ek+5aNuFXLmJ4ZtMyc7WxyJ+9iOb1sV6lOoQTnH4
         yMq+knSYDn3tP60cKtJNUaGrcYoJ6LxaLznd5o5Pvv3gMKbVkdfQZ8pB4iPeTZPDNY4n
         udl0PZhOHQNh0x3Bzbf2pXO9JCLhUqhMB3+fsACu8bjBefnERVwDisyTxDXbFY03cikw
         01iw==
X-Gm-Message-State: AOJu0YyyUK7wjwhP0WBBrVabuwCTWdiq6dYBy3PFDZ0DPRmsUDWiUa9x
	vGWJnvp9Erv+D+wgXUe/PWvYl3u5wrvNsA7LYKw2WrUwiz5SeDoXp4H1rVy1L9QfNDlIX5vGnBr
	Y2OTpCQrAhQbXAQKQFaUYz8zG4au8XeUOdD3fnbkRcNJhBRprzoMnvDQEXcU=
X-Gm-Gg: ASbGncvaUqyHc+O2FBOVW39R4cVITNguPvEusyVe7IW4jwNuc24wi+XW6+6B/chyY0T
	vek1WgGB9wwE2xoI3v9q+88ki8b1BSFPjk6PTuSP0jRIv0AgcOFBaaNJqYya5ayvjupx6NagJpM
	8vy5rzanYD9M5LPe8qdK5dI+WCt60B87ZEEbnKwr8efRvS8eYtdpdOnmtKZTGlK8J4yHqvTQspj
	64F6RDOdZdJ6jR1xnRclHHkXDlXYM+Q9uPJ/ShuJfXZV/i+0zhKe0toBkaejQv4GkeZNvYIlp/x
	in+inFa02YmGUxGk+j1zUirfNbZIFQrYVRpJ8If7
X-Received: by 2002:a05:6a20:734f:b0:23f:f934:19b9 with SMTP id adf61e73a8af0-2405504cb40mr20245802637.14.1754908677652;
        Mon, 11 Aug 2025 03:37:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCXTHsPg/7tVovNsk+VII5GuETNkYA1CNQuye0xMFRhATsoq+G9PvJ8YJ7dC9er9GV1cVQNg==
X-Received: by 2002:a05:6a20:734f:b0:23f:f934:19b9 with SMTP id adf61e73a8af0-2405504cb40mr20245777637.14.1754908677282;
        Mon, 11 Aug 2025 03:37:57 -0700 (PDT)
Received: from [192.168.68.106] ([36.255.17.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c61705bd7sm5516251b3a.31.2025.08.11.03.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:37:56 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: stable@vger.kernel.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
In-Reply-To: <20250806192548.133140-1-marek.vasut+renesas@mailbox.org>
References: <20250806192548.133140-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] PCI: rcar-gen4: Fix PHY initialization
Message-Id: <175490867407.9732.16514793693327960028.b4-ty@kernel.org>
Date: Mon, 11 Aug 2025 16:07:54 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyOCBTYWx0ZWRfX1sDyJ+R/nGEY
 7z1i+UvieShujdqakvMSHq2DLwVwyUXx/KIsDdyklwalFPcoGO/dUTJtyQL4hM+7iIMPSHaISav
 jK9W3iCA/bw1vbyYUKqY/ydChpyawFeERNPdL1CS/P262gn7BYPa3cOZTHTVzKLbXdqjjucUQ5i
 Py7NQGOIwPPuwthlAx0RjkGRLKLyvTEvVUeWaQVFvVzi9SwaGEzAtViRUyi+WL5VOVsbVE43jC+
 Cay5nGyBaCV9Xr7C4uGZFwihxpFIkn36KcqiiIwMKjxXeUxc8gmHAOQRn5ruZZ2xZPAUpM3uxwr
 BprSnxBUuZEgMEUbFpDqy4e/JhFEdUWgNafyGBVIKADtz9HyieX8AvOkr5En/bZGizIS9NLssXV
 J3txULvk
X-Authority-Analysis: v=2.4 cv=QYhmvtbv c=1 sm=1 tr=0 ts=6899c806 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=tivzXH558BYE5qsfyb1zSA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=GvldxTfKssXe8XXbSUYA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: mn6jXgQ4N4fYk-gcm-nEocr5qXOHx0dm
X-Proofpoint-ORIG-GUID: mn6jXgQ4N4fYk-gcm-nEocr5qXOHx0dm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090028


On Wed, 06 Aug 2025 21:25:18 +0200, Marek Vasut wrote:
> R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025
> page 4581 Figure 104.3b Initial Setting of PCIEC(example) middle
> of the figure indicates that fourth write into register 0x148 [2:0]
> is 0x3 or GENMASK(1, 0). The current code writes GENMASK(11, 0)
> which is a typo. Fix the typo.
> 
> 
> [...]

Applied, thanks!

[1/1] PCI: rcar-gen4: Fix PHY initialization
      commit: d96ac5bdc52b271b4f8ac0670a203913666b8758

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


