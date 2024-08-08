Return-Path: <stable+bounces-65974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277B294B3F8
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 02:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC672283ED5
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 00:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1884963D;
	Thu,  8 Aug 2024 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="btP8+W1G";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eagSx0Wy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BMsvROcZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89824376;
	Thu,  8 Aug 2024 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075587; cv=fail; b=g1mETJYG8jQX55Qej59E2dRhwBKm+pubo8kd9VsqcWf+I3VjktdpY1BOvIiRWwfQz5Yrl4Ppy15kYoCMaArJDiqjrkYm4KtcA4CuAFrBxUpkTsnipTW2hjV48XG8+lvk+YJckzKN5KQwUeojp4vDcRfJX86l1tvjipQ1WjcUiRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075587; c=relaxed/simple;
	bh=rrjnW4AUumVNv2wrFz7XM3DzQS+EKNnom0AY74VuFVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q3W8XHz/xDuf7G59dJMUqaIeMSJJ5byE8NuVXidBPE4sa1gJE9bHV9mYH/RsuzWqPOnvAGqc4uABcpAjBu9JkXRoMtlgfJBo/kA9YoUozkRxpOqjtGmlTXlfAG8Qv7hXRsrPoi6VeOpiJUlfGJl8yJfA4yuAdq1uYRhOb7am76A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=btP8+W1G; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eagSx0Wy; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BMsvROcZ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477Mmfh3006216;
	Wed, 7 Aug 2024 17:06:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=rrjnW4AUumVNv2wrFz7XM3DzQS+EKNnom0AY74VuFVM=; b=
	btP8+W1G3geEiWssrE8xGDML6gL5nk0COxJUlhUGNoegtx1XBUTct8Z3v1iCROlq
	0nC0zgFHOtm2Qt1rPoaVjMoUfShItOD4PR6MlBqjmzXTHCl5igrJKiJQrL3zJcS7
	2Td/9QySBkTLHX3vCqAIiv1p2GdAk7NkM/od93BOpPKjTn1iBVhWLzc+FUinq4kt
	m6V5QkB3zRc6TbPiiMHmreMaC+sir6reSTCBDCScSitiLVe4D0G5F23jx2EazZSw
	fPdeT+cLjw0+pdpXOJnuDZ6D3/PSnp1bw12YonN93GFQFWOB4U1fHJrt8UQnlhHl
	/cQ9Q+ZelpjliouSVIlg8w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 40v99sb3sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 17:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723075573; bh=rrjnW4AUumVNv2wrFz7XM3DzQS+EKNnom0AY74VuFVM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=eagSx0Wy4Z63U1D+Hph7CEm1Lu2h66q4zs/lAe61sxZIjuzyRhVQ8IUhJquwVCjHg
	 hCM8fWVM4KueddQLRT3sKFZJ7sHE64lbvwfQGK0rdN9EMgoFNu44pya3V+YLdmXjRS
	 mR+T/LbCndnR1XBrWtgnPb57eDHa1F6DJZGEn8qx1xAppnn427sT+C3Ebw6s7leZKG
	 zfBbhgMKibclmBhujY3MhFR39bpEvr/UcFYR2jt5WZNIaBHfsBGQd1UX2VomuK3I6y
	 8y8GRFaotxf0kBP8oUu8r2ErkUndnT4E8Ha5CjygenqVb6dJoo2WGWe2uTxunurqBW
	 168O+GDPLtQUQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7A69C40348;
	Thu,  8 Aug 2024 00:06:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 27521A0266;
	Thu,  8 Aug 2024 00:06:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=BMsvROcZ;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9D88440348;
	Thu,  8 Aug 2024 00:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCQpOKOl99/j6CRFma/WxSuK0JH7Yi99cKgVy8FJFMQJ2zH1RYJ7crCYmBVpy73N1/taNbzBb5BntUkE4LO5pPeVzsq4+7ysX3dVlxiWeWMLIytdKs0ecT4rGdzkl7//fuFxKknJL+RmxNqQUn63cbaqdE48QmwuGDKBDBljWGWtIjnmMRv0PrdnEDoCG7r1uc9iEivPauTxl7HL0fWvwsUnDGXeNxth03mlu98KKFY3ixCwMCGrFWBXqNfVLiSaE1pDJN5s72qqCgRHFBE7Ni1ERqrI0BcwQmLzdJ1Ow+1s0KURDp1BhO1+BrqH9Yk/dtAPpA/85zCKITclPE8JMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrjnW4AUumVNv2wrFz7XM3DzQS+EKNnom0AY74VuFVM=;
 b=P32pHPZm2QQAjsZoFCEBc8WA2FVchtOcyDM5STKI1rFcK3MXhWxk1o/KhY0MEsxW3XaW8ejzy7XSu19yJulvdG9ejEUqlisGR9WTBCp/RxMPPkSuYp0fevLkVLQRAzVUTkuskuWkFaVO3+c/sNLFfz8sUu3kpX6EWXL2kmPBHFP9IzCA1BM2yFB8z8ieZzbph08Eo+Hm8dFmXnQUmw+GktoLqS+/217a4vZ2diKkMvUqDll0J133aIsfwSImX+VuIEblj6TyteaZg5wDg5N6a/6UUKCoZ9aG3my6Fsrl3mBqP+Cz+kIrErQqb9uBs8Of5OIR2ZrR9Ub/iueFWkglWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrjnW4AUumVNv2wrFz7XM3DzQS+EKNnom0AY74VuFVM=;
 b=BMsvROcZRi9vEBW915KEhc5Tl2iXj2bH7TITqhtM0hHh5+cPPEnMuPPEreSymh0r5Xu1TAKQLj3+bmrq6G6dKSQJTBemvZFfX/JjL3NQN3hlbONUmV9O1oMK/4nAJvV3P1Wloz+gtL392C5mHWqFXZEqmc81ELnIU8UnEdTt4Tk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 00:06:09 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 00:06:09 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Fix latency of DSTS while receiving wakeup
 event
