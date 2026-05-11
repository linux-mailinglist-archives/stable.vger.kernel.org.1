Return-Path: <stable+bounces-245152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMxICg6PAWpyeAEAu9opvQ
	(envelope-from <stable+bounces-245152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:10:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B71509DF8
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C9B6300E28F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8B3B637A;
	Mon, 11 May 2026 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C8Zhgs4S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r8Qz0Ro8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235A23B0AE5
	for <stable@vger.kernel.org>; Mon, 11 May 2026 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486671; cv=fail; b=cahkvWNjP44gRUYvOLrQ1lrrm4QiI59jR3OTZ81D+zWqhwTVK5Q92Ecw8LH6KhdphiHBvqOgsupBq6Zys0nsJI6kzzGkx4l9HjbpYwPKkrbbaMaO0LUlRRyiiWKcQZuk1Pfc5XCJEGnuOQPcZDZIerxfVMkQjqZII0VDJqCVI94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486671; c=relaxed/simple;
	bh=nMckpKbE8iv/ztx6PBaA1DBq1/3h8dO5IYNYfmE/4+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R/xx9SMshceDhAZaxUFeCL4z2x+LBBcMH75iXJO9+xDkkjf9mE1Pta1GhbB9wBB9PcH5SGTxQq91vwCm83gABAnBmZvw2BeqHqFBEFx6T3gXOgSeNuXewZ/N0OLz08G3RIZRdI4P9VzLzpAEFTvOK6NnBDNFOmVFLy1Ysvnk5Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C8Zhgs4S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r8Qz0Ro8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AMt2Rt1811624;
	Mon, 11 May 2026 08:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=e5WupCaaFp2TT0Xlv2RV0uv5Vcvb70JfZZm+egDlFxc=; b=
	C8Zhgs4SwP1Cs3v+Mjh9mmcq0byqAk7Q+FmBoASZSbsxBLXsC/SBseCloKE1Oruz
	2VGZcJWisSC4K50aWZM8OC9tyZ235r0tIV9tnoQQ3FXLhL/QCwedmkpo4YL0aRTU
	hFkQUXVbjq5VGUOCw+Vrh+dkPAXPYZpTx/5/G5bBUK15pCO/Fp1Hf2ISDEnPmuGw
	4OmovVPoVCRllaE72WYKDNpw4USSnXJdHqGdxbfmEt8RXbbQu/hwSHxuCOFgGDVO
	f+5I17KtaQAev9fXDwyMMix7LNc937rUmPau17F6euYLI1H8X4ViV31r4544ZkzZ
	AxxF11K1XtH0TSejZ6cBqQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e1vhs22v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 08:03:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64B81QvV031909;
	Mon, 11 May 2026 08:03:52 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e1uc8e3kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 08:03:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfK+CYpsZAVWkwzK0LMin+erekQqFYklG1avkexIUGg1q0QHqb0m5HdEdCWixeFshHSAo5I4Pp8CzhNYhGeRHPsilgEc31hH+6pc/zWesigeJNH90+8BY79sZR9t/OSN6FwyImXVmCdU+Dj3IzwnKg+ktgfmJTHqadaoQvRYFCurOJwLfwOHrbPIieZvFrDfZuqJP1WBXxB9k1/MX3GJoM7F1RaAc08E7sFehBGkMllhQaA3AbhUvC5fTs9zCIjd9qMbCeWsfCkSiD+EY335L8Tto1nhJSbYQDghqbILz864fIKh2pU7XMsOE4fh2+8Olvf10qmkXQu3FuHZA5tipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5WupCaaFp2TT0Xlv2RV0uv5Vcvb70JfZZm+egDlFxc=;
 b=tVK+jvIKvvsmieODBiXwwhuQr8sDv2kBarQHi8CyK323DC6YHcdYEFcuyhoj9jNBpp6zjl95Wc6DIlX4Fdcm5hAippj+jrjbc0zHG33xVzMxNRFwF1Nadd6NYUdY5BGVIy4Ju7bLKhOo6+9tmYz02av8RhCji/yaewWpMxjM8T11f75KE2X8gJsFDxLLHa5+SKDdVUWtsF1bfJQ1myHWUcXOekDKloLUcDkVPAI2fWhywoeUyWJqkTy6y5pnKTMGsGm7HHXSf+lZZ4pHkRO/wJaBmYJJiF0egwW+JL86B9rM5ZaDMpi815ZzE0hQcfLgF8Mje887G80EB2sFwIgnfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5WupCaaFp2TT0Xlv2RV0uv5Vcvb70JfZZm+egDlFxc=;
 b=r8Qz0Ro8upXjWqHVRuOFRFFNFDe535qxDoXKuYABb01f4ALHkKCeAyNbGDaZF/wZad4So3eQVRSUDqwFGtCT2S3b8AqHCmIuEQvKEcuC8Su4HUX7EaZrb/OvUOdqPMq4F2MZneuU2KHUurAaCuNqOBsbzDlKecb4ppBS4wAp34U=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by IA3PR10MB8372.namprd10.prod.outlook.com (2603:10b6:208:575::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 11 May
 2026 08:03:46 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%7]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:03:46 +0000
Message-ID: <a194c1df-8e39-48b9-a8f5-696e32558bad@oracle.com>
Date: Mon, 11 May 2026 13:33:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y v3 1/2] rxrpc: Fix conn-level packet handling to
 unshare RESPONSE packets
