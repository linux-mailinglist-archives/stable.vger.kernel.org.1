Return-Path: <stable+bounces-125852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A5A6D4F3
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF5116AAB1
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61972505A5;
	Mon, 24 Mar 2025 07:21:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23923209F2D
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800887; cv=fail; b=YZoSYrAEWSoiVRfuLhpT/6nEC49BuVKn4dbFwKLtan1pauh3Rf25TwVZn4bWMtfBQ7BiYpsWMsvuBhmLwohs+7Il1d4kuQ0FUSGVsD4uUh8jzlxt0Bn90/PYD2GhShGgDYVet1OJyGWO+F7zp9nXGVzP7XG48d+Y2AFP5p4i5OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800887; c=relaxed/simple;
	bh=CXfL4KEyBnZeu+Utg3OAEY4ZWBAomZMBriZjZ+jgOQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DwC2jShkxAmFOeXj89KlaF4TPx4O5Oop4IasDGgQd1oipwJHzKk9r0WETl16rcu24k2S9i8KaqqQwwyCcxjZVRLhREHngagwXYK/8G3PyHqjYQB+3PRazTM6EEx4NsDza4BpSDduyTcJw2BColJz2qzNg4U4PWfJr9kGv2fnDog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O5Z8YN014216;
	Mon, 24 Mar 2025 00:21:24 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hrg41me6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 00:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhytyK818C8Ctzsx4VdY/54+GOWlkIk7sxXwrJX6oBGlvGK9rODLtIeKVoAtcR53AGOCSkk57oK3nOBdKuUqbr0rcAjwhBX9vanrCqwzIkTe856H2CVHnBZQrnFgLhERORoK8zh0fSz0vr7yu/+FXxF6sOfwh0gsIqC2Me3jphI76WJDJJ2y0n+LfxSHrlUi/CIZqQ8kNYWt2tFWDycqPTlZJcgw2sXatBlFjoBKiKehLXL+6lOBoJdxjO9IL3C7277oCmG4u7yVjRufgxJN/qKHm0nPel2vOH2hC5ozAoISpTNtIEx8AsLSFUD8e3uPIckiKPg39ZS1p8zpERDOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNy6fEEpgcV408RwchjwGasECmTZhXQtO84mvGLlrIE=;
 b=kDhnRyI3uhwJiMwybaK86v89K9jq/WwfQfsrfVLoCcyceLjVk+YE99GnKm4W0EQ9IJeqhjwM+gBwkaAJC61YwZnwjYcQWGkHvXoLqDj3xaeyS7gpBX/smxcF3tF2odVNkG9LEBAMAdo5kCBtqcIqLDBNJxD+tZy+toDHw4gNvgNFbVN7ep7Jw0C3OTs51cN+dJxZ/z3/Kjqlciw+twXEO2wVAGxSYAtPqU8imoBHE0/oaYouC4cdoVi1pnrb9JGTDYBf9f04runabISFZG+HvcU8GH6vDYAK0FYmprToEO7xzGFX00+UyElSODDI7IRiTvnHrVO5wx3HFH4cTYy+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:21:22 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:21:22 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: regkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, ebiederm@xmission.com, keescook@chromium.org,
        akpm@linux-foundation.org
