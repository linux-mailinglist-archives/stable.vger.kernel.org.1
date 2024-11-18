Return-Path: <stable+bounces-93811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB069D1537
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 17:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428131F2374C
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 16:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DBF1C0DD3;
	Mon, 18 Nov 2024 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NB4v6gl/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rk8L9i/P"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42D1C07CD;
	Mon, 18 Nov 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946744; cv=fail; b=QSrX/mzCwgoqpA7wsQkcxouBMZn5N9o8DsYdWx/G1ZdzxTHRdt8m/fxUvbc5NNSXeO1IYY0fjguBuZXj2uDTFi/d6yBVu1V9AUEyUXzNuhCf3gGBmkuV1CazNXyuHXrBs8kPLFZIxG+Q4QUoVzgL/Z2U5KKlocTGBigyUMt4eZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946744; c=relaxed/simple;
	bh=SMdCHpADAZCDZ19IuwSDkdB0196oJjOK3367HSuHZsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFK/R9RE5BgsTbfPQTKXN/feiRy1iTrv8PQ9j2msygAedSNlj3elA/+5zy9rv8mVzPM5QX12IGmJ7m03VcVwSf94oW6XEgmKm7riB2w7MYRtje4AhwQe8FE+BuAffNQASOvbhOw2hhCvI/fx4/L1zs6UYxVF/bPTULflUvmotBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NB4v6gl/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rk8L9i/P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGoai032669;
	Mon, 18 Nov 2024 16:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MRrVHGDRLughqVlx4AwYJKYY2Ke4n4qbuAKF0PLzItY=; b=
	NB4v6gl/5FbjBYm8DjknXrLGi19T3bwjAug/yVuXq1+GHeikqDYjDOm3glO2yCEg
	98154/IOItpmPj7lGNBWMK7B3c4oly3X61d0IxpQctMnHH2F7bCnnrOSZwlmPE3b
	P3CygkzZK/X2M9+46JJAbF4pO7z1kFnpsFTno+S7WHq4gV3r3rDwjKM0aUpmjZ1z
	1QLmSlW4i8RmJZZL2EQ6QNgBNFqxaNxH9WyfJEH9KwV1naHH65UiSfyxYjMpkP89
	q5LgK+wQETnnDKXeEokaihL2ikZIWDIkm+Dnc6a6reQ4dE6CM+i6yX+NPjgIAIDJ
	5dODssgmKqb8a34azwQ4iw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sk2nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:18:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIG1G5m009102;
	Mon, 18 Nov 2024 16:18:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7gxfh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnykYleQF+PZvdoGuZaTx1JSX4mq1pd8c1B+HcxOzYyc+p+mHRcq1+8KYte2VAAbs8ziwkEE/pXIBRc4qo5guteFCmazfOiYY5WO4OULF+uVFymtZPWRQbJvqirOxX4XfMgbYa8J7evj+fHbUn5vHwjGQkJdc/QBfzLTrj5WwHbnm04KP2JacV3RL5KRhFzvrtKhN/ubRKvL9wQouPzG92ZCok19KZYDJcEiVCRgNmHUI61jAyodMAb0R68o0LwxRxraB3P3k8MVs0UgYwN6C9rnUr6qvodtPhEcQHGy4xF3MnyT+xUp14XeWG83MkxeX0xDoSDbCTrnFfHACcD9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRrVHGDRLughqVlx4AwYJKYY2Ke4n4qbuAKF0PLzItY=;
 b=QpmZbdsA4vGKz1/JoWoRTtW5SfOydIINF36ltMy59F8rdHCQT9txqsJnmYe3CIDZMkYlA26mrqXuOIXPrsI1/RpFz+Njfwg0JuwtSRkQ8EFTOMiVGgt1aybERyVH179rSaK1vEPYH4YY2g0nzVs0gvKxaEBvTMvuI3pOV7uue+TNylFoWZcQybRrHoSZHSd/Vr8vzdhKLYU/ap2a4dOhJAywzEt41UsJLgYGyaMwUueA0ErnYMCFzIACX29oPXDwxSh4yPHFAIgcPigJIgfwy3Nf06qzYfxBL71mC5/nC8hg5ricyILfa6TIAOwjqtExg4dlLOuz2yS2i1KobyT2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRrVHGDRLughqVlx4AwYJKYY2Ke4n4qbuAKF0PLzItY=;
 b=Rk8L9i/PawLwM0ab1iB2T6sIlRyIttdH6locWvTOaCvGD3mOPPKCstWlHEhHA7SmpoWfaLj7xAnBSv2s3KyDnZXaIBUN3gO1/Q6I6p64kGzR7dJkB6D9Z/VDzBsQOhtDbbMha9NIP1u+6XxaFTjtMwv6fXE8j1GNWgdXg8CVPZs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA0PR10MB6819.namprd10.prod.outlook.com (2603:10b6:208:438::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:18:27 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 16:18:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1.y v2 4/4] mm: resolve faulty mmap_region() error path behaviour
