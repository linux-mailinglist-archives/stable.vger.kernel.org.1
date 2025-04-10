Return-Path: <stable+bounces-132025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA10EA83627
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 04:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A92D8A5212
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B831AF0BB;
	Thu, 10 Apr 2025 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AsFVXOQi"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DF91C5F11;
	Thu, 10 Apr 2025 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744250547; cv=fail; b=geC1By1iY2h8x3RxQ6LkHlGsMQYa6cuTyWZmMbtHBu/FPglbib7GDUsVHeKaXOyM5NNNWf2QPdf5pIQGCorbtj6Pqh9basVgR1vFXTOmXGWPgmOlvuj0TAWmOCz9NU3EABRjo5BELlAd3YzV5gOSycQSwRswfXYBJ3PLyt0XaI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744250547; c=relaxed/simple;
	bh=QS1iWzdf3vNfliq+z5gA/ZmldI70e9if8svLomB6buo=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=r2hebqR3oAuAce7y0RMQRZWGC9HplMUTlfO9Mu/+xpBi4kHPt8wFIfnUpqO7Crch0niRbJUaWVV69IsY4WZfgThE3c4GaQkHcibOOsME98jfv+BKm/l0H/VVBQecyaVOqppMqAenJv5lQ4jxvPSomYASS9SaZtUQuBL91pyNoX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AsFVXOQi; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRwFOrJY/ujgnMGNOQ9OLgmouUTVu9Brn7VBk7Ltn37ueFTr80a5Y2osl+1IiJR6vzRYJ+Pv9vcGZUrop7K8z8YvhHvU/JbMYepvIjk/40Wd5ZXbezWIxIQQevydvgUxD6nhlV+0iuPXd07iIiZBm6I/64D72rirKy4JXpMUvsPQLUABuRqLcXPR/YobUZGwiL/q64aecpsJyHj9Qj7Zxw5SZYWTJapD/y1ZYlnZkcQw7Q1c6Ecq1T1c3rLZLqNA+6DEByxNw3E1vxvm9ihTm9NjGJ9mDL/bbE7PQWGRFb3SnygFSaXaQKFh/vQHvgZi8oX1/Lm0X90x+hMdK3Xnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Hjmm54e/CJZMJ/PqB8ByT18s1OnA980o/RkY2iPpuI=;
 b=ZtZ3X7nXB8fmw+gb4GlhqVdW28RAfP4zktnN5xUTAyYmKIAEIcQNF5sOqUGBJS4hxjxpFrt7mSGLjowNN5mSrrdnv6t4OvcEmtls8YCQbpGPOUz+gRwTnQOk3bQq099QiKK6D0WOHIA8v3Uec2tBmA89+lZyiyqZqvDdVbGLnByX5ceLFs/bJsXSK8fQZll4r/Eri0mAcgeBelOuDOPfmjwbu3DTEHmPY3wTC3gDpKIDlkr7nkiBsVk4XbLmJ3A09OcgOkl5ytT9K9ZLdgiQ8tIksGCdlXzEedMU30GMFaXWHQwaN9sysu3PtZojjmZ44TeEJg5i3B8KwcOQdrD43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hjmm54e/CJZMJ/PqB8ByT18s1OnA980o/RkY2iPpuI=;
 b=AsFVXOQiXQ71+EObhYcUU/mtOgXT6Tm17P+3sKvtD8TVu9bU49rgqp9rdQMRBTYbllmygHHpzKbFyFZ0L9DxFXJja31265DeZJYUJ4yQ7UqeO92L2Sv1/oUHRz3OlAIrM/j4ptYljZB3Ju/U41iLITp/MpGE6IM3IOWLKsRC8ey4tMBLBNAQ/PGMkuuGxPTTj7LTMP0KSd4a+J6yzAq6GZefqgaX1on4tUIgUqCLANPMtAemWfwf0BCG0kuD9FhAmiQfVZOFFbOZmFZcnST+kK09XToPtxknGpAcNb335Tg7dhqoWWqZF2ChgcxSEF/VQ9qYWIp5PGogYvvpadijQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Thu, 10 Apr
 2025 02:02:22 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 02:02:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Apr 2025 22:02:21 -0400
