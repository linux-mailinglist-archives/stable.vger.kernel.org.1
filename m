Return-Path: <stable+bounces-227164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EUcOJUTu2k3ewIAu9opvQ
	(envelope-from <stable+bounces-227164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:05:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6142C2D31
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70FDD3135E20
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF51337475A;
	Wed, 18 Mar 2026 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="kuy78zgW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056C30F7FB;
	Wed, 18 Mar 2026 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867866; cv=fail; b=gWUSQ/V38Ma8zsBR2LWEXRAMNkj7NWLqprZZf3hi2+PwnkeNikW4OsW0U5b6RAAcoFyzJfhst0aV3yNeMV654xa4ewC+TQM91hS/0oaO+YLOe5N+PsAEY/AbOjGIzOkhjGC5WytB1WIjH6kKMqXxqyZKajF/ne/3rZ7UDOT6qdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867866; c=relaxed/simple;
	bh=8YE1BuHanRkvwfwDtRo1OY98VdZG+wPpj+gux866DOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UKjE/QS1X9Ha/uQEwrnM4Tln5p/ZD3mxcO0vBtPuD0r+ehhjgorvkxTQwpqldk9Qd01TODQXiDhpST29udojhvXdrcHG5LLVx3xd3RRNw/WGySpqvHmh/SksZ+sIQ8wydb4eQMjJDpBb1PSVAw+CQ4WC/xnpGel3/c229bX7bAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=kuy78zgW; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IJ0JUD199012;
	Wed, 18 Mar 2026 21:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=EWL5dcgq/SCDYZU4Ob5N/DZT2HxitJSra1/t+pn7k54=; b=
	kuy78zgWP8tXo/TjSYb3XJicytPUIJTUlAKkbVfdpNKWp/7LozJwUiviPUcVLrTu
	YXainfXcTlLUrCvh0+e0eppdpj6avhN1zyR0qAu79Nyab8Hy5Duzw3SAKQ6Hc+FE
	OZ7mbbtrLSpD3HAn6mkBP4Ps99yQalgKtaFq8Asc2CW/aNnFk70GfRdN+Mo1Bds4
	uDUa5EofdFMBHpC7nORabG86o9ShBydY90w3Kwg31VlY1EFBWlSXa/OjOmB0PgCi
	EXJ42fDJEZrZrGB81aC7gZ3OhmjO1NErYzfxFPVVKlOD63BxD8wG4eIECb+MOl2i
	HjBCl/bWF9l/hDWj3kp6QQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cy9ansyxu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 21:03:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjPqYF3bRNtEAUp1H5U+TQjGS8BTtGVWdweP55/g3/fTsWAuzrMo6LYwlT0mPl4xn9rYd/Z0uUmLVxIsIAyPc2VBjbxp/q7TlzQRgD0YGq0oZt2Beo3L/Qqe6g+hy1IBmOaXEnrwWjCrWzKRNiEL8FGOyKhXa47vKOXM0LIfqtebUtjNiNGZSXO3p1c/j4pjyBnz1JuOhuzDe+qMV+Q1AXG+abJ5zV/fD0MceV0cev+wvFDARHwgUmYwc8RLMRQWWdpMV8b0LCfotZig6N2LGHpYeidPhTTs5ivrgwlSpuRLlNALwSO28gYkPWkNW8ngiyXctp8JIvzwRzrZvPqX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWL5dcgq/SCDYZU4Ob5N/DZT2HxitJSra1/t+pn7k54=;
 b=F88NwTiqaNtGKDuUMgFbAvyafdfoHRVLFPBTiUunOGUtePGvTqyX5YD7KReGmRx+Sw7CzVFI0lSLXQUQRYYdl9sgxyLIuKJNVwuDjlSlLO15iWXuIE7JLJQCpEMAwbZRCYqk3w4yLIEBBHy/wSMV2hRouk8VVqQuP5OW4K95Bo/RYoMeuKAxZMmcjo1JFWMVoX6NARAZTpdU0k5kc/KSYYFiSmIg7i4lFry+Rcg//1IX+0CfExQaPvlbSOk5oH/DBp6s14fs6w2ZEVdFu7eKBDm3kkCgzyrFWVShxRVWHv9hdpUB4oaVh+e6tCDMO7Mk3j7NtA1IfKtlBvBanH1Law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by IA3PR11MB8893.namprd11.prod.outlook.com (2603:10b6:208:577::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 21:03:44 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 21:03:44 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, lkml@mageta.org, alifm@linux.ibm.com,
        julianr@linux.ibm.com, dtatulea@nvidia.com, mani@kernel.org,
        lukas@wunner.de, kbusch@kernel.org, linux@roeck-us.net,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v10 2/2] PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock in remove_store