Subject: [PATCH 6.1.y 6/7] binfmt_elf: Only report padzero() errors when PROT_WRITE
Date: Mon, 24 Mar 2025 15:19:41 +0800
Message-Id: <20250324071942.2553928-7-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250324071942.2553928-1-wenlin.kang@windriver.com>
References: <20250324071942.2553928-1-wenlin.kang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: e26adf4f-1a33-4268-b50d-08dd6aa47aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cSuIcSZeB+Crh/iFeTmI0oxagYmkmr4MqfvNkQvMLXGhzm42GDvTVSUxSWT6?=
 =?us-ascii?Q?mNfkFzPTKW3nCKUdobpKEbHaGQregXcR6Q6Km1Quqi9om3miG9k2APDqEqDL?=
 =?us-ascii?Q?alNhXlPmi71sSgXQxZ7XovSaKwPQfZxtqHLBi7t581hWEbqeJoWZsJmcjSls?=
 =?us-ascii?Q?SXZBbt8dnYeYOfwVG3MAC9k+E6zVhJcaZNA9PtK+oaxHTr+V+L2H3aMORk5F?=
 =?us-ascii?Q?jJBFGhBNM9IYFdo89tttQ9+wRvcYMt68Cme6hRXrz97XD2Qt6n9UC4aJEBl7?=
 =?us-ascii?Q?e24jUp+F4EWwgrswRoOtVTW5i2+9YHW4rcA2z4a8AUvO/IgxA7736dxzBk/r?=
 =?us-ascii?Q?pBVu25briiJ5U50qOz6lz91dtpDFgr79XT4fHBvel0ZlDz4OAWTwEBeOavUQ?=
 =?us-ascii?Q?n1QuPNOXopO5kZVyJtGRBUrNdHQVejpboI9O4/CV/a7ZNv3ADc8sF5z47egd?=
 =?us-ascii?Q?45S191A83cgaxsZP1NUMwPM7DRn2mzGxhcnTZUTsW53FfyMMWziZGAaWYRY4?=
 =?us-ascii?Q?el3jMTXWnwSFn3x2FMj4f2gId6w5HqZTEB/n3iwiiBQURQy+CwLXDuzeX+y1?=
 =?us-ascii?Q?bHT/RqnPgZEhFNWMVwux9AtVRfZRuoQQ/4S1LxTo8mPgBuB8KQNoOFvT/bCw?=
 =?us-ascii?Q?vUFv2a0pJrIkO06bIjxoYMvq2bim+tQ0PLMd49SxCUbyvaMXhcgFLoJHe8Bt?=
 =?us-ascii?Q?neSKxq9sIWNYp/rsDzzOlA18NCALtkhmMR+A0b2ykQ5u2aNKJ++Fc/RNSXhX?=
 =?us-ascii?Q?pXUgssNmtrgJhLIS3dj/7dPDn5grPjQ5WRFXdjHYZrdIzeit0LTvwq4u21SC?=
 =?us-ascii?Q?cd4YUeUxp+qEV/hAFBXncoiVcWN2y9pjRknK5fUMpL3xyZPraPqX+Eo8QTXJ?=
 =?us-ascii?Q?Pl99UlWTHmCqoadCcGUzhUcOe3V22oblwbFAhtrseyBgKehsh9GS5q6Z8wB4?=
 =?us-ascii?Q?pMnqeyu5/1r5ctGr6aL3MaJDMR2iSs7mi3hjkasLk0vsjbGMIbLeIJCEv9UE?=
 =?us-ascii?Q?Ttcvc/xH44OGYPpg94dY44aWzlhuDYRrGQBX2SYE0GD1jEjuUOSC6InrcYXr?=
 =?us-ascii?Q?iIfbJRPCXh1gIfqZfGzlfsRrkxIHczmZBRtwyxdLZBf1Qd8x+BIAI24i+WIU?=
 =?us-ascii?Q?c2TrK49ROH1FIEhy+ljCzYhItWLrHNIfBvqo+MjGfUBrWMZBNoRCD0+LiFi2?=
 =?us-ascii?Q?xMUPJJhXKsmq/i/9uJV52As5MwdaE5neBUj9lkEbklQJXivY33NABSAhm/Ji?=
 =?us-ascii?Q?PRaertdtPfik4pwq/PbVIz674x0ISsy9Noao8jc3YVy2cuF64Kq2RdMKEK8z?=
 =?us-ascii?Q?OePfChzEQcGIPxiHzbwPPdlG5Ov2YKKIbvekIcWEs1B524juRxVm1TwDxKb1?=
 =?us-ascii?Q?SES75I/T7kYW4d4wIa5ZZmH5ZVkZJj7Xwaarf+6EJQRekEhxfH7kjLktMj/I?=
 =?us-ascii?Q?Ej9zpQlb2FQPtYI0f7oWHbrWsDArCep1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ElqtR0ziYHk+Nlo5CPPkFmSwUvQfpvj7/dXNutgAhK+pPNujs5zoo7A2LOrC?=
 =?us-ascii?Q?8Ak6pgxeIlFWf2zdmVRVXL6WistiOxtnkVn3IfuG/5Oo0W5jkWt/DJVBNmSZ?=
 =?us-ascii?Q?YIoidY7ES2ApP1CVxcRgtZx+w2YZ9dm3qQNqOOur+mqJd9hUjjvD1gbBqCT0?=
 =?us-ascii?Q?xSPyxM6ppeD56GEnpv4ts8TkGPPKp6DMRXh8rHQhO/3tPK1FW05oMZ8eC2vo?=
 =?us-ascii?Q?PVI00oQcvdiN0HcJhJhQJfurTJeMYf2NjSX1kr51lztJbIZpo0kIeQ151ga9?=
 =?us-ascii?Q?QuQWbjOnnGb409+JyAKRylxK45ThqUYRAHS9Bj00pECo3smf1iz8vQDvwjNm?=
 =?us-ascii?Q?dyxNsfTy7wff14F0JIxq8xj11olC7ojZX3WgznGnolY82mOr1iEXSw7jBhKX?=
 =?us-ascii?Q?pnFrpprIGXC0mXoRlVExv4EYbG8PlRrq0KIhtAejgUjFjnShlqvsYTr/j6dr?=
 =?us-ascii?Q?nPq8L3prVeAgOLfUMqLALn5L1VHKbElEqncOC3yQrQW1RwaqQNgR/ypNfGqj?=
 =?us-ascii?Q?1ausuux/qAZlgGtqO+HLwDxwRLJo12Sd7J8E/sfKv+GY3PFwMP2ARHfcrFEp?=
 =?us-ascii?Q?WwRpCrC7cbXRG/frdqitCbu6pMgk+bDvzjwFifPSl9A9DSy6An+EydmO1Fyc?=
 =?us-ascii?Q?wQ5kUYb2qsmwJ6bp3jw2tf/8IdDjDjsX1nzxoL61dKqbXUEWPDN8B1KYnOAU?=
 =?us-ascii?Q?unwGjul8o92DVm2acbG9efkgcGVm7ZlnD1qBRbPN5+rW9MJo3x4Xp5HOof7s?=
 =?us-ascii?Q?MAZxZLiYnUwuRIkUyqzOKCCREsNnb6QRwPMPDNgIB4gOHBMU8iV6DOZd4UDl?=
 =?us-ascii?Q?CFe/j7UZlIAHVrd3oEhc4wcuFFlvWexySx0aMAjDWd9GuuJqKmSqSiK9pW7V?=
 =?us-ascii?Q?cEwTRXmIbH1xXVPN7Si7hWshbOagQ81BJWh9QC6OXf4cOqD7HuxwWN6spiuk?=
 =?us-ascii?Q?YAAbODiEAkG9R3lOoYeQV1Ha5bU+z8dr6nvXRXD1IoGpolLZ0CIp3NiUq7Ow?=
 =?us-ascii?Q?1HDBzFQrvQ3fk5Xhw0V0EZUtu0krxlKbj/lktPeV90Nl0PMfw3xEJaGuDZAH?=
 =?us-ascii?Q?wdI0FegKriKCogr7I43/GrtlyWbtwO3PFXsnTWY4wcJTQEWtkw/7EOUWVgDB?=
 =?us-ascii?Q?7YPoI7LmbP84WjNz05xGST+tF8Qlqx7mUsZqaRu9iZpo/8q98ypqUYLs7eUn?=
 =?us-ascii?Q?wht+rta8mN+CJ9A3oltbJQbweTh9SQjThINrzXVlKWJOuSB7ZiYsy3/HEOSH?=
 =?us-ascii?Q?zSfrTgg+0Q/XFaBAlcl7JK64o5tT+x3jAuZmMOdYcQL83zAEfsP/6AI8b/Zy?=
 =?us-ascii?Q?q8KhyjhyPUHa4DDuOObAVMSmQeL1LrvpOvY9Z7DgDkNgH/akIHhum2M75kVp?=
 =?us-ascii?Q?A1UtU4FgrEHxbmc2dOqUHPJKRaEO8ouITFb7RxgSuzOgXYJHPzuLqQiNi6Tg?=
 =?us-ascii?Q?lvD/RdU2kWea/C8e3BHtrguubpAJeWS54TK8CKd7Z+3xpr3xDhw9W6H7mtVG?=
 =?us-ascii?Q?059K0gn5NasjX1CgT3QE2I6jG6r08TSyFuTnb2+HoGOPbFJzo5rsuUZ0sOpN?=
 =?us-ascii?Q?B2Kkp24jIoj4cpmPUrBvQaYsLztG2nmUptGT1sp0tCZvTn/jCVaJO56YxS6v?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26adf4f-1a33-4268-b50d-08dd6aa47aa3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:21:22.2792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grsHmay9rJFM6w7KtuwpwDRfsPxvAWFXcY6ozGbPs7Q7vT0H/Y/WfQnFOaIcAijt1vbWE6prNSKW6tuHATYxOmUa98oPoNk6nymiHSyOqBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-Authority-Analysis: v=2.4 cv=HZwUTjE8 c=1 sm=1 tr=0 ts=67e107f3 cx=c_pps a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=PtDNVHqPAAAA:8 a=drOt6m5kAAAA:8 a=37rDS-QxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=EtZhav-2TRoc92nNA6AA:9 a=BpimnaHY1jUKGyF_4-AF:22 a=RMMjzBEyIzXRtoq5n5K6:22
 a=k1Nq6YrhK2t884LQW06G:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: q9xpSkgWwjICJDOqkZnvkQ-BgfrFTBFH
