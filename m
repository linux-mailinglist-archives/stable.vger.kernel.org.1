Return-Path: <stable+bounces-247640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCDbOT/0Bmo4pgIAu9opvQ
	(envelope-from <stable+bounces-247640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:23:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED1C54D429
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FFAA31609EC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47014441027;
	Fri, 15 May 2026 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CYUvv45g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="P9MvfiOI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23B3E5ED1;
	Fri, 15 May 2026 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839969; cv=fail; b=lA/6G7tmJkFsUS0PPYYLXdEmv15jFMG3MXqIOEWR10GpStjAJdYcFNCz1/e/bm39Wd7MYLwRwg7bye8o5eetAJuTZ9B3ZiuwFfYDrQSHGbKPSIHFEi7ztYhZqdIA0zdSvrUpe+rRVG/GesppEB9KY7EIOYStSVe26/V+6zWFuiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839969; c=relaxed/simple;
	bh=Y5YkhGrQcm/9xWKV8ApYA6d1qEfYvVtgyIF9b1ML6ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Elu/d/40cH6QhNUlLH07jnDAeSrRHcR+OcLofadT/t45fSGKv2EfJZZC0o7zMVAihlIdVsi+7RJQjq5brr7tfl34PmDrNdG1dbir01qgtoBJfW5UvMzn95MqFOSyWy4KhNYId8eJL15x+LYrUlZ0vtoh5a++8WJCBl5o8Dizktg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CYUvv45g; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=P9MvfiOI reason="signature verification failed"; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F3mkpp371296;
	Fri, 15 May 2026 05:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=50pgzFuZbK3KDLSvJGbw7ug3kLmqI49W9tEopbWnCVU=; b=
	CYUvv45g9KyCeeXATVJh8Uj2KGH983ddp2C4rzO3KUY7TQrvbMuy6RULBnIhts2A
	wpjT1x5PFLRR6BHGVlUAGVL4YkPfvxVwTVhXEYU9ICU5GUTJGArFDPyTcJxlACT2
	Ne4fSzNdKMi6d6WqgR5CvGW4ecX0DblzaWrP2OaIuxq7ENavtG4AyT2363De5KcD
	9aihbgvlRH7mn8hK8+ajlpGxVLglaGdSSG9zgcAdNUR0GWCAoF+QxBJaCNk/FuuB
	+KcBM2VUuAUxEfpNPgKaas8+4Pt1WqeulKQF+jtmn9l63j+0107oRhYZif8ETGkU
	8TSo61TTUPRbngeCIGerzw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020135.outbound.protection.outlook.com [40.93.198.135])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4e5m2prrbd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 05:12:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTRkb1677xXELWM+M36A1sugUm2wk/1ewr+N0p/y6+zMgdXIg26MMyQXMPzkdz6E4IlLdCuTsmX1v3l9yKHHMK+WGfDjxcZPJey3P/kfp3DwSpZ3qtzYP3iHSfVaZ/9hJoZu8YkBwxjlhEZ/wkZt6xYHp2Y0if3QR3qd+7HPTv3U0L/T++c5M01h8ZB8cmxiBUcLUxyb+gqGMJj+muOUv7yILTYCY0H5KpcGJZVGgEn+d0B1uZndaI16eW1XtJO2OLVeFSzbM+nocb61nWaQRzAp1o62vbak9fexxi7vbj+ydn8rJN71DXPHGGwBLrLmA81cM29ynHcNBxjwrCTT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvRK8288YeoL8A84KGATwUvh329CMjNspvo5kh11N08=;
 b=PlogsAPa7HY8sRWxH9DEqtXqoYrvyqeLZ6718ewOBpwT96H7uzQTnjb0tvBd6NZ5yZkKz605iUk/FSHWtie4Iv9AFQpRWL1n/D9Gakjs5ZsqAjiheyxC8qhhUACr21dR8Kp0tU2BoYX0xrC6jxrJmWBZDk8tPYGItTd8DBPhc7HcfWST/fhYK0yL/7s1Uv2zGcIpTujwMSdPbvqxJfdB22TjYkiKg9Nbjv8Uyk0jfTzNVIN03mS5vuMMjCh08EKx0UIg5YH8akkkALcFjdNNLIRJfrvtzrp7BdiALDZrQhKKVoQD7WW3WaDxgRslYCbBpPfL9cITJB2rHewQfM6aoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvRK8288YeoL8A84KGATwUvh329CMjNspvo5kh11N08=;
 b=P9MvfiOIm1ZP4Fnnl8wwgeNlgLP6sZ8wIJGTJJJ4G71C2g48WzuduqcyPpsB2hVtsgXYlK3La62RIuBHtrI5WmndcFNKQDLs78qz9+7WJmeWz2KZstygYXOykY29ZY9rqu9+gwOIlsCIVxSfUJI9w1dMrdWL2c3W+eSxJsAixRQ=
