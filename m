Return-Path: <stable+bounces-222634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFQrOUe7pWnNFQAAu9opvQ
	(envelope-from <stable+bounces-222634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 17:31:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E711DCD6F
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 17:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF37D305F545
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32216401488;
	Mon,  2 Mar 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qB5OdeIP";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="SZP42qMr"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66838F62E;
	Mon,  2 Mar 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467619; cv=fail; b=JS2PYyU6xEOn9Bp1M4BVOpdPTWM3egq2pkYK1EWyFyuNvJWsUD7ZxVkVNLBJxKrsQFFajzHU6Mzkhmj6rBhcrrFMC6v+rRhURLyGkqrNyig9MA5H+ALXMBywsT0tPyGKKf3LjNvFxu72WkAye2qfMLVAFWG+dx0Xc1OmR9+ONnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467619; c=relaxed/simple;
	bh=61jfCh6ILx0n9kHCICQSge2M+thX8aEqH9pKVHYKqOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZM9+mYAwhHqcO8+NxIcmrzf+EeaPemn7PndYFoqV+i47feqbxWvdGjjugK+86j+VoPrTMXyZiF8hF0yiA9XHgDXOikPjGFiNph+05KDSqsVV93RPUH10WuIc6AC/0zP7U3h+19XUuHRv79PU2oCtt/tyxSTGNYHFrnAMnZMevzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qB5OdeIP; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=SZP42qMr; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6225IXgd889483;
	Mon, 2 Mar 2026 10:06:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=97xSNki/c92516dGK35A0miuv6AwJpX3X66AnXrtD0U=; b=
	qB5OdeIPz9/MG53EGg6C6n4ej1eJ0R7Ts+Gh3R9V7c4M+BObsuVQ6uQwakJyod8r
	EaeXgxVJ75Pj9Yroju1HKJ1UyEJs0FPcfQ2nEc/ARfrj+0FRtLHJCIbGmt+V59Z1
	yKIbermtlH3/D8gvPAw81qRHoH+5z63GJ2IcbnF4da8idQEFLaI14phcHsoN28QL
	4Xr4A2d2cvt0FpkEKTw34esbQAvalI4tLkGDS7AL9V7UPhldWYyhAkmSSm4fyC4p
	425pdnuYtge550n/B3RW7E+5zIeY+nJ6KgGXG+F41C106GwwwGhYXuRbSUZ28Syo
	4HCWk5dAs6I4RBCMyXVRFw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020116.outbound.protection.outlook.com [40.93.198.116])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4ckxn0237f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 10:06:22 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGAAnMqONWoTZKe6yz9Mbrq4YEHFyidd64THzXBb3lmVhUcMKPRV2rSGj77+ke8vPiR7EOYN5ItYZ3edwdXbx5zr+BMLqXOXCK6xkJZHb5yNm1Zun4NLNiRySqBfwQzpOtc7ZGgH3W9p0mIR196e5K54HBKBsj8YRwa1Ohdp6leF1mAaJx8eDdFseebk1ZxpQ4RD5KH8gSqsWoMoyrAUeX9HBhEG5l7QJEMVGJfn+d5HxhbSkRA0cWlF+fbk4CnI1L1W5GvAR1ASSPG6MYLHFRtCJ9UV/eDlqB+LGZNdK+sC6ARdMlRX5lGTt2+M7xrUe08mbNwqez3tdTw+i/IVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97xSNki/c92516dGK35A0miuv6AwJpX3X66AnXrtD0U=;
 b=PvMH9cNlCUXepb6JXpI43xvdX36jH6PDfe7QtzIzyxIiFBiJ/LvXQilPhlSidFiPKxcpIQu3ZliQvIni0Ne81HBkA4UEcMDoXf96idbV/5BRaUldodfaUd7whSWj2doTLdsb4nheNjyA+WdBqQOHfBknXs5karB+Uz3Daj5ZqfjSyPG7hdQ6u33gtnroIYaA+hVmYwt0J+3C4txY8f4MXbXtyE0mh1PpzmdmVWxll6xldUYjoVE7hrA63qB+ECOQ3eW7IyY0tBT4VuUc1M/quVjykOJjullw5rKHkG4HixNPWD/bxr0g0wb9XXzgubAuCb9m5Fcdt2cT7ku2yKpkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97xSNki/c92516dGK35A0miuv6AwJpX3X66AnXrtD0U=;
 b=SZP42qMrkPSu8peruLy2yPpbmveSJGPLDd+AcDBynb2cIpPSE91Otj2a8lQbmXmIH6YNtL+a717Afzy3vPyzfkOBJbk/jyegx15GePnQ79XvCBVJ7tFHPx6XMd98AguorMsykNr8NaDt8gr5bS9/S27BU6KqTi/04/j38K9rn4I=
