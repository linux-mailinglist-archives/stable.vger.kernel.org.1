Return-Path: <stable+bounces-135034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C775A95E40
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B796A7A677C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4A220683;
	Tue, 22 Apr 2025 06:34:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A84135A63
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303642; cv=fail; b=jZcPkNol6ZEQFyBLoUF379NnWUEMppa9EuhiveD7Ou9nKWLl1eOwgQCbjvPbI5rbofbNeWJQfJQzWxm2ppaVmLVj6OcnomGwHt+7GSrV4bdLkw+QaTWnWV2Teg/QAirnhVlBqtT+LQaxr8toHUVCAZc1JtY/+dGdNTLMYGufb2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303642; c=relaxed/simple;
	bh=1df8nHDrkpUw7JythjUD5MzSgCji0gOmN2/IRJtCb4g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Kkgk+f1WidxfdflQ+XzFGtuxL7/zdc+VlmYSml1yWWPu9uNKD5SjysYb9r8L/FSjabom90UEROkhlx6EFeqiiOa2IWb+oZBBne4vCq1pH+I1wWHSam/cp/NrQjqGwLJ1Ob/RY/DdeOMdNroYaAFS6ngCEWqPojB14ax2pubz1GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M0boDZ003183;
	Mon, 21 Apr 2025 23:33:56 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 464bbka97f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 23:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpLKifezsDAxymxLvieM3tgjTDdq2G7jvQYHtwm7KOs1nmW+gt/fu4EQeukNXJoJQ9/Tp9K6VIpfGR+EtfN4fXwYozgSjW6iFhAT99Pf0Fok2Vm4nJaxx+fPkhbc9sP3gX+NHYzMEFNiR0OJNNn0rrbCsxhlzKVC8SfxHszILJNVKm1DvBpkdzaqwX9Y0+nAkAoxtgxF0VPB6al/X/LSO6VSV4Nc14o+wkIlg2m4sD3TVCzhUVV7IkRRYnf94rDhVqK1saSPhSBafzDZKxPSL2RK4wGfWKFZCjdo/mA+l5g7Eu1nnoLWF+nwvMph2HL3PH52vsBtK+ZN92uOsjpFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fy8JR+nBZL5yfm7zMTTTbnZKOypWkTh23AVdLooAKw=;
 b=xoq4CpY9/sD3h1Ch9dNCH0iPTjUSA/iFoHKOb8xsD5UIuKQk+RHjdNtBHjjIkvNEr4hSvyToDBcCstPd5e4c8zDHb5CLYtWKkFzHpXOcKaLN2DjYfnebD7b5AocD93lvO4pATrBLUzCu5O9XqYjrzDThY7InSFtk6qMjAkwG64vTJIm282IBPlHN6MKymbjw29mxkM+ZQbtShr2FhY4xx9lG72o2yHdVsr/6Mpx+U9wFOZyIH0ye9PWQGVZws4dYGCYBhCmoTRlIUU6f11t0t5szBnLB5eenbb3LQHWD3phh+5arqpkBq7CMG9QHIpcDDFLuYBFAggCAB6xuxv0qdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by DS7PR11MB6152.namprd11.prod.outlook.com (2603:10b6:8:9b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.22; Tue, 22 Apr 2025 06:33:52 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 06:33:51 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
        bin.lan.cn@windriver.com, vitaly.prosyak@amd.com
Subject: [PATCH 5.15.y] drm/amdgpu: fix usage slab after free
Date: Tue, 22 Apr 2025 14:33:33 +0800
Message-Id: <20250422063333.3901834-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0275.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::17) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|DS7PR11MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b08521-1479-4aaf-7e12-08dd8167a560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Znl4Z2J5Wlc2K1JQK0M5ZWlLOW1GOHAwQzdENHJaSFoxbjhVNk1IMTFlYzR0?=
 =?utf-8?B?cm9vZlZ2WFg5UGo4eWlWUzRkckVDZGI1cEJmbjhTRnhkdTlldW9DRmtjOHE5?=
 =?utf-8?B?cGljSmV6amQ0N282WXp3YnJ0MnlRZERxU1J5a0tuenk5UjZVdGhVd2xPVE5L?=
 =?utf-8?B?dWd0NTZybDg2WGpjSU1ZVkpZTytvSjVpL25EM0lYeXpqZHRSbjJibjd0Vm45?=
 =?utf-8?B?TkU5SWJtamhoNXZXek9oVmVoTlIxaUdGTUVTcS9tZWo1SkZ6c0xuQXVDVUhW?=
 =?utf-8?B?dGxSYXdvZEZwZkF1WkhSY1QzVXNiV3dZajlOclpHTE8rOFpZMG00eTJGck5v?=
 =?utf-8?B?UjhBcXhpUEE1RDEraFI5ZDJLdkp3eTB5elJReFlkcUtwZTl5VkhnekxDaXZq?=
 =?utf-8?B?VEs5a2VuNUlNVU5zb3MrVFpLaHFGTm1rSWpLMWN1RVFNWlVDN2tpVEg4cHo5?=
 =?utf-8?B?SmRocWo4ejYzY0l4aG1McksvNXFmUVdlWnVHc2hDdkJjTys2dlMvQlFhRWJO?=
 =?utf-8?B?VG1iS2Q0WEM4TUErb3N3aFRKQTNhVExjU1kydzZpblpkYnhNRmdqTkNZSkZ0?=
 =?utf-8?B?aU1ZcmF2QUVTMmpHMzhQNGErSUJQTHMveFp3TEtvbzdpbi9vMWdOY2w2UW04?=
 =?utf-8?B?czVJYmcxWE5OMitVSjk3QWFCUDVjTGs1N1IzOE0wSmpZUk5lTEtZK0pVcjA4?=
 =?utf-8?B?emFLakd4RkQwdmxaZ1pVa2xYaGNjS1lSa3hDZmpHZE5NRldTMkZ5a1J4Y2Zo?=
 =?utf-8?B?QS81MERhYWdCQ1RBRzVBdktsY05MMGJwQ0EzSTlpM2diQTdwckNjdjNyN3hq?=
 =?utf-8?B?ZGpmU2NWRExRbU5pOXp5WDhjWTIzNE1qWm1TM1UveTlYL2xia3JHVjVvQ1or?=
 =?utf-8?B?emFOTUE0SHpCaWh5bUM2Q1RiVkd6TXJBR0h1VDlZb0FyMnlBaGlQdE90Rnds?=
 =?utf-8?B?bE02Ui9hN2Z5U1N5dGJic01QWVhaVkVJOXRnY3B0b2RINzFYMS9nMTBYZ0M0?=
 =?utf-8?B?YzZWZmZLSHdOQ2lPOHUrUEgybHRJOEFucjY2UnBhUDNkNEx6MHppaHhyL2Fo?=
 =?utf-8?B?V1VPQ1JnNk50WVhJRkVGMFkrZHFuMFN5eWRMZEdqakdWbVZVaDhESUV1amZ2?=
 =?utf-8?B?Q1JmUnRhQTJ2NDZMK1Bldi9YOW1aOVRBRktKU2pCdExKTU1ScUMxQW8rejhR?=
 =?utf-8?B?QkdWWmFoZWU1WkMvaEUrd2pnZGZOVzNPc0c4eGRlVXNvQS9hSWNFYjRIKzJP?=
 =?utf-8?B?SG9CQ2FteUNRQjBFQWpJNksrL2ROZFg0Y0hwZWtOTTBzR1hEeGF6a2tERnA2?=
 =?utf-8?B?TkNIL1dkQ002dVZKSzhWbGFyVWZjNk9ZejJvSlB3OFF2UVZmOHdSYXZuekFw?=
 =?utf-8?B?TENhN3JuU1VrVVpXMndGOEdkY0dQS3dmVDYzOUtzaC9GTmxMWGgzbUV6ZTB1?=
 =?utf-8?B?eFY2dTBpendONVdOdm1uK0grWFF4RFhqb0ljVjJaem80R0wrSGgyNHpVYThS?=
 =?utf-8?B?Q25ITmREcEdKOHdydGlVejRlV2lFWCsxQUhoOUVNcDR5cy9TMmIvNFJOTkFB?=
 =?utf-8?B?MWhIN1A4UkVpekdDUVAvNFYxMFJ6N0pSWlBmVnJaM0RaZ3FhUWpYSDZyeUps?=
 =?utf-8?B?VzlwVzVZNGx4OGxPSnozRnIrOUxYVDdFOHVNZzRpcStEQWhxdHZWRy9raEUx?=
 =?utf-8?B?UURTNEtsRDRHZ0lwS2hxZWRtRVJ5YWhjOVFKbzhxQjhvKzZDUjMvdmFHVUdt?=
 =?utf-8?B?bklEUW8wNXdnRG1HU3hUQ0tsT2xVQis0bnFldHUyTXZhb2VKam5BOEFpbmpR?=
 =?utf-8?B?Zm4wYUJGZWJDT1NVTEplcEhZN2NUaWVVS0V3MlhvN2tTNHhoVUhwcUVuL2JM?=
 =?utf-8?B?b2ZKdFZiM0QwNVBvSnBTcXplbUdrZGY2OFczUjUzN2Vta0dPbGRpVlhiSDVx?=
 =?utf-8?B?UVdHYVZvWXlnOWs2NU91cjNRTk5aaTN3MXhaUnNISWQxY2ZpQWlZQWNTL3RU?=
 =?utf-8?B?YXNxaEgzcHpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzRZQklJOFJIeTZ0ZzRCdUpNWUh3YUlhb0NkMGw0d090NlczOTE4R01obGFG?=
 =?utf-8?B?dVdPc25YSTF6ekxHNGR1MGhUSERDL1N5UzlsZE93QXhuS3Y2STRucm8vVHV5?=
 =?utf-8?B?NXNJK2RuR2RXcis0a2d0NWtVTTZkUlZ3OVFHLzJqcWR6aENaelF1dFpaTGx2?=
 =?utf-8?B?elg1dTlNb0JpNk1hQk9qUWU0NUZZc1F2ejk2WnZGblVTODhWV0lqYVpBQlNh?=
 =?utf-8?B?MHEvcVY0clJaUDhKa1hmdmxyKzdrclVRV25Ba0J1bnJPYVFpS0tZUVJzOWo0?=
 =?utf-8?B?Ty9JMjJzelZnQjE1cldBR0h4VjZJZmNvTk45bzBPYXVwek5OMTlqTXhRZmxG?=
 =?utf-8?B?aXdhb3lGWDdNMEVUMVZzc1FwV1BiYzFPZFYycFZiVmNoUE4rc3Q1OS92MEJQ?=
 =?utf-8?B?YTJYNWdMQUFXSmh4WVp3RUlzczV0RmN5SDgxaHJzN2pyeHpoSHAxUEMvOTFu?=
 =?utf-8?B?cnBKY0FmNUR5bG5FR1VxUFlGUW5wUVAwbVlyQW9WVTgyYWY1S09LcEVRSS82?=
 =?utf-8?B?OFM0ZzlrY2EvdVU4N0dDTHhORWxOVFg0dGxwNERjQkF2dDIzMmlvUnpjR2JS?=
 =?utf-8?B?aXViVjNvTE9Edm10NXB3TldEcTJoV3NKcmZwRE9HT3JGQkd0MzdqOXZYRVdB?=
 =?utf-8?B?VjF3MTRqYit3b2hiOStQU0s0WXZTeldabk5tdGFLdUVueDdPeVAzSGlVYk1G?=
 =?utf-8?B?dEZUL0I2ZnJXMXFtNmRYM0NobzdYMG1jNmEwcHJwamRUb29BQmJWSW5SVUVp?=
 =?utf-8?B?VXd4RTNkYTJtQmlPRHlDS3FMZHd6NzVUTkg0M2ZBUHRZZ3dqSzMyVXVlSExG?=
 =?utf-8?B?WFpka05LRWFyakd1cXBnS2hpQmU3U3ovVmFxZDU4NG5DekFDZmZuQjJjSHll?=
 =?utf-8?B?WTQ0UmVPODIrQjROdXRFZEhMdnk3TUJCbUhaNTNYWXNaVkdXN0M3dFV6ZzV4?=
 =?utf-8?B?M0s1RHdyWk1ycCszK0d4dlFqWlQ1eDVQYjByVDFZK0F1ZkpYdmxRSTlqMUFN?=
 =?utf-8?B?TktZWXF0dTVkR1B0SmlRQklZeS90eDgwQzMydlpUQmpmS3J6R1luai9nVi9r?=
 =?utf-8?B?Q3hmaUFCVDZ0b0hKRUpzN0toNldvMDJ5Z0NaZDhwMkZJTjdpVTg0dHpadUFH?=
 =?utf-8?B?Y3ZlRXhuUjVoZ2FhL2xuNlM2cGlWRThkcDV5RUovV1RoTGJaRlFBQm85dVM4?=
 =?utf-8?B?d1FvSFpJSXhna3RGQy9qNDBmeWpseitUbU1zNGRRL29JdHhybHAwWGxINzRV?=
 =?utf-8?B?TE1YVTBIWVRMZW1nZm9qMklmamFaaHNvQkFoNWFXOVdnenQrbldyTDh1MEZa?=
 =?utf-8?B?UW1ORHQzT2hZT1R5SkVkblloZjY2WnhycVBWZGxETjFteUJrT3JjUkFJQWtO?=
 =?utf-8?B?VTUzM1pYeWE4WHppS0pYNlhmYU1aMEZmemQ2RnFuZVVPRXVHdlZLMm1qRnEx?=
 =?utf-8?B?MjVlUDNMa1J1Ykd0R0Z0Wm1kQTlxWmRKT3NPSmducDVJV3I2aVdTakc0OXMy?=
 =?utf-8?B?aFFUZG9OSGc2RGkwTlhIYUpYQmZJTEE3a0g3c1lOS1RYazdJMXc0SWNmZWM5?=
 =?utf-8?B?c0M4MTVjK0RHK3lSeWhJL2pHZ0tTZEM4NmFuODJXUTU3Z21OVGpnQ3lFcHBV?=
 =?utf-8?B?ckFBdzhUUEJHeVVHNjBLWm83Z1V0V3FobFEvZGxLK09Lem1VaktnMXZLNXh4?=
 =?utf-8?B?QVJkZTlBKzJDczhyUjFldEM4RTU1MHVNN0lnb1hNT2tOMkEwSFdSLzFuNHZ3?=
 =?utf-8?B?YkJjaUpKUWpSVk11dmZlNGNPUFNEUi80ZnJ3UTU0Y1R2VHB5bkVSTTZPK3A0?=
 =?utf-8?B?dHdKMGhHNi8yR0tobUp6dmNvQUlxcEY3T3NWUjZJN0JUTXhOSE96WHZaZlpi?=
 =?utf-8?B?OVVrTHRYRXFFNjIwSTgrbWJqRkcyRHNKN3Z1ak42K3k1QWRsMjI1UzFTcmto?=
 =?utf-8?B?R0d5d0xjOFkyUm1IelM3bnZLZVlDb3NvNCtqUTdwNVNUckVnS0JpbHdFdytm?=
 =?utf-8?B?NDFFakFVVjhTRVZWWUxnVUhDV1FjUGU0VUN3cy9lbmhGVklHZGJPNGpLWUxp?=
 =?utf-8?B?MXYycmVRZ2RUQjhsbnJyWnpHTTVzMlFWMkNSL1V0Z2ZMbnpkMGZjWk9oUnNt?=
 =?utf-8?B?UFZPS2dqM2pkaEd2SUJuV3d2dnEzMUdOR2lYV004VjlrTklkUXNUamM5RXRC?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b08521-1479-4aaf-7e12-08dd8167a560
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 06:33:51.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSqiKGhyQWk1ZlgP6CIi54Rrnqxfd5wE7TGKG/2A7eYkzacwJYcEx8w9tpfDeQbVSfOvwXgqjnziFXLLic0DcIRH0qaexA3iDKWNjM5+MuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6152
X-Proofpoint-GUID: K1dBMacq6eSzqnSz_gDr001dCQBvpUWw
X-Proofpoint-ORIG-GUID: K1dBMacq6eSzqnSz_gDr001dCQBvpUWw
X-Authority-Analysis: v=2.4 cv=P446hjAu c=1 sm=1 tr=0 ts=68073854 cx=c_pps a=clyc6YhGvfCRRXf4btgSWw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=ZxmLuWR_iMKEpw-oEckA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_03,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504220049

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

