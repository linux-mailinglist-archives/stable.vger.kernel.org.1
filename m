Return-Path: <stable+bounces-225571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNu8BekauGlYZAEAu9opvQ
	(envelope-from <stable+bounces-225571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:59:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645B029BE73
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA83C30347BD
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507D5396D27;
	Mon, 16 Mar 2026 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BnJxoapZ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="I9nKCGTE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC2530B508;
	Mon, 16 Mar 2026 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673119; cv=fail; b=nwv8fgYXdKdR+nGMmjNOhjIBLbfKcWhaD8zGWHyW6mCRzmjohmOTor6fLlML1K33sp8M5IChY/U15K4LWuHEZ2gT8EKjK5iQ7TfaZJbehzf6T4bcouEF/3aVMNX9ObkPcPqDP8UBzKz5uRsu2flhqpRgU00HMAeo8mg10ono20Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673119; c=relaxed/simple;
	bh=g/aljvu8CRCQg23dULpWm3njRNP4P0AHOYJ8zGy74HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in+ZmQK6KjjciFog0CI86Jg7yppt9BZkowCrC0mS0rc3K7qNwgG3LIMWFA6+3onusHfvXW3c5hqdyTHc04+lX9MIuTibqPH8VUEIY3kHNnx7yUIoD8MhGbz6m45zynwOcvdkj7Z8zJr4yxJJrISw9FuwyRwfgIuKy3Y59neYzFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BnJxoapZ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=I9nKCGTE; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GDexLH3504530;
	Mon, 16 Mar 2026 09:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=2x6QyorVSjnq+mldr0
	rGDNrnOxn2NwSzyBSOrJ8hMEo=; b=BnJxoapZjChyo3eykafHIAhmIctFx802Cv
	Prd2W9nto1YbFTEAfr+Ctqb5UsF7mrxZ83PIoYOKzWw5WaK8kA1vsIbRDuYBfxvP
	txoA6mER41KcXgDvX1TYWzVP03ufnehhmPoKN1veW0xLq21J6KPmypCnpZn1XNSX
	PYOQdbog9XjiyrPqChVkJf0PjtV9dEnZbjOtVGafIkYTmFx3ZBlLKHP4p2icdEGC
	pOzJ9rrsTCGzbhA56Ab8WHTHmb3ZhKfTK3hx8dbLP0GwKRgyfKwlLvZRg3/SAEYt
	fnzAWZG79vizkluP7wR6N/IvKhRl9wrceet4zwK6GLV1XyvnHphA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020121.outbound.protection.outlook.com [52.101.46.121])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4cw43f25y3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 09:58:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhgnYiyZTmjjSi9/2ghkN1ErWGRu6l9Wzedn05I0X0ZEs/9Ef07rjLReEX+Q6mzR7Wbpf1BSgkCAWoHWJVJo6s1LFWWHvz4VH7jt4/QK4gO4gqnmanu6j1QsvIB49hGPsdDyQ4TkY2YTKlj1gW4udx+1vPcKv4lpL9VU8zk43aUwXaMeFbsn16EXezZ6z0yigmmljh6+oXfj++VxSCwZNWfPWsqcxJi4y+QAuvl3XvjBYYQrPHQ2qWF3okBKsed2YeG2rkIBpYpooCO0YFb0NtqTJK0y8DyYwsW64PRyZnA3/f19Xm1R0iiCIHsNa8L0NxQcFu+H/hurAxMC+6w7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x6QyorVSjnq+mldr0rGDNrnOxn2NwSzyBSOrJ8hMEo=;
 b=y4CmPWepnmJ1rx7dvc8Bol2WnE+K7Jw7BYQWq++PewnFwLXk7Rv9F/kB9JSEPmy3CyY6peSMNYa563cterz8eIcpMl45q2E3+/aPCTDi1XiPfNL4KCd9yvKBjAyWaAOGTitgrshsyKKvL4B6zd4LjrWhuiAagFE18i5ioB8zzrwfMZriDTSyeC1S75G64+BsrVus4mNO9mkK12oR0jntCWdELG9f+MJiZUWnweyT75CQO8YmdAtCf3P4GtPk3PkOg6Dg07OqY2fgFAoRjdPeI2Z6xd+Yf6fl/U6QW9ZUfi83Oh0sAgFdr+aC/QVgCzcokY1eLVpWcyo1psZSwkS9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x6QyorVSjnq+mldr0rGDNrnOxn2NwSzyBSOrJ8hMEo=;
 b=I9nKCGTEcZWYbZlMyACAuXmO4Xl+b0r/tm6KLnGaarmI1DqU4yGYlvPMfDW8UmaY+mRDIOpcd5Wla8+J1Vf1Kb8d/56G1pzbCsO09cbvxdTiXct7WrDXjBWeCVEF5yOf7C1f7M9WIjT8riAH3RT7r5+4hY5zVdtNqQVvV4Rd6tk=
