Return-Path: <stable+bounces-225273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJOsCgvfs2ktcQAAu9opvQ
	(envelope-from <stable+bounces-225273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 10:55:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA7280EF6
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 10:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 443F4303D388
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1EC38AC76;
	Fri, 13 Mar 2026 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kC1XZQ4d";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="afmCRiz7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A732838AC8F;
	Fri, 13 Mar 2026 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395703; cv=fail; b=rEQ6WIR5CrFfK8MvpJP9UiFGTDJC/D77+V7FABLFyAx2DPS1PyJCPG4pti277Ogo9raohgRIbJVLS7w964SE5uHJ7Nqp9D9P4QGvFuwguHWS18A0cze+ViLGGwCaUocmvPyt1pTY2cs2qEEvssN4OahitRVmqwpgmusvV/M5xAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395703; c=relaxed/simple;
	bh=d3WCpp7Au5u/LuMXW/khX4dXC4uWQiV5BrszdkNRHJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBrtOCGtt8UmSiCLIPiZR8yOfRk8YESBqwFHLq1YskZ1JlB+M8IPmRmlIYfgkf2NAMjRM/Nu7NX508yLDgSnItIrfHiznMxEGBH9n5UqtYlAaJViihVpDVrk3w/SSiQU5I7psn+pfvmzRO1Ex8H9J46BIKecZnYY5F/MB+m0x38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kC1XZQ4d; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=afmCRiz7; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D4x0nf2074754;
	Fri, 13 Mar 2026 04:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=HLV7RDdyGrRthjyqNl
	rHo9FaEZYSFctCRiwbX4lyBUM=; b=kC1XZQ4dl59Hp7w+VuEp9bTUxX5qE3l+l3
	TKIpuubqdTL/DGPolPQOZfEFxgE1YrGAGSelLQWXEj9k7QpB8lGujkNkwZVzrG27
	jnktoctQNgM0o3JKtRW8Is0wmpnuRiKETDkgFyjsUZeH1iGNNo4Sqd6hGVlK6fjm
	tZI8C4T5snHXXLfsKXaVQKRV92ygG/moeUugeVBKH4QF/c+delTmxoRf8WMZHuRI
	S2EB5jvdkGwvc1H4+jC+DacBlHEQPy6gmO67raJ9SpMBjRCFQ3ZNB22KpuVpOA7f
	wM+5O6lvTbGgK6/vu3Hku/Q5X4F+wRJ2SoyAdl2e5PVX5hIV9IFg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021128.outbound.protection.outlook.com [40.93.194.128])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4cuh78t6ty-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 04:54:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZdZ13sQj+4S0NQyDsp6rHbp/eIE+KxCNydS+7rycKUjaL1tvyZxIgtkHNdkTBK+AvhLpKBwImDDv+5uu30jIsFgDu83pTOy67F8CAYAd7HLBI1RtJFTvuEtyEqLeHI42CNdCrO7xnODX8FfsEVlO03E405aY6GMlad+/TU5tgfu+y0Ew628zs1/KP3F6+BrYAtYDA/pLKshB0uSX8cd2U0Pk4bbfudr5Wp99dyETKnEw2H0/w6XH7LeT9fSPSwIToQ6E6E6eiJ3C28+YI95CazyN2fikxpGmRvpeNlrOSJUo34LX12f9Ia3Dj6gUAOodfqih1ZpLAlyMzQA1GgQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLV7RDdyGrRthjyqNlrHo9FaEZYSFctCRiwbX4lyBUM=;
 b=FF7tNquvU1y4tbmkkQeEC5YLx0bf+3F44p9XlU/gCcjjUYIwT1mcMf0PPi4tiZzv7loefLbzJ87DleNjfvZVighsQpBjJZOmcq4PjBXsSo2O+P4ittjoXLe7qHtjous5Hckdo4QBTsN8BfNA46yeIpSQT8RQighO3HPeb7fTSanRIZKdB3MxPdX8XLVAQbmphJgHvsWllIJlVJomk7B9gVzMZjly7BOLIFcrG/qEh40kFRoMAZvVs2MqQVxe/9bthGYIDw2mnDb7er76B38TLuNS48uhsJMHUbNSt0v8ashmMUURB78JgcrAi5FacwvqDiTTB9tGmMUyjuWU9zzelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=intel.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLV7RDdyGrRthjyqNlrHo9FaEZYSFctCRiwbX4lyBUM=;
 b=afmCRiz720Q2RobT4pWzP2yXrPHAeNXCDlsO+PUNSEZ21OENtZ5EM918dy7TRoXgVz/NFujA53Yx62J5Z4LM4I0SwE984gjDJDGVbkG+hfc9BOBiTPhJENcZaU11EpG+rO87QjVGsBiD4qI/auwH4Z3EqgiSkyDWLs63+6XlYBA=
