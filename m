Return-Path: <stable+bounces-244599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ4ENN28/GnSTAAAu9opvQ
	(envelope-from <stable+bounces-244599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:25:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCBD4EC274
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEE9E300D1C6
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA83E8C66;
	Thu,  7 May 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PjS2d1Sk"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5D3EBF3D;
	Thu,  7 May 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171098; cv=fail; b=H/kZpXhAhKt02HWpCaCyWm8Lwd81oEXALTT0gd7NDls2uanMxw6jlbZlhFe3aX0TdcNaAKwMeeON+g3VYjKlbqEtRiU+Ad+cPlibUYvb96T/Xz8LVdFU5429kzlCbLsR9frLDsNDOYxCTB/qQhuztA44pFCAI70ORaBlegiiHa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171098; c=relaxed/simple;
	bh=FJFGyO7mS4fqvi4o4LGwAp693/HzFFXKoMQ0r/2D2Iw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejZrp6QHxDq1j+N1Cw5jz9gBdlJU6xiMz42JY1dlHE1BNLeIiNrBOBU34XmtNZ5yJ+uP+k42m29qfDse1aVr0uKdgOrPjGda3Owv/OQNScdKSm/WDLazl6XW5zotraOOt99RHpBeT3NN0y25ee0JEmgp2sQp1EHHl+ZRwJg/Cjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PjS2d1Sk; arc=fail smtp.client-ip=40.93.194.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9ufJ0FeZVT4USO/6agO54tw9W2RDpX4D0Ov3fZaB3Mu79qj6oLfUcn3kmMzDOOZ6Rtw1ZDlJufh5kBBJTzNeSwOP+VdZZ5suwkM5QRiqC4sq8IJXAGownbHldlFjBx+taaPYdWGF0KoAvt0+GX/9abQgk6xJN0YpCpPKpsMfFZMgfu/f646KAkQyyXv2D8mGPsstlG/7U2cIxGoEIRl+wZVwqXhDjeeqRO69Z+en4YTwDHNf/3ASotI53Sf9cUygKxtLibQCgR6YKFt4GXD5r7XlFsgyzhGSSggNKI7QtuUB13VM94FCgykSC8pRzWkkaDn9JeApeU1SaUujkNkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPbvqkMkyl8IIfwvHm4w26t3ijArL6JLAL2F+VP2PLs=;
 b=XK8gfHEFNTqbYacbP1bHiYuZVjRwjjNRWDjGxH+JvgN0Y1kDE6OvNlx2ubSLgdOxo44wtXQuGbzQWDauVAP2gd/Mtl5/+Z4sfz4sPXXCy1SowlV3TYN1zMYvX6oRU/+sy2JwXHnxsG2OdTlbiZbTMHeF2q9dSDtrMLbO72SloUieg1C//FgkxnH6vHo7CcZDmzIzWKmaaYe+POE2hzFAxSX9y1YIAMzzaNTd5VnlhDfeZxeOJxJHL945h3SUrF/UK0vjdqLU9Bt+X50R+cYOhDr+DS1BnYEhQcglmk7qnuRVt+B2nes9mggwHV65tOuJX3dSyXnUkDdgHbTf05QFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPbvqkMkyl8IIfwvHm4w26t3ijArL6JLAL2F+VP2PLs=;
 b=PjS2d1SkiElts2dOEKu+p7eY1jIlt2atrn5MKRWSD/TEL01w7RBjf0576Zu0araBw8njpmnRrQ8wrptLNUk8mkmrya+uEWdTH0k0k+Y0k0pXTF0wOWdZ9Gx6fNXoK/JuTMgBw6NNiYEl1zHMTYPv1Az8or8giob6zgWHiCC50oE=
Received: from CH0PR03CA0291.namprd03.prod.outlook.com (2603:10b6:610:e6::26)
 by DM6PR10MB4156.namprd10.prod.outlook.com (2603:10b6:5:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 16:24:51 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:e6:cafe::d5) by CH0PR03CA0291.outlook.office365.com
 (2603:10b6:610:e6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 16:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Thu, 7 May 2026 16:24:50 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 11:24:43 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 11:24:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 7 May 2026 11:24:43 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 647GOhim3698375;
	Thu, 7 May 2026 11:24:43 -0500
Date: Thu, 7 May 2026 11:24:43 -0500
From: Nishanth Menon <nm@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <josua@solid-run.com>,
	<w.egorov@phytec.de>, <matthias.schiffer@ew.tq-group.com>,
	<d.haller@phytec.de>, <francesco.dolcini@toradex.com>,
	<joao.goncalves@toradex.com>, <emanuele.ghidoli@toradex.com>,
	<ernest.vanhoecke@toradex.com>, <rogerq@kernel.org>, <eballetb@redhat.com>,
	<robertcnelson@gmail.com>, <afd@ti.com>, <u-kumar1@ti.com>,
	<stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<luis.parga@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v2 00/13] TI: K3 DTS: fix USB Clocking for Compliance
Message-ID: <20260507162443.taj7ijqkmfy7omac@chalice>
References: <20260506141040.1368918-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260506141040.1368918-1-s-vadapalli@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DM6PR10MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: bf08a749-de34-48d8-0fcd-08deac5529c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xG7iNYNEGQVz5HVBFpyF8nd9iCRsura3XmgfysoxJMBXHkhh/yaVKOaRRh6RWjUmcuoP/h3xWTMkaF9TxD6PN5RDvnFB3JZa4CW5DdntHEqStbnn3jz4LvwzbQP57OgcOeIbAubrABnEoEinwBwxgoDyXgR6yV2/oHvDh8BuZslrQflQH3DohOCsOqxjceEsG0z3a++oM8DSUcU9hglXIqkiQaggeIcjax1psgoKaWdhrOIJiGBZxacJJ7xfARvT3wqJy5W0IrDAv4MVNUcl3TELnDqlNPD56z5x6ltwjBC5tKmMicLOv5rk9ZfTBN8Vb2P/9FJvhp0HZW28EOltEH0CSRjHzeTE9UObb1x6DbkbyoSLqjWGyNsekHLp0M5GFe6OBofHm/r3X1Nv47wfPnl5sxmgiq0i5YmONjhYBt/iX5o8Pw0AOgwt/eZrnKCORkxfqdGqxhUSxOjxLVTsQ4yYnHkn2b2gGhRn/MA8WK1pKCdmCd6MCbRL2EpT5LcL6bnkZgItiAGTt4lDWTu+g20rIXaHGhwMcfrnDQczKjHCakjsaab1Glkfd2aFTq6+HrjyXfpOW/EtNOTpxlk4KgbMkLgJlsCfgtq4MPjFzhff4mHfKv29WkTbeyx7pWRz8qUJUxAdwrBwrAZd7FoOHhTe9/KNUc3ocZvlcM6tTnGqmynzoMuVI0sL/e5TMvE3kUmacERCU2TMnJ57LeZsKgmK4WAkqj+ZUB+vDchq3Kg=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jQDPgoGNg3SxEqABVKqUFMy0ajtPPYE5vFWAPnxw4CI2r87ALxG6UaD0DJw7ewFOsdA7bnl5C/TTR+eWqFuxuEb0O4y0mlH/heQuB17zCu18ezOgPgygON3nmaOnqYuUL7Kt1gbmXirZu1H8iRWlSx0oD519ak5RNF1+ZvUZmKEhSgp8t21cRSmCWFiQKXhwYKrI1qE+ue4P/FXqjMVhHw1i1z4pY+q1CajsCsvOx0uO7L2KyvcYGdL0x6tu0FpNp7SLkRtdmzAP61oFC2a3FseKOEsGXqX3h9cT+ZOzUlHbd9wboZ/pgxwj0sc9xM5yH6JGBnDV2ur3U8nCVl5y9zzCm3RA0L28qsvn17mdJ0kLEw089lCvu9qVRKhmat1ODHPA48Tw1XZIw6Ssb+iZF/OeD4XrEplAI2mDBMcccMy0JxuCK/OKwdJULQIo8Vod
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:24:50.4916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf08a749-de34-48d8-0fcd-08deac5529c0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4156
X-Rspamd-Queue-Id: 7DCBD4EC274
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244599-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nm@ti.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[stable,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 19:39-20260506, Siddharth Vadapalli wrote:
> Hello,
> 
> This series enables Internal Spread Spectrum Clocking (SSC) for USB
> SuperSpeed configuration. This is mandated by the USB Specification
> section 6.5.3 Normative Spread Spectrum Clocking (SSC).
> 
> Series has been posted as individual patches for respective boards since
> the Fixes tag is different for each board and needs to be backported via
> stable.
> 
> Series is based on commit
> 74fe02ce122a Merge tag 'wq-for-7.1-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq
> of Mainline Linux.

I am on next-20260507
The serdes_wiz0 node here is bound by ti,phy-j721e-wiz.yaml (the node
uses compatible = "ti,am64-wiz-10g").  That binding has
additionalProperties: false and does not define ti,core-clk-sel,
ti,ssc-enable, ti,ssc-type, ti,ssc-frequency-hz, or
ti,ssc-depth-per-mil.
I see
arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtb: wiz@f000000 (ti,am64-wiz-10g): 'ti,core-clk-sel', 'ti,ssc-depth-per-mil', 'ti,ssc-enable', 'ti,ssc-frequency-hz', 'ti,ssc-type' do not match any of the regexes: '^cmn-refclk1?-dig-div$', '^pinctrl-[0-9]+$', '^pll[0|1]-refclk$', '^serdes@[0-9a-f]+$'

and so on..

How does this series pass dtbs_check?

> 
> v1 of this series is at:
> https://lore.kernel.org/r/20260505110631.1144200-1-s-vadapalli@ti.com/
> Changes since v1:
> - Collected Acked-by tag on patch 1 from Josua Mayer <josua@solid-run.com>
> - Reordered properties in patches 7, 8, 12 and 13 to have 'status' at the
>   end of the node based on feedback from Francesco Dolcini <francesco@dolcini.it>
> 
> Series has been tested on the following boards:
> 1. AM642-SK
> https://gist.github.com/Siddharth-Vadapalli-at-TI/d4aecc572697bd02bb65a0fe5efea393
> 2. AM68-SK-Baseboard
> https://gist.github.com/Siddharth-Vadapalli-at-TI/371aacaada2b236776455be5fa15e593
> 3. AM69-SK
> https://gist.github.com/Siddharth-Vadapalli-at-TI/1d7c6c3a5cbe6ec2bc966887c3e4d913
> 4. J721E-Common-Processor-Board
> https://gist.github.com/Siddharth-Vadapalli-at-TI/f815f1a9b400ba492133e43c36f69936
> 5. J721E-SK
> https://gist.github.com/Siddharth-Vadapalli-at-TI/0d1e4e72b47ab1482b5b7d1247bc8bfa
> 6. J722S-EVM
> https://gist.github.com/Siddharth-Vadapalli-at-TI/146533f0a89bde59b47ead582a924e62
> 7. J742S2-EVM
> https://gist.github.com/Siddharth-Vadapalli-at-TI/be8ed3e339441b7301f57ad006868238
> 8. J784S4-EVM
> https://gist.github.com/Siddharth-Vadapalli-at-TI/62795430857387491162b21d9c9692d0
> 
> Regards,
> Siddharth.
> 
> Luis Parga (2):
>   arm64: dts: ti: k3-am642-sk: fix USB clocking for compliance
>   arm64: dts: ti: k3-j722s-evm: fix USB clocking for compliance
> 
> Siddharth Vadapalli (11):
>   arm64: dts: ti: k3-am642-hummingboard-t: fix USB clocking for
>     compliance
>   arm64: dts: ti: k3-am642-phyboard-electra-rdk: fix USB clocking for
>     compliance
>   arm64: dts: ti: k3-am642-tqma64xxl: fix USB clocking for compliance
>   arm64: dts: ti: k3-am68-phyboard-izar: fix USB clocking for compliance
>   arm64: dts: ti: k3-am68-sk-baseboard: fix USB clocking for compliance
>   arm64: dts: ti: k3-am69-aquila: fix USB clocking for compliance
>   arm64: dts: ti: k3-am69-sk: fix USB clocking for compliance
>   arm64: dts: ti: k3-j721e-beagleboneai64: fix USB clocking for
>     compliance
>   arm64: dts: ti: k3-j721e-common-proc-board: fix USB clocking for
>     compliance
>   arm64: dts: ti: k3-j721e-sk: fix USB clocking for compliance
>   arm64: dts: ti: k3-j784s4-j742s2-evm-common: fix USB clocking for
>     compliance
> 
>  .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dts  |  9 +++++++++
>  .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts |  9 +++++++++
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts            |  6 ++++++
>  .../boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts   |  9 +++++++++
>  arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts  |  9 +++++++++
>  arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts  |  9 +++++++++
>  arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi        |  6 ++++++
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts             |  6 ++++++
>  .../arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 15 +++++++++++++++
>  .../boot/dts/ti/k3-j721e-common-proc-board.dts    |  6 ++++++
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts            | 15 +++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts           |  6 ++++++
>  .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi  |  6 ++++++
>  13 files changed, 111 insertions(+)
> 
> -- 
> 2.51.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

