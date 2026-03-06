Return-Path: <stable+bounces-223315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF/mMCSFqmkdTAEAu9opvQ
	(envelope-from <stable+bounces-223315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 08:41:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485221C914
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 08:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A74763045240
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96AB375F6B;
	Fri,  6 Mar 2026 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CADg3UBE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ap0HwhAD"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A343783C9
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782876; cv=none; b=KzcrVQV9fZb3i85vjmdgKuGokispoKTqxbPlbacZ2orW+gSXo2Rjekv1HPQEJBBQGFqeqqZKPX4rMJZByXyCuU+nN14kSVFZo+A3tyTYDHWRc70HTvMZURKbmm05upPN9bIe5Nu2F7wNosOwFQpPsJZSLYjIXtHuBuAFechi81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782876; c=relaxed/simple;
	bh=KBqTZQUmVm1l3TMx2vocMDlDatncf7hKM+rVdpjNXZk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tNt1Y0By4EB+MovEbbBFMgFuWLdHEniIbxVOZTtOqas8gLmiNBggx8tUd7hZqSNzg3vxBCIxshe8Il1Jg6cepSRkTLwkH8d4iCM9HySaBgjartEr+WlKbPx6iz8eyBns6KPYsnTaO4R2+cvj8itkOvE4UNFTiaupzwR9ubqKZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CADg3UBE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ap0HwhAD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264aIUB3297827
	for <stable@vger.kernel.org>; Fri, 6 Mar 2026 07:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CiaSslmCTrFWUovPnExrsa13sAVJv0zHhYcKCq796dw=; b=CADg3UBEcph6bKGS
	nVrjTHTJXLEOLau4WU7ELzX30cI602IOrEvgvmeSMzoVPFJEbJL8GogncYQ/KSTj
	y9/PyqxzZa/5im3yIi56GBwrgyd56BYIoKlmwhCvg4HMWolr67UxuwaNcaN+0zxz
	HNDzouQr+0B3nJiKlWyi1MeTsd/b57CTrbknD4EhvfjsputP1Mj6HVBNXYuDphM4
	yucd4/pyeJOMGIUT7+BRFoyG9ZvGCKzyaCH1tY/YvPtVol98zVpKjMSB1IZLj6aB
	q7rCF4CswE6djxmiJ7Hvg75lTI1yamoMbaBjwp0IpHntfMXVeMyBlNfqnZnJUoJG
	Nl9vNw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqpxdrrg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Mar 2026 07:41:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae5031c6c5so242989735ad.3
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 23:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772782869; x=1773387669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiaSslmCTrFWUovPnExrsa13sAVJv0zHhYcKCq796dw=;
        b=ap0HwhADyPyQjFCylmsXheVfug9XWR6ienwXryAryzYnmhXTezcW0b3k4uhBJZ1L/r
         nWLOFtR4XlJh9fyYCM2tLbTlI498NxE2bbYK+VdjqrFkM6JMrepLI4LvJHEWFBAI7EgG
         Kg4XEa/mDD+v1U1Zw3LdWaT/bff2FRPsZEJ+qgjaSqvZaX3T716O/qoRtIN1mMPx+6a/
         aYGSjqs7TiawJVXehSbaUNojeXToXbFDPVMd2Q45tYONqkMwYddSnyFrCBeyKaKvBFAh
         DBoHZX9H3jEwlBUaRtCmMIMaWowaN7zA1fIIyYHDIAJRgaeIq5znSAJHHg1RMWhAbG5c
         jYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772782869; x=1773387669;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CiaSslmCTrFWUovPnExrsa13sAVJv0zHhYcKCq796dw=;
        b=WS3pPjJMeU/MbKwgRYEiUDMrDu/keFSGhHx+RqFnufDeLHHFeXbcq1XlBq09XPq+gU
         5znCbTwsbx73wwqmm1Nc6pQtLy/ppGhOTZNTx1koWh49mtuK8aNxBEIFGY46f0TbFVSP
         4ptjeuJGBP/aKBeI5ZaYXNC5Y4byAmEjF9X+7ClIA4zfBYbNWhzDB7tbN2ZUDm71utX7
         tAXJQZHtbu5HQld/8OjAenkFRw2iGBO8g3PFhK/DPj64uE7Y3lAfYO/AY0uhs0xA4wTP
         nQNwzInlI9EfU8Rmca9NcqF8i7j+AxwGP/ohBOiBq6wzs2L9Gdnn2Ltv8CKmobFw+FJP
         4Z5A==
X-Forwarded-Encrypted: i=1; AJvYcCVq2U5pExmcAWVM9EpDP+x7JXdtr/+60mNsLxFXjRIdPyuNbLU71CcsJhvP87+nNpV830xp83s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKClQAB9nbUWFHKm1/r97ibD0VKQbRYL57E0A+RzrOOUUcTNiA
	swTP6SgcjISbohraHu9PW8GK9d6qTpqDZWnDvYbssSCSgsO1Me+GUAm6xr5Y+ArMLbKkSg5Q9Hg
	Ytz73WurrCV4CoD3KyyLr8fNMGQaihVRCpNII2QR5X1s+TD8CrfkIVzhapyo=
X-Gm-Gg: ATEYQzwJ6t1U7jmFlUiScr2lfX7vOmArNrNg4XcyGFfeEwxRJtWkkuvZm/2FvPb80XV
	6nk1Rio03QHf9DtMN4Zd/sbrlNxJjEpLDvXL2ypNFbdE8PDYx9F/6Wss/GKIrZcujEbdrBcOJVP
	zNXy0WRAx4AM8v02QkuJzBBQgUWzQ0Q2x1b/GEq/eu8B9jrudcGp56Hsmn5hIsx7SNMfVu40g6p
	3xbkILR59ya5Cy9roHEnlcVcdgiGz1cBMx10E1zqRuHCwLjFIeRyPPrY28qZhBfSrSwD081SuvX
	uc6O3VyWgDTeSqjhKDr4+YuATvx5h8w+y6etPG3cPC0fbVxPYd3rXPJ8Lo00TstuMcxWQchadGs
	VKFu6YpClsXzgY0TM47oNUDzYdXQntP3UEscuZK4OVm5WTPs=
X-Received: by 2002:a17:903:2448:b0:2ae:62c8:771b with SMTP id d9443c01a7336-2ae82367245mr15289965ad.10.1772782869035;
        Thu, 05 Mar 2026 23:41:09 -0800 (PST)
X-Received: by 2002:a17:903:2448:b0:2ae:62c8:771b with SMTP id d9443c01a7336-2ae82367245mr15289775ad.10.1772782868548;
        Thu, 05 Mar 2026 23:41:08 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:a6f5:7b5a:25de:64e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8baa3sm10541835ad.65.2026.03.05.23.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 23:41:08 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260303-b4-async_power_on-v2-0-d3db81eb457d@oss.qualcomm.com>
References: <20260303-b4-async_power_on-v2-0-d3db81eb457d@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] bus: mhi: host: pci_generic: Improve boot
 performance and cleanup
