Return-Path: <stable+bounces-244408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKWcKkBR+2mSZQMAu9opvQ
	(envelope-from <stable+bounces-244408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:33:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CE4DC43B
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C563C30C8F3B
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A405943DA3B;
	Wed,  6 May 2026 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="lX/GJecd";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="lX/GJecd"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023090.outbound.protection.outlook.com [52.101.72.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFC82475E3;
	Wed,  6 May 2026 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.90
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077091; cv=fail; b=FjDwnz/vCWLS/ae76fLCUnRomBCiZDOYFWz/RCpBO+AFPokl//GBPt6XFcGUkE058D/oBd47hiekiWaPKmC87wIvdfBNXhuErFrVCyHlDXL3h7VaV6sn91XNPcEeOFcWcgMPgQjim//lwdiLq2TfKwwhMCKm+7iXmCtj/iPCkwE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077091; c=relaxed/simple;
	bh=sF0DeOyBq5zqX6Xpd/5aoa+6PnsbId/t2QyJ47XRGu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TSOTioHbWWXpVf9adIJ0Ci4P5jwXKYiOnSLJvH3inkgvXYTV2YlEiV9zmNNu1YRs2DWIvnDB21Hm8/1gAgvc5gvUrj3lX0L+STWlGRmbU/1L+zdmsRwXaZLndBmM/qmxnEMgfW5Gr6Nf1yAfnlOdF62VVFLXuaohKXU2B450sdA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=lX/GJecd; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=lX/GJecd; arc=fail smtp.client-ip=52.101.72.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XgphOw4JABIuVDlJHDzELXKY4kVPpvKTkBrDGPWVeLexzfHF4KKEKSqb5CNnJqD1ez5aEdWJ6NjWC+CLGBX8Jfk1LXrMXanHXw2apB7uf8A3DAs77aLTM3EacNHC5ElvpC8b24SzlZ1kh1D1r2XGK9JyGmdgfbkMhHxQ1pYSWYkZ/a1Vu12Am4VZ2brUUkhWXOVa1zy+wN8+gWmBwIU/gRqmMexWCC3vFzJhkxpJckdrFRie6OrCMJDVUOcJZc/vaLtfhKEjbFHw5F0EE0OAGoEmNEhx16ZvxCdTB4jxjEFCVRswcAAYnCjYGGPF/K3Q7CiG2FKKtSV9YRnJDbYbHQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF0DeOyBq5zqX6Xpd/5aoa+6PnsbId/t2QyJ47XRGu0=;
 b=JZ0/wmfZYDEdmPeNmFs1insPNULN0EiiAXQi3a36Pq5620JEL/OYyaAkwsoIbAebKN3jhVSQ4uD8aBVVyFaB1njURG0nbxdkq7sPc2n02em8vTNc2Iw63uUseuL1PNiCSK0PkRJLk4F+wEwbk1+NCcDnD1dSfPIqR1fTi2NkXrSVWLek743tZNhGTov0l4pAQnj43+ye+XwCzmuUkb0IPq0Su/mAhjwwldmxeaiEZp3Hqyr8/SVcfx12YE3k/SloBp07xVLWjQ4PabBdrjbkx8+KB+f9sgvyecvitcpSSglOwNTC71MOHKcPVaQAxnQGohNOMFnruUAloUZTOfYyiA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=solid-run.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=solid-run.com] dkim=[1,1,header.d=solid-run.com]
 dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF0DeOyBq5zqX6Xpd/5aoa+6PnsbId/t2QyJ47XRGu0=;
 b=lX/GJecd0FkK8CT5ZL1MWPiHrpj7LVt93SZzUnmtz8lypmklAbdNmPYhi9S8ZEjKuHZMWFDVdZsefdXi7/JzzJ6xRWL9FmFf6fAbXtOWZ1Z1SCtBRIhBNtFmV30Xk++o23p6uPCPNLJv3SryK0ChBQbQnwEBxnIy/jwzB3xt8GTvvKTwxyQdQil9/JfPxFPkr879MfKE5vdvAqNuupzbR2HAkNLFICodH1hKChX0p61PHCsMNSgng6w8mDhcJHgBFf2drZIvjz3cO0vVUEK0/NdrIZLov62UVC0X8Fdr667/wysv0ozDyr49YVmGz3ML3sUsAMwboFF+NGc3SFxA+Q==
Received: from CWLP265CA0496.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::17)
 by GV4PR04MB11775.eurprd04.prod.outlook.com (2603:10a6:150:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:17:59 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:400:18b:cafe::36) by CWLP265CA0496.outlook.office365.com
 (2603:10a6:400:18b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 14:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Wed, 6 May 2026 14:17:59 +0000
Received: from emails-7917932-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-143.eu-west-1.compute.internal [10.20.6.143])
	by mta-outgoing-dlp-305-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 4950B7FDDA;
	Wed,  6 May 2026 14:17:59 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed May  6 14:17:45 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAom1Z7JZbl7jM/qINVlJ8sQD/B8vl3QUKluOSeWS3e7L+E2krjNrLzCOjP7UlNy1euVYWHRZANipuEbARl60hml3qSWiTIdiVv5IYeUEaUuoeVK+k0i8JD16gmnx53lFJ5aNkx9HyaEzq8OmVKAUihuy/Nx3XFLEE8IsfgAAlp5M4w9vHTjG1ufZx5QmrZqdncjKSxFGg+4JxGblUQKSxu82LpaqKtbZLuN/hpDnzL9zZAtOdumN/H63IuXOZleJBkI9tXeT6WqPdzPwwUh1ea96nAvdgDB2D8Q/PZLNzAxIlJid0QpZp2HQgtxEwsxQCPH5bH2M0cc447ZjmqwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF0DeOyBq5zqX6Xpd/5aoa+6PnsbId/t2QyJ47XRGu0=;
 b=t9q4W3BL0e4qKFMjAcnYdJWHhLAg0uE0ceVQhpKwkUsOFN+0U0IjdFGNmURY8QesjmCk34IlOeWzGY6LfLJID8c0SIVyFpj/WcDeHXTp57zFGr9mxblU75EL6iypMuSgeyrLLVZH7B4RR5r1wIUIFh/fRk7PdLdTQ+ipFDDz7wuX0LysD5O1V/dIWdWD/dALZQsv6dzPv4KyuW2bztGQsMHEua8tZcmRsnKVR2HEug0HFZaAzAlHdOI+O23EJsa79HUI2WdKJRe4WKrAR05BQ+UzpcTY4d3XK8ZZM2OsiThthOLGCOobfsDj+sa26MIOE5md7f5Qy4Qd1f9d903X4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF0DeOyBq5zqX6Xpd/5aoa+6PnsbId/t2QyJ47XRGu0=;
 b=lX/GJecd0FkK8CT5ZL1MWPiHrpj7LVt93SZzUnmtz8lypmklAbdNmPYhi9S8ZEjKuHZMWFDVdZsefdXi7/JzzJ6xRWL9FmFf6fAbXtOWZ1Z1SCtBRIhBNtFmV30Xk++o23p6uPCPNLJv3SryK0ChBQbQnwEBxnIy/jwzB3xt8GTvvKTwxyQdQil9/JfPxFPkr879MfKE5vdvAqNuupzbR2HAkNLFICodH1hKChX0p61PHCsMNSgng6w8mDhcJHgBFf2drZIvjz3cO0vVUEK0/NdrIZLov62UVC0X8Fdr667/wysv0ozDyr49YVmGz3ML3sUsAMwboFF+NGc3SFxA+Q==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by GVXPR04MB12127.eurprd04.prod.outlook.com
 (2603:10a6:150:313::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:17:42 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%7]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 14:17:42 +0000
