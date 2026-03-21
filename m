Return-Path: <stable+bounces-227760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO3ENCt1vmmZQAMAu9opvQ
	(envelope-from <stable+bounces-227760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:38:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD192E4CC2
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53147302DA19
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E431F994;
	Sat, 21 Mar 2026 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="nkoAB2he"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7C2E88BD;
	Sat, 21 Mar 2026 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774089486; cv=fail; b=YHXyZrxfYjNxHQqLsxo1UalxTk8PZDfRZjlLgIXbe638cz8EhIzNdGldbm06KwNMHNCzdPgt6lFyvTrhF2EbAKdZRurzKtj5pZLWmXxDSOIGiRDWAX4CK+uS2vEnrflKDb/uQ9pYI3zn5y/2dcpezd0XYUwYoBveAV/VdFKC00Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774089486; c=relaxed/simple;
	bh=nl4WWQKJ3IXnd0QjqIChcBDUwCu/Glt9gIyYLAL9Pg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZoS7a/XcHlDv6j2i1X8LXIkWCqZFDwB1/vDdQxpb4+eANq9sAo9BcDmO98HrC89XkAYCIzolwEhZPEp2gusoAMkd4qYP2MlU+EbnyKvomv8K7XCwwG+MO1hZLLux/wZtf+mcXnLTAUo+Hz1/TFTBw4jUXh0sAzltPOFaQdam/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=nkoAB2he; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L9uEuY3525421;
	Sat, 21 Mar 2026 03:37:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=yAh2yy20404immphVDrqBUiyF6yC0Shn+gQR4gThVgs=; b=
	nkoAB2heUf/mtrn1po2Z2D7DTcd2k820e+XZnTovYFS95Xr7ObDmXk2wyzYoP4mo
	zl0ERsa/Bmc+aHjHM66t5t/NpuNcxpVwnU04TR+DH7da12o09IvUDmNqsZzDjjrj
	fzjYtvic9cul1a/h7PQ059bW0rvqbJXMtvnx3mp/iPBEEsRL3k5LVimjHrovLbe8
	RpcWgilUryKCsfA9NVKm44VtCpSAff4emswhwzbZ8jnXxOXcR6jY91IYh+wX/Hia
	V97YuENOAipUa95SGrzYNB/wZXhEfxI102nG9/PsA++rRdbJr2fLEc2ygcYX9WQr
	6DMQG/tOXcldY8I3f/L2Jw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1pky83c2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2rk/rT3azJRTo8gDLT5T0g02XWLSx4kr/WjRGIm58BjdWyeAEdaJRcLsjxSDc9+ZYRnqdu0p23APEehx8BIYOzykUDXgqnqcQZhKqu/aYdef3ZCXmY8/0+b4sLRBlVepW3md6zjhxxEQTOEaLxf94U/7a1IsZ+PJH5tRZor4W2OgHot2kHh/wX5auBeNhYmq/v+wWzDHbr20DTZiYJxgQTcANiIDhCspTYigqTs/jKGHmnq+YTfYQzx0XyLH/0MbnMI2uuz0vPsP219/U2I28Q+Lla62S/Vgxe2yTqgoPCUBKdRD21Hf8YlLP/nQXE+8C4sc4MR/YgLdUTV5VxCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAh2yy20404immphVDrqBUiyF6yC0Shn+gQR4gThVgs=;
 b=RXa3GBXpbH+J0zeJlNUFetujXDRLrLG4kLXazGsaxXVnIfM43RbbFqND63TeSo5Z2Rp26gHJ8iitYuvc4gdnoXIZ94EZJ/gzdGzx+vFQzMysbcSAtxsuI5HXa8UpskuTEzVgX/Bemigsq1/R8f1NxYyW7/AVm15JPQk+ICJZsCRVBFLDlWw+gdZg3K5yEqJlC/vRDWwiCWHvogw6tjNi2/x6BdZ7s2GScCdqEnh9ISG/seeW/TCFNHKwOLchXa/v6TSjPta07hWQrRd5Scb3e5R55EwDSPMkqJxkmP9O0J5QQn8ZPrQ9N3r9kJsIyQmsjoC0qK4hc1l8cQ15Fc5OXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Sat, 21 Mar
 2026 10:37:54 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:37:54 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 6/6] cpuidle: menu: Optimize bucket assignment when next_timer_ns equals KTIME_MAX