To: Wentao Guan <guanwentao@uniontech.com>, gregkh@linuxfoundation.org
Cc: dhowells@redhat.com, imv4bel@gmail.com, jiayuan.chen@linux.dev,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman
 <jaltman@auristor.com>,
        Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
        stable@kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <2026051132-equity-umbrella-a786@gregkh>
 <20260511074104.60836-1-guanwentao@uniontech.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260511074104.60836-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::19) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|IA3PR10MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: f25f64c0-19f0-4b4f-67ea-08deaf33d3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bkec8JeBABqqbFc/xkUkrk7RKUMBbLHlSYz0bJgWHbV63OuOq/WTbXd41dzo4L/k4WF72YDjoxXaSPvXYAFLIyOQ3xPuXbUJVe6dTdWCaaobtfQWSypGo5MnpXrPPoUyP3gz0uEIDo9m9vLEoX0BTaFgPw8TUGfLdvMm/VkExG4WlACZx9Wg4oqqaIshTn3naLiCWvTj10Bc02U+UhMXJFw4JDs2dUt0H+4c7B409Ev/B13gsFP9/KQ79a6gAwSnvP5SvLiLTcDqECkHCqpxpwk50YRKRK9LrCNMuBMHnF49LgrXYvKtOGs+7rFVEUH2Q+MzDpM95XdUO4bF1PNbL4HFXC6nlMXDphY/dXH6IfK8Cm2PfacN+VoVZZeHGkHO+WNBkv9gj7B4TEbVRdMMDLb1QIro9jlZ5Gx0AaQdZrbjYBpqqOlfMYtnAEgu/IUFMmzmU3nbCevMtHTtSrsWW/t2EtNNkA9W6r/GkzeHPt3ECB73wrg5O5LbRVW/kixzhOeXCnmT9ISsQ1xMTXj08iNl8Bjdy4qf3cuyYc/cqoydFkyTJZo1byKFDMTtBU9EU3j/L71OXoUrr4BDWD7c31gM+YkajAbUaXAzaA7P9r/7xHf9D2sllrbfxMlZ1BnJvtYkOChY98U2Ybg8OMmILFewCTR+emIbitzTz53yFa9QYHBM13N7VYzMIIbpsmq3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3ZMMDdwNWVsbVVrVTAyRzRmZEI5OGpTb0xMTXBYY2RlaUtZc2c3eDVuZnpJ?=
 =?utf-8?B?WEdTb0g5VWJCUVVMVHFTMU5JWGJraG9zM3RnWTB3VUVyQktXQWhsejZJdU15?=
 =?utf-8?B?eUlTZjMrL0ZNRUZtQ2FRbU1UYnE3anpNZWNlZHhSRE9UUzFIVGJ0ZVVYL3pI?=
 =?utf-8?B?UDE4eHpwTUhwV0ZJMlNybUFuTTVrY3NiNHREM0d5TnEzemlGRmZCMVNsOUZ1?=
 =?utf-8?B?MGg3eVYxS3FJeHBpYy9laWduSjN0SGtEdE0zMjE2SVZoUGlwUjFMMHVVc21q?=
 =?utf-8?B?bWtNVFVmd0k0cndtcnB2a3VqSDhmSWpkc3ZsQUI4QUFXczQxWCt6TUZhSWs2?=
 =?utf-8?B?OTVWWSsxK09rZXRSUjczSW54QzFFQXExY3FPblhkNjJreEZKaHVxN3pYZU5q?=
 =?utf-8?B?bXRrWVRibTRRSGhOdnUwNXFjOTdxVjJjSlNEWnNKbi85R0R3MzJ6UmZ2M1RY?=
 =?utf-8?B?REdyNXkveExnRlZuWStVbUszSGxDMEo2dktuaG1Od2twVXBmNWRpeVIvelY4?=
 =?utf-8?B?eVVMV2VWMWFOWk9VeE5YR1BPNHBud2NKcjRwTXRXK3NUYVNid2c1Zm5hNUY0?=
 =?utf-8?B?L05iME9CUzAvRjRWUzlKNzAxSFE1bU1kaTNLMTVUQ1VjVXlSTFhBMGsxZDVq?=
 =?utf-8?B?TUIzSEF5OEY1VDBZS2NlM2t3RGxaVDdET1pnL1E4ZGR6TktrRG9BNlpBYk0v?=
 =?utf-8?B?UWpPMHBqWHFyamMrUCszU0llNVdPUEQzcDRsa0U5MzZqeS94UU13MzFKNXVv?=
 =?utf-8?B?UWJhMmQzN2NSbHFuampSQ2kwMWNnWkhDMEpoNTd5ZTBLdVBxNENBRTBWdGVM?=
 =?utf-8?B?L0JDdWhBMk96dVplRzZjNHVPMHZZRDBzVEU2OENQa3g1MGtNdkRya1JScy8x?=
 =?utf-8?B?UlFWOEhvWUt2QlJUTzM4RnY3U0pXVW1oRjJPcTEyNGlMMHFqNW1seVoxRHhn?=
 =?utf-8?B?ZXhqWE1PWmdPK0ZGdnUwcGpQTHQybnFEd0E1MllpTG5PMEp2UjZIcDFla3dH?=
 =?utf-8?B?czhoMHhNbGp4ODE2bFlWWWNqMGlLYmNvcTlPb0hjeHYvNDVQbzVlRHM2T3dE?=
 =?utf-8?B?a2dxcW00cHI2TWZ3c2ZSZ0dhbEk5TE44T3dQV2Fjc1ZKOHU3aTdaR1FvQTJD?=
 =?utf-8?B?SngyL3RhTDhYVmdmUVJJOUU3aExXQzlsalZPalVwZVdWWW93S2M3Uy9EWE42?=
 =?utf-8?B?UEYrTGpYSTVQVmVXMXpQMmhBOEErZGJiSDVOQXBEWGMxNFEydGVYVjNzMHdC?=
 =?utf-8?B?U1JwaXNPaysvL1NnWVdRbHhKZUFaKzVHVW1PN2lkSUJXejdxVGc3VTJCUjJu?=
 =?utf-8?B?aEM1Z0h3a0pEaTBvNm5mdUh4Q1JMYUNkeHYrQUJmTEJZYXRrYkwwQmcrVy9t?=
 =?utf-8?B?eDA5UUpXTi8vMnJZbFg4QzRLY1B1WFZFUkp2VnFiRUhxRXdvK3J6UXVLUTh4?=
 =?utf-8?B?Nk8vZkR0bnVwUXRzck83YkphZ1NMNG5TbzFKb0Q4cWluTWN3cHVWMlkyTE51?=
 =?utf-8?B?eTJNRjNUMHE4YjlqZ1d1NTluZXAxcFFaUnB1UHZWSysyR3Z6cFZkd1pUei90?=
 =?utf-8?B?azhMa2RPRnd3UXJoRGRXVXhpZjMzQ3Q5aVNPNkZGZzRNNUVBZTl6ZkJFOFJN?=
 =?utf-8?B?TGE2UDdqQm9KZzFCOEdla1BzUDdTbExMaTA5ckhEZlVmVFl6aUE0NzErSUNj?=
 =?utf-8?B?YytYcmZMZ21CUWFwNG4zN1pQN1dMdmpydVoxN0NDNytWRlgvaWgvM3M3TDhL?=
 =?utf-8?B?cmhtZGVmeGJ5RlVjQzZ0K2NOTWRES3NCT1NYc3VHaVIyQmxuVHh4ckM0Z2Zl?=
 =?utf-8?B?ZkpFY0N0Qm1ma2l5Y3VNZ2JLYnowYXZza0ZTSENGWWtHVjA1VmFPdy9zQ2h6?=
 =?utf-8?B?MU1ZMjRaa2JuWFQrODJuWjlac3kzT0czV2llNG5LUzUzdzFjMkl6NFNjWG5M?=
 =?utf-8?B?b0FQSTVFZlhoeTcvRTVOdW94VGl4TWRpZUo0WXZzcVlIaTV6QmxQMTlFRkY0?=
 =?utf-8?B?YmNkU29ZSCtyY0tXdEZRYjA1cXpzNlRTeXE5N1VFTTdXdGRlU1pCRU50bUFs?=
 =?utf-8?B?Q0QxWC8vQ3YyVEN1aXdpR2xwdGJsTTZvWXVtOTRDK000eFdtS1JhZ1lUclZh?=
 =?utf-8?B?bVh6cjBSaHBxcWtXaHM3dm4zZEJZQjFEL3Axdy9XQkw2akloL1VGYWwrUkx0?=
 =?utf-8?B?NVlNM3ErMHZWTDRDc0RDc0trcVQ2RkkrbU0vRXd3NEhPemVJamZWeE5aeGFx?=
 =?utf-8?B?YlRWbjZWaGxPYWVIVUMycXFkY0d1NUFWd0IxSzhlTlFtUjBUYVdpKzZPMUJh?=
 =?utf-8?B?a2lxTGhZQnVDV2pOZnB3bXJjNXBpWHR3MlJLWUlvYnJNQXBkT1JQaXV6YXVm?=
 =?utf-8?Q?idqce8tsuu7os4bZo9YwgHdJ+7UXLpuZDJfvP?=
