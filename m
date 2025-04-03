Return-Path: <stable+bounces-127486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DE6A79CF3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 09:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2933AB703
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 07:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7B62222D8;
	Thu,  3 Apr 2025 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="GqIjyZ6c"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B6221F2D;
	Thu,  3 Apr 2025 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665243; cv=fail; b=D8oo8wGFDQVgqIaxz6uFp3gQgXI6g/f6o2v7npkRqSsqXKohazzc6Z2iKjjQee9O6rODu5PmlkUhQ7zekKtS6owd1bpDDS74cQFL45DHjW9flfugpzVNgIX4TFSHyLassJqlNQE8YnlH8lsDQDXNyd795h32aRIeFBxvbT2t+kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665243; c=relaxed/simple;
	bh=lyOiHDkcORPSDY2aMBksQe/ZztJPpbWOazjlG5pQAKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lHArfBSVwF9fUm/2FmhPfs4ci24HuZnjw6eyBMA1a4qp+Nn2+LfRwbu02N/mK38TFYiKhTSRS3etfLCQbWGDNcqFtmC2q59PfVYjCkTawPWUJmapDFsCfevI5YFczM8aGUtc/13Uy679jWVlT/Gf0t8n9Y2O2S5bqCwMAndHUfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=GqIjyZ6c; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5331G3A2024777;
	Thu, 3 Apr 2025 03:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=2
	B6NokDj99g4MgD49879iHhOpcZIF63o1rvq6IOP6pw=; b=GqIjyZ6cJLbWrez4y
	Eury5ZsK4Xk3cHctW9LQcoCKT3GQ9dZ/GWXOlkpR2CmwEB5VmLWI/wvEsmokDvbi
	3YUC2I05+OsnXgOakfUc8mdkjyx28xzoiZvMfpFVqK75bgtmlxhS4Z/gH03l8AN3
	DMEF5Y3elC+A3LMEltkwZz8xrLV1fBLtEsbwCYxr7fONE0wJJk4P1ovNa2JbXq6e
	LboPTGbcthAN0c2AJCZUGXXtjE1u6d8jLnPXoySG1EERF8q2h2XUXFXVSB7Bog3z
	6aV6XbaCMDYS8igDIj89b8Xs93jDVzIiF3ZHsCcS7oUDIu0VIxSqEvmWORJqZ0wc
	XYpqw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 45p9xuxgar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 03:27:00 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5334MVmh001933;
	Thu, 3 Apr 2025 03:26:59 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 45s42an0fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Apr 2025 03:26:58 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUEY1hwrOErJT3Z6KtHjYdoCX19+/CzWQFzmt7SaJSnutMbyA4v9FrqFASxOP8Q5RPTlafzuf4945YnRW2Fep9kx2jTXlItT3NXm/MowmTADsvG/QPUp+cRpExDtHems2IZ2e/NxbrzqiFBf6FQ2wNiMv8UyOvaMQ+6lMDQ6aw/8bSeK6fU62OAgfUy5T+wg2vQKQvMxcpVy2G0eB/OXSCZp6rzekgPMLtB/9EDvsS4cQMJpB7BDlwIQQw+FUG3lCqRUIHbT+Ygvem65VkfZkfR0yd50bGSwkSBqZ/XkdCvaGIQHcVBc70NcOv8uTIsNIdKsdhx6cIJ+sN7gNTMc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B6NokDj99g4MgD49879iHhOpcZIF63o1rvq6IOP6pw=;
 b=ySOchy6dQftK/VHQc3ivl2RHQKdkwaXXnctjlKNEYd+ZqD2mn+t4QU1VoNzd13UiH9+kDTXRM3KxwxfZVVruW65oZB1M9VuLjOMlESbUPvablu4epXkQXjzD/wy7WRDm70cHzQ+7QyTIJ2qlUbdmJmYhDlvIE3HPrO31DlDzfaSGwknUv8q6yIcpLe0o2f8iR2pmobd2r21TuEMlEFRrQyEPPNJjimT8KKDNvU/zTWUMMyapIk6eTOWjG6B8kL8j2ZgfpOKvVJBClc7Btac/LFHn9O/G819mSX5r+cl2C4ajlGvYft0YSeI0iEs3K1dyM4fcJFihXPqovLFWcil9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BY5PR19MB3922.namprd19.prod.outlook.com (2603:10b6:a03:228::23)
 by CH2PR19MB3767.namprd19.prod.outlook.com (2603:10b6:610:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 07:26:56 +0000
Received: from BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d]) by BY5PR19MB3922.namprd19.prod.outlook.com
 ([fe80::afc3:5bb2:37fb:2f9d%7]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 07:26:56 +0000
From: "Shen, Yijun" <Yijun.Shen@dell.com>
To: Mario Limonciello <superm1@kernel.org>,
        "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>,
        "Shyam-sundar.S-k@amd.com"
	<Shyam-sundar.S-k@amd.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: amd: pmf: Fix STT limits
Thread-Topic: [PATCH] platform/x86: amd: pmf: Fix STT limits
Thread-Index: AQHbpEYUOKQUBYQf/0S21aMFHJvVkLORimEQ
Date: Thu, 3 Apr 2025 07:26:56 +0000
Message-ID:
 <BY5PR19MB3922081DFDDBBCA0EA4B84239AAE2@BY5PR19MB3922.namprd19.prod.outlook.com>
References: <20250403031106.1266090-1-superm1@kernel.org>
In-Reply-To: <20250403031106.1266090-1-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=f0293281-8e94-4d07-b07c-3a8fb1b855e8;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-04-03T07:24:41Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3922:EE_|CH2PR19MB3767:EE_
x-ms-office365-filtering-correlation-id: 9e721aa0-a742-47e8-20c7-08dd7280e9e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-7?B?S0x1d2h6b0dLVHQwRzVVKy0wQXE4OEZ6TjRMNlhwd05Yd1NDbDZkRVlCa01O?=
 =?utf-7?B?S3hUQUhraVV0UVdwdnhKS1phOEk5TTFkOTM2VGxEek8rLTFRVkp1ZjEvaWdP?=
 =?utf-7?B?SmdWTGI5cTJkbUhKeU8yazN5aFNxamlXbjlQTUk1dG5QWUNOZGZUSHBMd3Va?=
 =?utf-7?B?b0VnUHduc1JaZVpVdTR2SG14LzU1dlVhTVhvMUJKVldRUU5TS1FWMTNUYzZP?=
 =?utf-7?B?NTNmTi80aThoMlB0bVhuaDhZZDVUSk13UkE1aUJIa3dxZVh5VDdZUmFYL0pN?=
 =?utf-7?B?NkVGbDJ5MERiT1hyWWs4bHg1WWdJSXN5Q0t4eWpMemZ2dHk2N1ZXTk94SWs1?=
 =?utf-7?B?R2ttNm85ZistODJYd240aTFpeWFhN256OGp3SGtmOElHRnFVelNYKy04U3d4?=
 =?utf-7?B?Q1owRVdUS0lsWFc1ODVsVG5YWTJ6QSstdkVkb2VuZ3lnZDV6RzcyeXozRmd1?=
 =?utf-7?B?cW1URnFrNElwdXpNYnNSaTM0RFdhcWNVYXpFUTJVVElLd1pDN2dCcjc0R0Q2?=
 =?utf-7?B?RTFrbTh3T0NtSjBBZTJzV3NQdy94QjA2c2grLXg1VVRYcld4RlI5bjBZQ0t1?=
 =?utf-7?B?Y1VMbU83MHpOTGxkY2NYUW9NSmswTTVDYm40Y0ZZOGRxMm5JQUw2YktOVXBD?=
 =?utf-7?B?czFOaXo5UEJRRXV4QkJBTTBIN2NVUUM0YW1jSnl0WnZjbGtWKy1XVXJsdTBs?=
 =?utf-7?B?cXJxQ0FTNE81bXQvSkRSQnMxUHdpNVZYMHJLamJoVm15Ky1OWTNlOEFRVHlv?=
 =?utf-7?B?WFRITHZjdWFxWWRReTJXSmVIWjJNdistSmZNdnNwd1J3aTdGRmJxRkNQY3g=?=
 =?utf-7?B?VistWXFWUDhJY25yVDBQaWhkMWdhWjR0MlArLUk0dTJ5NmJFR0ZnMmlFbnQz?=
 =?utf-7?B?RmQ2NHgvTThuaUkzN3FzUCstRWNWVU9BVnJIV1dheWtLT3EvWFRkVmFESVdS?=
 =?utf-7?B?TG5DWGNQTTN0YjNJV0RqZkY3UHJiOGc5U1o5ZEhtYjA2ZkdSVy9wdkNmSFFU?=
 =?utf-7?B?RDdCT3VGOWd3Mkk0TWo4WW43cXJBYVNDd1JUa1JDTGhRa1F0Ky0weDlVZEI=?=
 =?utf-7?B?Ky04NzIwREorLWlpZ25Tei9YVHVuZGJieXB5Y2xnR0t0cXFPWVlMVGlQNTZa?=
 =?utf-7?B?bFlKd1NVdG1iV2UxSnRpbFZlcWlLVWRtNXNIa0RSKy1ob3gydkhVWG1rZnRT?=
 =?utf-7?B?WFJCWHBORnZOSDRPYUNkVDJZVWIzVDBlWWRTcXo5dGp1Ky00elRoTk1uMEs1?=
 =?utf-7?B?dVNaYjdoTFltc2gyMW1GQ1BVVTNWY0VvWFVWWk5sdHhkNWM0ZTZ2RlU4SHBC?=
 =?utf-7?B?bktSOVhJOGZrQlVaQmlvSlRBeVJtM0Z3U1JDM2xMWC8zNjd4dDlBODJsb1Rp?=
 =?utf-7?B?dDJmRVhNYmM2T1orLXByOTZKdVczUlZDM2VTQ2IvVWwzdVhjdU9pZXZYcHZW?=
 =?utf-7?B?cE9vN2FNbDNLa2trendTU1A4cnJOZk1tMmNNOW9yUmduUVd5alVjcS9zeE5Q?=
 =?utf-7?B?cmJRZ2pqWmRWQ092WXowWTk4bUNINHA3TU1zbHk5MjdJbllGc3ZIaUxmUFFP?=
 =?utf-7?B?SHp3ME1LWFIrLVFaR1g0SENEcUtDMjVJT1VrMFlyc1BjTk1zVzMvVmxQdlI=?=
 =?utf-7?B?SystamlCZGpHVEE0U2VFVDBWYVc3OWNubzNMNjNlcW5tOWxYZ2NvTm4vKy1o?=
 =?utf-7?B?NmRScWl6N0paZ2plbHpVWWM1RXdUbjhBVWFWNTNYZTFDTEJnbkp2Zlk4V3VZ?=
 =?utf-7?B?bkU0TGZkSjdDbmI5d3VJbGhjSHEzMGdjR1djdEc1TXllWHNnRkZScDg1ZkNV?=
 =?utf-7?B?L2t6TisteDFLT3NVamgvdXpDMzlEMVI0MEVaRHNMUW9IUCstSnp6YzF2VmNa?=
 =?utf-7?B?eVRUYUpkQ3lTQnRYaktxVUVLbEVsZFU0eDgvSDYrLU5FZHJ2Z0dqOWxWazFs?=
 =?utf-7?B?VWk2L2pyT2M2c1BOTUx0NVJEWGtDckVkUGVnVDhJelVTSDFkbXZDdnVEaEo0?=
 =?utf-7?B?SEdUQ3ZMNDFrVnlvNGk=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3922.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?MjJNNS91bm5BOW1PTXo0dExzT2VsVjZyS0NidS82aWpvSDRUQW9oeUo5Tk5R?=
 =?utf-7?B?Z21pQ2NaQnl5MEg2cXErLXJZMWExNDA5NHI0Ky1WdWt2MUhUTEdTcUZIMDNi?=
 =?utf-7?B?WHB0Y1BQMGo4U3lnaWEyTFI3TEhrT3EwRFR3UzVDUlhQOWdyLzVyUy9WMXhk?=
 =?utf-7?B?anp6bU1HWUJZNDlwUElYaWVQSmZaMW11ci9GeTZjbm9XM3VIMGdiRkx1QTN2?=
 =?utf-7?B?aHkyam9MUE1IaUIrLWFsTGVqRkU2MGUrLWxpaUlOUGJNV3ZQTlQvaDRoWVJ3?=
 =?utf-7?B?M1ZJVk5vNk45Y0N4ZGpDKy1IKy1EWTFNUmpwM2d3alczdkNBaFZGYTF0V3A4?=
 =?utf-7?B?a2FtcWVNOUY5UzlJbkYrLW9EZGpOeU5lelRLRkNsS2dPUkwzSmVubi9ZOVBw?=
 =?utf-7?B?cnlLWlMrLUEycU9jTXltTWRZV0NRT3gxeVE2Z255WU9DeFF4VmRyeDdPemNs?=
 =?utf-7?B?R0oyWGdqTDhIQ3NVMlMzTDcxamh0RistdjFNSGhlWW9MVzI4SHdtUUpKaWlP?=
 =?utf-7?B?d3lVWGMyOVpxdldDeVp4VVFyZWpUU3lSRGRaZVBOUlNjYlBtWGpWRzUzV0dP?=
 =?utf-7?B?RktIaE5raGVKNkhQSUppcGJrRC9IOXVIQlE0b0EweVB2TkdGOEI5L3I3RHNo?=
 =?utf-7?B?akNpaTBORHpNbDJMY1dxZ2ExVGtRRVpNQXV5anVyeDk2eVJXUk0wcmVsUEpw?=
 =?utf-7?B?QlRIMFNpd09UOVFBa3JvVWZuMkpWUSsta2lBZ2xCanNqeGhWbDlaMGt0NUFw?=
 =?utf-7?B?dWZPQlRBNFFyNy85d0lCQ1dmanZOcTBUZVM0NzAzeGY0TmFjN3pLeVFOYVdW?=
 =?utf-7?B?aGRwTWR1WUhUcS9xRWh6Zk9hMU9VRTI1NXBsejM3Q2R3UW4xcHR5SDVEMko1?=
 =?utf-7?B?VGlObGFyd3ZLWWxYL2NkVmxDY3ZLcmEzVjVLZDV1QjluanZveVlFTG91bENp?=
 =?utf-7?B?a1lKeGhTVFdzNWZDMVBSUWJ3N2dmS2FnTGZmQmh6R0xDTXN3N00xenBZU3BX?=
 =?utf-7?B?SzBTU3lQdFU4L3JYUW5SeWhGa2Q1N3JrTmRJTDhSRmVJaW1sakJzQlJTKy1Q?=
 =?utf-7?B?VU5RZHpNa3FVbXVzVXNRYjdCLzlyT1BFQ3dBZThZa0x5NXNSQ3MxOWlGTm5L?=
 =?utf-7?B?dkpNYTJYZkxKMlZYOG5HblU1emVCYk9ZcjlMSVVIZ2E2dnBiLzVUQVd1VGpB?=
 =?utf-7?B?eUYzSzB1SHJYV1VrVEpxL3FnNUlhSWJVcFVPc1BQNWpQbHdjMHJFcVRsclVD?=
 =?utf-7?B?U2dMbmpwNnJ6MEhna2VkaDNNZCstaVh4QXZTazc2dkVFR1lucmVoYWk3SFFY?=
 =?utf-7?B?bVlqazM4MkFLYWRTbzY1NzdyeTFDL2wxcWM5ZDJYeXVqSGZ3WE1hSTUvM1Q5?=
 =?utf-7?B?R3J3akg2eVZMWDBjZ2ljM2Rzd0w4eWlKSWg5bFZYQUxHdkRBdXlVMkg1a25N?=
 =?utf-7?B?Yzh2S243dDJSM2tncUVGZ0FUSE1VejBsQWJVSzBBbDFtcUdwamFjKy1Hek9v?=
 =?utf-7?B?T3VwcTB0UTJSWnEwL3A5Vnp2czlrYmJvanlEMTJyemFSUW45UWhFM0tVYk9n?=
 =?utf-7?B?SVk1UUt1TjlXRmdxYXp0NXdDbnFOSGFoT2phNExsNFIzaHNXYWdEdldudGts?=
 =?utf-7?B?SWtiVGlzSkxHaHJWZGpVZ1ROUjV4NistKy1IdWNRbEhxRlJmNk5tKy1tT2x4?=
 =?utf-7?B?Tjh2WXk3UENmT1QvQmNuNistQW1tZW56SzEyOU51SWpFME1VOE9BaHFHZ1lQ?=
 =?utf-7?B?S0paNUtyWVJsVHJBT3Rvd2RrMk1FcnVlZTM1cUNqUGg4M0xrYU9PQ20wKy1t?=
 =?utf-7?B?TlV4RHRLRW9UcystVTVlQkRMS2VDWEZzaWROR1FDNTNrcjdqSTVXNmlOc3ZU?=
 =?utf-7?B?RXM5UGRmUVViSVhQS1pQbVhmM0VPZTBSaEgwKy14ODZqYUJiNXAzN1ZqTTlh?=
 =?utf-7?B?VXp6Ym5CdkJiekliR3ZNVTUzckpZNWI4V1VXaVFpN0dxbjQrLWF3dnJzelJq?=
 =?utf-7?B?T0dpM1NnT1R5YmRxbndXdjJZZkZjRk5mem05bXAvVlAxKy15SFJaMnVRSzA1?=
 =?utf-7?B?bnhDdmZuTmxCaXRZZTlDSEc3cXlCa25JME0xRVZVYkQ2bWxhNUp6OE4wMmcw?=
 =?utf-7?B?blMxYzM5cjNwdkJtR2pkMThMMFRpZ3J5MENsZUFFOHNPT0NGTEVNRzdQRDhO?=
 =?utf-7?B?SWc=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR19MB3922.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e721aa0-a742-47e8-20c7-08dd7280e9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 07:26:56.1188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIsiPpwrv8RMWCTE9phWxJkxdu5TjbVPz+USTmWQOw+KNJgt4S8XOHDfFqsrrAQLJxELxuk40QDhblDPywDnwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504030033
X-Proofpoint-ORIG-GUID: bhg-4qr2kX-6Jedt1dDQvmRBWdnX1uI9
X-Proofpoint-GUID: bhg-4qr2kX-6Jedt1dDQvmRBWdnX1uI9
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030033


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Mario Limonciello +ADw-superm1+AEA-kernel.org+AD4-
+AD4- Sent: Thursday, April 3, 2025 11:11 AM
+AD4- To: mario.limonciello+AEA-amd.com+ADs- Shyam-sundar.S-k+AEA-amd.com+A=
Ds-
+AD4- hdegoede+AEA-redhat.com+ADs- ilpo.jarvinen+AEA-linux.intel.com
+AD4- Cc: Shen, Yijun +ADw-Yijun+AF8-Shen+AEA-Dell.com+AD4AOw- stable+AEA-v=
ger.kernel.org+ADs- platform-
+AD4- driver-x86+AEA-vger.kernel.org
+AD4- Subject: +AFs-PATCH+AF0- platform/x86: amd: pmf: Fix STT limits
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- From: Mario Limonciello +ADw-mario.limonciello+AEA-amd.com+AD4-
+AD4-
+AD4- On some platforms it has been observed that STT limits are not being =
applied
+AD4- properly causing poor performance as power limits are set too low.
+AD4-
+AD4- STT limits that are sent to the platform are supposed to be in Q8.8 f=
ormat.
+AD4- Convert them before sending.
+AD4-
+AD4- Reported-by: Yijun Shen +ADw-Yijun.Shen+AEA-dell.com+AD4-
+AD4- Fixes: 7c45534afa443 (+ACI-platform/x86/amd/pmf: Add support for PMF =
Policy
+AD4- Binary+ACI-)
+AD4- Cc: stable+AEA-vger.kernel.org
+AD4- Signed-off-by: Mario Limonciello +ADw-mario.limonciello+AEA-amd.com+A=
D4-

Verified the patch on the issued system, the issue is gone.

Tested-By: Yijun Shen +ADw-Yijun+AF8-Shen+AEA-Dell.com+AD4-

+AD4- ---
+AD4-  drivers/platform/x86/amd/pmf/tee-if.c +AHw- 4 +-+---
+AD4-  1 file changed, 2 insertions(+-), 2 deletions(-)
+AD4-
+AD4- diff --git a/drivers/platform/x86/amd/pmf/tee-if.c
+AD4- b/drivers/platform/x86/amd/pmf/tee-if.c
+AD4- index 5d513161d7302..9a51258df0564 100644
+AD4- --- a/drivers/platform/x86/amd/pmf/tee-if.c
+AD4- +-+-+- b/drivers/platform/x86/amd/pmf/tee-if.c
+AD4- +AEAAQA- -123,7 +-123,7 +AEAAQA- static void amd+AF8-pmf+AF8-apply+AF=
8-policies(struct
+AD4- amd+AF8-pmf+AF8-dev +ACo-dev, struct ta+AF8-pmf+AF8-enact+AF8-
+AD4-
+AD4-               case PMF+AF8-POLICY+AF8-STT+AF8-SKINTEMP+AF8-APU:
+AD4-                       if (dev-+AD4-prev+AF8-data-+AD4-stt+AF8-skintem=
p+AF8-apu +ACEAPQ- val) +AHs-
+AD4- -                             amd+AF8-pmf+AF8-send+AF8-cmd(dev,
+AD4- SET+AF8-STT+AF8-LIMIT+AF8-APU, false, val, NULL)+ADs-
+AD4- +-                             amd+AF8-pmf+AF8-send+AF8-cmd(dev,
+AD4- SET+AF8-STT+AF8-LIMIT+AF8-APU, false, val +ADwAPA- 8, NULL)+ADs-
+AD4-                               dev+AF8-dbg(dev-+AD4-dev, +ACI-update
+AD4- STT+AF8-SKINTEMP+AF8-APU: +ACU-u+AFw-n+ACI-, val)+ADs-
+AD4-                               dev-+AD4-prev+AF8-data-+AD4-stt+AF8-ski=
ntemp+AF8-apu +AD0- val+ADs-
+AD4-                       +AH0-
+AD4- +AEAAQA- -131,7 +-131,7 +AEAAQA- static void amd+AF8-pmf+AF8-apply+AF=
8-policies(struct
+AD4- amd+AF8-pmf+AF8-dev +ACo-dev, struct ta+AF8-pmf+AF8-enact+AF8-
+AD4-
+AD4-               case PMF+AF8-POLICY+AF8-STT+AF8-SKINTEMP+AF8-HS2:
+AD4-                       if (dev-+AD4-prev+AF8-data-+AD4-stt+AF8-skintem=
p+AF8-hs2 +ACEAPQ- val) +AHs-
+AD4- -                             amd+AF8-pmf+AF8-send+AF8-cmd(dev,
+AD4- SET+AF8-STT+AF8-LIMIT+AF8-HS2, false, val, NULL)+ADs-
+AD4- +-                             amd+AF8-pmf+AF8-send+AF8-cmd(dev,
+AD4- SET+AF8-STT+AF8-LIMIT+AF8-HS2, false, val +ADwAPA- 8, NULL)+ADs-
+AD4-                               dev+AF8-dbg(dev-+AD4-dev, +ACI-update
+AD4- STT+AF8-SKINTEMP+AF8-HS2: +ACU-u+AFw-n+ACI-, val)+ADs-
+AD4-                               dev-+AD4-prev+AF8-data-+AD4-stt+AF8-ski=
ntemp+AF8-hs2 +AD0- val+ADs-
+AD4-                       +AH0-
+AD4- --
+AD4- 2.43.0


