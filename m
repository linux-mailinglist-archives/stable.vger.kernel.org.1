Return-Path: <stable+bounces-100502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EB79EC0DE
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 01:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F00188935C
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C66522339;
	Wed, 11 Dec 2024 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ckJWJkeX";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="M9IGwKjo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MxmZzAiL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE311CD0C;
	Wed, 11 Dec 2024 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733877239; cv=fail; b=qSaH0uzp9ZfkzbkWLQXxOweqnuJwUoQmOplANa5giK59nfQd6tKcH3td/RkaZeguY79Fsg4LnXmN1VX0pt0VSEEFPnDFMXeVSPdeBTAdnMRlMg72s/KKSMXwgv4IK4c1iL+Zturx9Dpx5MArpXU7oiI+0XmXXq/QlKS6noek1oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733877239; c=relaxed/simple;
	bh=2F1fa01FlzGNvP4SW9/uGXQYuTWkljd+yEQ/qB5QrVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z08x/ZDOPqSS/2Jvi1kVuE5wLA3D1gazx5VkAR7At4S3UXf6H6rX7QlpnTGkZrzarCfcrnTx8DYcwPh/b2RVKAZr9hVxWknCBu3OqWP7I45gGL7MXLrZVLJNaXP+kln5Xv/1vrNjBOlMZY2KLNBQapxSS40+4BSA2L44e73pots=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ckJWJkeX; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=M9IGwKjo; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MxmZzAiL reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAMBDPX000584;
	Tue, 10 Dec 2024 16:31:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=xvYZPiVmvN7FxKjMD3vdLVXXtMvSRabvS6CHN1S42Pk=; b=ckJWJkeXgMy3
	IPAGWwcerQ8n6UyH3SOpWRusiqf3kkMIvxIjamS8DtUVkWNtCf0ENeMiEIHRkPIw
	ITh8C7xaiULUrec2r8gH1DOxP4ZkyAYZy+hYk5QE4X3eZ8nJ/AQ48CQBW7eoGH5W
	VIKB+d8aF6gxqBxK7ukbRF/5gxdDIgjlduNXrop68WZBwLAauiBNwLEUCqzQ1lMN
	ngCFa/y64CM+jvHe/WUVGc9YbYVICOcXcivbRGcilUtG8ViVk6dkhGiiIdpWLdbJ
	8bglQ0zYRLPbzuYtcWz54nBNSMaO0DGogm2iXCocnExg7BVoyKiNLY1e0Z8Kn3a7
	g22u/K7olQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 43cnvka119-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 16:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733877101; bh=2F1fa01FlzGNvP4SW9/uGXQYuTWkljd+yEQ/qB5QrVc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=M9IGwKjo71soosfxs1QnEs0M8VCpJyXpUdQflR9AEq7PSioyUDsUwdeaiq2oZ+G07
	 RTvU5XPEMbvUCdkXMRMCo7jhCXn4q/UIXDWET+fI6SQO6XDxTuH3Ekf6mHKe4GQzCB
	 uj4UoOhGPzmAaqG0f6guJMzVP92SWHjqYyIC5VEGy/m/5NDECSVO5LdJPLPiHM80YE
	 t/6oeCb4LLcaAWLLADLvbeRcfVqssXvGQHGbqs6+p9GOFhVUFjxbGMq3QFS3ANzJVY
	 uZa+d7y3XpIPHKrXrklHe1pP1tzSEC35r2oxOKIT27p0SnMoRJsgsAb1nj9ZydNkXG
	 YyQGHkcbwhweg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DB0A1405EA;
	Wed, 11 Dec 2024 00:31:40 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 29A9FA0091;
	Wed, 11 Dec 2024 00:31:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=MxmZzAiL;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2ABA340560;
	Wed, 11 Dec 2024 00:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjzsLBNOkHmxnSWbel02yefLdnYhcDuI49j2WJmA/HNR9ZSyTQhCZSRMT7B7WgEzQAIsXi5dZT8lVGfavrkg1Hj8x85Uon/9XF3TbX+YIsFyWLjZsU6QqAwhHOuYYeJ9+S9fKnup95CIosV43QpYG2T+LUvhYFWG66j+6ALGv46HtUvWsthn4vvJv3OPHHOK/WVyvOETQMNxbF94jsfxQNsr2bp53Sy4j8mpyURGSLg03iowXnw3SmIjpc0FGsQHJZOIKAaXZivVLrS/YGtih/spy01sf1WcpVLsawAdgUWDzRCcNhvOQFcHOlsxqvM6Q/SQKlItTJa8tP+airryMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvYZPiVmvN7FxKjMD3vdLVXXtMvSRabvS6CHN1S42Pk=;
 b=ZWfLqhH53qmS8k+qrQ2l23iFFQV4tRr6UiytmGA1aWtjocWKB7vgXrODolQkdqmZYWC+FZezy7ZnFqejXlV8S7q1asx7GpW9ne0/xuXdjdXRxgRUEl/v7EPOtII6Car8vhZxMSbP/cegGYBmuGauAMkvBylGHPl+s9EKaqeKpked6Tv/Mv+eBd7t4YhC1LeHwPfzFBs1jLHXQ6zlqYMA5VTElin0wYQDaN7daVjwC9SP/AtbcBzd22AXMkMuQ2jDPlllL2ol5VFSmP9JS4k7K19TOQ8mzDpOZUSre+NEf9F7BjT0L3d6LgrOOvwEFfl+cg/kfR9H7unY+kVelIwaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvYZPiVmvN7FxKjMD3vdLVXXtMvSRabvS6CHN1S42Pk=;
 b=MxmZzAiLYGPsxpKlEefXCVWa+COSOIFKGyf8Ky4SAEc6L+0DElOlcQ603CqlupOIjKEViYNbMra0Bz6juz+BirfwUbF837CQct8G21dVBfmOtFbE42NqcN//0NKGzdQPcBFcFWsbdPsteBdSbRuQtkJc/SVRufY7KmPg4edQ2Qs=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 00:31:36 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 00:31:36 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Homura Akemi
	<a1134123566@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Subject: [PATCH v3 01/28] usb: gadget: f_tcm: Don't free command immediately
Thread-Topic: [PATCH v3 01/28] usb: gadget: f_tcm: Don't free command
 immediately
Thread-Index: AQHbS2QJPaWIt2oTTkK8bp/oqBEgaw==
Date: Wed, 11 Dec 2024 00:31:36 +0000
Message-ID:
 <ae919ac431f16275e05ec819bdffb3ac5f44cbe1.1733876548.git.Thinh.Nguyen@synopsys.com>
References: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB7691:EE_
x-ms-office365-filtering-correlation-id: ebd2c70a-f39d-4f2b-1573-08dd197b2be6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LQ+lmFBKZQDPANdu/t7tympElr0AmAfhq73tt7+I0S2PB87L11inTVbY/t?=
 =?iso-8859-1?Q?/vQhFBLr2iEFH7BVhi0TrATV+ngn7Dd/cOZh85Wp7omYTndPfA074L/qmC?=
 =?iso-8859-1?Q?Vop6hof7KiF04lOYt6YR99rIORvQ2vc0kdzJ2hmPNGlG/7jF0KRO9oRN5e?=
 =?iso-8859-1?Q?KbQSOdqOwNJTUn3XelRTxy+aPvwOjXtYQ+wmm8cWICwpQH74EOj36Pglto?=
 =?iso-8859-1?Q?sjgZxXuGVWM8w6JgenRtYSKlcrpGMVu9rurTVTLvl9YlIqQFvayiOOwW91?=
 =?iso-8859-1?Q?p8wJkiOE498r7nBsmyZ3yOg70gJNkoXljfhxyM4eZANx3VrKi8paUltRDD?=
 =?iso-8859-1?Q?6bVQFMWubsBFwOeDZUlua4/w4eBvnZ0ZjCvo18veFn9Mm+JRr4vlLAWFZ5?=
 =?iso-8859-1?Q?bAlAkg/L7R7rIJyQzv7YekvCEIJoZVDFWlPAcwfYdXy2Me261bmXFS2QkI?=
 =?iso-8859-1?Q?KRN99EamTYVI1GJISkAeFcW6TZZ57lwxLYBjOyDCjyzxTRLzOUbJ11sVUW?=
 =?iso-8859-1?Q?LThQDSmYQdxvFcu0xEijVzq7W4zwbTA8elJAzQMWBOrwuyy47GhZTbiFkL?=
 =?iso-8859-1?Q?22gVDNWIli/byJ9SDDhpg/Jp74SGm0oIAcgdfrADvglXR7Sns1jcbzRjPE?=
 =?iso-8859-1?Q?EtmrQB4JU1gXar4UVIH1JOIBTw1AjIzu5N0rocJ30/GXsNlhidNCvHmlTl?=
 =?iso-8859-1?Q?iiO9uHdK/rWsiDGruMAt/jbtcweACfW0fqiMwYdEUGAn0xpV3MH4m7vp8I?=
 =?iso-8859-1?Q?lmvoN4plrYLZ2f+kI2t+pxBNp9RHsgJf+/i28xPVuIV85dRbSSdMkeuGWg?=
 =?iso-8859-1?Q?Xvz0CrNvdOi8DYuqwgEztOD6KzimkH6YMrFIWc/jjO026e4Lk4uO+z/T70?=
 =?iso-8859-1?Q?0eILcRk0huw7ybaVFu2iBC5zlS57uZIGUIBbnKBmX7O+DSz7ef6yGd5Ko7?=
 =?iso-8859-1?Q?yANzLFB/pAGXK+kc8zNe0RN1aPPRdpUlV5zufUSWGVdovT7AAwj0H0/Ey1?=
 =?iso-8859-1?Q?iLgcOrfULpVyMrexLU36xh+8oZKzb//u1zy+LQBt/YispH7eakfpyeiCD1?=
 =?iso-8859-1?Q?yQywKy+XA13ClB8/xn3j07HjmWjDmhsHR+D1jlvloZbpeA7NJoeHGyoODX?=
 =?iso-8859-1?Q?l60ltqM7yi6DgVEL3d4EIDPBWPGyibvCkZkPnzQ09GKq7+gAzqx89Tlk6e?=
 =?iso-8859-1?Q?d1gwuo87W3jg9aVBLSO9A7RJPGHLEDCTClRhMhr+3Njblw9KAWcatfl8rY?=
 =?iso-8859-1?Q?WGCeiVNLDFH/Ly2fjAWBzT2b4OdTOgWkvC9OGX47HmfZ+Yr1mLqGE6OEFY?=
 =?iso-8859-1?Q?6Lr4/w+XhOhZr+dvlv480P3RoF2Y5W7Vevg9tO4zOMhr+1SgQmOfhCZW0k?=
 =?iso-8859-1?Q?mSfvEs/XqQCo7gADGsSPDOfkQP+h7m7bi9SVyjoZGVqVYk3+wPW5G1V9cN?=
 =?iso-8859-1?Q?5/99XX65puIxdJbk9qTBy5cL+ul0RxtoIvxD4Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5qjJhYUzmPmaHOjPqN60vgMcMHajXChZ03oPGce2fS5/4+YvKnqHl44p1b?=
 =?iso-8859-1?Q?S8JygKka6uqVHNgu9NId2sE7YYvx/+JDS7Cy3Ydd2SIwHpAk3kdHDid7HN?=
 =?iso-8859-1?Q?9kYSrrlUEOjmkGUJmA+BclgqcnGBTJDuFXSQNnjt9uiXlSwaMSJF87Ty/L?=
 =?iso-8859-1?Q?7jkouJLsbEM1SUzw34DguL57As2gX5D1qy/0iyfraGRJXFujqy9VHva1y6?=
 =?iso-8859-1?Q?uYwZhD/cYjhrL5f4/CE6orAjvIt2apYWV27C3zsNAzmDOWfSlK8pwyKefU?=
 =?iso-8859-1?Q?eYEX/x5w5XvFBS/PodPI9IvHIvt3toZo3g/T+1qn2Foc8bT5SS1vT9RkNu?=
 =?iso-8859-1?Q?poG+AHAiclH/Fks/rB6gA4YuF2OmXYssYZiBNp2DgsXf5SeSboCAzIkhhe?=
 =?iso-8859-1?Q?U+4ypuNeHyRGD4CV0vOEFdRcBMqHmQhcEJhlUVXMhNeSrPMN4QyhDvWXRp?=
 =?iso-8859-1?Q?K9NKK3Nxhx4ZgwcOhLrlJuFm5MmkBFoN4eBfnncIW0wW9acBLj1MCf0AtM?=
 =?iso-8859-1?Q?CHLMfPnYH/0GlHstLHUOLJnMFfIzjU0I8zGPumNy6yQxGhKVlfC82aOLR2?=
 =?iso-8859-1?Q?Z46YRe3II04Tkt9zndvCwS6ED37iEZWsjgNIAm4xOcSQ2cNuK2b6FFY37S?=
 =?iso-8859-1?Q?dpj+7QXIU0kMdwrlmbJCPk8HyYO9BmuTQdwbjZUk4Mn926Sy3SZZr718kv?=
 =?iso-8859-1?Q?U1pkPUkQzI4JGQjyPPxInv3ykuBRHl9DuflK/3xz/5DObk1XMnrJy7FXTK?=
 =?iso-8859-1?Q?CPQ101FnR3vTGPX1G5MAzrq2IZ0BnmsIc5201qpqOLFjpL+9sVvWfMzuzL?=
 =?iso-8859-1?Q?ymSLeTfi4V27/0sPj3b/hUmloJFsM4Q3GNsrGjbBnONWjbNNjZImgemsrt?=
 =?iso-8859-1?Q?KJsv+nwRBko2pBjsfIiXZInwg9F8mPF9xXNQ7p3fTf2gHQ+mbHsJltI0w0?=
 =?iso-8859-1?Q?xwVDL5iZ5AI/E7B751VzZYTUUcOm24hCZajxgAuk8ltysH7BI+g6L7iTGG?=
 =?iso-8859-1?Q?q4skwC0r229ArcL3UAym5JglruAmAbIIeKABGW7dD/7XFdJm5xxTRTGRfM?=
 =?iso-8859-1?Q?F/c2ujizHqECJ4JbM0Ewwghl1057wrnInl9LDE1EriVa3i6BlDioOoZsPn?=
 =?iso-8859-1?Q?ack6RRAGP1gLVXvGds37lPkLfpfsPW+CfumAJI63i0lJwM44hiZBKomfSC?=
 =?iso-8859-1?Q?kSzoNGqrvHcQUpVL8pLe2ge9EppjQyiLX7bRVhIknSdUSC3XK7N1Cv/jaL?=
 =?iso-8859-1?Q?0O+1rGUbkGjCddbTOhOp4Zlow7RsFjDrjZCE6wn5VHwBhoXuHmeluAFh0C?=
 =?iso-8859-1?Q?hX4ceQoPVZ/47lEdCz8Ql6IQJ4spbT+XOUInc8B3DKe32eMfxfzk8iB0mM?=
 =?iso-8859-1?Q?+JdpZVJBIzLVsRmIpxA7Zawm8czBdFLVQt0d8Z4fzY7eOxUm96Glyrawys?=
 =?iso-8859-1?Q?P+AucGHj61nRBe1nAbwPxxXprL4sWAqErMGC4gKR0iplKj0eNi/gSMQu6h?=
 =?iso-8859-1?Q?t1licuDwlmVuBdUc/SBp++tuxmUlNh2fUw1c3CEA+b/HugFyentMX/wjOZ?=
 =?iso-8859-1?Q?MLcEAxj9RLfM1aX2AAdKPSv7FSGp5eucSUttFHsgXl/9zbU+9Uu/roTr0u?=
 =?iso-8859-1?Q?hgbRyYLVLBVCLbPKUKEqProQop2HptIIKd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C1w6VuBvTHJjfKNkDlZ7xhrqZEyFvJBz8nW00j6pWrh87ZFz4Ry6RBLiXdV3wAZYTgRf7OI9F8z46xL0T3tq+1UqxHU92ncyKFff+M7QB1TtbuK6vD1EXIrSJu35GNPPw7t0HK3g0/TfDXibDlAvQcpduN23LtuM8JXiIUr9am2qJ+H2Auix4O77Eg8AO0sJ4wpcx/Xc+ZtN4cjWZW5AQkXcvxCJAaUw/ducj8Xg5mJ/3FpGmrN1wjAWPMNAgK9U4YhanBpdsPvjbgMPQx6YZ5xaBDqhs5cS806zAwltA1wZkiW54dYmd3Avrk4+bjaIU7IWgnuT7fM16CzHSMJj8Zt4Uhfxy1daYKOvtpNOZsb7gAhFzeQU4WsSEbtlYdHt+iICKSye/Pdfs8qBEkWBalF1QpKobUsWQ6ribR62jDRDBEHMB8/mqHiApVMbqUxDLhxkpOE6+cg9d4GN+mtvzOjacs1ahVN50pNBvgib1vvFBiEaKvc9zbMISCo9aLp4U+cFUAgmCgtzXfU8OJrQ5rz0dKz11uvlnFsze/tZx8GSyqTWF2wBOvy10tX/l5VaFHDdm/riRgBqEiCOABW9UDI+BweqG4A/pdfT0km9WQt4TurvDk2Lxu1f2JnWC+84FcdSV5Sz/CdSaBYL+lfjaA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd2c70a-f39d-4f2b-1573-08dd197b2be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 00:31:36.4143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKYcli0C56j+J87/SiBHfK/V8gsptXwqzOalBa3gzzTguv49zLIaSQY2g0ILEg0iVHVy/t7ndzHUHVg/ontZzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