Received: from BYAPR07CA0077.namprd07.prod.outlook.com (2603:10b6:a03:12b::18)
 by MN0PR19MB5827.namprd19.prod.outlook.com (2603:10b6:208:37a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 14:58:26 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::f) by BYAPR07CA0077.outlook.office365.com
 (2603:10b6:a03:12b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 14:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Mon, 16 Mar 2026 14:58:24 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2E189406540;
	Mon, 16 Mar 2026 14:58:23 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0B327820247;
	Mon, 16 Mar 2026 14:58:23 +0000 (UTC)
Date: Mon, 16 Mar 2026 14:58:21 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs42l43-jack: Remove manual pm_runtime  get/put
 from tip_sense_work
Message-ID: <abgajYu+F769Amct@opensource.cirrus.com>
References: <20260316124924.31047-1-peter.ujfalusi@linux.intel.com>
 <abgTWxI1Q9M1o+ka@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abgTWxI1Q9M1o+ka@opensource.cirrus.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|MN0PR19MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 459cd555-50fb-48b1-d74d-08de836c795b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700016|376014|18002099003|22082099003|56012099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	3ceNzacuvdZRvAgkKHlojzyfKBN9cK6g3Qay9EG88c7g+iWaYRp9USDqvBG1sbAL0ODPhukW3K0fS3RdGdsDXR8EGK5QYDtO2A4+r/+aKoxwDNcWhoC4wR5DPLTXKSBdBz0boJglqXyvcdrtHDjoyWI3U/XgRd58JHXTbz4k19DOCwweuvrEYwYq3duFIKY82iHDO4oMLPvhSOOB6r/YBwbSFh36CIb9HYEr4eteC+NpjYyU/UXfMnNvbVoZzc/Q7SsoUN8q8ruow32nOhlWVVKh0MgCDzpMN0hepIw5r1LjLdOOnDaibAttYN0fH/t/D/2zsinidelv3M0p1CdEIoyzQkrWZIefOHsrP3PjkwuBAHB8/awujJAOrLy1N5QE50OtkEE/Pj5ujD128k533955fx6f0PHH8SkLoSN5AglnM2yYgjrI3uCQk8rkwDvijkwhSF6ecBXJBkBhPZ3IfvkXC7LJ9J3Ke/l2G6hVAMqlfz5QSlQ6fGYZ0AGD3TxYs4iQYhDHtRgJaCwL2nE3nFx6WGlexxe8L/rbVxIMe3i0ELmUlpt99ZHLZ8keHoqdBPFKLbngnn3eY2Cf1ZJhidJvc2vLcSNM4IHsWT3RextLSZIbU4UHcQpFaqELytmOdhrouEalyAufivNxbS8w6QZfVHm3X2bQ6Yxi1kgpF/hWBP8GXSSpeA0VdbuGZiOEMUwNbMw683ooGMBbOPYsTlW5rt4gXZkg80X2Up5gJeRadK3pXEY6lkEloNRcx/M/qrv1Vx///3zXDtBWC06kaQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rXTredVhIOQLpgpOg2Iujm2Mx9tSz5PNVDAVNQSNh6dDdDOAdzbarOB+c3j/YBChbL5/g9QpE7IXwSBoZlgpbjGhUnp2H+vOkH+BKikaMvzerXQY/rGnPfO4jgH5hIyr7Y8DMUrMLKqCxHwJSZY0rfIga6wa3UuvYEcyL7qoshWWe6ARi5oBTHgxpd1Mq65bcCapXVl86HReXKwtSarzZremynceZAfcmc53YROUwVIB2y5eg3XVEY5iBRL32YA6t2LaqpdIYinA2xsE+SQcVadP867vr0ynC20o3BACVXSmur5GIFw6NmlDvu3owbbICBDUq0eKysJcS80DzP6KAPLp7jvo7X7gRqEoMjMACk3v68x8GwDY4wuc4WwbPhe7zBMZcPo9NMLt4ejv6Z/oqzaQGeV8F4Iwm+rqrje4H/KQFgFvWR8tYFprMvRgt5Xi
X-Exchange-RoutingPolicyChecked:
	YUHkSocxY1cN+oIAXQMn1ZvVCA83V9eLV/zOcKNsmgMWmUP2Xj+L9hCAkRJR2LXD6nBH0ADgDOwT2vif9x7i/j1gF47xcdUT/xgAVhBSr+SI6snG4p0vN4NXo9mV6XIT5TdyBnNW7Vq5aP1geNsH/o512o/d3SG0ctW1gfgstsueyUreJTRJ26bqMENXVt/Wh7H7bI7Xv4i/PA1KApup/U1rfG1xXYEA+gIlUkZdeI02eR5e04V2Po6G7MOX7UgPpukqSMvCtR+2t9n8pLEs0UKhgOuGy5uPw46bfd/4y0ubDZwVRgg7K5A8wjiimKC41NnDgora1oX8R2uJx/5sTA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:58:24.5700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 459cd555-50fb-48b1-d74d-08de836c795b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5827
X-Authority-Analysis: v=2.4 cv=YqQChoYX c=1 sm=1 tr=0 ts=69b81a97 cx=c_pps
 a=pjPKNKgC2VgaEdt9hcwoBQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=hXHgDl-imSNk0r0C_cIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExMiBTYWx0ZWRfX5Ba0Dwp6BnXq
 x8Dip39OERlE26Wz4aJvmgF4V9zhRiyiOnBcpp6bXTTzoUJEo7euXzc7XGTerYiLAZDx0NdNpMY
 miHpL0djkiTwNMbUN8Uu7+B5YmtOC0Ub06uIHyRq7IJQkoVg2GIEfHjMb4AglxEORlzSmdUJb+R
 fJ5Wa1Qc8jbcDyakxMTjoCVdqHi3yWMmJWMLOkEMfDLJ3Dpdk9F+wAxck4tovGmXOSgbd7xFic0
 GEpMqHwZeEFwM47EYCwG8MgoLK3dzOD6GLlUlz/RFkEaDLmXGar5O+Ec0NOv9tWJXoXQB83yY/g
 j2DhVG9U1KdchlaOnHV8XTaLHNMZ303k8s42Jp7KFCH/ndbgvO3nlYqSgfwWCNX6ETNrSiDk0xE
 JPIgT77iagMScgfJBZhUDZXhu9FIY9jjoXM6p1l9fUEadw5TO5HsaU1/cu36RsUORm4foYGhZv3
 i0ihRLKkKixuXd8s1Ig==
X-Proofpoint-ORIG-GUID: svtx93DcDHPQXX1r-kLuwatf8zZ3qfYb
X-Proofpoint-GUID: svtx93DcDHPQXX1r-kLuwatf8zZ3qfYb
X-Proofpoint-Spam-Reason: safe
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cirrus.com,reject];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019,cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,cirrus.com,opensource.cirrus.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cirrus4.onmicrosoft.com:dkim,cirrus.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:+];
	TAGGED_FROM(0.00)[bounces-225571-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 645B029BE73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 02:27:40PM +0000, Charles Keepax wrote:
> On Mon, Mar 16, 2026 at 02:49:24PM +0200, Peter Ujfalusi wrote:
> > When a jack is inserted the forced pm_runtime_get() will keep the codec,
> > soundwire bus and it's parent active as long as the jack is connected.
> > This makes for example the DSP and firmware booted up on Intel platforms.
> > 
> > If the module is removed while the jack is connected we will also have
> > unbalanced runtime PM state.
> > 
> > Without the manual get/put, the button detection still works correctly and
> > the system can reach lower power state while the jack is connected like
> > in the case when there is no jack connected.
> > 
> > Fixes: fc918cbe874e ("ASoC: cs42l43: Add support for the cs42l43")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > ---
> >  sound/soc/codecs/cs42l43-jack.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
> > index 3e04e6897b14..d90a13a55845 100644
> > --- a/sound/soc/codecs/cs42l43-jack.c
> > +++ b/sound/soc/codecs/cs42l43-jack.c
> > @@ -756,10 +756,8 @@ void cs42l43_tip_sense_work(struct work_struct *work)
> >  	ring = (sts >> CS42L43_RINGSENSE_PLUG_DB_STS_SHIFT) & CS42L43_JACK_PRESENT;
> >  
> >  	if (tip == CS42L43_JACK_PRESENT) {
> > -		if (cs42l43->sdw && !priv->jack_present) {
> > +		if (cs42l43->sdw && !priv->jack_present)
> >  			priv->jack_present = true;
> > -			pm_runtime_get(priv->dev);
> > -		}
> 
> Hmm... yes, I have this feeling this was in here for a reason I
> should probably have left a comment here. I somewhat agree it
> looks a bit mad with fresh eyes. The variable is also only used
> for tracking this pm_runtime_get so you can drop the jack_present
> variable from the struct as well, if we take the patch forward.
> 
> Best I can come up with was it was some interaction with the
> Intel host's doing a bus reset when coming out of clock stop. I
> think that might have caused something important to get
> clobbered in some situations. But anyway will do some testing and
> thinking and report back.

Wait, I think it was the headset button detection. I think the
problem went roughly like you get a button press on the headset
whilst the host is powered down, the device wakes the host, the
host resets the device, wiping the button event. So to the user
the button press is just ignored.

I will try to find time to retest to confirm this, but I have
a good feeling that was the problem that caused us to add this
runtime get. I think maybe we could get away with dropping down to
only doing it for 4-pole headsets so one could still get the power
savings on 3-pole headphones, since the buttons are not required.

But fundamentally I think the issue was with the bus reset coming
out of clock stop. We had erroneously assumed on our end that only
clock stop mode 1 would include a reset of the device.

Thanks,
Charles

