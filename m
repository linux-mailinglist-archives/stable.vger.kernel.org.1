Return-Path: <stable+bounces-219729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG9SMZqGn2mmcgQAu9opvQ
	(envelope-from <stable+bounces-219729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 00:32:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EC819EDAC
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 00:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3BFB3007889
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22332F39B9;
	Wed, 25 Feb 2026 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="uR3bstyq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="Kb1FjjJo"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1FA3815F5;
	Wed, 25 Feb 2026 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772062356; cv=fail; b=dfbqAZ3VO9Lwnz7jl1e/SFdEr1gA7spxYaYE8nDmUrmPIav8Pe6kyGBw5iACJr0xUQXVpiMI1Scjx6GF9PtE6WXI3HgiB+G9/sKqu2rLM33icl8a7Bc0I5UaDV0MSxMc0/Gl4n2X6nCAId4lIE3/IAQEDK53ya0koa2hVkRGhzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772062356; c=relaxed/simple;
	bh=NeQsCzPslFErXSe3LK6s4KgbxoFc2tJi5Ogi859dgO8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IVk6gXsF5I39CUBHT3Is3+Dyn5q7pbP7h36XeDnCl0xzCe5TFVkmQxM2v3WQajjbQPu0dUw0L9eVmQLOBURGp3OmIs9+dHsw8n0Div4fGldLdkoA/aaiIx2CALbNJCyu/58GkgZ8WSWijAuT8pi9Z4c7s64uZPkCiYheLfDHisY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=uR3bstyq; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=Kb1FjjJo reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108156.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PMpoo1547052;
	Wed, 25 Feb 2026 15:21:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS1017; bh=LnIkQ66d5zJpcvz/dkgork3q
	0yIbCa1FAciJB97/VWk=; b=uR3bstyqAdmw6qjlvJynO/tKlXq4WIPqPPRbohiO
	8T4zlqF5SupeRUwSHS298uBZ20cXo7+d2CoMdQJauSxG+gBxYvoMXiC5HS1sD6Tg
	dhZgNmWGdO4XbN6QvYrXnOKiSqg+awczN52sgJWtPLn3KtzisfJoKGk2BlQsgP1S
	hrMtY9O3/oaA4BtFiVA8SpaM8nm04rdFstXN5LiTEBk2UUJtMWkGZ0xQ3EdXPlc5
	8K+auUUigEpT08WIPV6G/bALsyrM9lEZJFMfIS2xUYQxJELVS/0T+bz4h6w9Bsgb
	KPESkSL/R/Y3m+s5zvKfjmJ0kBx6nQyIm4AogSiaw9dUow==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 4chvgsmb2k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 15:21:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxeyS431g3DSToO1ifadaDiaLllPbhFqTAtFaO+RNHasL7cvNfYf3u4TP/13VYRdBOkdhru7T458IDFgFQAHwEI3fKCz1RO8nZbQ5BhObkenFha6cGkkD/M75RK7pN2R41KCv6X/el/581fqeHESUvTQ/T9QEjL50vLIuBvf2abyumgXpnQjlw55Sp9E7opZCK1YRHZffC16BZnBktvTixFnfZfvi7mMINmtXU8naTdFq88pypHSdxF5t+EHHJ9ejtZvu1mF6L06JnWRrIf9My1ixKAirjWU3qqGp1RuC6Xqs1LS0OPWBWliHQmYoNZMzaSo0abtfjaHzQtkNlt7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnIkQ66d5zJpcvz/dkgork3q0yIbCa1FAciJB97/VWk=;
 b=DApZuQRQf7Rw8fvS7G29n0zgL5IeKVbQ4UMe4nKmOJmacjqMTMRb0I0yd9C1Ght0WFnLNoUO5koiz2Di/y5YNylzRqm6C1NUzvLwBrjQ7UFSPZk0wetJ4dMqaZ5tuHjQhSIjUllZvThLx+8XeNpRuhELpBmSvE+2OqTnlibiVVzqa5ygXKhs4MtdB9Wg2nsIvoLMBEYTZmjZ6djwdEZJR+AGdhDo10J7dQrbgfjgtYYmR3DyU7e3/oUaEbhbkFWeF6+t6wTJ67mh89jdQP2iDPkPjb7iHJO38I/0MF3OczuzVRWvwbuDQzdD1SuLLY9QQsGgBZe75k2hdWc6yatP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 66.129.239.14) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=juniper.net;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=juniper.net; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnIkQ66d5zJpcvz/dkgork3q0yIbCa1FAciJB97/VWk=;
 b=Kb1FjjJol3mvYh1n3sm05eF/pF/oB9fdNAFOLKCvtdCC/awGxLL+cNPGvJMzfZA+Kkvuz/Av55npkuebmEo+FNqYj71tUFO6Na7pxRZ5+MJZ09qpjF9cUCkgQFuDN9TNTGTrzFDeD5mYDi2dJjHm7hBmR0atPciBCu3OjFB68BI=
