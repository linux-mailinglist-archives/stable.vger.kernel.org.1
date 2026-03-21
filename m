Return-Path: <stable+bounces-227755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cND1FAd1vmmZQAMAu9opvQ
	(envelope-from <stable+bounces-227755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:37:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD562E4C81
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDB13006B20
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB9431F992;
	Sat, 21 Mar 2026 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="lR3yIrM2"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FBC2749D5;
	Sat, 21 Mar 2026 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774089469; cv=fail; b=EqSwaTZ0yXP1OCBekfGYUWgG+wTVRljwirIh3RhZHIjepeJqTIiZNCCcFEtg7LWn7G8E4q+sqP3XyaPjNsDCb433p3eajIKjsjZTMbfQdONoG/MgVwhxe47fC6cFQuA+skXHUL/7ZyPmygsroLFGUcyXrk7mLs/qc6LWXOqOqLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774089469; c=relaxed/simple;
	bh=nFZkFJe60O7Ls/6edSvBLZdIX95nN/22K/VF7Kfo6LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LF1ot2x9lU5rpKPTilZnrxCYyw3n2UpZk6mhuLJanBH/HDDEgRPoDMero9i9pszr7syhz4n9dV013WuGLPkPD+wc9hXUzBcMW5af7r1TbZ69csJ7LBKhBJ/vpKOizVsPyrDZzikPcg/N1QK4l/NU31pVluMMvrL8h7BjlcPf7co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=lR3yIrM2; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L9tvA53678047;
	Sat, 21 Mar 2026 03:37:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=kZ1E36CJSJvb73WUSfi2FtVvPtAPfNs+MPx3gFioQO8=; b=
	lR3yIrM2HVcUTmMCIkpCkWf1FgY/7dYbJkz6Zv3YvmLbnnAuTSTynfALb5mCC0h1
	hhc1nkUIYqqA3tRMKQVBxiDCBIDXH/HZ6/UpBUv2AulyMsNr1TU6tGhJbvk7N4ZV
	+j6mgVC/rooxp9O356WAlAnh+ukYaiRAuGtDTXvC80csoPZbw2he7qSqhe1kK60l
	ipv/31Qq681tnup2pzNjzxKnab/XLlQ0av6JzFjxzH2W6sd5aWmRaq9hn9rurvql
	yTcxHtYYOz1lyFchKNmAL7jzLk8UqK1aNM9pN6KnYbArKyynPVLIg3CdSO/emCuj
	9TB6tem6AYfP0Mjq1QsZ8g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d18uggvew-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hsrejte3CBD6ihHSpSEMVqWXXiL9NfBQq+xRB5H2P8frmGoDyaXo8x6sfiT40VbhdL+UQ0CqbjgjSFECbOq0HnXNdIkPi3haeh+8eYcNiaN8/ypcTdVbfJFA7spvxUUcHFUSYJPK45v018PgV31ihvW6PZXNfalkZpbxoPLk6ybOXo8Vqf4QagX2z9iv33n2p/c7FfmPQkmUGEUKK+CVO4sm6A5vsMkGgRhFBpbnyXTLWB0ljnVs32hWEGKw5Y9iaOS5gfcb356KCZV8J8ghbDakaDSY2wdtFa9hwAiRrgqWsQko7sRjsbxK8mKErIE4iW0stfiN5LNpkYPuubX9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZ1E36CJSJvb73WUSfi2FtVvPtAPfNs+MPx3gFioQO8=;
 b=jTjXGPiQauk3EwmfEm37SxX5TV7ht0abYqTfoy0alXQSYb7OBchPvnK6DBM/vkJfX+g5ZaBN9G3+XQSLYe3sIEbVzYY9ZNzugY7XCNNk7pzWWtl6D0EpCtQ5djg4DEmigWLEX5PckbYI5V7g2eA+dLTDaJ04cQqZ3hsihHSQ88KQqFWcagVOcqRiobiT7U1sq/7JpibUrJxHBRIZngqdGh/PuW7eCIAhknNA3nRidLjnrlkfxhK4KfhGbYCD6VLQtfCYcP4Gdp3RIFqzAbVZwD+rKi8om9Z+imHj0rNzqDYsfx46vGA8q/jsHl0oBTg4k0gP+nVRI0oslQf82hn+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Sat, 21 Mar
 2026 10:37:38 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:37:37 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 1/6] cpuidle: menu: Drop a redundant local variable
