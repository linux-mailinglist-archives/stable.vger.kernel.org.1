Return-Path: <stable+bounces-196891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14670C84CD4
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 12:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 579EC34CD1B
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D49314A89;
	Tue, 25 Nov 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DlHIOqxl";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="EcFbmDDw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38431691E
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071377; cv=fail; b=thS6T12VYqEshgylOSzXLSpV53Bn/7zb+yQK1hIaOS78bM1yBlZA3xambSrK8mYrCsgzmv+LKAeyhlWkzEO8zaOE1HV4Q78czcdVjr8+6g+k/dAkoGrrPiYvqRXU24yW+IQMuu0JWBysW9DFT9xQZCnQ0NpZ73zd7W6LOxqB2S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071377; c=relaxed/simple;
	bh=QQ18z8kcSojU3liuPlXOSx5QZkxDR8uSMxDDOwl/1Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJlq9uHzHZq76CS2rBHnd8+ohNKtR3XUOfzYb9y8yJTxhHs3Eebq9TSd/d+1MwsLOAHXRG0Vc2K7GeBQrAUh8LgvycTftZKBEZJH4ihP08u3bMbRbY/Zdy3Hyik/MRA5v2/JB6NOmdpgW5e62w6P56KipE7fyxYeU8CBaPPqgwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DlHIOqxl; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=EcFbmDDw; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP4jkG03667332;
	Tue, 25 Nov 2025 05:49:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Nsc1lnivjaNf/sHVXQTttb2QypCuTVZfoD1jrIetJyA=; b=
	DlHIOqxlweT1iwE+OZOI224Ah/ax807MUVCNaDbHFuVslK1Zv+Vlzen2JmKSi1HJ
	88qUFifBvbSu63b8L66K/OnPdJNmLg0EfUJkQXeySrIMZCA38R/gu/+F2RiLWEK9
	M//YmLdDgZG0KhCQGeQb+t7kngyGWrAbJHxB5Warv8/AXFH18zx2qg9+7oiEszY1
	imfVyyRBAz3EdZwfoKcuiaSNkDlauJJzuCbrMnKr9fY1HG2VUJXfbxJ3chkzmncJ
	cvH24o6pXyxh43wuYUAcX3baP03+RxLnllkJKlK0DqOuolIaTGwlE6CXEIKGwado
	kuFT9D0GGmyeeHDkGgYCUQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020096.outbound.protection.outlook.com [52.101.85.96])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4akafkaxe1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 05:49:25 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbI5vjsBbxYnpZrOXk7ONWV3k4TO9LrO5OuIAbF2UFzHwyYjjdHH3+3T3aIkdDrlo0A0MLnhYdSTQshMdnZOu1bISwYviVectWfde2A49kXrDHXbF7/72r4dykqdu+2zBDZXG72xWGej5Dt4qU0s1zAHUUxfMVXqGe0z+03f7aezTt4JjRPFDLz04XfZg2Vz83huTUtjH5KNDoFQi+FJkG3pNerhyxphddHmEJUwh0AGDhtBztVFBzItxgBQ99IFn7CAUPfXciH/SKIEMv+2EAalKRQnrt6W1f6VYOi2CYeB+UW5yOgN1S5G9JeVW4ACkaPtxplXGRmk/KZ8nNOMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nsc1lnivjaNf/sHVXQTttb2QypCuTVZfoD1jrIetJyA=;
 b=BL83dpRsoVadDGgaRkjuJHunWbZGyzNIwZwf0AzHso4eP4LDMiNcr/HFi1MO+jr1eLnG76yE6kVLejmwnYF1Ct2Z5rWpNDjkDefalCwUvgabOFZGfHMM60P/h6dpOWGuuKytAo9aDg57uu0LxcUcTvRdOsx0XwzRlplu2U9d7Syb+PHr0RcUZgPGgKbj+K1C6zk55RnXsPPB0m7uVS8oTGuBM4fGyy0FUuZ1hmEolkFQ06wLejXgXxB6rJ7afYJW6WAqHhnEdqKxEAUPcw61HstiGXyD4ykLuGRo+plfIJ1xhCFJr5HcZ08Jeh7kYt2YvP2SHbdQqvoj7csgBuyWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nsc1lnivjaNf/sHVXQTttb2QypCuTVZfoD1jrIetJyA=;
 b=EcFbmDDwTieVhL1+0Hg/gIzsYTF+49BiVZaGkU3MVIVehA63VBJUUH4OheLliVN7wzax6MO0pAxQmJBQt49iw+2JODWTr8Xnh4pOjRfiCgEWl4c6dw/3SgR5DqXmLUeunVm2cC2yEik0hnjmab/im8DakoGpcsTb95yNkoi8FKg=
