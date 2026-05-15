Return-Path: <stable+bounces-247848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI03D+dAB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:51:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC555267B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 051573033AD5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBB73FF1DE;
	Fri, 15 May 2026 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ia+HyvV9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="kJXQambL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFB83FF1DF;
	Fri, 15 May 2026 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860199; cv=fail; b=JlOXhy675LpJzNrcMvbsExpeHn3Cx+g4+Vto6SzYVWzwezNpvHRouAmaarsQ0yAUVVpoHL7tF9hQabOoA4rry4TRUZ1Tc8OZR98tF9Qi5LnlkCvmTg7cK+ZD+b08+qU/U+2t/ofbw0b2AboVIvFIQFa6TgYMKFrn317W0YAwlzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860199; c=relaxed/simple;
	bh=71OQJZDE6G53sSeo76s2edeh/r69/8V6WfnAZAVwyXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTtZmBV5gWuCEJGtiFiUR91gbio4sGJSc862z3chj6iRKpMLVJlvGSDLPVuOu6AnJ4Tl9VKAk+kUw+R1xKLV8rBLLppUhgrfUrMM+To2x+xZe2nN21SS5Uqc9v5gx2uS9QY53A9xuFXSTKg0Y28OIyDEq5SiiOgYwoT4TMmi96Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ia+HyvV9; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=kJXQambL reason="signature verification failed"; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F3mk8A371296;
	Fri, 15 May 2026 10:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=OPDRWg7WC2E83xxk3l9om4wNblrGqkc+zEf7dsqQy74=; b=
	Ia+HyvV9T2xKmcBNj6zHvYsX1vT7vr992Cj3cA7YyBtnsXvs30CX4YGO0EmDy3EA
	N8EGsZEXor3Y4ydiZmC537OhQfoeyFsxg0YdaJg1/UOjFOutLStNQZTspLPv8xBw
	qJ0O0i25weRpOxAMdzSUsBPTRi2X6jjGjKlZUaDFxSIABEa7jh3kzOGA6zR3Dxfr
	tYa8GS2WMpBpfGFxUTnzti5NVvvWZ20eAabFopNuT7XDHRQ3LbuPosz8iQlhbfge
	GVgRzTR0eWCLd3Oa+EmLHq64K9P9QH7+8zo73z6oMPj8s/hjuA3+U/V0avkmRJA9
	DeTjvtXtqpeF4oUxymOsLw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023142.outbound.protection.outlook.com [40.107.201.142])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4e5m2ps46u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 10:49:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/sJZ8BcQX9XXhg7u1+Jful5a3IR1vs9fqEzIfTS0qyW9ISPGmJiDp0DMsWegFp8QCl46Y/bDfVIvcEIerisNcEk1R81qg/aUpInDdHY1JGIiOi2v6Q8NeiPC+cfooc1TnmCazX295AaNLzdAcA1tI+GJI+7KWjS8m8hDxsvLOJ6l3c4z8oGJm5F+/OLrF23rK/L+iTuXNLl53Q6GWJRaYTzn7XmLCAH7BUkCq/wjd01T2bfjhED6h1dwO6+FqlGF/fLvA2yV3b+xlSX79c5i43SQx9IPrzTvxhKMZdP2sMDLB4SE7/5w3wZM77OVrINNOY+lhPcHb6jZqMJlWt9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvIw3Rh9OwesiLMBrvfrPdPgGydpTG6FaMf33f/sx0Y=;
 b=lmZHUgWVfLdr+6A1GZtbYQhMJ6+UGGKXbNAhFzFjYDNgyuRN5UWXtwJzrUoC5/8W9g3X5RSYC0PYuEbYpp20288TLGbUW3OTh5JS6cE4oHNx69GP+wKPvc/8qLag3jPMlhrrCwyKEWKv1IUka88wnm5IRBmvRIbEbIinPLR5jaQTfFsJbll57gDuAwrTjw6YpKgY6KcTXgCSViClYaKwSt8H7PR81+HDHA/6I6yIVKeA/7U2GVbj7RQ2Oft/5Q2x8dVF46mRxzt5Nz3DplpLWeOariH9tCNGJJcCb1p6wQEmets84xCBVf9/OVHReR4OJqxaTLYKGjI2/A3CNb1Q0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvIw3Rh9OwesiLMBrvfrPdPgGydpTG6FaMf33f/sx0Y=;
 b=kJXQambLQaRQWe95hJoTy2adwka9WKrZHngDdDzSVI9vdyiJtGLUWBVt01zs8rMev5L5s1yzV1GHqTwYo+/tluZTHhQNwy1CH8eX0TgPHG5wwprFyRmcoXPB0H8OLpoWBwq2TKsZ1oEBWciKHJMzRFPUkTBs8NS8sxIijQrNz4g=