Date: Wed, 18 Mar 2026 23:03:16 +0200
Message-ID: <20260318210316.61975-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318210316.61975-1-ionut.nechita@windriver.com>
References: <20260318210316.61975-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0250.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::17) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|IA3PR11MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: dc94d7eb-9987-408c-f431-08de8531d706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DNWR9eWq3S0L6c3VBmPili4ngIbZyctLGSvwWO1S5CszASDPPt971dKS+V3N4LfJJnYWN+Zb63J4w2va40z9MVk3MMtOsSKUVBTG516E0yjR9vk97LjEjI0mEJHxdsffVmFLFnS1+WI8RldNoqlIr2qn5nONHr95d0dFqXb8a1XjfXxI7sLo4xuNUCDYnXXL0fUHLv3EHkAADE/nnH2h4VPDocZLpCsvFeqWn4BeNWI/GElSj5+ss6hLA7kWkINcGHXVoCboFiRu2V6kbu60CiLr3rIVQwUBGs6Y+4U+KOnYd/ejxosgnHcv8WTNiTGAovCDpSjmECDyXu68fdARAcFAoOgouVDcNl6h3jAalx43rPtv7RF5SJbvKTf8lgeI6cUwRPOHGb1Rhnn8grYyIAp6SrHRQvqn2jjbvYokXlQ37sapEpiCZBFV2rnLv1eFSkr/HZOhnaQEMs3kma5JLo4ELOAOYcTnI3HLDZE/7glxj/2WgnDafq2a2jza40VmYViMNMlq7tbd62jbkOon3oTq5n8pCMN74Dg7R+LBmeOcPi6zbG9wOWAdjxCU3dkoIAeNud7LuQaX9X/Wf+GCIdPwcqwiK0swgk3hIncocX3UcrdASmb2Ppe7t2bmycVFSxA0FJZd+AAat90ZSvVGbOZvsf1t6zS5y+yXmiCsTDVA0c6AzfKv8QJJ99AEG9XMbraYDUPDWpBXPRSXYDPakR80tGaWK+JgjmSoGPHB/rDiKlZ7hRehznMhiC1xaFrx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aqgoCFhNQTBoVelZrqdeBFK7vLrIoKKxG0VhnLoHCD4aeo1igsOdaC5rwCtX?=
 =?us-ascii?Q?toXSO9WcE5ACtSgu13bT1Gu8e2gn9Ocy/589QPsqAiOFa6NDDwMWCuIQFAlW?=
 =?us-ascii?Q?mPg5SD0Q506kUQWl1oRlHb7aNnAlwz1cedH9zoirlQRMXJ8q7D1MqTBomYGs?=
 =?us-ascii?Q?vIQ2J5XRnxc0FvHSHxIdrVzhKJRR4dhOqLBuwWP2rIoSyazKdnXQ8Kf5ok/o?=
 =?us-ascii?Q?nRYkBWl4aUibkT4jjNrecRINqicaie8RpRpvgsCuIK8n4lLSMvxMqck+/K7k?=
 =?us-ascii?Q?zOG4VhOSy+jw/eNWNioSG660Ng8D++DBG2oGqtDY/oxeslc+ZziDxgmtrJrw?=
 =?us-ascii?Q?Tk0LxZsnAILox4k+rq+aAT81Q4Z0Kv6TdVoNidHZUvqKtBJukXT4Sv5OGthf?=
 =?us-ascii?Q?zmvQFwKSNwGXaf2j5t9MwE93vH7eHyAj/FQxtuJI5t3ybsuw0UA9rOyBzIwJ?=
 =?us-ascii?Q?UkdlOQ4/5Bx0whwQyuvoZED8aYrUVDwfw6VS+IKfsXlxhPNpGXKbpz4xNyOY?=
 =?us-ascii?Q?e7FYmoxWSYjUaGG4QvJfmdqfvLxNzCrAsZQ20p/gXW1Caa8kZ0IuTLfA3pyX?=
 =?us-ascii?Q?LgQHBp7JVXFKtTV12Ca54qfwe+dHs7Mi18vIiiyjkTmjuV8F1OLwsbwP8tKt?=
 =?us-ascii?Q?wN0+PL97f1vPK8mcRKEFBZlqSFLEw28Sltzt1+T4FEKodK17oA3LgxjBQHgM?=
 =?us-ascii?Q?wxC92kIEz0Ew11/PEE95deL/wcMBhD4ECr/CLLD6wioh7SHitFit/6ZzzdL0?=
 =?us-ascii?Q?axejy5S1ABJTaOios5+i3QXX+xRAMHwxEW643MvOJOrlE1MVQFiGxQoVXjK6?=
 =?us-ascii?Q?b+zeHJrgbej0maa+KKHfUCCmexyZHmoEO5zKMyewyHOP2NdnaFodbWnLbukM?=
 =?us-ascii?Q?iMeOjtjKoNdRdHwNGhO3iUTmGwWGXcqSOrzLVmpOJBCOb44pi5WcC9IVSjHG?=
 =?us-ascii?Q?QPqq2W9zpH2wcblSuhDdjgJsXJWRGlEGoG2k9X+Drspp2t10lpiUS9uwAhPr?=
 =?us-ascii?Q?jkAxzxvOAANBsMyX9E5b5ukvI4g5FIddmovU0ocsmXgmKXrIAJY1FaQu0rYZ?=
 =?us-ascii?Q?g1fZJilVHC68lv5PDEthTiil8uVmSXZnqrsjGqoLnQb6HmtgCW7Cz1JEpIbU?=
 =?us-ascii?Q?OzrtQrmO8bY8wEkqS5KmLTaV9EJum9Lv5d8wr2WT+tJyHx+AXUUW3HIo01FF?=
 =?us-ascii?Q?2WxARF+ioNd+S14LNWWRm1EgKWfqG5Md+GYa5jZcrVqc4XB7yYSHZzDqisM/?=
 =?us-ascii?Q?tu3KiYU3Xk430i6CgyX+2QqhERK1BHAUBH3TSDbd6ryoQBffnXv+l/Y13JDo?=
 =?us-ascii?Q?sk+uPQMQnS/e8PJkuKqri+IwECO8l0ylwVRDUXM0nJC3uXv9kssSpJ7nnWaz?=
 =?us-ascii?Q?OJX9lEuJ5H3ECGQmFCY6HW1LKHkqurEM+54rKRtyY3oKj1AuT2J6zKdrFt4+?=
 =?us-ascii?Q?PwTsLy0kyL/y5X/w0jFZZwzi+9tYu0JXg93dCYLO3eazdtBnAhLf8TwZV0cn?=
 =?us-ascii?Q?FvGJzuJIHyOvZ6W7UzV3OomaYicuRq06ijGzPR9lkyibC0f6RuFxbO7W7ThB?=
 =?us-ascii?Q?CbewffNed8tF6yUoNQohQLLV0e0rgcZWtJl7IFc4mNVPQ/UnCYg/K52sA+ns?=
 =?us-ascii?Q?4Oz07nJ9t1k/9qCZwO6whpByQce/J/ezsByXUtT1nd5IZf3gapad2JcRnNpm?=
 =?us-ascii?Q?4MYBjVLpvXUse4HYa4HepGOeHw7at4k2gRMFgZCfjYmvz1yUn9qIsiIqqRlq?=
 =?us-ascii?Q?vIdnmauRHPtKuy6sd3qe7ZO0k0xEF2KmBvv58Mu5UwBsPOXELRIlXFu0Ku/3?=
