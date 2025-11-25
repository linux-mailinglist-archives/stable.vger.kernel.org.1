Return-Path: <stable+bounces-196845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A56C832DD
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E02F34A7BD
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 03:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4346A1DA60F;
	Tue, 25 Nov 2025 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="qs0aWYeJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFEB3C38;
	Tue, 25 Nov 2025 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040062; cv=fail; b=GlHGpZWJH0SkH5FzZPpZe4kv2h2WsGW0AIULTo9PrfCwEah1hReRNqUl7Aoowm/59c15vLQ06usiGB4RcvbQS6E1Ff6zHRLTJrLuImJ+SwDkZNbHaomk70e0ZbpzzvhYHKYCxMtNKmY353a30cP05cmZYJWD2aj/GDAFpOSLx0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040062; c=relaxed/simple;
	bh=gVPuzG9EKsvZHI+NHcBWfTWLXWsJ0lfUuURNs+V+SiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tK2h/7iWdpshSy8X5bVxYwtrsU2BtHnj7TKrXlvvNuAF5DWKFz7UCGdFylvRTM941/jwKJmwnOEaBkRPpX/mo1ntzLjOz5SKc7TzUNSewYXmOVG47Ak100CVp8zw+3A4oK6yLuD0Uu5GXtvHEBlV1A5SXF0JVZ8F71RM4IiYlBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=qs0aWYeJ; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1kxHp2480727;
	Mon, 24 Nov 2025 19:07:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=gVPuzG9EKsvZHI+NHcBWfTWLXWsJ0lfUuURNs+V+SiM=; b=
	qs0aWYeJeFvy2C/vhSlT5PQg4wviAVKFkJwSppm8aGpXKegDYDtsRkkcqjpZAS7p
	8ibEZbXB+qdr2wmVRWBpImiqwvYDFmH/IAT+xY28lNQBmfgD1i5Xg8okgU5SfbLf
	2G8l3gjHM9T4mxPxAXsZW7gmem7cIinbts/lmdSL97JuipYFwelPKQaOhI6cGWK4
	b2Cir8+FJ2miaPYOgUst1B6BmNHQCiW4OHvRMb8/7Ba+GhfhpetXdQE65G/MVmz3
	1VmzMpR2Ktr3vi4u/hxDZFjGsvp/Oy5IzLPZmrqQH5zROAWGpGuhSqimEjZKCLEY
	6sz3GF6KwnW64EIGB6e+KA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4akdjjaa68-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 19:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXv2LzEgjqJI+vfATvIiTo2nt8IC6y8XxfknyYZ0mx83vWwKgXu86bbaLJ3hm+nrrYSOwzGL8F4QAu34fSyv6UXIqR1fQCLD2z3Cmalj8PDaa8kylG476kGoqhz4wUxZ5yVOF1+u/bwg6N5+co+xi6mUeJEno/44DrqfL4ipqRoFuLtXrV7759G7KNW/75P4jciVpyq4KSzTIqvCbrnRqR2hTdL/4ptqj6Bsu4LkNh5BR/YJqpuGBHc4IVmBqw5IudBePRT/2gR+uP2hk9iVVepF3kL/cxgdpS7Xx+QXYLEi9q3YnGQwseYjUfhcEShAU/K6Fz1dhpMEOGXsDBH7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVPuzG9EKsvZHI+NHcBWfTWLXWsJ0lfUuURNs+V+SiM=;
 b=h3lGsJEqX3bPksarILiPU3s0Ss+x97HB3pi0YcPV99+ZNbPf4avcidedr9F1RnmJ+zHFbdc+qzcx1j7fJ7xf10IL5k3uJV+xApwQnk+3JQAr9EnVY+VRd1hjjfe0hMQkhTwCEXXBo5uSrvCQdB0x4kdlY43C3oduTrY/ma3/BJ4X/lBAtXSEa9//XT+I+i/Sq5kxO6eLUIOVZ/icQun0FjkUsx7bAxLTezBPUyyO+rUwbjEsllLxsA5Txac0Y60VqVbU3mZbPTQwJSYDQ2JUnV2uVv7kGTvOrQklH+YOj1WCrpyHDDN68b5Ed9jxViyGHWnZlLH4XRxb0hK2ALy0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 03:07:30 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8%5]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 03:07:30 +0000
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
Thread-Index: AQHcXbRfV9J1uUqO+kCRpWBqUsXuqrUCssIAgAABkaA=
Date: Tue, 25 Nov 2025 03:07:30 +0000
Message-ID:
 <SJ0PR11MB5072CCB0B5213AE5467C1456E5D1A@SJ0PR11MB5072.namprd11.prod.outlook.com>
