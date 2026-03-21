Return-Path: <stable+bounces-227753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGBeF21zvmmYPwMAu9opvQ
	(envelope-from <stable+bounces-227753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:31:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF322E4C03
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A60603071F1D
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9C5316190;
	Sat, 21 Mar 2026 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="O986LigX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03E30BB9B;
	Sat, 21 Mar 2026 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774088741; cv=fail; b=cj5BEZP8N3cPCWumls1+EsD34RhBLH5vPTQa/OJPjgflELfz5RK+bVDLckpqbuWxgdyKD8YVkG/7mxoyrl/OX+RFTq7nq7ypb9Pk6GEmdP+jjSgZQT/Cgic4HQryzJQrXUoIZdAJ2DGxs7NR4GutYWrM1N3xCyuFfrKLL8aKYgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774088741; c=relaxed/simple;
	bh=aW1D2XKvLhFZwaUgmHlTt5B65x0Zq2c2mqBtlsh8hy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tz33TilTcVSpPP5MVCb12fsWy6EYGElAzS0Oj4dIV8HNg1e8Velgg6oAeeaMWqQc76L1JQAJ5zv42oHkD1StijuMPGJc2WX5QD4aKjfJ5BknDmSvsUw8k+WDRnOFU+nQ21WNAg0HGJhLrhEo1ABS/unwKlJNyHPfCfwbfDbJ8gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=O986LigX; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L9uEuC3525421;
	Sat, 21 Mar 2026 03:25:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=KAZsW8SphZ4vX3RO26K59S+AS+AvllklbSkXQB/Wek0=; b=
	O986LigXmgd0tINyYtORKkFBubFGSnVrfcvVKrhDOec8rD29Ii4jHsvtbEDzYfIi
	WnqA6/jagTDV647s2NISQ2Ib8ru2Ss73Z1bNo4PpjHKYQdU9jcWQ67mSkZh+bIM6
	TynlsYthW7SfbXfQrhJZhdtvTN8nKqFc5n62fa5QbYLsSUSCCdxzMSfyg0wF+Zqf
	MH8pnVfR8KjstCbGY4JoRT9ZFIvi99OtLbxxrPWKCzVmYuQjdGgpjpK4FJiN8OER
	yvtvW/kPzuiedhU3JRd4MsMOnjZgA4rQF/Mp1Piy5rPz2F5Fnyalwbt9LcJ/Zppm
	TmiknjK3nFtW4qCZlC0mTQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1pky834r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bb2yLVSV3keEByFG4S4YpNF5+JTU6ZVoSsf1g9cJ2exi5R0ijTkdW0t3EYh12QWtKnMnZJBDUvdrJo1yM8s8g4K74FjQTQ53/EA4WCr6Xmmmg/e1MsG1k7wIyPTzylXgnTobbA887ucNbNK09gDmUd0peseDDWjjcpOg9Vqg+LS8ZK3f6iwIPk1t7RvMCzuclQt6tB/xrhQHBcSivSibYWue1/uc6bqOl3IkKeE4E2QDtAXTso3HnI4I6URo0uiot/Hw9AyxcjK2vccLF7/LkhxupotFet9G5fqFoTgajXUrsIBQZgTLjIV4PavZiwyUcksrPVc5K4Gj044ub6IRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAZsW8SphZ4vX3RO26K59S+AS+AvllklbSkXQB/Wek0=;
 b=Y4RyWoOdAb/XKNt0VhydKQdPwlT+kCslcPT6ERgCO77mBQWxhD4asHoRca2XND0XsD3EVakKue8r1+6Rj1ap/vyG/fMuDz4wMr0HMaliXUgrez01oIorU1SZtm6C+J3UvkHGFbXywJZyPEH42fWFGwM8SZsgUTsJJQdr0MlJEcuCrwDWG4Jb3q2MhqaIHj3WOI0QTIp9dHiPhqJojIp4Dxci7P7NhK81991Chgal7TdBoSqHrvi9d16RvYwcwmFlRwb6vq9Q3CGkSXuz8S0uZBaSjZtE8KV4ntIGB6wStN4mQmcLtKlxBfGHgpYhvpcGBWdKY/At+F7R4kwNOw5Yhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Sat, 21 Mar
 2026 10:25:02 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:25:02 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        Ionut Nechita <ionut.nechita@windriver.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 6.12.y 2/7] timers/migration: Annotate accesses to ignore flag
