Return-Path: <stable+bounces-219867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FycDBPNoGkomwQAu9opvQ
	(envelope-from <stable+bounces-219867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 23:45:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4751B0804
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 23:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5810305DA9F
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 22:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0432426EC1;
	Thu, 26 Feb 2026 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="WIsEthxF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="Yz+xiMt2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AED37880E;
	Thu, 26 Feb 2026 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145934; cv=fail; b=rceC1WM/by4KpvZgOJDz8KdpwYF8S7Iso5FvBsMC59FenFrq44LQnt+e/yYCCK+pec1d8ugttfkRh3NNUMFodF4LpT/OSZS0qLMdwIghwnCE+PWbxN2QktmYT/C18cRnxy6ycc6DSicNbVYjcjNSYqcdWwdfBDo1xiFkXnYiqGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145934; c=relaxed/simple;
	bh=LFZDxDQVJexlaxDxzvKQK2UqZcwUUhFKUylN4yCNE8M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tTTMFwbpLVfQXDoHIxtktiahqKQCznVen+ZM8B7VzSHqWi4dEQO5odokkrt/9/wW8YdDgQMuv4vqdCBh6HD3GZ5wnDftjQTu1FGW9wwc1OtcS1aNOWW4SNGPrd69OPppMg31c2LX60W7KW+qHhOM3LHhEU242ivEh1Q3W43If/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=WIsEthxF; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=Yz+xiMt2 reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108162.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QMKOhm1537003;
	Thu, 26 Feb 2026 14:45:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS1017; bh=pZd0MRfPPl851xDDQz4VaUMa
	0pw/YKqU8fEAKqnpWf4=; b=WIsEthxFZy6bOx19VSJOy9f7Q0o3PTALLZ2TKk0v
	6B2j+y74iTuljvGv7uSzDc684qVnH2Y+xIoxonIYdmQhpyPazSvY3zV7uei2Yrta
	9E0exmOKnHjgE6PzBG/khSCWXEULomk0w409uQ3KbIKXp9B180UbTjrf5F8NTog4
	FDjW/g9tfv3fSqb8BLnJQLXsRcb90b4RFY4kAP68TAkDimd2H4hTMwVOhI448Ndb
	Yd4dJL9E+iHLnUWVRInE+zS1TgKgaxFJ9Uadli3yjxUxQp0Z3As2PID9psftuAY5
	wRSBW9t9ObmyqP277uz8DkYTGRexyjHllZgh/xQL2qowzw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 4cjre8syrv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 14:45:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b10bHh7DxLb6smaJuuBXyIo+zehTb7GxLCpuFGzQnxDKYZD9JABuvBjwTiswpzGfECw/LRXsfCdxuFGXZDdhd2bqcDYfhQt8ntFpQvryxJY1G5zKo8MJNyJeHw0gaNadhDLj2V82zM/v54C113ZQ+XPyRjeuXnK9XHLVnq9YuRvdmNEhMrBMt7j9TBW1PxezoRfAg1NgyydMn/pOwZ6ZFr86vddYKkF+QfecFcYcIdIFRUsBHDW6oATrW/uRcfTl17wuRnvGSIzMv1y4sVBrC5yjldzJ2+IPb9FMuwDZufX+MxGem0yYdYPXnD+xWzD3Es8EJq3+O6zuhb6Jrmm53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZd0MRfPPl851xDDQz4VaUMa0pw/YKqU8fEAKqnpWf4=;
 b=DrxkruSg9I89EIYB1EeTPredSdMNe+tVBTiLzZbHnyKRbBzuC0MeWQrjSwDhuZn/n8+CCRLsA7pL0VqmfNw1XhibwaWYe8nzi6e0k7DlbeoP6K4nWiEXdxtDdNzNzhS9x7jhN39ZyNZYQ6XYF/3nmNGVraVDYT1z9mLW4bO9PGeBRBGSgmRMl4AFLZTHQqqSIVoHNgn38C7CocqrlectmTk3zPW6eh7HJz9mRnBhLPY02weO9IwVhbmzlsh6KTJGPEEFZN6sZBJjkenc3OaE4+7NeivOdCwDbhY8IYQZPQnQ93F79bk3B/v7fPjF63xuOf8LdRyHAMLMbIsnfW0b4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 66.129.239.14) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=juniper.net;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=juniper.net; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZd0MRfPPl851xDDQz4VaUMa0pw/YKqU8fEAKqnpWf4=;
 b=Yz+xiMt2rexAGk317uJxVJmSNckrlSdREXrVxdmqt+HNH/S4GXjUnF6l0hB2Ai9mUTpMPj91BHiIowI7Ujqpae+Rq5WGA8836L2Wv1rrr2mswQ6P3vfVlp4gCg6jBuFg84JXa9yNfjWNSzYy9bM9JyHQda2GY9bvxOtG7BoYobc=
