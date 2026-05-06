Return-Path: <stable+bounces-244367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHczAAcp+2lAXAMAu9opvQ
	(envelope-from <stable+bounces-244367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 13:41:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7394D9CA4
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 13:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F9DF300EC54
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 11:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854543D51D;
	Wed,  6 May 2026 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDkpRUnK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MiWPpPMa"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4631743D510
	for <stable@vger.kernel.org>; Wed,  6 May 2026 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778067639; cv=none; b=UVYyQlgEdK15AHtvVQhkGEETU4177ffrZ0Cgfj+xOYyN37KfdbotrRjdjDx1SiALzsreHgpBNIOKaoXM+QLcbGdYG0gWmLH00/S7JLEnTOUXpnNOoVdMYIT8FlCY9Z6BoafYZqP8FpQCb83HBY5ccUi+cpQGxiAw+QEL5rvxMPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778067639; c=relaxed/simple;
	bh=YwHnAea+ZNdBKSZ+FdKL95GqYoOJftrvBMYNNriODHk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lc+A4hkGMTvAqg0HqDDPALNVMXwApFWVBJQrVotoHQ24yFGVAK2wo+6geDL1uVAI09nq/hmooTx4ECOkF3kh3dnT0NPFYuW8eLthawURO3odM787hcdWRHn6smMR+KvXY0Gqv44Y1FooGTfS0+jcR/81Yctb3fubj9QvAEh7Qho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDkpRUnK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MiWPpPMa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646A4gV63524218
	for <stable@vger.kernel.org>; Wed, 6 May 2026 11:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0oPLdXXouDVkhJv0oKpMf1eGEE226oo0STDXOOYuHJQ=; b=pDkpRUnKxfGFLMT5
	IN9zzXR7jhmgMF1GVsF3zijISdON48bJVwWva/q0u0GihR5r1vz1O+2J7MsBo43P
	cqZVAU11HbGoawH34omEc3A++vGylnf9Kb25BsYi1w1dTWZov8Srucv3oMR5sb1W
	LNoWgFdQKjKrekMnMgjHRT4egouTlr60rtxBzR0T1v1RmzC2BIdrbd8VCCGLyVK6
	AjRB8+3XLAFpEGJcSCzIxHBaWmL/MvWYb39ydI1kDGjODtj1ktEE96R6GOmnFQsI
	w66NyMy9WFDMvwwXf1tsubzcjgHn2DVJLyq8nMJRsft5JWnYUG6sBbWtlI6wZ+sm
	mALumA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jwr9f8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 06 May 2026 11:40:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so444685a12.0
        for <stable@vger.kernel.org>; Wed, 06 May 2026 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778067637; x=1778672437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oPLdXXouDVkhJv0oKpMf1eGEE226oo0STDXOOYuHJQ=;
        b=MiWPpPMamu9IakjjjZRYwlo90mC9XN4jspDQq+tMcTJRzr1LHuwCz/kLY3gtG6ifzp
         dO/E+BcfbmnyxA8q4a/gqnR31KyT8JbcY2dB/WDGLoSX7P377Bg0VKnvkvJgG0cIwewb
         8H2rM9v1Ur9w+No8znoQJJnIxro5c/iS24SKH955VDQe91+2bMMcjN21uoRuTUh9c00i
         SIMCDub2f6wh8vUSjSWw6nKxsTVePZxdEQ5OqTWxY/B2a0xlvsFQBUwsERwARUSDYXW3
         ltOwrzKVkujJg/Am0KkJ0OGq1bwGe7Qn060DU7l3YOOq2PCwTlImNbD6k50hoYjVRfaT
         BbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778067637; x=1778672437;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0oPLdXXouDVkhJv0oKpMf1eGEE226oo0STDXOOYuHJQ=;
        b=YpOJv2bmdD68TZ2HwvanBZeF6jnL286yngWX+YmKK9DXVnkn6QrABhs2yGrPrmAkUG
         WMZHt8eVsUF1Gx5UKcqfCo9u7mbax4Z51eZj2Kr1Sxf/1JHzi7heM4BbLHJJ7EfzemOh
         tzNHMNf1Tn1Pwi47R0woIMsND/m/0b4LmDr3vQnoFpD7QT25RaUpP3V8lBSrexoELlZj
         g0ZQ9G/rE+WC+RDyoc3mKxhkRqeolassKEXm0WMTxWUVfyBt7RA7TIlP9AxGceGpSJQ+
         ScSPfe03u4V6rk+7bNBzzngitmq6e82u/s7Md5GBDsBbXL/H34Df+HdqET0dSvhJfz+3
         xAUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0DSIaYoQwLgd2NiA6wlb734jZofVDrdUMebJ8kwLWUxI+PlBU+hUBMWQxvHUNAQnqtrSYr+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfsX+QHhkdtLqazdvpNjtWg0Ta0v4PZOBQrx5JoNstXkhRGuIO
	SR3JHskzRsXZNb3pRVqeFomu8VfMHb99sr52s720aOjx5aFvQ0mFb/DWiytQcsfYM23n06VoczB
	bc7KbVE58oEub7b9HR7xIs4rHXqi4GtJ/x11sMWJY6Cs41k7kJctdInqhKDo=
X-Gm-Gg: AeBDievgH/itn+TDkbOb+Bdoaoc9G4IYIcUJTrlCclMpLhgsIoMm5Y3nxRxxHbYqta7
	QHXHu3VHqvoH/XO/UFvicG4yNt9DZk6A+J7qonSFoNyOrCQqyWAlCWNhLctl6ozdCNvc36LBe1D
	3r7ASvwuUaWh/+RLy67Ol9cKnjS65yeakSgQj4TBXWBKoZ6+CVMSY7nx9tc5fqBuuNkYlSHWsRN
	labnAikDI/OXnUKVrmneTVm9PnGX1f1RwllPpChi2EFFpdOHl+Hq2BpnzSZgTc6lKrWA6uKscaq
	lKL60XjHtezAgMK+v/xsJRXxPrqWJmxNtLLcUs//VA5dKP+/M2cysgg5fE2OjkkIj554rCLWqik
	yZmtvS8mGBggxCUjRJnuV3qHR5JOBneM=
X-Received: by 2002:a05:6a20:3d85:b0:35d:cc9a:8bc1 with SMTP id adf61e73a8af0-3aa5a315ec9mr2589455637.27.1778067636416;
        Wed, 06 May 2026 04:40:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d85:b0:35d:cc9a:8bc1 with SMTP id adf61e73a8af0-3aa5a315ec9mr2589412637.27.1778067635781;
        Wed, 06 May 2026 04:40:35 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.67.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm7058783b3a.16.2026.05.06.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:40:35 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260319090844.444987-1-hongxing.zhu@nxp.com>
References: <20260319090844.444987-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN
 handling
Message-Id: <177806763016.14331.14072129675795042605.b4-ty@b4>
Date: Wed, 06 May 2026 17:10:30 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=J4CaKgnS c=1 sm=1 tr=0 ts=69fb28b5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=SQtj7D3ryojUavkWoQJ0Rg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=VlnV4lHhP5wV_tSmghEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDExMyBTYWx0ZWRfXzAVMZe18F2hc
 E3aF4QiinKNZESElUYCrdBkOWMbooefFtLRnf1FC8ueFO6n8RbjoyrlHzGXFoXrrhOdfcPtS0z/
 9Eun9bYPOSJbahvuksJLw7gPJpD4byVE2/IGIMzwNfSrAo/g7p9mts7C3LI9h145U3SribSzM3J
 PnIg1EHvooWKU4djHEtWO3l2byPAATLLP+eItFOsJztmkqbTBEhKhNTjFiFRNhfwq6LidtiXPmW
 qu4DRgQbRpG4QQQGgzWERI1AMN4wT2zl8Qp3GmpvbLH0je+Hd7v3A6vRl2yJbVLacmSmbYLUNJz
 wgjBQ0lwsft599PgMJSDH3nAgMxaQZK+yHK9S/lGSw7WI3iJLx9ioS+F85U9TjRwYukoS0bb58T
 YA/+2cPvVPaEP5E8vQep+qFHdTU0ZxF5JT+s7A89wSm7Ep3u1hDgkthk+alp6isKpVKX5mL7s8s
 AkQGdaYRjKcFn3f6ysA==
X-Proofpoint-GUID: iVQ1Y_TxodDa0CYED_zCMHH6h-GclJRU
X-Proofpoint-ORIG-GUID: iVQ1Y_TxodDa0CYED_zCMHH6h-GclJRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060113
X-Rspamd-Queue-Id: 0C7394D9CA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244367-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Thu, 19 Mar 2026 17:08:44 +0800, Richard Zhu wrote:
> The IMX6SX_GPR12_PCIE_TEST_POWERDOWN bit does not control the PCIe
> reference clock on i.MX6SX. Instead, it is part of i.MX6SX PCIe core
> reset sequence.
> 
> Move the IMX6SX_GPR12_PCIE_TEST_POWERDOWN assertion/deassertion into
> the core reset functions to properly reflect its purpose. Remove the
> .enable_ref_clk callback for i.MX6SX since it was incorrectly
> manipulating this bit.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling
      commit: 5a8c573879379eed867d279f7437dd4e3aebbb7f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