Thread-Topic: [PATCH] usb: dwc3: Fix latency of DSTS while receiving wakeup
 event
Thread-Index: AQHa4n64myRqI4MS10KyZQtJfHhLF7Ia8i4AgACktoCAAPGjAA==
Date: Thu, 8 Aug 2024 00:06:08 +0000
Message-ID: <20240808000604.quk6rheiqt6ghjhv@synopsys.com>
References: <20240730124742.561408-1-quic_prashk@quicinc.com>
 <20240806235142.cem5f635wmds4bt4@synopsys.com>
 <ec99fcdc-9404-8cd9-6a30-95e4f5c1edcd@quicinc.com>
In-Reply-To: <ec99fcdc-9404-8cd9-6a30-95e4f5c1edcd@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ1PR12MB6292:EE_
x-ms-office365-filtering-correlation-id: b5df54c0-cf6f-42fc-ae80-08dcb73de7d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1dpOGN3QVpZZ2E4UThERFBoa0RmTnVhYXRpVGpZeFlEdGdrZnVIV1MzTkh1?=
 =?utf-8?B?eW9NQTJjWGY5SGFpNmVvOWJxOTdSTHdwenkvbkpCY3BTMTRpT1BrclZPZGtH?=
 =?utf-8?B?SzNSQU5pNmJuTlRDeGZwaHlTckR5MHhyNGp3ZHAxZEQ3UElXUEJncTdxLzUy?=
 =?utf-8?B?QzhQNG1wcFVoM2JIZU9MME5nM0s5Qzh6SDBweDNiUlh1T3ZGVDZnS1hGL3Z2?=
 =?utf-8?B?eWViLzNVb1AvdVFtajdvelNCeWFyZXB6cjYwYWs0UkkrajFGN3N4OVVOTWg5?=
 =?utf-8?B?WTJpaWxna1dDWkJSWGpDazlBRmYwbGUxZjQ2akVXbVpMTnhSSnpaMk1KNlVp?=
 =?utf-8?B?Z21uU2pya2gzY1FmaHhrdUp6cUxrNUlkRy9OSHQvcUlRNVdZTzZGOG04dTVn?=
 =?utf-8?B?c0w1TUhlK2pHVi82aWRxdFpueUFjRjVsaXhOUWg3bkpxWU5mOCttUWt1QkVQ?=
 =?utf-8?B?ZDEzeU81K1ZTK2RPQVZNMko3TkZUMVZvcENHdkhiemFrMlkyWnpuSFAwU3No?=
 =?utf-8?B?dGx3MFJWOFJ3NmZaam43TWxFSFZyVGhMa1lPT3VKeUNxRkFyWHNYcklDZDZx?=
 =?utf-8?B?TnVSMXl5aytYb2E4Z0JnZEhLY0xhblZBZE80aUFOZythNjZESk1EVTBDYzNr?=
 =?utf-8?B?NURtNXNCeWJXcG93SHZnWGpBN2JwdllTODg5T2ZxWEE1elNCQ2hpVlpORks4?=
 =?utf-8?B?N2xBVmJ4aHRDZnhKeVpHSWdwRjdWekV2R1pRR3hPTElXZzN3UFJULzhyUnNV?=
 =?utf-8?B?NXNJc2dUKzVBaXlUSHFGVTV0RHBjUDJTMDBQWjlvQndzeUpIQVo2UEFrS2kr?=
 =?utf-8?B?Qmo2dVRmQ1F4SEtvdEtrdjBvSkZMcVVmV3gwbm5OOSthZEtqVWpaRmNIemZl?=
 =?utf-8?B?Ryt4c3FGS0pLY3htd2lmNUplNnFYd0VLTXE1QW1YWXlUb3RoV25KVlFSQzZi?=
 =?utf-8?B?SUx4b3YraVd6Q2szYkhlWkYwbjNJQTVPc2FBNWRqY1BGUjBhd0xLYlM3VlRJ?=
 =?utf-8?B?dWs4K244WXl0T3UxdllzSGpNZUZwaE0wL29Pay8rbEs5S0QrRC9HbG9xam1O?=
 =?utf-8?B?b05aeGlEUkZ3RmtzZHR4SjFqcVRxTVgzTUVhWEtyTTFBSGUwMmhqd2lSckZK?=
 =?utf-8?B?TUdxU2pueE8wa1lPZHB2MW1yaG1uSllvcjJzRDRvRHdLc3RVTXFXRFVDVlp1?=
 =?utf-8?B?QjdBQVFvNUF3TG9JbkNXZ1JUdGZXK3Vkc05aTCtUU0Z6MjBxc0tXQzVwSWRk?=
 =?utf-8?B?ajBrd25YTXg4MEN4VEVWamtna2NQYlgvcmNsbU5ZWW9RUGxmQzdzcFJSWjRm?=
 =?utf-8?B?NHVxd1NsZis1cEVwbFcxVVluK3dVa1NKTDQ3ditIcXZUbkNZdWI5NGhQRlNv?=
 =?utf-8?B?MjgwaFBGelFUK1padE81WVdhb3dLRFYrR1hxQk9DQm5uSlByQXFMN1R0cDdx?=
 =?utf-8?B?SEVUY21QWXJCcXhZNTA2bHlRM0UyZitLTEczNVBmaFA1UHRHUkpOV2FERi80?=
 =?utf-8?B?ZkZibTRVVXd1WjAzSmJCcnNML3R3eWtkdGhXVzhyWlBtVFNWK2pNWFdTd1BO?=
 =?utf-8?B?WnFmcXlJUTNLWHJMRzdhQUswNlhhWENicGE5K3A4R2MyY09KVFVoVUNZLzZj?=
 =?utf-8?B?RlpLamJyT0Y1QlFPWnk3dlJyOXcwVzRCWHBIdFJvaG9adkxUOW1rSGhrSkI5?=
 =?utf-8?B?dG8xaUZNUStrVmpsYm1aK2hjWEFNdGRLdHVsTm01ckVLNTdYR0tmWnBvbW9q?=
 =?utf-8?B?dHp5Y2VtNjBlUEp5TzNiUEs0Q25GdU92Rk1sUU5SZWNxU0l6OHMwaE01QWtp?=
 =?utf-8?B?MFNLRWtRell0N1ZZQXBPWjlRbE42Nk9jdWdQWlFLQ0NBSUc3VDJrN0ZRQ1Nv?=
 =?utf-8?B?RzNoNmtNQWhrNjkwTnFBSk9ITVN2b3hCeVVhd2c4VW9ob0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tyt5dXI3RnE1ejRDZTB4RkNEYWxKandla2I2M2lLd0RDZmRobjJpMG0xcjRr?=
 =?utf-8?B?M3pCeHJFb3YvaEdBdlNudXJaMEFPS1hVVmkvYk9YczdockV5cUNreURSWVA3?=
 =?utf-8?B?djM3VkR1R2JNWlFDR1hSQkU3UGY3NWNpaDhSS3g1Qzh5MlY3MFpPZEdwMEFy?=
 =?utf-8?B?enFWWW5YbGVWc3BablBPQjVsdnV6dFNvbUQwTDlyQk9XOXFtNC9IWEhQN2Z0?=
 =?utf-8?B?UEZXbWh2elZKU1lTQVYxSHBxN0ViV0haTXhoMXpndjNZdGFUSTBnV3V2TmJp?=
 =?utf-8?B?VlUvZm5DaUUxdHNreDJxZmhhdjJ4OER2RDQ2bzhPazN0LzBURnZnY2kzWUtm?=
 =?utf-8?B?dDd2VEF5cmQ2dXhVa0RIai9ZSXc5Ry91KzlTakt5Qm1hMWN1NStMSkQ3amto?=
 =?utf-8?B?cFdtc1cvWjNRRXdqTXNwcS9NcXV1SmJmVTRZdVl3aDVRdVJhOFhKVFBuQU9k?=
 =?utf-8?B?dU5KU3VTdXN0bGJTUXZIZ2src0QwczhOMm52aUl1R2crdFRVbm13RTRsZVo0?=
 =?utf-8?B?a25mME02OEp4SFhwNG5IVTh4cml3OXFCeEFIS09vQ21xTkVCK1hhemFTaHVI?=
 =?utf-8?B?Rmx0aFJkQTJSY3V2Z2cvWjJBZnBkMkVvcXVUSmNzdGpzYTBPME5NR0x3WU84?=
 =?utf-8?B?aHZBOURJYTlUeEVPMDJIRnRwNm5TN2diZ3NnTmRpWFAvb1RWQnh3Rm1LZExw?=
 =?utf-8?B?UmkzV3cyYURwak5aSlFYMnBUcXZ6V1d4NU9QL1RLdExuTmVNeEF3U09MRTF6?=
 =?utf-8?B?WEZ0VFZmcEJKYXNXM29neU93bU9uRWFlaHFPWHN2aXlicE8zSE52OTV1a0h6?=
 =?utf-8?B?NTBQTEtUbEgvYWFqZkhyajN1bVhiaFhRK0R5Qk5ndVRlUktiWXJqZCtOdDR0?=
 =?utf-8?B?cTF0Nk9sVGlZTkMvZHVrQWcxSjB2S2VjOThLMzZEMEhNaFY4NllFNnZPMmRa?=
 =?utf-8?B?OCszWWJIZUFSbGdpbVB3eDR5bEc0d05LNGYvYnljNVhlYTNVZVZLMHFrVllB?=
 =?utf-8?B?WWE2M2VpcEVmUjZ4SzNET0pBd2E1dnl4aW5UYkV5TFNZWE9nZFVMYXJ1SVVE?=
 =?utf-8?B?ZEZlTUl4M2xKZ1paSzArYTh4VFFLT2gvamRMdGtXYWV1eXpyWXYxM09RTjN4?=
 =?utf-8?B?WHQ5RlZqMGh0TWZ2K2J1RUZlU1ExYW5WMDhHdm56bjQzWWhPSGZSQ3daUGQr?=
 =?utf-8?B?UlNoRW0yNWxCTlQ5UFZqUDZsSDc1ZFhaWlVtNzFWZ2RCNSsrUEVEVU85WVJq?=
 =?utf-8?B?OVBQVGl5WC9VdjNxUU5adDdKazJGdS9ZSDgyYzduN2tpYkNrVHYyNWVINE5y?=
 =?utf-8?B?S29VNDV2dkxmaDR0QnhpSk5EUlErWm80ajBXY1pVSk90bmNMK1QrQmUwM21l?=
 =?utf-8?B?NXBwVE04UW1zZ2s0MFZxdVZJVzFWdkhUSktjei9iMkRhaTNWbTVzVGFsbjZ5?=
 =?utf-8?B?REEzclFPV3RXMDlMbXBDT3h6S1gxTHdOR05udUhyQkV0MDhlU1M1YU8zcy92?=
 =?utf-8?B?Vmd0NUkwSU12WjlxTit5ak9XdU44RE9zQXdMSUdZTG5rV1o2OWVVMDhkNzMw?=
 =?utf-8?B?aHdWTjMxVUI3MkhlZnNNZ1ZxbVRsaWl1QmQ1ZUtDcks4djNMb2pKYTVmN29B?=
 =?utf-8?B?eFRmNWlSbkJKVE05QjMxOFhYaThXNWdyeG1CQ1BSeFlqclRNaXZxZlFFNWV1?=
 =?utf-8?B?czM4NG14MFBlTTFpQTV4RFZTUGc1ZUlva09CSE1oeDhyMnorcUQyWkYxdm56?=
 =?utf-8?B?ekFmMTM4RGIxRi84dnBSZmpJWFdrT3BHT0VjV2c2blJtMFg4RDRyUUY1ZDZk?=
 =?utf-8?B?cUlPalltUGJvS3dDVC9taVBYeGZjYkVsNm1rNGpmQllndVJlRlhVbWk4enlk?=
 =?utf-8?B?QXhnMWRjMklKZWdWWXE0aXI0RWdhaE9vRk1CSXhibktYNzNXSGNuUWY4Z1NM?=
 =?utf-8?B?RTdUbmtXZW5PaUxlUTUrampscERZd204SVkyQjRIZ2Q3UmIydVdsSUN2Z056?=
 =?utf-8?B?MjVWZHNJVlFGYkhmQkg4Uk0rNHlYcTdJYWM2cmszQjdCWlRuU2NEODFtMzhi?=
 =?utf-8?B?SmJxVER1L2xtNzJiaW5rQ3FRL3RYNDRXRkQrT1NHNWgwd3FwSjFyc0x0Rnc0?=
 =?utf-8?Q?ZtHU04J3oJTMsLZbpOiwnR5ux?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9B35594DA222F499B0A15AF7B9D35A6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SqSHMiQYuLYmaQFjnjnIeaRZyVO9EOGHOzWByD9uLXOjLGGZ0KrGbRYxWvl7tpKxTwKi/y3Os8awKt7jf9FQcd6nolPvMeda9XZYA6bL9ew7GFL9CpJhB1g/xQZVNkjSGLpce7RK16gTFXfN03AhD3FG4IaErxUlfxowUYaCzl+kSr1sk0b3aZ7jD3i73LIpPIY3Mc5oANshS+59qaGXFgqX724anCFxXbIl8aj32GXfv05cNYTsDGgz/c53mNHO1uuRL2ULLGn+ExvT4XkQrB4gc+gWEKxqrzP8keHh/KRSIkPBIOy2IJ0aUOffH5aLOh4j8iPfUvxrTaxNtSNcFbKfopYEduNmzFmuse4JyidlTDoLfBBHvoxHaM/aCJdCPk2BC1yZIgcJSAb9RE8RURjaUHLQjuRgmJymH44AB/y5PqgTvvrMBi/HC49KtcvoRQFgt2erP2ETSmW4KrSjelKJEEViHmfLI1swbDWAM/IiinsUyMZy+viVZ8cEqQvpFO6BXXGj1nJMMbhZjyyTOV8/vgi8g9fjplMHN5DvQpSRN3bZAcz5CtOlBBhJR63GlGUIQgX7KuxP6oFXWKBlGravFnt67oZqOk0E36bos6lLViEASG8AAXk5fFYcvY6AO5v2kxaXp+p1oWQZB9a9rQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5df54c0-cf6f-42fc-ae80-08dcb73de7d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 00:06:09.0020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X08odoyLcHCKkgFUiuH962i/jw+muzCt7ujp0sifGKH484l1ISo6oWMxO67+sk9GJ1v8PYHH5ncZWvLli+cQfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
