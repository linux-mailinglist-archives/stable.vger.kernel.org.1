Return-Path: <stable+bounces-196848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EFCC833AE
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECDFA4E53EE
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 03:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF0A22333B;
	Tue, 25 Nov 2025 03:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="GWnhOwio"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F6933EC;
	Tue, 25 Nov 2025 03:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041344; cv=fail; b=PoyjvNRI3Dzkayez7gcvCveGH87U9L7spZgmY9jXYRSNksqU2caTo0EJbOxkAId7I5AVjQcI9ZGJ1509VJCzC8R+nD8fx0z310riNJ/g/jkVRl5+bW838he3gqTA0UDMoA4VQqGwgTNFsIW6L4ZBr+9gapfwV9XRo+QznhosBu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041344; c=relaxed/simple;
	bh=VfqUXLCfahr73jrpajIIfKmy5rLv0ExHtii7h9leFTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c0NQw9LTuDWffBgcrFRUWsNlh7kvLNCNtcupLa5sEgN8Y99R2GYdW7afIlz6wwUr+b83eOBJrTeYAtOfSvsIEVvFSJ1hgv3j4BwRlTy1np9qf90fRy01qe3fK9FzG2xH8+wrZZv2zA3S0V7xfi6cj6QJyGmYrFObwL52zBJJAn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=GWnhOwio; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2x4Fu3263255;
	Mon, 24 Nov 2025 19:28:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=VfqUXLCfahr73jrpajIIfKmy5rLv0ExHtii7h9leFTQ=; b=
	GWnhOwioJR4e4hXqgMdmBv8DB93OeNqmLo+NwaAAc53x3Cl4oOY5gxVYT7XrFKX8
	b+Wa4WdNX72U7uwMtHWQpvXLAsZxoAda8hcS1bpxkUT516l8K6aZ5iAhhEVYZUNv
	uMTFOXQrv4BW//5vXHnz1v7QM/Fa1D7HDJKm96r2otOoee+EI0kAuS3JHCDXUlwW
	6Tj0DM/CXBFZimHpRCdlbBSnXHh54cdbBhZVvXKTdHr/9weTgCbNcOiOmb/SlU1U
	mJgyLOEPpXGTHIwvHknnKg6m4u5OvZdGrAWcZeNLNg3qWBpmxmBxrJRrmn6VbDu+
	4QW2BiI8VKmBZ9lOE5RZJQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak9b5afgu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 19:28:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWFcBVkaFaQayZHDPPybIlDJxYG3FwYCJJhnqcpi7nx9QcWenQe2GK6BxnRI3cwuqPXGKemmfFT7QoUxzw3YCQ229+KYE1XaEJrC+LYthiMzWJSS7DB5VE6vGJpjPDtheU3iBVgi6Jjb18wdcND840myc7bGiuEShfm4KxxlFy8veJVz6RPoMScNqvfkpV+tVvYt5J87yOHkMtmfzZ1hsdAueLV/hgO4OisjTcoChayMqE7YoBwynuhQZTWsbK667694hML/tMTxZ5LTQ3UnEsKT1OLz4C8KxXZ270Rkja6TZVPgiwR9vlSAsmsAUVF4ozbDdNVMT5kgKjZsG3pmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfqUXLCfahr73jrpajIIfKmy5rLv0ExHtii7h9leFTQ=;
 b=SRhzyPs1WViKoDBZsXEdNUFs+E+oavjxi7cNQAbAdGu4ih6SE83jylgVE2BJZxiVZDJlVEtZT7nFCpvXEvxjgkv/sm4vcOTabZBoO7Xsm2DbVIwR7sxUiyM2TZz5+0JUn0NutwWBAAbcKruxQJWBOBGERa2/8igRnNNMm2w7eVDgRG1i7PkWUQbJpt9mNDlWKn+9BOWtk4K7s6xQ47nUog3kUdt5F68/LEdB/r6pUdZEqPvCOngWPImGqVeepfMUa1LyMYdhhaWS9QAoHg1RAGCSfpD8EMfwowkoemtDqvFb5Mkkk+ISI0qWm4QI4PALGpmR78Ln54ZzZcFFxeJwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 03:28:54 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8%5]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 03:28:54 +0000
From: "Liu, Yongxin" <Yongxin.Liu@windriver.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI buffer
 memory leak
Thread-Topic: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI buffer
 memory leak
Thread-Index: AQHcXbRfV9J1uUqO+kCRpWBqUsXuqrUCssIAgAABkaCAAAONgIAAA4pw
Date: Tue, 25 Nov 2025 03:28:54 +0000
Message-ID:
 <SJ0PR11MB50725E455D5B0089507E8311E5D1A@SJ0PR11MB5072.namprd11.prod.outlook.com>
