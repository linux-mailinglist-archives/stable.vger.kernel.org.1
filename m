Return-Path: <stable+bounces-225552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA/NAXsTuGk7YwEAu9opvQ
	(envelope-from <stable+bounces-225552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:28:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE2329B595
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1EEB300B560
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470B927F75C;
	Mon, 16 Mar 2026 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kNrkNJyo";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="KpGg4ZVG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC062798ED;
	Mon, 16 Mar 2026 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671274; cv=fail; b=WPpg4zOS6y3rpMG/SYUbe8W8PV/4qn2zsu8SVeYCwfLvDk3gkiM4++5hupio/rWIf5k8C1Qk05EUyf2GCPQ09UCMj0/01TPJHiqcHJZxPncWup/RBueri5IxyFgI+QaVS5c5PZBsm1oyFRXhFDncQzlAKeGzIv4JhffXLHQp8+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671274; c=relaxed/simple;
	bh=Qop1cZfrJJ64OCj5buDNpeG4xn5VUpGZwZdr0lmMbFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAgMWweaVyUesj00MFoZ4/g90AJMJye6KRxM1Kt8in1idQvm8Qm8K1HY0sAzPNAXn9OW+CZqU2vbpI5lmG12dtdXXJP+faJMGpghKas12lOWFBujV9vChcXIZkqVubjY0vWeuTX2CHjy6tphEdcfx7cTmvwpSRJkqIu6WTufUko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kNrkNJyo; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=KpGg4ZVG; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GDepNb3504445;
	Mon, 16 Mar 2026 09:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=MYqTvxU4nqlJfjoDjj
	lWpqyH4WouZ6OYEl20O+UbndY=; b=kNrkNJyoZ6lMb3dH+8s1p5ZjhvZO3KJHJA
	7EjAhzC665pejq77nCAfyhGIeS9TkBDRA+vIokZKkrSKkZXKBFx9FnUN2sT/R0QW
	pj05tMWTpM9CjxapK4tiPQmKwTRX+BPpeqzpEKuzUhXKvJufb7HeueycGJwxGYzU
	YvJf4fw10I1HPr3ospz6GRQGt1iNwTFzCDG1vOo0ElrI7a3q3PQMa/N3rp6Ci1em
	TVijLdQdq5uKl20DYc3sTA0LSX+d18JZ4mAV5aZoEIEcP9duWMFr6MIfacgAbJW5
	Ron6KW3KUDqrEGpRLz+KmuWq5McnnB1MAQwOiRigU5oh7nGLNw5g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022134.outbound.protection.outlook.com [40.93.195.134])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4cw43f24pj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 09:27:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzJLMDjciGXxEqsgI2Wrp9hh6kv42ePf3OGy/GyMgu/47Hqoukd3nV7Wqd3e/RoF0Oxz0I/g3p8ye2DB70TlpFNWdmTPVFJZQwjncXd+aI7autJrtQdK4hJvDZFG2LAFSYcJVDpy9xJ6jb7NE0j+VXQme+hf+I+7hzpsiKKkdJLj3j471WW/hrzjuIFXd6f4P9fBFdq6kRgoI4Qcs9IQ6+w9xRDWcBvfXoAEnUvVibSfnoJbzRhFuxn0N8A0bgNVB/6C/EaK6aUOgCV61vGwwFKpKdLz64cC2RjnNfrW7utopO5HUtK2eY11kL1Qpt/alkrWM4GEXPW0j6/C4ZUISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYqTvxU4nqlJfjoDjjlWpqyH4WouZ6OYEl20O+UbndY=;
 b=pyuCM+ExnIwROZRY1pB6qnZ8Qr66UeryDtVARzYB+D/IY8iCVLTgMnJGNT9ewg9+XogHHV+b1BxU7U5H3ICToGo3brHjUpAIxg5b11TrcLT4HA31yM/CnrSWim+pdmGPtuS3B3AW9aDg7XkGXOc7OFkCkYNzba4UOFCiyvw5A1jEOtrYyCV4kIBW82tW5NmxHu53vQEgs82vVRm4P4jSkBqumhXEFU/rTOVEl8mCqNYIiUDQ3SyMrqnSKkYz4Six3ybecWCVqdfU64XEYWMFxpbhul7v/pNxNtd03ySplP5fR/eRVmSf587oZJGDFA1TC7DNPN+cPnApMhwjvzcZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYqTvxU4nqlJfjoDjjlWpqyH4WouZ6OYEl20O+UbndY=;
 b=KpGg4ZVGotM0lOWack00PHdo/Rh+d/a21U4wpmjy8N0kgM6PzuiJcrr8YY7DtgZ9sZtW4iUlZaDdcUmJTEJ0ZuPn+klRf+2QguzuMYWMyL5Zv3PN01GgiBEKWfqUXVwgUkqgQ0JfoTUyaj0gokkTZzyj9sylv4m4fb9RdTbwjoI=