Received: from CH0PR03CA0387.namprd03.prod.outlook.com (2603:10b6:610:119::21)
 by CY8PR19MB7107.namprd19.prod.outlook.com (2603:10b6:930:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.13; Fri, 15 May
 2026 15:49:45 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::ce) by CH0PR03CA0387.outlook.office365.com
 (2603:10b6:610:119::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Fri,
 15 May 2026 15:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Fri, 15 May 2026 15:49:43 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 374DE406540;
	Fri, 15 May 2026 15:49:42 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1D85982024A;
	Fri, 15 May 2026 15:49:42 +0000 (UTC)
Date: Fri, 15 May 2026 16:49:40 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: "Stefan Binding (Opensource)" <sbinding@opensource.cirrus.com>
Cc: =?iso-8859-1?Q?'C=E1ssio?= Gabriel' <cassiogabrielcontato@gmail.com>,
        'David Rhodes' <david.rhodes@cirrus.com>,
        'Richard Fitzgerald' <rf@opensource.cirrus.com>,
        'Takashi Iwai' <tiwai@suse.com>,
        'Vitaly Rodionov' <vitalyr@opensource.cirrus.com>,
        'Jaroslav Kysela' <perex@perex.cz>, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND] ALSA: hda/cs35l41: Fix firmware load work teardown
