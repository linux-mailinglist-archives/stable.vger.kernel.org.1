Return-Path: <stable+bounces-247815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A/SMBs4B2ottwIAu9opvQ
	(envelope-from <stable+bounces-247815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:13:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 334A9551F6C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 714853088552
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD58848B36F;
	Fri, 15 May 2026 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="brT4QPvY";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="NIXHRuWr"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D176D292B54;
	Fri, 15 May 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857711; cv=fail; b=KavFJLg/nWpySLkD0iR2r8dIcEQo3q0e3ns62qw8qUeuez5rKcFdTfO0O0biKrzGtgIQm4Tah6PTdpuPeUS2gyQ0W2JsVRCg/mG3VgppR2sBYXz4DK1VwVY15t0JIkKXDGCSPNuh8fiERC15ktcyS64H+b56AfdJinjZgm5XgWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857711; c=relaxed/simple;
	bh=lAuXU9V3ja7nNS2z6gGWZn2KHKWTpTu5wtMNmY8hrNs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qE+YsmSmU08wE2u5Z5jIrRVYrznwpMaYPHuSwsShvLzSxmlrLeoQeJgTJMJXUOC8wub2Dt90krzPUJWcPO83q8z4D83HOWMmsutgK3ehLkp4kNLuXsiUfEnByC5K5O+urMt2vz9HmSdcBOs6GP8cCmzixldAEbeqDaL/pdMc7zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=brT4QPvY; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=NIXHRuWr; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F3mk5j371296;
	Fri, 15 May 2026 10:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=YtnnDUTAW0E/xEP/23qBpTgjutyzbYaZzMX+opl/R/o=; b=
	brT4QPvYCxPTAk8zHaY4mBjj/NGa0URtC3f1No0w77eXBvdobaB7VK6+4ZZvKwRy
	Bt7RYRnM1rpZIcrT0k+Rm6cU0r7NxNaA5mKpiZqKu4caa8jHT0ppuLrkbftSDMz7
	EydwebhJNlQGkNBavu2yCNPbxeRiXVZBDLGN40nbqwcJ9q+HeBwLfYg5kIY16Prp
	VSd7/37JILTV/JChJMNb6pkSrY8+c7quycHA01P7xLZXZ9MD2vtYSmst/p5bNFrO
	y63iJuFf3J13Qaa8AZxg6u3BfCH7lwtSu6tPrKYYLKjBbi0HkZVJOp+eH2kDC9Tt
	YtimuWC0kbVeEKwXXp7Rgg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020091.outbound.protection.outlook.com [52.101.56.91])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4e5m2ps2k3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 10:08:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRjEBsqyMOmYqznUKkH9KPDIwfCQi1Dzs5+Gt/q+MwdWMQxVEITMOl/pYvv+xcbmmhPZOQFph+gfBALlaHLMLC9OtMIQmn1eo7YewI0tf7M6N6vlzs6Rp9gIBh/Uq0bpLEj75jN5Mpjk0ysPE8obMi3wIm7SFjk57dNIWNBFMCcYRB/czLzIBCtcmy7WTnP80iSNH6ZsCRoOqOVwCZIhYU0mduYq4wmb9BC2CxWlKDB1hvwnG9F1JVdnyOGRoWOZdCyTOnn5oTaJWi0OPVBifORgSWoTniUKAaCZxxOtdBG532VYHY2z+wcnZLhnKGchQmhZAcXXxhgDpfqOwkMGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtnnDUTAW0E/xEP/23qBpTgjutyzbYaZzMX+opl/R/o=;
 b=c/wpr2HESQDIUtY6Sryl0yvyRd7Mgkcb7D+8xWlP2WFDZb4ifgIaW6V7vnQzfPMDrUeQ3MJRtmI05i9dYaJ8RY3X4uYAheBwOMbi+YiVAauiEOl2zRZdP/MAawOpD4z2578uYkoAY1eF2n72uX3D5VDL3qhlxXkzCh4aM6BHMhboBXJVuu09LnG1af8LupUbALxgQYB3qNR84zcepfnu18xoiLLShK0PXHmO9BwcTzM/bE2RGlaPOS+5vCs2dB/KOI3v2Q3vfkSGchyLZKenTGYXlhP/qORbasHHLp2rtC0kCmEZuSBLdI+K2j4xAAzh7xTOpdX/FN7seedS4DXF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtnnDUTAW0E/xEP/23qBpTgjutyzbYaZzMX+opl/R/o=;
 b=NIXHRuWrahp/V7q5Cshd63MlfxSEWk2wXVUzpXqZeqEnKTF2sMNFRDngKQBuUlt4Q3IR2V8VF1pgFgc+QvgXWmx7Ws4zqpMP7WGvbo1xM6moQ3uXoByZ0n6S9qQm2UvDfQ98ktuaPmXjyO1cgsDvfjDmYNPlidpezvU7ozZLjY0=