Date: Mon, 18 Nov 2024 16:17:28 +0000
Message-ID: <c1010a906529ca76149fe169291f0bb94b506dac.1731946386.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731946386.git.lorenzo.stoakes@oracle.com>
References: <cover.1731946386.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0034.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA0PR10MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3d2cfd-8951-4881-3972-08dd07eca07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vV2subp5ZSTXCGM0ZknUUWeI7WfJT1L1hC+JgPOIAoe1oEIShHB2YVYVnkfc?=
 =?us-ascii?Q?OYj8f0d2VE9bKiiv556qwuDO7m5Rttorrh2eeMni27ipbx0MaxtcyGTG6Yr4?=
 =?us-ascii?Q?IoPfKELXUYHDDUfrqHyHMy6JvPT/cVnnSNeQb6cUctehWMnrl3foqXRsa8In?=
 =?us-ascii?Q?rxaYWv8u6AcgpN++bAMR4BpaGPX/dCJDDe3de7lAwSyf3tB690ogW/huhB90?=
 =?us-ascii?Q?0BnQgORy/sdHPeOkwv3hWllYE9juT/fGGrQwJGBqHm03cx4Ac+Oa/zB59LKG?=
 =?us-ascii?Q?ZTlvBymGnZa8GZSr0K8z+GU/e3uveJsnJ7/m7Qtc3Q8sY5uS2uvS9srPr0FD?=
 =?us-ascii?Q?oriorINQYLnEypKEZd0V0MRNsOHPdrdqlOmF/GWKpeX8WdISYpAuugl5oxQ5?=
 =?us-ascii?Q?iDlZ6nzD4x+UBq4EhpviCvtXjdGyLcf4Q4XUSGwa9I0RAZPSJEVc3TdAg7Qr?=
 =?us-ascii?Q?LFEMi246JuIIDsc2VEQwsUYmjpa6LqK1FuwXkORtnEC5hpAmQurM14CYWUh/?=
 =?us-ascii?Q?jdcO+FnEIy1t0JSOCdlH15WUY0embR81U66SSE37nUu/7eIJhatdVnE9CKxr?=
 =?us-ascii?Q?KDAJdB9HOq02aybeFbK6dXYEctMt2KXAw94VHps3epjpW6aeXnca69AcRXsf?=
 =?us-ascii?Q?Mgq5AueojB8BkCnOB1HvikOxKuK6vZPvhybj1w6/BAIiw7B1hd0Ldf+Ndttx?=
 =?us-ascii?Q?/6GeTYsmX8adUdhfCs5zluSTK0DvCWZrVZG6QxgFZ34tc20lPAA5OAgecx5b?=
 =?us-ascii?Q?qtrBmav8V3HqJ8SaDLRwxl3XB7chN8gn2V/zoCxMi+zHLQuTILlABcTbnUFm?=
 =?us-ascii?Q?Qh9x5Nx0qq8QQVkwCxkpJ2T6P5FJueNhCckydyhSRf4qFrih+r4Ox0jh8CXV?=
 =?us-ascii?Q?s56GB5yGNxiJWAAkIMMbVP0S/pqYRuaOn9Nz1oKub6AYOxgu1TevNloT30nn?=
 =?us-ascii?Q?ZUXWG7v7fQH8Hytu3YJQ3vj/GnCO1mUSEf3EGHxHUSU/ehz2HzW5AzDNzfe3?=
 =?us-ascii?Q?fCviKx8/qyI9seCNulXX5O15bs9qrI4e+X+7ZOxPJBs566Y6glMqlSJorVRe?=
 =?us-ascii?Q?hYvKZ4b/+dwDEk+gCCbGRxwhR19HBPtE3hAtOUxEpBLqk0sgD4P40dvYyRaL?=
 =?us-ascii?Q?+SomegsU0Iqi+Kjv14RxExV0qx/ZXLmI9F53+62Ix1yqgEA+vIcgQQvxiYX3?=
 =?us-ascii?Q?KZsvrWZIN4A1KVdI+ORkFbojqqYEKo0yK0+YWI7i6X/x4Hw7O9X1RynZqmoU?=
 =?us-ascii?Q?qt4IRNoM8qQHhVAUXOUSME1lIhFAM/ESOV/FJ2BSBReNS0laBo4ggQb7sBpl?=
 =?us-ascii?Q?E1QZYHz7L9RNkGM6utnk83se?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mQs9o+66NfqJNu9Yb7PJWJQFaXE62ns30pd3KonjEqZezIp8M1t0ryO60PNk?=
 =?us-ascii?Q?raX7ZUS93yDXhdYbaERnJXVjIZguQha0ogoLjcjgKkZCaNRse0VGDn3GGL77?=
 =?us-ascii?Q?6/mIQwp8kRWPKPOs0KvSezCCq/FCpTWs55KOoxy1gPMQP9nveH+9qeihSad7?=
 =?us-ascii?Q?Ctko/NnRb2RbwBKga2aNHWesB+SaDkZInPI9gbbt7G0vp3a+xJ+p2FxmPhyo?=
 =?us-ascii?Q?dgYoBHfSun96kOLugiHkTe6xacmlj3+RtHdSJyu5jJvyZvkn8llR98+dO0C2?=
 =?us-ascii?Q?ZErZ/D1X+S+ePrsuIkG0ZdcuXisZzxjjkoy+aoVHpx8g96lxVaK0hXA7E/8y?=
 =?us-ascii?Q?MIbeCTncmlWf61ZwTJu3l+OitPRnsvJFburb/wofj3AlJXl+XyfFRayCZJrZ?=
 =?us-ascii?Q?2olbAm3WzSGARbKNcZX4dZsm2wnR+/ip+l7jEyy7udsA0/RrRMLB6hm4wl1j?=
 =?us-ascii?Q?Qj95NlOQnTL4Caudu4JnZ1cPIpNwGtH1l6KHA+TL26BVyhrZU3IyV/NKOCSe?=
 =?us-ascii?Q?6u9BksC3TEW//2mAyDyFlPklXq2zmnKMHUdN2xdtY0sA0qxgwlIy+9vBNsU8?=
 =?us-ascii?Q?2zG+Zyxq9DgnrYDN8BlaPV9vsOxO0gn38AGrqANpVYnKx05MVbL05EZTQcbs?=
 =?us-ascii?Q?0qT/+cu3eplBwBfxTvcLiuX63Gun+h0pwIFWJ54okb/h7eRWaQz0wNZelzkz?=
 =?us-ascii?Q?E6sdBpar/AE84nICRDEW6eve54/38q873gmKHWe/mNIUbiiaAVtUwZTroBqD?=
 =?us-ascii?Q?CiHbjDm5z4Zp3YLO8vvkRvvLFz08PfsFodTNwTDyiKr3CKZz9q18R08gypo7?=
 =?us-ascii?Q?TzYl+Stk9YHzjAjgOtNoCHuDYU5CT03v8ESqmLHwUwDBK707UGUaI4FJUMRm?=
 =?us-ascii?Q?NJYVCo0lV5x9wOD+awqpOmXmzz6bVnoZXjxcsO8y3whRKDB8f5cNY9/S9lY+?=
 =?us-ascii?Q?wjpwtJuMVRGzO/uP1OCq1VKSj5WRKBvPlRybCZ/MtTFVnJr7qXUJbrOrPwZ7?=
 =?us-ascii?Q?mpxDxwljG+xhGfSp4Cd4YqsTiFy8Bqx/jJpX0YvlHvSAxtK1puvhz3/oqEKl?=
 =?us-ascii?Q?jPNv89NvkQnTVUYbYKgatVuAeKkSuNHDBvAyXHMqtcjDmO09j7SBFXvNDX8d?=
 =?us-ascii?Q?5B7sl6XUoZeh6YMMo+HOgaMBuIvC7XKC2E1Dhj7gR94MPCVEcbQWdItkhA4E?=
 =?us-ascii?Q?9Dj7Z41FapxiuWTVc/ZvIxQhuh4mykL3AejpgP+tkMmTnEbPfGxg/eHZdqfr?=
 =?us-ascii?Q?ueP2pEpGmEnUdXrlA7Y3g3X98AYBKZg8eQEfl3iriF2Fo23U13eG/cWPYevu?=
 =?us-ascii?Q?zet4fUI+cE0mMqK6FstCXF0uzYe/TFMxxUjNi3QuJTQdG1T03Vz7c5/FxRcm?=
 =?us-ascii?Q?nvns4gwKGcvaJLBfgxJRjT4dxSMiWg1GIH3czEkdXC09j9FtAR55A6qzSDO/?=
 =?us-ascii?Q?PaGzp6Zv+p+z6wV6aRAwuXabYtyPwFpzZACpC2CPPv+Ls8qBbnen1bxah73o?=
 =?us-ascii?Q?KVQ9G8sUVNlWQeKMXrWw/28NoFLEkSrc53VvF1V+1unZXFcin/+gsGat4Huq?=
 =?us-ascii?Q?TfhcuapCTDmqeyDRCSK2IPQhvFV6ZfPlyCSJJj9QYhWiNMjHfxsrj/JzFFAD?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vYbqDmGKA/0Xq65BX9YqqJGuvL+LdyShB0qJRCfVwmG6JqvG3BXcXMkioU1VXyzTwHtiKqDnkTDr+mU8aOl1RU9zTLKiy8HiI204wI8iAs5oiJrN+6Yw5pUv9Ta5cs31YGSkvP0JcIZ+D4DfLg25DKj69HWHifgPgqgKoYuyha5B1zvqSvlsDhrRbqLYlufIMhhjdN7Ut0tcRGK9MvWUcUwvpWO3ePTgzx8tTIkj8aVFOZhDUDh0zb06s9f8+llU0ufeD1cUPhZ+pMWrnelAcY25/feFBHvZUDv1amVVlKNcS7MRjHurGuGqMX/wrQF7PXSKocO1snPRmp9zzFf+tVfL8YBrMtldjfvKzoLeIDELk52q+MoGXgx4KazXkWBodRRIoQ4Zs5bsdKTsWkHlYi2N0cMVsDm66BSNHUn+YAwptFwWlKDaixilh3CQzjglgZVwmcX3vgK47kAfgd9ZsaswxDn+d0uabH/+MJkF713HErbObgywhh7lt5z6dGl2/iqqSH3FF4SUBMizILNGaea8M6vVYq3/IBqmkLaXcJEJ9MrpsqCKvrCSQwcsxChC/ohIOATzfj0j30OewGYUYsD9JPxPlb6mOtjX4VixVnk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3d2cfd-8951-4881-3972-08dd07eca07a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:18:24.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSRO9MZcbgSJBm/udHr7q46plGDBbNRdH6g7/V5Xh7AcG0cI/B/Hc/g5mheEVGPxMezRvSJRkvg0ZP7ySac92Ac+oAOcJFd1CpLKv7Nz71c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_12,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411180135
