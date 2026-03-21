Return-Path: <stable+bounces-227757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIozJhJ1vmmZQAMAu9opvQ
	(envelope-from <stable+bounces-227757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:38:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E442E4C97
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ABF93009CE4
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8112231A570;
	Sat, 21 Mar 2026 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="M5qMtsEv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BEE15E97;
	Sat, 21 Mar 2026 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774089477; cv=fail; b=UaSU4bLLzBwlQN/aNoxS0W0IVzhk8+4zORHOkKBtg2OwLbEEHm6s8e9hv0D4ztx9Z1WOWWwMiaoE5tL+MQBnU13LSOga67E17iTJn5FdYAvcpIWan9p0e2Se31H1vPdhkqrQXPos9dJ5hK33JmgrWha7KfdxUu7q9eUMSNPKD70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774089477; c=relaxed/simple;
	bh=1GMPG8Dgt8gFfuDcNEzY/Ub0Yd8R1+FkCT2u85OQ6t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NbtM1YaShxD1XvehrGm+q77kKljC8Pxy5Vcn78sufeurrnDEjrIB1tV4osvwRRGbLNxJlVdr/QMGYBxEUW0F7hJGZPPyKmf6r9cNI2LDMFNtEh7HnuR2MB/Ti5ZsuSYmOxXFYfIVwO2Fv3JVjCkEDmfkdeFFwtDGVY0rxe3ZR2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=M5qMtsEv; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LAP2KM3727555;
	Sat, 21 Mar 2026 03:37:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=4xL+3OZI3Zv866SYr1eQDqkYV5tIB6Y8aLleRB4w2/s=; b=
	M5qMtsEv16yO2jFyg9e4pYIChYa4UVCYE2x6tCJvUYD1WuQovSKEHlvxead/ijjx
	4kUULJjWc3cOKJSpTVSnBPojU8I86XZwhXZZbBbgZJptnX/RHl/rVvTJpMJXAcOl
	sh7Qu3+if6nPNgH7aZo8H1epQYLEU69LbcLpoJLW2f3FHuBTG2LPeP0ghvPKEoDZ
	2Jw0JPUdJ/+tza39AP/N0rKdfFAh9oCCzh1RnLsCq8XnHDKKwrQl8TxSgA5npDpr
	X/yZqti+NVsemUI9HXx1fmd9bV/kiNzhZu/n1tcmZ5y7Xb5XfEX30PYrYTX9hzCL
	8pEHZXgVTLZ4vqKF6V82wg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d18uggvey-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQvTmUKGyyto69Clf4AEFGFb1BefQaW4kE6Sg5Fz+nLkDc0/eAeOxOp3m52tHatWPEhNjsuJ6ch+sczfHPIuLjC5w8a20puwSSijMXjOguI/5Etjzt3gr73SmQw05kjDgO5qMa0qsHV5T8RFyVfrpnRCzFfURgYIrhw2cRYnIw3uPNNeTEZdmRaej5bYuHdVma1QT93d2ukr9jpTj8ZJia7vut7SOkeGqSy/9ebnJiH00yg0ojErE/iy+EFUKatHDFKWAqOOXG+PYtGcND3qXRzMPHraYmzTWUgMoLwsELmw6K7uZtGDcqpATR9SwggUJEC8PFXQSibnVWEovY1UXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xL+3OZI3Zv866SYr1eQDqkYV5tIB6Y8aLleRB4w2/s=;
 b=grWraSk4VLr6McuHwPGIUSjClWmIEQj3cmzNl/RxZdwz4LDeYzAs1WY2eb3+Fez4PBOJGn+kJc1FYsWZPUSouaH6D34Zv+Tmb5PyKhYFWPKcCqMM1e5E5aNELJL6hshdk5GFFWSe2vyxURKOtRy9yZKc3ZPKUb2uKycyuITCVIHZAbz1vTDblFallwnAhsirC5OcCXZtPdN7nCGmpDBGWsZUPV1T1E0Mr0iTJ6UiPdoOPcSYvhaUEcujW3DpZbXTWgOJgZPDCn+KrVma/Jy6rLfxGlQyT7APP++NnGTYX3hWxcC0U+8vxxG6K/tLLFxKbSwg1G+M77i2WddaxrzGfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Sat, 21 Mar
 2026 10:37:44 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:37:44 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 3/6] cpuidle: menu: Tweak threshold use in get_typical_interval()