Message-Id: <D92L7OLOMSRV.KP3YBYMZ8NHZ@nvidia.com>
Subject: Re: [PATCH 1/2] mm: page_alloc: speed up fallbacks in
 rmqueue_bulk()
Cc: "Vlastimil Babka" <vbabka@suse.cz>, "Brendan Jackman"
 <jackmanb@google.com>, "Mel Gorman" <mgorman@techsingularity.net>, "Carlos
 Song" <carlos.song@nxp.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, "kernel test robot"
 <oliver.sang@intel.com>, <stable@vger.kernel.org>
To: "Johannes Weiner" <hannes@cmpxchg.org>, "Andrew Morton"
 <akpm@linux-foundation.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.20.1-60-g87a3b42daac6-dirty
References: <20250407180154.63348-1-hannes@cmpxchg.org>
In-Reply-To: <20250407180154.63348-1-hannes@cmpxchg.org>
X-ClientProxiedBy: BL1P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 42663961-ecfb-4f26-7299-08dd77d3bbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0laVGFSc3lNLzhNKzRqNVJCcksrRnlGcFE0YkI1S3RObkplc080MncvWTdL?=
 =?utf-8?B?a21ZcHdSK2hiQmt4UXlFNDkxK1dUSld5YWFST0tDbnhNalV5Z2owdWw0TEMr?=
 =?utf-8?B?TlF2WVNpczRRWHE3eHpvczZ2ZDhLRmlGb3JKL3BNVm5CQ2NPTER0Q0hqbEpK?=
 =?utf-8?B?MTN6bitFYXRRVytlb1ZDdDNFMFh6b1pWNXRFNlJvbkVTSER0YzBPazNzR0N2?=
 =?utf-8?B?Z1V0Ky9rUFAxOUREY1IvUncvMlFwZnYycUVvSTc3SEI4b29rYzBCVHU3NTlt?=
 =?utf-8?B?azBTY0ZEMWcrMEwxUWxxQ2JLM2tCTmgxTVNsTkRYQmpvU2tzTjI3NEs4Qi9q?=
 =?utf-8?B?b001VlRWM3ZRbGZjK0xneXNITEliQ0thWWpobXJkSmU1dy9SK1h5MkZkYXZv?=
 =?utf-8?B?KzJITmFXK0ZZWldxYi9sS3AxTTB2S2gyaklvSTQ5UFFnbXFYQ29sNHVtMjNN?=
 =?utf-8?B?aFF4Rmo0Zmk5d2h1aG5HVVV1SFAvQXJkanE1ZC9wOWhrMitOa0cvRDk3RGgr?=
 =?utf-8?B?YWdVTnhJVWZDWExib1kwUzc1QXJnTmw2ZFA1ZVlTc2kydmpXSTZlVk95TFBL?=
 =?utf-8?B?VW90SDhVY1N0bTdXV0N0bzNqaGwyQ09EU3BqdEY5a0ZyaFhlWVIvdzhaNXRP?=
 =?utf-8?B?QWg3VFdISVVHRlU5VVVlOHdjb0piaUxXRVRpbWJJaUZhUGQyLzhuZkJ1c0FD?=
 =?utf-8?B?M3hoTm5yT0JjVmZzcUFSaFdScDR5b2lLbVZiZnpyNXdmaDc0S2RPLzF1bUZo?=
 =?utf-8?B?RUk3djdtMUdDVVJ4YlRTbW51cUFqdklvcHlWWHZDb1owRE9iblNSVnF4RlBW?=
 =?utf-8?B?aXVoTFJJdkNWeXJaYlNOekdQL3hPMG8ya0FoaUNYSENVcU5TSWVGSWRib21a?=
 =?utf-8?B?Mm9DaEZPaXltTjR5RitpdXlncWl3Y1hLZ1lPODhXT0lCbkRIeXc0ZmlDVC84?=
 =?utf-8?B?S0xoYnZqVU5YOXRuaThCWURONEhnMG9NQ2F2ZG1SQ25RaFYvVmVXb2crZWlo?=
 =?utf-8?B?aXBvMW8yb2hkWEh6VXdmNzVjSW55ZGw3aHU4d1lqQTRPSWl2MGV6NVBIVlV1?=
 =?utf-8?B?QWswOS9HVEh0THd2N2IxSjFrVVFVMHcrQUhnSURLRXFHdzZ2VFdIMzNxNy84?=
 =?utf-8?B?QlNqeTNURDVsVWIzMzBhVzZnNm1hY3c5UXpyL2FQbG9UVHpHeitkS1pHdnJZ?=
 =?utf-8?B?R1RJaU5XRmxETUNHRVZIT3g4Q01jbXZvVjRDYVJYT0Z1T3pWRURpWUVXY3hG?=
 =?utf-8?B?NjRKcUVoQkphTUJnMzJ1VE04bW9jNGtyNUNnL2VNTXNSb00zNyt4R3dDZWdJ?=
 =?utf-8?B?cWxSa0ozdld2UnA4OFl4eXVXU3dJbmlVRTJJazBQcElJcmRWRGFkdUYvelJL?=
 =?utf-8?B?MmlhRVFkeWd4V2FrVGVZUklrNnpaelcwSDAyZHZxeFMxMTQ4NC90cmt5Y1Nt?=
 =?utf-8?B?Q01lck5haStKZXIxeDdkMEtHQ3FQaytzajFuL3dldDI3WVk0bmV2L2VpZXEr?=
 =?utf-8?B?Q3JURnZEN0NJSVNLVjNDODlvZDJOdENLZ2U5eXo0WGluQjRvYlhrd0pOS3R5?=
 =?utf-8?B?TEJQWWhuWk9ZaDhQdkRLay9LaFovcmtSZWdlZFNYYTZJbjBSRHY4ak1RanNj?=
 =?utf-8?B?VU4zM0tRbEVpaXhESUViV2ZhWXNRRFFQL0NtN1BiNWxXc2dGSWNRUEtTYk13?=
 =?utf-8?B?SWErSTAzazN6RUNIeDloSnJLVjZLNVlYZFRPUzdKVW8xRXoyTGJTcWVsU1JH?=
 =?utf-8?B?SkdMN1J4SHlvMEx2bDhETmRPSFo2NlFRVGlWZG9XRzF2dVhQSXQwcGtTU3F5?=
 =?utf-8?B?VlJyT1NiVElMOW9jUkdXVWNEYU5ycXlXMmJNZ0VFanZvbnpSWUZYdXFwVm9U?=
 =?utf-8?B?MXM5Z093TFB3aEdFMXR6TFVzdE90TVFEZkxzM0F0ZU04cnhvTGljc0pncnV2?=
 =?utf-8?Q?x/uucbWdhyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T21RRlMzQldmWW5rZ245TXMvbjNrb0pxd3ZmWGxCQkxiODRyK0NnMUlRSUR4?=
 =?utf-8?B?MjVJSys1eisxVU5wOGVPMkVrbkRBQjMxeWhqRlA4RVg2clFGRmxGWGVUV2ZE?=
 =?utf-8?B?R2NGRmVkQXMvV0YvN3h1ai9jc3B6ek81dUZ3YmovM1NYdmg5SGdXM2dyQWl4?=
 =?utf-8?B?b0VsYm1pdlFmTXdoeXNuN1ArS1NWY0dya1VwaGpDTmc4QW53SkdDRTJ3eldx?=
 =?utf-8?B?N2tic3Vlem1FS0VzNTJSaEV0MlFDUnBZa3VTYlpHSVhrcjk1ODJvaTl3aVA3?=
 =?utf-8?B?a0xJS2w5KzFrUE85QWVBL29ZZ1ZnbHFXWWZDcnBJVkgzL3Y3OHZubWNHY2d1?=
 =?utf-8?B?Y2FZUC9Iamp5V0ZQM1E3cWFyWHdDMDZxRFczVVJPUnFWYkFTRHA0QVFKRDJY?=
 =?utf-8?B?ZjZBc1Iza3R5RE41Y01pU3ZCS2FTREI2VW9LbnAxOEdJVmJBaUdiRFBvTDZT?=
 =?utf-8?B?aklnVXBqY3AvM2ZNYVA0Zk9sRm13TzY2V2RFUnZVUHliUkVnTlgzdXljUEVn?=
 =?utf-8?B?UW9GVDBrUmhQOUMyU2h4RENTcFlpL05vSWRrR1lXTUV3cG5LeGRtR2dXQy9i?=
 =?utf-8?B?UGlVSjlXVE5PSHh0Y0lCaXlKZU1tTDQ1LytXTDlaMmFuUVQrY3N5WmpRYmNS?=
 =?utf-8?B?bjA1SS9zWWtGeTVuNjdqSWJuTnRrQzBWTjJrQ2NVcVRxbHk3SWN5MXhMd3Y1?=
 =?utf-8?B?b3pNSG9hSkdsN2NUNTZVVjRBU2tXZnhKcWVESUpUeDhKS25NdXNmOWtXdExY?=
 =?utf-8?B?Yk5Rbms0TVowSkU3aEdKSHZTOHJ3NE1nNlFnUUFZU2prVnNncjAwY016T0Jv?=
 =?utf-8?B?Q2w0cWxxWEhsUm1lNm5kQldsSkhXdzlsM3F1OWlEbFo2bVoyU2dCemQ2UWNK?=
 =?utf-8?B?MS96SXlPczBOZU9zc3B5VUJJYjJpQzhBdlRteU0vUnBNOW1zTUU5MGliTkl5?=
 =?utf-8?B?bWNiTXE2MlFCZzVqcWxEMC94WU9DYVR5Vy9tcFBLNkFOTEp4c05GRDhtS0FH?=
 =?utf-8?B?clUzRGI4aDZJQlZGTlNMd0QrWFMrL2cvMElrZDc3RnFzQ2x6WXFWeHlBTkJi?=
 =?utf-8?B?Skc3Z2YxOFBONk9tODU2eXkrOWIyWng4VExjd1JwSzArcUdjOWRzS1ZWeXdu?=
 =?utf-8?B?d0xaU1hYREFuOEdVUTcwcENnU2ZEWjNaamtlRVpqRE5saUYzUy81SVUzZjh5?=
 =?utf-8?B?WU5qam1BcTR5Z3RnWWF5YWRXbkFDb3lFMTlRNEllUGMvSEdDYzIrVnRCSlFP?=
 =?utf-8?B?ZTVqbFhLYmlNZW5NYzZmUXdDZGd2UUtUM1RTUUNGcnIxZHFrSHM2K0tDZkJS?=
 =?utf-8?B?ZjYrLzNhcXNNcjFzdkg3SktqZmVhZmxLdTBkcjhMaC9vRTNVai96NE9nS1Iw?=
 =?utf-8?B?Njd3K2JOMHZDeEkwTHpjZmc4NEJwMUxrVGUzOG94djcwYUJHZ3NoNkkwN3hZ?=
 =?utf-8?B?dlNIekhoN3c4SnhxemxEVVJzMFlzMFJueWp2YTR2aUV0WUp6L0FFb1JCbVR2?=
 =?utf-8?B?RlpiNjd5eVEwZ3N0QitSU1BFNjVCb3lKNGxnUlNjcGU4RS9SelhJcFgyNDhO?=
 =?utf-8?B?T0orMHlzcjBlWUExbkJLYk1scUZBbmU1STlrMGNwL3l5UFl4L25adVhoYmY4?=
 =?utf-8?B?OXFCaVFDZTU0TzcyNys3M3lCZkRqYmowdjIyWUR2UlZlWnVMMVZNa0RDVFp4?=
 =?utf-8?B?OUMyOXBpaXJHMWMrYWg0NDZ1dW10aUlYS1F1U1ZtZW1zdW1jOUczR0l3bzJZ?=
 =?utf-8?B?Mmc0cXk2b2tjVFp0Sit3cjN1bTlka0hRK3E3UEJCdmxxMHE0aGw4ZVJUbnNh?=
 =?utf-8?B?K09jcGxHQmxCRnladmI1K2o1ODhtZVRXQUVpWVVpaU5LWmhaZnpoUm5EWE5B?=
 =?utf-8?B?WWRmTzMxd0xrNzFkQXp5TjVERHhyZmU0b3cwZ2xYRk9lbDZCOFgxZUFldExa?=
 =?utf-8?B?VzJvYkZ3T2RVNlhoQ2FGRXBRMUZQSFVHZnNzUGVRL0NXc2MvUXVVRG4yOWpM?=
 =?utf-8?B?V1BWNUg5OXRtdHNId3VWM1Ivd0VmTW4wMnlJTzcrazN3cWN2Ty9GTGdObmZn?=
 =?utf-8?B?ZHBTN1h1VjdOSDNuR2p0MGtvWFhaVnB2MEZ1K2xteitQKytKdmVmREMrbnBJ?=
 =?utf-8?Q?vTM3PmF7E9dJiyl49Da6BIE7j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42663961-ecfb-4f26-7299-08dd77d3bbac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 02:02:22.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmSSQudHVbVd0M8PuQluXP5V7mCu2bq4fH7W5C+6uAxkTx+lWxY26t1Av2LlQMKu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572