Received: from PH8P220CA0046.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::22)
 by LV9PR19MB9038.namprd19.prod.outlook.com (2603:10b6:408:2e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 15:08:17 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:2d9:cafe::52) by PH8P220CA0046.outlook.office365.com
 (2603:10b6:510:2d9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Fri, 15
 May 2026 15:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.0 via
 Frontend Transport; Fri, 15 May 2026 15:08:16 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 49206406540;
	Fri, 15 May 2026 15:08:15 +0000 (UTC)
Received: from LONNCK4V044 (unknown [198.90.188.46])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E803E82024A;
	Fri, 15 May 2026 15:08:14 +0000 (UTC)
From: "Stefan Binding \(Opensource\)" <sbinding@opensource.cirrus.com>
To: "'Charles Keepax'" <ckeepax@opensource.cirrus.com>,
        =?iso-8859-1?Q?'C=E1ssio_Gabriel'?= <cassiogabrielcontato@gmail.com>
Cc: "'David Rhodes'" <david.rhodes@cirrus.com>,
        "'Richard Fitzgerald'" <rf@opensource.cirrus.com>,
        "'Takashi Iwai'" <tiwai@suse.com>,
        "'Vitaly Rodionov'" <vitalyr@opensource.cirrus.com>,
        "'Jaroslav Kysela'" <perex@perex.cz>, <linux-sound@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20260511-alsa-hda-cs35l41-fw-work-teardown-v1-1-1184e9bc4f25@gmail.com> <agbxffucE1h67TRI@opensource.cirrus.com>
In-Reply-To: <agbxffucE1h67TRI@opensource.cirrus.com>
Subject: RE: [PATCH RESEND] ALSA: hda/cs35l41: Fix firmware load work teardown
Date: Fri, 15 May 2026 16:08:14 +0100
Message-ID: <002f01dce47c$a7859760$f690c620$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJVru1H1X8DEkodQ2gKbnitDjJPjwKXuRFZtQjc8mA=
Content-Language: en-gb
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|LV9PR19MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd83dff-3210-48c2-1fa1-08deb293cb0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|61400799027|11063799003|3023799003|22082099003|56012099003|16102099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	7dV45Nez6gAQUpFAViUfLe6u9LiYMEEdDVK2u6NnLv/YnR45Qpc4ziXCeBoSHF3reu7Y+0YsnFSPOx2YvCYazgArUOw/UJg+VPiuJ3d0tZtpkLSQPGjI7pPukuUForzHQ1e0g05tSJgSAttBbnV3lPeXerFGl8oaaz+TR89uDsg1A5+FrhWdLMWxnNkhh6NsWAa0qM1vbKsusPLrnCC2bwkujdFQgGv7syJZ21uQfVtnQLSwqKRbWxqY7r2AUYeyFJJN+k8fUVSTfzXP39IHX85Pl5HLX18k9dKGTMysWh6rRtCFd8FXTx8PrFIeZ5P/Z6fsKCf7qrXuzcT4nWb8y/Tzn91Cut/2iVTs8anZXbcIPFb2+udEp9YWmJG20S/1sI5Jzs2AbsF5Pp7VG9sY+5w2vD124IgLk/S3Z+B9vyrsZNq+liWVyMnxyVSfcW10arCDbjzBnSyEodL2W7qq1DYcFiTDQ0OWGL09nv88WlKZylvChUIOM94OJVYICHUqF8Dot7hNjow+BFwjB6MgJUNLohBfFgehcQTJvUXiju0EYj4hPTTD3UiIXsQAfq4atmwQNaSKW5OA+0/3xF3TUqXzFyYtcEQ+C/dJmSFH3Uq/bYe6elzMvPS/d2G5IsQ2+4Lsu81D2SZGmi7nbfUxnyKnIh/uIqaRJQHKS2IG8ND6chR+p1+TFh5tNOY9mw5u
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(61400799027)(11063799003)(3023799003)(22082099003)(56012099003)(16102099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RMLM32lOyxIGeigicS5EB68isQ/jARLWlrd1AU2CB08X2B92MvpBhHQWEc+CTScCkvhaACBdbik/pw1h+tdAQ1UMagCsV9Ho2Bz7bc2sjH+IA2ncELJIoenca4czx0DlvhMBGHuwSHvI2whEVqVbf2SESQjY3l7tEiXjWyetNcOMJIQ1cVtO7Ahx/+nC1QTO03s+PzDTj7z2Aq2JrxMHJ7fyI8v8p7mcz1uqDiJTV8v6rUK8jJiT/9Z6NFXkmON6neamj4rjdq+bhZVnjLIUpH9HEql1qHd655XTKLANwQ/TQgSoBMNLQOdE5pSuhiYcyHO9EmyXIyzl+myDt0QymlbL9hTbbWdGDsrD5sAv35TKRDOK8dPw51x5NsyhVaWjD3PAELEXmGi1iXUYg8EV2zw5DKepY4tAbVeA5LxaOaMbIqB0qq0s73g8zW/5N/+k
X-Exchange-RoutingPolicyChecked:
	uZEwXzalt57IUrep31P6/Uxz06hUh7SnqqyEzXWlvsmx6sCN6gGQhu7GUiWqq7VSPbzRliC8b/7ZMb0roROORzlGf+ONYVhYUnkcOuwJ3+GxqVK1e2GaWw7CKGpCIlwNuFAgA2DCkkQF5FbSYt8bVUyngX7ikz3+34OtiAf7W+cO3Lzo4DXpD8dz0AlsOMKum8bDLHBqD37czuOBzcwajZ7PmzsWWva/2CGj1KAFnEYo2O3zzBtHP2h6MYOngw1Gu4Zch69RC80hxQw0VMnou9NneVfT4acuEym7drs6dS78raDW+shCNVQLeCylCjSqZJjk7Ksmw5/ZQwkYFALtDA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 15:08:16.6510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd83dff-3210-48c2-1fa1-08deb293cb0d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR19MB9038
X-Proofpoint-GUID: 6Hus2Jrie2wjp2ObnFF6fqLwhaTpquTb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE1NCBTYWx0ZWRfXwIqnwP4fEpb7
 u61HtNMVq2OHuV9fgzqzxjCp5PBNdX6h2AsmeA5FYTbRWk0cm5I4QsB56E0JSuXWBNsc84ShQap
 Wy+cyXrxha1+gkeJeVG4+WJbeHizmZIeNoSe+QHoDvon/97CFJbDLit5oyG6TczhSTBfMFfLfyB
 Wb5KUDBTn87bxd7NpzDyZCzkHlOhTpF5bPl4YIVIQHrB+KKOmbnihmtJCzBNSHva6fz5Px/I/Dn
 GDHKO8H1E6mPFsVfglbcldD2nge6/N5/SNw2SYWUdlLlqy7gFfBw3jlBDvKk/EoZth0kDmoLkNE
 iwYfptjMJKhJjxCxGDOAfqUpIg599nVerRZ8e1+hxH8SoEousgCFmYfQYv+LgGvUgZzWst7uOpA
 Qa/QtA6Z0+hIgRsIjXaeBk0vej/zCm42e7zlr2TcKG4jvmwHS3Jqu1gCS76b1PXuU+C4jW10j1r
 e8lWGANxRMRc/L2F8NQ==
X-Proofpoint-ORIG-GUID: 6Hus2Jrie2wjp2ObnFF6fqLwhaTpquTb
X-Authority-Analysis: v=2.4 cv=aMHAb79m c=1 sm=1 tr=0 ts=6a0736e4 cx=c_pps
 a=DCeSEX+nBJmE/I7rcEuDsA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=w1d2syhTAAAA:8 a=pGLkceISAAAA:8 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
 a=h9f2Ul_0yR8z15jnxVAA:9 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Reason: safe
X-Rspamd-Queue-Id: 334A9551F6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cirrus.com,reject];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019,cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247815-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cirrus.com:email,cirrus.com:dkim,perex.cz:email,cirrus4.onmicrosoft.com:dkim];
	FREEMAIL_TO(0.00)[opensource.cirrus.com,gmail.com];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbinding@opensource.cirrus.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Hi,

