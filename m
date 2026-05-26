Return-Path: <stable+bounces-254448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEw2J4MRFmojhQcAu9opvQ
	(envelope-from <stable+bounces-254448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 23:32:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F115DCC7D
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 23:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4913300CBD9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867F3BF694;
	Tue, 26 May 2026 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XNFc03H3"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A026C3BD;
	Tue, 26 May 2026 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831166; cv=fail; b=A8pYFMQ7GBdYWzdivFiUYeb64g/IiO68RRwG6C6vxzpO8yogqP5RUn5Z5lRNx5EGxE8Nk1TrhgGlTdpYhK53rrLDWEWaxj/eb6eX4dgfXuUNRpk4u1qOdllTBMlbQ2tdWHYd6ZvR/ZAWpi1dDxaeviB/lDRe3HT53WHy3new8LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831166; c=relaxed/simple;
	bh=ePZmRF9mj4vl3v1mWt9jHNOJQHNyJt6ovjmG+huy/Oc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k1kpzI8c6/MnIpTvIZuU7OZoePVQWysXNwTLUgrUBNedpOHkdUm0FIDTpcSslBHXExXwtqOAT7ci/mEuG1f4N2bLh1Euvhtr/aGTHZEukbpLWULLA8PQssV8diLbp+TY9o3Dklb4raDOF+6N/lZRciV7B3s3+5ld1Z8uByeKH2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XNFc03H3; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEa9J10Wl3tOQMDLgcTqiFg+8nTEIm02GbP+VkaI3fx/GDoQwDa8xM7cfgASkJ0XrDH2Em6ADBCGCFGa91v8FO60WZALNIsSpIkpJBqbcb5QAec0yVEvhuq4pMOMFVGjhmEznHG7j0gQe+ENPszKcEs/VVr32FVTolgP1oSbHrRxtSfSg2k0FDtOQHoXpoNRa/iJ4GmmTs6whsmPnJjaNCUNuIobDtCrZKaMF/3oH5564pyumdvjYHm4vrf+g4ahVw+pP4eivtMl60eHmuzsZZd6sZBIPNbn1hwPzul35We6H+K20AnGQjvw9xEcHRRRmV5uxy+QW+xLSwQ/vlR4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaHJ9RSSjJslAvew9XeGZR0rkKxYkogkj3uj8N+/eog=;
 b=fYH3FiRHkLvX2+ZgXkOGmK0hEOPO16CDzEo1W9zvuQ7Hx6mDAA4UiFJWcvSDsqxwfTlfdfbQpCnF2LwFmL2c+DSVXyILJrrjrqa9d0OpYX2ze/2M8cnD5XnQpu5/7UvZJQ4rvAEHb+iiVxIqbwshdDMQ0/4Msbdgw2VcTSCP4Rf89rdX2mSYW3FIwPtPaGO59K4N2RCsOKPLfEiOVVauEMGxinqIbNbSnTGRhnmhkt28eyVUBtLLdHd64TcaRmp4sB+J8sgZhwW8biYbcHQwbie8VfTD7GWiefWO5R10gwkrcSI/eBV0LsDtVmhARWCifcm1GPYKabtSAzVWrgM3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaHJ9RSSjJslAvew9XeGZR0rkKxYkogkj3uj8N+/eog=;
 b=XNFc03H3K5h+hRt38F7xvayjL84neesURWyJQ8OFSltSWYwZNdhiNBJjDKecuFgxDdQtr2Pll1o+glvIsMsStCUL/e1g32ZfhU3Rfo0VV1u3I9RbsPsrcO1jp3tzW3NCUWde36moXfA3XFvha5N/NFocixw3WIAWWoH2poxEbfw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 21:32:39 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 21:32:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Muhammad Bilal <meatuni001@gmail.com>, "Kuehling, Felix"
	<Felix.Kuehling@amd.com>, "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdkfd: fix integer overflow in get_queue_ids()
Thread-Topic: [PATCH] drm/amdkfd: fix integer overflow in get_queue_ids()
Thread-Index: AQHc6sBJWa07N1ogyEuZjdk27XHWVrYg19Dg
Date: Tue, 26 May 2026 21:32:39 +0000
Message-ID:
 <BL1PR12MB5144A61A8C1C9F48750E2AAFF70B2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260523142645.39102-1-meatuni001@gmail.com>
In-Reply-To: <20260523142645.39102-1-meatuni001@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-26T21:28:56.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV5PR12MB9777:EE_
x-ms-office365-filtering-correlation-id: 8425fb5e-3f68-4be1-49c6-08debb6e4fc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099006|38070700021|11063799006|6133799003;
x-microsoft-antispam-message-info:
 LKX1OIwSIaGfgirYM23VGvR75pLEA0NAFlZye+eJa+GlUtszhRGmvOPmsA3c9DLfJkyLDrAuWdiA+FxvC1FrldTfNzv2fhNvXepbwNHGHrc764vz7UkxdHaiydDMMd/Y6DRKXfMpfdGAcI19gv2T9/OoxSYn7WnDlOSjY//sgSrKA0K4NVgOgzekkDvfxy4fuRJO/VHuArNOlI8Zp/lDFNb1pqEitmHnAjXCgK5YtfTXpJEKl3OHarM6NPvF38MceXxMTRhP3IkFjORQorRjKaFdJk1YcTCc95Be1QiqZvDeab7uvMMIc8jNNM0plksEFEDop/8CiTAtBqrpg/zEmRY700jPcI9cwPgdMk5tmGDcWLyjopn21Pph6M82tfHm85FX+gUPFhBBxWjqbwqI4MLm2WzcdxEmlao/h76NZ2Ry8TO5rssh0PCmKjVD+ENKSD4zbA6v7+guhlQG2ptAEhjdngBfrZeA3UFr8On/Y6YbhYfDuTY3fdA7On4YEjfXlLGznJDRem6ZVyJenUOiSQDernPY4hvLkFPUWZ4iCQJHdle5QSJkXtpyPPVlZ/MTDWpVp/J/2P/FFfiHUIEB8ZxQVqNR9ZHL6X3yiT0JjqQumg/lLMrEcbtO0nkb5Bqk/XJVlP8dlnZ9nM4F6/aD2i827svxRSI/KX/bgJmaqkqmDGVDysxL9/aqpFUt9xUOybIMjRRYT9H9F2bo8u4TaQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(38070700021)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FKWtQ9iPqwu7q8LeisaCUrAQqXtzI+fFLoLVZPqikZptcDjGaYsUfnYRohYu?=
 =?us-ascii?Q?ukziqnq6Ljtiq7U+mkE9cPuRVhnCLMKmK+xqCSf02G8k+zPXLjhCxlAxG7VZ?=
 =?us-ascii?Q?WlG+gmglsgLsZQXrUStgBgLf78DUyudAGT6v/iSutq48rTzDw//VuRt6N6ar?=
 =?us-ascii?Q?j55CIuEMwwijQKwmB3iu2r/4Cq8xQIKV0yg31TAI+TM1ybl09w33gCXw5sPM?=
 =?us-ascii?Q?d7pQ/PicWPJDI4tQqU7GqahKs+rQwnPUWBxdwdm4hSkURdXqYXcYrXy/YxdS?=
 =?us-ascii?Q?msfFewazL/HlNdNgpZZtKRK21yWSihdPJ933mFBtFDfUUMio3SMqghG840H1?=
 =?us-ascii?Q?HItg9dv7qvpbBQZ0ygxHQfrlGCLuUbe3Z5nERHCoWF1ozUEQf6n1HqkFU80e?=
 =?us-ascii?Q?BnuIFPt18dStoe916GnSBZCuLH1QXsp5wX5f+RfpP8a2O/fisW/3NILPHub6?=
 =?us-ascii?Q?kpzbCsmCgNy0dj3cH/d7HFkMDolMZC1QD9+7MtjlgJtxnzReY2HPhF2sfLul?=
 =?us-ascii?Q?wkgAeTHXL5IqQzZtSKH+KIs3fLwB/nsIusWKZ86moPdbaQ0N+azCxNVNCrDo?=
 =?us-ascii?Q?21GIMHdbmxBUIJPC6NAyQf2DhAn9pBy8ukpnIDDQt+wDLLV3Tq3G2bxxIOO+?=
 =?us-ascii?Q?jhuRvegZ3ThEmXVDD13LhHDZyBJSzUdnC1CgsWeNuH28aAWEASN5ge+KuKDh?=
 =?us-ascii?Q?SOzOvtYDSBr0C16Ji53SfLSjkcce2kBH0xp6ka3RsJLVORgCNk8NTfsKAATT?=
 =?us-ascii?Q?XroejdJRAU5qUMMWSpeGyIyJiiH+oP2tVnYtYNo5k8BjgBTQv3+mEikO2HIF?=
 =?us-ascii?Q?4CfiiPF+enjCurg6FXSj+f8xrQdAgVI9vex8Zd1R5V1flxCq2rBUS537VOT0?=
 =?us-ascii?Q?RuOH5rzJjZBa9Yt1V+1uL2y5FAKPY4I3nMDggg/udUp48NFW8txmNVq5Bos/?=
 =?us-ascii?Q?y+fefFJXlt0kYZNrwHh6Cig49U/VEPv13K4YoUAHPjtlvvtcGki0moIGLW8A?=
 =?us-ascii?Q?ZNUEYTLl4FDLko++cQDSNbLbmPP35kUiIQ8O73+N8yaWaU1KfpoEEEyV+bpG?=
 =?us-ascii?Q?eGv99ishIaU0eUPdL0gqirh06zmzBUGLjKZxbwp9edGhJoj+NtsJJuYE4p84?=
 =?us-ascii?Q?wscd6k4yDw43EvehFG5e3UC/W3HkwKdyiVqpWT73Lr4xV/HNRelANitaSeUM?=
 =?us-ascii?Q?HMy9iERw0NwYkj3fgMHUNqeanmb4//TRbybnVTrIa9B9+rEUJGfRURYmJxPX?=
 =?us-ascii?Q?e9Brs04KFrckHbNDpxWZ0l/LCNBB3DED+lpvefkTwi8bwUDpUKNfeyDCAru1?=
 =?us-ascii?Q?7L7AaY+zeDew4pBfGtLo0/vuqoVf6BQhTjRDGXh6CXAzcEqWafg3nsDDuouD?=
 =?us-ascii?Q?evyIOFC8cW/AJZNeS6gI8kZb0dDFD/htReX+PWkWP1mDKICqIQuzseArJ8jx?=
 =?us-ascii?Q?S5EyU66t/gSYubMV599EqmKS6YgO1ZdxAsdqye8Y1FSHwvTTcYxTRtdM06sB?=
 =?us-ascii?Q?BYuWfrANPm25b5PpLmLbH0BI4tKW2+pxHnUYURUFPdBB1NCxO1kHiCAQsG2I?=
 =?us-ascii?Q?UqR9ruSofuTYVRhgfInVVCeNioH2bewDTEobqgsiMHjiMBeQc+n2pDPtB9kL?=
 =?us-ascii?Q?7qEovtvtJbQims89stgv0cAOn5V3JQpu5OHusJ/DbI07PwbQyHZTUoXWyeT2?=
 =?us-ascii?Q?KzlUkP2+XRbKtmtjYyiOoptvJA3cWFfMbatpS3ejwHhKdg50?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8425fb5e-3f68-4be1-49c6-08debb6e4fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 21:32:39.1441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5jGPFYnoAVxntCnZM9AfyRo/ZkTKH+Tv9cpibuJOM+CWOY8qOHKRLZizjG/MiWxwVwU1SGNc+hofeCoIhgk5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254448-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Alexander.Deucher@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[BL1PR12MB5144.namprd12.prod.outlook.com:mid,amd.com:email,amd.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A6F115DCC7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AMD General

> -----Original Message-----
> From: Muhammad Bilal <meatuni001@gmail.com>
> Sent: Saturday, May 23, 2026 10:27 AM
> To: Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; airlied@gmail.com; simona@ffwll.ch; amd-
> gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; Muhammad Bilal
> <meatuni001@gmail.com>
> Subject: [PATCH] drm/amdkfd: fix integer overflow in get_queue_ids()
>
> get_queue_ids() computes the allocation size as:
>
>     size_t array_size =3D num_queues * sizeof(uint32_t);
>
> num_queues is a user-controlled u32 copied directly from the ioctl argume=
nt
> (args.suspend_queues.num_queues or args.resume_queues.num_queues)
> via kfd_ioctl_set_debug_trap() with no prior validation or clamping.
>
> On 32-bit kernels, size_t is 32 bits wide.  A caller supplying num_queues=
 =3D
> 0x40000001 causes the multiplication to silently wrap:
>
>     0x40000001 * 4 =3D 0x100000004  ->  truncated to 0x4
>
> memdup_user() then allocates only 4 bytes.  q_array_invalidate() is calle=
d
> immediately after with the original num_queues value and iterates
> 0x40000001 times writing KFD_DBG_QUEUE_INVALID_MASK into the 4-byte
> buffer, producing an unbounded heap buffer overflow.
> q_array_get_index() in both callers walks the same buffer using the same
> unchecked count.
>
> Both call sites are affected:
> - suspend_queues() calls get_queue_ids() unconditionally
> - resume_queues() calls it only when usr_queue_id_array is non-NULL
>
> Both callers already propagate IS_ERR() returns to userspace, so returnin=
g
> ERR_PTR(-EINVAL) on overflow requires no new error handling.
>
> The copy_to_user() calls at the tail of both functions also compute
> num_queues * sizeof(uint32_t), but are only reachable after a successful
> get_queue_ids() return, so they are safe once the allocation is correctly
> bounded.
>
> Fix by replacing the unchecked multiplication with check_mul_overflow().
> Cast num_queues to size_t so all three arguments match the destination ty=
pe,
> avoiding implicit type mismatch on compilers that implement the macro wit=
h
> typeof() rather than __builtin_mul_overflow() directly.
> Add an explicit #include <linux/overflow.h> rather than relying on the
> transitive pull through linux/slab.h.
>
> Fixes: a70a93fa568b ("drm/amdkfd: add debug suspend and resume process
> queues operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

Thanks for the patch.  I think it should already be fixed with this patch:
https://lists.freedesktop.org/archives/amd-gfx/2026-May/144364.html

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e0a31e11f0ff..c08ad718dbd7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -25,6 +25,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/printk.h>
>  #include <linux/slab.h>
> +#include <linux/overflow.h>
>  #include <linux/list.h>
>  #include <linux/types.h>
>  #include <linux/bitops.h>
> @@ -3308,11 +3309,14 @@ static void copy_context_work_handler(struct
> work_struct *work)
>
>  static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t
> *usr_queue_id_array)  {
> -     size_t array_size =3D num_queues * sizeof(uint32_t);
> +     size_t array_size;
>
>       if (!usr_queue_id_array)
>               return NULL;
>
> +     if (check_mul_overflow((size_t)num_queues, sizeof(uint32_t),
> &array_size))
> +             return ERR_PTR(-EINVAL);
> +
>       return memdup_user(usr_queue_id_array, array_size);  }
>
> --
> 2.53.0


