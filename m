Return-Path: <stable+bounces-240995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHLVKG2P62k+OQAAu9opvQ
	(envelope-from <stable+bounces-240995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 17:42:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C490460E03
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 17:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DCF330022DF
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1498E3E0251;
	Fri, 24 Apr 2026 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Cjxp0t1Y";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="yE44t8VL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA423DC4D2;
	Fri, 24 Apr 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045344; cv=fail; b=q7qvpamDMeYwr5JDNkIDyGhMKda+nNR2eOFOFN9Cgx9CFZAZK2ouTNpuJqi32G5S1D2gvwXmIQ07UmxvETr398aOy5iTIC9lyNlddblH0VXQGzuAN54IcITvWydy05vQjpZ/uDEhBhciQvO8SkFEJ9R3xMwBTEQ1LY2suy/Y/RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045344; c=relaxed/simple;
	bh=mgF3ZvJjscQWv4lO1yJwdR4fT5QurC9EW73PMAV48ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyLanO5YSbEoygNaM4yFCoOtm4gPjchNUtT/d5zF6chmb7BAU3/zCu5yQUiCD/nUMcBRLxpcfe9y8k66Sv5jopJ5ujcTEJ7xbXUO5M/BtQXG0IstVoJHlreLqZGbKeoYm4CZ/D3ZPD5j2eK2+mgAL6WWRfcmqt0I+lLN+69AMZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Cjxp0t1Y; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=yE44t8VL; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O6aSbp3341144;
	Fri, 24 Apr 2026 10:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=A/bOK0AlmAYVHv7IpDx/v8iJJ7Xys4v2LZ4+KOZuHJI=; b=
	Cjxp0t1YCeHI3mla6uuNbbnJ+JWN9TRIwS8GxaCUOsZGyZiXyx164rjvpkRnAsyq
	JqlcskvDf+errpE8SIB7kGY5bvYAwGiWKPfD6DJAyfLjY6INDgPTm+sh15SSwCpB
	F8ZUyHQNhEVmhyF5b6jQCAVuulNrixBLr2uJqVcXaVMSb32z1dfiEwGAB/gdxJDo
	2RC5zj7i7em64rD4IjxK8Jq6mmbEOXmQk613BFhgLDUjZtdWukRoomiTFMB0euqT
	tysDMMwn4nOV+igL10/s1usoO6MzNZSoLDl5y11e5lPspQn+Xtaux33vwpv3Qx6R
	kXbq0YuHGsJLGFH+xHtbYQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021143.outbound.protection.outlook.com [52.101.57.143])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4dpenhv2tb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 10:41:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTHz4maFBZS9vJHO9USp0TaFsG2pWlxxyUhrBjFfhxH+QoJEK9jhVoEA13GV2jzORFPcgdcsKgYuyQkL0kHA3AiCjzFODyPrrFbH7tKvd1NsJ5kfHC8yYwnDuTFFfAc6mXbQoaVnojXoKfKIapi89yD0Hyi9wz/16sI2wC+2UgRFDTmmu4bwdZmdwxkFRvMu4NuQ3aBL4jJiDaRCP5FSfTanafxMnzVb5zYyzy8bJ2PC4cuINUHkQMizyOgG3991FyokeSJiQXselX2qtjdA2aQmQ76uyIyRjYk5oNkoCh9nQZ6ZX5McIP93xUAC0MWbkaOTPeHQ2pVwgAKws+xGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/bOK0AlmAYVHv7IpDx/v8iJJ7Xys4v2LZ4+KOZuHJI=;
 b=yKm1V4QQHDwI4Uro0LmY5bK113v9dpydBNSaR2HqArkQmTjU9v2Yn582Dfslrh2A0RdK5kGZ+tAqXrpEcU2ltH0g7mn3eeF4ZLmLr5x5n2LjttxxAo76SN2oNJeTUV/l0aE/363gBGyOE5bi0RV27Y+1Q/T/TJbfOcRW8w/ji4EuxqOl8t0sjO4IVG/2AoB7JsKoxJ4VIkilxTSMFD21/94F+vHYj/9hKawJPeJDubFw5I2/PNgwNXMulQuBJxeKxEWrJ9EVeY/jp/8Po7DZheb31fdJix2QE689FX+yJEWUsaR00COeO+ARPP9WuJrCSt/M300RK+5iWaw4beYlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/bOK0AlmAYVHv7IpDx/v8iJJ7Xys4v2LZ4+KOZuHJI=;
 b=yE44t8VLSM6Ia3mATPQlULWr56xxfNL9alEwPjey3RKTr/dZ2+uaD83RnC5XeY0X+WoBk0L0Ot+45JvfriPHPKHOtIGRs6M4LWSIwte1aaqWZpDyg8KYigV/MaYhKku41ePvZ+cXtymW3Yd9Nu7skD/UDBYN6pNu4sFdvOBLVD4=