References: <20251125022952.1748173-2-yongxin.liu@windriver.com>
	<20251124185624.682de84f@kernel.org>
	<SJ0PR11MB5072CCB0B5213AE5467C1456E5D1A@SJ0PR11MB5072.namprd11.prod.outlook.com>
 <20251124191443.4bd11a48@kernel.org>
In-Reply-To: <20251124191443.4bd11a48@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=39e5961f-0c7a-4a98-af1b-246eca8fb967;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-11-25T03:27:22Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5072:EE_|PH0PR11MB4968:EE_
x-ms-office365-filtering-correlation-id: 9b69129a-632f-4093-eea8-08de2bd2c2e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?t6e9yzF4ofXoZMomjIkBn7+SZ1PSdCrtAojkyiHR14EI3NRCW7MDJHJbOTQx?=
 =?us-ascii?Q?IYUriwLvaIs2oFueSJroZfwm3IPy74oKElu2H6WV2VdW58L8Mv6lbI8+MR2T?=
 =?us-ascii?Q?JxBp96mwov7eWLoiNqz4Z6StwBWOmFO8IJCY4jxPngINVZsiAWs3H8LXtHcW?=
 =?us-ascii?Q?P1xW2pXyDw3lvfAe7y+El1oB4bwCTVq1ZCRKWln3ui31uCfgGW2go9EjvAyG?=
 =?us-ascii?Q?AiKN9OKNoWsE0jOKYpdF/3VfOlVYEXJSkZ2qX+e0DFvaFIjRn9zJVzte9ufD?=
 =?us-ascii?Q?3fZxXfb/tUQ6SLPQgaCaXMT2DkorApwSoAda6rm6cAM6NN1EHUz+ZcHLcOcP?=
 =?us-ascii?Q?8820zfcOGW0jKIN9oVOD/KS4XkbVpC4H16x12TV9a7IjyltbXWOqLBPBU3Qn?=
 =?us-ascii?Q?n7WWZLfSpZCWf0bcu+IJeUT5jv3DfLaqKnRwjGevtbknhBN3wxW/5vxl3oMO?=
 =?us-ascii?Q?lWQE9+vfSUuWVAQWtTtiabW0hDwnGVfQAYSrulay1xDx86Is5xUTNNxVlJIK?=
 =?us-ascii?Q?1WmYeCsN6W2sZf+DGWx4ME4RRX17coVtKLBZ1QK7xiB658N65MRU8mFkEypx?=
 =?us-ascii?Q?NL09aV2olr3tNbkW3HOz6ZZXB/cjqrUvvnPQnUZZy134rHbAtpPiXveiO2o2?=
 =?us-ascii?Q?VBGHnpUWOIOELVhcgV6vuZGZI3tI6NniBTHYXikJC4/22C20N8XIWoDWeTFr?=
 =?us-ascii?Q?hGX+pBajDbmu0oWjj6ys7Duovo1fqnExiLjeX+UXa2R1GVcWDdFBfo7XVehX?=
 =?us-ascii?Q?qtZkXNOKTXJPJL8ixTPGhS0WQG5Uxw/Lwe/VljuLn6a2PBtHBpLvv40JhnR8?=
 =?us-ascii?Q?z5ARGxs7fCxOIaM3ExRp7a/YCl+7d1xJXYsuG9aD+q57x7LSADBdsY1On0CJ?=
 =?us-ascii?Q?yJ643feMlNDXzTFNI7T8P11m9FiOiw+RJBIGL9LASQkOmk/SxPg4N+tArQ9b?=
 =?us-ascii?Q?zNpFDyOj4xMKb96DpQ2QHl3DaPZNBMu8zis9Rylk184turUutm+NByjb1Jzn?=
 =?us-ascii?Q?RKTdgF+U9N8AuvWMR5Zq2A4ihfglYvn5WMmWmIeaxsFxLH637fehj8vR7eia?=
 =?us-ascii?Q?Bj/omU5Px9hEEjax+1zN3+sXkVpQ5ZZtWpSffAMi3w58YcZqKSHX/qKcHeW3?=
 =?us-ascii?Q?WZvCdkatDoqTO1Av+/x5Nndu595lHmlrWiyacGudhubRoD0sdt4bJPp9e7Fy?=
 =?us-ascii?Q?vHE/r7SWlvitgy2HFIhnRt5OoeayZm28CBnrKAh61W99rBK9cHRFkoFOCiPY?=
 =?us-ascii?Q?7kdFghO+an2TYhA+0bu7QcenvW4Gv0W/zHMkLkCRboX92W1ctah7upXHi1vp?=
 =?us-ascii?Q?b/Xs/a/ku8aeTndpX7jhJEQZz8bWYAHl4M68+y1H/I151fqTknWKIrX1BFhQ?=
 =?us-ascii?Q?TmvvwjkVGmbUMe7BUndkJZbTCo1MzaTpnqF9GD2U8m5jiy2GZ88Ap3wxt97C?=
 =?us-ascii?Q?rMfThFMpEYShPLe+TOa/x/15sOkmuE/u00F0dUHedLaCNt9Lky1/Usm/eXAP?=
 =?us-ascii?Q?I3cSTAvynslSvHmA2wftfHE9pNdpp7fNq97P?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NgF53EBQdJAIDM4953WV5XdiThYHs4SU9HbCisGOOLSBsTHWJaIrdjpGEWwX?=
 =?us-ascii?Q?C4zv7O4h1QY0aXCEcjo4JKWhhwSaJetALo83ZJuRGFRbTg2A7j8HAw66ukDU?=
 =?us-ascii?Q?BBlIhzFZqlEPJskg9Ab9dXBsv0N80DoOUYmCcdAUn+ZsOX/TZuuyD/AqXagM?=
 =?us-ascii?Q?KR0yTOQOi9PY0ejfActFG7sYG9C0KoqOxElBhpKZjSDRcEsiskSJuauVdbiH?=
 =?us-ascii?Q?O/5IAqmLNzBRMhEyzaUQT02pSKlQk1feMIzm+Y5KxyQ6hIbirk12A/2oJ2xM?=
 =?us-ascii?Q?/H6vhhvoUSSc9MCFMY/8sDzRU8PNzU6RLr3/UFysp1rFoJpQ9vA52qucn7q9?=
 =?us-ascii?Q?s8Zl7G3l8xNS9UtsqW8AnxlATGZ3ba3mLlMKB1ncks0T8DWGanDtvECf8L/S?=
 =?us-ascii?Q?NmelN36e0NttjS39bl+5HKAv2ThCtDxJ+sAsDM7mvlf4Ezk70Vz8scuWLtrK?=
 =?us-ascii?Q?Sb9d7vypWVdNe20LBNf00MAxVBzl+wL3mjgtcrOzUiAzT6hJ8OHrUDLanyXM?=
 =?us-ascii?Q?Nl1jri0OUilfGUwzzEaiG3pHlRfoSV9th+XX2QyVjXmxyguVhvjO3dUZTkS0?=
 =?us-ascii?Q?HaKaqDBd4+y/MF1nvkFKy8Ip68yBkV7XlSYRXfkqhkIT2/EYM25wyRDPsLWt?=
 =?us-ascii?Q?7XRz8chcZRb6dKj/kMTWMALX0qIssHgr9q92knOmE9Wgq57nJ0CsGrwhuwyL?=
 =?us-ascii?Q?LgelDB8VnT6XMlvB5fzlyrbTOUSodBE1WVuASWj0uodgLVNvn7y9vcCZF7wb?=
 =?us-ascii?Q?U1Kw4T63f+HK5mgTW71W5RHJ4Syik2NFkLvw2LI2ee+wOc1/I0qqucbISmIL?=
 =?us-ascii?Q?fVshVV1u1I8UIZhb5loeJDW7d0kjrmK/MNjWF+C9NrRLTAL3fPvooG3Zv5Wx?=
 =?us-ascii?Q?t02dKDni8zI9J2E1TdJpCGYS8e9W3vHQ8pDMcKRMJw1QwxXgkSbfig0XaQtt?=
 =?us-ascii?Q?OUdT8jw6lz+mofo6s7Ug37vJSyklNjyfi7+cCerhrKQjFmy+UJMYpjEUmzhy?=
 =?us-ascii?Q?fRFkykEGYJX3+8haTv5xrlAmy97ISXzmukOduu2drXLBP4pKBsyizgzpCz8P?=
 =?us-ascii?Q?1cYSNYxw38VDLStAHhQo5xnqXznhUNKqkyTSKs/CNUmYXs0u+Ja0MEcbypoS?=
 =?us-ascii?Q?D303TCkBiX7wGFeO71KCw5SkNnlh3fQhMsuAQVdpRAFqq/TIZJBmW6LMBHiw?=
 =?us-ascii?Q?+jyEM8LTJKpjlLo3HHCnzG/HDhmy6nJcRHQ8/AQ7I5pIQ8EQIAeMsfRe9TF5?=
 =?us-ascii?Q?aHC9tmg3I/XYcHBzga2k3g+QTP3AsrKTiow3RPvoTqvb3gfD1qBjPOa6Xz+7?=
 =?us-ascii?Q?vjSKDQJGGgbnWy9rj5rH1Prtb/JkGZJ8xnfjHMAbmrfzvGR/MGH65z+d7DD7?=
 =?us-ascii?Q?f27UvDT9BExCr/1y4tfNzXW5QFSK4PTEjrh2reQ4Pgpm1y/Cw+I8HFgUNu+K?=
 =?us-ascii?Q?kjit1uWRvoYG2ktP368W7jacD9xHJ7dPS1AFU9EwHiYlq+lsQpqc8mwJVjIs?=
 =?us-ascii?Q?p231lnm5/ABTgXWdmzcGvYnp7IIcSIH+69WfTX9Y+tiMkbI5yjqcMGjQfBYx?=
 =?us-ascii?Q?889rKc8pKQdB2qYCLYjzs5VaT8ekmvxpMm2sDBdQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b69129a-632f-4093-eea8-08de2bd2c2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 03:28:54.5721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJIIP6DnZPqSL8MlI8IFCSob+WDm+TBQ3V2UIgpKGplEqc4UOFuIUq3IUFqnR1QZLi4P1bAqaIMtNeztVuYZnaKFN6rVR/qkgQTyq2MK2a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-Authority-Analysis: v=2.4 cv=fozRpV4f c=1 sm=1 tr=0 ts=69252278 cx=c_pps
 a=6APEVz27trGWNYyenu7PEA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=QyXUC8HyAAAA:8 a=f7ztsxou0Aw-QlRM-RQA:9 a=CjuIK1q_8ugA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDAyNiBTYWx0ZWRfX9F4A6vWQ0JaC
 LVWIE4YHw1+inNAis+/WwetNpxyjBlhh5rSMh31QAg8evO+z9GlnggQVFC7VhMmOA3XDF3uVg6S
 h2TaFlALTvmSmdnRpAzAyJe87Aqc4k5sPVXHZKPlCKt0dtoNPL7/a5NS55/nRf/VEcMChHAczC9
 Z4OBwA924k/kK8kKxYsm6WIr8SFI2DfXiXkZTrIAqmUj+A5Tv3CBs/zO9qwAnnhLK/pFV2s/Qad
 fWNXLdFNWxIPZAPRDFvO/k7AjDh5zdtmAvuSzOh8HIJRlTDt4NMpXG7nUjx7/TyPYx4vCnOLihm
 Yid1O3a6VJP5/ht3Uz66D8J9QIegVOdrdnDsX4nUeWx64UNWAKi3A687ovdza2hsLDO98lr0p4H
 LyGo5ckutuWftQRc227zgDDfGhk41A==