Date: Sat, 21 Mar 2026 12:37:18 +0200
Message-ID: <20260321103721.35114-4-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321103721.35114-1-ionut.nechita@windriver.com>
References: <20260321103721.35114-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::7) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: c22c5c55-108e-47d3-738c-08de8735e2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LIwJr12av/uNqSivDHdvJZF2sIKAyTgfXw/ibipUN3Wr2M3MN4mFKohZ+qXKz8gUvQC1zGQvvdd/Kwk8kA9rdS/WgM+Ro/kEbvSDbiCDuFZKZV2bCzMjkNM9BqAnGhnc5j0RcGenbzvRTdt+ZqydnioTtEI25mha8QEfIYW6YYpYsiKsOvkr4WpUO2g3hKnJI1gJLfLxl6BuT5BihV8hg0DFY2pVduGk+eTP40/cu90jVwrng7od/TeRgJRJ0xD2HSc2Rs+ShLen96UWM3W/Z7yLdYxPoRYbFHIq2kqpFn8XNQ2P8WP+Y7QfU2oltzU2VFeHCyCPpWeurP85f+OnQZVqhIVTcjSEHWFYZNf2Pz4Uf22kgT8G5DbHNuQW8fjBEiXsD2jNT+nidgcEljN6SA8eRu/MQ9Ibi1NOtvVFXE8tXXtqt5QutZY2oLT7bmZ/slZtwyIlOTPcbpbHEBtZ1s+qdK5lozH4NTqe42k+43HI8mniVKYEHMTA0n34M5Kr7yEC7WeytRtZB6DVZfDL+xs0BVANCag72jmZ1v3GDL/xhoX+NbaN9awNXktQ3RQe37WRmVgp0y/ZC7kg2eQZ/SOi5Pj/KKjfpbnhOiuBPL39ylJbBvo1BP9/gYGLXP2OTzDahqw644SeQsCRaf6t44ZQcIxWnF8cxCXMJtDHudx3n0YG0RscqYrMF/mB/iSULOmw4SiFPcn2Bsk8UfuW2S6HHV/DyL8zTkjl1VzwmSiDAJLEWsvXEajCvXRcE1fe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y7WdAGhiQUcL96C5zIwsfadqPVIOm03LqpGLO/SnTCWH2OfLjf0XiB97Eh6r?=
 =?us-ascii?Q?30jMT/dD/H+mI4MJnnBM6l2BTkglirdSR7VcXF15zPDmdKiTRFevFmdh7nF4?=
 =?us-ascii?Q?JLBuBliyMLnH/8VjxwsE9Eumnz7S5+AXbKYVACnMy4C3vejVbYiFdSiJEL5L?=
 =?us-ascii?Q?BgR3FOdVkNvtENKpAcbGVgTx2Va5hrgVoW7pTBGRpLUIJTIsE9W4V8RvO3zJ?=
 =?us-ascii?Q?9fFvutMLLJKKPq4Xzng0N4bZZxXIiDhVWadxW4BrjSCynAt2yKt0EZdoZds9?=
 =?us-ascii?Q?bz69stc8c3VSOhaFaphi+QzjDEH7v+qE0Q46KxeK9XrHBORhN3wNWvhtR/Ss?=
 =?us-ascii?Q?13Arzg3R1hihRvWTDimCgm6M/kPY9Bk/758IsmrOocEyPrBNM9e6ZkqDe0PI?=
 =?us-ascii?Q?jNdeWC5pswgn8N8bQLcv3VCYD/BdX0k1D71H1a05pAPBTAlDe+xten11A+ji?=
 =?us-ascii?Q?9MgRB3gVIWoKQpnhtU1gepbxSYYH2BD5HLIM39xArBdV99Lp59CmWBJyssa7?=
 =?us-ascii?Q?/GdAU2RZWkWQwgO6s5i9uAGgqDjD16DIehCWstO240Kp3RQkbNqN8Avlsy/r?=
 =?us-ascii?Q?7gNwYYYla+FcqbJfORryEEQdCxbLljQ5uvIoo9P64Qgip54cbjfoVIhWdNnE?=
 =?us-ascii?Q?WsgVIjJikp/4jS5eeZTl+BMc/d7I3MzH3heVQ6VJe9BBbYThkNt3vdtWXubZ?=
 =?us-ascii?Q?SAazhPAFkgbsn1p7DEUtdEKyHHS+UTC+mYJ7GYyGNUll21ErcAtRlB83V3yr?=
 =?us-ascii?Q?QrfwIBXhNmdwI1TbW+QMzK0myOoLNdNLVdR6hUd5utH7jLVnVmqHNWyWpQMu?=
 =?us-ascii?Q?mJUUN1XU2H6bw4Yya6XY7zFvcdIzX7SVxdd1QJb+wd9ztQbA5Epg2NkDzfZ3?=
 =?us-ascii?Q?UPj5PEIuoWd1xu4i6VlI+j3IcfQkpXJ6M7Y+67qWV9laTNkclCTT0J3jDdng?=
 =?us-ascii?Q?Ce/InPOpGsgljV4fmVPx9xsUECTECEo5x3jn2EopmuKe3zwjFUMa3j8krfIk?=
 =?us-ascii?Q?ViTZeijLilMFkWOj7eUeDzuiUyP6twkwfjisztRtzYzamK2vUysnvVWThjwo?=
 =?us-ascii?Q?d3RrbGoy8sM4/I5SVmYKsCHBkxXBc4k5LhWTXgmW5HEy/aWLUh+ha0lzP0h/?=
 =?us-ascii?Q?roJxdzAmSVXmmpGxAXzieKIAZosR3hdu6jQ6ADLwVy/fHodbNxSz6jHaXtYh?=
 =?us-ascii?Q?Dl/Dl3gE8nAVix9rld7dCN7x8vpuPXXXEVU0ijoZ4AgJ6Lx3H/IQs74Ovi5v?=
 =?us-ascii?Q?R3xBtp7DNfPZcgrd5EjXZHfuaVrwt068lqYu9zrUlVNajCrIAbLvd6KvKVFc?=
 =?us-ascii?Q?CZa6+peM3/52kEWcnVItRVkLlQZWSlqy/o7nwJk/MAHcX89y2BfIgvZBxJxf?=
 =?us-ascii?Q?/+xZwoDh48Ry0x6qhQCDFysXLAjWmbHyNnYVqktrnsdPDOPqQQJxX5AbWica?=
 =?us-ascii?Q?L63TsRNjJLxeK7Wsxbr2c3b5w/PvH8dl0UWb1X+dLMmukWr5BfKi+4C9WywS?=
 =?us-ascii?Q?mCjCYiVvs0YwLKKRetF1WMX/loz2C+HFoX6UtmnOMcbUBQRa+di5Lw77jAfL?=
 =?us-ascii?Q?l/cvkn/pr7R9HXusPstBsizZ3f1TJvAvZ1mfifrsHECuhLVSekhoSP1Dia/P?=
 =?us-ascii?Q?HSWR8pBpEcfHsZsX9qhcj4kArzktRalxAeJ8kAERNt7au/jbhA5gmm1RKses?=
 =?us-ascii?Q?FfrmphRNac9Uxm5mHpNCpdvarZFlZNWKNW61f7MytvMY6abqCHmx6yl2HFFs?=
 =?us-ascii?Q?Uf/H4qO2vA6+gtzXvvzUgkGxueNaWFo=3D?=
