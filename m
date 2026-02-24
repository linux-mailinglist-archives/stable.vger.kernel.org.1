Return-Path: <stable+bounces-217862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IoGD4RDnWkMOAQAu9opvQ
	(envelope-from <stable+bounces-217862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:21:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 365FB182618
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1B383052442
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 06:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F622D29C8;
	Tue, 24 Feb 2026 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="b4JC46B5"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD2F287257;
	Tue, 24 Feb 2026 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914109; cv=fail; b=lbTes1KreZ8WVZS2SJWEYLFekPxp20wieW1jz0OrC+F2b2qk5qcQyx8ZXtmCKzWK1hFylr6s1R/yQYUgxIuyYW3JL6QyyV9NdgzTCprgadapQV+b0nUKE3TeXfih/pHtucVm0R/LqTOtOCHYbv8uTtpOwIDDs+sOKGpF7yLP1w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914109; c=relaxed/simple;
	bh=zyNS13PeIxli1TmMC2CS/HoD6tGJUHaaKgFlgDT570o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pkPm6ff+xCZtFZi80A+0qO9d5SKwYhZ/Kq/YJ39hqhHR2Mylr39VdY0hpwn9nPhvCAUn78EpKc+OW5Ej5pHMPevdwVWWk5e7ks6+bv7yqBFv1Bn6ajrhycBula5YENBIpViuzB7eUMqDkZ1pps/Ac3uH4MyiwLy4tMM7LstKXwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=b4JC46B5; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O5V6Ig3327197;
	Mon, 23 Feb 2026 22:21:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=cXJoSxeRT
	KkDbT6BmGww5MirOhjEz1It1lxyiSLGadE=; b=b4JC46B5GlHQOU/fM/XKsYr5z
	Dfh7GzbQjnquj9q6a1wZFWMz/HW92fWjfboj4nhjttwxvSGXcwf4UoldiFdyELEh
	+4qeQ/fji6E7gf/Z6CDfdXLcZFQIhLiiOgk17vse3TfURqI/mD4pOORt4E2KQlRy
	4B7I8dI1Zw9Ercle4mws8nDrteBlrVjugOp87QHYX5rwH0rbm1H2ENdCHqDzvBw6
	ijJn6Xzni7M4ZnRfdOFXQQtZ1xwWqjbL0NA+IZ17+sVfQPJPEJqMJcv0AoEWD/nQ
	9UGjC7rbmxE2aNJ2hpJMSMxxVFhIjyc6okEb/5M9y4nIjadlqUUAr1PYCEf/A==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cfd3k2gny-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 22:21:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNcb6YT+mpNq7f9U4PGYV0eUiR4zFVomna9DagccUXBAdIt0o0uwckRmFLGBiwHkSr/WYEEgXAT7v3hJ9DGnNtrgJD/+N+4ZFn0dIDSDiZcTOGL/w/rmaFJzoEKBDaVs8J3veLITZtsNnSmFJAgJHR0WQI7/83u9TlwCjWGXogoKtW3bl6+PxvKZV62RJy2sAbOuDeCyT7SSAL7Gz1FYar/7+JLHFGWLNXzafPRF+ZbKVZj2z6dI0Uotx/lFb0Qm0UpZMmsXYV6WL1Hueo/Kd/oSxPklxFXIuQdsKK+ZZiQzmLhTBH6iQqmRsaNibfDbDwSAkkDmdKmTldjLIyvldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXJoSxeRTKkDbT6BmGww5MirOhjEz1It1lxyiSLGadE=;
 b=DKqiBUiEgIlXPnA6NEMltngp4tAzvn6g1QO2bzKrIOCmXQypzUMmuzP4QadUnYzOch1REHbljYilpk08lRu6IW8mdqmA2xaZK0GDyg03aneG3XE08yiYIDdZEFrf4yQvDELN1z8mzGqVKsDd8Qf0feVeD0/AtHJJNEngtGA5RdHGI2Cn13KlZBRQkr1jL2bW7EhB2JUl85MyXsYu+CbLrMzWNH6FJM7A1n3Wu2sVjxjR5bZ0a8lNlMRu7YG8lDuZcXjeAEZWhLbkGQlxUd//+Q2YblC/Y+pcWoYrDxBoZxiRCiM9rTK9ize09NoSBtV5DX9QAfa1qm7I0j2DOyqmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB6214.namprd11.prod.outlook.com (2603:10b6:8:ac::7) by
 CO1PR11MB5156.namprd11.prod.outlook.com (2603:10b6:303:94::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.20; Tue, 24 Feb 2026 06:21:20 +0000
Received: from DM4PR11MB6214.namprd11.prod.outlook.com
 ([fe80::2896:ebe:3c3:8584]) by DM4PR11MB6214.namprd11.prod.outlook.com
 ([fe80::2896:ebe:3c3:8584%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:21:19 +0000
From: Bo Sun <bo.sun.cn@windriver.com>
To: linux-pci@vger.kernel.org
Cc: Bo Sun <bo.sun.cn@windriver.com>, stable@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lizhi Hou <lizhi.hou@amd.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: of_property: Omit 'bus-range' property if no secondary bus
Date: Tue, 24 Feb 2026 14:21:03 +0800
Message-ID: <20260224062104.140453-1-bo.sun.cn@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0338.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::17) To DM4PR11MB6214.namprd11.prod.outlook.com
 (2603:10b6:8:ac::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6214:EE_|CO1PR11MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca6477f-939a-44a7-dad2-08de736cec8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6Okru0LXPPiydIMUuDHZes9ZjIB9cKl1v3Brw27+6XW9XG72AYagBEA7081?=
 =?us-ascii?Q?jBUA1SyEa6tsgsKu9JcNq4iSiw9XrJ/kvnaNUBsydzVbFFnsgEbLm/Yokuyj?=
 =?us-ascii?Q?2KR+k50WX0WqVndm3pK8C/dGpo9OsyyXVJg/nOyNbvF+Wa1BGyXBqfSpt/VS?=
 =?us-ascii?Q?ZTWPamWlvDoFVyIwSafajUgwNjxRoi8fUCLWfUCGysnYFEFcFRkk0/VuZ89j?=
 =?us-ascii?Q?PTFHXP6+aSqhHimipQanVnxN1n6aYPh34JvWiKVmHrxeqZ1Fs1paZ5JhrnXS?=
 =?us-ascii?Q?Er7MrlgkTHFx7vzptqtkP9qdT2UvA+2O1hjdOnLjuNfC72g8A6qqCkDBDkGw?=
 =?us-ascii?Q?XAJFQg9VBs6OLSDe+jccpEfal79szV33paOUlGe9BhL9T8vcGYlvMxkvn5Oo?=
 =?us-ascii?Q?VS3PDb/NWOt1rcop3HCtYdib0HwYvleC1P7rbXO2BNdnW+eTaVeHSxrQrj8z?=
 =?us-ascii?Q?q6BiJ1CWV9V5zWFfIeSATQKhN8CpYoE1bafzW+rrjh4WgnAc7FAkjFwX3yBo?=
 =?us-ascii?Q?cIqUtclvjpm7CM8Wwsii3krZ+Ctajtqk6B7ffDO7X5ZnWdZRZ4Am6UUNbd6S?=
 =?us-ascii?Q?nkAfmEEaxtGr9awZhVN9pOA56ZkXR46SgK+PKo5Ggi/zAk2SjQks3Q3YoeCf?=
 =?us-ascii?Q?94V3NvshCblDaxKplgs2qPFGEHiYHlFMfB8D192lHd0lr3i/ottkcKSGpaK1?=
 =?us-ascii?Q?HJkP3Rijysd2aetzEgvu85JbbYG8IeVrlG+F4QwnGmTUWHh2HyHURZOb+x9R?=
 =?us-ascii?Q?yw2vITlS8T2rkpF/jgtTfQKTLpm76HFBiLvBIeKlzRYr6jhKH7xmINSzYXVj?=
 =?us-ascii?Q?5Z3gx4hPA+mMe0KjxlB7ZfhwRejCaKiWhBqsGTreVlajMi09ZzUQ4Wk2jxCG?=
 =?us-ascii?Q?2bL50gL2wA4QaZP0p99ITA3NzytWQ7akcWQbiDd5VnmAd0xqpSY/zPkjCGsH?=
 =?us-ascii?Q?tOnuB7LGmt/eZ/HMBFeo9oTGroZhz30uMQK89nklouzjHyYQngWXLukxMhgP?=
 =?us-ascii?Q?1XRT0MUO/DBmlQ17vVak5GufiB32Ak6L9OTKd2s5i8+dQFzcOcqO63+edD92?=
 =?us-ascii?Q?JmPKgPMJq+hZKiTfjySS440KuDC5adU5pB4fKvVTOLey8/IvkJ8Or+0c1MhR?=
 =?us-ascii?Q?Xh36npfkrluCBQe4N8WSEAjeOwg6i0LYwH5EwgVkf+P8L8Suvv1DzBXVsMwz?=
 =?us-ascii?Q?Nwaho7bHguxqCJPUcUAjGafZrb1D5yeYZTiiuXGrPF5JvuIZJRK/MKB/sPrF?=
 =?us-ascii?Q?f3rxbbS+g+th+J+CdqADuf0irYL4NkO/WkN43Ji/hWWl9w2Rpnfy6nbQMHFb?=
 =?us-ascii?Q?i8cteMG00T2Fy6DH89xJb+agetE5cFwUFC9PMtuhwPjGTOzJdkzIQoMPXai5?=
 =?us-ascii?Q?tvFMqrBTkcE8VqNdwtSnEqSdWzwxL1hbZHWX5g/PFohU1t9FG2E1F8l1TU+W?=
 =?us-ascii?Q?4Ck8pT4NAWmZFlHLfyBqQhRVkKGNnguBcSDt6FRpDxNJsgfUA4Wm4m7+3/zo?=
 =?us-ascii?Q?WV2JQFXkAwcSB0SL4hQow2qZfLTzNfKHq8kF0hKgWipO8i3TELXKAB2MiKae?=
 =?us-ascii?Q?7YvOZW365I27rA6tXPJcPlbNVGLKQFSlM3FyfuqkrJ1Y/8mTTbvMW9mi5o47?=
 =?us-ascii?Q?N5Nxxq9y04CZBfKs4XrT35M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0EpbP5FtYJu89k9mHjpEnF7nshbhmRJMV5g/8SX6vYwn01AkBoEdvmrEXoer?=
 =?us-ascii?Q?Y7ck+R/FRyVujr/0zh2Y2zSbe/marPRT+DP3j2Fqo/qfjQOufzTK+rQhE5C6?=
 =?us-ascii?Q?tZ7kBWUFvXFYkjpf5D5Z7wyK1umefOO06j7+d1EA3P7YHO3dYnGxSQ/NfDGu?=
 =?us-ascii?Q?h4wXldCYKdUPlqhIx/Flmg3+sBtQeZYCYl1LK4kktPTi4IxRUOZyH0J/fpy0?=
 =?us-ascii?Q?8wyP8Y7omjYnLdr5TUX2kdwZJj22NgPuveXg2t+6OYDqwVlbpV1m+e3ARQKY?=
 =?us-ascii?Q?GcFt3A+iih89iG3GqY0mSaUuoJk8I+ufDeAbbXdnnImEHGILW11F+fhesc/i?=
 =?us-ascii?Q?/ztNyoQrgtsBaJHThWDvphYjQ3mAjI8Awm+yj1rwPRPSzSfvCtxHxjOiQBAT?=
 =?us-ascii?Q?JKY985vPS2Rct9Pdb1fv6C0NAtQfzob1BQpm+1Pp0eGvgq87wkJugs9DKI5o?=
 =?us-ascii?Q?+ZcrZzaWBghV6GuymFiZvlrJE0P9Sd+q+QxM1eQHpGvc67Bhf/Zm+gxE11a0?=
 =?us-ascii?Q?03ZTxkvRR/uVtB3gKIlZ/xdOkR8v8B9dIu8mYlfmb3bcgtg+5fK7tlmAAszR?=
 =?us-ascii?Q?fVKMHDjipmDC5aueCzdPk41lVJQg4KRGD6pzZhOQu7kCdt3Qwp/atFgji9h6?=
 =?us-ascii?Q?Jx10IZR7WmMH3weLG8EPUexc9g9kUz5eG9jvzuvgOUQcMeb7XmImKPBl2R4E?=
 =?us-ascii?Q?W3qsFLZF0QoRUTAGoealxsyXfHb5vHUYP59HLymWcKmxwdPdrzGBmwNoO1mb?=
 =?us-ascii?Q?Ohie/OfdK5L/1FxAUYvpBEs00RtEhoYoEoue7km6sDDKrB2q49aFqHvN3XxY?=
 =?us-ascii?Q?CAjyChY0iXHW2Ap4MZKOVDpytUhcpkys2BeTf71pDmacQpmfb6EkxZfsp4Bg?=
 =?us-ascii?Q?/cQB+NP9H/C1zZ4Jqvk6cqCS7JWPbO8X3W7tZJycL2wowVdXqoKP12YXgumU?=
 =?us-ascii?Q?YzKmprRYVULG76lI1xHFaEyiUOzssPzNV4Ewrj4jOAe3CuhX5X9FladZ3Pcb?=
 =?us-ascii?Q?FK29p/ok4/W7P2fGKr+82hTpbLAJ6GhUt0jiLCFoNrXnYnlgweBS4OcCoU50?=
 =?us-ascii?Q?9PxBSVy5jffzVSZ+t35jVNYm4OIHVg7qxNAQd65c2rGREdLHOo9SZlFfk4Dh?=
 =?us-ascii?Q?SnockeqNZyoXIEkmiXOyIwTPsinB1AXwQ3X8r1gP2Rvb8RU6nbe71TuG0GSd?=
 =?us-ascii?Q?r8+pSvUZgFH2N25bjEnnLil2aAwyOnT25gXbwZF/cCxdxdYw0hvzQ4f8jkYg?=
 =?us-ascii?Q?CDB2A2YgjAFmr21cdbzxTJLXRSi2CrcH/xKsrlBuA4HhZnEhs3PHw7GKRAmU?=
 =?us-ascii?Q?XB+F7D4PgR7o9dBu9aA91YnhIrzmHAwoB1pGLFGOW6K3OoHNjRsBFp6pcj0x?=
 =?us-ascii?Q?wSeWKnimtmvXnfdGqiBCDEqhrTb97Xdidaaa7xYfsS8SCpUkuVFGd6dHSGpk?=
 =?us-ascii?Q?u/yM2yYgXDFoPwtdc90SCBepzOFJ+OlmYH8Fj3rZfYUzzvGWpXZdp/NSK3W1?=
 =?us-ascii?Q?nMq//sgYBwwdlIwaUeYb9dwbtDGMtOus5qJnctff9rvtgvnDXS3cMDMPSSq2?=
 =?us-ascii?Q?gNDvQ2VAWQ2Q0hJzui1OFvWHLbjuMO6VveW3iQkSGuHd/FuBWBjnPET0glA7?=
 =?us-ascii?Q?kcHJIB/PF/1tsDUz+ApDpy7LUjdfhKOF15zH0J5HJaqQkmhRfCCnYF6l6Fsg?=
 =?us-ascii?Q?Yli7JLMKXqd8Uc1eBIvWVawnpBEZph3hluLHZAwF7SbgG5tICKo40/1migWv?=
 =?us-ascii?Q?rDJy9IFKAQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca6477f-939a-44a7-dad2-08de736cec8f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 06:21:19.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p96qY/z4zMWS8vDORbPRubxs3ebgBTWbbuVsQQBgnF9YAy2WRlzFICsMSP9igWkkOxipmAnq/+k7hSdXADTHTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5156
X-Proofpoint-GUID: OmBxK8jdZeVF2JoCO1pjN8L-X8eIlCDU
X-Authority-Analysis: v=2.4 cv=Bo2QAIX5 c=1 sm=1 tr=0 ts=699d4362 cx=c_pps
 a=mfnpAPd2LV9TTO/yo6PAYA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=UaaBw9Nihny3kgCARB4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: OmBxK8jdZeVF2JoCO1pjN8L-X8eIlCDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA1MiBTYWx0ZWRfX2XxvuEA1r0GX
 W0eV5VSxarlxot7LsB3yPd8NO4axbLrSHmp4obGznquboBLWJnnlRWhiET0Qv7ryrguDx4mV5iE
 5IvPLJRuYpCwtd19r0fxJQpcGgPGF3tNtSf7SsCmx25rOtHXI2BdBVfPXLboecnNnjr8H6IWV9o
 yc2wKpOEj1QSqg2t2HRl7S0ZwNSqqRHwwd9UYYFr6AUOTzvy1dsOSX63/+jpYZ4NKH3SLd+NId4
 s60Yz2wbJ4vfQgipC7+2+1E6tQniHrlVSZdAH4iSWxM4GNowjK7+GFl7E2SL/pnBVNY9tkRU7Hn
 zOxoFUyf/qOmDuvZbbuunZQHIzPuPlgAa4R9Uxi4dsg7SzpvEr0FZyHr8MnmUEMqShmuu9Flw8I
 5EQHLlj7olSI8inxC4KQNcCBGoxfMEzCKV5GNVYtyvzwVDSMLZZrYEgRGpVIttOcxftZQ8f/0fc
 RP4R4+9tgJlLMgMKyjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240052
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217862-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bo.sun.cn@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 365FB182618
X-Rspamd-Action: no action

The previous implementation of of_pci_add_properties() and
of_pci_prop_bus_range() assumed that a valid secondary bus is always
present, which can be problematic in cases where no bus numbers are
assigned for a secondary bus. This patch introduces a check for a valid
secondary bus and omits the 'bus-range' property if it is not available,
preventing dereferencing the NULL pointer.

Cc: stable@vger.kernel.org
Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Bo Sun <bo.sun.cn@windriver.com>
---
 drivers/pci/of_property.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 75a358f73e69..cade01ea6e68 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -95,6 +95,9 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
 				 struct of_changeset *ocs,
 				 struct device_node *np)
 {
+	if (!pdev->subordinate)
+		return -EINVAL;
+
 	u32 bus_range[] = { pdev->subordinate->busn_res.start,
 			    pdev->subordinate->busn_res.end };
 

