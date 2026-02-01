Return-Path: <stable+bounces-212998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNgcGkNhf2kMpQIAu9opvQ
	(envelope-from <stable+bounces-212998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 15:20:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA421C6207
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 15:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C21130075E9
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B582D33BBCC;
	Sun,  1 Feb 2026 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J3eWbQVJ"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B4186284
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769955647; cv=fail; b=sIXhXc99vCBFg+5K6BsPWIZ/XZFI0zra9vfRh1r8ViI6pay3/7eDM4AIkcczaxgTdAhzXidKMmtaT+vO/FyFs/8p+TI8isH7gQzwE8XKvsiOuMszAS0hGrD2wqus2uZSKcnEBhXhu7kLX5kGQf7Tdgk3jilzx82w27SX3tCEBSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769955647; c=relaxed/simple;
	bh=pH/B65aIggGaAYdppNMzNiutnmo9KV6S7L90GvMbMrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jl2Od/rmS3jnoJiS4+ZYBwdeZ/O3uReaahcl9dUY/tH8QiydBR6ts/7W0gmV/xlEC3IrvuY8v3bi9K7Yax1ondutUXZV4vxmU6dR8ZmzBgXevVY1iGCrSxFG/rrkQrX0dHBDGQCt2DGQT3joGuzFfVuu09rgTDeByBo4yZGtkk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J3eWbQVJ; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRS4HgnTF8FUqfBtOivMPDGFVF6kb5wVAeA7eKpfeN0bOcPzPRZISycC/g/AmsQYRoGVp0x+5VRxqheMj2HyqbKCP9YDB8S4EflRCmmlluvKAPrjoO6GTG94sHkmUUYsK/yUI0/1xUotv8+zP9HSGoES0H1D2lspLuVd8SQoJgwNypR5jqn2DlW0bBGpDgTIXucVWPjJa5AZ1yhceSx4SRzC/HsPz2+LgrzJWnbcI3R9yIji0mH4JOtt0Odv0X1SyTS7KKiFvrsVQAPNDHqU6OtKiTL9v8tgVV2d1Z2LiJX1g/8lPQFPi/qcekTLu/G+1wcSh1KhB3QM5073RcCEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qv+JVEHDdjBmOZ98NkQGlV6CzsomhRmJEqGGJCbERJk=;
 b=WmqUrXIcvdcYtQT6v4/oGg2DuE6nRYUedWVcVkHZ9Wz/tmYWx0EHhWvzeqwq0jJKXp1M3V0eV2rtahekdRj7lxM4ws03A6Lj6JtarVyHc99rnomSuwVlDyuVxBsNjvaxW8F54jG9sN5TbF80w5hluviSE8H1zwRg3k9Hqpn447TA3Ja4MkbFy9CLnsOBonTHmy1whyVr/eDvTfcwEnFFSdD+NQv2/SsZMyNWgBLSWsVkkxKgGdQgLgzm/WAlfjHbmNn+hwi9yRr9HmHu9ebbq1gCb5RVILeButW4F569O5YV7Tn9/FmRYyssW4e1jUXG9aQ5JUP4WWVGY6ihuVL9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qv+JVEHDdjBmOZ98NkQGlV6CzsomhRmJEqGGJCbERJk=;
 b=J3eWbQVJE0Z9G1k5jqrAnrvjTj56Wr9lje5V6MafrVrfYnWJQSQNOy1jB2NVtee53ijxz5Z5jq3xycFtHVdZ6LeHFth94rAdwfrUaVDyYKDxcgNF/n+qmhDBFAa3p1nKgYlUllYKdB+foVz0Qpo/tOTAsYKjbE8vY3xGrdz7MkusEI+9VcR+cClS8dh1jOtXbjA963rwJKuXO3Cv8E/duOHUABqmKmqU7zAOZQRe4LOTYLs6NNUXwmOoCeVw75YGuzNBJrix1grvYKrUpKE1X9arCyw5496PfAHKBr3lT9Wl9MIwvXAEVZuTMtiFihwunNCxMWfbR1hzvVgnyX0L1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 14:20:37 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9564.013; Sun, 1 Feb 2026
 14:20:37 +0000
From: Zi Yan <ziy@nvidia.com>
To: Gavin Guo <gavinguo@igalia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, david@kernel.org,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
 stable@vger.kernel.org, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when
 split huge pmd for shared thp
Date: Sun, 01 Feb 2026 09:20:35 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <4D8CC775-A86C-4D80-ADB3-6F5CD0FF9330@nvidia.com>
In-Reply-To: <08f0f26b-8a53-4903-a9dc-16f571b5cfee@igalia.com>
References: <20260130230058.11471-1-richard.weiyang@gmail.com>
 <178ADAB8-50AB-452F-B25F-6E145DEAA44C@nvidia.com>
 <20260201020950.p6aygkkiy4hxbi5r@master>
 <C620202F-685A-4B9E-B51B-078EBE5BF0C4@nvidia.com>
 <08f0f26b-8a53-4903-a9dc-16f571b5cfee@igalia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: IA1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: d4883a1a-e987-4a5f-f2b2-08de619d11dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tr67FsznBYRt2YAQbjqXaZkvmb2EpnzCp3heanoWMTGQ0OFr79fMi4tG1G0A?=
 =?us-ascii?Q?+5R4CekEDdiQ7YOGqXta4AQPGdo375FctQNt8XTR/kyMAfAHqvH5GR0yra7u?=
 =?us-ascii?Q?RR2IxvRlffdOUvFU0ivbYq16a5aBNegda56/tFp0EfryX32KlA2PA0o/11lD?=
 =?us-ascii?Q?eqLsjPnc3SuHaKSZ6nL0CZvNQUEc6bzmYgcv+fe6jnuTFfTqqMbZ6s4wSzWE?=
 =?us-ascii?Q?LB5YZwFF/EhOYph+bwzlKGSjKMkaf/i43sf0Xk8BRsmHOVT56lylhBSyypcq?=
 =?us-ascii?Q?IFGjYXTQUQdKD8Ziet5r1k63w/cQLjepkaK/I3YE2SxyHFujeE51zJ1ysmdU?=
 =?us-ascii?Q?rassp7GCLryukWeDS1IvF8W872AEpY/Q6LgTdtGLs5wZL+Y/q72xac9ZfHlb?=
 =?us-ascii?Q?OxsosJj1QrGfbrgG+YKYZlqQa+0FFL8AD4/U2G9MqnRIF61iDLe1/+4wTWR+?=
 =?us-ascii?Q?VMJAVk5YNkhb8dXMp8qn9JlXWcSdEtoA+egola4hWQ988xX0IxHkoXBwVWDt?=
 =?us-ascii?Q?AsregF0aHxMHZTCJpL0x2Ao0uv1G+5R3LCNSBjSJegMqAWv1sAyH5qPlPUjV?=
 =?us-ascii?Q?GacRM9PmCcGQw8SidwODGVGNO36NkeqhjndLmh6RfwgiRGqsDjL8lalKBKEo?=
 =?us-ascii?Q?NHXItigV26LHJ/Irh0xSAQzMfszYKa855xXG3NqLzTA+chOWt9ssC00e+M7y?=
 =?us-ascii?Q?D6b7lNtpOesgJ7n7Ulxgk+E4c3L5DiWqUIsuotel/Tq/TY6lggUR2t1VmCMj?=
 =?us-ascii?Q?PuyHkhzxRUfd7nxd3RMO2eoEnBr+2rfH2RI+AqoAt1mQAEdCZ8JbGA7gkn63?=
 =?us-ascii?Q?1DaAcmrq+XIde74yz3cs7o+Rk9maG2TRuy+zuXkZgDDvM24y2E4sOi5TA4NY?=
 =?us-ascii?Q?5nPbWHQTmR4qiUbTKrlQYK9vfwG9anKEg/qBcT6FnDFS/x9JReW9Q8VnIkto?=
 =?us-ascii?Q?CA/UaYUpemkq8YmacQVU2tOQgKevzOljv0QmZJKzmeldrBy/ry5HL8PFOn1f?=
 =?us-ascii?Q?kRCFJzwXDEEtNIpbALY+qiecasuAa+b7ya6GiM+D3Cb21B1n8dg1AFAkqdgw?=
 =?us-ascii?Q?OB7p5l6XTLPRjjmu82SxcVzoWq9I6x6LB1nV9eeG3jnk313vDVpxyuzbEjFU?=
 =?us-ascii?Q?2xUVyM00uUF2x85Kd2C/1PsyL+yCaGK15Eu4t2xsXZAmXLnSd0AyZPp/mBIh?=
 =?us-ascii?Q?gfM/rSlxDmoH1ThLNa2JqhheajKyD+VboZCL87K9f2fe7uPRb2xB8s7fi/0E?=
 =?us-ascii?Q?I2/mRL24EjaYitAjAecUiuxl3KUJbnoAEH1QdMcOTBXHOdG35hILAr06eZfF?=
 =?us-ascii?Q?ixzMLPZjWzP/3HtGnbzhQrNNuirJsPGYARb81UY9IbEYI4xJoks7TgjEc+vv?=
 =?us-ascii?Q?6DUnj+Pte1OtxUBfSS2S8HbRC+iDfYyFQAusggp9uC2MZwHS3CUJyrBeD/wi?=
 =?us-ascii?Q?ZPRc7mdFwmr6Mx8VXgj8gEiKHNC2velNgzw0VKsAu+usvrJPYnblyvxkbLlz?=
 =?us-ascii?Q?oXeqn7wiT4eSRyB77J07H9CrwfpUx3+2NsEWRfQa120EkTPxlGFaKHgAKdYc?=
 =?us-ascii?Q?mtlWSTOFuUsRQ+c0r14=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bjLhsHwZEONP5uB5HaN0vdbG6vZM6gkFTEAzeHfG16W46sar+lVBQNQPIqFh?=
 =?us-ascii?Q?8N1q44pmngoIG0PMrVBDTOD37nFYvnsqlJYM4p5x0bJUHnEGFblSumYcdWa4?=
 =?us-ascii?Q?0+GoyazN9GqC8Wm4LykxfrLIwq+cqQFKcnNu2UlkJ1EhMaJiyJ7oRKw3qofL?=
 =?us-ascii?Q?UVk6tSGEtYrHevG17S2tyTJ0m8TcaDG2HyjjwgS+WyD2Puqn5MjB6bEmdMzM?=
 =?us-ascii?Q?bjYZ5zAZKWAIVhwGAZ2BC0RgVCnWQ2BIzL3jnAedC2H7tNag4G2VA3+FpBHb?=
 =?us-ascii?Q?pNgWn/L85ZL9o0nH1ov+MUtNOMsYLJ41KSfDLMcyBDAw7inqPK9dfGZSdROh?=
 =?us-ascii?Q?xh7OcjkxGK4ad6KfSfLi9HnwV70hGNtv3uz6//mq9lfmJxKgGhtuskUoGGgf?=
 =?us-ascii?Q?BoQAgHykx3JIkcVcllujiwTKpHFys8rlZhv9aDbKmWaGYoO6wddM+deC8lGZ?=
 =?us-ascii?Q?KSHoDRsg+62X5kXSRrH1MhFeK7sS6NmbVHR3R67DZWxT93WxZgB2X+801voq?=
 =?us-ascii?Q?/uUwcctx3j/QvqvAntl4ELYBPbkao4qZ0FUev6xU9U6yull03jbWodzP6zgT?=
 =?us-ascii?Q?Rc8oxPf9VNT4guiVEc3dlTbVmFqOPoU9LkITfKLsweDgCsjBCa6z/8HOwco0?=
 =?us-ascii?Q?IYJvwFbPSeo9VSAE0wRRTz0duRLz8nZA7iyr8EJ6tsBrJIzygPdVW+qNu6xj?=
 =?us-ascii?Q?VbakRP5jfnxBrgdVh6ZtkA+tYQDf09qhIbi5hqR4/GvABbOzYTCa7bu6BOKI?=
 =?us-ascii?Q?yh8G8dbSpjM/fF35t/tBWnj4K7M1DsXNMRw8xkRoPJMaebiT+FYtWlmuJaKr?=
 =?us-ascii?Q?zcb6OcJUeFy9Gydy6A4dNnh+8UF5EsHPXzVCcXQvZr7GXhw7tWVJ8OMgKFEB?=
 =?us-ascii?Q?/HdHAIcnvMmKjSYvXqFPDHXZocQN4Ac7W0jwoAwiqRqRTW9RGFI8iM632LlL?=
 =?us-ascii?Q?1Ux8mmC1ybuOlALuGnR2TiBvpOjq2C6wWs01gVgLIekf0KvkPUAwQvwP7xgm?=
 =?us-ascii?Q?qs7nci0AGC7a/JSfIwUnFJBvE9NhFfQVHWkrTKRTvkhv7Ip498m42c5w5PSc?=
 =?us-ascii?Q?FcsOE6VnVd1LcMR9l4zDZU1RN038uDFzq9+oXTe1zv2mrIqskq9C1SzdnU8s?=
 =?us-ascii?Q?igqIzKub5MKPawO6X4bB8Tl5eED4WGWPxehb5sJgXa4HVqAmK5D49Vn8S5VV?=
 =?us-ascii?Q?NNLHOST36cMYXm6LalH9php8Tsrd93gaiENeXpWkdxEyVAY5ovtkFmm4DEmO?=
 =?us-ascii?Q?rLYtOfRZHONq5Rb0fU81PhdE8q/pCWCjX/pOKBnTw0gEs2WVswXavzDqAvws?=
 =?us-ascii?Q?Cleb7XC8Pk4xTY9x6EpAyFjXTldefSxntsot2/FArYqFYIc8YUp9CL57PUKk?=
 =?us-ascii?Q?byjPrjtQYKTEJ0Mpni3zyXOhBokN+1VfwFtcShyl8lZ60jeujQDBGPPsGU9l?=
 =?us-ascii?Q?ZCGk8xuXdrO8t5dOrrcWj/AosXOgEKnjcJwzVawc2FSRn+gEUpTI87XIKo/J?=
 =?us-ascii?Q?KgIuGtlh0qQT8lUgLUeJ4Q+R+mTy2x9D2OucAUAY0hLx2PYReXix6f3iFWkQ?=
 =?us-ascii?Q?nK3+2CWfOeDBcMw5HXpIWqBGjZocgoBbtKEujhDg/HpimHgpxnERWV7kP8xL?=
 =?us-ascii?Q?/l+avEd/u7UaGeSiOhN4rgoww8mT9gHBmcMCGFd/PEtSkfTRHdZMqwWEXDRR?=
 =?us-ascii?Q?bZrIdqmGW6QTmELd3QUhZUWt23AU/Wh1twm7OUdPwgu7roU2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4883a1a-e987-4a5f-f2b2-08de619d11dc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 14:20:37.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUdy9Ff2C1GpXvaf15C15a7OfcuU6Z2IvLBr/kvmF2FdnwZbTcC4nOQv9/J50OlF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux-foundation.org,oracle.com,surriel.com,suse.cz,google.com,linux.alibaba.com,kvack.org,vger.kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212998-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: BA421C6207
X-Rspamd-Action: no action

On 1 Feb 2026, at 8:04, Gavin Guo wrote:

> On 2/1/26 11:39, Zi Yan wrote:
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
>>>>>      Create an anonymous thp range and fork 512 children, so we hav=
e a
>>>>>      thp shared mapped in 513 processes. Then trigger folio split w=
ith
>>>>>      /sys/kernel/debug/split_huge_pages debugfs to split the thp fo=
lio to
>>>>>      order 0.
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
>>>>>   mm/rmap.c | 1 -
>>>>>   1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 618df3385c8b..eed971568d65 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -2448,7 +2448,6 @@ static bool try_to_migrate_one(struct folio *=
folio, struct vm_area_struct *vma,
>>>>>   			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>>>   				split_huge_pmd_locked(vma, pvmw.address,
>>>>>   						      pvmw.pmd, true);
>>>>> -				ret =3D false;
>>>>>   				page_vma_mapped_walk_done(&pvmw);
>>>>>   				break;
>>>>>   			}
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
>>>    * add one similar test in selftests
>>>    * let split_huge_pmd_locked() return value to indicate freeze is d=
egrade to
>>>      !freeze, and fail early on try_to_migrate() like the thp migrati=
on branch
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
>
> How about aligning with the try_to_unmap_one()? The behavior would be t=
he same before applying the commit 60fbb14396d5:
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 7b9879ef442d..0c96f0883013 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2333,9 +2333,9 @@ static bool try_to_migrate_one(struct folio *foli=
o, struct vm_area_struct *vma,
>                         if (flags & TTU_SPLIT_HUGE_PMD) {
>                                 split_huge_pmd_locked(vma, pvmw.address=
,
>                                                       pvmw.pmd, true);
> -                               ret =3D false;
> -                               page_vma_mapped_walk_done(&pvmw);
> -                               break;
> +                               flags &=3D ~TTU_SPLIT_HUGE_PMD;
> +                               page_vma_mapped_walk_restart(&pvmw);
> +                               continue;
>                         }
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>                         pmdval =3D pmdp_get(pvmw.pmd);

Yes, it works and definitely needs a comment like "After split_huge_pmd_l=
ocked(), restart
the walk to detect PageAnonExclusive handling failure in __split_huge_pmd=
_locked()".
The change is good for backporting, but an additional patch to fix it pro=
perly by adding
a return value to split_huge_pmd_locked() is also necessary.

>
>
>>
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


--
Best Regards,
Yan, Zi

