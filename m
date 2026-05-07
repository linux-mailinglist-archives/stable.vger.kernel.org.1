Return-Path: <stable+bounces-244514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNN3ANY1/GmNMgAAu9opvQ
	(envelope-from <stable+bounces-244514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 08:48:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EED334E3AFD
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 08:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 965CA301D118
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 06:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78D133F8C6;
	Thu,  7 May 2026 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VbHRXBhX"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590A306B3D;
	Thu,  7 May 2026 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778136195; cv=fail; b=Ce5Q4m4GEMPQ/AGZPwrDaXdBUPhFoZ1+4hv3kFXrspaBHE2RqzZZmCwrnrHEDHTKvGWaz6bEFQfEPO/CR+rH5GNjwJCHaopLqdst7LkVLmFFZuuZt5D6L+iYZU7O2dv937ScAYuKQI9VMeBV8Q5H8k7HcFZyOc8dxwDI1undmZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778136195; c=relaxed/simple;
	bh=13ec2EmJHXF/I8t5p3xORaWAtRnRKkzl1Dpm0Aj1L3o=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kklR4bZUDEaochhMNAVsEd/H1sSfMsxpDlLMIdPEwC+9pbT74cwVg2BrbVI65+Jxyvkf674B1ySXBY5/WGQNt1qsY4oStAfpgLH/YjisoEiZW8JdOX//4QNtJUChQL9NEk6EgTuR0FdV7XXiUBX/vUzsR+J2HK2AucPaM5WgYbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VbHRXBhX; arc=fail smtp.client-ip=40.93.196.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whp4j6PBjQnXTqwayMZOYwv6YrejVHOKKQV/KeY3OTjjfkU1nQGytSNXgnqM2bewHogJFTgfilKdrYwNzsItyxZ2R4N13iIFKJKyn7mblMQp3riVyNPyq5xR4ysCZhYezxauBaKfLROZglQV80RMsxSvOVVl1IqXHBV1/u37D34AImGOe3bo9TQnJjp+WQbXVDspEU97NultoTCX0LQeoynwACzen4lYjPADLzSbkMeepGxYMeeaOF7znjs+VOoXBBO/UQAoVuPMU5Ac38nPzcCyM0nypBhPaiohPiHBUtFmY5+ZFsC/c3f63aqfudxFahfqLkjXfwzbfHpOHZmNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcLXfRMQ54xaiyn43vuBNcaRUgH8B5wO/afem3+pyAI=;
 b=MFIQgVM8/xcWC1qCsoFsKPvgqZXvtYz3U7Lx9cmKxm+5pB5mp26bIYKWw5cVLaofzQcMc8XRPGD4fMRYNdAp3aKB47cHvkCePDvfB5GQpd/qZSGfALcTwTc5aiVLue8PrB6JysJ/O2weGKF3EdXxLoR5G2wKsrLBjmJcUHnAnN25NzHR72hUuKufz23cXHzpGB3ZacFXeTj+oN4CrP5EJj1RkvssLBupJKiiojxrzrTxVg+tO9MwRq0d3abqt/5UT2ZH/IQ9V2gN/LmVEgsQgfOVU/36JKVYUPXOp/RyDUxAsv6InmQ9aX/OdILmKVnqrzxk96LvA5kwFDGWZI9h6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcLXfRMQ54xaiyn43vuBNcaRUgH8B5wO/afem3+pyAI=;
 b=VbHRXBhXWgaT5dV58/KwptODsxMrV0fG65aobx+HYZCRZXnwyFCecj5czrVhRym5Payo1wWCXHrqNTTOs/sau6L4d5XAsCNOQBJ5pSd1ih4gbIz/Q4Y86a2hya2KuCnJV2j41ejRIubh3xxGoe2InrDjOmM93qizOfpb/q+3CDw=
Received: from MW4PR04CA0205.namprd04.prod.outlook.com (2603:10b6:303:86::30)
 by MN2PR10MB4285.namprd10.prod.outlook.com (2603:10b6:208:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 06:43:11 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::e3) by MW4PR04CA0205.outlook.office365.com
 (2603:10b6:303:86::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Thu,
 7 May 2026 06:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 06:43:09 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 01:42:39 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 01:42:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 7 May 2026 01:42:39 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6476gWb42748265;
	Thu, 7 May 2026 01:42:33 -0500
Message-ID: <0e9e5de7-b456-4da3-8165-8ed7d66f2671@ti.com>
Date: Thu, 7 May 2026 12:14:54 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <josua@solid-run.com>,
	<w.egorov@phytec.de>, <matthias.schiffer@ew.tq-group.com>,
	<d.haller@phytec.de>, <francesco.dolcini@toradex.com>,
	<joao.goncalves@toradex.com>, <emanuele.ghidoli@toradex.com>,
	<ernest.vanhoecke@toradex.com>, <rogerq@kernel.org>, <eballetb@redhat.com>,
	<afd@ti.com>, <u-kumar1@ti.com>, <stable@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <luis.parga@ti.com>, <srk@ti.com>,
	<s-vadapalli@ti.com>
Subject: Re: [PATCH v2 00/13] TI: K3 DTS: fix USB Clocking for Compliance
To: Robert Nelson <robertcnelson@gmail.com>
References: <20260506141040.1368918-1-s-vadapalli@ti.com>
 <CAOCHtYjJRmr5LhRePqaOomjVHb=o+B8-3+6BN89Xx9erwRdcng@mail.gmail.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <CAOCHtYjJRmr5LhRePqaOomjVHb=o+B8-3+6BN89Xx9erwRdcng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|MN2PR10MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: b57c1583-1a48-4f65-ef17-08deac03e714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	VPgp6hkrCuRs2eTPt2pVzdF/efsyJAs2KaBfRp7nb5b+l+FC4md2tfxoe63K/MRZJ4kJlvUbz+q5/GaCtY5BOXu2XxnbsonlOi8krmVuCmk2TRTlpmySRMr6/SJuQuZUvA60m1fOsQU/ZDv/YtGLnl6qtRXalt7QaoTcdwDwr4GC00kSde6cCMeOjF1qtBqTdxwTRTNmha8OumFCBlvKxHLoGIOIZg2pXEtCam5pPPL/efZHEUjmZMyM1ZJ//kLSJjnUOTlO1qxjVG/w+Q9twYuYEGwB3fyAw/rjnGeT/mmX9qWE+ncw1VqX1FNpEe/P+mqzn5kziWL56cjoPoPtMCx+b/I8bA41jUYcPCETdmpNgov4eVxeDK+d7jP5r1C7yWuV2Qz880RoLYmu1VNbUvSN2ux67IS2SDQn4W8Xg0wrf1at1ry6OGQOgDOlA7xqAT+HBsRd5IhE5NSH6qrLk2hdPaEeVv/5Hf78kfAVEG5La+bKeZ0QXLo94cMwYeXMj2DqL9CEXAyIPwb63r6hJendkT6MZug0fzfx0kN8X5QqG5fJbCH5ZkwKJetffI7xJLl4LoQNez4VpwrhVrNnH84Hsjz5v+RvygR+OFLp59dlxCw4wlYXYkNyLwdPcIN0ZEH7cVUDmWiilMiibIcbpt3wJF/8Nci38o4ZlIKYjfZDm6DqBS35TBKGPdLAnVTcFNR5r2A2ldKRA1f/goiw//Ir7iizOzmkSoOc6VLCAu0=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5vQ9I7WxB+D4N+OUU1eVyV4ouxqKszoo2qSGi3OUuAgtdXsTEfVQ+pYAxiM/XST/Omx2Vm8JEv7SYKmpT7OBgWzC1pnUUw8R2PDnaYeGlFvxBTOjgWYJIqvE5gD8j+TMVYdjgSPzb7jzWsJd1hDtIJvF9trIdSX9ZvzUuYyQ/c870MtgsUctqPS1tDVmYFATv9X6SzF7AjbEoJ+PNvE05aKqfhw31yyXxLzJOSPd7dbi/vmviltEOri02jArL8sXMHXRbdaemDFPj/rML4GCSNorwoo1x9oBQmzuFb5ImpNm1QCPEam3U9GznlQos01LUjEJ6jArW8wDqdU6Hl/A0lyiIl83bpvLkVX4faqE6xdO0HP9lv6OANF7lTClIs3iyOG0kDlccueIK8+kD6jMjc5HefZYz7NnYYElJboMu5nNd0TjPZyETzOqqulco7zo
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:43:09.3766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57c1583-1a48-4f65-ef17-08deac03e714
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4285
X-Rspamd-Queue-Id: EED334E3AFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244514-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:email,ti.com:mid,ti.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 06/05/26 22:37, Robert Nelson wrote:
> On Wed, May 6, 2026 at 9:08 AM Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
>>
>> Hello,
>>
>> This series enables Internal Spread Spectrum Clocking (SSC) for USB
>> SuperSpeed configuration. This is mandated by the USB Specification
>> section 6.5.3 Normative Spread Spectrum Clocking (SSC).
>>
>> Series has been posted as individual patches for respective boards since
>> the Fixes tag is different for each board and needs to be backported via
>> stable.
> 
> While yes, that's true for stable branches.  Since these are so
> similar, wouldn't it be best to push them to the board soc family
> headers?

I see individual patches per board+SoC combination for new features as 
well. So having individual patches for Fixes seems to be preferred given 
that squashing all Fixes tags into a single patch doesn't make it easy for 
backporting and reverting in case of issues is also easier for individual 
patches.

> 
> (Either way, I'll be backporting these for Beagle. ;) )

Thank you.

Regards,
Siddharth.

