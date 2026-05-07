Return-Path: <stable+bounces-244597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFkmG7K1/GnVSwAAu9opvQ
	(envelope-from <stable+bounces-244597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 17:54:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E120E4EB878
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8305430A61FB
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C744BCB8;
	Thu,  7 May 2026 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kxop64zZ"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB83C5546;
	Thu,  7 May 2026 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168850; cv=fail; b=DX+pC7Bk73z7ad1/X8FuwZs+JUnE/sYG3+qEp0O4iG9qTTpKoDgLSaPCsK+SbMGflae5UweypXnDzCRFaNwcUWfYhe0xSZmhl47EJ87iBT9tjqxMPJd6i97hnooE5Dq4wo7PO3wjVt+7346/wVpbfSigmFRNEbbJtEYYJhzuqNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168850; c=relaxed/simple;
	bh=EH8vBany5YWPtrEyxsFndMTTmY29E7hTcJ0bvp26ZeU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwC/PC5wI+HpxVQL62JXe+twtSe+B0vNd9Azii9byNwUG2x6QovbQfM2Qc/JcW053NebncLIsY8OjIbEEarpqXPNOoGYpkccFlUrbcD20AOScE/g2eNiWZPIlrQCYM2S+BsmseQ6XsWWy1OcDYLdn02BRUTck/fvMBjP8CsMXvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kxop64zZ; arc=fail smtp.client-ip=40.93.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8Sx+TWEcAgJ3u2KwIqdZnk+7plKe8JeYCRswHr4a3T0RdKv82vVyX6MaXghJZS6iU9PvMTinPoJI3HHRZsoKHtsV6FaoPUTIahHwW4N6E4dWU5OeJQzoqeagrhSDTLKE0z1g/8ZKicAZ8m6kHJN/+9QKHExNw170+HSwjwBSE92qbp8B+VIzinDAqqDCPVOUu4006uBbQO0RrbiJGwGQvtEQjHFfUGmIatJ0AXr8Xri8EEEPiBOpKosdHVcTUWmSxw7xqT3gX34Vrf3ulkaCC5liTrIP5JtAt+XDNZtjVl7iax26Jby4rWVYj3DLuNxy1hioVORfWx+FUzQIDorsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIf8QG+bbq23tN8htG23QGqiTALYTWmROeUahIonHqc=;
 b=rFwUElPyztXu7FOXs2L74iz/2NSFYWEmpSyDylf/6hfyAMiDhBwWQ8zzp6bJSGuv58fc2TxIUl7xXtVEIQhl7HYDvPQ/NSgzNFFPM/n4HpqLqwXHjZXVqh+P0kIxDFWXTUq28VpRYPub/+qvOcXIH4uVUIKRUf4GGB7ZMBHsnm7wims9t3GFLkAv0uFaWQ8a5Opd1s0OrRsaqqZDCfaiDjZIlB2xrSQlJArxm7SyOranSK7NreF1rFoA8OP9YiVh46NOsfe+IY1ZwnYZ0YDSfXpSji3wuwtFQZj/UxvBoCB2aCmYHHdBO/Zg8nLaSv7qgLReJzSu+nR75oYWEU8hXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIf8QG+bbq23tN8htG23QGqiTALYTWmROeUahIonHqc=;
 b=Kxop64zZ3JnJDITb+EiPOaT6ItVhJP3mjee92Ire0artch6tk5Ep3FyLqYS6KRYlzVkCjJ4+oOLRV71+HgPqb5M93kPclIheZIuKL5IfHS9DC40awPZDtb5tIiWzKwkAoRkU/1fxeppmQae80J0TxQx4gAtt/kV2o3zyu2Zz0JU=
Received: from DM6PR07CA0084.namprd07.prod.outlook.com (2603:10b6:5:337::17)
 by PH0PR10MB5793.namprd10.prod.outlook.com (2603:10b6:510:fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 15:47:25 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::a6) by DM6PR07CA0084.outlook.office365.com
 (2603:10b6:5:337::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 15:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:47:23 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 10:47:05 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 10:47:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 7 May 2026 10:47:05 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 647Fl5cb3946841;
	Thu, 7 May 2026 10:47:05 -0500
Date: Thu, 7 May 2026 10:47:05 -0500
From: Nishanth Menon <nm@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Josua Mayer <josua@solid-run.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"kristo@kernel.org" <kristo@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "w.egorov@phytec.de" <w.egorov@phytec.de>,
	"matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
	"d.haller@phytec.de" <d.haller@phytec.de>, "francesco.dolcini@toradex.com"
	<francesco.dolcini@toradex.com>, "joao.goncalves@toradex.com"
	<joao.goncalves@toradex.com>, "emanuele.ghidoli@toradex.com"
	<emanuele.ghidoli@toradex.com>, "ernest.vanhoecke@toradex.com"
	<ernest.vanhoecke@toradex.com>, "rogerq@kernel.org" <rogerq@kernel.org>,
	"eballetb@redhat.com" <eballetb@redhat.com>, "robertcnelson@gmail.com"
	<robertcnelson@gmail.com>, "afd@ti.com" <afd@ti.com>, "u-kumar1@ti.com"
	<u-kumar1@ti.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "luis.parga@ti.com"
	<luis.parga@ti.com>, "srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH v2 01/13] arm64: dts: ti: k3-am642-hummingboard-t: fix
 USB clocking for compliance
Message-ID: <20260507154705.oisyadsyrrvv53qj@upriver>
References: <20260506141040.1368918-1-s-vadapalli@ti.com>
 <20260506141040.1368918-2-s-vadapalli@ti.com>
 <c5c8a3a0-c8c3-448c-83a6-99ffe3e6ef11@solid-run.com>
 <440c9069-b8dc-4dba-9dca-3a6c94bfd52e@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <440c9069-b8dc-4dba-9dca-3a6c94bfd52e@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH0PR10MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 8409058c-fa61-4a3b-ba73-08deac4fee85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zhrWn/paEoR/A4tmTJZBEb01Rn7UlSt2wOFxv18Wt4mjCT2R+QLw2GNcVLLzKhbeCuIrk0TZuZj3vm5NThb7I+d4s8FByJJd6SQwq7+naIWngnMnaRANSfe/SSCePIuwqFJkvEfQ5UNkwV0ZHVk7ZLR8C731vLkU5jmRtKqnck0PneU2X8Dc8cLbf1XNgzaVWDcRImSyndjz1jynDRlS5CafaTx6IaWgTJ3imhtd7GcVe16fwSfbpXbEx5NDrz9usJ+w9Nvz+DFYWpuN6T84LkdmFFdYaIbeh4HXceLUhKdP+qP6vngDubKTPjj2MK7ndJh4WUKBK3tIqTiJLZh6yl4Fpb50fg3Fu4ddUYdZ27A5OQDThg/SfWGAosxDKv1Hd2cI3mL0iPJ0AQthIFB++4vHA3F01YnMd4MQRU0yvP7XtPEC+35mANsqt/MfSiFbMkbH4IObq/coxloDgGiR5dJLcmB0asIyBEwHepx8BkcJTf7U0mK6MpXgRuR65rewBzcl4ZLYRYkmfrpyvwVmiHo/KzFILA5mfHQzVSUDFtEwVBDdQ+w/pdiSjsNwT4OBotz4YVCCqRYRRf8ZX5NClXnFcz1ogkqeIozfpB3tlOSe5Mh0zfzLUpqF4dVLVMZL6pd3LvJ7I77O/+Db2JGhKOyR+842ZVPiAlI/6qj9uDhd1pJRD/d1YhGFwytgFPE1YyCWHhGouFcCA7Mo9bBRFxpDkwLV8P45AFK1R7Pif14=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PipU7+bKk2ETqW/q4lBSBJOYU9OYeQ1BeVfJhQ6p1qAsMjfwU/TkNGVGLUloDEt+BnfrerBGySDKaGkjmPoPzhek3MuGwPT6XrkpitxAtfgzvgWeUPOSt39ntrVkOr22gttG0vA+xWzB7B27vLNsWfGKMLcTfVzBVCiyMOLApYiuGfsKMc35PtuugLJx18iqCEEbEGSh+jUld3LZ4sWleaWeuWexOzehRIXb8hDWGHfq3N5VitwW6EiTREueKrtt3uNsIkzxHThDcYiFjzi7/s/SXiBQlL9xwCLtSQIhyYAB1YKHdAh7VCForC7t53M53sq/K0uoUA0KWLy34zkjW5s9E65wssB1/nxoNR4hyhETTUAlhHAFHHU1q/fHZkeax90IdR3QF28f59aM/W1lQ4jZTjWT8mJZA23qCyafRtr5JBXlyEeQBeqaau5iZ9PQ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:47:23.6303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8409058c-fa61-4a3b-ba73-08deac4fee85
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5793
X-Rspamd-Queue-Id: E120E4EB878
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244597-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:url,ti.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[solid-run.com,ti.com,kernel.org,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nm@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 12:09-20260507, Siddharth Vadapalli wrote:
> On 06/05/26 19:47, Josua Mayer wrote:
> > Am 06.05.26 um 16:09 schrieb Siddharth Vadapalli:
> > > According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
> > > the USB 3.2 Specification, SSC should be enabled by default. This protects
> > > against EMI violations. Hence, enable internal SSC for USB SuperSpeed.
> > > 
> > > Fixes: e2b691804319 ("arm64: dts: ti: k3-am642-hummingboard-t: Convert overlay to board dts")
> > > Fixes: bbef42084cc1 ("arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > Acked-by: Josua Mayer <josua@solid-run.com>
> > 
> > Your (submitter) Signed-off should always be last.
> 
> I see both patterns in git log (Acked-by before Signed-off-by and Acked-by
> after Signed-off-by) for arch/arm64/boot/dts. When posting the v2 patch, I
> looked at a commit with Acked-by following a Signed-off-by and followed the
> sequence.

Documentation/process/maintainer-tip.rst,
Documentation/process/submitting-patches.rst etc.. Signed-off-by is the
last in the chain - always the handling order is maintained.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

