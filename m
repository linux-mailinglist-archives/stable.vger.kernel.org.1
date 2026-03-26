Return-Path: <stable+bounces-230502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOpZDwVmxWkn+AQAu9opvQ
	(envelope-from <stable+bounces-230502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:59:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94013338D21
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F880300BDBF
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BC3401A33;
	Thu, 26 Mar 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PFnsfTfs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pwnf6OGG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0072C11E2
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543997; cv=none; b=APu6xoBr7P18EMtsTm4cFBYs77OWjVklMlPDYzHtViDEJavoMFlg2v5xD0Sermru15HbBVMNAqv9QcPOi3DCd0aMpQmm3/w3Q4blrz8dwT9HyQJdNVM1E7IuWfKnM7oTd+qzRUCgNbMjCdAWQBCjps0AP8D08gmP1bFUG6NiH58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543997; c=relaxed/simple;
	bh=a678yhp3JDTo7rDUkiJiYhzXeFmpJaBVhgpe2Xcw6B0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gM39zXniVDa+/hKCx9KCQ1SKkYtMpnMimnqcSqW4m5Dg3qYJUiTQUFto3oLFvHvmSAPT5NBXReMSywWGkVb5MuimI8l/6HtMpXFEgke0dDD3NB+6GCJXF3ve1Y652dRnhAbiRmsPDd1tlRy1imPUKXHS2S9rwYsaj550fkRMOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PFnsfTfs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pwnf6OGG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QGKehR638789
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fg9vq1NSbflBQy9gaZali+s+bMitFkQSj4SmPdzwvoc=; b=PFnsfTfs6oJ5S1at
	mIrYfJRqq+Skz3Httf6QVckjDdKrcQ8E6KVGx1Wn/Ea6ebujOjTzswIZAtcu5tdN
	zcsIZftZ0cUN1zv4QSM8o9fgqsylETavI24SNdrcYVrxihmcgkD8HeWuq1Snm07n
	K6LIRxu4COIzJy9fAsU7vk2dg2rVfvA1iOshfn5T2+/lU51JQoPeQm26XxB8GggG
	5jaAzHGlmtYaypbYEl3dJxmuhuoybAZsyCjVj/1N7PZOycky66I8bVOcAaeW9lyW
	FsjstywPg4lUJPCYGProEuxjxzeUciMFftCbQhWgIkDBnjUTQCKrKPCJ6L4BLbx/
	XTdstw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5883g487-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:53:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b079b4a8c3so37989625ad.3
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774543995; x=1775148795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg9vq1NSbflBQy9gaZali+s+bMitFkQSj4SmPdzwvoc=;
        b=Pwnf6OGGpbw9c5pF6Z+AY3zDJsDzIf27UUkhELw4KpvGEREhbuHh8OuVlivu2VKG7d
         7WlMAZhorOXIPqvHhZrqgRVv+xHuGhgb1g6IVZLZB1nNzDlycq/NNlZIU64mjejoyQCh
         4Yrqei5DOjbKZHQg+JTqg4NmTwQH+yGK+YCgJLiihYB8pFEKlMLTqJNVz3lR0fpHi2+B
         JGNKhbNvU3Wi/qDN5KhgYtRAF475gasi4XE5V+YEthlzzYhyi1A/tpw45S8+rmdDFKYT
         gw8dEH7hCRYbYAkiDoebJjdoV2M28OemNgwgdUwfGyw327e8YKpZM676l4aOOUDi0iHi
         wQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543995; x=1775148795;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fg9vq1NSbflBQy9gaZali+s+bMitFkQSj4SmPdzwvoc=;
        b=S+irHnQAiXbK7leBE3EeNVIPsnr5gprxIRlk311E5z2Bkq5CwZqMxSyhsd8mtHA18d
         EnTgrhKiJGqzEqbd24BxFgn80DAH+sJu8vLW5swJVqYWz/MuCUj9yXWV29x73GRZio+E
         sSzWwaauv9xxdPvCqhKXqLKk78L4kwRJ5XgST9pIHd0poPk9BhhUEUUNDhOg9uJo6bAF
         RYvdah+BxH4fMlxpIYasCgjpwLuOWFwQdP/dpOpDZyjFRUHA28gMktvyU7r10Pw2+H5s
         yVtsyinEvARdoYEPCNGBhs7U4OhX2aD7gJ/fRQv99U79Andxi4guO1RkaIxsk1qIZyDt
         D+Og==
X-Forwarded-Encrypted: i=1; AJvYcCXLL2MBNoMiXBO9DlbKutoZd66WRXFxlwElq1fp+96XV3l00FQYe5+GqGSYGaxDFBj3VnUZ2mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6DwNi17caku5ZAaIk+G9+jiBTv54BvpXpzi1GH+QWiUtjJlxe
	/XG2xcp1Wg0RQ6DGD1t4yavlTQVuA+nsueTcXp1ev7byxC+hP6Jot86oHdavgDF71tWwlxflMNP
	QIZ3jGNiaAO4F535YhGQZm83wkLfyD8qC/X8xcXRqhb+UfkLz0j2SEfUNvVo=
X-Gm-Gg: ATEYQzyxuqIhLB6lrj7++Iyi+ZTWJIocNvH5T4IXe0tA+hR1EqBDBP8lv/9360qMbgT
	UiH4s1qwUE9iTBSV9+5c/RoBiAEy2XDKQUPPCeMWNxtyyxpzQbsDBwpMjO8MXo+Axx/WfKH65R6
	nQsB4xytxaWNRQ/YzPZV/NRRUbblmvThAYY29F6P00GO5Qv4/FpM6hX3oz6TAsvJDJTLHSNjFPa
	UeacpPsa7vqtwcVB2v8Qea0AB3+CGB3NOoXNgV64djAiM8ATypVf+EkuLQvaIu6zCMWrLM6Y+fk
	IfKLIgNafdHYWPf4lOT4RbM87ZacGYL3zky3kcuEFxSoTmf8vhDj+tH6gzyddswlybzYllo4EwW
	WM4BM6+Z/ZYAQjFFSc0/KSE0=
X-Received: by 2002:a17:903:3884:b0:2b0:a980:367c with SMTP id d9443c01a7336-2b0b0987e22mr93048385ad.2.1774543994694;
        Thu, 26 Mar 2026 09:53:14 -0700 (PDT)
X-Received: by 2002:a17:903:3884:b0:2b0:a980:367c with SMTP id d9443c01a7336-2b0b0987e22mr93047995ad.2.1774543994189;
        Thu, 26 Mar 2026 09:53:14 -0700 (PDT)
Received: from [192.168.1.102] ([117.213.101.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7bbe57sm47090225ad.34.2026.03.26.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:53:13 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <20260228080925.1558395-1-hongxing.zhu@nxp.com>
References: <20260228080925.1558395-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v1] PCI: imx6: Skip waiting for L2/L3 Ready on i.MX6SX
Message-Id: <177454398920.452566.5271838432728945617.b4-ty@b4>
Date: Thu, 26 Mar 2026 22:23:09 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: 9scXxBA1AhRWN2YMB4qvtmLF1PhPimN2
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=69c5647b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=pjPfvbXasfe8cMZvnaMi6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=rcZeYksTzYAZqbyAQKQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 9scXxBA1AhRWN2YMB4qvtmLF1PhPimN2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyMCBTYWx0ZWRfX7qzLVN1bgY7o
 iQOmSLpQq2vSNJIJRqh3ECTjjI+DrIZgP6vDk2/cnRebD7/yQLBJeqgrCWFT++Ku+aQ8i3kgEQI
 9C9aU+5l4i0ZRDiCjBMF9+LTbw8g+M9/xqIzzQZWB7+vwcAysjv2suOWPZKalaw+A6XmmZ1Bk6L
 qnHJkWfnxstHer0A1I2W3VYrHxhlzYXANl6hFIeEX40I+eYK/0Gke/ED9RgZuSLiWXHUW3h6cU2
 XxDit8W3PUUhc9SLNFVoX23INX77ZRJVqthkMGf1SOx7dkHKF2C471e6lf/OZBAE6KPs/aUI5Ym
 /vvywajNlDCYyAEA3C4Wi9MT23Xw2gLv9GAF2wv8TtwUyEiQnvwxvvJ2kKFzRevSsv/pVLxSJbY
 k+gNtDhD/HZWj9LSY7OxOzjA9MmRn7OYmkearF5Ee3vAuZPFd/pId2uHd8S6kVq8/GdGkzrbKTB
 1H84jb0jP9nTWxyJBSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260120
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230502-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 94013338D21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sat, 28 Feb 2026 16:09:25 +0800, Richard Zhu wrote:
> On i.MX6SX, the LTSSM registers become inaccessible after the
> PME_Turn_Off message is sent to the link. This prevents verification
> of whether the link has successfully entered the L2/L3 Ready state.
> 
> Add a new flag 'IMX_PCIE_FLAG_SKIP_L23_READY' to skip the L2/L3 Ready
> state check specifically for i.MX6SX PCIe controllers.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Skip waiting for L2/L3 Ready on i.MX6SX
      commit: 5f73cf1db829c21b7fd44a8d2587cd395b1b2d76

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