Received: from DS7PR03CA0323.namprd03.prod.outlook.com (2603:10b6:8:2b::12) by
 CO6PR19MB4818.namprd19.prod.outlook.com (2603:10b6:5:34f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.22; Fri, 24 Apr 2026 15:41:45 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:8:2b:cafe::7) by DS7PR03CA0323.outlook.office365.com
 (2603:10b6:8:2b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 15:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.4
 via Frontend Transport; Fri, 24 Apr 2026 15:41:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 004E0406540;
	Fri, 24 Apr 2026 15:41:43 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E435F82024A;
	Fri, 24 Apr 2026 15:41:42 +0000 (UTC)
Message-ID: <1e0fec70-7af8-44d0-a9f9-69b0b42c6931@opensource.cirrus.com>
Date: Fri, 24 Apr 2026 16:41:42 +0100
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CO6PR19MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: d83d8e98-03ec-41ef-ba0c-08dea217fd24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|61400799027|16102099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	piBQdHgpGEjMtVB/BVQxE2i3+q/tcPTbbp9RaTUd4QRvk/K0aqBoAcJL5MTYx8Z3ts3ovromuKUtEXD0FSIu/5oFCYVAnPq4vJMJ7Qq2GyZQZ8r2zVH5IRew68cuK+EsYftanIWEWuFPTDFBt1LRiEH71n9A9k0LuIc3ZMJNkus0RTUVaPObxDwNctgy6QKxWKql0Pk0JX/LcV4IJZ8WoE/RGGBOfsuyvsGSBRL2y/67jeDgWX6U3u+0kGPsaK9CbyV/E3MkSvZrZD7AwKBzjSkwqyzQcIwmBGgHfuaxG+OnhZCrlsxAE5fTMCi6kptNnIMOmbj2rvfXU0crEdGqgUWpH5kRzejOp9dELWXOZSYmGIncb1H7onpB4sPfUGR4tRjl9+WXCuQwRnA0X3bD7cekZB56ovB0DjONPTB94XsoUPcpOXX+iSLWDvk2oXCub9RP7qzzK3x+zd2oJFGYHMGEVBl6TfD720KPv26/yGIQGOO/CG6en9q+9cIG9hNzUF/oWA/2tLjIE1w9HvzNvfZN8qzy4d8H7QJ3hqLiWfr66uKA7Cf9qxgb/V+Qhgrc6I/G2KXOAethhRHNpkcr/H7+wSYqYdJfy3Y78aJsfKc6nno7irpeW7vvOjMelrxXHh/J/JaIUdlaMibjxI8ag7HEv4cZ6W3x1jb4us9IVxp8zslmb8ZakaYF0L3IqLoYE5r51o8K+kwrfTmgGdDHr/2bUfTaYkudQfQvliceJ+Fl4DAujSupb7YjWo4Evz6M0X2bqAu0a7ehgOx9UsA1hw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(61400799027)(16102099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VWla58oLporWJI4HduFkNmD6v1iVeuGXaEI5KFArImulnQGOZV3raXpU8BeqCzFVZcNtg9A2+0KBeHHNabujZiO6KvqQpZEFfEn0x9pDYilGcu0yEaa5788VyK2L+nonGBVltxg1GqnkP+bMIG3JTHP8i1zQYmasZSN/FnPv6LlbtPMCXIoUph3gb9gR7nBC9O8pX/rVyslOlOWDjrtd4knG57Q/hm7WBIJke8FxtEaXuUBJZ2h3e48d3LyQFozWF+cIhkuXvNSn+yvDFyLv1EDYuebhyyeonizqWVzd+BuLaJ2a8hIPxusPKwCVh9ClGYSkhnvBc2/ju9+fasmFAD7iRnfSfr0lROCuMfM8D2mR2mZ0SxtZgTrLcIQ3DarbnXky+BSha/swXUPuTUQClLcI7RbzLGehIeUH9DoXiLjszmrAXydIiRPOuOjfOV9T
X-Exchange-RoutingPolicyChecked:
	AMzdTmfgvWA44/AcVOHyXcsv27xlNsAHJqdpD8cCQyCDbsJY/bjoIH1y3ULq0k5CnPF3KyEhyK1Po2BpDPi9iSoIsQwGQ4HwrOJnvrxjyup7qUneOB0YW3vfunns9445i15MfTVWQNTjUgTlJCORR8762lfOig6i4MTm8gPhYy3G1FjrGIk0pg/YIZmyf5ny2fupRUIBHOLYRkultvnvNjWzXE03tYn+7h47i1CqUrkMEsdlBEDxg+X4ubg6dSlM3CTVKXlIQDUv9WjH/wfCTzMx+6lJ718SkZUjan2AJQ737QQJCdEsm+EfCoGWgz5Mu4cwgqKOrpuYMBHyISChyw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 15:41:44.5825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d83d8e98-03ec-41ef-ba0c-08dea217fd24
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB4818
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE1MiBTYWx0ZWRfX+c2lY1T8vdKl
 TcDBrWJOD9e6tINbtHmSkwKTzW9colwfY5xKAsF2SA9paxb3FaxzvWLcEdCHK9q5sQ0PKIP8PN5
 Eh+dp1aN8x+lePVRu0f0rCxnyO454n2naVmN93DUXS+UggbM2B5qDTijVFmOD2UpXoW9gwKi8qp
 DxWNdrTIjCBam6Ue7llSVgfi5kYRgQ3B9xpo3sF8O8NTukvHH8pDvvaqxqd/NLZIPxudsMnrPxo
 /zQrQ4zvZeFtT9S6D54QTJ15pQyuL9dgP2xgYrn+RBZvGcsTocCW5ttlAZyvc3shMr+qhhXbk+K
 jSIFwg9dsl2twy8Sx/d2xWHCM+3bRNAL8oUB6FwNnGgDMxT1YeGP3qKhPDFb/K4X2t1wKCxRp26
 ODBgQPLgHLda9rgHNHOgc90seuRGGKvMEBzLWxS4fO21lvaBdJBsAwcePSfP5xByLl/qaxgBKD9
 reYH8MJN36xGv0jgGCA==
X-Proofpoint-GUID: 80D7y0JOgbaSIRBr3j-cpHk1CaYxljQd
X-Proofpoint-ORIG-GUID: 80D7y0JOgbaSIRBr3j-cpHk1CaYxljQd
X-Authority-Analysis: v=2.4 cv=DZInbPtW c=1 sm=1 tr=0 ts=69eb8f3c cx=c_pps
 a=pCScd9Md5F2Oib7HHR5gBQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=w1d2syhTAAAA:8 a=JvBwcO1VsS_aB5xwRE4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Reason: safe
X-Rspamd-Queue-Id: 3C490460E03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cirrus.com,reject];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019,cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240995-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cirrus.com:dkim,cirrus.com:email,cirrus4.onmicrosoft.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]

On 23/04/2026 2:11 pm, Cássio Gabriel wrote:
> cs35l56_hda_mixer_get() ignores regmap_read() and
> cs35l56_hda_mixer_put() ignores regmap_update_bits_check().
> 
> This makes the ASP TX source controls report success when a regmap
> access fails. The write path returns no change instead of an error,
> and the read path continues after a failed read instead of aborting
> the control callback.
> 
> Propagate the regmap errors, matching the posture and volume controls
> in this driver.
> 
> Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> ---
>   sound/hda/codecs/side-codecs/cs35l56_hda.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

