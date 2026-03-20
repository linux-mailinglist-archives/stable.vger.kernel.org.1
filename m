Return-Path: <stable+bounces-227615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL8gMn+uvWnIAQMAu9opvQ
	(envelope-from <stable+bounces-227615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:30:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7A42E0D9A
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F9C530A08BE
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D516B192D8A;
	Fri, 20 Mar 2026 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="AaeGxzcy"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12F326D73;
	Fri, 20 Mar 2026 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038620; cv=fail; b=H0aag2uKCd0UW13axK7oGAyFLaId1SjL5g9lMVgX8y+BWZILcr8kBakTk7KmO0yx27G7E+wCbyHR/E/jnb/laMDeNjiqyj25Vt2U+38kPmj/EgAxiNG+Sqv15SKOQvi0Yn5QjaAYMRdjx3rVO+mO5yGG5b4QxVFixJsytvqRpro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038620; c=relaxed/simple;
	bh=Pi7nrRQut750+spVTyXfaFil9uTXZ/5Vcx1ISPQS1rw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L81epD4xd3zxJk2/79Li2RerEav4mxYv22UolhcXMhRyMKZyQCTMbBUEHJQzuT67x0XRQqpeVEkbl2ucg6a7xQ+XYTys39Ymz7DwWJ54Zexw3IO1QF5zaaKpuXV79yx4c58e5cAUJDs2bn2xkV/Km9cyDsjBIr+fT7mqqzHBwdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=AaeGxzcy; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8qbZw324122;
	Fri, 20 Mar 2026 20:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=2Ha6uppFS
	BXaPhr0+oDqdyX38JSBFngQQEEj3XP/3Fk=; b=AaeGxzcyYnsOZhTjQC0QQxrHu
	XT/gRlKrvW2RA+3vyyiRBVvFvXDTJX5Iw1kK/uoebfWq9/slciRzTwB8LjT3P+vk
	S17PERgRCP7HSoCknIICAbJWk28WqUmMMMhE8DpTO+Mcd/iyIWeltZivtHT+Z6j/
	tXVAPK1VLTM0D5ClmGCoyinvyLgJTIhq9bxOnkzz5DoRhf6sr1K++qt3eJfqQFkA
	ppkSXAxHylQ+U2yXxQ8wIqnT9zjZeqXpcscl8rc0Sb+xnfioomLnRvgjOMmxY/5P
	JDkKJ1lIpwpoew9I1RhP+QjarBD3yppvPXUqOclburNTfnTZ4e1ic0nA+i2LA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cy9anw33g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 20:29:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwAPjPmGn6TTlRmSRi5x/9j61b/qxDZzePcJzQ7axr8YLSeFqF3ySyEZ4rOiDple2XrYqstbRjJAYXse9ZSW0gbbutFyT9qqbRJiMAEUXhM1ZWmewZrfPxPrzZ/+1OsdQU9LiRWWZrMmJoVDo96/3DXk2WhOGwy+L9I36ak9f9Z065SF35szWB7PYfGQHQHm7h6um7bnvKEeVlZpWLUa9CxtkvS7iii+qM5HxCP8RC0woGb/8bzLpINRgS7Qg/RWLQBfSp35AnHKQx41veiF2eIG+lUxgWyxEzXUyaf3Ytj9AilR0J3B3V2yqkDEiDpCQD9+kdXICL0ZGtOU+10zDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ha6uppFSBXaPhr0+oDqdyX38JSBFngQQEEj3XP/3Fk=;
 b=Vh0tZwnfBjSCy1t+LNvEVkE+yQHXGjn3fSq8PiNlqvyWgEmVTlfdWb6CzdzQVmsiPRaJ3E0l9NJdDmHledZAIxcQHCe8agRTKe/PjVPiPWWOthWQPbBm/LH0a8TINRwo/sZOp6lPJnRYQqEBYLqMQ+tSPl838UDEE8BzEX6vubnZiR6SVVDVn9VgsSUOX8QupGUznObQwWP11ZsZTZd5CgK0xKz5z8IG5sKVeQxs3T0OVFUyEb8nbbw7s6OuChtzn6zjWl31S4M4R3Ple78ojPqllKD9IjV3rrarzNeVw6exDJOPRVlUGeOlKBT/ariS0Fo6rkHn7KAD19EEX0174w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW4PR11MB6785.namprd11.prod.outlook.com (2603:10b6:303:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 20:29:21 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:29:21 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com,
        Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [PATCH 6.12.y 0/6] cpuidle: menu: Backport get_typical_interval() improvements
Date: Fri, 20 Mar 2026 22:29:02 +0200
Message-ID: <20260320202908.24377-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MW4PR11MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: b99d8f7a-b6ef-4cd6-3d85-08de86bf5e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|10070799003|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ewyYHe2bfbOm57tXgMQumqJ+1GlOt6StNpGnubEXJu059J500weeCP44Vf1qLarTYYZBbFWTIN3jksoBTXRPzuvlmW2nTAQqOm2bFTP72GbdwLs3RTgnanuspkOUJlnVt5un9baJIHBr2V6A9bE+wivE7bWraJqlZ1f67izsx2syTLv0OziQ2IV6s16vSIpy7e8PcT9nf/THys5z2IP9ig3S+M660SMFZgOT+xmCOq06e4+vfE7MnajwEzVbTD+Nc/z9WOBklDmdWv2G3jmdWOBDJCdToJeTLJ5Tcm2yPzWm0U0JinhCd40kgnMWGMcB+nJXbDLJGhY10pCuQiBCVbrBcptwWodlPPMHk91RrfKcZQRkP3PuDpn5GOJ3LHeKKxLD10GmputQe4s3kh0YtFvYcQLaLrVUX7VxrHiYzWme3FTT1QFZFHmhMPU95NJlvvvJzPRmzEXof6RQM0szlxTE0LfD9O8q6ESEArAA1EH+UsV3aPgZGgTsF1VCwUcbkbRAg2M8hJFbpwnme5s4TGvpeyJTcbumMdwChYOQE4JIjYftQrwZ5IZ3FHU9fDqJxSgzOccmOPTBJOMUOKljgJ8uL7f1DPGccOwg9/ywwEFfal8Bp4L59Wkn+RpW1nGMqmeDAl2fHd3VRONOQ/ZjuwkCWZED4AECr+dOQU3b2/Q1r2W3OMfKXpuMPCBVGWmCkiRYNiCS6pE+ws96PU4dCafrvZpn399A8gVoAZATZcw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qY6QEb3RkhsCDQv4tlDTmFCrpbKgk99E6e8fZHemWzK5ungKS1fg3rG4PPL7?=
 =?us-ascii?Q?/X6bQTAQww8pTrbzykGnmAVjcmP4Bs+FxVmk/JPIZVb15M4MO28Jec6qg0Dj?=
 =?us-ascii?Q?aWi0dE3gb3H/WG6TS9twB8KHwdjvdtGy/RKSAHNC0P2JVYtPP2w8Ub0bciau?=
 =?us-ascii?Q?7IrGQOroI1Bo1unQG02iid2bcYt76q4gJ4wjo2eNHdw4P2F/l8gyrKU28KRn?=
 =?us-ascii?Q?Cxu2K46ujQhHMXkeCaB4WhiXXo4iE6JvKOlwC7TkhoPvpfzJd2pqziqwWnSq?=
 =?us-ascii?Q?XSOcBBKpCiRfPyLUDcWfEBcb4TETxPA9EIhMhmGCc3BQGxWms/+5H69IccJ9?=
 =?us-ascii?Q?B02XmN0A1v4XrhM3CI5IKHy+HZ3j3qJcU0FFZIK6ts5owqZc1j6erL4jRk7h?=
 =?us-ascii?Q?9pNvvapp02pDbWeyXdvlHrOAIHuFE34U+B7hL+X6xRBxtXRZqwoH7x1igy6l?=
 =?us-ascii?Q?CRCQ/KeT1gFDcFh8sCqDELlwWTueM2lafBTaSTcWLTeZQVFbHshkbzkdJAip?=
 =?us-ascii?Q?wD4Yv9YTbVRurKn4Pkb6XPjabZCY74ZNI3aRqEec+EwNSr5SwZFOgkSXF+s+?=
 =?us-ascii?Q?weA8Ch+MoYk53JZLX2b/535MEo159Q+xvlLGtDv0TcIwtFZM6EO83L76NIOS?=
 =?us-ascii?Q?umrvvrbs8SkJrYUL9iySSlMd8u4A49/qOu5xPNmQT53ZbOr0jq5ZUfh1wals?=
 =?us-ascii?Q?NkTAkdmkW7973uDaMplUtEEdw+r/xQvkC90/UQ+qecj55apCmQ7k19a4JmXm?=
 =?us-ascii?Q?jwnhJsnlUNtpZM8hOm/h6sG2KBe/1jPk3d9EaYC+N7VmqhLYMSm9zZ6YnJk7?=
 =?us-ascii?Q?99iz93u68VibhCtt5VVJ7WXBH07NMUNzt75ciLKQ6wUKX6AfRHWMgwsB5p93?=
 =?us-ascii?Q?4uyvl1jU2GbmZrIMIF4Zd/hH+csXXEOiKcDa5mbc2DuwRCsNQC2knuBMTob+?=
 =?us-ascii?Q?aKvM0j8ZT3YwgIvUPsaPo+fsLDSHXaItCOZ3iyNb1DdTy9CFia3d3NklKjEf?=
 =?us-ascii?Q?PD+fPkFlus7hPXMElm8x7BvE6koFepz8aBxwPZRStpzET6zYp+2rsdVpmn3K?=
 =?us-ascii?Q?n8u2Tyusa5gSs/HTVwtmz1mH47gsU3ShkYxIwANUrWfhlnE3hNn0YWFynDH6?=
 =?us-ascii?Q?0WtCemES0mZ/4Tj+x36njFq5T8mV/vOvs983lno4v5OJBl3B99vZQv8qXefn?=
 =?us-ascii?Q?Zb88EnEy1Bp7mRdPZS4XHj1T/hDINTVR3edrGPqMhw8FSh2sqtjjZdyBh4Sd?=
 =?us-ascii?Q?XFezKVLf2G4PfrgbcsiCELv5fPlKYxzQC+1yTEQ+P4VhhaRNh8KjIWFlcTFD?=
 =?us-ascii?Q?9B7x6PK7zRKricOF3C+K0whilIoZa5tk+IYMvhb0Ww2Mn+ZMf7oTZtLv88Mu?=
 =?us-ascii?Q?bnoB4VYJvEblTKrNI5jNUOqkpBr8MXblG6h7mJ1qV6J1UHZDfCvuL40GLZn9?=
 =?us-ascii?Q?+OWkOa40KJcnaeBwYT59gdILWDV3q/uIYTHDERCasY6g4fwTv+n92Oe8N7Rp?=
 =?us-ascii?Q?etAqHD09/A62XsFZ/WErxGhddxHcOc//unCnNYMPFygJJSvU11//i2QGop1s?=
 =?us-ascii?Q?1CxECeVy2uZixWatkxBkAEszyGhJyp+pmBKgzx6WnTl/lAewu10u9FZ2Tsnf?=
 =?us-ascii?Q?RRZt8V2mYEiOpalu7Pas4S0hXpWKq0onI5Wy3LNRdtIvU+/0nzPq4RCr791Z?=
 =?us-ascii?Q?s6kgtM6UtkRs9A2oJhdys+YAjCq3Do0B20RHuAWPH+Ll7afb4jcRxZqWAYrJ?=
 =?us-ascii?Q?aCrCtzNIdlblp6NKFLjCH2Yt6QZXB14F5ASynw0A+wWdQbLBOOUHksUmM+IB?=
X-MS-Exchange-AntiSpam-MessageData-1: NBFUB/WeJMQARJyHJhTXjQXZvI30BzslIqc=
X-Exchange-RoutingPolicyChecked:
	TRTbKGcD+vt0K5TSWf8mTlxL7klSNu/cMkC9GclHkKhOA+J1fzmiLqGtDw/rulSEHFugPuYZFyfE1uimgkb57GEKRcgmkOPt57i/qt2ogjdF7Mbk4tjjS2361CgvE/7HFT8xiXnTub/o+tbSFNpD7BU+gngd9a3hvGHQMwerfto+r1nHMMcffZ3cNq5t0oIG19ZYEokzj3Q3nTTOpVz2lm5cUgBXfk5Mo5LQA0AgnbdlsWYlEnvUHIrYIkrWy0GRSR6WxXIK/2viR7x9eTGvRoXN2ObZaFk5g61dTgXDckc08UP5Y34RquPaP+lf96n3B7afhr5WywrBdPHOSzbN0Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99d8f7a-b6ef-4cd6-3d85-08de86bf5e6c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:29:21.6145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxZxxNHRiKgXs2QAOGVgZN6BnE9AAAkssAgySC3eS8MDbVieXpJPbxmIXqCmQPqwakptD2O4vmTRscn8rrto/QV1peWYFwmfDCMALWzhQ/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6785
X-Authority-Analysis: v=2.4 cv=IrMTsb/g c=1 sm=1 tr=0 ts=69bdae29 cx=c_pps
 a=g4Zu/129bcKSj1q/f/8ScQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=CjxXgO3LAAAA:8
 a=doN5y8Ov4thJEN2E-usA:9
X-Proofpoint-ORIG-GUID: VYahJgoU9ImYrBpNGV3k8N4PB7SQNDpD
X-Proofpoint-GUID: VYahJgoU9ImYrBpNGV3k8N4PB7SQNDpD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2NyBTYWx0ZWRfXwywqUNhLQ8dJ
 2sbx6rUstW+l6KUw/ICM6lUNNSxnpdn4P1I8U4wtFzl/Lvq1EfJKpUBTnGb25+xK0TPTGSKqEGT
 3saZZViWrD2UXzC1/wgTp+z2PgIxUkfIlH4aZ/0HrOp50DvbyYMNAVlIR5YRu4ultNPYW2DLcMK
 GSG/gYonpg8M00LVYwWFV+3xWvSOaWsGe7023Eh/pp0/96OoMYAVQwihE7QKxUSoDdIOF3E5lwb
 9TUvyCNzHj4uX4J5CNc3sSot9Ps6tC/cadpBRZB5EtT+AUQ39/NsuiWkqrWisqq4FTPCOCqqCej
 zUngFdvzVOqDeDF3BFbglXUbJWhs4AxOtjeEijUJGh8Sg+R3ijbsDx5Yqp30I+0TDHwh2WgYgq7
 V1GWYboTlRXXECqq9Jb3Cda4wWzTd7bnYBMhx0i32hRRwHZHu/8Q43fh0hcuiS4kAjeGkH0xKKU
 J93KamcPFkpC+HGbWzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200167
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,arm.com,linux.intel.com,quicinc.com,linux.ibm.com,yahoo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227615-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6D7A42E0D9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut_n2001@yahoo.com>

This series backports 6 upstream commits that improve the menu
governor's get_typical_interval() function to linux-6.12.y stable.

These patches are already present in linux-6.18.y but were not picked
up for 6.12.y because they lack Cc: stable tags.

The key improvement is in patch 2/6 which merges the two separate loops
for average and variance computation into a single pass, reducing the
latency of menu_select() on isolated (nohz_full) cores. The remaining
patches refactor outlier detection to cover both ends of the sample set,
update documentation to match the new code, and add a minor bucket
assignment optimization.

After applying this series, drivers/cpuidle/governors/menu.c matches
linux-6.18.y exactly.

All patches are clean cherry-picks from mainline with one trivial
conflict resolution in Documentation/admin-guide/pm/cpuidle.rst
(patch 5/6).

Upstream commits:
  d2cd195b57cf ("cpuidle: menu: Drop a redundant local variable")
  13982929fb08 ("cpuidle: menu: Use one loop for average and variance computations")
  60256e458e1c ("cpuidle: menu: Tweak threshold use in get_typical_interval()")
  8de7606f0fe2 ("cpuidle: menu: Eliminate outliers on both ends of the sample set")
  5c35041099965 ("cpuidle: menu: Update documentation after get_typical_interval() changes")
  d4a7882f93bf ("cpuidle: menu: Optimize bucket assignment when next_timer_ns equals KTIME_MAX")

Rafael J. Wysocki (5):
  cpuidle: menu: Drop a redundant local variable
  cpuidle: menu: Use one loop for average and variance computations
  cpuidle: menu: Tweak threshold use in get_typical_interval()
  cpuidle: menu: Eliminate outliers on both ends of the sample set
  cpuidle: menu: Update documentation after get_typical_interval()
    changes

Zhongqiu Han (1):
  cpuidle: menu: Optimize bucket assignment when next_timer_ns equals
    KTIME_MAX

 Documentation/admin-guide/pm/cpuidle.rst |  56 +++++++----
 drivers/cpuidle/governors/menu.c         | 118 +++++++++++------------
 2 files changed, 91 insertions(+), 83 deletions(-)

--
2.53.0