Date: Sat, 21 Mar 2026 12:37:21 +0200
Message-ID: <20260321103721.35114-7-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45a039ad-829c-4952-ec18-08de8735e8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ThrOLehNLiSFTynJqbXho4rgbcr36P4/aNeMtWPMnpGXj1ZTXgQvGUGJkOaEcblm0jG8qLfplWUOXkza27zQYVugagi+zuOgng2ayfWUSbn8YkzQKdUTX8vXgsSMHNqIKbv0HIM+vvFIaekz3om31F5CRfctbpczkQlKTGN65peyXoEd2MivUNK+Y9NfnAUmcxXVwuxKLzF3TIHQxnd1pKx7vVPd1yXZwiyacyswcTyn49FLIiEZlU+eQ1+XcihzjAbRzeT/F0ZyqZIgM7mgBp7o7DdnMMi31tuit5CW3qnobYo/b4F+/9HbMNBra1Gl5FlA9AOfo0lTPmeyKVzfM0bakKCcyqce6mMqX/RY2LrzG121oogasLchk+5Naw9WIuYzHgtLM/7gUu6KsEdlU5eWCW6mnkH3WP/2q4i46nf9fBfYWALeuJZb/lpqMMoXWVKzGqa74RLLFdj/gGLcvYKh/AppG80oWJfazJlPdwGs+HCCvtgGRullKD4zDsPlO1AbQ5zWQgs8aNFhTRBW5DLBmibOisnIJCuwRGgwOeC09v58mgFR2NA1ndU50GN3HC+yEUaHFb07QunWBKrqV/XeyWs4VTKkTIqlpUOaJt/9L/LJG+PSfQmVWqx7yu0wTVg8lYoYpG33Hiheyf618KwHpjwfyafl/oNr1IFaaKEsMA093GhIdWRZOh8L7oZyu0FNuG1BpfSqIg/FdwO1HANqFoiS+DZmDjomfvcy+r0mKMjP4+6c2+oS0IM1JU/h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Fner3ttU9VM44oP//aROX5tFcYrKFsR6VMQ+1boDemLpKdMqsYvIndffI44?=
 =?us-ascii?Q?WOij3jbl3uZBu8k+OQ+pkBWZT98LJ++nIwYOyLf5FjZQUPkSMDfEwJH+WkEY?=
 =?us-ascii?Q?AlVkMsaiQhnahsGAnvZlj+srVYD4o7wXMYQduTrY6U7VVfDNLApXedfE+qIq?=
 =?us-ascii?Q?JUVUBX4xPDcdJHgXIkAyVTg8VXiImPGkmVgXMrf3GtIy5N8XxR+UdjIhvogd?=
 =?us-ascii?Q?fIsWOop1sukx7BU7gaLJkO7+MtvpTreC9bLabPgTf7M/wNOMu6Akhlqhs504?=
 =?us-ascii?Q?faIi9drLiDuh0eHyaydK8aDHaHd2y6Q+gwkTUSEC9ggmbSBFjWPyM0OkM208?=
 =?us-ascii?Q?XXDa2yr3JfH1woUQWaP+rd+rUWgL8MFjdqaGb9WQsTD2Aj8d5Y9CuJ+DCaS0?=
 =?us-ascii?Q?ge1GOtlPCnVul0a8gewNi4b4SnIw/vTrZPO7CNEpICOHWX/2/dla5JSRBF1E?=
 =?us-ascii?Q?uRKa/KoIXTzHXBV+ScsgrQPD6KMYJ0XTQb0bFEt/w6fmvEYgSOTqsukEGuAK?=
 =?us-ascii?Q?YfCjBD2+Q8ahsC3NJXswjFn/BpYh+Zk8T2ty1DXrvOyI96eyhir8FE622DVO?=
 =?us-ascii?Q?Hvv+4+VWDEtQRT1Eyof8w3eZs2wPvS2tYS+++in8bYy1EvMhQi76cmo+bcOg?=
 =?us-ascii?Q?kj11G4cyUVumxtioBsEFziR3pNsxc1GRlQEcBYalBKJFxXp57CI82N6PdtT4?=
 =?us-ascii?Q?KrcSmvSrnvPXNAMndgtwJ0iUyy/P+guZv5MwXGIXqTAdSeZXZwiyU25POMpP?=
 =?us-ascii?Q?SSkbVPe21tXEB6N2OOySsUXTdVhIwpoye4WiseRe1stH8M322eICtfMGxGW+?=
 =?us-ascii?Q?aeq26Yow9Zd2NTqdPS4eDzKJkkXYqpvOlpZckvteNtFO5EfNawGVQl1Ij+r7?=
 =?us-ascii?Q?YPUKWDoBVf63DnAj3RE36U7dGO+8Dq5+7u1t94Aemun09D3oOzWtgkN0NomA?=
 =?us-ascii?Q?sQRcP+Fw/vXsiUjxorsKR1Y0SHXkApDh3r6kIZ/gDhnFvOS+Zn6SZvOdKW7b?=
 =?us-ascii?Q?3jCoduygDwPIRAOkF57xFggbtQI68PJGzBLdj3b97ajhUPxGJjdrd8RuuKi3?=
 =?us-ascii?Q?0xxkZkFIuNZC9EdKT4fDBFXgIPM4gyBERftptGZ49niTP5jG0FnycqWo/oW5?=
 =?us-ascii?Q?VxTg+cJXKsOpsHrUHwnxbg7LyUwOgTwe+VU72Y5MuENeitDMHq2YpF/aDrj+?=
 =?us-ascii?Q?GAjMIEEtRq6sukn/tdqT5RJ8EU5XrERDyrX+MQ54bQrwZgrRd2ehg+810uq8?=
 =?us-ascii?Q?Wbq1g6SgASLhhFWgcatQ6gazVBmCIDurSaCUwv0qSMf0OYW8B0twlUFxLx1M?=
 =?us-ascii?Q?KnYBXnPrUcQOC1VqKUaaHsS54n069eV6FnvrCec3qDjn5uECCHgBZKANwpwG?=
 =?us-ascii?Q?d6yPA1NK4VjDoUlhny7mSFZR7ggQZ9k2i+HWDVEkrQ0D7s5zVY8MZdszovSL?=
 =?us-ascii?Q?3LXpzx8SLXbNFPqKu1hLxXEWaXT25MXQlFets83PsOTd0WbCpuBxEUqbZtJl?=
 =?us-ascii?Q?pb/B5Be4dMJiCINP8934Q+hHIWXka1oy1ytzn2qnPz+ocMKdNUe/j3G8T/c6?=
 =?us-ascii?Q?a6KyQ+UVI3B8RG8DDmKDAVSlUCAZGGU3r3JRdrSmfQ8HpRtILj7M+LfHrodm?=
 =?us-ascii?Q?eN2ThwTQtXWjfsaQOYUbs3WQEZZQMI164tUyIRz99BV4dpI1UKXlZih7kZMm?=
 =?us-ascii?Q?GlR98MLLQ9dXNfaa9k6Bi1J0feScUMuYAWVSP9EvuJmLb8CQKCad3NXLq8TC?=
 =?us-ascii?Q?37iqT8u+EuidBB8J1Geg9ikkvL0PwqI=3D?=