On Mon Apr 7, 2025 at 2:01 PM EDT, Johannes Weiner wrote:
> The test robot identified c2f6ea38fc1b ("mm: page_alloc: don't steal
> single pages from biggest buddy") as the root cause of a 56.4%
> regression in vm-scalability::lru-file-mmap-read.
>
> Carlos reports an earlier patch, c0cd6f557b90 ("mm: page_alloc: fix
> freelist movement during block conversion"), as the root cause for a
> regression in worst-case zone->lock+irqoff hold times.
>
> Both of these patches modify the page allocator's fallback path to be
> less greedy in an effort to stave off fragmentation. The flip side of
> this is that fallbacks are also less productive each time around,
> which means the fallback search can run much more frequently.
>
> Carlos' traces point to rmqueue_bulk() specifically, which tries to
> refill the percpu cache by allocating a large batch of pages in a
> loop. It highlights how once the native freelists are exhausted, the
> fallback code first scans orders top-down for whole blocks to claim,
> then falls back to a bottom-up search for the smallest buddy to steal.
> For the next batch page, it goes through the same thing again.
>
> This can be made more efficient. Since rmqueue_bulk() holds the
> zone->lock over the entire batch, the freelists are not subject to
> outside changes; when the search for a block to claim has already
> failed, there is no point in trying again for the next page.
>
> Modify __rmqueue() to remember the last successful fallback mode, and
> restart directly from there on the next rmqueue_bulk() iteration.
>
> Oliver confirms that this improves beyond the regression that the test
> robot reported against c2f6ea38fc1b:
>
> commit:
>   f3b92176f4 ("tools/selftests: add guard region test for /proc/$pid/page=
map")
>   c2f6ea38fc ("mm: page_alloc: don't steal single pages from biggest budd=
y")
>   acc4d5ff0b ("Merge tag 'net-6.15-rc0' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net")
>   2c847f27c3 ("mm: page_alloc: speed up fallbacks in rmqueue_bulk()")   <=
--- your patch
>
> f3b92176f4f7100f c2f6ea38fc1b640aa7a2e155cc1 acc4d5ff0b61eb1715c498b6536 =
2c847f27c37da65a93d23c237c5
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev
>              \          |                \          |                \   =
       |                \
>   25525364 =C2=B1  3%     -56.4%   11135467           -57.8%   10779336  =
         +31.6%   33581409        vm-scalability.throughput
>
> Carlos confirms that worst-case times are almost fully recovered
> compared to before the earlier culprit patch:
>
>   2dd482ba627d (before freelist hygiene):    1ms
>   c0cd6f557b90  (after freelist hygiene):   90ms
>  next-20250319    (steal smallest buddy):  280ms
>     this patch                          :    8ms
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Carlos Song <carlos.song@nxp.com>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Fixes: c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block =
conversion")
> Fixes: c2f6ea38fc1b ("mm: page_alloc: don't steal single pages from bigge=
st buddy")
> Closes: https://lore.kernel.org/oe-lkp/202503271547.fc08b188-lkp@intel.co=
m
> Cc: stable@vger.kernel.org	# 6.10+
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 100 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 74 insertions(+), 26 deletions(-)
>

It is a really nice cleanup. It improves my understanding of the rmqueue*()
and the whole flow a lot. Thank you for the patch.

Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi


