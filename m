Return-Path: <stable+bounces-125841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3742FA6D41F
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7E4188F87C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 06:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BFE13A26D;
	Mon, 24 Mar 2025 06:20:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96DB7F7FC
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797250; cv=fail; b=sCVxRFIjwIrCD50++2+Wetbw0osww3YOaTFmT16ert903bO6pxaHhePWIcm7EegCeOFO+KHhqrfdWaov7/qVQ2McTBiUDrNsfkyA/zFbVMdaHscF8teBdHlT/2OEh/gxpovbZcVBHoBQeZwPRqqRqWk96EElzm4BI0AGtCDzRM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797250; c=relaxed/simple;
	bh=53b3My5fsjESYj71SNBD2sjLNZw16ZTdvOBnfbjQqM8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EsHsWWvIL2avpNWwKx6/ixmqPS/5FPDwfDQxuj986ZjI1quEuofeVOrvRKKi+3xXdRYUnQJpeVYedUo2t5r32OeO01QptdZ+MAFMDHWuR1+gn0FHFWxUhgrb6q93qayxe+nSUXR+JVaJDxc8JR6NcI1dH+FutbY1IaR00l8jMKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O5vIxe023585;
	Mon, 24 Mar 2025 06:20:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hje1hsxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 06:20:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tepL+82r+Z35u/qUd6YT2lva326/0OeJN0JLAZL6Krkl554YNvA1XCOdcXJVIboRzVEa7kRDls/Rb6wDOe3tNM2NemujEyUNWeDY04HxCluBtpW4+iT0M7CzC90kZsWfQByIFJuLZhEgloPkFYhmhlF+eGZa2U3jZx7Nh01zbaUOyCkVczCM1GKP/2V5dRfOtVK0mFu25ZJ8yI9G/Uz+UNfioPIuGZCFWonV17WlmaAcCyJ3AB7ZL8jygGKsXgw9hhHoR7G2U5fvH3CpUIbE/BYGbYA8j1wHoIlilQY2zCA1hs3tHCAKCxQTc4YhtqfO2PhehBSmxPsgH/SyT5Kc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8R2ytWcSXRfma4sePVIj0JYGIhpmaH8r1XmQSA5UfNY=;
 b=abytULDwds1vuQDFzBOMJFw3x5fqsug7flJA3E6Ew4Syo/S3xXKnLJ2RnfgjVeEat7pI3MYDqb81M/2C5w0pzfIqJMpS8T88XQj/34nM1fyHJklRlRJo/sT4Gec4PJIUZlq9nVodMyiYX2scNb5n4ePiN8rzHF9pV4AKgHs8QGhbWDruoS+VbRTNcQzF1tJCR24NjUENLUHgFDVJMmWFevDL+rOTPotCysFrBCtv4yj0+pfJaY9pMHsdEwPLkmu9Z1mAdwYVKsSD6ACqyhlEqkYFfFcLI5mfkOPGuUHwYSx8ZqM2D+9zsaZF0qEODcHx3nxbFaX5Ne3RsqmfXrldYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by DM4PR11MB7327.namprd11.prod.outlook.com (2603:10b6:8:105::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:20:27 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 06:20:27 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: Eder Zulian <ezulian@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, Bin Lan <bin.lan.cn@windriver.com>,
        He Zhe <zhe.he@windriver.com>
Subject: [PATCH 6.12.y] libsubcmd: Silence compiler warning
Date: Mon, 24 Mar 2025 14:20:03 +0800
Message-Id: <20250324062003.1203741-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|DM4PR11MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: c8386413-7309-475b-addf-08dd6a9bf83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3RHbVVYc1hkWHdTeE1yZGZuQTF6Q0ZGQjdXTytjSzA2cDY3eXhZNVFTUlVw?=
 =?utf-8?B?bTRRNmMxdFRNa2ZZc0J6aXU0aVZ6dGlDYm52NzFoREJzMWxva0ZUVW0yS2ts?=
 =?utf-8?B?NnBvd2hOcmo5MkNrbWlVNlV0RlhXdTFtYWNZUVVaVWd0NlNyM1A4ZEpEdm8w?=
 =?utf-8?B?YmZHVm1UeEdFUUhkWU9jdTA0dUFmTnlOaVFEbzlpTE9jcnpFbW5WUmNQc3VS?=
 =?utf-8?B?Y242d1k3Y2dMVEZxZysxQzI0bWRqaG9KeEpkLzB5T3AxRURKcFdiRHVPQ3Z2?=
 =?utf-8?B?dlBnYzZWK25CdmhnVXNYWHJGMC9NK2d0ZkY4b0hCMnFSVnliRk5IaWlEdk00?=
 =?utf-8?B?VklZU2lsRHM1Yzd6R2FxaW9OUlJJVkdPSFdrNFdnRnhONDBBTW1uU2I1UEtj?=
 =?utf-8?B?dHErbThhdTdsWkRlK3R0Ry8rS3RiV2pFejlrTWhWczhGL1BSMGN1amFHTlNy?=
 =?utf-8?B?bG9XTmtRN09rUC9NV3psT3JoWGtNdXRsQXN2T2UzRW9TWWxaQmFXWlZoV1I1?=
 =?utf-8?B?aGNsVTludDR6K0NVdlgvWExFb0Z2Zk54Q29xN1E4VTlkQlp3S20yaHZObG1Z?=
 =?utf-8?B?clpwdnJuLzhjWWVwbDEyclBkais4SkFoUzNaVzlCWUJvREZjb3JhSWY0Y2l2?=
 =?utf-8?B?emM2M0RxTnYxVjZlMDNKMy9NWHdpMDVVMFhmd05RZ1FJdzIwYllicGM4MTBa?=
 =?utf-8?B?NUltanI1RW9wdEVMVnlOQ2YyMzVRVDc4cXlJMkdwVm1COFR5cyttekhEZFU5?=
 =?utf-8?B?Nmd3OWN2MEZYT09QUGR0dFZpK0dGb2lDVHpoWnBnTGZybUx4S01HeUtmdVlV?=
 =?utf-8?B?YzJuSEkySDYwZHRWems0SFhEN0RJWGpQb285Uk8yVXNreUJwUE02RTBNRnFr?=
 =?utf-8?B?SW0zbTYwSWhiQmFFUUpHL1lEaE91QkRlM1l5RHpSUjQwdGk5OW9EdloxanJJ?=
 =?utf-8?B?Y1ZMOXNNRmg2alU3ZTdDSHlTQUtnNEtFd0YxOVc5bU1wWDZHNC94OHB0aVFI?=
 =?utf-8?B?VUlHWUdGZ091R05LdUVaMVN2YlNmSkhTbTdvK05ZT09IQWdPNEZ5VkQyUDRI?=
 =?utf-8?B?enNYMk55U0lnWjMySllGMjFlWXg0blY5YzlGTFRUTWlCSU5jdlk2T3Zudlhq?=
 =?utf-8?B?UGI5bjlJemlXc2hsNUUzWFZ0bUg0cjEzSG00L1J6Z1JSMU1OM0lvUUJKUVV6?=
 =?utf-8?B?anhrV0NOSDVjMjJWUW9yVkJwTXBEVldIVXBFRThsbWNYUExXZnVwR1FqTUNY?=
 =?utf-8?B?am5ZMnZ4RmEzNmJYUUZhN01ERUNIMHhpODRXT3ovQk94d2JCLzhiZGxEWDFh?=
 =?utf-8?B?N1FWcWE4Znd4NUJQNklPdnBwMHRQQlZVcVFLeHkyK214VUk5eTZ2bjlHT2N1?=
 =?utf-8?B?dXQ3R1c0akRheUlsWFczVGw0VWljb3NmTldOaGRPZC9UMWFTYnovVlRndWta?=
 =?utf-8?B?MXJOMXNuNGNHVFl6bXJJcHo2K1VhYWg2OXU5K3JxaFNMSGkzMkczSjdKd2I5?=
 =?utf-8?B?RU15Z3VheDVod1p1V0UzQncxUUFMSVptTFRrUGRVQmwxTEJpMHFFTVJZZndB?=
 =?utf-8?B?eCtDdGxHeDlGL0FRMDdGYk1LNnJWaUVFNGN0eWwraS9QSndzejlYaE9xTjRs?=
 =?utf-8?B?Qll4TVBkNkh0RjgvWDhYSWZSMDFZUG53SSt3OFR3WUYwNFNMalBqWm96NGIz?=
 =?utf-8?B?dEkzelRGRHhlUk1BZXFrb0NXNXJ0dEdueUhoa0E3ODFDYlVnajYvcWZ5bHhU?=
 =?utf-8?B?SWVuZm1ZOWRnWVFqaWZsMWRwU0FGV3RsYnNJczVJcC9ZZzNuYXNuY3Fsek1a?=
 =?utf-8?B?U01LdytNcUtkeGtKRUJRdDhJRjdJTkFEN1U4eTVpa1BKWjJXVklsS0cxQ29i?=
 =?utf-8?B?N2k4WXlheTZYYzFvemRRcHQ4a3FGcHY3QmdvdVE0VFJVa2NXMWYwV1ZKRFVO?=
 =?utf-8?Q?iiXHIgYw8QOidfe5ZImkNRSRbmH47raq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlhNeDVuNklmWXR6R0NteG1HeEZ0L1FzVlhObGRCaUM4TTBDTzFqUUtpWFdQ?=
 =?utf-8?B?ZDlEci8zekF6Tk9YMGUzWW9BeEx0K20yTk01cXEvR2liZU1nMHZOLzRMSEJN?=
 =?utf-8?B?NHpueGdaazEwM3NreFdZb3RIb1Z5eHdvdFp1Uk4xSXBlbzZnMGY1Ylg4aU5v?=
 =?utf-8?B?Y3pMakswWWJvY2RaeTJob3NzUDg4NUY2N2V0UjIwb0RXQ0NpL21XVTVjTGkw?=
 =?utf-8?B?a3UvWktNaHp0c2JRdm9mWVZIc3NBdlcreFlEbzVXZ3FCOFRZQUJ4b29ZYWV1?=
 =?utf-8?B?ejVkdWk3NStOdytqQTN2SXRIdElmV2pLRzJ3Skhsay9EeFQ4OENuRXZwUUxw?=
 =?utf-8?B?bUxBQnZmQklBZ2wwS2xlemFoY3VEb3BUbG5uZmRaYVI2eDhidEYzb3kwT0oy?=
 =?utf-8?B?bzlNU3pXZEJDMkRTVmRmQTVTVEczaUJ4K0ptemh2Mmd6bzM4eFBEUHlrR0tB?=
 =?utf-8?B?R1NVUWFBbHF1bkprTTFSQjI1Qi9RNS9uek5Ka3hlMzFLbi9OdDBrMmVXcEFV?=
 =?utf-8?B?Rk1aSnBneHloTzkrWlFpOEg0dmY4YzZXZFJMcm9EWW5kbDFGRTN5NW9sS1lQ?=
 =?utf-8?B?L3ErNTVIZXl6eWFlZ21saXhPb1hCandKSUF0K2FMTUhweFhNU21XYTV2N1Ba?=
 =?utf-8?B?RnhtUUhSdW0xbitOMkZ4WExnSWl6cko0WHBrNER3V1RLT0dNSVdpb1d6WGl0?=
 =?utf-8?B?ZVRrM0RxZVlSelM0UEVtbW5pWExtck5yRmxMYS9Fc3AvbkMrOVNjK0NOd2V5?=
 =?utf-8?B?a0kzY0s2UGN2WHNGSkR1QUVBNXFpYnRNa1RHK21kUUtVOUhWYzRzd2tTSlpi?=
 =?utf-8?B?akpoZzkzY3UyNVA4QWJGYTl2b1pocDBnaEJFMmxXV20zVm9GWXhUWGFMRmlT?=
 =?utf-8?B?NjM1ZnFNNUJsMmZRMXBQT1lmR09KbmNhUDdsTTl0NUF1SVFxNXNlakpybE1H?=
 =?utf-8?B?ZnNBMzZGVGNTQ2xqR1c2YXMvZDJJMUF2bzNhdUZZY1Q0OEpndGIzWW91QlZp?=
 =?utf-8?B?T2YyK3poeW1ZOHJLNXBqRXRZVUlZZ1NjZFl2SlR2ODBTcEh2SSttU3NzaHpU?=
 =?utf-8?B?VVhuREhBT0lWb09qaWV5Nkh6a1N0bEl0N1Y2dkdWU0ZzWlo4WFpvaEJuSXZC?=
 =?utf-8?B?aTNqb21DQW9EcjIzaTZzWmdaMzRzajJndVExSWlvcUFGekE3dk1URkxkU2pQ?=
 =?utf-8?B?L2p3blJHVXF3SU5hZGxEcTBtT3pIQkpWVHh0amk4Y0JvMWdmZGlTQlRNaExJ?=
 =?utf-8?B?YzFIWldVRDNkZXpRMUhTbmpxM2k0ajRmb3UvOGVMWnFjaFBsMUZaNllDQk9k?=
 =?utf-8?B?d21vb25KWUV2WHc0NVJWRHgrQmRweU1BcWprMjhSNFE3NkdjWklYdTYvVVhP?=
 =?utf-8?B?azJCaVR3cmxzYUttSUtEb0M0ejVuU1BUalB6enNDa1IrTVk3K0NrdEhhSDFQ?=
 =?utf-8?B?NGxQekVtVEQvWjgraWNiUU9oVExlQS9Hak8vTlFFRStzQzh5VnhvWUZjZHZL?=
 =?utf-8?B?ZE5jbnFLU1pGVjlzY3BFSndTUzkwbGZWdFZDeVphc1ZNT0g4V0xkenFzWjh0?=
 =?utf-8?B?TW1HZHJ2ZzdMMm12cFA4TFdzUVlxc3ZjTWxjdDYxWk45d2l2ZTlMbUVkV0JD?=
 =?utf-8?B?U09uSUh2NGVmaHZXVmlld1ZzVkhrcG4xZ3V4VTIrUjVUR2k3U3REM0tBREdD?=
 =?utf-8?B?aDlQWDgxN1pBR0pmTUZjQXcyTHcvWEYzTkRQVWZUVHVOM3pDVmxYLzNvNzZ4?=
 =?utf-8?B?Nk5yVUErS1M2U2dQS3NjdjBNZWw3VjNRdHNOazdZWFRBbmdsaFdSbXpHbEd5?=
 =?utf-8?B?c3h2eXV1bWs2SzNZb00yWVRDVVNUYWVBK3huK2NZSm9aRFMyeTkxRXFMUVU2?=
 =?utf-8?B?ekk2dUN4V3JacU1vdjgydlE0ZVUwb09qcHhJUUp3WlR6ajNIdEVMWVZ0czZR?=
 =?utf-8?B?T3JJQ2tTVG1QczJ3ZFFQNTV3QVI4Y1B1Q0J3QlI4V2tWZmJ2b0t4TUZTNVc0?=
 =?utf-8?B?M0tudnMrRHZmVnRaL2tmaEJwdlR6MlpIMURGMHZMU1J5b3lmYUdJTmVzRjRz?=
 =?utf-8?B?MFVGNXhEKytnVTNkVkcrT29pY0xBUkJOVDlrZXp0ZGNpUXBSTlRFbW5IdHo4?=
 =?utf-8?B?dU01MytGK2c3czlTWTBhdXlWVFdLRTN3M0xtSWRqa2Q1elg3emtoL3RtR0Zx?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8386413-7309-475b-addf-08dd6a9bf83e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:20:27.5717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5FjXyHzD7uikb8C90Gu9AkjbXmoQCI6xe9/2edDjVvnsdieSaJ1Nex9LKZwbooobcTjkF3FMCtmz2o8FgJnxGt4+B54aH7WUt3o4g8AsIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7327
X-Authority-Analysis: v=2.4 cv=KPVaDEFo c=1 sm=1 tr=0 ts=67e0f9af cx=c_pps a=AuG0SFjpmAmqNFFXyzUckA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=HpJ8KcZbcxjT_ihpqKcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 6XDtlaqMH0S5E7gq4hGLgtRoo_1H_-H-
X-Proofpoint-ORIG-GUID: 6XDtlaqMH0S5E7gq4hGLgtRoo_1H_-H-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=719 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240044

From: Eder Zulian <ezulian@redhat.com>

[ Upstream commit 7a4ffec9fd54ea27395e24dff726dbf58e2fe06b ]

Initialize the pointer 'o' in options__order to NULL to prevent a
compiler warning/error which is observed when compiling with the '-Og'
option, but is not emitted by the compiler with the current default
compilation options.

For example, when compiling libsubcmd with

 $ make "EXTRA_CFLAGS=-Og" -C tools/lib/subcmd/ clean all

Clang version 17.0.6 and GCC 13.3.1 fail to compile parse-options.c due
to following error:

  parse-options.c: In function ‘options__order’:
  parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
    832 |         memcpy(&ordered[nr_opts], o, sizeof(*o));
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  parse-options.c:810:30: note: ‘o’ was declared here
    810 |         const struct option *o, *p = opts;
        |                              ^
  cc1: all warnings being treated as errors

Signed-off-by: Eder Zulian <ezulian@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20241022172329.3871958-4-ezulian@redhat.com
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 tools/lib/subcmd/parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index eb896d30545b..555d617c1f50 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -807,7 +807,7 @@ static int option__cmp(const void *va, const void *vb)
 static struct option *options__order(const struct option *opts)
 {
 	int nr_opts = 0, nr_group = 0, nr_parent = 0, len;
-	const struct option *o, *p = opts;
+	const struct option *o = NULL, *p = opts;
 	struct option *opt, *ordered = NULL, *group;
 
 	/* flatten the options that have parents */
-- 
2.34.1