Date: Sat, 21 Mar 2026 12:24:35 +0200
Message-ID: <20260321102440.27782-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321102440.27782-1-ionut.nechita@windriver.com>
References: <20260321102440.27782-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIZP296CA0002.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::6) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV1PR11MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: d24a1369-4d82-4ceb-b194-08de87341cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	SqP7/qhBhUEAkdU32IDBudqsZKkJtA6caHQWCGWrpjtAqRfb8thvY5VoF8yr1b2v2B6dxQ5RlP+q9QobRSaW2GL2rwkUtdgAC8bHfaiO6X/+8SniLoT0Was11iLbQREMgep0T++MJekvpZO83dj/7fu3YZK6nay6OVakLVYKYLFIzR0+ay7EyiW82iqcKT2Ez9LS20mCaob/ooTBe6McZ9mBuyjsuN8rmjhLEv94YW4kDFDkzHq1RkPz3yqXZPMoSuZY8Qo0/znxJ/xqwZU0CwgDthMLGQaJAcvsNmRlYrL4QBLG4JUmxvs8ksBpyOzk6ca78ovwnharAEEbfWsI727OfHxzQtmLU06uEPVp5Nn1gsTHtfE6GLxOm3GbbLe4iiT6TvOI6xaR2S5v0cE8+SnanwIx8d/04AnbSv3b+fNbv2aqhZbv1PtLGlcbArQgenTXuSIBKPSm+llIGoLIL6YK6qNGhdfaSJg7JnKANoWTDz+G8E+eU2QPamNbcIcVhfHVeD4E5brd4v2/P0HblEGGI7aFnB6KE8+AHIbvnqi+IlF0hEblcEOvkJ9trCkWg5ratW0BN/GBYfojyeqFLY+U3jUGdzfjfU7w41YlLxUQ2nUMbgKSM4EwJwQh6hVw3fzHdMtzpdFwsGpt+5vIJD5Z/ZQ0OclE0MsIJv7m+IjAv3KlXVc7VhNuUNos+4c36Y33aehcVyOGQGo4C6qMoA8flDE7f7L3gh6Xo5yfhshQXgchabe/0uET8D4h2Ia0x5Bd8AMI3NnZsDIeytOSmQF+SyGtfAFte7tnIu3EZJMB4t+7INUxW0VIdmK1p3Oj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JlFu9YbF7nkczBGI3QovC5cqk+ITXXj3mAHi1ZtIUeUsjHKbZO9+vnvKR5JW?=
 =?us-ascii?Q?E7hQf7AuzJuMpkY+55CCyOVrQ5xgkjIokG2TY8QWucdxzZO5AlrfCNvg7z+I?=
 =?us-ascii?Q?ty091FB+3gQnfr/U0Whs5m2+sAUyDG4t1YRW38I7B4G9bpAtW2rutheH0GGz?=
 =?us-ascii?Q?vvUxHbpAR0HrGZLdPXiRx/mm3Av+rHIGcs5Xft5Yxa73gCff/weZZORleS1I?=
 =?us-ascii?Q?SGvMe5yCtJhThYnHXZsv6LtCXzMfl6mlYASDEAaBrVeUL+AVdsCUrwN8b26N?=
 =?us-ascii?Q?Ul8cbBtXuCpnihO+0dhtMcrBkDAZSxGXG6ozzgCTD629x1kzXZgd28Em6nOZ?=
 =?us-ascii?Q?gONGr4CZYxFcgOF/dJJseteQX/sO60+omG39TskzvhKOUdYxkTXmnyZuBjLL?=
 =?us-ascii?Q?+iOW62uMwz3yQd+sLjLs8H+6yM/SGak8Xqwpx9FPUqc9tG78u+JQNagmaE+4?=
 =?us-ascii?Q?s2CgEsXoYF3qzxsOOSBZzza78Nv6z8mWMBz6Ut4XWEaOKPyTXjTSVL6EDgDS?=
 =?us-ascii?Q?feEPpW9C+KsGcL9QqjZ7dUh9W6zKBLOLkHx5opVliUoHLFtK8sDYmkno6TjQ?=
 =?us-ascii?Q?q9ihdCuk5S8NfGW09OOLclb7zKnvttou87tWLj2ndg+ywsCzXq98kh08sV36?=
 =?us-ascii?Q?SO1cGZzu1U4/AWadXoyktS9TCUiOP+oCKd5/YSwBId12az/+0HSlACPmUaC+?=
 =?us-ascii?Q?5s6UR/cUc47vlQubF9JPPeZQAO0PQsgn3t2OLHkWdamhnFZZxfP9uEkezlBg?=
 =?us-ascii?Q?SsKsugFOiKanOcE/pCiq7hzxi59CJIiEGQ799N7xTBjEEOrJP6PlGZCQXG2W?=
 =?us-ascii?Q?y3b+dRqJspWiyfBp1HR51ySF9OLlwhx5MQdtqcq4ZENgCBY1gm2rSMXAdWXq?=
 =?us-ascii?Q?g2TnRQlPUi/P3x7P2PX1XYz+qKDxJ9XUEKEp9jUxmEFvImp+Nhav9u7gh6s0?=
 =?us-ascii?Q?+nWujusMqYivkwXxzMsOLi/s/coj/mMKSu0lN1xe+PNvbszzbZWTKguh7S7Z?=
 =?us-ascii?Q?M8DHhRk2l4WUeplCEH0jndW7nPv4v131g3FgDflF2EJmHiIhz4K0zzpXhrhy?=
 =?us-ascii?Q?Xtn81LuA9mCUD240ahYN/PvT3JcubXW4n21bQ7zSbKC5RtIBwbBZisGgFiju?=
 =?us-ascii?Q?gM09zWdiBGlHDk0XVQTUTnQ+SAnSQlT/7HlWr49nM+iOTduIM5BJZunfXXcE?=
 =?us-ascii?Q?A4VkyI9nZ/iDcRJihCS8MdURQvaVERMbJbmtr6HygTwekz+uuQpbZGGHS8FO?=
 =?us-ascii?Q?OdaSt/7uR7wcXAATE044r28GA99sgv2tjF/Ei4O+SyzV1loj4sZnEzcvziG9?=
 =?us-ascii?Q?88INN3iBfzxN6P34MINhd9Q1l/7nahmel1sswj0gx1luTkboohLBH/hEVipn?=
 =?us-ascii?Q?4tCcVgHduW5p6Lzve4FZqJDv0qukYtC1gVeAmDJxiUCZtpC/oxYcPnXcTkTE?=
 =?us-ascii?Q?ZcLi5bsq1g/yeNiOOyD7dw9H1f0pX7R3xx7LNuIQNq2oiO+QPwR7ePasJPZP?=
 =?us-ascii?Q?fbO+muokUuBoQ5JGLxS34NDOUfga5IB9aZyyOGj3o1vVs+SAl5/cGGHjQHMw?=
 =?us-ascii?Q?oSLByDKSgz8LLGPTzaMqbhWOOvc3CF9UHsYWj5hlMvUbflOvQpj0+4aiJpbK?=
 =?us-ascii?Q?RBvwNKHvxlkqPpt2gbJjg6X/oSlUX/IGVB5T6V0U9spaC/cIWWtkcio5nWue?=
 =?us-ascii?Q?2YsckIAc3/i7d0q69XgG0ZjokYR/8ZTjCoqEoZVDCgeHvs6dYkNMBt/31zRm?=
 =?us-ascii?Q?0f9qWxoQE04F2CDbI8uxjtdXyXR1GlI=3D?=