Date: Sat, 21 Mar 2026 12:37:16 +0200
Message-ID: <20260321103721.35114-2-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: a2954f8f-4dc0-400c-bca1-08de8735dec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/2VodfHPBWJfWIym3G1lB9Vo7G3i2yPI3n+apKRKWBIIKab6uZjeO7NWOI8535Q/0UIW9Js/PT7EvLPmgru3yEuxzXATeOjtKZaOFTy30WSx0J8gHEAzwaFPgA1nuhzYlw0+x+/jeVvItLvp8O0et4z0I5JWdzXT9MTVXWpYf3GNyZ14afUwPh+4r9v+BiFOHdcjRFFkUic97v8O4qCkTAiVfdbFUBkacOAzgtEQ0JOLqbrlYk/NUYYCKY5ccjmaPYdmEqKmq1VIzMGy9oZ/4cHQSSMmR1u7HKDJAM9E1AWgKBm8hZK6q5DgNfYJ5gBzp6AT5+uvQ/tu1CdDW11kNioPzU5S1nERo7nsoH1V2gE9J/Snvnnlg07Y4MyuvfJjBlWv41azcGFTlP0jspk6PCgRN2gl13T7lIdXRPb2fdxoAgOW9Y5G7oVMROv6/CgSCkmQVWK3fh55yUD7VhL8H1XnopXlWRJwOg1SdDNceiwW8LWibFuJ1fqF1J0ffdl1XhsNstp6jmxkLdr/aLBRfXfxD3X8XQnl9gVIdiQkuASyUeKvSFQKWOSPU4+MZk97MfDDnzAsJdo90q7sqluywqgI29dknZ/zBF3DmE4fndGdP5YoaqwUSYjXPRStivlgBL4TAIovYdW+l3Qtj30aVqFPVPAq4sLrY+T/GsHC4qj2VrhAS3UX+UohdFDVHrvoe8/CfKKxhXcrroNgZUJ7GxAzn+wcPWE6D7I142LjnWo7sfY9M5S31RahQBdjw5MA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UtSULc64IRpL4/IkkdHYliHLbb0ZYFHvXHuSx389JeKa204niXCb2WkeF1Vc?=
 =?us-ascii?Q?uYJVhz8Zh3nC3b1ppcxITrSsV1sNDnf+G5GMp6eOsKZC6f79ELpG1JK1VYKV?=
 =?us-ascii?Q?M7wxgidFF5WYsUIlqY+rAbFljiookKoQcT+4nvh/5YzDCHW3VKg65SEeW21Z?=
 =?us-ascii?Q?SkSKQis5XJat/hTe34KXqdEB35NDDP9QZR3KGeKoLAgxcP6AIDE74mO856mL?=
 =?us-ascii?Q?qr8Sx6e1uVZ/k4PLb14oC9qtP8CZmmfc5FXCL1S6X+c8v9bkRHDT8RXqt88P?=
 =?us-ascii?Q?br7fF2a0WgUx5sGllgv3Eu6LCEPQe1pvaNVujkgHlD7xOrOLL/l/FcBoGAI3?=
 =?us-ascii?Q?ZeIku0Nf6tO+3CeYq9ePqezWjq6FdE2NlzA5ODxEgHCsi9Ul55VvHKH1KBQ6?=
 =?us-ascii?Q?pPtf6p6vcY12YNVzwBvyDeNRs/Jj4EZMj3JJzx55J4LzYC5aKDX8WpE3pu5h?=
 =?us-ascii?Q?69CPSwNL1z2xel+/2/KNFdppH58YVamLCIIPufujMWO4tVU62L9FvSd/+q0N?=
 =?us-ascii?Q?OcpjRBtE2HFh+ippmknRy6uDkywL8qLxUaq5nQ/CMfNrgeoOTbHzLJh/laXl?=
 =?us-ascii?Q?hxKh4mC2C3dG6ErlKSkEAGs9yiEkVGKiY8WyxzkP3PNKRkmW/vobrDztYAhV?=
 =?us-ascii?Q?3lJE4gQLp9IR5sstA/hgEGoFsRJ7wVfNs+AqPL/hbU/8n/TRZy81EwXQ6m4o?=
 =?us-ascii?Q?ZxO/CqYApQ1pOyP2h+8ZtO+rf9SQ4IoIJRYXROv2ocsn8aJtcLspdbFzk7jy?=
 =?us-ascii?Q?N8iWFUdJMn/5SqnszaLQkc4FdxOG4QoupCiRU6qNAG22AkMLiYtYtqdwiaF6?=
 =?us-ascii?Q?rAQTpPii/N43AMlbypCPeqer5WWJT6NOZsNdtoDWrakFxnGYbka8J7OQPSNl?=
 =?us-ascii?Q?aIBTZLTr1F9h1pooc8jwo8jYL3PTc9ry5zur6p42r+myoXwVz20664EXj5Xe?=
 =?us-ascii?Q?It1R/wpJeF0dLGcaDyEWN+zensfwHn2ovXs1nYecwemSlt/2hH66DZnfkrGM?=
 =?us-ascii?Q?E0GYlx69Uxu1oTNYUJdE9liPLS0Xzxw20KIExdK7+mj35HQcweUTir3yJeRE?=
 =?us-ascii?Q?fpWH80VXh9MRUl+iujvNTaBE+/DCiT470xKRlbbJJ9Hl2nYfqSYUJ+cDH/mj?=
 =?us-ascii?Q?jflt3hpLly0j9HnFg3Kx65YpW7u+qn2n+EYQsPdJ3d0FZFsaVUz2Vp8yT0z4?=
 =?us-ascii?Q?2CdWH2/CWG4Q7jrSyAOZ7iFpbwP9mGlSYranL/HyR/MOjpGBTn2xmlRSrFnx?=
 =?us-ascii?Q?EWT62TE/hRwYOUdF1rkTidkRkimQqm5UWH9wxIxzaJstq+EimHUxiacrwGx8?=
 =?us-ascii?Q?qES4DTOke+udvPYvaprRYB6ty9rFg8kh6sMvfQdHbEODsA6jfVan1F+mOQiq?=
 =?us-ascii?Q?yKfxYgk8pp+K+xSYjU5uoCPz2iZVCaSlQWGzxxtaZp0FPGaX9vGFyJtiNPrG?=
 =?us-ascii?Q?7sGCUg1+VD8yTBxf//aokCPR45g1vQfzepatS7EsMaFjvE8MwK31WIB8L20L?=
 =?us-ascii?Q?yQiYUZayG3fJr4BPrMo8t7TDjnjt6bQVuImtzREHPzK9fWa2iDjd29YOzev9?=
 =?us-ascii?Q?vFmP2e0/ACK6u74s/Imy8YTAgJwdkP4CpYGpZ/Cvnakdq/AnR3GaI6qyDdqW?=
 =?us-ascii?Q?YUOm6ZveF1A1VXgTT76ZrQiOHRhXagvVjxWusj8zn/qVyFl7b/N2qoxETeBl?=
 =?us-ascii?Q?U9yOhWsBxiy/T1chNGpxr7Dyxql2nicZayvv3UEpfdVl+xiDbTMNjA3oR+tH?=
 =?us-ascii?Q?ycaRdPsulPa6876djUHNyhS397u2bms=3D?=