X-Exchange-RoutingPolicyChecked:
	JJPhVJa8eIIp0r3spq0DQsSVshQq0MXyuP9ykBLeWYQH5j1FrseNeVnXFVhmaHRvkPx8HIqxNwsigMRJYV9/F7sIrvrQ5UGA1JFXiRt1FFjiroX0indUWfGB9L74FetsRJjJnweM+5wcsTmqug1R4gbmhOJ43ey4Lw8ONPNggzT/nFdtMXJP7MvNTkpKPYEgeEyJDa7PhF7hQ3gV9rElsgA2vNrZH4SraVxfv0inIO/IfA5lU2VCD5JNBYE3zBg50m0y4WKe/Ab/U6afqhLXXY9Yn0vLht2JuklyCYn+jeGVvRkwRYl9Q+rujYq9ApfF8K8CUaThXtLAEtO4C1YZmQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GRpp1uPtOoCGLix/LrDICmoTI/AzPrIpDS2tf/soQDQiGHPleHN0iracTWMaT/zIAG/NJO8iMnBty5v7LwQAi7tlAOn9Mz117TQGsUYdPfrPvHHiCiQ2JhbjI9lWoKNR041WSnDhmwag+G7978nnWysnEa2dcFf70UgepXh/miQS5LZLswzax+Yu263hYponR1svpsZMoMyWX0gkd18f2g4qKf9Y7Zfzg2YkyB48wGZbCu9XQ5kIMoZmM9i76HP62LJlvFQWJVnqTDDIiDwY8wGzNnnZmKFXDshmRjd511d6x2r+m+vUjkzYWmOK0HOoPxLPC6aUxexdxlWcgGU5gWT/1YGn732UtqQznGU5tp02o1RwHjM0RA23VG9z3KtpbYt/tqnEiI9P1bqo6MbdX+WnqwKO8peaRQxT2qi/GKB6+1k/g5FL0JSlyeeCAAon9APBuFxxOpRcXdphQYopHWCO6eOgWAb89c2rOBWEDwdQq63BV8PCv8Vv9XcKAJR9t10AII9wLGPmLOyl0wNEXLGKhknoWv7kHmowCg2jjteyR18QVBGzEVBx3fPrgbnpkNKz/GKsKc6Z5ljOTtXQvlVtO+pcGQ2gq58IJes++f4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25f64c0-19f0-4b4f-67ea-08deaf33d3ae
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:03:46.4768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vo0g98FvczvgRPeAUd/dHSIPJfkEinkrGSIfo1aL/359ls7enIDOe4UTM19NacUYff9c68WrVA0C85vMoaOaIDpoBL/h0yXd4dg9njlmZi8Gy03Sbz89+QChiq4Igq1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605110087
X-Authority-Analysis: v=2.4 cv=EKQ2FVZC c=1 sm=1 tr=0 ts=6a018d68 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=iHwBjlyiAAAA:8
 a=Si3cETwTXSGcMmFZ3jMA:9 a=QEXdDO2ut3YA:10 a=uNSKXYNwxGiU6LD0JREI:22
 a=5yU3S35YU4bGjq-dph-N:22 cc=ntf awl=host:12298