Received: from BYAPR06CA0025.namprd06.prod.outlook.com (2603:10b6:a03:d4::38)
 by CH4PR19MB8682.namprd19.prod.outlook.com (2603:10b6:610:232::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 11:48:06 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::5c) by BYAPR06CA0025.outlook.office365.com
 (2603:10b6:a03:d4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Tue,
 25 Nov 2025 11:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Tue, 25 Nov 2025 11:48:05 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 86BB3406540;
	Tue, 25 Nov 2025 11:48:03 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 660E482024D;
	Tue, 25 Nov 2025 11:48:03 +0000 (UTC)
Date: Tue, 25 Nov 2025 11:48:02 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, stable@vger.kernel.org,
        linus.walleij@linaro.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup"
Message-ID: <aSWXcml8rkX99MEy@opensource.cirrus.com>
References: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
 <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>
 <2025112531-glance-majorette-40b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025112531-glance-majorette-40b0@gregkh>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CH4PR19MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb0a0ea-f960-45f7-e56c-08de2c187f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|61400799027|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDhQWHhBT2s2aXh6SEpybXdWWXdQdWh0OVg1WTZReXpWd2orRFl4RCtqYjdT?=
 =?utf-8?B?L3hhQmUrbzlFZUFCWHZUY2prbFk1MENUcFZiWG1sZzNod0RZdGpWcVB2dTRU?=
 =?utf-8?B?b2hqakV6QW9UTHpVNnJaUENCNXIrU21PWHpVdUdZWm9MVHMzTmxJN0U4b0E3?=
 =?utf-8?B?aGNyenJOQ1lsMWNUOFNpZTRRRzIrQzFLSzRLU0x2dktQT2REbFMrUUZaUStr?=
 =?utf-8?B?cjBRVVRTQW8yUmxvVDZpTzBOQTl3WmVBalg4Qkk1SzE2WlpGcFl6WFo5QzR1?=
 =?utf-8?B?NzdvNmpJeHVPMWQydTRuREdvcG9HcC9HSTZsY0trNWgwQ1Qza3dvQ2UwUzBl?=
 =?utf-8?B?RjJrNkVYd0RqU2RXOXlGd1dVUW1xWitZQmhSZjdiMndLRWF0SFFOS2hUV0tL?=
 =?utf-8?B?OHUzbjJCd2EyQ3BqZTFFY2pOcS9MQXdhS3I1b1oxamdQeXExRDZ0UGpJYjZo?=
 =?utf-8?B?UGF4WlFPdXpIeEwvT2tMbjJwaDgvZGc1SkdGL2Uzc3JmYkFCM2JTdW1jMUFT?=
 =?utf-8?B?REVMMmdPNXZ2VDRUMExudVpjaWd0NW9XZDFtSVBoNVlwSTZVNDRpWWQ0NzR5?=
 =?utf-8?B?T1BLa3N1Mlk0T1A2UkJBcnFtcC9lSWNPcHdOSlhCWFZnSUxjU1pGVlRYaWFN?=
 =?utf-8?B?ZFp3NWtKd2M0S3M0cFVQbU4ycVM3b2txejJMRFp5S3VjaFVmMEdEV3hKc0p3?=
 =?utf-8?B?NExtSHBUVVF6ajFyY21qUzk2MXhJS0RBbFpTUXBtbEhscFJxbkcwUnpMaXFU?=
 =?utf-8?B?dHp2V2tTSElJbEdTcjNlQWdiTkJNZUFhWk9TVEJpLzZyU0xOenA3aXlVQ1l2?=
 =?utf-8?B?dXdoekY1T2liaU50N1hja1Fyam5FQW1OSmx3WlU0VVRUNlQ0NEpTdUZIY0tk?=
 =?utf-8?B?RDcwOWxrYy9Bdmp3TWlCWnlneVRaUEJTcEV5eFZnZmpsSjVwb2h6VVRDWWN1?=
 =?utf-8?B?aUtEaWRRSkNVVDkvMjd3d0t4VDJ4NkFteGVNOUt6bFVwK3FadXE3WmRwSVFx?=
 =?utf-8?B?MTFVc1hLN3FTMElqc0c5RU1scTg1ZWozNmtMN1RJVTRpQjlpakgyN0llT1h1?=
 =?utf-8?B?RVM5TTgzRkZ0Um1BSG5vSFRJYWxlaEtQQU5kV0gwbDNNQU8rdlIzTGsxNTFh?=
 =?utf-8?B?L043NFlqV3hvaTZUY3NPTUhoN3pnWE9MU1p1dkhkWjBzdTdJcUhKMSt2SDVE?=
 =?utf-8?B?Z3pDQ21LM3NocWl5N3BiQi9HcWFRUXpXSmM1S2NJUWY1VGhzQmJxL0RudUpV?=
 =?utf-8?B?bENDaWFsTFpzRFJUTzNRTU16b0tVYkEzdW4zNVpjM202REJUUnZ3dmJNUWdk?=
 =?utf-8?B?bkdRT252QlhSZUNtTUJOOTlrQWRsc2hkYldKYmM1bjZGN3dlcm9qMW9qS20v?=
 =?utf-8?B?YkFDZjlNNWxWUnd6NjJqaVpSS1hOR3UySGNXWjNiY1VGVktUSi9IZlp5Uk1y?=
 =?utf-8?B?c0hHNzdiQ0Q0NmExcXpLQ0dZQmc0OFQ1WGYvRlhXUFdzV0Rna3pERXFlSy9E?=
 =?utf-8?B?anFXYVZ5WTNmSEVpdkdYazFyRFcwT3AzWU5SQ2RqcEZXcDgvYnQ1NjlHZFRj?=
 =?utf-8?B?T2JGcGJHb3pGeDRlZXVtL2pXQWN6ajR3SlRIa1MvWUYzN0JINkZXbGdXK284?=
 =?utf-8?B?bk92NS9kdTl6RjROdUo4NUxPZ2dkUVB6SFY1M2ZRa0pLbklyWUNFaDFNemRZ?=
 =?utf-8?B?SWZ2Y3dYMGRTeXd5Mm1JZzI1Q1p2SytvMFZ4MUwwd2hTQzV3TUl4Wk9CKzJn?=
 =?utf-8?B?emRtT1QxVXdydm9HUTc1akdBMkhmL0lyalVPaGw0akRhZkNwWjBlNmtzYytI?=
 =?utf-8?B?TnhkazhVRUlvOEJlOHdJL3hCUEFDYTNxUUxQQ1dZeTI5Q25tNS8zWjdBOWND?=
 =?utf-8?B?UkNkWHhHNkFianVZUW43Mit3YTVqWk5sR0RGMkFvL0pVOGNaWk1sN3JIVEw2?=
 =?utf-8?B?d0l6eUFSSDZWNHFsbElYSkw4SkNZc1FybTNQVHVtekczUVZNQloxcVE2aFhL?=
 =?utf-8?B?YlZsdjN6eVV1V0Zhblo5dXpkaWxTcldJVHhXSzNrbTluUEVjVUxFa3Z2WHhO?=
 =?utf-8?B?dkU0alBVdi80T0Vjdnc2VDl4S1RZcHJtaFFWZnYvejE2UHR2WU5vRHlDS25M?=
 =?utf-8?Q?IqpU=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(61400799027)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 11:48:05.4566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb0a0ea-f960-45f7-e56c-08de2c187f2f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR19MB8682
X-Proofpoint-ORIG-GUID: 0p5yR3XE4S29BlmG2h44lyJdIpjE8rMp
X-Proofpoint-GUID: 0p5yR3XE4S29BlmG2h44lyJdIpjE8rMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA5NyBTYWx0ZWRfX+cht6e+cToH8
 qY0OHZOp6q+5W32aIWs9I0cBjLZMBn8JrYJohlJwWfBIyjqQnt+cT9zMwbDiAFKsLA6KnBoD9EB
 PhgH6vI9TBHCf1kqZGUQmEr8S4YAEa9IqjdLYI7cNUG78M6vpcLA0VInUCC8403NUXnM0C4lnBw
 kiUu0RKj2rU1T1ofLnyJ+0vfzdMDm99Nv6GzQfOZi/AJp/OK25+c+AijG9Y6yZY5OgNkbH38UuD
 vx5EAWUUWfOrtSq7JCo51PrJyrliKwg+XO7QBms1gGwYnrbJM3XWX30Qao1SWgN3iRqoAZ9kU+S
 acMxW4lhyfajBf/iN7eA2zcpZgO83Kz5+ZVFTKvO6i1RWC1geJxqfLQkgTQxaRJOOcBw1DmSvsR
 8RVJseMHkwNmbUYf1hCAuT7Zm3oFzg==
X-Authority-Analysis: v=2.4 cv=Dacaa/tW c=1 sm=1 tr=0 ts=692597c5 cx=c_pps
 a=wyQZsu7YS+H2q1uHh87QeQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=O_mYIUxG9PxvoMOS:21 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=NEAV23lmAAAA:8
 a=w1d2syhTAAAA:8 a=B8rR2PiwNwbCYtC2KzQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Reason: safe

On Tue, Nov 25, 2025 at 12:43:16PM +0100, Greg KH wrote:
> On Tue, Nov 25, 2025 at 11:31:56AM +0100, Bartosz Golaszewski wrote:
> > On Tue, Nov 25, 2025 at 11:29 AM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > >
> > > This reverts commit 25decf0469d4c91d90aa2e28d996aed276bfc622.
> > >
> > > This software node change doesn't actually fix any current issues
> > > with the kernel, it is an improvement to the lookup process rather
> > > than fixing a live bug. It also causes a couple of regressions with
> > > shipping laptops, which relied on the label based lookup.
> > >
> > > There is a fix for the regressions in mainline, the first 5 patches
> > > of [1]. However, those patches are fairly substantial changes and
> > > given the patch causing the regression doesn't actually fix a bug
> > > it seems better to just revert it in stable.
> > >
> > > CC: stable@vger.kernel.org # 6.12, 6.17
> > > Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/ [1]
> > > Closes: https://github.com/thesofproject/linux/issues/5599
> > > Closes: https://github.com/thesofproject/linux/issues/5603
> > > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > >
> > > I wasn't exactly sure of the proceedure for reverting a patch that was
> > > cherry-picked to stable, so apologies if I have made any mistakes here
> > > but happy to update if necessary.
> > >
> > 
> > Yes, I'd like to stress the fact that this MUST NOT be reverted in
> > mainline, only in v6.12 and v6.17 stable branches.
> 
> But why?  Why not take the upstream changes instead?  We would much
> rather do that as it reduces the divergance.  5 patches is trivial for
> us to take.

My thinking was that they are a bit invasive for backports, as
noted in the commit message. But if that is the preferred option
I can do a series with those instead?

Thanks,
Charles

