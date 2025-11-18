Return-Path: <stable+bounces-195081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4C4C686BB
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 10:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69D9E3446AD
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ADA302758;
	Tue, 18 Nov 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lC17WsBb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zowRhWze"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF691FC0EF;
	Tue, 18 Nov 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456548; cv=fail; b=dPFHNUCSUL+CmtQN79K8cHQDJO3dSrgvamARH20G9PcKvoOLOAYVBp0nhDfB3hTz0WYB61ZFuxDeJ9wojTGNzqv47qB3wqGAjjMDmQh86fgWute704s302PIxKj0PwL+rjCJfB8xBbC1fACw1ApWhNUZu7YwGs2WsFFIHJA9tzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456548; c=relaxed/simple;
	bh=ejqkXNzEXiWCbXqcnKbS5e9Iuo++kl57EKs5xNlk30g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nhg40CPzS4Zzr8ivJzkdzI3YoTZAFKyLUdpX1nY9l0WBQOfDyhFFCYtGCSDpYYBUj5RFIuNoDVgUgWfdmuEg8Z8TCNSU53QXOhPW0gHMI+/SasHF+z8bMjuk27Ka0NYhGnBAff8M/6HT8m+7c6cHAMp/s5lkHEdbsQtdkKTXPbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lC17WsBb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zowRhWze; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI92H87008802;
	Tue, 18 Nov 2025 09:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cZYmjlJyeV9SYBvMOoQp+BhRj/n925IeW4tDl4jDZM4=; b=
	lC17WsBbQ1ScGpmwgrrdy0JlrO/4rJ/5Dh/DHzCmFJCyzykWE4iHyVcrrJ40x/Dv
	ygBOIyCLIpyCZQOuiSNxHEaAqrvEs65UWw0AAwPEHScK6gyN8pj8rTJ0N8sSkSLN
	UdAlNHQtWOu91kRpTW+q0qk337Fqk1FldSFZPY+k5k0GVoP3l8JVvXXK4lP8CZhE
	+X4zmwYkmyh0FYo5lKnnJ0cWE5ZKXCdzvtTfb1rmDwn31XHHsI9JZpy1OZVHAT45
	f+kVCOSJzFEDpDtBkV0uCWyZPhdaMgGumcndYcTWoJU6VQe0vjqB5NQ3lFaOSWSO
	jDoeK+skuHMnSBeubuh56Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbpvd2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 09:02:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI8cege007189;
	Tue, 18 Nov 2025 09:02:19 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy8venr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 09:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fop9MY9YiVGjYAWQTyqPlLZdrsC4tw9ARp+OoK2PwnT8SritBAwPQY7fuSW89GcuxqLzhP1UgM50aS8gudlzuKmqW0z6TL8QAvKKxNYmdopG96MhCrxsC2SKnVtVxePb/LWyJd6yAm9vvNK3VdvX83bW6A3f/D/pkbaaWBxC5oFOjv89QTw/t3emvWozqzIhBuJVdBkVyJnVohJEpBcizWWqX3paJifsUjNWEoFF4+B/TI1zPF9n5XhWvFacnFekKFZuveRIjXohysdKF/ZknJu5o13HnLqi4WaiROEKy9jBMJLgPQ7fPO+f/pJ4sG7OpoyxIIllsKy9oTXhxQ+iYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZYmjlJyeV9SYBvMOoQp+BhRj/n925IeW4tDl4jDZM4=;
 b=Ti7AgtoNhnt0V1kenYz1X0JKIZjbQYTwGZYXYQl9wc/GgWDFaWTUr1mMgOyy6OFXpDODdfVWZ/o//KIpbw5SnxX7uJ6pyug60i6hE/u5+BiP8vt4IrrY1GOF7JXVFXo6d/B3XsrteSM5q36K5Rk4Kh50Q4IX3LGq8//ENGUj3CQ/eP8XHQ9SwWNjVGcTliRXTumeL7FhWEwbRlIsQpufhsWbtA1CraRuzQ7gb61gwDDC4cE21diXS1LYjSurgCiypB51mvj795Sl8My9yDRd1CJr8Y2Rmj3r+FB7kWYDLYFyKJ/kFSKrR4Gp41dlbmDAuzkB8Oz3ysB7Yy/KB35ONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZYmjlJyeV9SYBvMOoQp+BhRj/n925IeW4tDl4jDZM4=;
 b=zowRhWzemXiCxw1TbxTQHaO4pBKQJsRzM4IBgyPgivBaknQOJiAjKhSs90gN/oziZlgYRNTCEVVBowdRSztNv3FbRxlaDuubPw/66gp1r4MBx7Q3hC1q/KX/AzusuWNoGan1uo0C0UxSK8V8+wg3iYMdNEtSDNDjGTzyN5vGHIY=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by SA6PR10MB8013.namprd10.prod.outlook.com (2603:10b6:806:447::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 09:02:17 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::6ac8:536a:b517:9364]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::6ac8:536a:b517:9364%3]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 09:02:17 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] Revert "block: don't add or resize partition on the
 disk with GENHD_FL_NO_PART"