X-Exchange-RoutingPolicyChecked:
	qFNVNQVQyh5njoADZnW/vMY0A96A6M2PyJPK56yyaSpVuW3vIb3L3WURG5OSX4ww6b0yC+ztnwfNrzS5x6PYLE43XG5d5aQIApshyKTLbykbLrX2LN9rv8YYuI6e5A9WUAI5LHZF9/cyRoPUgLI8hqUcm/ImHSlMNzfPvaXnF+qCSuXYsqIAC3hxAVJCKhnLrNSQsS5TUrWzxYDmdy4HsdVwUfBRBfexsO+DPO80IKf2IaZc32qL9kKNpYBnYoMBzKTZMSpt7wk+c/AnXalmSbbS2eyvmFgToy3XK0Qp3bZMx+xBy1yri34NAi/yvT7THjz3yB0jGJRxdbhSIBRAnw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22c5c55-108e-47d3-738c-08de8735e2d6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:37:44.6724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5VXNlS3M/Z0J2fDBzEISPc7VjN45MoWqHk8v0YgoY8/ApTZla1Wy/qet1w2iK/DmDs+71JgH+lW/UY+wD2qb3toyqKejkYtwj0JZvGFQy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-Proofpoint-ORIG-GUID: sHQQSMR-yPka2UuLOQRIYokmngp1O-Mf