[ Upstream commit b61badd20b443eabe132314669bb51a263982e5c ]

[  +0.000021] BUG: KASAN: slab-use-after-free in drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
[  +0.000027] Read of size 8 at addr ffff8881b8605f88 by task amd_pci_unplug/2147

[  +0.000023] CPU: 6 PID: 2147 Comm: amd_pci_unplug Not tainted 6.10.0+ #1
[  +0.000016] Hardware name: ASUS System Product Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1401 12/03/2020
[  +0.000016] Call Trace:
[  +0.000008]  <TASK>
[  +0.000009]  dump_stack_lvl+0x76/0xa0
[  +0.000017]  print_report+0xce/0x5f0
[  +0.000017]  ? drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
[  +0.000019]  ? srso_return_thunk+0x5/0x5f
[  +0.000015]  ? kasan_complete_mode_report_info+0x72/0x200
[  +0.000016]  ? drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
[  +0.000019]  kasan_report+0xbe/0x110
[  +0.000015]  ? drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
[  +0.000023]  __asan_report_load8_noabort+0x14/0x30
[  +0.000014]  drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
[  +0.000020]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? __kasan_check_write+0x14/0x30
[  +0.000016]  ? __pfx_drm_sched_entity_flush+0x10/0x10 [gpu_sched]
[  +0.000020]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? __kasan_check_write+0x14/0x30
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? enable_work+0x124/0x220
[  +0.000015]  ? __pfx_enable_work+0x10/0x10
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? free_large_kmalloc+0x85/0xf0
[  +0.000016]  drm_sched_entity_destroy+0x18/0x30 [gpu_sched]
[  +0.000020]  amdgpu_vce_sw_fini+0x55/0x170 [amdgpu]
[  +0.000735]  ? __kasan_check_read+0x11/0x20
[  +0.000016]  vce_v4_0_sw_fini+0x80/0x110 [amdgpu]
[  +0.000726]  amdgpu_device_fini_sw+0x331/0xfc0 [amdgpu]
[  +0.000679]  ? mutex_unlock+0x80/0xe0
[  +0.000017]  ? __pfx_amdgpu_device_fini_sw+0x10/0x10 [amdgpu]
[  +0.000662]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? __kasan_check_write+0x14/0x30
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? mutex_unlock+0x80/0xe0
[  +0.000016]  amdgpu_driver_release_kms+0x16/0x80 [amdgpu]
[  +0.000663]  drm_minor_release+0xc9/0x140 [drm]
[  +0.000081]  drm_release+0x1fd/0x390 [drm]
[  +0.000082]  __fput+0x36c/0xad0
[  +0.000018]  __fput_sync+0x3c/0x50
[  +0.000014]  __x64_sys_close+0x7d/0xe0
[  +0.000014]  x64_sys_call+0x1bc6/0x2680
[  +0.000014]  do_syscall_64+0x70/0x130
[  +0.000014]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? irqentry_exit_to_user_mode+0x60/0x190
[  +0.000015]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? irqentry_exit+0x43/0x50
[  +0.000012]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? exc_page_fault+0x7c/0x110
[  +0.000015]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000014] RIP: 0033:0x7ffff7b14f67
[  +0.000013] Code: ff e8 0d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 ba f7 ff
[  +0.000026] RSP: 002b:00007fffffffe378 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  +0.000019] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffff7b14f67
[  +0.000014] RDX: 0000000000000000 RSI: 00007ffff7f6f47a RDI: 0000000000000003
[  +0.000014] RBP: 00007fffffffe3a0 R08: 0000555555569890 R09: 0000000000000000
[  +0.000014] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffffffe5c8
[  +0.000013] R13: 00005555555552a9 R14: 0000555555557d48 R15: 00007ffff7ffd040
[  +0.000020]  </TASK>