Thread-Topic: [PATCH 2/2] Revert "block: don't add or resize partition on the
 disk with GENHD_FL_NO_PART"
Thread-Index: AQHcWC0EXEJKAooKnkemT7DWcQ8CSrT33tiggABD9ACAAACAAA==
Date: Tue, 18 Nov 2025 09:02:17 +0000
Message-ID:
 <IA1PR10MB72403125E25B4981BB77851498D6A@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20251117174315.367072-1-gulam.mohamed@oracle.com>
 <20251117174315.367072-2-gulam.mohamed@oracle.com>
 <2025111708-deplored-mousy-1b27@gregkh>
 <IA1PR10MB724026C01ABF778B9E9EA10698D6A@IA1PR10MB7240.namprd10.prod.outlook.com>
 <2025111848-gusty-unclothed-9cc5@gregkh>
In-Reply-To: <2025111848-gusty-unclothed-9cc5@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Enabled=True;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_SetDate=2025-11-18T09:00:44.0000000Z;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Name=ORCL-Internal;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_ContentBits=3;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|SA6PR10MB8013:EE_
x-ms-office365-filtering-correlation-id: 02491bc4-7541-4d13-7bbe-08de26812cb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-7?B?N1A5UFZVVXdGWUVBdG9jbm5hTWg5VmQ0YmxKaDQxTTZkUnlWTFNqR3hLYzk3?=
 =?utf-7?B?bjJ5SkRESDVjVXdEeDF5WG5TYW1jdWNjWVRTRXQxcFlRQmN0aU9EMEdQTjVO?=
 =?utf-7?B?bSstQystZHpEKy1wc2RpYW4vZ1AySlhLWkdscFNqalVKL3M5RTc3SUF1RHpP?=
 =?utf-7?B?Y2FXbUtvS0VGb0d5TklZWnZwTkcyUm1SR3d3SG9DSnIwN29MRmhaOWx0MVRm?=
 =?utf-7?B?Ky0vaEZqellIa3JaeXpkRk9VcUhWRSstYTVleHVGcFlKaVhzZ1NsQk51ZTQ1?=
 =?utf-7?B?Wk9wOTZVY1ovU0VBczRzRlJCKy1ubFlZKy1tT0ZudlpHQTJ1NnhkN2NnU1Jy?=
 =?utf-7?B?bGwrLTFrQ2R5VkVYRUk0YistUmxINTViWjc4MXNEQUJRTWlSY3RuOEFaNGVU?=
 =?utf-7?B?L0FxbndaU2pOenJFL1dqME0xSE0yVnBRVERWMmovejZPRVBSM2Yya1l1c2Fy?=
 =?utf-7?B?dWVSL0NhaFVqb2tMajRJc3lYZmtZeistelpuMUd0alZFUFpMNjNxWERaQVBa?=
 =?utf-7?B?NDd1cTRHRG9rY013NlJxSm95RHo0WjNLOHVyTDF3eFdlbjZtNjQybUNzMExW?=
 =?utf-7?B?U3RFMC81dmkxWHFGcEhONDdYY3hidi9kUHBNUW9FWHU3TkpWVUhUWXZPeXV1?=
 =?utf-7?B?OVV3SWx2UHJaenNsKy1ER3lQdEpVQVlEY2loc2pKN3FGYTUvVUpPeDdVVXRR?=
 =?utf-7?B?NzRQZVBoQnJ2T2J2a3RBNUFmZm8zSTVTWjlOdGxIcGJtWk5GYml3NU45dGFX?=
 =?utf-7?B?ZFNtYm1QY1VDaWg3UEpZU1N6MEVRTTd2ZElVdVJKMG52bVEvRWl4OFp2MjF5?=
 =?utf-7?B?M1dyd2hyaUJkSHlFZ0EvZzk3dnRnRDFKbVZ6ZXltNHBHTm5iYlZxOTRhelZN?=
 =?utf-7?B?NistUmNKZllOTU5HSGdVT2tJY1UyVnorLXpzdExMYnVhN05TQ0loamQ3Rlli?=
 =?utf-7?B?ZzJ4YnVSb29jUGN1SXcxbVVzM2pKRmZyU0sxNXJCLzFyR0Z3SmwwSHI2OGFV?=
 =?utf-7?B?d3lFSzRxdCstZjgrLTZFaUNiUjBPZ0U4ZVk4QlpJKy1wYWcvWURXOEdVbzJj?=
 =?utf-7?B?R2FUKy1NY2hGUlYvSElLLystSistVWsyZktYQmNFZzBqZXNhaUpjcjhmNnZR?=
 =?utf-7?B?WVduQkhnUUxQMW00WE1xU2l4ZThNTy9QWERLZjZaTVNSZGt1SWdNVVBHLyst?=
 =?utf-7?B?Q2NYT3JQMzQrLXJ5WWZBMTl0Yld4Ky1qMTEyUnhPc3VXdUZKY0RGbGxQeUVE?=
 =?utf-7?B?eGNGak5TZ3o1cjR5dEZFSGM0MlFCT0Z4bHFpMnRuWU5pVlU5dG5GR01oT1M5?=
 =?utf-7?B?U053dFZ6TE0va2dnM2lwcUhMSEdRV1hQRistdy83VkFxM3RieG1DclN6eEV6?=
 =?utf-7?B?YURiU0IzaEhtdTg2MmtNNkcxY0V2cGxRV1R5NWVQd21KQldhUENxSDBFVFl5?=
 =?utf-7?B?WG1rQVIzQmtzN01hcEZaRExWRjJDWjBkejJKdlVIZ29VcU1yM0NqL05BM21k?=
 =?utf-7?B?RmxOYVlWaGFRaldwWEhsM2paZ2VrcXh0TXB4a0ZBaUVIYWR6N0Q5akxtWlVw?=
 =?utf-7?B?M1QzTFkrLUNNdzJPRnhiZ0NhUkd6QThnWmRJM0VmbjFVRXZLV0IwQTg1VW9P?=
 =?utf-7?B?a3UvbE01MzZxTjVKM1dtTXVFUmVJSEhONzdMYTB3RlJjSmVMVTgzTGVEN0JB?=
 =?utf-7?B?c1NBNnNvTE04cVZXR2xWQVZQRTA4dFFYazlMRzNtcDJaMzNqdjNjeFUwQVZ3?=
 =?utf-7?B?anE0VUhIeUNPQ0lsSGxHKy1vbE80SXVDTGE3QzN2cTAwSXJPSUNINUZLMVRx?=
 =?utf-7?B?V2oySWt5R3QrLWd2M1J1eGlmVTNDU3FaSzc0dystUVhzSGZJRGwwL1I3Q0hD?=
 =?utf-7?B?b0NjZnhFOEtQa0V0NkZhRWIycndZTGZQbjBEVlA5cSstOTJRNkN1eVQ4Qk1X?=
 =?utf-7?B?Qmh6cjQyT3cwSHNNY0lzWG82Y0E3YkUvLystUVBUQ0ErLWxYeTI2U1JzVHE4?=
 =?utf-7?B?TUZROEFHRmJwYnJnU0kzeFB6c1pKZU1QVHc1UmdFTHd1U29MdVFzL2RJRGxZ?=
 =?utf-7?B?RS85ZkZTZjExVmxlcmFzS2hPekoveUoxKy1jMTNhSFFRQklndg==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?MmRDUlJWVzkwS2JqNU9DS2hZYnJKdDJSS0ZzVVNNZ3Fyb1puRDBqdTQya0cz?=
 =?utf-7?B?em1IRm9uaGdWU0RjbWVjQ2syOExPOUxYTld5VFQ3c0o2aUxKYVgrLSstTFJC?=
 =?utf-7?B?Z00rLVNlZGJZL045cUU5VFF6aVJSZ2pZL0YwN0FPVmVRRDFNclBYcjV6clli?=
 =?utf-7?B?cmNXTFJUYTdaMFYxQkU0REhHczA0cGw0eXYyQ200QndpRFZzQmF1TTNodnA2?=
 =?utf-7?B?Rm95TVJlamZRQjZZRFFITVg5dFJYYSstLzNOQlpsUG5NWGJsSDg3QTRsOU5X?=
 =?utf-7?B?T29NNnZMU3pZcUg5UEN2Ky1pWndxV2VTVEw0RGRQenhqbW13UXhsM01WbFZh?=
 =?utf-7?B?TDRlNjc4Vng1MHcyeXp6MWJpYlVjSlBPY29xNVFsNTg1Tklia2R1ZjlXb1Yy?=
 =?utf-7?B?T3BsRE1iM2p3anJYMmdpRHlyWGtRdHozbE9SYWYyKy1FU2Q1Tm1nUDNZUmdu?=
 =?utf-7?B?R0JaWjVIVDF5aFZ2ajlDNSstZ2tqN2tHaTMyNkhxb2sxb2dEQVJwTGxkek9U?=
 =?utf-7?B?TENGUERQRDB4S0x5OXRwOHJEZTliKy1WU2FoNTdJekVCQVRoTjMrLWpNbGV6?=
 =?utf-7?B?SnhzeldFUlVOVkszOS82YmR5SHd6d25OY3J3Yy9yN0wydFAvYXIyaG43YnFV?=
 =?utf-7?B?MHo0clI1L0E1ZnNlNWpaSmNrdG83TXl0bGlWWGdRN0JxV3VHUXNZNjFLU042?=
 =?utf-7?B?M3d4UHZLcm5aSThxRVhxMjlwc0hNSXk1RHFBL00xd2o0cVNsY3BiMFNPbzBi?=
 =?utf-7?B?VjgwcS90MW5xcDg2YklhY2VzT2VmeUZuOE94RWNCT01CVlg4VWZRVTE3Z0li?=
 =?utf-7?B?eEJDM1NQbmhpWWJNWUI4YXlUTkpqZUg4YXgxVTlkZHhsaDlDd29HKy1mZ1oy?=
 =?utf-7?B?SFE1L3FweWlva3U4U2pFVVNKWFA1UTF3RngyT2NST28zSjg4c0srLVpmNWNH?=
 =?utf-7?B?aXBxT1BtTWFJbGt3T1VwRUprd2tzNm9xU2RmeWUxdjNHSnRRSmpDdnUwNyst?=
 =?utf-7?B?bWE3Q1NBTjc1N0tOWlIzdXdWdWozeWdwU1p1VXprNmNzQTNHNEoxMnkyZCst?=
 =?utf-7?B?M0lJVmJ2ZnQ0NWVieVRFS2kvclo2V3NaR3lOQTd5WFZYY2NaNG5uQVdyMEJa?=
 =?utf-7?B?SEZIVG4wUlQyTk5EUU9kRVBFVVFJNHdVNzdwdDY3N2pMa0RaSmV2TmNSaDJC?=
 =?utf-7?B?OFVsWUZtQlNwUXFHaGNkKy1KaHpLd01MU0RGbjI2UlZNaDVRN0V1SmpLb1lh?=
 =?utf-7?B?ejU0U3ZSWHZxMHpXTkxwWTVjVERpZ1YrLXpUQkZTb2puMGJlWGZWS2NQVEMv?=
 =?utf-7?B?TEorLVNkWENuektMaEZ6dTBSb3ZVQ1VVcUVBQTI4Z1JTYWNnOUVDR3ExcEQ2?=
 =?utf-7?B?Q1YvTHFOKy1ZenVTVE9QQ1dOWUVxQ1p1RUcrLUdLcWlCU0NxYW0xcistMHdl?=
 =?utf-7?B?UmdxcTZObWlEcXBaQzM3UmphRGNOUWl5R2pxc3JiOFljZDdEZUFwVnRJbERZ?=
 =?utf-7?B?UDRiMjFLM3EvMDdHZHdTKy1qSWsrLWR4T2szQzlVbGh1eko3WkxXZE1WV1JF?=
 =?utf-7?B?Vnovd0ZRcHI0UVN5a1ZMRkVsV3dRMW9ZbG53akt0UlhFYSstaXlUU2N2SjdN?=
 =?utf-7?B?dGhsSzZFZ24rLTN0MVo3RDNRelFPcVZpYzQ0YmRMTnlDNWZwaEs1TFIyRDN5?=
 =?utf-7?B?WktSWUlvaHNrcHhhMlRrRURGNVNsUkhCYmhaamNOemxweDZ2Ky1iSGE3cDJl?=
 =?utf-7?B?WXJXbmJwVEtuLzBXeGtCQ09uSWRhL1plbHRDdzRhaG50S1RiVSstUzNPZlR3?=
 =?utf-7?B?Q2NiQjRsbVNyQWZ5OVVQQ3U0TVZpTDRNQVh4ZmxNUk1oUmFXTm1qUDlJUGxZ?=
 =?utf-7?B?VU53QTZPaUxTckZMZkFlV0xIUUZvMHZPUFkwSDFFTHRCYnM4NFV6WEw2amZW?=
 =?utf-7?B?VVFwbk50RWJBdk9zd0UvVkhMZlQzUTVETmVGa2hkbEYrLXgwL3dHcmVWbTY=?=
 =?utf-7?B?Ky00WGxjY1gzcHY2RDRCMVEydUxLbXFPQmt1RjlGV1RacGxGM1ZoRUo2RE5L?=
 =?utf-7?B?bExPVFZFY0w2YzA4cUlvcU0yeVZhb2ZuaVQvYW90QUJrWDBVWnZWQUlmbVZ2?=
 =?utf-7?B?R0Y1ZnlmKy1mVG9Pa3N3eHhMWHlqRndrUm4zR0RDLzNWem9JbFdObEFzVlV6?=
 =?utf-7?B?WW1Femg1clhJ?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2ygIiU7BJTKU5cMm37Lbjwmyf7n6wRd4+SccKY4LMVDmkPZ6S1eLWDuiHCD/vzpR/zNimuB1pRV6KrTXUZKUHzMNAaRED2O0rFKwZJRmh+MLuUhvKoW9JSx6pxDGFvfrGH/QyrPK0Qw3UoSiQ0NGl2pE9mBzLA1a9atOV26RhldDokUgj0KcFD2pbPNnzkHVozrdG3lPywdaPIT7mcw0PhnT4QwRIqt+ErfQtIzVbPxmkaxwOLt3pD3XN3aNdVP7kM73dI8P90LEn/VupzcrolhQV8XxOQY+MNapBKZidtwMIB5B/1wlcUHKcmRlgdXbxzZk7uuNerq50MUg/VaHCtJ6QDVE3mA+ZndLivv1mwGOLog2s/W1sqHfdYRrDHwuu85SnYGgGei23wjmegh2+CHa8xy0fgFuA4JLMkzGJlphBzJllxXI6J3kgz5zI5SiPUC75ZGQ3veySztfngI1/q316iSS/QYoWYuJLLJxcM+9A/tuC7OFoS87ZgGtZ3qqmGFWYGS9RnY7UD3gNOhdeqEpuS9rLCu8vR1CXDamA0whtmkL4RzjZRmZVlIYGjD1Xocuz0XIlEwfCga8CHu3jp0faYS9axLj5Z1g++EccuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02491bc4-7541-4d13-7bbe-08de26812cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 09:02:17.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNnGUqD/HJvpp7QpV3t5ZdUPqAY0P53q30uXoLi/46fR+sA2Gyx3C7Ij503YqVsFeQAaEL3CPMdDKNzS9K3wWp42C4u/aJViuTVXk6hDLp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511180070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX1Rws2odXgekF
 XhNl3IexZLmWFYIo2Oae4dDaRhCZRBcP6ZC/i/3m6WfuhRN/U9IeyjC/+dJSEspXy8Df83Xjad8
 1OYkac2u9O78vR3X2jskmJ3J6Jp7RfD5RcR7jZ9TIocnR6g2pHaLTygyMoZyu8Z2mM48s3V0DhN
 LzWt2vA2+jV8ugnDKQBKD0CJApxgEVDkEN+RYkkpp7YhUR94jwH4YnwcV+ECbUAVWMVlzMv31BD
 F6aqxfh3TMybRLM4IhzjCGqLxhWC3COG8wdA3ik8ERAWhona1CCKD10Q5/Nbzq5hbQb+EtRJJK8
 VL1ReDsItYpw6Mm1KXsASuCoRQexZGfhAnpPwfaeEyL8LumUnd0+KpZFxystO6IrNARP92HEGTI
 CeGoEOJKLD7rLgTiOh/VAGHtisOwAw==