X-Proofpoint-GUID: _OIn9AJ--2p7NQJSDe9UODvlvAkDGldw
X-Proofpoint-ORIG-GUID: _OIn9AJ--2p7NQJSDe9UODvlvAkDGldw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250026

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, November 25, 2025 11:15
> To: Liu, Yongxin <Yongxin.Liu@windriver.com>
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> david.e.box@linux.intel.com; ilpo.jarvinen@linux.intel.com; andrew@lunn.c=
h;
> platform-driver-x86@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI buffer
> memory leak
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
>=20
> On Tue, 25 Nov 2025 03:07:30 +0000 Liu, Yongxin wrote:
> > > -----Original Message-----
> > > From: Jakub Kicinski <kuba@kernel.org>
> > > Sent: Tuesday, November 25, 2025 10:56
> > > To: Liu, Yongxin <Yongxin.Liu@windriver.com>
> > > Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> > > david.e.box@linux.intel.com; ilpo.jarvinen@linux.intel.com;
> > > andrew@lunn.ch; platform-driver-x86@vger.kernel.org;
> > > stable@vger.kernel.org
> > > Subject: Re: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI
> > > buffer memory leak
> > >
> > > CAUTION: This email comes from a non Wind River email account!
> > > Do not click links or open attachments unless you recognize the
> > > sender and know the content is safe.
> > >
> > > On Tue, 25 Nov 2025 10:29:53 +0800 yongxin.liu@windriver.com wrote:
> > > > Subject: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI
> > > > buffer
> > > memory leak
> > >
> > > Presumably typo in the subject? Why would this go via netdev/net.. ?
> >
> > Because the only caller of intel_pmc_ipc() is
> drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c.
> > I have sent both to the platform-driver-x86@vger.kernel.org and
> netdev@vger.kernel.org mailing lists.
>=20
> Just to be clear -- the CC is fine, but given the code path - the platfor=
m
> maintainer will likely take this via their tree. And the subject
> designation is to indicate which maintainer you're expecting to process
> the patch.

Got it. If needed, I will resend with the correct subject.


Thanks,
Yongxin