Received: from BL1PR13CA0266.namprd13.prod.outlook.com (2603:10b6:208:2ba::31)
 by LV2PR19MB5983.namprd19.prod.outlook.com (2603:10b6:408:14f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 14:27:43 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::5f) by BL1PR13CA0266.outlook.office365.com
 (2603:10b6:208:2ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 14:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Mon, 16 Mar 2026 14:27:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4D7DE406540;
	Mon, 16 Mar 2026 14:27:40 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 2E48D820247;
	Mon, 16 Mar 2026 14:27:40 +0000 (UTC)
Date: Mon, 16 Mar 2026 14:27:39 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs42l43-jack: Remove manual pm_runtime  get/put
 from tip_sense_work
Message-ID: <abgTWxI1Q9M1o+ka@opensource.cirrus.com>
References: <20260316124924.31047-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316124924.31047-1-peter.ujfalusi@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|LV2PR19MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 334c6055-98c3-42e4-3a13-08de83682e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700016|376014|56012099003|22082099003|18002099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	XB2J5jFwWotMz4np5YO0HyDxytjImxwTSIrciZUIl19Pj7pZ0dzYEoT576sjEv/CZOPuWrSi8ExKlEitRRumChQyROm0TyE61fNLFElq750/Rt8ndByevT5uKaQC9NQUMFTyU4tQ3TnYL0aFE8Nmy1BCEo6ZzQPk6ZTzTCBl7Yh58nkaHMWLjkBKnpVESz6zMmYiuR4tP+Sigq3hYwUasEF3V+sHf6hbcCKlDVus++K8kuNelbP28jX3ocIXPpyPmUvU94Lb+m7zO2AK/opvRSKj5XrTKXkwvdQpWs9/rmZxkM6jHcYEL8fG0qXoeaelPaE3lGkfk/4a65AJ+bT9KQIML/Tgu9Tj4J5UjmS15msXGXFBaLqaFdGmG7GxrWM/WtSmO2ii5pqtAalGwud1VgZyFyXY4iMz+GSiy++havTWGymPihdZ2sWZa/m9xEv9nzjnE++5bx9QjRPQqKzNRyfP+l6yZTF7g+xL6kUYQb7Zl0BuRs2I+4Wm4BKs+7LZat7IXGJfmtjJz9cCV6v4vm6pv5W5cO0r7s7IMdfKMRghp+BvrcXwJmTySIvrcQoZpnkhLzyw2Hr6+0ihAiH+0Xk3MQU1aGlDo3BDW8M6TYRm5m3m91amz1EemX5H/j1akgoTF14GIC59V1emIKVetxOlfqbdlJI1su5Q3yjKgB7ow3ZT3hdmoKV03KsoKBNQ8B6E7Bwt6pt8qZIvKz72yvv3V4kvQ80ROZ7vjDsEuY1V+x2Az9WNo63x30UHEwb2VGr7aEBy0gPK2gFi0iF16w==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ku2Ni9oB8s3QZ1R5XMByn7Ovi+qkmCvOFCU1QBVP3GscunVdzr5SjrVUvJLcG6oAziQ6y5QrmbAXVEh9fQlmkehgot/wgTCvhecGpk6dXXUGGF863fWeQvoLhaYaEronW/JQZwGWbsnkrY+tDDdvdNT5JPzbkPq96s2rPbJfC7ILkOCp9rzDLNl556o1SNHZHxP30yn1pzyfdt+c6dEDnuFPFx+4W2UXxKJPUfyE8END/YLQUYh5NRPLpBh9laNO98c4ZjfdmQoy1k2H9/M9D2gKc0z75I6i0d217mQqFqhitrzwRELwG2cYxsGMan18k4YE2Inm5WuURHn2M7oFCbnTVio560p9mr2NMEhXD/bDN7H82ige7T3yWi52sA2ObeJW7TvQiidjP4WTzXVzdJ3e1ZAU7gAFzE8OF+aJK5qywBgF3W4J0PcOMBPWMXA7
X-Exchange-RoutingPolicyChecked:
	uePYJdY05TQxzs7h1fUkjXGz2/IdECA0/+fxRax8AyffGkNLSIHtSHbNYEhzwCH1Nj5z/J5+0boMntCus94UADsEX02N9MUTk6mZUfJxvruJX4cyTzmN73FAKh3ZpbkMiSEQaq+s4pJEQEXuWELyBTbGqSc8h87azwOGq/Kay8brrY2G9PwnuKcqf8U5/qlLy7A7HP79SmkiSWf3UTnDAHOSv5PhTK65CYxYT41OCBLW3iMxtMHFd7by5dPd3Q7tD+SqGXeKVsouxeG1wXanWkCNiVa26X+xlsOj8e1z9EmYfbST2mTtl9PtS1piTd3VOE/XkxiwNuTTQK7ZbXZKzQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:27:41.2098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334c6055-98c3-42e4-3a13-08de83682e90
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5983
X-Authority-Analysis: v=2.4 cv=YqQChoYX c=1 sm=1 tr=0 ts=69b81363 cx=c_pps
 a=rUfGOIOvJ/MBLZtbMVSs1A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=5m6mY_qYQpFCyjtjPIIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwOCBTYWx0ZWRfXyh/EUgGKmFKR
 oCjYCqpBpjgAV0X+/jW6z0EucT4AGuivpNmwqtwNL4OqvA3MGKHQSwb2WTX3mn4Qh9oY510dtC2
 lna02JzAzpTX5Vv1NlGEI6sQVejYclgu6ZNZ4ofB9sCJ6Htf98FsXivdXSCDDCDS5vmEQvpcXlV
 pNHwrtT9ZgvdkmGnzaVnslQ+2PQqtuLHR26qWgcJmnuxpCb3l65Uov74B2mZxtS0ac3JvaUUohp
 aeQidsv8fdxs8uuPBEnKlxoxVG75yXJkCsgOZ3X5VavUh13DtFmeurC/Hb7D6ZPwCcuWmknZodf
 TsWGj0JQSlA9HacfOif6TfV/6oFWIjarfEGwoDl26JOKIa5LXDUynfuDLWaK9bH2YVRxpL3lw+b
 Y2nE1aoXGIimJQEADnECKoG5WrPZb8Jq189xkqrj6g7VNj0F7OBW9GoligKglmltqUCmGVmU9mJ
 PVX5T3A8BcggaGWSZZA==
X-Proofpoint-ORIG-GUID: y691SNA3lhtUFLaChzr_FlR-U3ULA-cc
X-Proofpoint-GUID: y691SNA3lhtUFLaChzr_FlR-U3ULA-cc
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:+];
	TAGGED_FROM(0.00)[bounces-225552-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4DE2329B595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 02:49:24PM +0200, Peter Ujfalusi wrote:
> When a jack is inserted the forced pm_runtime_get() will keep the codec,
> soundwire bus and it's parent active as long as the jack is connected.
> This makes for example the DSP and firmware booted up on Intel platforms.
> 
> If the module is removed while the jack is connected we will also have
> unbalanced runtime PM state.
> 
> Without the manual get/put, the button detection still works correctly and
> the system can reach lower power state while the jack is connected like
> in the case when there is no jack connected.
> 
> Fixes: fc918cbe874e ("ASoC: cs42l43: Add support for the cs42l43")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
>  sound/soc/codecs/cs42l43-jack.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
> index 3e04e6897b14..d90a13a55845 100644
> --- a/sound/soc/codecs/cs42l43-jack.c
> +++ b/sound/soc/codecs/cs42l43-jack.c
> @@ -756,10 +756,8 @@ void cs42l43_tip_sense_work(struct work_struct *work)
>  	ring = (sts >> CS42L43_RINGSENSE_PLUG_DB_STS_SHIFT) & CS42L43_JACK_PRESENT;
>  
>  	if (tip == CS42L43_JACK_PRESENT) {
> -		if (cs42l43->sdw && !priv->jack_present) {
> +		if (cs42l43->sdw && !priv->jack_present)
>  			priv->jack_present = true;
> -			pm_runtime_get(priv->dev);
> -		}

Hmm... yes, I have this feeling this was in here for a reason I
should probably have left a comment here. I somewhat agree it
looks a bit mad with fresh eyes. The variable is also only used
for tracking this pm_runtime_get so you can drop the jack_present
variable from the struct as well, if we take the patch forward.

Best I can come up with was it was some interaction with the
Intel host's doing a bus reset when coming out of clock stop. I
think that might have caused something important to get
clobbered in some situations. But anyway will do some testing and
thinking and report back.

Thanks,
Charles