X-Exchange-RoutingPolicyChecked:
	V9VhVDGzrXdBAM2TsHCapILaCsjP/xf7Ru1gKQVtuZai/HzbtZYgV9aKNdRJbyT8tPf1wr5lKPz9yrMGqxaC9G8cEi7rGjVFU0XdAmbBi9Q/GubiHzONOfAVBhMVaEoSm/WKPqJiJpyILNfgdp19aLYak1NjnOUNDK81hEny1Vcv3j69wThAnJhW9rTymUIlINBlW7y6N2J2l9dze5XbWBNUd439n8l/LmHVzvAKXMXcd5EYLpiwx0NMVxnzPDXLw4BymcMC6LGyHsBdfEFJgQeTa8aXpgfs3PdvpnbtiwmDrLN/C65Iqs0ecyV6hYevy7p+CHmFsD5MGBURsKf/7w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a039ad-829c-4952-ec18-08de8735e8d7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:37:54.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gor4UCTTYxZfOzF5IhsPnmeiYujN6Z4W5gvue+WFlHsvo2bdBpDoynneTgoHFoMR5zh7YT68/r0uVZJe8tIRe25vKl+hF67sbfYf75o8WO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NiBTYWx0ZWRfX4hWgSLvxoLXJ
 hCXOVNiLp3MLRqOvBDe9OjSCJnApsvCrnCEG61bGtR+8DkBnRtPDlen3h2B29xp+azhveq+B4O0
 RVU7XbhHTE0o6SGKkd9AlCEjAGfe3FgiHOAvk/uNlnb8MnxJEexoWGG6MkAVa0qw1psYh3Lforc
 4EwNelvFbbEAS6H5J5lCJqt0thDhHouZdcPQUXnHSpQCZdF6Tw+7R32gcEv5qmuKAwezJPe2oGF
 UtEjzAAj+ngdoO6uoOHPyAEtnoT/uf6vOoCVdF2gxHxb2q/ttJCcEyly8cHj7jV7sb5UmN6Kl/F
 TBuZwqxgmwqPwqytFvMnFHpar7N1t/3nM0L2W5I3xA3TJjEO6h2wZT+YnMZdrtdHRHEyHQzOFlT
 pT50HF7i9vtnjtL+d6GS0xlI5rYoWCeqIuBli/LYHuyFaKaYS4woI3JEp2EWMzvPSYslY2Vy/nk
 8kHgvLu7W0lqvph9OWQ==