From: Josua Mayer <josua@solid-run.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, "nm@ti.com" <nm@ti.com>,
	"vigneshr@ti.com" <vigneshr@ti.com>, "kristo@kernel.org" <kristo@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"w.egorov@phytec.de" <w.egorov@phytec.de>,
	"matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
	"d.haller@phytec.de" <d.haller@phytec.de>, "francesco.dolcini@toradex.com"
	<francesco.dolcini@toradex.com>, "joao.goncalves@toradex.com"
	<joao.goncalves@toradex.com>, "emanuele.ghidoli@toradex.com"
	<emanuele.ghidoli@toradex.com>, "ernest.vanhoecke@toradex.com"
	<ernest.vanhoecke@toradex.com>, "rogerq@kernel.org" <rogerq@kernel.org>,
	"eballetb@redhat.com" <eballetb@redhat.com>, "robertcnelson@gmail.com"
	<robertcnelson@gmail.com>, "afd@ti.com" <afd@ti.com>, "u-kumar1@ti.com"
	<u-kumar1@ti.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "luis.parga@ti.com"
	<luis.parga@ti.com>, "srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH v2 01/13] arm64: dts: ti: k3-am642-hummingboard-t: fix USB
 clocking for compliance
Thread-Topic: [PATCH v2 01/13] arm64: dts: ti: k3-am642-hummingboard-t: fix
 USB clocking for compliance