Received: from BL1PR13CA0270.namprd13.prod.outlook.com (2603:10b6:208:2ba::35)
 by LV3PR05MB10571.namprd05.prod.outlook.com (2603:10b6:408:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 23:21:16 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::ac) by BL1PR13CA0270.outlook.office365.com
 (2603:10b6:208:2ba::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 23:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 66.129.239.14)
 smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: Fail (protection.outlook.com: domain of juniper.net does not
 designate 66.129.239.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=66.129.239.14; helo=p-exchfe-eqx-04.jnpr.net;
Received: from p-exchfe-eqx-04.jnpr.net (66.129.239.14) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 23:21:15 +0000
Received: from p-exchbe-eqx-04.jnpr.net (10.104.9.87) by
 p-exchfe-eqx-04.jnpr.net (10.104.9.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Feb 2026 15:21:13 -0800
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-04.jnpr.net (10.104.9.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Feb 2026 15:21:13 -0800
Received: from buildcontainer.juniper.net (qnc-bas-srv058b.juniper.net [10.46.0.148])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 61PNLCFT021463;
	Wed, 25 Feb 2026 15:21:12 -0800
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC: Brian Mak <makb@juniper.net>, <stable@vger.kernel.org>
Subject: [PATCH] mfd: core: Preserve OF node when ACPI handle is present
Date: Wed, 25 Feb 2026 15:21:05 -0800
Message-ID: <20260225232105.454931-1-makb@juniper.net>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|LV3PR05MB10571:EE_
X-MS-Office365-Filtering-Correlation-Id: efefee54-524e-4eb1-90ba-08de74c492a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	gfllpCvODNYjdsxUGUTpTet05WYhT3EW0ejVigg7GJ2J/OLml6R+nB/PIkmOU3Kj/+0/5kjlP/fOQhcJCx4SBhBSPJyAwiGv8Dkej3jVn62gNsrJS1joQaS7gv8CmCKWnJ8DeaAPpAR+ER7IeqAxCHe7BRKbmudoHIZy9qsms1bEbPG7/lTkw12jtQINRIcTx9uHWJEObiP9vAJ4e40uChUrQDyt6qT4QpUTwGJqoPXlnRjmBOPC/r42S655OT3yS0rNdiWHqMpXl36TUqJHFph9KlZLtvj3qdiddEmNAxc8XDhB8NzE+AQ9Az/AjV3kzFdYD6v9tLBG3LxixAYeJTQZ5SbtiRlSEAzLiQE9Jy27lM0D6uKCxO2MRc5jzvur0w9yECamsxc4T4zJWmOmGBASL7zTG2W7MfthKr8g4unh7trP7xelFwZ1P2HVI0ezlIvR1qZX7XQwpoUSglFckHEXVTeqKdxkTw7NXia3ARqeNsG9oWtgQHIaZyyX78HrsWJvf14qnQKX8FHy+aODRm+/1eAqR1h4f+np1D2UR0jxtZLusXQzx8qCyWPnYCk9aPCfquE6ZVrFHWL2r4LYnnb3zTXDQbt07G2l+9qLB9zwYFaippOudeXc4jC+2Gf86kdh0fp/vQTK0fj8bdg8fNq1a/W87o3Id1/q1Cbb1ULIq+Tm7Dv2jQQL5khSwgmXWTYrpj2Be6UddeMcy3BDGJ53Pa/Wn6jsDwyPXJx05OTTpYn+TdkFePH06YMKR2+7Zhmlfvnje+YFWtkcnPyL3KM3CAeKzGILiK6nRbaqz2xNrcjzKSqc5TskGeXISshi
X-Forefront-Antispam-Report:
	CIP:66.129.239.14;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:p-exchfe-eqx-04.jnpr.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Ip79qFhho7jW7RVM5VGH5D7cEiTrf8pzzTovsunFKclheeal9xAUBfKremyZI2EtFGJyJFnmbqu1/hokKOzw3Wzkghwf2Xk8K2DOM20yHka2nXbXH8KgkVvBIbrIFwdYJICzg3l1cogv556DQzDntmZBHHcJ8gp+eK7E5ZMBwmdWmq8GdenO+FUoKh/Widl2K3m6HEscj/nPl/EJ/pRQizcgDX2JY7VYznhdikARqG+HkY2eq4JKMvRf+JMVEHFH60AYAVn3r8H0oY2eGVZBF5aIxHhgh2T8DNc0rlI4V9kdgO7fFXfjmnlQyT0cCSm3mnlbW2HvZpZl7DN//d2SiRwo2YDtQG05za4h3HYm5yTle/PtTZWZfTyTH206l+tVtvqvLTIfJVh5PagYq1Fre46jaZ4vtyxUptLLg32M9/anMD6Fbjrr7Fo7S9dXaCH
X-Exchange-RoutingPolicyChecked:
	eJ1/MDIVsVvvEDx/PzaLY6AU4CAUB9iXl/MTafiAlb0iYUJsgreGOAKv8We+gqpF2mBQppvRLp8cJNS5LbkMXIBReHGSYN+WpTUDK4RhfWe+0uOzVht9S6LZ/YWOGYWq0W1hgNsah6wyQKsyhZ5C1tqImVoEm6Pzp+cxBvFf37211+oPxmMd02smFt3om0R+XFyVOvfv5t838v1HkBDOjNrx2pWP/FpRl2qHeJr1mwjxQ1GBSPJoGo99xsiGKnxlETkI04V24gu3afN+x/05A2H0Vma/+fHTffcBzZ+mrtwATVwdHOeVMj7V+AG+GUKJq7RC0mvMgT5ksTO4QssPPQ==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 23:21:15.4594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efefee54-524e-4eb1-90ba-08de74c492a9
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.14];Helo=[p-exchfe-eqx-04.jnpr.net]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR05MB10571
X-Proofpoint-GUID: S2r4M9W_NwZf51_OEgCjTnQQRupL-o3Y
X-Authority-Analysis: v=2.4 cv=cPLtc1eN c=1 sm=1 tr=0 ts=699f83f1 cx=c_pps
 a=KKuy1w1gR68tVOnyqteslA==:117 a=f/rncuQqEjTEF/G1odkJ9w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=HzLeVaNsDn8A:10 a=s63m1ICgrNkA:10
 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7vL3O5uBSuztJ3xaqtyr:22
 a=8vlvHv4eveIrSVLlmQuz:22 a=VwQbUJbxAAAA:8 a=OUXY8nFuAAAA:8
 a=v9wZ2LzyxJIfN6L1Eb8A:9 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: S2r4M9W_NwZf51_OEgCjTnQQRupL-o3Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIyMyBTYWx0ZWRfX2cFqc46nxojz
 8XyOdX2ES5OkDVwjLzVezv7OTstcvBHpqJ5L5+jr3QZDoXh7eP462xiDqoT21TASi0BgV17oO63
 ZuetV1FA3F/6wBAgFIE+zu1DCTORVP1cR4nWw0oYaXxO+VbzIwajO38z3hX4BFCUz7qYpscXQ1Q
 r+I4H0oj7MwyfMjmmphPWyG7z0wyVszsHtJ2drO9fq9KBi6k08IxkDqDto4EuzWbNEAwG3wmrIS
 7FIobtu4kezi782R93hNW6IlRU9hDvWj1ECME/Fx0CJPwtc8mkEGIyCPm8qTz0T0bgMQjsXN4lP
 8GLaPi9ABcixX8ZAhwI2rjcCWSNGaKQcryeJTUUGTqCXGvM4jVIq83PO8fdz7TbLwvFbAv9605+
 P2GnGlx1KJt6oElvFjnqjFxzUyWGmup3yw3dCUbUUE+qAl/bGj+qNmU3b0h0NVuehNM+3J3ZtU4
 bn50uSjm2/ECnQX+xrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250223
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[juniper.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[juniper.net:s=PPS1017];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_MIXED(0.00)[];
	TAGGED_FROM(0.00)[bounces-219729-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_PERMFAIL(0.00)[juniper.net:s=selector1];
	DKIM_TRACE(0.00)[juniper.net:+,juniper.net:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[makb@juniper.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 66EC819EDAC
X-Rspamd-Action: no action

Switch device_set_node back to ACPI_COMPANION_SET, so that the ACPI
fwnode does not overwrite the of_node with NULL.

This allows MFD children with both OF nodes and ACPI handles to have OF
nodes again.

Fixes: 51e3b257099d ("mfd: core: Make use of device_set_node()")
Cc: stable@vger.kernel.org
Signed-off-by: Brian Mak <makb@juniper.net>
---
 drivers/mfd/mfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 6be58eb5a746..3c8b06d52d19 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -88,7 +88,7 @@ static void mfd_acpi_add_device(const struct mfd_cell *cell,
 		}
 	}
 
-	device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
+	ACPI_COMPANION_SET(&pdev->dev, adev ?: parent);
 }
 #else
 static inline void mfd_acpi_add_device(const struct mfd_cell *cell,

base-commit: d9d32e5bd5a4e57675f2b70ddf73c3dc5cf44fc2
-- 
2.25.1


