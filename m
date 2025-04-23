Return-Path: <stable+bounces-135281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D87AA989BB
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA04179590
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15CA21C175;
	Wed, 23 Apr 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="KlucivH0";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="2GpSHfvf"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF1E21B9C4;
	Wed, 23 Apr 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745411079; cv=fail; b=P0ynp7dMq3AAfo9I+i/1o6h2wnPJeNfdQPAh9ZUwwzXndMKQvucWN5FCHBpYbJ1WjmX0R06a1aBQDPLN8gmJDYXW/cLqKueJZ3iojWiPvTWBKoKyNp3534pJbbGdeYL+CwRuqGUz1/2UzPrkXcyfTzz0WZR/mBosGLRDSUkv1Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745411079; c=relaxed/simple;
	bh=x9bLq9qXDzY4b9BINrEj07WeTLSI+e9clGrEzPeD01Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TF68fTBYm+yCPXnFA1ROIDE16Vy8M1DMw9h8RguxgyCaX4V3uoaAGANtbOcsRwjI0HS1pB59q9sSvD0ptJ/eR8xVp94ZWbj4AE1In5AC2r0n9R2b+gsbZxUvxxKv6AOgO7ijH5K1rDpcSKg1plZh2YKsnMrTzLg4/+VsmDRGytI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=KlucivH0; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=2GpSHfvf; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6REUk023619;
	Wed, 23 Apr 2025 04:43:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=wcZG7znJiQFV8ZbUVF1eRpOC21hmSQ4N+ZT+LOtJeTY=; b=KlucivH0W8ST
	MsRE7sbXH3TEDssLL5N/hNgYBhwFvm5lsJEuT9AKh6H05cA9KmetGOapwAqFD/mC
	jqSOhhNCTe/MLQVGS7Jcm36ZzB+IyvQsInYewo5Iho/PCPjxwKC2GabpraY+C+rN
	cisnwJOkIhwHU3fanFK1Y3PUklxFeGol8oL71PswrtoWOXDqAUQKBY+MVQbdROUu
	sqyKaXZKbUF0BneGQ4XTj51ih6as44h36DYZS39EH8YICwzCJJFz2SbXTeCL40cn
	JWfNfjQe/IMAxYp2gyLMKvGq3HIj6PUkr1xW2X22CEy3zhl+SZafyHz2M2xPyLLV
	a5ZXiYyRQg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011027.outbound.protection.outlook.com [40.93.12.27])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 466jjyjm7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 04:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZ3xF7D+/deCBZso3jS2lgKd3zUqsUqrjj/F31HKaxXMzoboGuCt8p/KZryhaQQuybXf2MQsmby1FyMsZW3Zcpr2dxW3vSN4QL+ghLS+nDuy3+rQZGQQhtTtZVJfMiFi146BfM+HyfP7mPxygIuqiOaBvUpPtUuLHgiuAd11vMtjv5jPmQICnivIl8kCVp4cQjGQmFLnq223qSbXkuzSHeT1bP/A7XXfU1ykoCZwBCvfZe12pfVT69O+avh03Xk57DO6msaeWxFU42BhevIPKt960STlh0WCBjRy4s0Gs2MNL7hq1M3zarpWchJoLfpr/mV8L8a+XwhAQUHKwzwgvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcZG7znJiQFV8ZbUVF1eRpOC21hmSQ4N+ZT+LOtJeTY=;
 b=sr/2u3o9ahAqrJcUuWnUVqcFtM6BqOrtJ7B+R0Oq/nMa5MwjnSIp7QDh40YAhaKD5bh/n9Pd/2vCKf7r8QnTUjy7O2PaOUTmjO88dlAFa2Cum6qvl5ZbJjf0eMyahucbxA/00lv/PefnMYAaFzwOLwiWB+jJAAxBYEHRMFb9UcSyACccb/4lPo6kQ0w2LFhwmCD7jBkgFNeCGpDuUrRQblHYodyIsMZ0kR4W7aHXHJp02XnKaSLAKcKskrny84dNAwyZuYomlIo8qqKI2RP4YtCxx/oR5Kq96rHGGvamXhLMJjyyobEGRl9ZZhkykOHNpm3Q4qU3h8387N/PSrezKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcZG7znJiQFV8ZbUVF1eRpOC21hmSQ4N+ZT+LOtJeTY=;
 b=2GpSHfvftv3ttvW65vfNrQlM7wZMYjIhfQ8ebZup9rlWIf6BlRigygs+Nb+prWJtu08PaT2LOCqvmyq4IonksCMwE5mgz6IniNtrF3aN0UrfCVjeZLBfjXiatrRfEflG3b7jUY0ZwGCfV3VWwhDYrQyygYRrhMyDINvXm6B/V/I=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by DS7PR07MB7799.namprd07.prod.outlook.com (2603:10b6:5:2cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 23 Apr
 2025 11:43:03 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 11:43:03 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: fix L1 resume issue for RTL_REVISION_NEW_LPM
 version
Thread-Topic: [PATCH] usb: cdnsp: fix L1 resume issue for RTL_REVISION_NEW_LPM
 version
Thread-Index: AQHbtEEvQ7zZtKOwf0+ZY/0fGIjH4LOxH2Bw
Date: Wed, 23 Apr 2025 11:43:03 +0000
Message-ID:
 <PH7PR07MB9538D15B4511A76BF9EE49DEDDBA2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250423111535.3894417-1-pawell@cadence.com>
In-Reply-To: <20250423111535.3894417-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|DS7PR07MB7799:EE_
x-ms-office365-filtering-correlation-id: 73a664e8-228e-4a53-7a77-08dd825c01db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?I6yGoPofurn6PZBg2OZSQjkEXv7kocz0HgSh4EXqO6/5eQK+SbTaT++p5Dzx?=
 =?us-ascii?Q?xsFs9fq7qDyLD22DzpAsTHvb3BF/jtkwBQXH7BLHRc/4nIYKNgxIwIAoxE8o?=
 =?us-ascii?Q?gxpL+vTpfGQV7WfEKD1ko0LzKdcp21GF9A30wgHLPY1pVQXbgoFJdCoxXKZF?=
 =?us-ascii?Q?+qQPhhTnqUFDWhXfT15di3drcJr85WeHE6JafJqq3nCzC5kkqV9fZBT0Ize0?=
 =?us-ascii?Q?H6o3xfj8urk32TWJbKfLAgoMdF05L4mAn0naMTTCL5ULUa6dHbzrb6IkwGSt?=
 =?us-ascii?Q?H9g5jP3Cr5VF1n6UB+CYSDfwoSexTrmXekv6PHOYSBfFCJREXDPwZjx377cD?=
 =?us-ascii?Q?XH0M3mJyUe1sIazQu7MEtDjJvQ1UN5kQ4q29qc+ujhDwq52GaeLgd4GbFoVl?=
 =?us-ascii?Q?h8FXZQVYB99lne7LlB/RGDAtYji7N/ppZdLccUZbhaAYxIsdkAgNdsnt90q+?=
 =?us-ascii?Q?JcAtYYBjmvI2Pl4IKMdumMwG56sJNGR7EuUuBsjJ7hy7q0uXjW8Eyuwwszkw?=
 =?us-ascii?Q?YSx4wh6FkWAThRNJF9dymSNGAzyp8YomBDExr99tv6VhnBgSI+VYouJWkdO7?=
 =?us-ascii?Q?O9hfi2DB+gDrG5EcmZTtMrQTpo9iydc8xcmmqCJivuQsSAXN7iVlIHiq9sWA?=
 =?us-ascii?Q?Hl3fxUzKjpiwkwBGtVs2X+uD3Q16e9u1nTto0Yo0YS8fQaNi9BTszG6HJcY2?=
 =?us-ascii?Q?5MDtfBPVESGzyBQmu/tE5zc3vZDyw7Y9jwGriHD5LWxVR6zzkDN1ltyMp9gr?=
 =?us-ascii?Q?lOwjpRhGNFaeTm1n0AZt0vQbB7fx7unaPhg2LnQQONgnEiA+oMD2Z1J2gIRh?=
 =?us-ascii?Q?ffmKavKaBOgeGqS1oDrqxmMmb4mXAa12pFdO+7Y259boq/l6sQ+8JwnKV6u9?=
 =?us-ascii?Q?D+/0eTW/Jag5bIZuSabn5FQe0TznYJg9iTwnDnmZWLQkGgCyt7tCXFmHJRnj?=
 =?us-ascii?Q?7GjBkWFBFYCYHKkXC6vFXemv7HHXza/EitszWfADweYKBS88oWj5RWJXZa4K?=
 =?us-ascii?Q?o1mFchVBVj0YJr9OElRb9Ld7MDIsr++0CM1zAvw/s65UAQPm4u27r9ZJxdsY?=
 =?us-ascii?Q?WZE9KGIM62YwEK0HHzICN6LYuOwIdJZIrWjXSDOKfbBkE6GcAdyTWTxOtXkU?=
 =?us-ascii?Q?E+JjrR+yUfjZQ0s4lYYPwR7gA1d4cUUK3VtyUboUF3U9GtOGd3/nq38/oYnn?=
 =?us-ascii?Q?kTLmvn35bC8JTr/e869RtK2nQAb2bBf6cmWnxofFIxHKGfLVHkUhpHXtxmBT?=
 =?us-ascii?Q?qQ9Q3VlV63G5DnQW7rxyxfoHCVZhEZjMEegXPxOD5fbFMCxs8GX5NdxBkfHC?=
 =?us-ascii?Q?4o9xXLa2NbrzTNkTsXtudcCpKF819iWcXdM039kRODCfNYJAmNdfRb08/9aZ?=
 =?us-ascii?Q?ake1JsK++8RaBTEH/KrKyZ7HEO7HT9hzg7LQghcV1YVFrH824dlxudHLi2++?=
 =?us-ascii?Q?/H/kI0eSzgjNlm3opGpuwbBftVdULh1ohbprk8ibt39HlSrQlYH43SdxSmKm?=
 =?us-ascii?Q?fX7PEgmNkWHshcM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YVTNJ685cYTn8TYyh7bktpgKzgZ00juHv9tcG6FuZ2hlutuVAL9sAybJMtqp?=
 =?us-ascii?Q?/+7ww1All3ZT2Ps/hemj6q61GI4hy7P3N8a1kMPFoexEhcL/M5RN8X+6kx7n?=
 =?us-ascii?Q?hA9h11j2g2o3DIZJhwhA0301i2u16pzByykrlyETIkvLRdf+pzZtLtAcgG8R?=
 =?us-ascii?Q?KEtGf93gcWwuDCfYu+f9KQua1nKJAVzpL7EFp4A480s3puHmbRWTj5mtAKkf?=
 =?us-ascii?Q?UEuK8V4taYIGxZW7B+UWfnASMyimTsHp8DRP89nBQtOhA6ZLvfwH58ccWDvB?=
 =?us-ascii?Q?io2w9I94JdVAPlhkoTZ6p29JSg8Frxha9D1alczz2+LEZroJ98ndCXrHvcqd?=
 =?us-ascii?Q?+cL5mDVljdnvLPT66alvTNZPhVCZmko15/hLjK0Dgch6vuUD1nwusUhCnnFf?=
 =?us-ascii?Q?sEmddWQBXwPBFbjizI2gf39UGzBOmCNCmShOYBE0rM7VCcr7eSpTLfyimlIG?=
 =?us-ascii?Q?AZPxuXD+XrpOoQpivb47pypkIhPLh7WpE2h8/IVxvqanHA9sBb4D196rC3DQ?=
 =?us-ascii?Q?VM2XhOSzxsueIsI2dJ325ctu7jO8Mj1TVSz7Sy4iPaa+WdWJYTVMbFqsAGPR?=
 =?us-ascii?Q?ft41weGarpU5h0JyGozr8hqtTv8Tnx1O0LUf9g/6RZMSc2WEpb/5sNbFb8dm?=
 =?us-ascii?Q?yY4uXhDBZ/P8XCT9DqVGprQT+Z4TQbBpDfLEA/Brnm6MKUBOzGXHVKUxol+y?=
 =?us-ascii?Q?tXTQ5eulfY0ZuvHqga0UTUieUyw5TOTCg+TriEMFeSaXI6ew/2ggtmjosmtl?=
 =?us-ascii?Q?098nB9p0eTlhAHxpXIL+t8nqZQuiZW6v5iBApdz/Ahtp6fzz9cbCWINqCzqa?=
 =?us-ascii?Q?NHLR9RxvtPqTuM618CF2VgxnZVRBLIqL1Qsss9Z3Nqj/vGG5+oJgxc8ttaVN?=
 =?us-ascii?Q?LDE1vynUJdC+V9Sa+mZuBs7SljRO8vIf3sPN0FOzGyO/t9Yx/0mMsW6zznQn?=
 =?us-ascii?Q?Fz7H1uYy8OlpkcHFep3s6Oqci93ArEAcRBeC8Pgg1ksLXeq1baqxxnfPckDR?=
 =?us-ascii?Q?DCoPna6voFfkkwfArdghqJpV9idQelXO1Qi42BbmA5J7MwFwlA4T/fYBjDT2?=
 =?us-ascii?Q?yOfK4nei0LkIstVsnzAEuR+mQsAM0HTCyLRpNpXPwJZu0aSgmgl/hzymYkOL?=
 =?us-ascii?Q?/Q1eBmgE4MEq5ZSsi1hKWc7rUQoSZfVT/c9jpdklHGMD9OgS55INwRyQEKrb?=
 =?us-ascii?Q?ffnAR8RhBeKDC3lPeR2R0YRg8BVwU0IUElVagELCwLsitPJiyEsgwqE9spZn?=
 =?us-ascii?Q?0n5Am6KSwdsir27E2XGdh6QQX9Z5kxZkHLtlXkbZmXO9S7k7/YJtsRq3rJee?=
 =?us-ascii?Q?Z7FExdtMr1FDZplc0k9+lmNy9c4fdl3zyWr2YoQHQa1DxL+A7CNkXiud/ADu?=
 =?us-ascii?Q?KaUR9C/YDywMnTR8GKWFCV9KbD6+YQ7fC7V/+iu06rMHcVkqKiu+OUE4EXf3?=
 =?us-ascii?Q?bdupoGTUe/8Izfi8+Or69ZO3oAb28Chllymvoxa5wX6usv8yc+HSX5O/heja?=
 =?us-ascii?Q?P7G+F1UkFXCqqTOOAFDJGfojDqrLjwXfEUL32nVbEfLAA3tbBmFnO4Qt2qUz?=
 =?us-ascii?Q?NlhAlJUeVsK1aen1dp6eXYzvudghtbwyYEll1W06?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a664e8-228e-4a53-7a77-08dd825c01db
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 11:43:03.6030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjCgzFsK2/O0WxzKMNpkd8pwZzY9Xmu1kzNLsXIqXsWZ9cZgrYWPrqac9SgIs6UOJWu5v2P4amJydR8tk/R1jxM4UPRqU/KXxGQLzK8J2Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7799
X-Proofpoint-ORIG-GUID: vjU9Y1E-IzaxsH2tRChT4o0kncllPPV5
X-Authority-Analysis: v=2.4 cv=bIoWIO+Z c=1 sm=1 tr=0 ts=6808d249 cx=c_pps a=k6qe+EuqS5agFzeLFj3oqg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=SZsXWzALDm7mESlI4MUA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA4MSBTYWx0ZWRfX/HzFxzW0hONs XLzN7My+pHV6tOXezqdiJcfUgxmAFvy+H6t6rZ/CRKkXQxe3KMlkYAdZYyp4CFkc2HnCuGmNsCL uOm1GRfFk9d7/wiawab/fJ8EkpsxFLSE+ZjDCLnXM9nWVI3xMEyMlzFvqPNDf/oEOshQvq+cYT0
 VH5qoFvYxPK2z0y5AMdwJtR+uyoNGN+Grjd+sXjfDTnLjhlQFKnE84jImAot1JwUUFl336hyKlG kGJ7GB1pA2M3/XrCmUgYGqEd7Hq+idZpPt3z85d7qYFezQ4AmyIBtLauWOvJFHTDHLXorqZ/sxw fWGUXfRcnCiSZysKLLWOr+Vmht138opZ5n2c30of8yv4zxuZO2if39tbnbC0/MtpbTSY2Eq3OmM
 dR8ICOQj2k6bMLUgh839vF5a4uhlVyuPrBeXK4GTmmUH1KwUHjwpXjfPkinF+nbrHtza9xDb
X-Proofpoint-GUID: vjU9Y1E-IzaxsH2tRChT4o0kncllPPV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_07,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=857 impostorscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504230081

The controllers with rtl version greeter than
RTL_REVISION_NEW_LPM (0x00002700) has bug which causes that controller
doesn't resume from L1 state. It happens if after receiving LPM packet
controller starts transitioning to L1 and in this moment the driver force
resuming by write operation to PORTSC.PLS.
It's corner case and happens when write operation to PORTSC occurs during
device delay before transitioning to L1 after transmitting ACK
time (TL1TokenRetry).

Forcing transition from L1->L0 by driver for revision greeter than
RTL_REVISION_NEW_LPM is not needed, so driver can simply fix this issue
through block call of cdnsp_force_l0_go function.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 2 ++
 drivers/usb/cdns3/cdnsp-gadget.h | 3 +++
 drivers/usb/cdns3/cdnsp-ring.c   | 3 ++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gad=
get.c
index 7f5534db2086..4824a10df07e 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1793,6 +1793,8 @@ static void cdnsp_get_rev_cap(struct cdnsp_device *pd=
ev)
 	reg +=3D cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
 	pdev->rev_cap  =3D reg;
=20
+	pdev->rtl_revision =3D readl(&pdev->rev_cap->rtl_revision);
+
 	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
 		 readl(&pdev->rev_cap->ctrl_revision),
 		 readl(&pdev->rev_cap->rtl_revision),
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gad=
get.h
index 87ac0cd113e7..fa02f861217f 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -1360,6 +1360,7 @@ struct cdnsp_port {
  * @rev_cap: Controller Capabilities Registers.
  * @hcs_params1: Cached register copies of read-only HCSPARAMS1
  * @hcc_params: Cached register copies of read-only HCCPARAMS1
+ * @rtl_revision: Cached controller rtl revision.
  * @setup: Temporary buffer for setup packet.
  * @ep0_preq: Internal allocated request used during enumeration.
  * @ep0_stage: ep0 stage during enumeration process.
@@ -1414,6 +1415,8 @@ struct cdnsp_device {
 	__u32 hcs_params1;
 	__u32 hcs_params3;
 	__u32 hcc_params;
+	#define RTL_REVISION_NEW_LPM 0x00002701
+	__u32 rtl_revision;
 	/* Lock used in interrupt thread context. */
 	spinlock_t lock;
 	struct usb_ctrlrequest setup;
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.=
c
index 46852529499d..fd06cb85c4ea 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -308,7 +308,8 @@ static bool cdnsp_ring_ep_doorbell(struct cdnsp_device =
*pdev,
=20
 	writel(db_value, reg_addr);
=20
-	cdnsp_force_l0_go(pdev);
+	if (pdev->rtl_revision < RTL_REVISION_NEW_LPM)
+		cdnsp_force_l0_go(pdev);
=20
 	/* Doorbell was set. */
 	return true;
--=20
2.43.0