[  +0.000016] Allocated by task 383 on cpu 7 at 26.880319s:
[  +0.000014]  kasan_save_stack+0x28/0x60
[  +0.000008]  kasan_save_track+0x18/0x70
[  +0.000007]  kasan_save_alloc_info+0x38/0x60
[  +0.000007]  __kasan_kmalloc+0xc1/0xd0
[  +0.000007]  kmalloc_trace_noprof+0x180/0x380
[  +0.000007]  drm_sched_init+0x411/0xec0 [gpu_sched]
[  +0.000012]  amdgpu_device_init+0x695f/0xa610 [amdgpu]
[  +0.000658]  amdgpu_driver_load_kms+0x1a/0x120 [amdgpu]
[  +0.000662]  amdgpu_pci_probe+0x361/0xf30 [amdgpu]
[  +0.000651]  local_pci_probe+0xe7/0x1b0
[  +0.000009]  pci_device_probe+0x248/0x890
[  +0.000008]  really_probe+0x1fd/0x950
[  +0.000008]  __driver_probe_device+0x307/0x410
[  +0.000007]  driver_probe_device+0x4e/0x150
[  +0.000007]  __driver_attach+0x223/0x510
[  +0.000006]  bus_for_each_dev+0x102/0x1a0
[  +0.000007]  driver_attach+0x3d/0x60
[  +0.000006]  bus_add_driver+0x2ac/0x5f0
[  +0.000006]  driver_register+0x13d/0x490
[  +0.000008]  __pci_register_driver+0x1ee/0x2b0
[  +0.000007]  llc_sap_close+0xb0/0x160 [llc]
[  +0.000009]  do_one_initcall+0x9c/0x3e0
[  +0.000008]  do_init_module+0x241/0x760
[  +0.000008]  load_module+0x51ac/0x6c30
[  +0.000006]  __do_sys_init_module+0x234/0x270
[  +0.000007]  __x64_sys_init_module+0x73/0xc0
[  +0.000006]  x64_sys_call+0xe3/0x2680
[  +0.000006]  do_syscall_64+0x70/0x130
[  +0.000007]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  +0.000015] Freed by task 2147 on cpu 6 at 160.507651s:
[  +0.000013]  kasan_save_stack+0x28/0x60
[  +0.000007]  kasan_save_track+0x18/0x70
[  +0.000007]  kasan_save_free_info+0x3b/0x60
[  +0.000007]  poison_slab_object+0x115/0x1c0
[  +0.000007]  __kasan_slab_free+0x34/0x60
[  +0.000007]  kfree+0xfa/0x2f0
[  +0.000007]  drm_sched_fini+0x19d/0x410 [gpu_sched]
[  +0.000012]  amdgpu_fence_driver_sw_fini+0xc4/0x2f0 [amdgpu]
[  +0.000662]  amdgpu_device_fini_sw+0x77/0xfc0 [amdgpu]
[  +0.000653]  amdgpu_driver_release_kms+0x16/0x80 [amdgpu]
[  +0.000655]  drm_minor_release+0xc9/0x140 [drm]
[  +0.000071]  drm_release+0x1fd/0x390 [drm]
[  +0.000071]  __fput+0x36c/0xad0
[  +0.000008]  __fput_sync+0x3c/0x50
[  +0.000007]  __x64_sys_close+0x7d/0xe0
[  +0.000007]  x64_sys_call+0x1bc6/0x2680
[  +0.000007]  do_syscall_64+0x70/0x130
[  +0.000007]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  +0.000014] The buggy address belongs to the object at ffff8881b8605f80
               which belongs to the cache kmalloc-64 of size 64