X-Authority-Analysis: v=2.4 cv=fNPD3Yae c=1 sm=1 tr=0 ts=6758dd6e cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=P9SarY25XEDwvii7LpEA:9 a=wPNLvfGTeEIA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: 1NHgaCyb30sbr0QXxL-q77yRE1EBVTsQ
X-Proofpoint-GUID: 1NHgaCyb30sbr0QXxL-q77yRE1EBVTsQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=821 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110002

Don't prematurely free the command. Wait for the status completion of
the sense status. It can be freed then. Otherwise we will double-free
the command.

Fixes: cff834c16d23 ("usb-gadget/tcm: Convert to TARGET_SCF_ACK_KREF I/O kr=
efs")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/f_tcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/funct=
ion/f_tcm.c
index e1914b20f816..6313302a5b96 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1062,7 +1062,6 @@ static void usbg_cmd_work(struct work_struct *work)
 out:
 	transport_send_check_condition_and_sense(se_cmd,
 			TCM_UNSUPPORTED_SCSI_OPCODE, 1);
-	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
=20
 static struct usbg_cmd *usbg_get_cmd(struct f_uas *fu,
@@ -1191,7 +1190,6 @@ static void bot_cmd_work(struct work_struct *work)
 out:
 	transport_send_check_condition_and_sense(se_cmd,
 				TCM_UNSUPPORTED_SCSI_OPCODE, 1);
-	transport_generic_free_cmd(&cmd->se_cmd, 0);
 }
=20
 static int bot_submit_command(struct f_uas *fu,
--=20
2.28.0

