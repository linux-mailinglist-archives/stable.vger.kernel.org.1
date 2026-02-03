Return-Path: <stable+bounces-213132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMnVDwk8gWk8FAMAu9opvQ
	(envelope-from <stable+bounces-213132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:06:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 863FFD2D4D
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F8BE301652F
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 00:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532E33EBF02;
	Tue,  3 Feb 2026 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ut05zN+T"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B533EBF00
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077154; cv=fail; b=TzkN7xeHiQc60OsJP5fDjln8wWVcvrKSE6F27ElS6Ty9OqUZcJV02ctzBAZNP01pHiUBQ7W/dZpOYTVu78T8uFruHkXX+4nhLONXzSQ/USZm3SBkvUoR3BxZj1H73FT/haWFsKy3Ym7BmCl3+9liokRbEo/ByI6P1hlqmDlhic0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077154; c=relaxed/simple;
	bh=Vn4ujd8o3qS/BgTK+dYl4cpBbAiSChoZ1F6CvPJxVbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdQSNBCFuBH2fyMknLx/f8t2eDX40uQzNaH1VaNQr3Oa+wLzIN8PWKZ4v4HIV7e5TSAHfWmMh6cS6Sgfegny4DYVQ/jMgrogAQQ0JxKx4yyvU4na5+ns0gfnHthh3gqQwvQOA9GorUPfPCByLoOxOnZoAqNQLoIdn95ffsXkLfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ut05zN+T; arc=fail smtp.client-ip=52.101.56.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpJz6gSTQpsrV8PpDl2593eyq1CSrnL5yTOwGaHE6XTLw129ByiiSm4dun1BMBSxEhlherNJ/EVOLhr16U/a9QxVrJwi3jo70ftQpumRiIQTdXKZALez/DPclXtTN/3GSwuAGx/nfHe04oA9GH0i/j5X4JOsXJQ24YU0Z7X6J4KXNNuYDr/JuV5YWzS60i1ic2146dBf646vEQR//I7v0r6TKJVMCelebV9HNk7JePZ4B/3zszOVmq/6Ljq0G5l1KN5/YrCXXlmLgdbx3a0k65zmNbaN+mXnK57XBk/LrNuvjZtFgJJ+Wlwqerd1+kkMB1Ejd5mG/P4gFHzLGbIXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyD46pDIZwqUvOkyo+Oh1ZG5FdnEADKeH5sUNu7jlDc=;
 b=QOpdK0bJitktOp4Xf938gp26lkusA/ZNH9dqWf/FJNZvt1xJ1+gjWsZ5aDYJXq8VUT2zdIkUZZ7RBqTh+u/DQ9OoQJHaix9yVPpfBxWxZnZi9ktZa3gM+8+pz5DSoda82TU0OGCsAyLvpBFnUb9LTNmjBcc9Cq740Zd0iQ0LRtgyZ0TdmZnk9WN2Z65gdzxFUMsO/NuFfaPkNWbOC9eDGkczWZ22dMUUDUGvfl7Z9eVBw0EbIf3mN9UXow+FyNjNdZt+wCAcfd5IkcOUkUX+hCmdPeSHhpmXBMT302kcu2UQzH+RmZElZwzCkrNdbewBgAmwhFl69BC5FPRwD7P+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyD46pDIZwqUvOkyo+Oh1ZG5FdnEADKeH5sUNu7jlDc=;
 b=ut05zN+TbmX88R+PIPHm7uZfnpqXfyAyrLo+Wd7kF/cidqZw+rCNjDZoo/0UHx4eCoKjb9zwk/rWcC4OKPYktJayfkl6b8J//Q+IxR/LGva3uf+qK3MQgAcdywYIq+f8eglRCvAZZUAMmNUDTGM+mu0l7EgGmOGdA0idp+/FH7VPXzvKJx3yieakHBnLa6O7ncPJKLhr+AfGH1FhMFuFjYhXsMgTTTwiv8qv33KJyuz0LSPGzvsNzoSOJ/Di+RqzeTLlgnFsxVL7ou0tSeHSYEDaIp6ei22RMP3EWBjhn/yL3PNTORW9ef5I0YWNXWooi/hEVDUGfQd6y/kh19gDHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Tue, 3 Feb 2026 00:05:48 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 00:05:48 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: david@kernel.org, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 harry.yoo@oracle.com, jannh@google.com, gavinguo@igalia.com,
 baolin.wang@linux.alibaba.com, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when
 split huge pmd for shared thp
Date: Mon, 02 Feb 2026 19:05:43 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <DEDED3EF-FB7A-4243-8065-F2D73B1FE444@nvidia.com>
In-Reply-To: <20260202235714.5wvxveurjfdka5pl@master>
References: <20260130230058.11471-1-richard.weiyang@gmail.com>
 <178ADAB8-50AB-452F-B25F-6E145DEAA44C@nvidia.com>
 <20260201020950.p6aygkkiy4hxbi5r@master>
 <C620202F-685A-4B9E-B51B-078EBE5BF0C4@nvidia.com>
 <20260202235714.5wvxveurjfdka5pl@master>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:a03:60::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 84984f15-068b-4d25-39f6-08de62b7fbf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bmPP6853QgR3RNSlIUyTYRW2uLS8hNj+ZrulZzs5ZSNjWexghvLuQ4ri7N4O?=
 =?us-ascii?Q?eo5z4psO2eYP1d1rNGNLljV1ZSTiWl67e7rtBVseKB95Zxa0KJqkpwYEPS/o?=
 =?us-ascii?Q?hbFS2tr1bqiUaLmZk9/gP8B5d4Lg+pbsRV5pCoKiY0AWBcPDzmCEtMG+XxVo?=
 =?us-ascii?Q?zSSkneziLPrRZJgdNoRtZxqjCsblhiy6AO6vYMs57VWzlGV2RNU7G6p0hEFp?=
 =?us-ascii?Q?tJ3bTPjuWRU5REiBQ+PX+PvdApv/mfXEQVMi/VnQxphvZbQIEc+WN/362tUU?=
 =?us-ascii?Q?yR/ZArtgJ+Gch1ZtFNQS/gDGNpJJouF2XuOksWMV22INum50GknK0VLAyx8k?=
 =?us-ascii?Q?dCkhHKOp0WH8bGkf2/j7++jCjk293QwNKFfBLSmtUjJOGEVrd0PGCnR/QZxf?=
 =?us-ascii?Q?CNsYANgsEfcKR5dy9XriqqLAylxYSbdiNp3c3V5545o+cfJ3V5kFSs5Nwv6T?=
 =?us-ascii?Q?W+nDZtS+1bBEth8qy4NdZtk2OhI1x2YzcrGTGCX7WI5PHHdXzNEowqTP+5XZ?=
 =?us-ascii?Q?dF5/wmAzULZVAELFbWunMdXm2+t7HEdGlGGa5trQUo33zqGjZFNWrVTO77B5?=
 =?us-ascii?Q?FKHvOX6yeeDZwl7/WjiAWBjm7es4ibQHZFkyE1o7dK+RTxCg5knlW8RbuNXQ?=
 =?us-ascii?Q?zrTtKDc7zIWHSFfPjI8I2S+lP+Sl/CHC+Sr/DRRxbx0wQFAeAuqvZv4AiPus?=
 =?us-ascii?Q?SWZCZMhMb1H+qmfgt8OgCy7obp+mDXwAVpc7fcN+C10U5KFj4m5mKxqMmLH2?=
 =?us-ascii?Q?HmENiXGupT1EjCl2QPmNe+LFF/AjBHKobDpPCITkVr5uaZickfiZpvfwkmHU?=
 =?us-ascii?Q?A2Yv4sLJ8eQlDDchDXtAszcQmEZkqxW01vqXbKOpRZ11FRi93hKVPzYbiioz?=
 =?us-ascii?Q?E4LaZDIvdX/uSP1kNUuaSiQF0eptxPZDFb+CRWNAGpDuRK53oLn9e9I/OsjN?=
 =?us-ascii?Q?2VLNLzDdpt+xA8cGONBPiHF19VUuJCv9o9SaOM/WiJZSghfgXcJN1ev9F52a?=
 =?us-ascii?Q?s/rOfwmHcx/1a+5HkCzn7dTutEmC+tGWf2nmIR6jyTL5yQs/chVw2B6ksxTS?=
 =?us-ascii?Q?ahWtvGA8io6aCeXxCWI1ngA2arUmf9xMhNBJzrHhOU52FKPINJrr/RgtTXcT?=
 =?us-ascii?Q?rX2+3IF37jc3aKWm+9PykGxfrA3cihXcIs1cq7iCnZtQoFboiElk0a3y5x4M?=
 =?us-ascii?Q?QOFTtA0Jcs54Ap/Vc2d4azWc48jW8Q4jpgK74m4TDyQ0ohfdnb3yGMhNGFmY?=
 =?us-ascii?Q?Ev6ya6C5cqUERU9BpbY6goAlYa778Fa5l5PUMA+xPyvMmxt+Yeb0dz4hhP+J?=
 =?us-ascii?Q?y58yy0PVYHTxQyHK9JXwpaTU82/0MSL/XRN/bag4eW6LzuZ4nPchjQrt2XAF?=
 =?us-ascii?Q?+nsKStUlcFyYeeI9964P2emONyMO2PBTRSDNuqml2UEtjhDDzqbOPUtsZ0Uk?=
 =?us-ascii?Q?eqWBR5PIqwilBADe+ol+UMuFqx9aYV6qpTd+d1JqktgGGb3/KcMfJbjzS1/b?=
 =?us-ascii?Q?+djpKHDhg6BkuhJtu8oG4g0TKss3iGsOXlUzX1KRVdyJ4L8LyQpL6h5I5PtC?=
 =?us-ascii?Q?PpeZcsI7OJ6Qg5eoeDo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbb8mO2t04cvyI2PCz3PCSsoHp/sYEfdT/wjtSje9238brZtnMNcBaB++zQW?=
 =?us-ascii?Q?cvhjJ+NCNhq8Iw7s+8GxEBeoahDCSDKqReZymjmvvu834t5kS3Ee20sqJx3M?=
 =?us-ascii?Q?DvXIJqpZmSZfOUZwThVrik9kRk2+rDJIm5PvLywQtjkSH3Kx3ye/Mp8EH3yS?=
 =?us-ascii?Q?TM5dVazMHThsZe9lsXCNCYTI3/YULY8evFT2skmAzMRtGnBTOxfoYMtTBIxo?=
 =?us-ascii?Q?kFsUHIdictpgZ96DyNcPQw/OXHusMJFQIzq1NjY6ziQpC3/YHKtY7lT0nFTY?=
 =?us-ascii?Q?7jvvCyvdMEpVd7qyaksdAp+rMqEa3giq9NmtvNghtQOPS7EYzbUdJV2pRHks?=
 =?us-ascii?Q?cSNKAhKSxrKXaF3/l00t9IS+hWli3iVcsriBeLLPtsZlx7Od412hT0FqmWVg?=
 =?us-ascii?Q?pyvYQ4DA6FezvbB5mACYyRoWDHudfkZRTDtqkFfU7A4JCpOWFfLH6NUknJ9r?=
 =?us-ascii?Q?JRJijLhkvvP/tolaKE97E1emiCBJlp/70XX18xeD6AJyl5r9Z1YVYH7K2aea?=
 =?us-ascii?Q?Au6+AR4cu2UzBHJ0P7CmA2UClYHOXnE/GDiOLQvJgsRyZMo9/iMwxpUi7Jz9?=
 =?us-ascii?Q?zSPWwDarLHRjP/bmSpHnaRBxex0VQuc5PaEWoNMDg8QLDe4CqwPjarJY8XfK?=
 =?us-ascii?Q?uKVcjlotg8LszNuAaj8DMPO2nGiZI1UFrszF6D5DOMNe55ImCxQn59ms4a+W?=
 =?us-ascii?Q?hN5jT+uMHQlJ2zagQXypNuZDdAtm+IKSdW4uONBX+e/1NUoHA6dE6rdjLlUR?=
 =?us-ascii?Q?tpDUBTZjdFC4GWyofy0usjnhSe/zrrlXwqYb8oY86FzCmYKmRInYcSG3XACd?=
 =?us-ascii?Q?bZ2LkmWET6y2nf1gzJYN7CiCOlplfO3OAYRRnOm5bWX6p9klu/t7tcq22oju?=
 =?us-ascii?Q?24hQDGJDYO7MnQAH2Gbhh8SI2/Eqf44xI/i0cREvvwhKSlYRVo08JA367uBG?=
 =?us-ascii?Q?Ap6E5/R5wNCG8t0x2Xqg0UuoL729rcTrD4FYS2ysGlxPOWkg5IIIH17nNoPm?=
 =?us-ascii?Q?U6szJX75TKeEq72W4xctvCGD5RGgchCviucR2wIwn1Bt4luwgXYqAhvL1R+T?=
 =?us-ascii?Q?fRGPhrMi1GP/9I7UPcM5VNFtiSfY7m9vJyAiJLTsxXGZJEDYCQF36xXfwKYc?=
 =?us-ascii?Q?B+9bcapHq+i7Y+NaWKxBB+JPSkLNi1EtC+G7xRFVpwChGKFrYXg9EMiPq13M?=
 =?us-ascii?Q?XaeijOJ9bF9HL0bCrPiJwNuhQoqDS0JsRCtO7esDWCCOWssdn9qpy4SnZMdg?=
 =?us-ascii?Q?EGKlTXFLsvsDiVisX5u9rwwUEfIH0ybKQFAXU+ypLtOwa5zrKXTd5bMuoGKb?=
 =?us-ascii?Q?ImpdF+RiktJ5dypIX3+Czk4iv99A0f0d72uFlqntc9O4JVftUH0oDGNYKsoA?=
 =?us-ascii?Q?ErypL5M/VAeD26fuGPZpiU2ISzBclziUaqkIgIR/OOijeXy/aqVKASgCmzhn?=
 =?us-ascii?Q?l7SYTiIArYcyXVGPKoW/RVrOA7lVRyeFLZlLAioC7NRZ7iozwrLc7umtEuqq?=
 =?us-ascii?Q?tG7CrUm3SdpiftF0YXkKYIl5vQqKcbyKBgGYLGM7NqJWQl3fWqSwtKkRjzJ0?=
 =?us-ascii?Q?crkEZpL5Dz1LgR5oo0s9+FtcPCnBytSewMLZdBOfr/u9yPrdyHSuhH77Or8W?=
 =?us-ascii?Q?fixekxz2MVLi9dJL5rlckR1FmhYqy0O1R5L4zQ+n+yk24ZGn/egF/T6UU1IW?=
 =?us-ascii?Q?krDWicTyN8nxNfVOFvU1bO5SJ8395ovT0XIsEVEfvJXQUv3A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84984f15-068b-4d25-39f6-08de62b7fbf0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 00:05:48.0953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCkTACvxCMwIdN2hz0ZkS0ud+dfPlx3AnJvc8O+BvP0itPJuHzZgABACqpPVGBYX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-213132-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: 863FFD2D4D
X-Rspamd-Action: no action

On 2 Feb 2026, at 18:57, Wei Yang wrote:

> On Sat, Jan 31, 2026 at 10:39:40PM -0500, Zi Yan wrote:
>> On 31 Jan 2026, at 21:09, Wei Yang wrote:
>>
>>> On Fri, Jan 30, 2026 at 09:44:10PM -0500, Zi Yan wrote:
>>>> On 30 Jan 2026, at 18:00, Wei Yang wrote:
>>>>
>>>>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() a=
nd
>>>>> split_huge_pmd_locked()") return false unconditionally after
>>>>> split_huge_pmd_locked() which may fail early during try_to_migrate(=
) for
>>>>> shared thp. This will lead to unexpected folio split failure.
>>>>>
>>>>> One way to reproduce:
>>>>>
>>>>>     Create an anonymous thp range and fork 512 children, so we have=
 a
>>>>>     thp shared mapped in 513 processes. Then trigger folio split wi=
th
>>>>>     /sys/kernel/debug/split_huge_pages debugfs to split the thp fol=
io to
>>>>>     order 0.
>>>>>
>>>>> Without the above commit, we can successfully split to order 0.
>>>>> With the above commit, the folio is still a large folio.
>>>>>
>>>>> The reason is the above commit return false after split pmd
>>>>> unconditionally in the first process and break try_to_migrate().
>>>>
>>>> The reasoning looks good to me.
>>>>
>>>>>
>>>>> The tricky thing in above reproduce method is current debugfs inter=
face
>>>>> leverage function split_huge_pages_pid(), which will iterate the wh=
ole
>>>>> pmd range and do folio split on each base page address. This means =
it
>>>>> will try 512 times, and each time split one pmd from pmd mapped to =
pte
>>>>> mapped thp. If there are less than 512 shared mapped process,
>>>>> the folio is still split successfully at last. But in real world, w=
e
>>>>> usually try it for once.
>>>>>
>>>>> This patch fixes this by removing the unconditional false return af=
ter
>>>>> split_huge_pmd_locked(). Later, we may introduce a true fail early =
if
>>>>> split_huge_pmd_locked() does fail.
>>>>>
>>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() a=
nd split_huge_pmd_locked()")
>>>>> Cc: Gavin Guo <gavinguo@igalia.com>
>>>>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> ---
>>>>>  mm/rmap.c | 1 -
>>>>>  1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 618df3385c8b..eed971568d65 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -2448,7 +2448,6 @@ static bool try_to_migrate_one(struct folio *=
folio, struct vm_area_struct *vma,
>>>>>  			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>>  				split_huge_pmd_locked(vma, pvmw.address,
>>>>>  						      pvmw.pmd, true);
>>>>> -				ret =3D false;
>>>>>  				page_vma_mapped_walk_done(&pvmw);
>>>>>  				break;
>>>>>  			}
>>>>
>>>> How about the patch below? It matches the pattern of set_pmd_migrati=
on_entry() below.
>>>> Basically, continue if the operation is successful, break otherwise.=

>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 618df3385c8b..83cc9d98533e 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -2448,9 +2448,7 @@ static bool try_to_migrate_one(struct folio *f=
olio, struct vm_area_struct *vma,
>>>> 			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>> 				split_huge_pmd_locked(vma, pvmw.address,
>>>> 						      pvmw.pmd, true);
>>>> -				ret =3D false;
>>>> -				page_vma_mapped_walk_done(&pvmw);
>>>> -				break;
>>>> +				continue;
>>>> 			}
>>>
>>> Per my understanding if @freeze is trur, split_huge_pmd_locked() may =
"fail" as
>>> the comment says:
>>>
>>> 		 * Without "freeze", we'll simply split the PMD, propagating the
>>> 		 * PageAnonExclusive() flag for each PTE by setting it for
>>> 		 * each subpage -- no need to (temporarily) clear.
>>> 		 *
>>> 		 * With "freeze" we want to replace mapped pages by
>>> 		 * migration entries right away. This is only possible if we
>>> 		 * managed to clear PageAnonExclusive() -- see
>>> 		 * set_pmd_migration_entry().
>>> 		 *
>>> 		 * In case we cannot clear PageAnonExclusive(), split the PMD
>>> 		 * only and let try_to_migrate_one() fail later.
>>>
>>> While currently we don't return the status of split_huge_pmd_locked()=
 to
>>> indicate whether it does replaced PMD with migration entries successf=
ully. So
>>> we are not sure this operation succeed.
>>
>> This is the right reasoning. This means to properly handle it, split_h=
uge_pmd_locked()
>> needs to return whether it inserts migration entries or not when freez=
e is true.
>>
>>>
>>> Another difference from set_pmd_migration_entry() is split_huge_pmd_l=
ocked()
>>> would change the page table from PMD mapped to PTE mapped.
>>> page_vma_mapped_walk() can handle it now for (pvmw->pmd && !pvmw->pte=
), but I
>>> am not sure this is what we expected. For example, in try_to_unmap_on=
e(), we
>>> use page_vma_mapped_walk_restart() after pmd splitted.
>>>
>>> So I prefer just remove the "ret =3D false" for a fix. Not sure this =
is
>>> reasonable to you.
>>>
>>> I am thinking two things after this fix:
>>>
>>>   * add one similar test in selftests
>>>   * let split_huge_pmd_locked() return value to indicate freeze is de=
grade to
>>>     !freeze, and fail early on try_to_migrate() like the thp migratio=
n branch
>>>
>>> Look forward your opinion on whether it worth to do it.
>>
>> This is not the right fix, neither was mine above. Because before comm=
it 60fbb14396d5,
>> the code handles PAE properly. If PAE is cleared, PMD is split into PT=
Es and each
>> PTE becomes a migration entry, page_vma_mapped_walk(&pvmw) returns fal=
se,
>> and try_to_migrate_one() returns true. If PAE is not cleared, PMD is s=
plit into PTEs
>> and each PTE is not a migration entry, inside while (page_vma_mapped_w=
alk(&pvmw)),
>> PAE will be attempted to get cleared again and it will fail again, lea=
ding to
>> try_to_migrate_one() returns false. After commit 60fbb14396d5, no matt=
er PAE is
>> cleared or not, try_to_migrate_one() always returns false. It causes f=
olio split
>> failures for shared PMD THPs.
>>
>> Now with your fix (and mine above), no matter PAE is cleared or not, t=
ry_to_migrate_one()
>> always returns true. It just flips the code to a different issue. So t=
he proper fix
>> is to let split_huge_pmd_locked() returns whether it inserts migration=
 entries or not
>> and do the same pattern as THP migration code path.
>>
>
> You are right.
>
> BTW, I thought PAE stands for Physical Address Extension and confused a=
 while :-(
>
>>
>> Hi David,
>>
>> In terms of unmap_folio(), which is the only user of split_huge_pmd_lo=
cked(..., freeze=3Dtrue),
>> there is no folio_mapped() check afterwards. That might be causing an =
issue,
>> when the folio is pinned between the refcount check and unmap_folio(),=
 unmap_folio()
>> fails, but folio split code proceeds. That means the folio is still ac=
cessible
>> via PTEs and later remove_migration_pte() will try to remove non migra=
tion PTEs.
>> It needs to be fixed separately, right?
>>
>
> Current __folio_split() logic is like below:
>
>     if (folio_expected_ref_count(folio) !=3D folio_ref_count(folio) - 1=
) {     --- (1)
>     	ret =3D -EAGAIN;
> 	goto out_unlock;
>     }
>
>     unmap_folio(folio);                                                =
      --- (2)
>
>     ret =3D __folio_freeze_and_split_unmapped()
>         if (folio_ref_freeze(folio, folio_cache_ref_count(folio) + 1)) =
{     --- (3)
> 	} else {
> 	    return -EAGAIN;
> 	}
>
> You mean after (1) and (2), we don't check folio_mapped() and continue
> spliting? Hmm... before continue split we tried to freeze folio with ex=
pected
> refcount at (3). This makes sure there is not extra refcount except in
> pagecache or swapcache.
>
> You mean this is not enough? Not sure I follow you correctly.

Missed that. It works. Thanks for pointing this out.

>
>>
>>>
>>>> #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>>> 			pmdval =3D pmdp_get(pvmw.pmd);
>>>>
>>>>
>>>>
>>>> --
>>>> Best Regards,
>>>> Yan, Zi
>>>
>>> -- =

>>> Wei Yang
>>> Help you, Help me
>>
>>
>> --
>> Best Regards,
>> Yan, Zi
>
> -- =

> Wei Yang
> Help you, Help me


Best Regards,
Yan, Zi