X-Proofpoint-ORIG-GUID: rXLUr8Epg2qjIK_L0O38hQRq9dJbCYJl
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=69be7506 cx=c_pps
 a=BRu7lVsKyHj15bVqb/Fc8Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=bC-a23v3AAAA:8
 a=COk6AnOGAAAA:8 a=t7CeM3EgAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8
 a=nFvYDp7MkW-kaRE07g0A:9 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: rXLUr8Epg2qjIK_L0O38hQRq9dJbCYJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
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
	TAGGED_FROM(0.00)[bounces-227760-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,quicinc.com:email,windriver.com:dkim,windriver.com:email,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email];
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
X-Rspamd-Queue-Id: 5AD192E4CC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Zhongqiu Han <quic_zhonhan@quicinc.com>

commit d4a7882f93bf2520315d10ab600ea4701e22be69 upstream.

Directly assign the last bucket value instead of calling which_bucket()
when next_timer_ns equals KTIME_MAX, the largest possible value that
always falls into the last bucket.

This avoids unnecessary calculations and enhances performance.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Link: https://patch.msgid.link/20250405135308.1854342-1-quic_zhonhan@quicinc.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index a18477ecce433..ca863ba03d454 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -278,7 +278,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 */
 		data->next_timer_ns = KTIME_MAX;
 		delta_tick = TICK_NSEC / 2;
-		data->bucket = which_bucket(KTIME_MAX);
+		data->bucket = BUCKETS - 1;
 	}
 
 	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
-- 
2.53.0


