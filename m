Return-Path: <stable+bounces-230437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFBVMqLxxGnv5AQAu9opvQ
	(envelope-from <stable+bounces-230437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 09:43:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 415E13318A5
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 09:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F8E731001FA
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 08:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BCD3B7B94;
	Thu, 26 Mar 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rgdeJ+Gq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C33B8D7E;
	Thu, 26 Mar 2026 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514206; cv=fail; b=ZgzDi7gWZTddzZL9kwK2kgduTjHvHPR2O11sBFFznafqkyOJYFug0rlILPZMjCNnUTh/gkQsjTliwswHLCYUnYVLk+d08YB1/24+NmV9wZtlIZZp6h1YLmAJNU0WOlP8oB713x2T1u16CQH+BrYSZVhGBNZibtREeWqKpjp13TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514206; c=relaxed/simple;
	bh=48i0pAdoCCxy5O09jEHvsBf0wxabneaT0tk1lwBe/p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VDZwpLdobGSsmTwKGu++CsxIKArgEThJeXgVHnkGP3c+5P/TfZNLfxW6dWnD/YaLNnYVo/ZwjalSgeOaRWIp+DOI8BCV/PQXyvR/TdShI00sKCv2jseSzyhq3YeOtpln1X6VoZd3bzQkwtpAG2X/YT1qNxdt19NHswXpFcSKd8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=rgdeJ+Gq; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q5tY783254232;
	Thu, 26 Mar 2026 01:36:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=3SM+NIariRpcaLI0B0mvChlztVVSNmTS8X3y4DpeDjc=; b=
	rgdeJ+GqUEKH+76nTbx4+jHKrzv79Et5qZZVRe8cx0eEeB0P/8dn1rgthacyytI+
	nled4gLCJIkawL7bsA9pi5Zx/LCNwyXxTwsoBKGO9siZ+UVH1sZEQZdF9Vemf9jQ
	mPBfAvju4H5jkYpqlgyG4vJ6XreFoxF+dE82YpE8o4YeZQEyAJ+GmLzx3g/AoN6b
	ZDqKpiosGkE6KqCnAoQvT70zjv48ZWS/TLZHN1eYJUHLa09qUJRLZqeuUZ6nwzb9
	GdYMDY6oXPcpHRuoci6YM6WRQNAOxEurocOCD8WmzFlVybuGxJ5W7igqlrDuLBMd
	FW1/AJMpRnYxX8ib0gnhqg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1tucwwt0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 01:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuzcXwyGVUUgQs4QPeHVpuhDzd+LClvOgeytYu1zLpNa2IZwcaNQ7WBTihGvv7vsN7/5yVE1nSgF9wlS6RRh2dJYB94LXXyyhU0H67HS6KLtDf4DiP+aA7rKY/d4O5VZDuaW21xC8NGZ9DOc8nnVOkNBHga8LWeBu8JCB1j9IZrxYa3jzICpb/7kLrmKKQTKSPojFYgfAUnBGUjaR+ppyZtNBl+4PLXN0sUV/FIES4tp5J6WqmhHIWE1sscJs3MzFQ9k7uaS49Smq8GP7466r/XBkkraJNOgZMiGP3w/LRXKDoOt5cqbJifODOC5fW3Hi0PzEkT2zgNz8p7nmttnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SM+NIariRpcaLI0B0mvChlztVVSNmTS8X3y4DpeDjc=;
 b=dmYCk/MRUZTlE6r8Byn+XmN0EHoWVmk8+hjQsJ8DRWbaVvGPTKhrsMeglRlLiizdDfKbZLrUGF1RSV0J0hI3iFPbdle87GWEhG+aFotkvxTng3GDu5SA3zzFsRx0GSYxvtTF10CDwc6L14CR8nUzXUEriTao/PMDEVTbuU3o7al5BzkZlKG765Zw33BPVUvIVA9S1cXjyqz6BFr2rZfElvXG+6u8lCRDHJR4E3IDNDoRr3/fYm7x8wa/TL+k8QeKTLjtnCfHYyrQmOY8KZ6sgaUP+Pd2R1034REa59riGs78S1rh4+56Z015ddkxTenDV0Pe3IrjYmX/uuaE00K2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB8364.namprd11.prod.outlook.com (2603:10b6:610:174::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 26 Mar
 2026 08:36:03 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 08:36:02 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, linux@roeck-us.net, lukas@wunner.de,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v11 2/2] PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock in remove_store
Date: Thu, 26 Mar 2026 10:35:34 +0200
Message-ID: <20260326083534.23602-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326083534.23602-1-ionut.nechita@windriver.com>
References: <20260326083534.23602-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::24) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CH3PR11MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6dc00f-b154-4d5c-dbf3-08de8b12b6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|52116014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H4zJAaQBAeP0TnHDUMFeLVlJjtT3UaqGCY/DkC31OZHnhlr3KbIWuxMjiiAFk8yEdL1QET+lLXoQ8R/czBpyohybhIrzlstxoMbf2XUJHlbu4hcTfykKrAbmcQYh1vumSnvdeXCnQL3kcbt/bXBmWnc8oTQmg3rhPEZ3PhB/QhcaeXOuxnNb12FCQYbpx1OBQLEZXzA5hgWzME9RGrt6bRcoLitkfkA4XhWTuprsCyLPEBDjY8n9ISW/pnqOHAel7hf3YVOBSlMY90bZLHMJOXNKAIsV8UP87XrQWeKDFNsTPe7H0efMyWOtoUPsLQoNEVfm3bkgXc5o5rNv0/HQwSlINh0MD/BXZsL91cp9tFXOyj3RGRMWU3C/YxtV8PkZ1qRu7Ok7yA0RzftsI2zntHNgJUhR2yWZnKHaDTpTgng3kA87bBXlHl87dJau5U1NOBuNHO+cjQL2NIkmYyUw36hv5LXxizUOf6Qv5qhqxQh5qDxGLjxisWRWnknk6PkoXo2xJ57WmAwt8mojCn7JWR4C4LtoLB7VtbUH9E7JqBbxFIV4jv0D34i1oo/pXM8O5LPtLXXUVEiDh6yYpvlc1vv8J4/GCzECrhg6bB+yq5lNrLG4VT1rU09Hf7+uusHV5aeKJkCM4MfMWv5dJfVxUWL1qWrcoWQpojSgxzNIQ/181mbFGNWiqOkXFE/pNkz5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(52116014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UfDVR9fnNSCeWXYWbqBIGtbyV3lBgmbFZ+l9BVeF7zZuGSQn/yD8TcNBfJCI?=
 =?us-ascii?Q?Q126AFvaXRrebLAL6J93iM9Apg87Wvsqs+VI4/FMbceyzZ+ocyhiop0cg6G0?=
 =?us-ascii?Q?qDG9MXeYAD87oKAGqmcZsyC847aC4mEx51hBjYWXvFDP99D/8dCqVyHDoAuV?=
 =?us-ascii?Q?Oh+ndpWIlgxXhoDfZob8a5v2bV/rZl1hwE7rCAXYw6siV/Z1GcMmoj9u6N6g?=
 =?us-ascii?Q?u74KtIVWAQy9hocMRPU5WjX/BHCssvHKJcdZulyCNp0pJffb2jXS+q2GJHDS?=
 =?us-ascii?Q?kWidcfbZx2LiXAWmd9Urfhs5gasUiAnxhLctKrqC7eTNRm4T5Z8AzXytNWd6?=
 =?us-ascii?Q?oyzzZeIIP+NuCFfzwWG5heBDi53XvB6dZqZ2RgqpwFzrEbnwKfiJmgYRhqf3?=
 =?us-ascii?Q?7AiH7RzC9WATfql766db83d821Doq0jxTd6rPnPI6FmzabFN1c8+/im9SDxI?=
 =?us-ascii?Q?NLheXRzT0TT0SChowTLt9qzcQ7R7jG9QEsCcHLKLqo/Q1AkKRZE73bGK01Fu?=
 =?us-ascii?Q?xq0IenNLni++81apNJtYZzISrqjRztfPZ14hi/LS/r5U/woTSu1lbEtrD6f1?=
 =?us-ascii?Q?EBrMNiFX2kCzE0G6dPE3ajD1nRb31xaC3cenkR77Gj96O1+s14yB1B8R2nvU?=
 =?us-ascii?Q?MxGXz/79FgB2fMoGcNyYNFLRLoEr/7KlIo2QS5CrCkD3Nu4RuVl1voBhx9CF?=
 =?us-ascii?Q?Ij7ZeEZeADIzKVsPVSMPPfNxjtjtM/nSd6JtwmRvACmMyHlGI9Mlzgj1VgoB?=
 =?us-ascii?Q?UfPxLQasLRx3XI7+FpICYrp7sZ/Tt8azdqiNUmvtKhC1N6NNHVHPQcQ6CJVc?=
 =?us-ascii?Q?6+IUMt3Y4M31i/i7WKcWKMs7R1sEqAf33n3cN25SGyjoFS/sBiOCDSQcYRQl?=
 =?us-ascii?Q?36/1oDfwzlwEW6VLllIvFmjuL9UJ2Tg9bBQzVQ7vaIIIyfHqUbKD7EBpQgAj?=
 =?us-ascii?Q?Ovv7CP/64UaDqX+hT0LXI0DCyuPUl4KNMiFhxzOG+iuieCf6qtkVZqGtBGp/?=
 =?us-ascii?Q?OP4QrCz2Q06pS5KS5I8nyPotEdDji9mlTB6TPRBIUvXu1DPvn8/uhE1/7fX5?=
 =?us-ascii?Q?rq6AHe+JumhFku59NmKZe3wCi3a3ZirzK+qU6HSCqTFfFZptmlU9z+61ndKU?=
 =?us-ascii?Q?7+cMPouWF2s3C3xORGbdZx5OfWqutxIIWMuIq1e7E/qU2Gv1zpG+HAfZS0Wn?=
 =?us-ascii?Q?b8WKNhRUgIXeU1dHtVvYR/CkAy+BcV3468SIRnih5TRxKFSqfxAaShzeY0n3?=
 =?us-ascii?Q?QQt3BMV2mafLckcz6EqfKL0WE98CzEXuL5eIGtjpH7ONCbMP+TxanWqKZQvr?=
 =?us-ascii?Q?LBMXwpMTYau33uV83SsOIAeEwCFOFWkwlwZAzh/v7195iTVgByQUDuFOOHCH?=
 =?us-ascii?Q?tejuXhRLpQj8gPQAkxl44NxFIlpPQQGaRdP9f0AMqhujg0y54TTrAqzUX2Sy?=
 =?us-ascii?Q?UipRIdKG4khqsjadZ0nW9cK82PbRp2HS0baWRC2EhTHu8keXdvR6UD693IFs?=
 =?us-ascii?Q?vgmTHKHHIXB3eqcJU9p9RyrjmyLAemlzTBf5lqXGxHTi7odvE87bjxnPJ3SN?=
 =?us-ascii?Q?UUld/G6XDfta8bX5gKxNXxMfvC+RgaNXpCskY9VMI/pULXuI+UHf52Y9gIJd?=
 =?us-ascii?Q?I44z9PbhX96BJX4P1kbL3TuzCpaIOzn9NdmrC3hveYyB/CU+NuOvR0dJFczW?=
 =?us-ascii?Q?voIh9GZAX1YxgNGaWL1qrr3hSuwdjSKLFSjRn0K3j6r00O4PV9gYUyA21qgS?=
 =?us-ascii?Q?VQztwTDNd8aWS99/P8Vup92+nOi7RngIr07ItHfipIuVedEtZ23QfjTpvf0x?=
X-MS-Exchange-AntiSpam-MessageData-1: WFdOJCaVjUj3Ozf9TqdZcUNp5ewORib8VRs=
X-Exchange-RoutingPolicyChecked:
	lloaMjf8FX4+J+ou7fDAX8GtZ2/BnKZS16NbZE9qJbBZLSJNVO1V/AYKXhVzcALragN5mcYRuvm1V44nstZqYtX+YuOL9KOQD1Ueaife+UY+COEYXNCm6Nkfc4pXKZNnNXHgOJCzm4fR4lWPgGPOAUArkvOVxYnUPWDTD9qKiF10SmiCLncOyFE2lh4dZ1ebdoIMbpF5WwrjS8NSLgrkvuz025xkUJmL5ZMea4/i+lq9ApUk2Hucu0fKLf1cTTlUcYsVECsDcARcOvoS7cJP0cTMHDrH59nSJIjEu9JzbtdGOIj9C/r70zkK6+N3ROb0jKaImQSPyWKJ7g6/cLrtYw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6dc00f-b154-4d5c-dbf3-08de8b12b6e6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:36:02.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l16TT5wPodm1bO3VOsVrhbrVeq73XQjk8sl/TxmtogzMnwpeZ+DbwZr9wiu04Db1wn7+QYJhJh00XyOGtAkzPG9S6cmnH/xYxtTfPRLjTCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8364
X-Proofpoint-GUID: tcwv_GEcNwPnnWyaYzDQuy9JqtEkBjsF
X-Proofpoint-ORIG-GUID: tcwv_GEcNwPnnWyaYzDQuy9JqtEkBjsF
X-Authority-Analysis: v=2.4 cv=deCNHHXe c=1 sm=1 tr=0 ts=69c4eff5 cx=c_pps
 a=eJMC1fB0Wmzbl6MXJ2sZyA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=p2eoyRXnAAAA:8 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8
 a=mm2UkWPFonPHBTd3Hn4A:9 a=nlm17XC03S6CtCLSeiRr:22 a=KSHYvF9M28j0gckGFaEs:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2MiBTYWx0ZWRfXxJsW3GGekayT
 GOapsRutveNggg4Fa7eovwxI+5IB9uHMd9ZrFwkgMXgN4WdKK4OFedJF+rQ/voXmy3HUxE/NSM0
 Y3kWmOKIZnDGW0vsjuUWDo4gIXNH9ASm1pWXzmyAnk2+JA9EFWCcYzbPRsnrhT0EUlrIGjZ/hZx
 1lfPz8X3xU2fo0ql49j6sat1i51AE2zdqlG6Zn5sonMU3dGOm6NS2O06k5O7qvIlzBXfS/je6mK
 p8JjWe4cAxiG0EiFYkERI5AeNFs7sdrgXZ3/dkS2wV5+Dudbq7D66xhgdyCO5TjKH9btaNYNFhP
 liNzIRe15FgU9C0MBjxPrr/XzvDpjFWM+KlbeFyI/vSfD5KoC+8qA6qTqZzi14zEk5aFeJEcc1U
 rx+b+Abdi99gzRTbQbspKndZfCqS5I7ybsMPdhf4EjYmGr+GXkpYKqKcOpvuFfRb2jzkakT38/F
 T/gkiNd6Z8tjcd9Io1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260062
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230437-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:email,windriver.com:dkim,windriver.com:email,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 415E13318A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

remove_store() calls pci_stop_and_remove_bus_device_locked() which
takes pci_rescan_remove_lock first, then device_lock during driver
release.  Meanwhile, unbind_store() takes device_lock first (via
device_driver_detach), and the driver's .remove() callback may call
pci_disable_sriov() -> sriov_del_vfs() -> pci_lock_rescan_remove().

This creates an AB-BA deadlock:

  CPU0 (remove_store)               CPU1 (unbind_store)
  --------------------              --------------------
  pci_lock_rescan_remove()
                                    device_lock()
                                    driver .remove()
                                      sriov_del_vfs()
                                        pci_lock_rescan_remove()  <-- WAITS
  pci_stop_bus_device()
    device_release_driver()
      device_lock()                                               <-- WAITS

Fix this by first marking the device as dead using kill_device() to
prevent any new driver from binding, then calling device_release_driver()
before pci_stop_and_remove_bus_device_locked().

Marking the device dead closes the race window between unbinding and
removal where a new driver could theoretically bind: once the dead flag
is set, the device core will refuse any new driver probe.

After device_release_driver() returns, the driver is already unbound,
so the subsequent device_release_driver() call inside
pci_stop_and_remove_bus_device_locked() becomes a no-op.

Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/linux-pci/0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net/
Reported-by: Benjamin Block <bblock@linux.ibm.com>
Closes: https://lore.kernel.org/linux-pci/20260317090149.GA3835708@chlorum.ategam.org/
Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a2f8a5d6190fd..e87aa96c02bde 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -518,8 +518,36 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	if (val && device_remove_file_self(dev, attr))
+	if (val && device_remove_file_self(dev, attr)) {
+		/*
+		 * Mark the device as dead so that no new driver can bind
+		 * between the unbind and the removal below.  Once the
+		 * dead flag is set, the device core will refuse any new
+		 * driver probe.
+		 */
+		device_lock(dev);
+		kill_device(dev);
+		device_unlock(dev);
+
+		/*
+		 * Unbind the driver before removing the device to avoid
+		 * an AB-BA deadlock between device_lock and
+		 * pci_rescan_remove_lock.  Without this, remove_store
+		 * takes pci_rescan_remove_lock first (via
+		 * pci_stop_and_remove_bus_device_locked) and then
+		 * device_lock during driver release, while a concurrent
+		 * unbind_store (or sriov_numvfs_store) takes device_lock
+		 * first and then pci_rescan_remove_lock (via
+		 * sriov_del_vfs), creating a circular dependency.
+		 *
+		 * By unbinding first, the driver's .remove() callback
+		 * (including any SR-IOV VF cleanup) completes before
+		 * pci_rescan_remove_lock is acquired, ensuring both
+		 * paths take locks in the same order.
+		 */
+		device_release_driver(dev);
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+	}
 	return count;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
-- 
2.53.0


