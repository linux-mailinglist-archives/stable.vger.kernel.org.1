Return-Path: <stable+bounces-204500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2532CEF375
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 20:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C73B4301C91B
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 19:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C78D273D9F;
	Fri,  2 Jan 2026 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GcC8N5xb";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GcC8N5xb"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3DD1885A5;
	Fri,  2 Jan 2026 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767380716; cv=fail; b=IW51UXZVCWZPNApx0y/fVDY6XSNTnAOUyUNpl7B+ebDxmZfJlw3cun0SaYr59QCnZPaUXCkgmkWZ9b5rnSysSogvaTzB8hPTGHFgWM0iGHfvIbRH03Jsp9vDjRbsey1fFY/xUBmF4ChEW6AD+iAS6LJ3Grf/CEE7in7QllfuIuQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767380716; c=relaxed/simple;
	bh=dhhYImhI1efxn+3oBiCtldXO61sgy91cEHBShwenejY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cEgjc24jOEweGt487nlBQjmJdxGmgQ3pC2kvZw6W8Xy7jrgwKtvdHkq5Rhx2HOxzqLqOjyXTmH5uhXWDccbRZRoGyNrJlAwuflMH8RyH6FcEayH7moV06H5wcjtUOv7EfpWJB3YD9joQgVKug54AdHRN1NQrovipwygVhtkrUNg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GcC8N5xb; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GcC8N5xb; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JgH+XH/O9p47plAM2wqoPTyKe1A9kTPCe1w9h1RRcdupenN7uDg0r73SeCjz2aEMeNmbbT5A9TYHuXiMFBPsMh4AVrc5knb/mwgEvzWuIPm4C6HFXxa9wPLl1O60wp/4dmbB5ZG3oG0V6Dm5UhH2Cq2EMLRGveT/gjc1L+kH4ycy5/nBMIHTne2WHNreirMQoMLEz88RoucL5lf0veXnmt4P/LaQq6fpoeqDs8uWzjujlM5Y6ldOHc8Ge3gl+6A4tWTSCu1Y8rTprVZmLICLRfRD+Aejw5XtHAN0vVA4dkuLerwK+QyIF4IsliNacCoHPcaG9bsh5TVRMoGmX1QXcQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWu79DcAFnHs0ZzvCxoy0mAX1IeXFx909rt1cT40H+U=;
 b=AWip0Up8dIqDkYk7R3/oy2n2hBwjuBHr0jKe1ZWsjEkLsfz6SmObU7n2nU0KzjkgyY9DtEeOJedmvDWeQRsjyDdanr8n75/bArxItql4/vY6B4LJdeGJ82uT7kiuKWMtYBT1UaYTqTrwrDpEd6Z+OSII9SZ2IA8ET9rs7Ni0b3EzFON5lrQGNtYAkiMUNHBNrx3qU5dGC2vCSGozpjSa5RrEF4WlwYXYbNgWPwhuxgicKPF4qyLp/s43w+KiWB4fknbjho0gH6NlnN6DRdxIh2x4gmOcjoFo3GgWcYCmtYQ65XZwja9mfZYLH/m/NqMmTdZydC1zfI89qK3qOTZEaQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWu79DcAFnHs0ZzvCxoy0mAX1IeXFx909rt1cT40H+U=;
 b=GcC8N5xbxd3OFYW/YF1H2kDZ7UVuRX3YaN47PNjy9SD0s9gLzRmi43/evp6D+LRZpuFgzx+5JvGSMHrq7+n4dsqCes6Cm/Tyr3yruGb050wQxM2V1AgXZsrhySx0ZICgD+N13bdCh8/Z2K9btUQ+sBNr+dFObE2NqMk7gJSzNPM=