Received: from MW4PR03CA0282.namprd03.prod.outlook.com (2603:10b6:303:b5::17)
 by CO1PR05MB8411.namprd05.prod.outlook.com (2603:10b6:303:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 22:45:17 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::74) by MW4PR03CA0282.outlook.office365.com
 (2603:10b6:303:b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 22:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 66.129.239.14)
 smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: Fail (protection.outlook.com: domain of juniper.net does not
 designate 66.129.239.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=66.129.239.14; helo=p-exchfe-eqx-04.jnpr.net;
Received: from p-exchfe-eqx-04.jnpr.net (66.129.239.14) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Thu, 26 Feb 2026 22:45:17 +0000
Received: from p-exchbe-eqx-03.jnpr.net (10.104.9.86) by
 p-exchfe-eqx-04.jnpr.net (10.104.9.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 14:45:17 -0800
Received: from p-exchbe-eqx-04.jnpr.net (10.104.9.87) by
 p-exchbe-eqx-03.jnpr.net (10.104.9.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 14:45:17 -0800
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-04.jnpr.net (10.104.9.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 14:45:17 -0800
Received: from buildcontainer.juniper.net (qnc-bas-srv058b.juniper.net [10.46.0.148])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 61QMjEIG023636;
	Thu, 26 Feb 2026 14:45:14 -0800
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC: Brian Mak <makb@juniper.net>, <stable@vger.kernel.org>
Subject: [PATCH v2] mfd: core: Preserve OF node when ACPI handle is present
Date: Thu, 26 Feb 2026 14:45:11 -0800
Message-ID: <20260226224511.458065-1-makb@juniper.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|CO1PR05MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 5176a24f-f438-47db-2e59-08de7588b6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	lrrC2L6CbvkotHMGWQ48G7JwF0C2r0rVRIHP2veTjru559ZP3AExMDBHgjpIwIS020iJcMp9Zh7C29h2q/X44ITFg+/T/fj5TrQ5J2O2qGFQ0qAzhFvTV3bdSaIuBXwM+IzFTfJz+LUMHlVNM+koCKJpVMUPuAfmS43hy9d1Yv9D3G1glHORU9Fx5LO2T9UjF7WNnSU9Ldcs2VddqDxwTn3znHeOTuNPY+g5/xLFI4T3nvRc2lUwZHOguWLZgcgI9qxABGQnp5eg2dkMhfoxK5jqHVz6qTaaUhNhxZMHXr034zUwgS7yxeS/SnEUsZow76HMo8ykk/J8WikO8KyNNPrRQ9HEssY9poGFiWl6pz0n0C+KmfVo96CriFCbSsCsJX5JmJlgOG+5x47QNrWxn8Om7afkmk1z0kN2pcxnDv7DgIl6Sn2yzHt1X+LA8eqsPv5K5OxyCd8s/EimwVCrcMReigkjHQ9OUT6rs93bL1oOq1pL4pH3Td3GxSTVhVeGq0OT1UioGeDvl1u5YPY6YYMAKTGTxvRSipdgfD6JISHCGGxKlEVDoDv50NheC5R1b6U3lDZnDGku+95EO7+lEOPSoZFE5nwf6jyJqXNwIdLWD4L+mUfKotVbWUBIIErKdrRdVpB84ueXyV2wd5tBBBBwjDSK3BS83qJ11VphypaqLsrLQjSsaqT1gya2q1NwsbxDuTc9mJsQjZLT6iFUB6NQ+X2O/IDkRNQf2mA7by/kWwDRHfb/GHVaT7L8o+XHiWNPgQWAJIoo7eicrOP2UqO365uYT/TJ+ldxBUKh2AtrD9PkEQmWoXsRLumIi1tk/nO9veI5pQeaC8N3agymMg==
X-Forefront-Antispam-Report:
	CIP:66.129.239.14;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:p-exchfe-eqx-04.jnpr.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ibPzz8yZjbtoIHoJhY61P5nRUG8TjLk1uPXNj91Mgbfes3ooPAkYueYN3JvvCh0iVYXcxsFNCkTGElp2Hjqq+H7u7bABs3kSY1iBMDQFEThKY3zOr5wKFPtDeCxqFeWCh+qAlojr2CahIww/wuw9nrXJsLknmuedb5guJEZDRRD4GyDKlqP/8l9v/i2PDiaWu2kXLb11t8bqHSWOzMNXA3BoVwvMY0rnkrlCP1TlP0QU+OcewYPTyF7x8QkENqj3zW8seXrGiOnxeJnaXUfgOTf55EVU8pBoSo8PN6MwSXxHk96oC/3I1CRdXHLzoGPkda5oLnZ6LTZcjGXlyG0xPjKkvQLd+zQp479fL/X8cfm30M5Nyu8Xi7ayIIaVGYPbIR/3zCpGsi3GIHi1sQ8evEl+bTAcdIPv8fPVvt61uWoBTD8VwB5aRJlVddW28hd2
X-Exchange-RoutingPolicyChecked:
	kS8sWPmTpjBE82bPiCV3Ien6xekvz7P5CHzQhJLW3fTVCyiFbmBFn+ttaml0rdQDBkFNet3YixDd4fzhngXeopFOn45C1UlDIAfqvXKWiCApdPFtKdPRXs7SIgQmaxP6uohDfogbbBwhNU4iS0elQ6m9XKMum/uGym+T06sTBrVdEAPpZOM9laKVAPa8EnXblKbhxWSrNGJeTnHV3QiLTZ0KkVUIwgyWzI7vlrl8SBfYI9T4hsnlL/aB5DtftqDcnSViYuIGPYbPvr6McV4qktUO2q7/QVWycXGcgy2tTlx8xlfrj6OWCFFL4l99q8TOj5k1nuQu+a2cgOdDHYuLXA==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 22:45:17.8793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5176a24f-f438-47db-2e59-08de7588b6ff
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.14];Helo=[p-exchfe-eqx-04.jnpr.net]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB8411
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDIwNyBTYWx0ZWRfX4CJOcHQLO/QV
 Jqi6Qfn8UoVDL2QtdI7YTPCT57Ln6+/TXH1biGyp9QC0CGHUpXASIl10J123sisoS8U0GI7rNEd
 IYtg3qcEXvI5jgvdegDr7OMthwUptjtokdjGT6ZwvS7SneW9PuaAwNX/gdHFejvxbn/tqi+FBvA
 OWF+7umHU39qPVE7HoIgwS0eU9tjyQISQAud8yNGRv9Ym7bgky19y8HDyHxtqoOacdFkAkUjt7C
 ZH9wQEUohxYl01NimoWF+18y1l2z6E6WgQnliIPV3Ty9ROfMLxppv2BDL9POqcHfVatkmi9hkRB
 6Rx9gxISFLYCDCYNewuXUC4VCHvkkh0kDyhXvKPglJ4AB2sugGAIyCudgvVHAqJHeE+kr3EOt+g
 K0KGJRwIjAGR3Ea659V7RVYvnZS7zPqGtdKhGuJRROgSpzj3M8PCzbM0EipLaWWxy7ohum8D8xj
 pBPdb7LLsxhmJL8sWWA==
X-Proofpoint-ORIG-GUID: yIVR7wZOsQpUw0bJdTZALAmxW40FTZ4w
X-Authority-Analysis: v=2.4 cv=aeBsXBot c=1 sm=1 tr=0 ts=69a0cd00 cx=c_pps
 a=UNZgSj2+zgRPHH//f1mBVA==:117 a=f/rncuQqEjTEF/G1odkJ9w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=HzLeVaNsDn8A:10 a=s63m1ICgrNkA:10
 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7vL3O5uBSuztJ3xaqtyr:22
 a=03knP-N7grjIAEzMQkmJ:22 a=VwQbUJbxAAAA:8 a=OUXY8nFuAAAA:8
 a=1m0Mplif2iitoPYi-QgA:9 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: yIVR7wZOsQpUw0bJdTZALAmxW40FTZ4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_03,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260207
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[juniper.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[juniper.net:s=PPS1017];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_MIXED(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[juniper.net:s=selector1];
	TAGGED_FROM(0.00)[bounces-219867-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[juniper.net:+,juniper.net:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[makb@juniper.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C4751B0804
X-Rspamd-Action: no action

Switch device_set_node to set_primary_fwnode, so that the ACPI fwnode
does not overwrite the of_node with NULL.

This allows MFD children with both OF nodes and ACPI handles to have OF
nodes again.

Fixes: 51e3b257099d ("mfd: core: Make use of device_set_node()")
Cc: stable@vger.kernel.org
Signed-off-by: Brian Mak <makb@juniper.net>
---
 drivers/mfd/mfd-core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 6be58eb5a746..5c5465763312 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -88,7 +88,20 @@ static void mfd_acpi_add_device(const struct mfd_cell *cell,
 		}
 	}
 
-	device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
+	/*
+	 * FIXME: The fwnode design doesn't allow proper stacking/sharing. This
+	 * should eventually turn into a device fwnode API call that will allow
+	 * prepending to a list of fwnodes (with ACPI taking precedence).
+	 *
+	 * set_primary_fwnode() is used here, instead of device_set_node(), as
+	 * device_set_node() will overwrite the existing fwnode, which may be an
+	 * OF node that was populated earlier. To support a use case where ACPI
+	 * and OF is used in conjunction, we call set_primary_fwnode() instead.
+	 */
+	if (adev)
+		set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(adev));
+	else
+		set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(parent));
 }
 #else
 static inline void mfd_acpi_add_device(const struct mfd_cell *cell,

base-commit: d9d32e5bd5a4e57675f2b70ddf73c3dc5cf44fc2
-- 
2.25.1