X-MS-Exchange-AntiSpam-MessageData-1: 3I5olm2Eup7C4Kuv/Ib0C5AWqT8paEibDT4=
X-Exchange-RoutingPolicyChecked:
	faxOazBnWYPDXMxDHRtJ5HAUxQpBNZ+i3fwH9phBuIYOrW6rdYA8XXvRKhxoWsiaLknyeVNhZBFiK7yuV++Ae++L7C+CRmwnnTbMx05yKKU6vZj9/ggzvKl7rMBd9F5Rs108xCqiE4LPvezwQODn6xM/cYnbWDqcaVPnkFW/57pgnoOcyJ5bcEo/rCKuimMRiwAYsVIzqijzyAckkimsfqEvTOV3o9R1lJdEZNDGw+0tgKqNzDWB4atJVDSm8aY/UKPey5hiNee5khqQv20WPremFmXLFcxpt69PXBvGjjN8ixI6d0UJIdVWgmr6ulU+yFPfBtNIi+7RjbN3pmgupw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc94d7eb-9987-408c-f431-08de8531d706
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 21:03:44.2079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+pWr15mrQhi1MKngRI/opPQNQqfIbBMo3tYI007jLpmF3nuKKkUotSgTEpITkO+UXd/JDEE9g1gKSIU4BiEA+UKhstAj9+0m70KBpbld8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8893
X-Authority-Analysis: v=2.4 cv=IrMTsb/g c=1 sm=1 tr=0 ts=69bb1332 cx=c_pps
 a=65kS/IK/0KNveI1QfQMUCw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=p2eoyRXnAAAA:8 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8
 a=mm2UkWPFonPHBTd3Hn4A:9 a=nlm17XC03S6CtCLSeiRr:22 a=KSHYvF9M28j0gckGFaEs:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 8Yh7NGsIlLrszms878yHc6iUCt-u9KzK