[  +0.000020] The buggy address is located 8 bytes inside of
               freed 64-byte region [ffff8881b8605f80, ffff8881b8605fc0)

[  +0.000028] The buggy address belongs to the physical page:
[  +0.000011] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1b8605
[  +0.000008] anon flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  +0.000007] page_type: 0xffffefff(slab)
[  +0.000009] raw: 0017ffffc0000000 ffff8881000428c0 0000000000000000 dead000000000001
[  +0.000006] raw: 0000000000000000 0000000000200020 00000001ffffefff 0000000000000000
[  +0.000006] page dumped because: kasan: bad access detected

[  +0.000012] Memory state around the buggy address:
[  +0.000011]  ffff8881b8605e80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[  +0.000015]  ffff8881b8605f00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
[  +0.000015] >ffff8881b8605f80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[  +0.000013]                       ^
[  +0.000011]  ffff8881b8606000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
[  +0.000014]  ffff8881b8606080: fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb
[  +0.000013] ==================================================================

The issue reproduced on VG20 during the IGT pci_unplug test.
The root cause of the issue is that the function drm_sched_fini is called before drm_sched_entity_kill.
In drm_sched_fini, the drm_sched_rq structure is freed, but this structure is later accessed by
each entity within the run queue, leading to invalid memory access.
To resolve this, the order of cleanup calls is updated:

    Before:
        amdgpu_fence_driver_sw_fini
        amdgpu_device_ip_fini

    After:
        amdgpu_device_ip_fini
        amdgpu_fence_driver_sw_fini