X-Proofpoint-GUID: sHQQSMR-yPka2UuLOQRIYokmngp1O-Mf
X-Authority-Analysis: v=2.4 cv=A89h/qWG c=1 sm=1 tr=0 ts=69be74fa cx=c_pps
 a=DTw/Ji8TAQQrvHP5vDPzUw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=bC-a23v3AAAA:8
 a=p-nOP-kxAAAA:8 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8
 a=VnNF1IyMAAAA:8 a=1Zo6JAK-eCxqH1vQYoEA:9 a=FO4_E8m0qiDe52t0p3_H:22
 a=XN2wCei03jY4uMu7D0Wg:22 a=FdTzh2GWekK77mhwV6Dw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NiBTYWx0ZWRfX7TdkOqdne5/V
 wa572pvnsLiWwSdwy+bBlgVW8hJc+TVUlmfDNED5Faymw8wjBXFq+SSsT316MALf3K5TIrd6AMD
 NPPi6rsRPLAOoefdVCt0Wsa2KQlI1hIg5wg6PbPKgqy/NoWwuhKJhRjKoNapAywN7GY3MGsr6qD
 o7FZ2yZd2cvbodAz/4GSyLamje26EAf2YYYg/GOC0VWE3yY/QppB/KbEodZJXWxBy0H+b1V6Ktr
 xEUYQmEBwMjWdpVi/mzJWul33cw882/hPamePIfxKmXMrVB2LO5YuQcKxLVZYbW0nGClyxRAEco
 CIUc2A2TYstqbPj9geSPfIE1lSX/NiJhFPKUzmGzDqRWBcZvvgMB8QXXWb14FrmHPcr62GY5vQU
 I2UnqtWrG+5+nQ0bO6+9FRWdNhRzkQZvy6WuwNAIq3mGgu5ZE4MwnRR9/zcDVo7qK3W3/QXBLjl
 UnJD8zZdy3Ih8ZrLhuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210086
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227757-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,windriver.com:dkim,windriver.com:email,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,msgid.link:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 18E442E4C97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 60256e458e1c29652b2f9e4f2ba71fc7b09bd30c upstream.

To prepare get_typical_interval() for subsequent changes, rearrange
the use of the data point threshold in it a bit and initialize that
threshold to UINT_MAX which is more consistent with its data type.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: https://patch.msgid.link/8490144.T7Z3S40VBb@rjwysocki.net
---
 drivers/cpuidle/governors/menu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 8943bb8f19190..96bee77b8354f 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -124,7 +124,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
  */
 static unsigned int get_typical_interval(struct menu_device *data)
 {
-	unsigned int max, divisor, thresh = INT_MAX;
+	unsigned int max, divisor, thresh = UINT_MAX;
 	u64 avg, variance, avg_sq;
 	int i;
 
@@ -137,8 +137,8 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	for (i = 0; i < INTERVALS; i++) {
 		unsigned int value = data->intervals[i];
 
-		/* Discard data points above the threshold. */
-		if (value > thresh)
+		/* Discard data points above or at the threshold. */
+		if (value >= thresh)
 			continue;
 
 		divisor++;
@@ -202,7 +202,7 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	if (divisor * 4 <= INTERVALS * 3)
 		return UINT_MAX;
 
-	thresh = max - 1;
+	thresh = max;
 	goto again;
 }
 
-- 
2.53.0