Received: from BN1PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:e1::23)
 by MW3PR19MB4170.namprd19.prod.outlook.com (2603:10b6:303:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 16:06:20 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::c9) by BN1PR12CA0018.outlook.office365.com
 (2603:10b6:408:e1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 16:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Mon, 2 Mar 2026 16:06:19 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 6729D406541;
	Mon,  2 Mar 2026 16:06:18 +0000 (UTC)
Received: from [198.90.188.46] (unknown [198.90.188.46])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0F58382024B;
	Mon,  2 Mar 2026 16:06:18 +0000 (UTC)
Message-ID: <fb78b03e-8b8d-41b2-999f-3e7c327391d7@opensource.cirrus.com>
Date: Mon, 2 Mar 2026 16:06:17 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: cs35l41: Fix errors caused by software reset
To: Zhang Heng <zhangheng@kylinos.cn>, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, paul@mirliton.io, stable@vger.kernel.org
References: <20260302121106.66805-1-zhangheng@kylinos.cn>
Content-Language: en-US
From: Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <20260302121106.66805-1-zhangheng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MW3PR19MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcd83dd-50e4-4485-b85b-08de7875a43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|61400799027|376014|54012099003|7053199007|4076005;
X-Microsoft-Antispam-Message-Info:
	gmDYGh+EAluue2RL8etV4GrcNyhLj+OjNaTDc5No9qnVE+2JgyZ4lW9BgnqKLKACHBJWEyx7HFGWz0FcMiEAABXlnANWZAHoNVMbWBRxN8izynqaLEwbYRuShDP3+gO42lkMLUZJiYo2jmadxhoKu3jGgMYvQAO6IAzZb6QxENyRhp2MPRlrZLYWRAqfaasXL8mJmrE1jHCMm/3a8PcFidb6H80GS9tnzRE0MeDoRk89bAwuBalI+w9eTZbwK9QoYZp9ijpdeTFLq09P7vpIzdrV5jGRvMxN04WjXu+2JzVIAZCZK0Xg1GcpgDGEVcJFkG5kc5lJR+IxavjVAn7mD625MryWkNJrt6OH4Yuu/U6bSXgOgCk4PxAdYE7iMwUbbrwPRfAjaXK6YAHcsec0Q8ozYAfzET+U2rtvbfy5SbyV1o4laGsVI/IYBFhYu7pMUElJQCuaq39O2+BYnk84R3q5KOhCOHPyTwIVqQoA/9TWj/geiFHBjfp70YVWiE4M1p2mkJGzo4shpOv/w0pGW38npj0YGnQob7iQZQDh2H7pRD95C1ggk8fY5llKGtwGqjYtuzhyKufWlk3Tl96us9T/Hp14MNk9GW39FvFmW6r+IgDYHnXZzW9r8lzr/pna0/nGNfCVjggMueOf/n1ohe5BwnQTkfLyvVnvVRpXFGkHBP4Y++hyuf84vKtEcvkZdnuksqe/UVMfzYrw5VmV224b7TSfJ1Olise9hHf+LzCyy8m3gmcMMOeXK0nv5WHbeJvtIBtJnDDnciMadk2Rjbe443DDj4ja6Huu0zAX9/CFQ615J8YVw8k7w9q9UAKxptNTcYygFLYWr5Fbma5+7xJ7ZghaYN5cLJVv8NMtR9g=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(61400799027)(376014)(54012099003)(7053199007)(4076005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T0LPpgEWkqyhiyHtEV9qJZ9Xjl7vaRPS1tLIdNVwz6rRrf1ayU2qXYBrcBEy4eK72B0aJBWGtM1fmh7M+f21CfghAZ10WXA1J9/vBFFQlZwg0U5xYHXObYusbEuor7ipfIGxo5YwV5A8zScprgfRFnq0J+BLWatlbZBtdjGlhw+pH0CBoK1unnpVjFtzkzhI7ZXJ7HcmO6L4eq3YNUilU2Wqei+uIp2sUxmINvi4QzG3x9tlagjgvezY8O0/SuLEao3pHBNYwKLSgDdyAYCbXhcsOtypNnAwTzJkHfO4EGtR8Sb0SIcJ8WaCXVCzutNjeZ/AvY0PNFX4PjsbgdH6OEpJ+K/7w+/SHM9DwOCDZDl7ac9fPANhJLamcgzck/2MyI3GFrUMZ1x1FFEP3T7iARh3+z2AiozxcOnXEFHJIloQ+HEiqNufyKfCuH8Sbl1R
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 16:06:19.3083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcd83dd-50e4-4485-b85b-08de7875a43c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4170
X-Proofpoint-GUID: G_BokOqMFR6w7875jNHihQYSljf55k7J
X-Authority-Analysis: v=2.4 cv=VtQuwu2n c=1 sm=1 tr=0 ts=69a5b57e cx=c_pps
 a=r0Opn4K694hZap5IejKoFw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=e-JobF9mkbr2gxnOYXwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzNCBTYWx0ZWRfX0fuQ13b68qBM
 eVOMz1P2bMtkZlPW94kG0UgBVN4jE5KIofK0ebR201UA6Wchp2vHm5+raGJkaUattV0R+S14Z1g
 Rr5G3ulo1oYQDCIAsRN/GOR+KDhPevrEp3fmkGxFLfIQvexxlqPwktSA63k6EEfU9sbAUUxaYJ3
 HTnw30l8eVW2duCJctYcypnkBHzn6o9RpNMRXNFpLvacT2Q1pq00p2C16Q2BueqvxFJX5mcezvI
 ejU9tkCVsSJ8s7hG8nNAIQaqQ9GlJaq4eX0oOU8vXSF0uypujHJaMUDUWdzh5CYxL4M/4pMFAuV
 b8P2swjKZ12XyvGUcDa4vP3Zq45TetFzAwe3nj8CQF8oqXFjZNEWiLn5EZAhHDG5QiwcGjYkRFT
 aVy9VDOymakwv0b1vh8Xx7BiBZ5dV3UpBLwqbHbjgQ0Eemyl75pbjM2BGvV9bLRwWE4n2xdMpf4
 YCcDsZQnKxeWtM42A6A==
X-Proofpoint-ORIG-GUID: G_BokOqMFR6w7875jNHihQYSljf55k7J
X-Proofpoint-Spam-Reason: safe
X-Rspamd-Queue-Id: F2E711DCD6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cirrus.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019,cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222634-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cirrus4.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,opensource.cirrus.com:mid,kylinos.cn:email];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbinding@opensource.cirrus.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Hi,

I don't think this is necessarily the correct solution to this issue.
The software resets were added intentionally, so making them conditional may cause issues.

I've commented on the original BugZilla to get more information.

Thanks,

Stefan

On 02/03/2026 12:11, Zhang Heng wrote:
> Performing software reset again after hardware reset is redundant
> and may result in errors. Software reset should be performed when
> hardware reset is not possible.
>
> [  +0.013038] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: Calibration applied: R0=10476
> [  +0.010741] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.0: Firmware Loaded - Type: spk-prot, Gain: 19
> [  +0.012471] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1: Failed waiting for OTP_BOOT_DONE
> [  +0.000002] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1: PM: dpm_run_callback(): cs35l41_system_resume [snd_hda_scodec_cs35l41] returns -110
> [  +0.000011] cs35l41-hda spi1-CSC3551:00-cs35l41-hda.1: PM: failed to restore: error -110
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221161
> Fixes: 2ee06ff5d7cf ("ALSA: hda: cs35l41: Force a software reset after hardware reset")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
> ---
>  sound/hda/codecs/side-codecs/cs35l41_hda.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
> index b64890006bb7..c546a42754bb 100644
> --- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
> +++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
> @@ -1023,15 +1023,13 @@ static int cs35l41_system_resume(struct device *dev)
>  		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
>  		usleep_range(2000, 2100);
>  		gpiod_set_value_cansleep(cs35l41->reset_gpio, 1);
> +		usleep_range(2000, 2100);
> +	} else {
> +		regmap_write(cs35l41->regmap, CS35L41_SFT_RESET, CS35L41_SOFTWARE_RESET);
> +		usleep_range(2000, 2100);
>  	}
> -
> -	usleep_range(2000, 2100);
> -
>  	regcache_cache_only(cs35l41->regmap, false);
>  
> -	regmap_write(cs35l41->regmap, CS35L41_SFT_RESET, CS35L41_SOFTWARE_RESET);
> -	usleep_range(2000, 2100);
> -
>  	ret = cs35l41_wait_boot_done(cs35l41);
>  	if (ret)
>  		return ret;
> @@ -1973,12 +1971,12 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
>  		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
>  		usleep_range(2000, 2100);
>  		gpiod_set_value_cansleep(cs35l41->reset_gpio, 1);
> +		usleep_range(2000, 2100);
> +	} else {
> +		regmap_write(cs35l41->regmap, CS35L41_SFT_RESET, CS35L41_SOFTWARE_RESET);
> +		usleep_range(2000, 2100);
>  	}
>  
> -	usleep_range(2000, 2100);
> -	regmap_write(cs35l41->regmap, CS35L41_SFT_RESET, CS35L41_SOFTWARE_RESET);
> -	usleep_range(2000, 2100);
> -
>  	ret = cs35l41_wait_boot_done(cs35l41);
>  	if (ret)
>  		goto err;