Received: from AS4P250CA0013.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::15)
 by DU0PR08MB9107.eurprd08.prod.outlook.com (2603:10a6:10:474::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 19:05:09 +0000
Received: from AM2PEPF0001C711.eurprd05.prod.outlook.com
 (2603:10a6:20b:5df:cafe::fe) by AS4P250CA0013.outlook.office365.com
 (2603:10a6:20b:5df::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Fri, 2
 Jan 2026 19:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C711.mail.protection.outlook.com (10.167.16.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Fri, 2 Jan 2026 19:05:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipT+VDqs3SPxRlZbk7vocmP3mb/I4Q/pVWGODcqNeQIHFb9GEEFU0QAuekSzdFV8dt+1bgqLoexRqkezGi8VNCrE4ilfhl/KhKxuwYE1CQSU8IkROMvG+dR9nI9X6ac4ftNbmkYK31/tC1koTh25rcUjgIccS7V3auO31tKqZEalAQxyXguRxo8d+hwJp4EBAEGJ8AS+dVFT2FcrupXnug55NmW8AwKNpqiLLAsBXZ8aGfOE0VdOYyYSDgEeKwyBTl3lZd/S0a5FajwREKsLw9J+aiQybsFk1id7Qw09mZZneGy5Yl/SsXCXDc2fMoZxvuFLCM/SvnO1GQSZpC77/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWu79DcAFnHs0ZzvCxoy0mAX1IeXFx909rt1cT40H+U=;
 b=wmb8Kg7IobW0LR8U5syl4qjdgNS8Goj2/mh0rCA2IEKpQPZ3y21EVPyM7rWkwttvYCeu4XlrsqC6Y1bgI2mZMKnYvgQwoJXyj/GwcjOItj8eUb/0GiZ8I5bHv2wezQweFtWVRqN+t4kBvchhcC/MYKemRKqzbf5yyTE0WdtiLYxj0CPs3FyugTQIsKSitGP0w1RYlctAtZt6qhY+R0xYdjOKNjAyNKu5liRbjwBB3HQ/Vn/KTSrJO62uylARHv59leel5oaCdCKjlFxBKeLFHm40Wa84eUBpBGYvLmk8SVsVHOkqg1s7voxcNwZVTjx5QNbhilWaNRbKQ4BjJujs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWu79DcAFnHs0ZzvCxoy0mAX1IeXFx909rt1cT40H+U=;
 b=GcC8N5xbxd3OFYW/YF1H2kDZ7UVuRX3YaN47PNjy9SD0s9gLzRmi43/evp6D+LRZpuFgzx+5JvGSMHrq7+n4dsqCes6Cm/Tyr3yruGb050wQxM2V1AgXZsrhySx0ZICgD+N13bdCh8/Z2K9btUQ+sBNr+dFObE2NqMk7gJSzNPM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV4PR08MB11275.eurprd08.prod.outlook.com
 (2603:10a6:150:2eb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 19:04:03 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 19:04:02 +0000
Date: Fri, 2 Jan 2026 19:03:59 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: akpm@linux-foundation.org, pjw@kernel.org, leitao@debian.org,
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	coxu@redhat.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: kernel: initialize missing kexec_buf->random
 field
Message-ID: <aVgWn2NjVkKAABM1@e129823.arm.com>
References: <20251201105118.2786335-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201105118.2786335-1-yeoreum.yun@arm.com>
X-ClientProxiedBy: LO4P265CA0195.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::12) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV4PR08MB11275:EE_|AM2PEPF0001C711:EE_|DU0PR08MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a8f32c-a38b-427f-ae79-08de4a31d87d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?htRa93quUlRwzfAc5pL76KhVVqhHBGRmbnZiO/SFlS239eYkdd4jXHMP9f1o?=
 =?us-ascii?Q?WS7aq0+uT6Jcp5JgGDio8azmOrgXrIFNCqH2JJ0B/dpKv3gDzo3x82LgvzlF?=
 =?us-ascii?Q?EOHGfdpNJNHAo+9smj7oQneFjqlQVluS1daCAGVKK6dd7Wzvqk6PX0pkzAdi?=
 =?us-ascii?Q?kZO2Dru7QUfXPinI7XmMBoTkqdvb984IIv7PwKpwacIESXALEMVE0OyCSJsd?=
 =?us-ascii?Q?nN+gNGkA1yJflNv8CAls+XxzyoX3zk1zG9H/w8wtNEYZpV26T6r/YZ1iDkpD?=
 =?us-ascii?Q?M1B4pzo+RaSTluAdnqS0GoXRDBsWXh6+ozdC+Ki8S3Y9fUZ17k9xyIEmthoZ?=
 =?us-ascii?Q?59HAy1VP9NdLFsXpQcSOFaFDklQvyvk3asT3B4q2z2JCLPwy4ME5gX5F9QsM?=
 =?us-ascii?Q?l0v0iOf/HW0wuyV8G8UngT9VqUU7cW6Nq3BEv7wfuRpJ97fbJgUtA8XCAz9K?=
 =?us-ascii?Q?JlF39HxCiNEEGV4LHw64L81gTs2XMsXxpxyoxRoVLKNF0MfBYnnFmHY5WBeV?=
 =?us-ascii?Q?1iFw0Z3XvRJlnRnCf8y81CeFweu4433SFLE9tpPU4lyrLnETJvgZijRrh53o?=
 =?us-ascii?Q?i8lnbTA/ePXlzU0JPu0HWCxf1jyMElKR9iAFvnBxWSLdEIL5OQ7WQiY/+F4x?=
 =?us-ascii?Q?Dos1KzHFo3o8pgWq32Dv7sUMvYOOmjPsMf7CadrdhJXbaoqxW3ox13wyT4UL?=
 =?us-ascii?Q?MEJp2PCr9OiVyitiZuLkVBNM1FdtAxNhxImjwrRswiPs2D4V5CSNuPQWInwi?=
 =?us-ascii?Q?dWegmUL29eZLLxd4e1tGxx1idtL7/xJxNu6IYLg2o/MoGUZGKLJL4r+5UVij?=
 =?us-ascii?Q?c1E7YIv0JY/TiVKqwjgDGYZnH5wl76gZDGkqRQMb1yVfZKdL16tRVTLUZI5W?=
 =?us-ascii?Q?1HjUwAIf+SP0jnRSTUQCj+J3noi/jWZ4LTQ1KG0Y4b6Eclp5pU0a7vI6Qkd+?=
 =?us-ascii?Q?kx3tLZcbKgFN8PhOrUg/VTQ2A0ltS+D7QZvcQloMbpetmDLM75dKQtePSPRa?=
 =?us-ascii?Q?etTi3kJOeIKnsI9lmfe4FB99Tv/924U84Nx5ZYLwSjy2euHWRZ2aJsPIGIZM?=
 =?us-ascii?Q?a0bAf9wd0VQRR1D0sqxYcsjNFKyMMZL24fJ7DALJ3nJd8J0v4BhwuMnpJtEV?=
 =?us-ascii?Q?OL5jGlimT2Y79E+AMZLKSI82WWs9dTAzw9m0C3crcylJ/OwNp8NY31eJfUWZ?=
 =?us-ascii?Q?2/B3p/vqc4gU7PiuAUG8M/LcXuYve2z9gabdmg73MEFHrirUu8CFkCoVsF8k?=
 =?us-ascii?Q?bT1cP48MdkOTI/k/f2Z4HYcisooLHKl3rDT5//99Z23tWUyDRQfCCqT34cVm?=
 =?us-ascii?Q?Po1LXI4nWltyG+ApDeqZq2+Kt6DSFD1XBTjmeAh2Ysu1NBSZUJkeF4TOJYA5?=
 =?us-ascii?Q?j1a8qkDlMb0QN3jq4G0vbFGTpqIQGgWljLC9lD8u90XwRLM9ivyRZ3b1VQbj?=
 =?us-ascii?Q?sVKYvYHeQOBhnN89x1iDVDKKACp8uu9E?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR08MB11275
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cebfdcf6-2da8-46ed-e571-08de4a31b15a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|35042699022|14060799003|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K/Oi5Rc4CEpTzU2HXAXhq13FD9sFmPnnytLsdn7aGPDhjwkjOci+UXp+LdfU?=
 =?us-ascii?Q?sR58w6eDcoBb2f1OXkDpalth4SDZoJlPxyYCfcpQW0b03jr2U1gGIOjKQMf0?=
 =?us-ascii?Q?6u4h++tygHqA7Sj4Iiav+s0x+kOXdKJJrkT2XpoIabYznQvjo35uSZVmEf4z?=
 =?us-ascii?Q?rVizfyKqF6Oc+WcKjEsq3gPC1n53jl1YtgV6mjeCaSQbTzG+YiNnA7Gmws+A?=
 =?us-ascii?Q?qorxxFmjnEftxCB1eGFbaqxrTOpEOFO4Eocze7I/MTxAlHKrj99/58lpnfJ2?=
 =?us-ascii?Q?BEbm5RJ6PvJY48WAoD63JCDKC3IxrJ+popBHgrVXyLpav6NHRWG+51QudB/X?=
 =?us-ascii?Q?MFrgznq1x949aP+/2pQhwvr4iNAO6H/J/yykAJztdffUxaeEi/gCnbp6gdBe?=
 =?us-ascii?Q?haoeypIaRT/1GuZKH9HllsXc+M+yND4/279wQc16jnHCmh+7nv2sGB0ASHw1?=
 =?us-ascii?Q?u3s5+jpbLs0drMAKzQbxE23Or4JfEMCP+OAxjDnpRQAFZMxX6ZrnO0Dr3tGm?=
 =?us-ascii?Q?V0SefyQhXODkjQUug/mo6myNU3e2AA41ZtTQQUNo+ftnHGe2crPqR5VnMtdO?=
 =?us-ascii?Q?vxOyqmNZ/EtXMRR6ugNtJZMRdgguXhl7N2V9U1pV1v3xOIg5TPlfb8Q94+SD?=
 =?us-ascii?Q?VqjaWCCpNmk/R2JLlWuncZn2eOl6z7XKgNScKgyledgsW7KmLx45ZQIBfXhA?=
 =?us-ascii?Q?mdPhdvy4MzcuEvPSPBTEiZTSTblHCKchyiovvF/zzOADiSDSoFMBJb8yO1Y2?=
 =?us-ascii?Q?GmiUfyX3nwNSzK5wkSvJiBlOBxXMdTLx0sLFytrBWI60zTHLcuHBupHvPSDl?=
 =?us-ascii?Q?Xtmk4oV+REklxwkNS5M87jrHYUlHripiUv1xSz6VAfsrgBlSvTl5fuKpY3tJ?=
 =?us-ascii?Q?1/37e+cgC6T5CIrEh6CDaKXqV/BkrABOjeCStuNDjE/FWdfWe5Nb9WRwr4dU?=
 =?us-ascii?Q?FGTgClo3B3YYoqTr6bqBEZuyrUL3TeVfz1LWeeiuD+c3oveecyF39cX3/ufF?=
 =?us-ascii?Q?xgP+vEZpAntCBAvcACiwkU6cgX9S69EPYyDHuTuoxX5CtB+ZqZO/k93NL9CV?=
 =?us-ascii?Q?RNG7SIQo259WTUG9gB9S7ku9tju/k4e47TZlE36RyS/tfllpMP78zlQOyG+p?=
 =?us-ascii?Q?xTofxrJ97zR3iOng0QEdHhE9KEhnHGNzjpepeDldVo/A5OqKyylILG9KSTy0?=
 =?us-ascii?Q?ISBtyFinrJcAE54CuYosTx06rgiYzlrz2IqiAB/tY2RDuEbvKN39GllMYyD5?=
 =?us-ascii?Q?PmXdRKcBFlhwjZ5gs9lgJOMcP4vKe1TOPxv+JULa/VOnLiuMYQDNouLEmIeR?=
 =?us-ascii?Q?TcNar5hWWFXFd4s/4mvaSwCwgqPh/GQ9OJjLyT7uW6q1c9WJGdr9xeKtSBlK?=
 =?us-ascii?Q?VXplUBKayMCOEwHjVzTxo0lDmo7Qq+FX19LxcNZMo3BVCfAoXJfcFcCkbHMT?=
 =?us-ascii?Q?h4DNaOYu40r4q7yHjhisj2iAfpV8taZRNvCUf7qVRowrbWFFcDb86veEo1K4?=
 =?us-ascii?Q?++cjbxhNx9vviTj2ZTIvD7dlYN9hKF9UYK9hqngq1mtnwivyR0BQbtmstn5z?=
 =?us-ascii?Q?rDrRWWG7S0Te1y3icB8=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(35042699022)(14060799003)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 19:05:07.8217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a8f32c-a38b-427f-ae79-08de4a31d87d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9107

Gentle ping in case of forgotten.

On Mon, Dec 01, 2025 at 10:51:18AM +0000, Yeoreum Yun wrote:
> Commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> introduced the kexec_buf->random field to enable random placement of
> kexec_buf.
>
> However, this field was never properly initialized for kexec images
> that do not need to be placed randomly, leading to the following UBSAN
> warning:
>
> [  +0.364528] ------------[ cut here ]------------
> [  +0.000019] UBSAN: invalid-load in ./include/linux/kexec.h:210:12
> [  +0.000131] load of value 2 is not a valid value for type 'bool' (aka '_Bool')
> [  +0.000003] CPU: 4 UID: 0 PID: 927 Comm: kexec Not tainted 6.18.0-rc7+ #3 PREEMPT(full)
> [  +0.000002] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> [  +0.000000] Call trace:
> [  +0.000001]  show_stack+0x24/0x40 (C)
> [  +0.000006]  __dump_stack+0x28/0x48
> [  +0.000002]  dump_stack_lvl+0x7c/0xb0
> [  +0.000002]  dump_stack+0x18/0x34
> [  +0.000001]  ubsan_epilogue+0x10/0x50
> [  +0.000002]  __ubsan_handle_load_invalid_value+0xc8/0xd0
> [  +0.000003]  locate_mem_hole_callback+0x28c/0x2a0
> [  +0.000003]  kexec_locate_mem_hole+0xf4/0x2f0
> [  +0.000001]  kexec_add_buffer+0xa8/0x178
> [  +0.000002]  image_load+0xf0/0x258
> [  +0.000001]  __arm64_sys_kexec_file_load+0x510/0x718
> [  +0.000002]  invoke_syscall+0x68/0xe8
> [  +0.000001]  el0_svc_common+0xb0/0xf8
> [  +0.000002]  do_el0_svc+0x28/0x48
> [  +0.000001]  el0_svc+0x40/0xe8
> [  +0.000002]  el0t_64_sync_handler+0x84/0x140
> [  +0.000002]  el0t_64_sync+0x1bc/0x1c0
>
> To address this, initialise kexec_buf->random field properly.
>
> Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> Suggested-by: Breno Leitao <leitao@debian.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/kernel/kexec_image.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 532d72ea42ee..b70f4df15a1a 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -41,7 +41,7 @@ static void *image_load(struct kimage *image,
>  	struct arm64_image_header *h;
>  	u64 flags, value;
>  	bool be_image, be_kernel;
> -	struct kexec_buf kbuf;
> +	struct kexec_buf kbuf = {};
>  	unsigned long text_offset, kernel_segment_number;
>  	struct kexec_segment *kernel_segment;
>  	int ret;
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

--
Sincerely,
Yeoreum Yun