X-Exchange-RoutingPolicyChecked:
	SRwKnnlQRwjmtmOWNQxEj0xHe4pkRlhkJRPxAQeu9te64JF2un0Fi4Z2k2L4QVTxjlyYjDI2BvIQPKl2flh1hnjMZBELvHa5z4BLWYN/1Uz3/efQkBlun/m0Lq/wTXmldelGI9jtFGkPg1Ytg2j7n3dmNKbAJuln6OTdg6iueC1UQb9GOckCtyOPu50Ho+1tHoqoeJ33EfPSFGtZjqqqk1RNAwBqmL1Y03SfJB13YQ4DxXIKey3oVsZYbyPoNl+HOukiMQkn1sLuIb8zS4TR0ATA82uEa81Ch/59631d9r4rfuC8Xd+N7QCf7Vm86Ncmar4t9vbWGnCdv4G1mg+gUQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2954f8f-4dc0-400c-bca1-08de8735dec7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:37:37.9124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2cmATRcx7kuEvDkI4LaRpuhWAPpAHKzHfnh2/xBuZDESOv0a0oCpIfukJrWKL2TEy7o9Y+hrSkA5rjYec0H0MeqXozh9cOEtArkidwCa/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-Proofpoint-ORIG-GUID: 0VsAXwDmNNEh-HuGOoQgto_2nc94N2-F