X-Proofpoint-ORIG-GUID: FBo21Tb_ueMxPh26xCT8TRDS_g92OSh0
X-Proofpoint-GUID: FBo21Tb_ueMxPh26xCT8TRDS_g92OSh0

[ Upstream commit 5de195060b2e251a835f622759550e6202167641 ]

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

Taking advantage of previous patches in this series we move a number of
checks earlier in the code, simplifying things by moving the core of the
logic into a static internal function __mmap_region().

Doing this allows us to perform a number of checks up front before we do
any real work, and allows us to unwind the writable unmap check
unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
validation unconditionally also.

We move a number of things here:

1. We preallocate memory for the iterator before we call the file-backed
   memory hook, allowing us to exit early and avoid having to perform
   complicated and error-prone close/free logic. We carefully free
   iterator state on both success and error paths.

2. The enclosing mmap_region() function handles the mapping_map_writable()
   logic early. Previously the logic had the mapping_map_writable() at the
   point of mapping a newly allocated file-backed VMA, and a matching
   mapping_unmap_writable() on success and error paths.

   We now do this unconditionally if this is a file-backed, shared writable
   mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
   doing so does not invalidate the seal check we just performed, and we in
   any case always decrement the counter in the wrapper.

   We perform a debug assert to ensure a driver does not attempt to do the
   opposite.