X-Exchange-RoutingPolicyChecked:
	fXSYPS7jPp4VVIgxZAqj1AVa1MtKZVIo32s1HZ0zl/cfSw16gaJdBurMClr+LMEU9U4zZABWoq/hR4TLTPGSvF+P+l0wmvSDI/BismeGuR//TY7cPZRHBgDYe4Ejr/CotQ2gJraxKIzaLxQg76F2KjcJ40U48DouTAcLlGBPcJGOSHMyU5dbC4LYsQNIfkK5K+h8YAjuJ5cyBfxL+KCBsrixcbuu9URYOw9XEUtub7u5pflgyng/KPcWGmvKIAS+0jIjn0xtYKjg/z1jOZFHmJ9ONd12ARhIiqyhDq8qJv+qIo/FL7H4PolnaXkU5iL1DKZ3HjCjAES81J8TFX5y5w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24a1369-4d82-4ceb-b194-08de87341cc6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:25:02.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfdDwlH/D5OjS+b41cU6TS+kLH9SkI0ItCtwMK8W49g91HEFyfvMFTUHySGKFgnSQdCyA9MCYqmiw2MCzPOCTuqbHtkSuA4OWr0mJJoHDuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NCBTYWx0ZWRfX2YS+O6CfCjHY
 M9EL4O7tmHTydHDoPiQhlB0ADaqJsRcl+kG6Ib58mMQ8/4pc01p9D77UfLRtCfrHh8hF6pjjsh2
 8px76a2n8O+xoXSLT/EzuvqpXcTfmMron/RrVez0MmVM+UAIVgz0SxFT/JQHd9DsucyYpNhX+zD
 jDZI1CSUULldPtLfkH30RsVgCmNKy1ox4WBVg3NhvQ3OU6+q5B7+6gN5ydCKv+IjXtQEImoR3cT
 dtoMiWFqZ0krIpGI/d5tY3JgiSZ26L83epLNDfrPHFwjAZYDtUNvH2zweKvGVyH2sR2GK3/lhMT
 SDLV5Yt2uW6YLvvRD3fjNvxWCDEdd40b0WE5CVV+QBWsEve4fL9avmyDxlF+VFtx7QSD6GVRnJw
 Vhz04YB7F9etbduOIbS7hNtS+GYP9OE/Paullg9LPA1xsQdF43zExWZ/5cvD92+Hby3QDrpjd/+
 rTOy5k+ljzAmvX6ApmQ==