Received: from CYZPR17CA0012.namprd17.prod.outlook.com (2603:10b6:930:8c::16)
 by PH8PR19MB7048.namprd19.prod.outlook.com (2603:10b6:510:224::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 15 May
 2026 10:12:24 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:930:8c:cafe::3f) by CYZPR17CA0012.outlook.office365.com
 (2603:10b6:930:8c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Fri,
 15 May 2026 10:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Fri, 15 May 2026 10:12:23 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 7DC77406540;
	Fri, 15 May 2026 10:12:22 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 64D74820244;
	Fri, 15 May 2026 10:12:22 +0000 (UTC)
Date: Fri, 15 May 2026 11:12:13 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: =?iso-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND] ALSA: hda/cs35l41: Fix firmware load work teardown
Message-ID: <agbxffucE1h67TRI@opensource.cirrus.com>
References: <20260511-alsa-hda-cs35l41-fw-work-teardown-v1-1-1184e9bc4f25@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511-alsa-hda-cs35l41-fw-work-teardown-v1-1-1184e9bc4f25@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|PH8PR19MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: a0cf33e9-9541-4576-164a-08deb26a7582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|82310400026|36860700016|22082099003|11063799003|16102099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	seAtBHTObM890ImTlZZARfWnK3cergQT8T4kNMZ6EhJkeZsDJRcw+GRfMojbebv14xudB/bya3tNwTQSGIxrAfYh9wpeteqoCnXPdKPHsJe8SVyZ/ccpGlWEgAefVLGx00pnhbuhKj09o1EGFfEffs8C3J6DoH0+nfefNOugv8TjRkzJ2meeaCi6rHo4ZnGv66pcJXwWY1gnqd9jkSl2GEmS94x15oxdIyXnZc2K6ZQNx5UJBIZcNOsyIcRTmv/AQkAji0qi9v+mcDdVFtfisodi5cjyO3HYKJl7/NxxE4RPjKKMzqeRrroFE4F8AWwyaIcOHreoH+WyK+BuF0TvbtjIa3iiy89ExSKl6vt0ISIOvHCzUZg5H3i5Ux38Q7zRdbaugUUefxOlS0EpWOXMOb9UuDcUU/fZGe6iu+hyGrj3biKdLRSdvXNOVtK8RILM5TzwFzH9aj1ASxhNZeh/yO2g2nMc/xIp8wdvG9fL0cjRWc0jhBB1nzlCASFAlZN9ufjHE5yBZtHJe5j3BxlOCplUUJlfXNOkfcfwT+qRP/iDVwUR9FpdcAwnK1AtXEpUKNA53Z0G/VpL0jt/VHybA8mrLqmHmVM6DJD1TQYkPt1MkEJCsvKrFWnh2D5dtqlvVb76p0dlk/N2jzhml0KUfQDoo93Kx+W3sltDCD15SC4bUx+kSUArZ3zBA4Ko85qLhKAAdkVHSA/L1O6zgjD7rl6Ra73zhKbBPu3dt7LHeAk=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(82310400026)(36860700016)(22082099003)(11063799003)(16102099003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iGrRukqJWO9S/hcpHb1aMg/0H1uo1eZWi6oPYDnhdWwoJ4T1TdAp8yJNQ8YDDki+0IExmb6rqUOnXF9j/+QnfZf8PBDM7vpleXRQlBRQr+hiqBaxLmTMvufdjgmzRUTyjiEZV+pzNBSsPYPvjoxtPXY5139f2RaENaV2f1HfDOTpS5SZwNBpCYaJNFgtk6AcBQrRq9uqqgqLwVbbv1F5QPzKadJr2+IqLNUt9Whibin2We/FgaYhERbTxVXQuoMMYFlyBYvml7ImynpU1axEeBrikOogOzemGavRs3+KUIZZz0qIJHIKE0mCc2RYDqjG2r12MFgiZ/ZobpXvMBV6DIq4mVu0RgrORfmiOhDGhaIWE9qaeDBhstA6LKynx7Ck8VaHCKBigdcQkgoaeLw7u4MlcclS2WUw1HpSmOXPFSEm41P2Zkol/NT/aIteg6lo
X-Exchange-RoutingPolicyChecked:
	K4cGzmmtD3KwFHqRKD01y58VVrPHsyvvG5lROoSlpd950/b451yE63vfcOJB6T7u8YpcfoOZ9WDBeKuIRYgc217GWujFd5uHe4jd1v4M63hCJabfCs27Zp9MVLfhtE0qUZhg/qnCG0ZYYEFdoDMHsbtMj1m79QLeEoqPyBpp6vwvdZqybhh/2kZToXOBgYVSvRI5HEPiSKSyC0FZc1GMlHmwVjk5T9mC8kcT2X5P/lvl3mdkzWfO4lQbbUUmbAszcrKBrUcJ4TVQMSLBa4lKGljq4KuWA8PDca6ejQ7rbuGf00ndjlIgzfM0my061bUzsl3HV/uzEOgUSXVbfabRrg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 10:12:23.8563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cf33e9-9541-4576-164a-08deb26a7582
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7048
X-Proofpoint-GUID: yJLfykd8VSxY7XDWuq_ROSeRE34AaHS3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwMyBTYWx0ZWRfX3pt0Rx/CqdmA
 HkvzTH3MezxK2RRdfi76UBMiR/G/X3olFSJ47vIjpZs1RKMG+xxNY0edyPbE+KGNHY6opatv9N1
 GHhcDnZ7urqGAmAKmpKkgpfTeQwQBeT/eGG8UsC9iFUqTnzXG2apmXpLECLbizfLqSeDhSZJWPj
 XKEWeZgw9jUr9GaWsAn0jPij8iOPTu4IpMwHE8/QxP15M44lnr/CsHucfvwM1SgzpLvkBN1wGu8
 Ams5jVwDYXaP4sNOO3lKRekqLiN9B5FJpRMwlYVpsqdNc8s2gmLRuVHt9v4Uj9cUx97Vns0bDoX
 hGI0UPFVm+P0D+de/RZzviA6V5hGl+jVMJdnm6GlDyVlqTcD/4CMdkzpJQBn+c9L0vUBQ/+0L/y
 FFXu2lTWIzbovqwf86MTJCkKgVyaKUW8Pr9vdd1raikTBZ35sUuOKLZmoylvXUl4+VD23kTxeKz
 MDp4XGso7lbNVX22cug==
X-Proofpoint-ORIG-GUID: yJLfykd8VSxY7XDWuq_ROSeRE34AaHS3
X-Authority-Analysis: v=2.4 cv=aMHAb79m c=1 sm=1 tr=0 ts=6a06f18c cx=c_pps
 a=xM+CCxkBm3QG079K+XzSvg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=_3FePLsnkTRkqT5FW9UA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Reason: safe
X-Rspamd-Queue-Id: 4ED1C54D429
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_REJECT(0.00)[cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	DKIM_MIXED(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247640-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[cirrus.com,reject];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:-];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 01:29:34AM -0300, Cássio Gabriel wrote:
> cs35l41_hda creates ALSA controls whose private data points at the
> cs35l41_hda object. The firmware load control can also queue
> fw_load_work.
> 
> Those controls are not removed on component unbind, and device remove
> only cancels fw_load_work through cs35l41_remove_dsp(). That helper is
> skipped when halo_initialized is false. With firmware_autostart
> disabled, a firmware load can be requested before the DSP has been
> initialized. If the component or device is removed before the queued
> work runs, the worker can run after teardown and dereference driver
> state that is no longer valid.
> 
> Track the created controls and remove them on unbind so no new control
> callback can reach the driver data or queue more work. Then cancel
> fw_load_work to drain any request that was already queued. Also cancel
> the work unconditionally during device remove before runtime PM teardown.
> 
> Fixes: 47ceabd99a28 ("ALSA: hda: cs35l41: Support Firmware switching and reloading")
> Fixes: 4c870513fbb0 ("ALSA: hda: cs35l41: Add read-only ALSA control for forced mute")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> ---
>  static bool cs35l41_dsm_supported(acpi_handle handle, unsigned int commands)
> @@ -1522,6 +1550,10 @@ static void cs35l41_hda_unbind(struct device *dev, struct device *master, void *
>  		device_link_remove(&cs35l41->codec->core.dev, cs35l41->dev);
>  		unlock_system_sleep(sleep_flags);
>  		memset(comp, 0, sizeof(*comp));
> +
> +		cs35l41_remove_controls(cs35l41);
> +		cancel_work_sync(&cs35l41->fw_load_work);
> +		cs35l41->codec = NULL;

Hmm... are we sure the controls are actually still accessible
from user-space here? Feels like generally it would make more
sense to make all the cards controls inaccessible before we start
tearing the card down as a core feature.

Adding the cancel works looks very sensible.

@Stefan, could you also please have a look.

Thanks,
Charles

