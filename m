Return-Path: <stable+bounces-224737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LjUM4mrsWmzEQAAu9opvQ
	(envelope-from <stable+bounces-224737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:51:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5050D26841A
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 616D53038F3E
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F843CBE8A;
	Wed, 11 Mar 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="B29b6h79";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Vr4mDvuJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F623E5EED;
	Wed, 11 Mar 2026 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251445; cv=fail; b=b/Hmzwen+i87p9QlEkSkysSyl6W5Qr1Zyky3nH+F/BWZ/4DF6ItC5j3e3Pie7GWoTOlvUoBobE4eJWIrXni9wdawRlgVbV3A1+MpchUp//UTGHk1nrwEWm7+jwa9NFiOs+vypY3JRwp6h2lXF+b1k33PZmVWAGIZOpcy78IXWUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251445; c=relaxed/simple;
	bh=NFHQNvFsF6tWP1pKQhjumQWMQrYQixKr5x18+X9j4vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJpo7+PeUGo91v3vnV9WRC7xVf63tCHw/zpdbWxYkVzQE0kM06hM6BdOVJxuaXEtCvxvP1oId90vFcDtFA86ZLFs3VbdijZDcMeky/jrsvfE7UDU+/1z+OeogF/WND7pAiLNlIhSgztKMtp2DxD8jRhfoleJq3jU9L3imM9G7mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=B29b6h79; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Vr4mDvuJ; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B5MABV3360121;
	Wed, 11 Mar 2026 12:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=NFHQNvFsF6tWP1pKQh
	jumQWMQrYQixKr5x18+X9j4vM=; b=B29b6h79p3ynjVUiNIrK2UmGpEVXeIcW4Y
	3gKIpRx3j2x9pG3tSyWNBCrEdusK3ubhP7rMuwTIAIQjBZ9iAH50yyOqwzAu02YO
	PHAiVw5i1i5ht6SWFZ84zM4SIxz23H7o7R1Kjtfcq6Hd7G6jiyu7e6yMe+op1EZb
	PQ8GdZrefZex6jLE2Mw4lFNPVs1iNuAvfjnLg1S0j4QDZ81hmItjerHZeL48jOJe
	pi+X2FphzFSOTAQ+Vnhj8ksztzk6FPulJaw32INU7s5dDdfF6h+M9oFY4O/juWI+
	VkcBsqjDJjlbFIHAMzxkCmAHzVwMDcgsHDRIFyqpESxqNOL29pNg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021075.outbound.protection.outlook.com [40.93.194.75])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4crhapdqtj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 12:50:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynTagRxRcCGGHeFjgbAefXFbfQxQMvpoP6ABki0kZ0lupnf7wuEDEvoKRnwFS1ez8nzXKVSh/AmHlNxhn+h3XqHCV62JCOU5W7m03iRqZkEOkIhDp9X1S9ifVIctbc+pYYBqaq363KnSy8mdH5T+va2Zb/tB3M7lC0sXL3S+lX4MpqmLt30vgKeyGna9FyIyV+xdyRDDBjUYCrG+uZMTmAyYCUZ2quXQmokw5hkgIrZSI5mFWPUgNuNEia+Y1Y2Rf0Vhv3eg+PkHywwNlOyEOG/dYiqA9sku5cxltjv3wFnqbiMPzy1jyhZe61uVkfUth+0Z6W3Xdavl9VM6sPsl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFHQNvFsF6tWP1pKQhjumQWMQrYQixKr5x18+X9j4vM=;
 b=iOhH1sn1gREti/gA90vVppjBHjE3AN+oInvPB0GgBlYuopjUypLn79GKSlKl2j7ISKBD11tF5C8P05uHQBXtdWk7C7jTUFNWM40EZ9SjV1kOsrJgvy+QaFI65QPwNJMpvoDQjZVFnScrqAy1MtTA0DmiJxOOlWiFZe03tKMOaJeuEsB67dKlm5luGTXfjuOiiBcm2rH1+HfbzXXinel15+an3/fYKWpGWu8/Lldw1DqpkGgVR0ZbMfrSIU5VeZiDdkcXybbRx2EiQq7V0HLA7M9rmhC1wEdPo9t9BDCzik7tu55Vlc+1sE0aoK2VZlqpa2LiFJFY3cuFy+CG8VvnQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFHQNvFsF6tWP1pKQhjumQWMQrYQixKr5x18+X9j4vM=;
 b=Vr4mDvuJkFYP2fIcBaZ44Itk5ljL7gunlmK3M5KcTdlEtUoTsnLFy61E2+btbrAbdedYggg1y8VIl1DnfB15YBM9C23S98JZvxRHpUUTr6i2kAqzo9fR6yIXvhD27T6N35L6XcyaEq6Yk9m4aU7hf9vKa7Xv8jCTLjugTCuMYqU=