X-Proofpoint-ORIG-GUID: 5EiYp_Svk0Jnec5Tgsyh0wgAszizFiVW
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=69be7200 cx=c_pps
 a=Zi+2/POLpdgQ9anv5Nu4tw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8 a=7WZfy2cueCGYbQ_s_o0A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 5EiYp_Svk0Jnec5Tgsyh0wgAszizFiVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210084
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227753-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,intel.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AEF322E4C03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Frederic Weisbecker <frederic@kernel.org>

commit 922efd298bb2636880408c00942dbd54d8bf6e0d upstream.

The group's ignore flag is:

_ read under the group's lock (idle entry, remote expiry)
_ turned on/off under the group's lock (idle entry, remote expiry)
_ turned on locklessly on idle exit

When idle entry or remote expiry clear the "ignore" flag of a group, the
operation must be synchronized against other concurrent idle entry or
remote expiry to make sure the related group timer is never missed. To
enforce this synchronization, both "ignore" clear and read are
performed under the group lock.

On the contrary, whether idle entry or remote expiry manage to observe
the "ignore" flag turned on by a CPU exiting idle is a matter of
optimization. If that flag set is missed or cleared concurrently, the
worst outcome is a migrator wasting time remotely handling a "ghost"
timer. This is why the ignore flag can be set locklessly.