Received: from BL1PR13CA0162.namprd13.prod.outlook.com (2603:10b6:208:2bd::17)
 by PH0PR19MB5669.namprd19.prod.outlook.com (2603:10b6:510:14f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 09:54:31 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::19) by BL1PR13CA0162.outlook.office365.com
 (2603:10b6:208:2bd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 09:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Fri, 13 Mar 2026 09:54:30 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 7B89B406542;
	Fri, 13 Mar 2026 09:54:29 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 626BF820249;
	Fri, 13 Mar 2026 09:54:29 +0000 (UTC)
Date: Fri, 13 Mar 2026 09:54:28 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: gaggery.tsai@intel.com
Cc: linux-sound@vger.kernel.org, mstrozek@opensource.cirrus.com,
        yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: SDCA: Fix NULL pointer dereference in
 sdca_jack_process()
Message-ID: <abPe1EUHUX9ZRZJk@opensource.cirrus.com>
References: <20260310183829.2907805-1-gaggery.tsai@intel.com>
 <20260312143218.2008222-1-gaggery.tsai@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312143218.2008222-1-gaggery.tsai@intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH0PR19MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 360ac12d-1e7a-4240-404d-08de80e685ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700016|376014|82310400026|7053199007|54012099003|16102099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	59CPR7S3ljY4o4vMLbTIvXE8lPkeVtyKy6z1linTG2T9OJGT2bbVs4ZNa5oii3iMM1VILOJafj+ctX0wwVGXkWd7V1Zbr/iunh8EHXCj/OkDSi1RkrYhjpnpwQvxBwQRpMkSodB+aD1rookWAg+7pxYwNjVyccDXZJ3ooKe9GV3XI+kheUD7tafIuTURfrA2khK+x8ldcpK2bzvwa/Fzdxm4pwZOGdzUqf+C2yqjBbVsbgHxWQtwLlH44X4GqLBSGpiHWl9H2jLDhZUPqbYCTwfy0PT/6auIYbjsXXyUmrYUfILpk39nQZr63EjyaSYE3gS8NOcbvbRh4Oishjb1+G8bY1hCPQ3RELbwOApegZUzX1PBjWPZZnp2lM6g/GqUyhR6e+TS7ZpXULIj/S+nz+P4PS5H3moU3ka1b+HYDgMSXcLVY9+ojXyPD+Sbsrx+UE9SufSTCYGn1wCkDxe5w8lEia2DjdET9cWZi0Tzm1faXZXVDZMsdVbVXWUeBB2//nHXQINU1ihulhCKqGZENI5XP61gQOgt/KEE7Q4j0UiWLbEKD4jvXan/7HSa1Z2IcMmC+CK/qkO5HG+2TCMWsuZQw3Lr6dExj8lfBmA/ky8bdog4Ddr4k8AfsC/w5xf6aKQSgiBx4FcZyWmYPyQ0LUBm8/dqPwazLmX/lFSdhJup/00ghWnQzhjWPYbFNsBgZxk1cQRDK2nqi4JxzZ8EEy8QliRqIVayl2uS2KdjcLmWAKM9ry1yAtd8pj7Fy81O6mxHmPhO26jkib++BLC9ww==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700016)(376014)(82310400026)(7053199007)(54012099003)(16102099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/4kypP6vj4IUCD2+zGPG5tcFqDDR/fzCx8eNWz+dWt5Rl0G5ZSwIu0J4Uol/2Gc4PmoYwTVQ9HPz6WoA6lB0WXy2moBmDq56xZ1dVtmRlhl1AEMdSbnXtXmaL0QexzeWVUXpt7V6dHI5K/pY519oYNV+ERj/upKvrP/fwDFczScvvU9tCv8vNLSVcueHjybb3PtMXyow5W/Mj0ACBPGtMqPPmd7B+9l330Kpnc8g+Y1hu2Re3uLahXMa0xYfgOp5PPkg3Bv6M1ohdGzUbh8hU+SAvgUx//4E1+EZRMNMYAUXqWG4BnBRXjLmuSMvgBvbrvTVHoVkeeF2yJApRmqJlSdcaGcmzNqpWR445U2jpa1CzDUNIkKKjSltKZpsHzqdBsE4DEJCQU4IHTyIisXKBRbpCWYKxKlkmIRj46cT92onshy7DkDUAbEFtBlHQ2R/
X-Exchange-RoutingPolicyChecked:
	kof/THu6OGOYKgiJrZZ5AWjbbzTb/60seRQpftj1ZLRT03NP45EpBh7BXoM0UhWxB+dq/TqFNa0dE+f/oYl3rOi7CsdX+uHFnURuUsufnP/qWY5OUMzqLZUdffOUfeEHna9rIM5GZuHhO9YR0Ab1dOECYTHs/SagkzTBM1qAnRIn30cKEElAZy65Y7dYOVTnQN2SxcZf3dwvKsI6pB+XacjrrjAF2nR2ezKykfH60Rqx2+msgFPK8Lk15SZuoG04ocmSMocNbGHHYqJMx0S/N0fe+DcQj+/GIqH+oHBv/O0tD7pSJA8DDDlpJrN6BMG7HjJCxJY2Ls/95Q6uLlZuSw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 09:54:30.8950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360ac12d-1e7a-4240-404d-08de80e685ef
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5669
X-Proofpoint-GUID: g770hF7uCJ3hUNKJHq--uCwmm6a5u-Ob
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA3NiBTYWx0ZWRfX/d4kbMkKmJKW
 /hfyRCCI8IP4hg6LaDtT/QqOJ+Dmc34OEdM84Z6EzD9l5ZhL1baEwfBV5ffkEVWCMhyYUs4pMSj
 7rXWo+JGx6lNRgrsrq6jsVTcGXWMSIOitVAJPutGycwAZuKYqGodL3zj5+tYCi12tLJmLoWEClB
 rpH/qPqOS50NcZjxUmRULJmC6KMgj1F4zRtyFq9xPUnY+4VhImKKSrfsllqxErhhj4F+A2dz/ih
 /kOWP6//3aW0pib4RfLK9xPPJMNTN5o3oqvpTWlXnNRxMiHMzfsc9RLOdZsqwsvGRdV15by4+ZO
 MCSh663R/5clEkfqVfJPIWcK5RCCUC1X0kTiutaKG6DpK1iA47ncvNWi3cMYLIlXWL7dHNWLBU5
 pAFhaw5sfNY6er6WCS4MM0qbyejN9SxY6rhDVYg8mLSB5ptjAnIguJmXbCcghpt7nxOl5r06WxC
 c99r4iyRMLDSjrNNRqA==
X-Authority-Analysis: v=2.4 cv=NMzYOk6g c=1 sm=1 tr=0 ts=69b3dedb cx=c_pps
 a=iGETFsOoOHXRiUW2e12q2Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=QyXUC8HyAAAA:8 a=6ivFBjKWwyHM59mUNFIA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: g770hF7uCJ3hUNKJHq--uCwmm6a5u-Ob
X-Proofpoint-Spam-Reason: safe
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cirrus.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019,cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:+];
	TAGGED_FROM(0.00)[bounces-225273-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,opensource.cirrus.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BFDA7280EF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 07:32:18AM -0700, gaggery.tsai@intel.com wrote:
> From: TsaiGaggery <gaggery.tsai@intel.com>
> +static void class_function_component_remove(struct snd_soc_component *component)
> +{
> +	struct class_function_drv *drv = snd_soc_component_get_drvdata(component);
> +	struct sdca_class_drv *core = drv->core;
> +
> +	sdca_irq_disable(drv->function, core->irq_info);
> +}

Yeah as Mark notes this is really just postponing the issues till
you rebind the card.

> +	if (!card || !card->snd_card) {
> +		dev_dbg(dev, "card not yet bound, deferring jack event\n");
> +		return -ENODEV;
> +	}
> +
> +	rwsem = &card->snd_card->controls_rwsem;
> +	kctl = state->kctl;
> +

This is really a bit overly defensive, its just a driver bug if
this is called without these.

Let me have a look at this today, I think really the problem is
we shouldn't be devm'ing the IRQs since they are not being
handled at device probe time.

Thanks,
Charles