> -----Original Message-----
> From: Charles Keepax <ckeepax@opensource.cirrus.com>
> Sent: Friday, May 15, 2026 11:12 AM
> To: C=E1ssio Gabriel <cassiogabrielcontato@gmail.com>
> Cc: David Rhodes <david.rhodes@cirrus.com>; Richard Fitzgerald
> <rf@opensource.cirrus.com>; Takashi Iwai <tiwai@suse.com>; Stefan =
Binding
> <sbinding@opensource.cirrus.com>; Vitaly Rodionov
> <vitalyr@opensource.cirrus.com>; Jaroslav Kysela <perex@perex.cz>; =
linux-
> sound@vger.kernel.org; patches@opensource.cirrus.com; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH RESEND] ALSA: hda/cs35l41: Fix firmware load work
> teardown
>=20
> On Mon, May 11, 2026 at 01:29:34AM -0300, C=E1ssio Gabriel wrote:
> > cs35l41_hda creates ALSA controls whose private data points at the
> > cs35l41_hda object. The firmware load control can also queue
> > fw_load_work.
> >
> > Those controls are not removed on component unbind, and device =
remove
> > only cancels fw_load_work through cs35l41_remove_dsp(). That helper =
is
> > skipped when halo_initialized is false. With firmware_autostart
> > disabled, a firmware load can be requested before the DSP has been
> > initialized. If the component or device is removed before the queued
> > work runs, the worker can run after teardown and dereference driver
> > state that is no longer valid.
> >
> > Track the created controls and remove them on unbind so no new =
control
> > callback can reach the driver data or queue more work. Then cancel
> > fw_load_work to drain any request that was already queued. Also =
cancel
> > the work unconditionally during device remove before runtime PM
teardown.
> >
> > Fixes: 47ceabd99a28 ("ALSA: hda: cs35l41: Support Firmware switching
> > and reloading")
> > Fixes: 4c870513fbb0 ("ALSA: hda: cs35l41: Add read-only ALSA control
> > for forced mute")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: C=E1ssio Gabriel <cassiogabrielcontato@gmail.com>
> > ---
> >  static bool cs35l41_dsm_supported(acpi_handle handle, unsigned int
> > commands) @@ -1522,6 +1550,10 @@ static void =
cs35l41_hda_unbind(struct
> device *dev, struct device *master, void *
> >  		device_link_remove(&cs35l41->codec->core.dev, cs35l41->dev);
> >  		unlock_system_sleep(sleep_flags);
> >  		memset(comp, 0, sizeof(*comp));
> > +
> > +		cs35l41_remove_controls(cs35l41);
> > +		cancel_work_sync(&cs35l41->fw_load_work);
> > +		cs35l41->codec =3D NULL;
>=20
> Hmm... are we sure the controls are actually still accessible from
user-space
> here? Feels like generally it would make more sense to make all the =
cards
> controls inaccessible before we start tearing the card down as a core
feature.
>=20
> Adding the cancel works looks very sensible.
>=20
> @Stefan, could you also please have a look.

I think this is fine to do, and I did some tests to make sure it =
doesn=92t
break anything.
Reviewed-by: Stefan Binding <sbinding@opensource.cirrus.com>

>=20
> Thanks,
> Charles