X-Proofpoint-ORIG-GUID: q9xpSkgWwjICJDOqkZnvkQ-BgfrFTBFH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240053

From: Kees Cook <keescook@chromium.org>

commit f9c0a39d95301a36baacfd3495374c6128d662fa upstream

Errors with padzero() should be caught unless we're expecting a
pathological (non-writable) segment. Report -EFAULT only when PROT_WRITE
is present.

Additionally add some more documentation to padzero(), elf_map(), and
elf_load().

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-5-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 fs/binfmt_elf.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index ba1ef7e3f9f3..73e9e6131732 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -109,19 +109,19 @@ static struct linux_binfmt elf_format = {
 
 #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
 
-/* We need to explicitly zero any fractional pages
-   after the data section (i.e. bss).  This would
-   contain the junk from the file that should not
-   be in memory
+/*
+ * We need to explicitly zero any trailing portion of the page that follows
+ * p_filesz when it ends before the page ends (e.g. bss), otherwise this
+ * memory will contain the junk from the file that should not be present.
  */
-static int padzero(unsigned long elf_bss)
+static int padzero(unsigned long address)
 {
 	unsigned long nbyte;
 
-	nbyte = ELF_PAGEOFFSET(elf_bss);
+	nbyte = ELF_PAGEOFFSET(address);
 	if (nbyte) {
 		nbyte = ELF_MIN_ALIGN - nbyte;
-		if (clear_user((void __user *) elf_bss, nbyte))
+		if (clear_user((void __user *)address, nbyte))
 			return -EFAULT;
 	}
 	return 0;
@@ -343,6 +343,11 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	return 0;
 }
 
+/*
+ * Map "eppnt->p_filesz" bytes from "filep" offset "eppnt->p_offset"
+ * into memory at "addr". (Note that p_filesz is rounded up to the
+ * next page, so any extra bytes from the file must be wiped.)
+ */
 static unsigned long elf_map(struct file *filep, unsigned long addr,
 		const struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
@@ -382,6 +387,11 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
+/*
+ * Map "eppnt->p_filesz" bytes from "filep" offset "eppnt->p_offset"
+ * into memory at "addr". Memory from "p_filesz" through "p_memsz"
+ * rounded up to the next page is zeroed.
+ */
 static unsigned long elf_load(struct file *filep, unsigned long addr,
 		const struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
@@ -399,8 +409,12 @@ static unsigned long elf_load(struct file *filep, unsigned long addr,
 			zero_end = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
 				eppnt->p_memsz;
 
-			/* Zero the end of the last mapped page */
-			padzero(zero_start);
+			/*
+			 * Zero the end of the last mapped page but ignore
+			 * any errors if the segment isn't writable.
+			 */
+			if (padzero(zero_start) && (prot & PROT_WRITE))
+				return -EFAULT;
 		}
 	} else {
 		map_addr = zero_start = ELF_PAGESTART(addr);
-- 
2.39.2