Received: from BLAPR03CA0161.namprd03.prod.outlook.com (2603:10b6:208:32f::8)
 by PH0PR19MB7602.namprd19.prod.outlook.com (2603:10b6:510:28d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Wed, 11 Mar
 2026 17:50:23 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::db) by BLAPR03CA0161.outlook.office365.com
 (2603:10b6:208:32f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 17:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 17:50:22 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 255DB406542;
	Wed, 11 Mar 2026 17:50:21 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0CEFC82024B;
	Wed, 11 Mar 2026 17:50:21 +0000 (UTC)
Date: Wed, 11 Mar 2026 17:50:19 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: "Tsai, Gaggery" <gaggery.tsai@intel.com>
Cc: Mark Brown <broonie@kernel.org>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "mstrozek@opensource.cirrus.com" <mstrozek@opensource.cirrus.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ASoC: SDCA: Fix NULL pointer dereference in
 sdca_jack_process()
Message-ID: <abGrW9TA33KMlwmO@opensource.cirrus.com>
References: <20260310183829.2907805-1-gaggery.tsai@intel.com>
 <02cd505e-4635-4d81-8c70-166bbfeaef85@sirena.org.uk>
 <DS0PR11MB65421FE197235CDBEF721D848647A@DS0PR11MB6542.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB65421FE197235CDBEF721D848647A@DS0PR11MB6542.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH0PR19MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0702c9-6537-4b89-23d7-08de7f96aaee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700016|54012099003|22082099003|16102099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1Wp2U7eojIAcOj6eH+DsaKNEb8zXbrTcp0GmyiwgeIEZs/r7I1N7EtuakCVyTbBJTOvP2kqXrejgWTx/+V3qYcV6fYS0s2fIimn+vvwyB4xlC/Z2qDMCxgSGl2Dx3ODl/k7H7e7T0mI+c6PMnip0Ye88vhiNpzo7tdjS56KMt1IWXx6F8LUfhUJhY9Tnbw6KN7bk7PuGfgGANqmhjveFrW4Bceij0Vlys794flbiH6u6zg62EdS/2Z/TzapWUGgOtZXTBjXLRML4iY93WJAA+zu4DlrhgoGnZ9YvqgaebK5UksdDjWIn8W0f1ch7QWjMnyurxrws7GUGxcfSf6Lx4owZP7jchTuKo41r7D6pgmJHYRo6X3LIudRJjYJtkftc5IvPFWrI7MTaVAyfioWubN+1mheaISvEVZaCqw4pZjorHlNDiatC1mjwMX5v+V3xRZDSX9G+GMRO4Xx5oWEEClfKsCoxKx1saz0K3qzqpV8nc1yaDaPyVr/ID/EOKYheUEvsNBEkZRsnoytjwiGyE7LlSekVwMKF6jgI4i2Mzlr0WZndsmLneSxEMn1n6IzBN6V6/7xIY6A4F8kPtQa/GilU70xHYHLzwvm7+DHi+0+oi51ix+fuOE5uumi4cnm4PNRY7NrIPeGDyVfhwlBpjrIcOj8BsFLzPceo9gsAeiZa7qBA6PtIjoY5oYt+OEaXzVNIUt2EYl0lSUuUvZu6PHXw2DZ70NXBmPQM1DVsZSNF5gg1mNC9MHhoyeks3C2UREwayKIPaaL39g7LXdksbQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700016)(54012099003)(22082099003)(16102099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PExlPE9N76Fp+HJhf8qx9YpiutQGWYrUyAznV0B4H2adF424VtC6Ym3LU+tmSnGgS6GMKQiaQeEVwq40j8ZGXRNWpQh/LQsgRouvxPxBWx9myAwzJ7bwIbbRF1P027kLvgnatR2Jahs5qI9CfhVqE6FpGxRnphXn3Pp4dQf0lajz3FhWispEn7OFffmhlIxBIxadSGtNYXSrW19JRpTqe1mXqYShJJcLhcEavuzZpMMK7IjoP4lhb1ABzM8iaKiyVIM3MRGpG4FFmREVBCvEL3ZsFGFNOOR/e293h0IZGyor9kchLsxXvZ34W3rCoEoLJ1R/nFtF/WGrATHvqy9EGqXPSLeDmBfGsi3TekI7MP6jVVxFfb+QT4oNrjV0v1G6pfNVz4bJK8cHTyARo4j7lrswE8UXoVRc3Q9uE/YXRlKnpCIF1AsHyKf7s6j5F8Bm
X-Exchange-RoutingPolicyChecked:
	r5/t5mFN3MEXz/k8s7/OH+qK7Hobvjywuqk+50mpNrdqQMoyMHLXKQVEA5IbxLQeVilW65QB5/b78/rGlMJZBxE4TroyOi1Wc4OAHohO2ATBt+wSBpMQARE2Drs5cqablUI3fdTT9GyiOEHl9uGuznsFgDBtrf73yponaYfSG5yzIKpcK1HJyWygPN+Onkf2MwUpRNEX2ivD+eM/TH5xDGU+UvaJAAGeymJEmm+w3442JY9jxOigMskRv8RbUmy7Cn5xoj5RTsO2LEzZV5bd+CiCMLAUn0M4JCnwGGcprxoph8fkHhukc+xlj2bjl1C7iA9tO8kj0NGrRvye6Dd3Ww==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:50:22.0691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0702c9-6537-4b89-23d7-08de7f96aaee
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB7602
X-Proofpoint-ORIG-GUID: -qVtmKGfMSZrvNLzEczoRgxMs99OY7KR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE1MCBTYWx0ZWRfX3qG8LrQR45yi
 c+q3RG3Hwd8Cs1PShNQ16Z2S9DUWscTu71vEve0yOctGHo5lyee2g8YHpV62b826Mk/uMJrB9zN
 YX9B+7QptzTqwCrwc0cYmJiP8JSDQRf/8R6XoPvDQZkbn1zBJKhj07JaVi78xTXWLCAX5Ya3nxg
 RGjvFtaegaSBrqY0eDYDAiML9k12mms07WsoF854SomVOpFcfRrT1tBxK1Cu1i1eblIDGE+42r2
 xQ+OB0JlKuVDaTmw4sh3aGsEcH5F3jkt6xV6n3DRxSzIw7wQQxp0O98mqJLMRxoy9ArYPR3nljh
 MMwkAUu3JYKIhJgZ/6hxlpNspVVbNnyPQb0zMP4ku6PswDk9n+T7SJ9P/FDu0UFe6iUDJwXHsbZ
 o+8gbGauw9TQUq9S+7TqZJgB8jBACka0jdNK9T7VyKL8RiGWhEmGzlKRoE61hREWp+CVky7QC3L
 v4dJDWwOTWeWwiu1N7g==
X-Proofpoint-GUID: -qVtmKGfMSZrvNLzEczoRgxMs99OY7KR
X-Authority-Analysis: v=2.4 cv=EbbFgfmC c=1 sm=1 tr=0 ts=69b1ab62 cx=c_pps
 a=93H4cXmoI5KDoTQtorJXRw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=9Isqct4000FjFLGHclsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Reason: safe
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cirrus.com,reject];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019,cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224737-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cirrus4.onmicrosoft.com:dkim,opensource.cirrus.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
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
X-Rspamd-Queue-Id: 5050D26841A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 05:45:07PM +0000, Tsai, Gaggery wrote:
> Thanks for the review. You're right, I'll send a v2 that also
> disables the SDCA IRQs in the component remove path to close
> the TOCTOU window, keeping the NULL guard as defense-in-depth.

Yeah I think disabling the IRQs would be the better fix.

Thanks,
Charles