X-Proofpoint-GUID: 2BW97NxbhClWr-4GUpP3g0P8pZmU4JDT
X-Proofpoint-ORIG-GUID: 2BW97NxbhClWr-4GUpP3g0P8pZmU4JDT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4NiBTYWx0ZWRfX57nkGVJSI/vb
 WgYgYdvrja+RSjQnB//yDjjqYVXO7KvROve75a2DXer1kTURs9wcdLeTNS4cMV874h46eCUxd/1
 czFTOpw+0qyXP4y7g7dCsOfkwLHnVbQBEAZeeyxGiqGF7jfeoIeWnrSlQldi6kopD/6XVagvcle
 WgWlsPTxMesZtSIhOiKc0ewpT/oBnXGK04UqJirU4VBeemFBTNj4Qwmt/QPXgfzuGB53ccC/yL+
 zS60ljvcO0ya1HbQl4WLEK00Iz7u01x4cJm/c/CzuAhd1HQXk4oYYo611ORVdgGuE4q8OERJ0gh
 uFPjGhESvdmcl6PosSeenqZdbcokASX+ex0944lAFkWtgCTEDdtZQNeCJ1p7Rsr7hrs4GVBQrEm
 TbraIvHk2o1L2+Tt5cgOSr0tTUQ3lbKDKmkcxEKy1qvy9tVEhB9YKvbAfar9yPxiB6nkIf7hsd3
 aB6C5twqh/jB5aMSx6RE8R29CFxkwTg1mNJDZEjI=