Message-ID: <agdAlJek88n6K53H@opensource.cirrus.com>
References: <20260511-alsa-hda-cs35l41-fw-work-teardown-v1-1-1184e9bc4f25@gmail.com>
 <agbxffucE1h67TRI@opensource.cirrus.com>
 <002f01dce47c$a7859760$f690c620$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <002f01dce47c$a7859760$f690c620$@opensource.cirrus.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CY8PR19MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 86230336-65ef-4150-0cf8-08deb2999520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700016|16102099003|18002099003|22082099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	RVWkqGlf4AVvcfrcytOW/kpftyG1JDOywiUPuUxYue9M6lsHVPTVCo9PJbnB+LKlO9yWzN8sUXoEMjdIEC+FtRO13EYV/QaDvLVEhIQtQ7u4PXw7z9woFsjUnFm67Hx8ZiwxJyFDQa2KlNLg7LawtZoFlbyzm2ke+Rnucglh7zG/dpPg5lEQ+n0pmmwbXYhX88qd7WGH0YVLLpv5XePu/lOWs4yavxcpR9AecnzDilu5qIwGWqvO9PpYSEpUppxZwZrMd9c/zUKLpRqvE83CNOPNut5ZW3mbFmjyJKoI8TUPaAjv0U9EAFlq+QpWO+0Ohj5hySzg1ij57uN0KGi+F/lbLM9B9Dy9w0+8JwcVj3CQSMm8oBD0ppmdtsN9Xl+H28P/V5EZ25gZrGJRn0lvdY0eiCF1NYW1WN9UxInA4x4vlUoYNG5zIKJalf+E/7Xy6zgmy9IEF3eF+xryXX4+IKb3OuHwWH3oo1ZL+92MpkRC5MZG4gv5w9Pcj7VILXRrwaoKOg3/Ka5jNPb5wfmcenf2kC1JITIC58pPB5lrOxHxQGLsBvvHphEQaZ5jkQf5lXJBdD7U+W0KBypbMi1H8sOfJmqbf82jhu5b0bv3PjR1r3HeB91H/PvndaNn2DckxCWzXuEI3Ro0wVip35lILRXxJS17efiaJNRSXR5eQfvX2TMmoqN850+2aKw1WcAMidAE8h35xBR8dUNY9E/XH8Fu2gDdP8O7jbGa43lEB8g=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700016)(16102099003)(18002099003)(22082099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DAQ1vK6jAJX3UaA4FSeQFqf0su78DX97S+AhXfSOomKbC9UEik7+U7/nan/eY7itlFmq48Ud8yTGbUxso2zJsnDC7zyNa6dH9GOr2T00hea3jSGSfDWu8XR7nvwvxH06wLVeSctUhYUg4pYipPRPNlGmjh3GppGGH606ivh4MQnr3LD87nRnNyF97bjd8zA6deWYYeHXR+6xPTRe973reCEVvUbzbphnBxIYjiGkftFcLYLWn10xui2tYJ55iknlSzRAUwx7HksVpCVomXL0UhjP6SqWOrdw9jQ8z03hagbwKHj0JGAYJYl7xLDJgdaXJ3m+m2dorAmjZ1LXL5h0JC+lvLId0ED+K4lFGo4VdsIWCrSLuSUQ72fq9HZNYiv+gMakk56O/fFknYopU0o9u0uNvZsrXEoopOTzpwZswUExHGWPDoVzpVlDu4/Jn6OO
X-Exchange-RoutingPolicyChecked:
	Q3YgHGQhHCCrkoZSbsMQeaZ1is8d5DsU5J3WQo7M8/N86py/R9P5cT+mZaPNPzwo6MZl8uvTdhaR94M3Jp0VfRGzskgoodta48M2GnhZDK+EjWcr35URuODEu0HHW41UzoGyHzduamWv+bO8Uo2/BhNC4rGNLi/dPiAH6hneplKJ7pf0Dp6LnWMh3s1Inzj3bz7R+IkqgyYbRQjdQKDJ+YSCeOhyidNi9ZgPJm4DaHKC1JovMGItrSnoL9sNEap/zCPfnuOuyiwGhcjvRC9yG53z+UKXxsfuAH/RJtT6GPIM2OPjWSrqKcpCjn/GijA78dWGgIpzIpP6lEPpXfVV9g==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 15:49:43.2524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86230336-65ef-4150-0cf8-08deb2999520
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7107
X-Proofpoint-GUID: d5YSJwVcPK0AUTubUlFcrMdU9d66io4Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE2MSBTYWx0ZWRfXyksjpoHTgpPz
 M1uWTKjsFO6Mv4jjnfh75ExGM6sAX8xXQzQ2XcffjYEPa8noyu4opMs7Dzak/a1KoVhUdpDAofn
 LHeMHK2NGQsXHwD6xZ5V5F3Wi+ReB9HfvhGjajPyWLHja/5EtwrrCKthc8gtwabs8iI7OEFMeQc
 ThaH5pCW9zd9Nbo93Heg4FO2FGvI7uNdXqz/DyCNCizY+tucri+tBtmDLcIPmApZUD3Fjm6AYkY
 ovRLg9AuVukxia39HWbh+Rg5hLssfuonbVCMPgyBW16BFYRy+Mfkde9fXXXLaTTXXW0fpV/7biN
 A6+0g4eIvP8GyjZlsPxqNNlpEiuOT5T55tQJCpXpjSdY3dgRIZIn8E/A8lG4uw6Bv/uxWBhqQbp
 GBP1jCumw96ubE0DFQ2wFGDQxJApMhWP7NFYnzeNK4qMZZ5yaVda937pgtiAXGeKJ96nM7kwE4K
 kh9I0oHO259CRXs3stw==
X-Proofpoint-ORIG-GUID: d5YSJwVcPK0AUTubUlFcrMdU9d66io4Q
X-Authority-Analysis: v=2.4 cv=aMHAb79m c=1 sm=1 tr=0 ts=6a07409e cx=c_pps
 a=nzP3m+/CqRdBhj8fzGTHBQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=w1d2syhTAAAA:8 a=aeQL6Ji8ouG2p6O6iOQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Reason: safe
X-Rspamd-Queue-Id: ABEC555267B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,cirrus.com,opensource.cirrus.com,suse.com,perex.cz,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[cirrus.com,reject];
	R_DKIM_REJECT(0.00)[cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cirrus.com:email,cirrus.com:dkim];
	TAGGED_FROM(0.00)[bounces-247848-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_MIXED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 04:08:14PM +0100, Stefan Binding (Opensource) wrote:
> > -----Original Message-----
> > 
> > @Stefan, could you also please have a look.
> 
> I think this is fine to do, and I did some tests to make sure it doesn’t
> break anything.
> Reviewed-by: Stefan Binding <sbinding@opensource.cirrus.com>

If Stefan is happy so I am :-)

Thanks,
Charles