3. We also move arch_validate_flags() up into the mmap_region()
   function. This is only relevant on arm64 and sparc64, and the check is
   only meaningful for SPARC with ADI enabled. We explicitly add a warning
   for this arch if a driver invalidates this check, though the code ought
   eventually to be fixed to eliminate the need for this.

With all of these measures in place, we no longer need to explicitly close
the VMA on error paths, as we place all checks which might fail prior to a
call to any driver mmap hook.

This eliminates an entire class of errors, makes the code easier to reason
about and more robust.

Link: https://lkml.kernel.org/r/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Mark Brown <broonie@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 104 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 47 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 322677f61d30..9a9933ede542 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2652,7 +2652,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
 
-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
@@ -2750,26 +2750,28 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);
 	vma->vm_pgoff = pgoff;
 
-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		error = -ENOMEM;
+		goto free_vma;
+	}
 
+	if (file) {
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
+			goto unmap_and_free_file_vma;
+
+		/* Drivers cannot alter the address of the VMA. */
+		WARN_ON_ONCE(addr != vma->vm_start);
 
 		/*
-		 * Expansion is handled above, merging is handled below.
-		 * Drivers should not alter the address of the VMA.
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
 		 */
-		if (WARN_ON((addr != vma->vm_start))) {
-			error = -EINVAL;
-			goto close_and_free_vma;
-		}
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));
+
 		mas_reset(&mas);
 
 		/*
@@ -2792,7 +2794,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				vma = merge;
 				/* Update vm_flags to pick up the change. */
 				vm_flags = vma->vm_flags;