X-Proofpoint-GUID: 0VsAXwDmNNEh-HuGOoQgto_2nc94N2-F
X-Authority-Analysis: v=2.4 cv=A89h/qWG c=1 sm=1 tr=0 ts=69be74f4 cx=c_pps
 a=cLTib2BoJD1e+Gs0wkBYAA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=bC-a23v3AAAA:8
 a=p-nOP-kxAAAA:8 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8
 a=VnNF1IyMAAAA:8 a=1Zo6JAK-eCxqH1vQYoEA:9 a=FO4_E8m0qiDe52t0p3_H:22
 a=XN2wCei03jY4uMu7D0Wg:22 a=FdTzh2GWekK77mhwV6Dw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NiBTYWx0ZWRfX8GDQyzqq2oQy
 sMslg1rr9wE+Q9mgZfEHwdILDFW/TTja1FuyuccQQi05aWIUccsUYW21c0XBtcr9LdI1dyx/lj1
 f5ZCYRV0E+2E7NaFTQ9oRY8DqGewQ5Ds4BW/xr6Y8TjvWaJg2Ua+wNlWxmT0xoQe1rFUwCAtrsr
 S0k/4zHP4tJI4agXAmvyyIYKrazX3rx/kdHOSpvWtsMOQMRADlQkShpPRuFzqTrXo2svOwPM72y
 MXKH7QAjY+9WBkPBG1vLv3PUwx1vgaAN853dUcqEsK7eh/1rLGQCktpsyMPPKEjgoXfwGJ+Y25U
 qugMI8zSEBQ5ObM3iuA5soDsARmZs9SKI5swHn91dT2K3jveU1LdTnxchhvzc0zsgn6W5LthrsC
 A4XezFJK5Sav476KGQ8Iwsh0D6jtum0/7mw5c2Syt1OQLO4Qk22U0OhM7Ugbhe9rOPEf3nILZ7M
 v2ZWbolCvI1lALeaYVQ==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227755-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email];
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
X-Rspamd-Queue-Id: EFD562E4C81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit d2cd195b57cf5ffbe432be01e96f35637e7bd403 upstream.

Local variable min in get_typical_interval() is updated, but never
accessed later, so drop it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: https://patch.msgid.link/13699686.uLZWGnKmhe@rjwysocki.net
---
 drivers/cpuidle/governors/menu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 0ce7323450011..dd7e2a965878e 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -125,7 +125,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
 static unsigned int get_typical_interval(struct menu_device *data)
 {
 	int i, divisor;
-	unsigned int min, max, thresh, avg;
+	unsigned int max, thresh, avg;
 	uint64_t sum, variance;
 
 	thresh = INT_MAX; /* Discard outliers above this value */
@@ -133,7 +133,6 @@ static unsigned int get_typical_interval(struct menu_device *data)
 again:
 
 	/* First calculate the average of past intervals */
-	min = UINT_MAX;
 	max = 0;
 	sum = 0;
 	divisor = 0;
@@ -144,9 +143,6 @@ static unsigned int get_typical_interval(struct menu_device *data)
 			divisor++;
 			if (value > max)
 				max = value;
-
-			if (value < min)
-				min = value;
 		}
 	}
 
-- 
2.53.0