This updated order ensures that all entities in the IPs are cleaned up first, followed by proper
cleanup of the schedulers.

Additional Investigation:

During debugging, another issue was identified in the amdgpu_vce_sw_fini function. The vce.vcpu_bo
buffer must be freed only as the final step in the cleanup process to prevent any premature
access during earlier cleanup stages.

v2: Using Christian suggestion call drm_sched_entity_destroy before drm_sched_fini.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b11a98bee4f0..6ed4b1ffa4c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4008,8 +4008,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
-	amdgpu_fence_driver_sw_fini(adev);
 	amdgpu_device_ip_fini(adev);
+	amdgpu_fence_driver_sw_fini(adev);
 	release_firmware(adev->firmware.gpu_info_fw);
 	adev->firmware.gpu_info_fw = NULL;
 	adev->accel_working = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 9f7450a8d004..6d1516c357f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -220,15 +220,15 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
 
 	drm_sched_entity_destroy(&adev->vce.entity);
 
-	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev->vce.gpu_addr,
-		(void **)&adev->vce.cpu_addr);
-
 	for (i = 0; i < adev->vce.num_rings; i++)
 		amdgpu_ring_fini(&adev->vce.ring[i]);
 
 	release_firmware(adev->vce.fw);
 	mutex_destroy(&adev->vce.idle_mutex);
 
+	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev->vce.gpu_addr,
+		(void **)&adev->vce.cpu_addr);
+
 	return 0;
 }
 
-- 
2.34.1