X-Proofpoint-ORIG-GUID: CxCjmcjiwTOOA8swQwerwEsSJUm7W1eN
X-Proofpoint-GUID: CxCjmcjiwTOOA8swQwerwEsSJUm7W1eN
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691c361c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=WJJPNcJBAAAA:8 a=mQvHCebiAAAA:8 a=5XuUBu6sk8uQIPROh9EA:9
 a=avxi3fN6y70A:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=Orvq6HXzVWGNNdQUjdZg:22
 a=wsrb8zZI_WQ3QAEBCXTy:22




Confidential- Oracle Internal
+AD4- -----Original Message-----
+AD4- From: Greg KH +ADw-gregkh+AEA-linuxfoundation.org+AD4-
+AD4- Sent: Tuesday, November 18, 2025 2:29 PM
+AD4- To: Gulam Mohamed +ADw-gulam.mohamed+AEA-oracle.com+AD4-
+AD4- Cc: linux-kernel+AEA-vger.kernel.org+ADs- hch+AEA-lst.de+ADs- stable+=
AEA-vger.kernel.org
+AD4- Subject: Re: +AFs-PATCH 2/2+AF0- Revert +ACI-block: don't add or resi=
ze partition on the
+AD4- disk with GENHD+AF8-FL+AF8-NO+AF8-PART+ACI-
+AD4-
+AD4- On Tue, Nov 18, 2025 at 04:58:24AM +-0000, Gulam Mohamed wrote:
+AD4- +AD4- Hi Greg,
+AD4-
+AD4- Please do not top-post.

Sorry. I will take care from next time.
+AD4-
+AD4- +AD4- Thanks for looking into this. This is the 2nd of the two patche=
s I have sent.
+AD4- The first one is +ACIAWw-PATCH 1/2+AF0- Revert +ACI-block: Move check=
ing
+AD4- GENHD+AF8-FL+AF8-NO+AF8-PART to bdev+AF8-add+AF8-partition()+ACIAIg-.=
 I have mentioned the
+AD4- reason for reverting both these patches in the first patch.
+AD4-
+AD4- That does not mean anything for this patch, you can not have no chang=
elog
+AD4- text for it.
I will add to this patch also.
+AD4-
+AD4- +AD4- Also, this is for +ACI-5.15.y+ACI- kernel.
+AD4-
+AD4- Really?  Why?  Where did it say that?  Please be explicit and say tha=
t
+AD4- somewhere obvious so that we know this.
Sorry, I forgot to include this +ACI-5.15.y+ACI- in the subject. I will inc=
lude this and re-send.

Thanks +ACY- Regards,
Gulam Mohamed.
+AD4-
+AD4- confused,
+AD4-
+AD4- greg k-h

