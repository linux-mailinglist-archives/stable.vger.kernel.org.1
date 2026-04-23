Return-Path: <stable+bounces-240493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BBeK6sg6mntuQIAu9opvQ
	(envelope-from <stable+bounces-240493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:37:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC4F45310F
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AAB1303E2C4
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FC72DC79F;
	Thu, 23 Apr 2026 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hDQL366a";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="hp9ksBSk"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BACC29D260;
	Thu, 23 Apr 2026 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951149; cv=fail; b=MNfm3sI4mJsXayeyV3JZu/lYEwqsqLXz1wv0we9RtBDQrjs/I7MufeQxvrMS66+bZxmrCn6yvMEbaJJpofCk9PeHUNHbGZbAgkZ+X7GZJd8TEOfnlZuoxwdUpIQGtjCey3IsYQTldOGp1Vl5eNIl37ZEvhj+LqqYuUwzFGR0wbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951149; c=relaxed/simple;
	bh=lJNFZFxnbKnmhEZ3E3uoRUGgabyuiJuq6XdxUeksEFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkbsVVAI7JVgNaOTw1MSMcGwdWqDjOZ6X25ca0wHV5lOxhSqhWHE/k3ZM0FtwExXBmcuo5PPbGQEiQwJ/41eQUhTcF4DsvntRSlB3Q9XJYCu5PQUflHv0eDJ2i0UYCpv0tYBBuHeC7LNkkhzyBrjoN8tFwAtcYJuNRgyKbRUjpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hDQL366a; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=hp9ksBSk; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N7KvJR3311433;
	Thu, 23 Apr 2026 08:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=qjEpGnUyOkR0/QmL9EQcacuLsGOxhlMm9BvRztLfD4A=; b=
	hDQL366a6Nt3pnPu0SQJJgzBXJKxg9sIr5lpBOdVLZeWeWOOncbp09oz2FaxeqEz
	dR7NpYnaSFduYRDmAtbI/kFNfpIu0y+D9Ajhw4AokcBjqUiLkk0ClE5u8vt5IADa
	q1L8ABF7n4NE5ZDzGgXGlwb83wd6naK25h+gLPne8IK/Z3v6XIlHgg89bE1RewSL
	tHcmE0pXGHspK5X0aijWGTcCD9hT9hzWq8SOn2JXTalYQJnKZwAVQY9y3eTLBPcf
	0ijuIQH6CQMNUmH3o97/rHOIZ8Bxq9Fpogr9UN5nLAM7EJZgVM66I8A0h62gjJLf
	62etLyuRHEMaAZS+tIFoVg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020079.outbound.protection.outlook.com [52.101.56.79])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4dpenu2fdw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 08:32:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHcTJ63aT8YPetD2vZBOZOKRX2UhcTeFfG9+w1ObssQLpfIcgL40rkInS31oE5OpGO9MS2P505Jsc8BN4cvNwUHOyV5mXM4e8HQ0R/eGPZ65oKVk4nY360GBlFuzuExpi9tCZ7i1cbzgFh3qMe02nscqJeG4Rv3/uhKOW0QOzNC4fzP593jepzU3QHcYDaiOQxFeOG8ZoCjmR0/9mN/UZWt6rzkkAhfzt3c45pIMpSxs4mNkWmQt6mSo3pFPIfXJSWUO4uO1uzSCb39G6FNjJYJRxM05X7Mdhs+h+f5zi1reCxl4mmiCk6Aoduo8h3/pb/eLYf5Jm8VudiCKdOP49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjEpGnUyOkR0/QmL9EQcacuLsGOxhlMm9BvRztLfD4A=;
 b=A1xG4abBtEeaDVUmjhO+Q3ItoO2MR55L4hJiXtudEEv74kBeUPrPvXRJcdboILEPWmEJYEgigJwfi4U84x411HE3YiaZ8C+8TA7tIbdoY9oIE5eiLGhCXmYajk3+PqWgM5IJwM9YLsdHhy/CO0IdvFcWW4GCa1sjHlZNh2+ROhL3hgxIXT4d7HRFyseeE+/c4fOmWTrjUQB3g7SHcBB/+HPydiQf7wEpiD1tYJng+dUM+/qk9uuL0mjBXb10iF805sCeJPIgLT6d1+2tZ+ee6IdU3DbHlUbUdfJRY52W36ewYSiZ7TDU6rUFdTjbLBwXhFhLp+IJ+tmoZjOfy9ND6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjEpGnUyOkR0/QmL9EQcacuLsGOxhlMm9BvRztLfD4A=;
 b=hp9ksBSkEOicFmfESA8az5rWuTyc00yGg8WhTVcg1MUQi80+9+rC/DQ3tjVKTnpfEtTx+KVxvjru4sMViLi3q9IaMQT9OKtQc5v1s3KAeycbm4Ci/5AhOBDU7Ljki2VhsIsx0b5JFo6yOCQwBPzcIr4LJUjLtJnj9irdS4JZn3o=