Unfortunately, the related lockless accesses are bare and miss
appropriate annotations. KCSAN rightfully complains:

		 BUG: KCSAN: data-race in __tmigr_cpu_activate / print_report

		 write to 0xffff88842fc28004 of 1 bytes by task 0 on cpu 0:
		 __tmigr_cpu_activate
		 tmigr_cpu_activate
		 timer_clear_idle
		 tick_nohz_restart_sched_tick
		 tick_nohz_idle_exit
		 do_idle
		 cpu_startup_entry
		 kernel_init
		 do_initcalls
		 clear_bss
		 reserve_bios_regions
		 common_startup_64

		 read to 0xffff88842fc28004 of 1 bytes by task 0 on cpu 1:
		 print_report
		 kcsan_report_known_origin
		 kcsan_setup_watchpoint
		 tmigr_next_groupevt
		 tmigr_update_events
		 tmigr_inactive_up
		 __walk_groups+0x50/0x77
		 walk_groups
		 __tmigr_cpu_deactivate
		 tmigr_cpu_deactivate
		 __get_next_timer_interrupt
		 timer_base_try_to_set_idle
		 tick_nohz_stop_tick
		 tick_nohz_idle_stop_tick
		 cpuidle_idle_call
		 do_idle

Although the relevant accesses could be marked as data_race(), the
"ignore" flag being read several times within the same
tmigr_update_events() function is confusing and error prone. Prefer
reading it once in that function and make use of similar/paired accesses
elsewhere with appropriate comments when necessary.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250114231507.21672-4-frederic@kernel.org
Closes: https://lore.kernel.org/oe-lkp/202501031612.62e0c498-lkp@intel.com
---
 kernel/time/timer_migration.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 72538baa7a1fb..0707f1ef05f7e 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -569,7 +569,7 @@ static struct tmigr_event *tmigr_next_groupevt(struct tmigr_group *group)
 	while ((node = timerqueue_getnext(&group->events))) {
 		evt = container_of(node, struct tmigr_event, nextevt);
 
-		if (!evt->ignore) {
+		if (!READ_ONCE(evt->ignore)) {
 			WRITE_ONCE(group->next_expiry, evt->nextevt.expires);
 			return evt;
 		}
@@ -665,7 +665,7 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 * lock is held while updating the ignore flag in idle path. So this
 	 * state change will not be lost.
 	 */
-	group->groupevt.ignore = true;
+	WRITE_ONCE(group->groupevt.ignore, true);
 
 	return walk_done;
 }
@@ -726,6 +726,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 	union tmigr_state childstate, groupstate;
 	bool remote = data->remote;
 	bool walk_done = false;
+	bool ignore;
 	u64 nextexp;
 
 	if (child) {
@@ -744,11 +745,19 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 		nextexp = child->next_expiry;
 		evt = &child->groupevt;
 
-		evt->ignore = (nextexp == KTIME_MAX) ? true : false;
+		/*
+		 * This can race with concurrent idle exit (activate).
+		 * If the current writer wins, a useless remote expiration may
+		 * be scheduled. If the activate wins, the event is properly
+		 * ignored.
+		 */
+		ignore = (nextexp == KTIME_MAX) ? true : false;
+		WRITE_ONCE(evt->ignore, ignore);
 	} else {
 		nextexp = data->nextexp;
 
 		first_childevt = evt = data->evt;
+		ignore = evt->ignore;
 
 		/*
 		 * Walking the hierarchy is required in any case when a
@@ -774,7 +783,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 		 * first event information of the group is updated properly and
 		 * also handled properly, so skip this fast return path.
 		 */
-		if (evt->ignore && !remote && group->parent)
+		if (ignore && !remote && group->parent)
 			return true;
 
 		raw_spin_lock(&group->lock);
@@ -788,7 +797,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 	 * queue when the expiry time changed only or when it could be ignored.
 	 */
 	if (timerqueue_node_queued(&evt->nextevt)) {
-		if ((evt->nextevt.expires == nextexp) && !evt->ignore) {
+		if ((evt->nextevt.expires == nextexp) && !ignore) {
 			/* Make sure not to miss a new CPU event with the same expiry */
 			evt->cpu = first_childevt->cpu;
 			goto check_toplvl;
@@ -798,7 +807,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 			WRITE_ONCE(group->next_expiry, KTIME_MAX);
 	}
 
-	if (evt->ignore) {
+	if (ignore) {
 		/*
 		 * When the next child event could be ignored (nextexp is
 		 * KTIME_MAX) and there was no remote timer handling before or
-- 
2.53.0