-				goto unmap_writable;
+				mas_destroy(&mas);
+				goto file_expanded;
 			}
 		}
 
@@ -2800,31 +2803,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
-			goto free_vma;
+			goto free_iter_vma;
 	} else {
 		vma_set_anonymous(vma);
 	}
 
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error = -EINVAL;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
-		error = -ENOMEM;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif
 
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
@@ -2847,10 +2834,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	khugepaged_enter_vma(vma, vma->vm_flags);
 
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
+file_expanded:
 	file = vma->vm_file;
 expanded:
 	perf_event_mmap(vma);
@@ -2879,28 +2863,54 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	vma_set_page_prot(vma);
 
-	validate_mm(mm);
 	return addr;
 
-close_and_free_vma:
-	vma_close(vma);
-unmap_and_free_vma:
+unmap_and_free_file_vma:
 	fput(vma->vm_file);
 	vma->vm_file = NULL;
 
 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
-	if (file && (vm_flags & VM_SHARED))
-		mapping_unmap_writable(file->f_mapping);
+free_iter_vma:
+	mas_destroy(&mas);
 free_vma:
 	vm_area_free(vma);
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm(mm);
 	return error;
 }
 
+unsigned long mmap_region(struct file *file, unsigned long addr,
+			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+			  struct list_head *uf)
+{
+	unsigned long ret;
+	bool writable_file_mapping = false;
+
+	/* Allow architectures to sanity-check the vm_flags. */
+	if (!arch_validate_flags(vm_flags))
+		return -EINVAL;
+
+	/* Map writable and ensure this isn't a sealed memfd. */
+	if (file && (vm_flags & VM_SHARED)) {
+		int error = mapping_map_writable(file->f_mapping);
+
+		if (error)
+			return error;
+		writable_file_mapping = true;
+	}
+
+	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
+
+	/* Clear our write mapping regardless of error. */
+	if (writable_file_mapping)
+		mapping_unmap_writable(file->f_mapping);
+
+	validate_mm(current->mm);
+	return ret;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
-- 
2.47.0