Message-Id: <177278286480.10289.11737446909883935736.b4-ty@oss.qualcomm.com>
Date: Fri, 06 Mar 2026 13:11:04 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: U-kpIGAVIC_qghlHWogGzssA1EMLSK3h
X-Authority-Analysis: v=2.4 cv=E83AZKdl c=1 sm=1 tr=0 ts=69aa8515 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=nnaEIi7Bd9H0Gnl-4-0A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3MiBTYWx0ZWRfX2fmJMfxiIBR/
 IHCr/9GdsyMdnjPoDhupIO2lGIMacrmXzK0eKhd/1+f66FGA7AkmcdcfZWtD4wfdv9YPfu+LiEi
 7zn3JtTdCyluyL2MaSIILtCYC4s3leGZ9jaBHfsGYRErIQfk/iKlJ3jSjYETLzb69jPVUO58+yc
 /7evyF+IvPnt/1VbBsSstWVk5rGHJKC8BOhGszbP/sjWNvoP4D5Viy9rn+wMa+QsgavCB9En0sP
 62wnk9Ha7w82izjp7Rdszob5sfDSHdNwqLREz/2Yr706Q3bwTICg6VyRIyXcpfZZodtiFv1XbjD
 4OFaeKxJgkEQG2baXn816COQlSEZ4Eq58p5peGfUKE/IWHx8I/61r49fQ6ZhGGSkadcTcSy8zqy
 BJvCCtYMIGhLEzkWGWe2wOZRhZ+eA2PssTE3kGYCHQi28XAi35NX6CYZPaZt6R991aJXhkk1Rw+
 gD252P8wAiFQGD0k5dg==
X-Proofpoint-GUID: U-kpIGAVIC_qghlHWogGzssA1EMLSK3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060072
X-Rspamd-Queue-Id: 5485221C914
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223315-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Tue, 03 Mar 2026 01:02:12 -0800, Qiang Yu wrote:
> This series addresses boot performance issues with MHI PCI generic driver
> and adds proper cleanup in the remove path.
> 
> Some modems like SDX75 take up to 20 seconds to initialize, which blocks
> system boot while waiting for them to reach mission mode. The first patch
> switches to async power up so the driver can return immediately and let
> initialization happen in the background.
> 
> [...]

Applied, thanks!

[1/2] bus: mhi: host: pci_generic: Switch to async power up to avoid boot delays
      commit: cfdb41adf1c2822ad1b1791d4d11093edb5582b6
[2/2] bus: mhi: host: pci_generic: Add pm_runtime_forbid() in remove callback
      commit: f227b246307e0cf3091e13e7fbae3974aaf38eb9

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