References: <20251125022952.1748173-2-yongxin.liu@windriver.com>
 <20251124185624.682de84f@kernel.org>
In-Reply-To: <20251124185624.682de84f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=5457266e-c89c-4892-b823-03a27b7380c8;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-11-25T03:02:00Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5072:EE_|SA2PR11MB5179:EE_
x-ms-office365-filtering-correlation-id: 8242c7f7-02d5-492f-e9fd-08de2bcfc551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e0X0/4gfJBwrtSpPNh+fjlxeXKAwsdl1HQIJWjWBF/4pVPjaRE7nYF5MxUTh?=
 =?us-ascii?Q?7vNnTi6OiE+Z5OUhy6QJU9/jkrjRYWwUIMA4t9fL5cy89XAyLEOzj9GwWQG7?=
 =?us-ascii?Q?4wfvw92c8PcOBvfPeCNs/Zf1lQMmdlzgIN/Ck1OGHOJwyVVIibLEGOmu3olp?=
 =?us-ascii?Q?ScI25cRcRrLnWXfD1ZTCOXynEDPonjHoXaYzxBDKggzLjElFeza4QTUDzqr/?=
 =?us-ascii?Q?ab3bh9w9IlEWua8+/UDshxsdjcHm0+owRmk5Xn289b14e/CVFeaJJHU+t5rJ?=
 =?us-ascii?Q?uMX/HHnFS7dGO+W5D9nenYkgNV7YOjZNtqL5VgiOnfx92hilwBg1XuepDB9b?=
 =?us-ascii?Q?rpswn8iAJ/hj51eLc8nX8gwbqkJdO/fzGS5Lei4s7EMbwn346smSEWUCB9bu?=
 =?us-ascii?Q?fATC8+jenP0TB0ijWjoxh/QJX6Ub5qMw7fgwksL9p/E0Oh8bCpXVkbB/5Jte?=
 =?us-ascii?Q?WNMWVBv0eHg+1nznUtc5vZBLThDxUabO6znUvKt/wKishOwoEa3Yt9o5H8aT?=
 =?us-ascii?Q?cvjnDPA+Cg/zi1jYSnf09LgbaJAY5R5HWAlqck63OD0eTB4ZwV5qB2W9+7Ok?=
 =?us-ascii?Q?OvowXM/+iN8flbQGHu8dpUVbZVRVxxozwXf+vqGHfmmDGlJqEgFAhvZKgxWK?=
 =?us-ascii?Q?zMgehrsW4A7F2uTYt0I3lRZBIhvPGEMJMAz6xcQH3Ulyrmwwe59VSPDa4tpO?=
 =?us-ascii?Q?PLZ/MsXMg7L62ah68/4uhLae6ZS6hADEWSixVNERUUnO6gfD13GkXCrKdKWg?=
 =?us-ascii?Q?LXYOllEpZ+FSQ66F9E0Y3ABJbY08cWDk6pHyQb8J7SXavu+FwPRAPoY0hRa/?=
 =?us-ascii?Q?u0IiXqK4uyIgbAtuyUZvAMpiWRGBYh9ShAQMLh2LGqY2gtzAlWrr1xif1/An?=
 =?us-ascii?Q?f14+AnnwN0pSGycVP6tKjnA30beiyPV92eNbv2tEuVtIC41T62GCs33VTSz/?=
 =?us-ascii?Q?MUtGMo2S5YWmiRqaNcUbm5DYWl6q64btrILzYRjU0cQ+bQ5JLupGzsgIFb0j?=
 =?us-ascii?Q?kOhmHq0cBiSPBDteiIGIrZf0oj2Ub6y6DOebW0OPAi2l+bSLV1qKvFiEqQCh?=
 =?us-ascii?Q?fsV2xHBVBXu1Bco8L+uY7DCM7ZVOAng3BXf42OoZWTVcuDyEtleT5vJX3ErD?=
 =?us-ascii?Q?7Gs2vTHfDBR/TzwnIFldXfyjQUTxR3i6J/7L08pErbjtTEAKak+yNrZRqQof?=
 =?us-ascii?Q?q5q+fd2yJAKQ2GpWtDWYhTIX/K1kNB6hm7kmivWN5J04OmuGCf2AX5GWnGGX?=
 =?us-ascii?Q?3/xZm/k8MrA2lPraToJn6aapREOabi6LJLxLN3J8FOEb/yyUksNUX7xFVPK8?=
 =?us-ascii?Q?GzdOkeSj8SpK9JYkIvJxtTZ2zWgMvGLWqhkSVxMRkf0VAs/QU/MMO1pGlNka?=
 =?us-ascii?Q?r07LhiRdTzQOF51zY9nyVPzg0SyAJi/Yn539sZ/oUy88Ja+Nt6eorGEgB9KH?=
 =?us-ascii?Q?rE5uFx7APseyOfi3TTGjJLHLnTHzEpmXFyQ1Ya2s2mAx6p14KFDfhj6NH6FH?=
 =?us-ascii?Q?D99mqKOVMtgzxDhloS3ppBFX9xI8BlwCt9/M?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c+XUoYaa6EgUN9dOnLzCSmlogxk5uR2gIeStAS6ZQOrG/FkJKNwJBWy6vlig?=
 =?us-ascii?Q?J5k3mJjGKqc6Y/NB7JqE1JmesRIFkQ1Y4ReSwJicK8w6fib+8inklT+b9i5v?=
 =?us-ascii?Q?vRDuuCO2+zXdfGvqSxdBrHkyMfENh9vzHaMCuTP9idjPYzKYWiydDFR7SbUv?=
 =?us-ascii?Q?h3/w3CKoImsmEuDzAfKRcVGJdpDzy9CYE0qjZnxk0FO2KP95wYzdgfzDScDf?=
 =?us-ascii?Q?A8MI/8BgiBKmowiSAvfExXvr/8lbJAWRweFkJPiwrL8yNODeMdBKxFlLpFdc?=
 =?us-ascii?Q?oX0x4cMvQNyXuWxDyl44O1BoQq7zZR1wFPrQXyIwdDMX5uaAQDYCmEips9M8?=
 =?us-ascii?Q?hleEMJbgugTf0rovdQuun9u5bmA6jKV0aN/5h4z6el2Jfuw0ag7sy/b180NI?=
 =?us-ascii?Q?A9IUcG1KwTt+fuyRMHiNDgzz/0ETZVo6nkHHD2P6LmJ95y8X/kCnL5yoOCxw?=
 =?us-ascii?Q?XxrQIYQzNiXWKmwViG8TlB+TNNYEreDiuOTtAk+ALRd9+EnSXZ94tsdaHHfc?=
 =?us-ascii?Q?RGShJzXz2kEwxSZqcjQyh1zlbeDZqbC2SyN6WvBdiCdvrHdfo9ZE+acrwduM?=
 =?us-ascii?Q?gYCNIOVjup66djb/BB8O+uZu0S9S6eY4+UwkYOuiChsEkDCRzPuI65EBSrLo?=
 =?us-ascii?Q?70mX5VpFmIJgZaPzwbbpIBdx745fjeigmwjsTJVvaipgfi8iv49HMCAPlpBv?=
 =?us-ascii?Q?PtMhBnwMsZurP+DQgnE/dsgVm0/crfSnA7UYaWes0/osxKt1ZTP3ji/fMvDB?=
 =?us-ascii?Q?+q/pXj3vxg33fvVzTV77rVJWXtDJT+axOT5BZULiqTlfUjZUBWY7L0AER1K6?=
 =?us-ascii?Q?wIBwY/thQ5mpytz1PP+utZH4LiBwjABN1P6ksBkftIzPf8+SJK8rO4KHfuo0?=
 =?us-ascii?Q?fQYYV3OhtKN2v3L0XqbbI7qLJSbWazvvKP5u8OE3Td45OhnI6ZP9CwoVJvbP?=
 =?us-ascii?Q?8rWUcqcLKFTpJRu4Cj36T7eXHv/lrwdyrpGoavt6te7T9YvYKqptZjGGgzYB?=
 =?us-ascii?Q?O2UubFMMgIlrsdfJUbDlMEGdcrAj/wLwgnOaisJwA1GeWRSd+5aKY1/0Q6dB?=
 =?us-ascii?Q?tKvUXbNivJyys/vhJTdlu/PgWNih6k94zt1ZsNBCaJS9T0TmsqMuO8FH5yvH?=
 =?us-ascii?Q?xFV3C6PP1bzVpwvw0LiwgdS/L9MDuxDMzVRiJ+vFFfXIaOP1Z5ZT1RRI7XsG?=
 =?us-ascii?Q?AM7VMTi0O6472g2eD4q8FG2Hl47UMzDbuQToTkC4RhQEdCOMtYnMlt2EU4ew?=
 =?us-ascii?Q?Usr9WfGvskvqMB5CX2YI0T6H7hksUXfdKlYmK3lEJblBO9cga5QxvhZY8mYJ?=
 =?us-ascii?Q?NiBeclyXt8y2xuR0ogAy2Xof+M76vhbrj4EiBCDXUgD0OVT6MgcKJhHq2/bz?=
 =?us-ascii?Q?2y/G2LIsk68thfWgRMxBSHhAqR+Ait+Em17q8+M5ZNREirVaXF53ufsBwjep?=
 =?us-ascii?Q?brWdrVGeF++bbKE1hfE3ehkq3J9a8aWsle6uPR6J8EJslWC5gsT5yMFJ9rxC?=
 =?us-ascii?Q?UzvZ/xpZf9HdXtPqhzJcDeNZyiZK9yGgPmAV9SFP5Ei1uHxyTEmfnM1+BHdw?=
 =?us-ascii?Q?SxVofaz3pMSZ0EVGNnglysNC4xFjhjZxhwktn/f0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8242c7f7-02d5-492f-e9fd-08de2bcfc551
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 03:07:30.1330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmJu9zO7dKyZrieCeWO3O+lIVpXi46zi3wz/M6vsfmJrkIjx6iBZip4sE7tx96DXyUEjI2C4YaZLqCCE5Pc3Ug+WD4MwM4hzaywMDKJ2pOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDAyNCBTYWx0ZWRfXxuQ1VYmZSmUv
 gu0axyziFR0O3OyuAp8V6CXZaN028uEkDmhF3ibDo8vlobv7c+319T/4NSX40W/I/lFA3oqczvC
 QabKLgJRCmYkdwfvu1pw+QirLKMr1KnUJVBOE/NcDcmhrjqzhn7cZM83tKBKf31MFrHwbIFjEeF
 QoqfzB3ssuH96OxquRoqeak/kQFOY4pLklkbGgWAasiDYoYxza9lWfyW9B3wR2fmqrIkc76I0m5
 Oq21e3dEU7bQFOwYii4h82uoRYpUoSehh+F1Q9z7amwvKenJGFgBdRMTuH/IJEOpHpfKVRZcWvp
 DWbAnM3w7QskA2+74/SI03VwsGfbK9psc5267qPKgc6qIYYIIw5voLbPWg6U+cIMW3/DQ6HI54m
 NpnFI8zDt9chXWtZq3Il2fpbJjpHYQ==
X-Proofpoint-ORIG-GUID: i3JvZmdKBnP_Alno27SgBF5PU1HXtwaa
X-Authority-Analysis: v=2.4 cv=Wq8m8Nfv c=1 sm=1 tr=0 ts=69251d75 cx=c_pps
 a=Q5I7zFPfgszDbE/a6V3qwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=QyXUC8HyAAAA:8 a=smu_yoIS2pISua4-c9EA:9 a=CjuIK1q_8ugA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: i3JvZmdKBnP_Alno27SgBF5PU1HXtwaa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511250024

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, November 25, 2025 10:56
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
> On Tue, 25 Nov 2025 10:29:53 +0800 yongxin.liu@windriver.com wrote:
> > Subject: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI buffer
> memory leak
>=20
> Presumably typo in the subject? Why would this go via netdev/net.. ?

Because the only caller of intel_pmc_ipc() is drivers/net/ethernet/stmicro/=
stmmac/dwmac-intel.c.
I have sent both to the platform-driver-x86@vger.kernel.org and netdev@vger=
.kernel.org mailing lists.

If this is not network-related, please disregard it.
Apologies for any confusion.

Thanks,
Yongxin


> --
> pw-bot: nap

