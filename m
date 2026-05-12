Return-Path: <stable+bounces-245442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H8mEuQQA2rD0AEAu9opvQ
	(envelope-from <stable+bounces-245442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:37:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B39C51F710
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E3553030999
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48A4D98EA;
	Tue, 12 May 2026 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1WfPUjP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YIjk3lrE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6604D2EFE
	for <stable@vger.kernel.org>; Tue, 12 May 2026 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585822; cv=none; b=Veuak/7NUNYxXx14EA/WS0I+cO00gAWeWx5P7z7mAV+laq1CiCqZ5xHJGNPXmK9BWl7BYvAc0XTg+TKvqrmGTDeb6UyVOknCgGftNWVH/rU/Q8xvOGKiq3c9ySigdgetuCAYfRzwJgoiq/hvm9SvtNq3e0fk0hIJvro3DBM7fDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585822; c=relaxed/simple;
	bh=8U1Ja8P+VJXeTYjM2KI07QBXve6dg9X7VaRLyfyRjQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IbTSPtc+bDTxPc72NKsMhPUWOYL4m8FIigb0OyXnRxFtsPKlifryz1gUw3VWYCJcvNal7ycTDwE0yPKMBeI3mSzCBV/GgSLWnp1tWIWl71ww1Y8XWn7oM1IKZofusa4yaIBYdYjoZNWn2DAzikxN1x3vzY2M6gOeNJpLg2nHoew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E1WfPUjP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YIjk3lrE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CAke7N740581
	for <stable@vger.kernel.org>; Tue, 12 May 2026 11:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3cBTDDbsITV08dA6vkggPs2KMXQ9klD2DkmQBC22iek=; b=E1WfPUjP8ZtMxZ3D
	YxwAq8EBI2Bo4lE/2GMs8Sf5KYGFXvg7CwKkbv0pmegVAqtxu03mFyaXJethDD/b
	JgT069pLF2ukFFA/mz+X0H3bL7XkR7ZdrWakwnM4+TAlh41UG7AwEaPmx4YoPzHG
	JVgE+qBYWmTtPJPnd3gUO3VH1mMn8pgPacGMV3kkeJ0B8P1OOLVYW844chuDNQB9
	WVHwsZOz5Ha3imG/TgcUpAa5fbdtY6fMM+2XTY0JEKgE9idEuNLEoYqzvHSiZ97G
	y0tmeAv6HUEhYr6X3GK6HZys32GekpDTNYBbcBBdaDaRm668NHOMqALwXIkX32Xj
	jSxi8Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e42rhr7uf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 12 May 2026 11:37:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so5537931b3a.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778585819; x=1779190619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cBTDDbsITV08dA6vkggPs2KMXQ9klD2DkmQBC22iek=;
        b=YIjk3lrEojMXUP3GokqnHJHcH2RieP404e09g6WGGu46o4OqXuWbGOLkerqfeA5Qej
         pAVoZSGQv8bdGwlAfQeqHyIoUy4yhM8Rv1EjzE4olwtLxRWGQXUrC4heP1LHschA3I0v
         H1lCGcMERCZR5RJtyzI56VrkYjdzV5vPqlvR4fqcVIdLO8ZXAKMaZGgMqCpM//h/ccTQ
         B8tUnM8ayDzicGAX56YPUovDilbFNCd74BLZUdWu8Nwvakb28E2QIxltZ0CY1dN8Xhkg
         tl29868oOryWwrc/w7fBM9o8iIVQj/vKHMShKQk2kZtcw7GPAlCEBLBTZXQSVwM62iMS
         t4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778585819; x=1779190619;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3cBTDDbsITV08dA6vkggPs2KMXQ9klD2DkmQBC22iek=;
        b=BEX622Rj2Q/QchjvncdBYBUhDpZH9oJ6Vo8xDYjDzFPOoZp0YzG5PXwrN4Bcgz0oxu
         Q9M8hSuPPQxdPLI1nZuLKHykMgsvcoP7xw0TiFPFUzrlTc3ClRVHkICVD8ZVGMPZC/T5
         ga3MVmlvKgzWQThcjehf1rs+wspBqurTy95OoHGUonKtbGxEpmEnxDIx9R/Brv95iSC0
         beYHrQcQ7U2fO1ov4o+af49KMGha9IUgprcF6N9MWaQ/CvbXS/vqnEai7A7SixT48bvp
         sW5comdBaVg3h8J3aPXingHXynoFZH9dPLvYVTD/pgzhAxzjt4vRUNElI8Gp4L5qprHZ
         nIpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9f+oKZSqFcXpNOF10X63gYKBYYrv57vMu9Vc/nhwJWC5iqVWS6ytPtcf9g61BwrWXebt0p/Us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7zqCLEKmSkCxklcuEcBChUPPERwSXGcE9uGtwt1M9or9RDYvX
	EWejT6R8zL0V0F7s3KlQbcxqhlXLLSGqbG3/o3hVxFg8A3pCqlyz/g9LLgFuY8qtZTWOQ93fU+D
	zkLmFV5mZ6AWHXUopwDmrnfuSzlDsCalt3BNBYXFNcbzs+vKSQS75D5rNHqY=
X-Gm-Gg: Acq92OFoamnvz4lO5h/Ii94kvSYtFmUinXdzwuhBiylkyM/DVedCydBqhx4SgCiGUIt
	LHjeJSBdIxuelYiGPK+vMwNpp8cD+2F8c5QgnG9MxlPHeTHSrhdO8oDLXyVH0HSjLCSNr0k3Wuc
	rD8Cyz3F3GKOpb5541hNaEv9xKjz8MNenT4eOc+56nH8wIuXQUQr/bAgff1IijltQQal5ZRiC2P
	4/GeuJX0j1qny96ZlUhZ4VG7X2SyobfZbPVvfGOA29DiWnvv0g4S2phKW8c/tT5grXUIWD/2caM
	p8ru9icceoUaOt9ShtTEKhByuWMdtVTHgqrbplsJyzApLOyHB76wQwuy5tkH0Ym9NR8zbir+T1G
	ue2Sy0YajGD8SVMu4PpnT
X-Received: by 2002:a05:6a00:3309:b0:82d:162c:581f with SMTP id d2e1a72fcca58-83e3bf8f281mr15611644b3a.48.1778585819179;
        Tue, 12 May 2026 04:36:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:3309:b0:82d:162c:581f with SMTP id d2e1a72fcca58-83e3bf8f281mr15611600b3a.48.1778585818664;
        Tue, 12 May 2026 04:36:58 -0700 (PDT)
Received: from [192.168.1.102] ([120.56.206.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f38fsm22544280b3a.8.2026.05.12.04.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 04:36:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Ziyao Li <liziyao@uniontech.com>, Xi Ruoyao <xry111@xry111.site>
Cc: niecheng1@uniontech.com, zhanjun@uniontech.com, guanwentao@uniontech.com,
        Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        kernel@uniontech.com,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lain Fearyncess Yang <fsf@live.com>, Ayden Meng <aydenmeng@yeah.net>,
        Mingcong Bai <jeffbai@aosc.io>, stable@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
In-Reply-To: <20260412101731.107059-1-xry111@xry111.site>
References: <20260412101731.107059-1-xry111@xry111.site>
Subject: Re: [PATCH v8] PCI: loongson: Override PCIe bridge supported
 speeds for Loongson-3C6000 series
Message-Id: <177858581215.17835.9314837252988039944.b4-ty@b4>
Date: Tue, 12 May 2026 17:06:52 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyMCBTYWx0ZWRfX51ZWjS2EqsAk
 g9QTNc+ozVshyHFLt1faHflkww3hthFRjdBee7mNnDTssYymHCAqhQcEoiFqtfUenLwHj/mHOJb
 T90lk+gXhKPzC6dxscPzmDFN/x6dLZPgDhKXPJG/1dm54ez2FMGD68/AFant/HMHxtJhcw4e+PQ
 xVq9IajmaVYyQ7NNN94NP5OaMkERY+76/AfU9GGeWqO2DgpUjgZ/yzzOinNRKxDk7OUvWP19rZj
 5T6qE9JP5yUSJSuOB+GvQJm7M8WvAesrhSL0M/NtNLOzw0uNIgmty81VcdfFLi5PXusxklgdNmX
 m740ZTLVFnoT2KZb2VkHCeEo6h1jqitfNCfghyqyoTDW+BIyrwnAmddKRFWFZrjohZMzQuWtYd+
 dcBZkahSB4YJYWYB8QsjHAYauM7FAcRjc2X63gz55xPb5TkK1fV/7EHBcrCQQ94kxNFSeiWWL5Z
 8Gm77pbJqQetEHuwhDg==
X-Proofpoint-GUID: p2zaRtFGrZj4WaQoievrrNRQjprurYvZ
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a0310dc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=QuRtzvr4xB5J0le8HPcEzQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=P1rAUm4iSsRH5tYQsiAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: p2zaRtFGrZj4WaQoievrrNRQjprurYvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120120
X-Rspamd-Queue-Id: 0B39C51F710
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-245442-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[uniontech.com,aosc.io,vger.kernel.org,lists.linux.dev,linux.intel.com,live.com,yeah.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Action: no action


On Sun, 12 Apr 2026 18:17:31 +0800, Xi Ruoyao wrote:
> Older steppings of the Loongson-3C6000 series incorrectly report the
> supported link speeds on their PCIe bridges (device IDs 0x3c19, 0x3c29)
> as only 2.5 GT/s, despite the upstream bus supporting speeds from
> 2.5 GT/s up to 16 GT/s.
> 
> As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if more
> than one speed is supported"), bwctrl will be disabled if there's only
> one 2.5 GT/s value in vector `supported_speeds`.
> 
> [...]

Applied, thanks!

[1/1] PCI: loongson: Override PCIe bridge supported speeds for Loongson-3C6000 series
      commit: 72644ef266d2d7c679d1c8d8dd7ff5a7ab2171e9

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