X-Proofpoint-GUID: 6eZg7wCmjAGbCMM7RPMhF9194j3JcFrn
X-Proofpoint-ORIG-GUID: 6eZg7wCmjAGbCMM7RPMhF9194j3JcFrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_14,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408070168

SGksDQoNCk9uIFdlZCwgQXVnIDA3LCAyMDI0LCBQcmFzaGFudGggSyB3cm90ZToNCj4gDQo+IA0K
PiBPbiAwNy0wOC0yNCAwNToyMSBhbSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IEhpLA0KPiA+
IA0KPiA+IE9uIFR1ZSwgSnVsIDMwLCAyMDI0LCBQcmFzaGFudGggSyB3cm90ZToNCj4gPiA+IFdo
ZW4gb3BlcmF0aW5nIGluIEhpZ2gtU3BlZWQsIGl0IGlzIG9ic2VydmVkIHRoYXQgRFNUU1tVU0JM
TktTVF0gZG9lc24ndA0KPiA+ID4gdXBkYXRlIGxpbmsgc3RhdGUgaW1tZWRpYXRlbHkgYWZ0ZXIg
cmVjZWl2aW5nIHRoZSB3YWtldXAgaW50ZXJydXB0LiBTaW5jZQ0KPiA+ID4gd2FrZXVwIGV2ZW50
IGhhbmRsZXIgY2FsbHMgdGhlIHJlc3VtZSBjYWxsYmFja3MsIHRoZXJlIGlzIGEgY2hhbmNlIHRo
YXQNCj4gPiA+IGZ1bmN0aW9uIGRyaXZlcnMgY2FuIHBlcmZvcm0gYW4gZXAgcXVldWUuIFdoaWNo
IGluIHR1cm4gdHJpZXMgdG8gcGVyZm9ybQ0KPiA+ID4gcmVtb3RlIHdha2V1cCBmcm9tIHNlbmRf
Z2FkZ2V0X2VwX2NtZCgpLCB0aGlzIGhhcHBlbnMgYmVjYXVzZSBEU1RTW1syMToxOF0NCj4gPiA+
IHdhc24ndCB1cGRhdGVkIHRvIFUwIHlldC4gSXQgaXMgb2JzZXJ2ZWQgdGhhdCB0aGUgbGF0ZW5j
eSBvZiBEU1RTIGNhbiBiZQ0KPiA+ID4gaW4gb3JkZXIgb2YgbWlsbGktc2Vjb25kcy4gSGVuY2Ug
dXBkYXRlIHRoZSBkd2MtPmxpbmtfc3RhdGUgZnJvbSBldnRpbmZvLA0KPiA+ID4gYW5kIHVzZSB0
aGlzIHZhcmlhYmxlIHRvIHByZXZlbnQgY2FsbGluZyByZW1vdGUgd2FrdXAgdW5uZWNlc3Nhcmls
eS4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IGVjYmE5YmM5OTQ2YiAoInVzYjogZHdjMzogZ2FkZ2V0
OiBDaGVjayBmb3IgTDEvTDIvVTMgZm9yIFN0YXJ0IFRyYW5zZmVyIikNCj4gPiANCj4gPiBUaGlz
IGNvbW1pdCBJRCBpcyBjb3JydXB0ZWQuIFBsZWFzZSBjaGVjay4NCj4gPiANCj4gV2lsbCBmaXgg
aXQsIHdhcyBzdXBwb3NlZCB0byBiZSA2M2M0YzMyMGNjZjcsIHRoYW5rcyBmb3IgcG9pbnRpbmcg
b3V0Lg0KPiANCj4gPiBXaGlsZSBvcGVyYXRpbmcgaW4gdXNiMiBzcGVlZCwgaWYgdGhlIGRldmlj
ZSBpcyBpbiBsb3cgcG93ZXIgbGluayBzdGF0ZQ0KPiA+IChMMS9MMiksIENNREFDVCBtYXkgbm90
IGNvbXBsZXRlIGFuZCB0aW1lIG91dC4gVGhlIHByb2dyYW1taW5nIGd1aWRlDQo+ID4gc3VnZ2Vz
dGVkIHRvIGluaXRpYXRlIHJlbW90ZSB3YWtldXAgdG8gYnJpbmcgdGhlIGRldmljZSB0byBPTiBz
dGF0ZSwNCj4gPiBhbGxvd2luZyB0aGUgY29tbWFuZCB0byBnbyB0aHJvdWdoLiBIb3dldmVyLCBj
bGVhcmluZyB0aGUNCj4gDQo+IFllYSB0cnVlLCB3ZSBuZWVkIGVuc3VyZSB0aGF0IHRoZSBsaW5r
c3RhdGUgaXMgbm90IGluIEwxL0wyL1UzIGZvciBIUy9TUy4NCj4gQnV0IHNpbmNlIHdlIGFyZSBy
ZWx5aW5nIG9uIERTVFMgZm9yIHRoaXMsIHdlIG1heSBpc3N1ZSByZW1vdGUtd2FrZXVwIHRvDQo+
IGhvc3QgZXZlbiB3aGVuIG5vdCBuZWVkZWQuIER1cmluZyBob3N0IGluaXRpYXRlZCB3YWtldXAg
c2NlbmFyaW8sIHdlIGdldCBhDQo+IHdha2V1cCBpbnRlcnJ1cHQgd2hpY2ggY2FsbHMgZnVuY3Rp
b24gZHJpdmVyIHJlc3VtZSBjYWxscy4gSWYgZnVuY3Rpb24NCj4gZHJpdmVyIHF1ZXVlcyBzb21l
dGhpbmcsIHRoZW4gc3RhcnR4ZmVyIGhhcyB0byBiZSBpc3N1ZWQsIGJ1dCBEU1RTIHdhcyBzdGls
bA0KPiBzaG93aW5nIFUzIGluc3RlYWQgb2YgVTAuIFdoZW4gY2hlY2tlZCB3aXRoIG91ciBkZXNp
Z24gdGVhbSwgdGhleSBtZW50aW9uZWQNCj4gdGhlIGxhdGVuY3kgaW4gRFNUUyBpcyBleHBlY3Rl
ZCBzaW5jZSBhbmQgbGF0ZW5jeSB3b3VsZCBiZSBpbiBtc2VjIG9yZGVyDQo+IGZyb20gUmVzdW1l
IHRvIFUwLiBDYW4geW91IHBsZWFzZSBjb25maXJtIHRoaXMgb25jZSwgSSBzaW1wbHkgYWRkZWQg
YQ0KPiBwb2xsaW5nIG1lY2hhbmlzbSBpbiB3YWtldXAgaGFuZGxlci4NCg0KTm8gbmVlZCBmb3Ig
dGhpcyBwb2xsaW5nLiBXaGVuIHlvdSByZWNlaXZlIHdha2V1cCBldmVudCwgaXQncyBhbHJlYWR5
IGluDQp0aGUgc3RhdGUgdGhhdCB5b3UgY2FuIGlzc3VlIFN0YXJ0IFRyYW5zZmVyIGNvbW1hbmQu
DQoNCj4gDQo+IEBAIC00MTc1LDYgKzQxNzcsMTQgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRf
d2FrZXVwX2ludGVycnVwdChzdHJ1Y3QgZHdjMw0KPiAqZHdjLCB1bnNpZ25lZCBpbnQgZXZ0aW5m
bykNCj4gICAgICAgICAgKiBUT0RPIHRha2UgY29yZSBvdXQgb2YgbG93IHBvd2VyIG1vZGUgd2hl
biB0aGF0J3MNCj4gICAgICAgICAgKiBpbXBsZW1lbnRlZC4NCj4gICAgICAgICAgKi8NCj4gKyAg
ICAgICB3aGlsZSAocmV0cmllcysrIDwgMjAwMDApIHsNCj4gKyAgICAgICAgICAgICAgIHJlZyA9
IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0RTVFMpOw0KPiArICAgICAgICAgICAgICAgLyog
aW4gSFMsIG1lYW5zIE9OICovDQo+ICsgICAgICAgICAgICAgICBpZiAoRFdDM19EU1RTX1VTQkxO
S1NUKHJlZykgPT0gRFdDM19MSU5LX1NUQVRFX1UwKQ0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsNCj4gKyAgICAgICAgICAgICAgIHVkZWxheSgyKTsNCj4gKyAgICAgICB9DQo+ICsg
ICAgICAgcHJfaW5mbygiRFdDMyBXYWtldXA6ICVkIiwgcmV0cmllcyk7DQo+IA0KPiBBbmQgdHVy
bnMgb3V0LCByZXRyaWVzIDE1MDAgdG8gMTUwMDAgKHdvcnN0IGNhc2UpLCB3aGljaCBjYW4gcmFu
Z2UgZnJvbSAzbXMNCj4gdG8gMzBtcy4gQnkgdGhpcyB0aW1lLCBjb250cm9sIGNhbiByZWFjaCBz
dGFydFhmZXIsIHdoZXJlIGl0IHRyaWVzIHRvDQo+IHBlcmZvcm0gcmVtb3RlLXdha2V1cCBldmVu
IGlmIGhvc3QganVzdCByZXN1bWVkIHRoZSBnYWRnZXQuDQoNClBvbGxpbmcgZm9yIDIwSyB0aW1l
IGlzIGEgYml0IG11Y2gsIGFuZCB0aGlzIHdpbGwgdmFyeSBkZXBlbmRpbmcgb24NCmRpZmZlcmVu
dCBzZXR1cC4gVGhpcyBpcyBzb21ldGhpbmcgdGhhdCBJIHdhbnQgdG8gZml4IGluIHRoZSB3YWtl
dXAoKQ0Kb3BzIGFuZCBrZWVwIGV2ZXJ5dGhpbmcgYXN5bmMuDQoNCj4gDQo+IEZvciBTUyBjYXNl
LCB0aGlzIHJldHJpZXMgY291bnQgd2FzIGNvbnNpc3RlbnRseSAxLCBpdCB3YXMgcGFzc2luZyBp
biBmaXJzdA0KPiB0cnkgaXRzZWxmLiBCdXQgdW5mb3J0dW5hdGVseSBkb2Vzbid0IGJlaGF2ZSB0
aGUgc2FtZSB3YXkgaW4gSFMuDQo+IA0KPiA+IEdVU0IyUEhZQ0ZHLnN1c3BlbmR1c2IyIHR1cm5z
IG9uIHRoZSBzaWduYWwgcmVxdWlyZWQgdG8gY29tcGxldGUgYQ0KPiA+IGNvbW1hbmQgd2l0aGlu
IDUwdXMuIFRoaXMgaGFwcGVucyB3aXRoaW4gdGhlIHRpbWVvdXQgcmVxdWlyZWQgZm9yIGFuDQo+
ID4gZW5kcG9pbnQgY29tbWFuZC4gQXMgYSByZXN1bHQsIHRoZXJlJ3Mgbm8gbmVlZCB0byBwZXJm
b3JtIHJlbW90ZSB3YWtldXAuDQo+ID4gDQo+ID4gRm9yIHVzYjMgc3BlZWQsIGlmIGl0J3MgaW4g
VTMsIHRoZSBnYWRnZXQgaXMgaW4gc3VzcGVuZCBhbnl3YXkuIFRoZXJlDQo+ID4gd2lsbCBiZSBu
byBlcF9xdWV1ZSB0byB0cmlnZ2VyIHRoZSBTdGFydCBUcmFuc2ZlciBjb21tYW5kLg0KPiA+IA0K
PiA+IFlvdSBjYW4ganVzdCByZW1vdmUgdGhlIHdob2xlIFN0YXJ0IFRyYW5zZmVyIGNoZWNrIGZv
ciByZW1vdGUgd2FrZXVwDQo+ID4gY29tcGxldGVseS4NCj4gPiANCj4gU29ycnksIGkgZGlkbnQg
dW5kZXJzdGFuZCB5b3VyIHN1Z2dlc3Rpb24uIFRoZSBzdGFydHhmZXIgY2hlY2sgaXMgbmVlZGVk
IGFzDQo+IHBlciBkYXRhYm9vaywgYnV0IHdlIGFsc28gbmVlZCB0byBoYW5kbGUgdGhlIGxhdGVu
Y3kgc2VlbiBpbiBEU1RTIHdoZW4NCj4gb3BlcmF0aW5nIGluIEhTLg0KPiANCg0KdXNiX2VwX3F1
ZXVlIHNob3VsZCBub3QgdHJpZ2dlciByZW1vdGUgd2FrZXVwOyBpdCBzaG91bGQgYmUgZG9uZSBi
eQ0Kd2FrZXVwKCkgb3BzLiBUaGUgcHJvZ3JhbW1pbmcgZ3VpZGUganVzdCBub3RlZCB0aGF0IHRo
ZSBTdGFydCBUcmFuc2Zlcg0KY29tbWFuZCBzaG91bGQgbm90IGJlIGlzc3VlZCB3aGlsZSBpbiBM
MS9MMi9VMy4gSXQgc3VnZ2VzdGVkIHRvIHdha2UgdXANCnRoZSBob3N0IHRvIGJyaW5nIGl0IG91
dCBvZiBMMS9MMi9VMyBzdGF0ZSBzbyB0aGUgY29tbWFuZCBjYW4gZ28NCnRocm91Z2guDQoNCk15
IHN1Z2dlc3Rpb24gaXMgdG8gcmVtb3ZlIHRoZSBMMS9MMi9VMyBjaGVjayBpbg0KZHdjM19zZW5k
X2dhZGdldF9lcF9jbWQoKSwgYW5kIGl0IHdpbGwgc3RpbGwgd29yayBmaW5lIHdpdGggcmVhc29u
cw0Kbm90ZWQgcHJldmlvdXNseS4gU28sIGp1c3QgZG8gdGhpczoNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQppbmRl
eCAwZWEyY2EwZjBkMjguLjZlZjZjNGVmMmE3YiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCkBAIC00MTEsMzAg
KzQxMSw2IEBAIGludCBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZChzdHJ1Y3QgZHdjM19lcCAqZGVw
LCB1bnNpZ25lZCBpbnQgY21kLA0KICAgICAgICAgICAgICAgICAgICAgICAgZHdjM193cml0ZWwo
ZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDApLCByZWcpOw0KICAgICAgICB9DQoNCi0gICAg
ICAgaWYgKERXQzNfREVQQ01EX0NNRChjbWQpID09IERXQzNfREVQQ01EX1NUQVJUVFJBTlNGRVIp
IHsNCi0gICAgICAgICAgICAgICBpbnQgbGlua19zdGF0ZTsNCi0NCi0gICAgICAgICAgICAgICAv
Kg0KLSAgICAgICAgICAgICAgICAqIEluaXRpYXRlIHJlbW90ZSB3YWtldXAgaWYgdGhlIGxpbmsg
c3RhdGUgaXMgaW4gVTMgd2hlbg0KLSAgICAgICAgICAgICAgICAqIG9wZXJhdGluZyBpbiBTUy9T
U1Agb3IgTDEvTDIgd2hlbiBvcGVyYXRpbmcgaW4gSFMvRlMuIElmIHRoZQ0KLSAgICAgICAgICAg
ICAgICAqIGxpbmsgc3RhdGUgaXMgaW4gVTEvVTIsIG5vIHJlbW90ZSB3YWtldXAgaXMgbmVlZGVk
LiBUaGUgU3RhcnQNCi0gICAgICAgICAgICAgICAgKiBUcmFuc2ZlciBjb21tYW5kIHdpbGwgaW5p
dGlhdGUgdGhlIGxpbmsgcmVjb3ZlcnkuDQotICAgICAgICAgICAgICAgICovDQotICAgICAgICAg
ICAgICAgbGlua19zdGF0ZSA9IGR3YzNfZ2FkZ2V0X2dldF9saW5rX3N0YXRlKGR3Yyk7DQotICAg
ICAgICAgICAgICAgc3dpdGNoIChsaW5rX3N0YXRlKSB7DQotICAgICAgICAgICAgICAgY2FzZSBE
V0MzX0xJTktfU1RBVEVfVTI6DQotICAgICAgICAgICAgICAgICAgICAgICBpZiAoZHdjLT5nYWRn
ZXQtPnNwZWVkID49IFVTQl9TUEVFRF9TVVBFUikNCi0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYnJlYWs7DQotDQotICAgICAgICAgICAgICAgICAgICAgICBmYWxsdGhyb3VnaDsNCi0g
ICAgICAgICAgICAgICBjYXNlIERXQzNfTElOS19TVEFURV9VMzoNCi0gICAgICAgICAgICAgICAg
ICAgICAgIHJldCA9IF9fZHdjM19nYWRnZXRfd2FrZXVwKGR3YywgZmFsc2UpOw0KLSAgICAgICAg
ICAgICAgICAgICAgICAgZGV2X1dBUk5fT05DRShkd2MtPmRldiwgcmV0LCAid2FrZXVwIGZhaWxl
ZCAtLT4gJWRcbiIsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
KTsNCi0gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KLSAgICAgICAgICAgICAgIH0NCi0g
ICAgICAgfQ0KLQ0KICAgICAgICAvKg0KICAgICAgICAgKiBGb3Igc29tZSBjb21tYW5kcyBzdWNo
IGFzIFVwZGF0ZSBUcmFuc2ZlciBjb21tYW5kLCBERVBDTURQQVJuDQogICAgICAgICAqIHJlZ2lz
dGVycyBhcmUgcmVzZXJ2ZWQuIFNpbmNlIHRoZSBkcml2ZXIgb2Z0ZW4gc2VuZHMgVXBkYXRlIFRy
YW5zZmVyDQoNCldoZW4gd2UgcmVjZWl2ZSB0aGUgd2FrZXVwIGV2ZW50LCB0aGVuIHRoZSBkZXZp
Y2UgaXMgbm8gbG9uZ2VyIGluDQpMMS9MMi9VMy4gVGhlIFN0YXJ0IFRyYW5mZXIgY29tbWFuZCBz
aG91bGQgZ28gdGhyb3VnaC4NCg0KV2UgZG8gaGF2ZSBhbiBpc3N1ZSB3aGVyZSBpZiB0aGUgZnVu
Y3Rpb24gZHJpdmVyIGlzc3VlcyByZW1vdGUgd2FrZXVwLA0KdGhlIGxpbmsgbWF5IG5vdCB0cmFu
c2l0aW9uIGJlZm9yZSBlcF9xdWV1ZSgpIGJlY2F1c2Ugd2FrZXVwKCkgY2FuIGJlDQphc3luYy4g
SW4gdGhhdCBjYXNlLCB5b3UgcHJvYmFibHkgd2FudCB0byBrZWVwIHRoZSB1c2JfcmVxdWVzdHMg
aW4gdGhlDQpwZW5kaW5nX2xpc3QgdW50aWwgdGhlIGxpbmtfc3RhdGUgdHJhbnNpdGlvbnMgb3V0
IG9mIGxvdyBwb3dlci4NCg0KVGhlIG90aGVyIHRoaW5nIHRoYXQgSSBub3RlZCBwcmV2aW91c2x5
IGlzIHRoYXQgSSB3YW50IHRvIGZpeCBpcyB0aGUNCndha2V1cCgpIG9wcy4gQ3VycmVudGx5IGl0
IGNhbiBiZSBhc3luYyBvciBzeW5jaHJvbm91cy4gV2Ugc2hvdWxkIGtlZXANCml0IGNvbnNpc3Rl
bnQgYW5kIG1ha2UgaXQgYXN5bmMgdGhyb3VnaG91dC4NCg0KQlIsDQpUaGluaA0K