X-Proofpoint-GUID: 8Yh7NGsIlLrszms878yHc6iUCt-u9KzK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE4MSBTYWx0ZWRfX3Lv3P3SV0YB+
 /2LWxwn2w8MrYrziP0hoN/gMJadM+OjZdqbK3hvhL6ayRjPBlofi88zzxepSRcvCLNWVJsPBQ4J
 H6+mc21TKH+7f6/7Wk/rQRPvZrgvIy+fQOhDqWnW3w9QPok5Jpiu1XiHZ2S9sgNJVNcmjvDLMFi
 FW+pmq0sQPp72ZdGmVCMRew7UksVu7cm+f+54Zq2mGd6CiNBSyWNfRofi3DbaFkQHddi/VJqhoG
 4jyiOiRtwEIjjsONg0U9QDTZ80jmACKVe1kkQTQ5pcMnrAf8XWE/QmEfC8I/1eFJZRYXWKc1Tsf
 ZwpcwX/OxA4OUKROg9a6YipaCHngYCdT2gLNZpxCgqwHIZeEg6r+vrMQyegOgwSUHjD+QvxdDZ1
 V8sWA2hLKkOHQYb0uCALbg6y0kXzmXu3s72hJUou+8efQrxT8Bka74pQDend3BotLUWZTAG1XbJ
 8CFzs5eHDrRHgq5MPoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180181
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,mageta.org,nvidia.com,wunner.de,roeck-us.net,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,intel.com,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227164-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,windriver.com:dkim,windriver.com:email,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.986];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6C6142C2D31
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

Fix this by calling device_release_driver() in remove_store() before
pci_stop_and_remove_bus_device_locked().  This ensures the driver's
.remove() callback (including any SR-IOV VF cleanup) runs to completion
before pci_rescan_remove_lock is acquired, making both paths take locks
in the same order: device_lock first, then pci_rescan_remove_lock.

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
 drivers/pci/pci-sysfs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c7780adf564e..e94ea71a4eb8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -521,8 +521,26 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	if (val && device_remove_file_self(dev, attr))
+	if (val && device_remove_file_self(dev, attr)) {
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