X-Rspamd-Queue-Id: C5B71509DF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-245152-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org,auristor.com,kernel.org,lists.infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,uniontech.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,


On 11/05/26 13:11, Wentao Guan wrote:
> [Readd rxrpc_skb_put_response_copy which missed in 016725807ce3 in v6.12.86]
> Stable-dep-of: aa54b1d27fe0 ("rxrpc: Also unshare DATA/RESPONSE packets when
> paged frags are present")

Yes, I noticed this too.

But you got the commit wrong I think: (you probably meant)

the rxrpc_skb_put_response_copy() addition was missed in commit: 
bf20f46d94f1 ("rxrpc: Fix potential UAF after skb_unshare() failure")

Greg: Summary: (it might help)

The stable backport bf20f46d94f1 ("rxrpc: Fix potential UAF after 
skb_unshare() failure") is a backport of commit: 1f2740150f90 ("rxrpc: 
Fix potential UAF after skb_unshare() failure") to 6.12.y:


stable backport bf20f46d94f1 ("rxrpc: Fix potential UAF after 
skb_unshare() failure") adds this which is not part of upstream commit:
+       EM(rxrpc_skb_get_call_rx,               "GET call-rx  ") \

But missed adding: which is added in upstream commit:
+       EM(rxrpc_skb_put_response_copy,         "PUT resp-cpy ") \


Hence Wentao needs to add rxrpc_skb_put_response_copy() in this backport.


Thanks,
Harshit



> Signed-off-by: Wentao Guan<guanwentao@uniontech.com>
> ---
>   include/trace/events/rxrpc.h |  1 +
>   net/rxrpc/conn_event.c       | 29 ++++++++++++++++++++++++++++-
>   2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
> index 9377acad0c5f9..63efc9e4e4102 100644
> --- a/include/trace/events/rxrpc.h
> +++ b/include/trace/events/rxrpc.h
> @@ -146,6 +146,7 @@
>   	EM(rxrpc_skb_put_jumbo_subpacket,	"PUT jumbo-sub") \
>   	EM(rxrpc_skb_put_last_nack,		"PUT last-nack") \
>   	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
> +	EM(rxrpc_skb_put_response_copy,		"PUT resp-cpy ") \




>   	EM(rxrpc_skb_put_rotate,		"PUT rotate   ") \
>   	EM(rxrpc_skb_put_unknown,		"PUT unknown  ") \
>   	EM(rxrpc_skb_see_conn_work,		"SEE conn-work") \
> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index 82cc72123c9c9..6dcfaed1f7485 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c
> @@ -226,6 +226,33 @@ static void rxrpc_call_is_secure(struct rxrpc_call *call)
>   		rxrpc_notify_socket(call);
>   }