Received: from BL1PR13CA0168.namprd13.prod.outlook.com (2603:10b6:208:2bd::23)
 by BLAPR19MB4417.namprd19.prod.outlook.com (2603:10b6:208:29f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 13:32:11 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::be) by BL1PR13CA0168.outlook.office365.com
 (2603:10b6:208:2bd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 13:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 23 Apr 2026 13:32:10 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 450F3406540;
	Thu, 23 Apr 2026 13:32:09 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 354BB82024A;
	Thu, 23 Apr 2026 13:32:09 +0000 (UTC)
Message-ID: <876d2550-751c-4299-a090-fb7f4d264bde@opensource.cirrus.com>
Date: Thu, 23 Apr 2026 14:32:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: cs35l56: Propagate ASP TX source control
 errors
To: =?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, David Rhodes <david.rhodes@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260423-alsa-cs35l56-asp-tx-source-errors-v1-1-17ea7c62ec31@gmail.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20260423-alsa-cs35l56-asp-tx-source-errors-v1-1-17ea7c62ec31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|BLAPR19MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c3cc2c-8ffd-47e5-ab54-08dea13cb929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|61400799027|376014|82310400026|18002099003|16102099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JITT4Mc/W7kwRYfwCNXTeFBzr7e3373XGrxuaHbvt/HaPa0RkM3zVpwUzX+uTazD+7mo3w6G387iaafg539P2BMco4ho79CaTYApjwGciPbEcoayYufypjy1AdBUV3bGIzk7ZigYHmDkDIGa6TLZuRtWArd6AoEIFkiKtORJ+ixLNVzdCQufsMfwE46AlGg+DFtL18fW11VtxrdLHiUmz1gFTmeemfMzlmyAE75Hk6fcyBjlrH3grFsnhV/ntiX2C4cXFxcV8FFUIa394gUXRCLkKBlUiL/ITkcWafrcvgPnDVGEAqK/nNmrETF9xXqbEk3MsisvufVTMWG2VK5/pwVnXTQfZaj2BICkBMbfvV/T0z75PLRYZSok7BvqKDw3pyO3haRT3LokgF7Jq7uaXuWZ6PFBoR199CLXpEdLJp5bmNPYOB7anRaYpU6gCoMtdOJnajzY24j6A0XyjDvD7Kw0QBPIucB8QHe66tzuU7jODgJvh+wt4sfu40etsAvPUpB9pkvonSU90Zy0xgn67vPtTFYGI5crgH7mu6VT5Vy74CPTwGQQvtM+FDaVvXBWvndY1lgbzUzm2zy5LiW9N/KdcPabg49MfGhKqJwlciYPsoSe+kwpq8utAAb7guYbvwrLNo0fPVRJtoy1Q3VPUgiC+J7ktOpAUf9DlMHj/wjWAwHRUSezETwf1zmRsV/tSfLJsoWiTzC5PaGlGrnu+l0y1C+7fRCTd+RUbHgGLPhi+9tySM9/kKTQdPCzjogzVB5RW4s7qzS2hTv5JClKFg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(61400799027)(376014)(82310400026)(18002099003)(16102099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2rPozO8JrYti3AvZqAeKN11JiB4ppiJWY4gTdWzj6HdrWsD8yzSOHpNlFY/U68Gtb4/dX5yRGkxLRGpai/29cxfWy7s8+CTSDidqhp75TFUrJH1bdWGvyRkMXSjU9Lg8LJpo7D3p4D0PFlOoNixicaRjd6E9VbFqe1J3aPRyUHtiH3+k4r7gQUefn1Z6sbLLraV+SJ7EyE3C1jlON1LeLSN2Tum3HiPN3AwpVLB8Xuw8/NXGlaHmfkEEEmcQDLc846Z3ohN54RCbKyTb9v/NFTIwTHiPA9ZX3jhHoXa8KiPEfFfYT39EDg+ThhUxVq2aNuIxMTfmXUr6M/5pGwjRdaqtUX/AWmegGm/5rqiKVHAUoaHgRhz9oUfWeqz6mSC1cXku+Hbu7sbyqR6y2Po+/ACICddCfrZcvXogH03bslFXZaAdM/ndNgUqTdNBkoG3
X-Exchange-RoutingPolicyChecked:
	a7v7LnqDbDz19bgrhB0JDNtJxkz9ltNAodxo/VWKNwN8Kh6VXIUla/WRdDoow+s4DXmYy1QUoqHyNBvZ/cbsRJyTRyPt7eNAyYUdKJCioKSc/5xebcBnSKn2cBHIQHyNTtHkNWG+b/238l+ExR7s2x59LGCmghh9TbHqGOfStsA3syqXQIoDgizSpE6ECu84SfWjNNHYX+o9y2xFQBVG8sFAF06saiDXmqijzhALmexHxmHp82pqkyFJqitdVARtJ7zI+yHx6idULnd3yMmaHEHJiqHW8HyoADoT0QakOe4YQZUp9k38smbgkQNSSm7mfWFY4ZPyJGQaKFCtY6EaeQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 13:32:10.7760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c3cc2c-8ffd-47e5-ab54-08dea13cb929
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4417
X-Authority-Analysis: v=2.4 cv=DbknbPtW c=1 sm=1 tr=0 ts=69ea1f61 cx=c_pps
 a=kNb0EPoEURSSyKZUeQUlVQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=JvBwcO1VsS_aB5xwRE4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 3GIdxo30FmE5s3Pw-QGns9ph7SqQYKQF
X-Proofpoint-ORIG-GUID: 3GIdxo30FmE5s3Pw-QGns9ph7SqQYKQF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX6jE9CAM3NLsJ
 wp+lqIe0b4oLTwuX8+o8zgwoAYWt6GVOy46cXH2wCTN2+B8TE9wIXj1+R7CyD3ZNR0RDG/NB1Ix
 v6F4tojQldNY3QXJXcXh0meIGt4PW711weOMSFRsHuzrZjE5r8uHykXCy0rfjhCJ03Kal/cjKRs
 FXKorVsq99cMsBOg0hWdQ8AKZvID6aqgvRx/G81FLNhdBztKorXFVPipcCKEAHFkbzZvOyIEZar
 cMkcx5hP6GciZPMlT40gB1SUrA3jiWYXZdLPDbVuK4T1zjz5gVYeZAYGWA/PAy9G4f9jGlNHRhK
 jplsnMgGVSnd5kSLLDRFdNsc7SgygAdroKQux1f0JBaVlQQo9WL/vZ5r4AtyDdkmNTgNyAyRZzf
 JolunfRy8I1SfEcdM0OLQ60Bzj3iy+GPaQH6yGvI1qZNJE/csyVyB5N48xt8oyxOOd8jW94aLI+
 n8dpSmn3NgNHwnX6adw==
X-Proofpoint-Spam-Reason: safe
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cirrus.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019,cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240493-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cirrus4.onmicrosoft.com:dkim,opensource.cirrus.com:mid,cirrus.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,cirrus.com,perex.cz,kernel.org,opensource.cirrus.com];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rf@opensource.cirrus.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MAILSPIKE_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:server fail];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1BC4F45310F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/04/2026 2:11 pm, Cássio Gabriel wrote:
> cs35l56_hda_mixer_get() ignores regmap_read() and
> cs35l56_hda_mixer_put() ignores regmap_update_bits_check().
> 
> This makes the ASP TX source controls report success when a regmap
> access fails. The write path returns no change instead of an error,
> and the read path continues after a failed read instead of aborting
> the control callback.

Are you seeing a problem on hardware? Or is this a static analysis
warning?