Thread-Index: AQHc3WHmFcf41+qFMUepOyCpFcj1+LYBC26A
Date: Wed, 6 May 2026 14:17:42 +0000
Message-ID: <c5c8a3a0-c8c3-448c-83a6-99ffe3e6ef11@solid-run.com>
References: <20260506141040.1368918-1-s-vadapalli@ti.com>
 <20260506141040.1368918-2-s-vadapalli@ti.com>
In-Reply-To: <20260506141040.1368918-2-s-vadapalli@ti.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|GVXPR04MB12127:EE_|AMS0EPF00000193:EE_|GV4PR04MB11775:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5b64c0-2ffb-494d-e160-08deab7a46d3
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 o0Hghn1QwWGn1JaJ7wOr2iegflz0VABk9/fysqeEkSv1X63WvcTPO5//dxWXlRWtiwQJma27OehztTyWZibD5lyIULOUwMGst3JlDhm2MZpo5dAhxaWzgbFkCK5D3gZkcFIMfaaaB7wDiVx2Jy8xfxeS3rPySjmsYFEg/GrGiNSCcK2v26cZykEUBt7Ktn/TDTER/tPuO+5qjWnUAzGz0mhxKni5oU8ZCvSbGbIkcRJCw+bsh8Zj+Y6YuJT3KmknpOxNGiAD6Wogvi3QiHdTfquGDKauu0pY4G4vjEUjIj2v7McskI5NqgcnqhE+FYW/At4yLUN4hIaYe4u3JCfDBt3BR7nwRAESksdixukxUti9vAU28/0lNJwYEHuCq2lD5a7kYuS+yzYnS4fUXGxiDfTe42gqq7ekk1QgK3lhOWO6d0Uk/6VVCGcARgigGWQ3MB1QmzTEW+Z2ktMMdjjTaJbbg8veEvyd54kkXdrIwF5j9LvQEwWvtI+s/GaBBL3VYcH38JRT8EAtayt5kpPeW8b3/eV+AQjFq3/zgjAIStrTWHkoxxi40bNq2B5H0MfVIi8A7lI5z/qOIocINQr+m7A/CMyupmozvxueTXWKSjWUG0P8PfihB2ijGcT+KxI1fFl0On+8R+1INOGZN3V76BFx04FN6pdRUAhRa01sHQGE7dqbtVEIVYX1ZfM9H+S+tP/oDmwxsh/obbTNCaKRt6IsZzjJ0jre6IiRvzIDrXij3oi3cbNQ6iQL6kn6emN0QekxAsVMNV5tZS8gJhFWwA==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8388FF1060E0B4EA3FBCF704FD7CBE4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 vr9yubDZq/filRjmqenleNKxc+a1+H7QcjvhXnbDDt5pibgPVD9nY2HHIg0WvfVxeR+kdldtYv3UEy15cvMEzjUja15QK6gh3ncqNnEOs6PYLXwOhSAlJsJfJblkN9gUWxLiBQfkriZaLAxdGxJny1mAiS8/12FXPw9Wz0kvTApbMR3MqyNkpgz+SCQnDJI5S9GOH4VZ9XaHKPmlEtGSSLRaXQAGmaGhuU9EvZsZ4iupjFf8g4qGpcVQbhJTLWSa56d2m0Zs0FrO55TvsVSrfrJ4+1OU/GjRYBT7ha5ZhEQInILO41OW0WARaZvSIjqAz2MVocFoGC6J8pcBFYijHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12127
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 26841e17d19c493898eb40f711818b4d:solidrun,office365_emails,sent,inline:9723ea776f2aa7b7dfb80d808483cb3e
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b15b4076-82c5-4c3b-e8bb-08deab7a3c95
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|35042699022|1800799024|7416014|36860700016|376014|921020|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QTfuKdlwyZ4Xafb7ij6Mx3hk4H6eIEa2u+OVWjpOrIban0TBIWC43HpZf3SrHdQx3gU6qAFpO2mfsm/tkBZDxxNDrspmJMT6/qiSaQQXiVfduMbv4yLWUJ4snL4wL4S+C7iZGFT2YCTfKnlv+pW8nrMAo4Jzz6poEOB4kUpoFkET+aihKD0wzCr1RW6xn9X6kxv3jh00HAss049lhFSStmNCbo54OILMFGOsowA/ectfS/IVA4+CdcJgeuay+w/iByRsvbvcVAFw3wqOajKMt2Cza5hK7RVVCKVMqdgTPAHxq8zf5Yfw/gNcAwy2tjjwWm7J7a2FIUcuJGFw/v6mKyXrVc8xh1LfkyjpBVb3I/myAWLTSHAVdSjrJaXwx3SndAI6mJKOAz2Me0AgtjpJMNP0407RGFdXbq5n/TgCXQdS+XzFMqkKtat2w6g/vFJJTh5c84EY1jFvTyHlnU4lgtQvNQS/PNerc0H4wwSa6cF9SW8fjViRHQf5WG+3PGxC6UKhIKcOYDP3dBEX2cm/2L1FJPe4KTyads4TTCg8AllqvYiQlPW967mGLcvFUY6gniu+NJfePUXCpfzyKpiD4HyeCKf3sePE+DpmnA2fGHvDCcLV5ARsmTuz53C59XWo9MPrr3dHX8xIMJszFq8EcL97mDYrQ0ou6R3gWb/mO0EwVo8fsKe/xVELFc4E5kXhgK/VSTjOZ0Z0R+4ZymbPBmSAuvuszqUOxUilatvEWoY5GXaWE/6BlDRqo6VDUwapK5omNQWod+ywqSOSadm74OH7IVNK7YPM6qUCMF+Dz1s=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(35042699022)(1800799024)(7416014)(36860700016)(376014)(921020)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UUzMVvPH5Nd53CNskRbifDpJGAQQexqVdd8IQscdWNAwh/kRfJoygIzqHnMbqfldUIIz0LgEfr6j+hRaiABlYCBCa3q5frPE3g8kNiVTV0TqAs0UIxrrYE7AsYLUGre2sof6xjNbjnznrOEjFX+Hg7suuVjUor8UP/D5Ip+wQ1iCGvJay6SZYi727zqFdzVdPPU420huQdTTcoPJggRboiWFV+A98nuVLeHIu0IF8JjThHDlmwtKVaF5P/0bUiDxjVokVO4RKQ+S2u4hwYP+kUXn4gnx6p8HRnlqmtA27XkuKGuav0wJFccBwg8LKWrcjZ6GMwi6R7CE2uu59i07Fc+uUJEnjDZ5nFUicim//QFPEC4mumUJ6OPceOKV/ON3dRUAjIXh3JyZhUl3E3rDNOVvmOE5ASMZucAurT0ml/eHHvNRuRFn6+NsJetASJ7x
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:17:59.4981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5b64c0-2ffb-494d-e160-08deab7a46d3
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11775
X-Rspamd-Queue-Id: 078CE4DC43B
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.94 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244408-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[solid-run.com:s=selector1];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,phytec.de,ew.tq-group.com,toradex.com,redhat.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:email,solid-run.com:dkim,solid-run.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email,ti.com:email];
	DKIM_TRACE(0.00)[solid-run.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[solid-run.com,reject];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	NEURAL_SPAM(0.00)[0.925];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Spam: Yes

QW0gMDYuMDUuMjYgdW0gMTY6MDkgc2NocmllYiBTaWRkaGFydGggVmFkYXBhbGxpOg0KPiBBY2Nv
cmRpbmcgdG8gc2VjdGlvbiAiNi41LjMgTm9ybWF0aXZlIFNwcmVhZCBTcGVjdHJ1bSBDbG9ja2lu
ZyAoU1NDKSIgb2YNCj4gdGhlIFVTQiAzLjIgU3BlY2lmaWNhdGlvbiwgU1NDIHNob3VsZCBiZSBl
bmFibGVkIGJ5IGRlZmF1bHQuIFRoaXMgcHJvdGVjdHMNCj4gYWdhaW5zdCBFTUkgdmlvbGF0aW9u
cy4gSGVuY2UsIGVuYWJsZSBpbnRlcm5hbCBTU0MgZm9yIFVTQiBTdXBlclNwZWVkLg0KPg0KPiBG
aXhlczogZTJiNjkxODA0MzE5ICgiYXJtNjQ6IGR0czogdGk6IGszLWFtNjQyLWh1bW1pbmdib2Fy
ZC10OiBDb252ZXJ0IG92ZXJsYXkgdG8gYm9hcmQgZHRzIikNCj4gRml4ZXM6IGJiZWY0MjA4NGNj
MSAoImFybTY0OiBkdHM6IHRpOiBodW1taW5nYm9hcmQtdDogYWRkIG92ZXJsYXlzIGZvciBtLjIg
cGNpLWUgYW5kIHVzYi0zIikNCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBTaWRkaGFydGggVmFkYXBhbGxpIDxzLXZhZGFwYWxsaUB0aS5jb20+DQo+IEFj
a2VkLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCg0KWW91ciAoc3VibWl0
dGVyKSBTaWduZWQtb2ZmIHNob3VsZCBhbHdheXMgYmUgbGFzdC4NCg0KPiAtLS0NCj4NCj4gdjE6
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjA1MDUxMTA2MzEuMTE0NDIwMC0yLXMt
dmFkYXBhbGxpQHRpLmNvbS8NCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gLSBDb2xsZWN0ZWQgQWNr
ZWQtYnkgdGFnLg0KPg0KPiAgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1odW1taW5n
Ym9hcmQtdC11c2IzLmR0cyB8IDkgKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNl
cnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFt
NjQyLWh1bW1pbmdib2FyZC10LXVzYjMuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1h
bTY0Mi1odW1taW5nYm9hcmQtdC11c2IzLmR0cw0KPiBpbmRleCBlZTliZDYxOGYzNzAuLjkwYTE1
ODUzMWY2MCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1o
dW1taW5nYm9hcmQtdC11c2IzLmR0cw0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2sz
LWFtNjQyLWh1bW1pbmdib2FyZC10LXVzYjMuZHRzDQo+IEBAIC0xNSw2ICsxNSwxNCBAQCAvIHsN
Cj4gIAltb2RlbCA9ICJTb2xpZFJ1biBBTTY0MiBIdW1taW5nQm9hcmQtVCB3aXRoIFVTQi0zLjEg
R2VuIDEiOw0KPiAgfTsNCj4gIA0KPiArJnNlcmRlc193aXowIHsNCj4gKwl0aSxjb3JlLWNsay1z
ZWwgPSA8MT47ICAvKiBTZWxlY3QgaW50ZXJuYWwgcmVmZXJlbmNlIGNsb2NrICovDQo+ICsJdGks
c3NjLWVuYWJsZTsgLyogRW5hYmxlIFNTQyAqLw0KPiArCXRpLHNzYy10eXBlID0gPDE+OyAvKiAx
IGZvciBEb3duc3ByZWFkICovDQo+ICsJdGksc3NjLWZyZXF1ZW5jeS1oeiA9IDwzMzAwMD47IC8q
IDMzIEtIeiAqLw0KPiArCXRpLHNzYy1kZXB0aC1wZXItbWlsID0gPDU+OyAvKiAwLjUlIGRlcHRo
ICovDQo+ICt9Ow0KPiArDQo+ICAmc2VyZGVzMCB7DQo+ICAJI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+ICAJI3NpemUtY2VsbHMgPSA8MD47DQo+IEBAIC0yMyw2ICszMSw3IEBAIHNlcmRlczBfbGlu
azogcGh5QDAgew0KPiAgCQlyZWcgPSA8MD47DQo+ICAJCWNkbnMsbnVtLWxhbmVzID0gPDE+Ow0K
PiAgCQljZG5zLHBoeS10eXBlID0gPFBIWV9UWVBFX1VTQjM+Ow0KPiArCQljZG5zLHNzYy1tb2Rl
ID0gPDI+OyAvKiAyIGZvciBpbnRlcm5hbCBTU0MgKi8NCj4gIAkJI3BoeS1jZWxscyA9IDwwPjsN
Cj4gIAkJcmVzZXRzID0gPCZzZXJkZXNfd2l6MCAxPjsNCj4gIAl9Ow==

