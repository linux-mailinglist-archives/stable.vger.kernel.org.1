Return-Path: <stable+bounces-109635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD0DA18146
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 16:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26263A2FEE
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFFB1F4270;
	Tue, 21 Jan 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="Vgldks0E"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2130.outbound.protection.outlook.com [40.107.22.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3CE1F3FF4
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737474107; cv=fail; b=M1SPsLZBbge84p256da2F4iJNCrS+DuaaT1ercpAV/1EdIR0+29Sr5Eyi4ANX27vgWWLAJ+3vHBDUs40JXJoQuLDxL6uR1+s0lRDNgNI10c6kcnFlwJia1mZcqV/cD7ewFAKIGHgSiOtFOS/KBGQSsldrUIIt/9VtdwPdGQG5o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737474107; c=relaxed/simple;
	bh=+/rNes6SiZf4UBbjT08/NRsCuPnqLFEb7qmtZdsucQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=thG+J1amIWZ+5VnS3YEdUXgj9O6i9Hb0+39vV9pWOQ0Mms+vM2Nt1t7h12RomN5kgSVZBNO3OOHyHIG3kwyek7+ZhodJLziQlIOXuxma8H2yaRrr+rQaAigHlFyvf3v0eGkTXAYuheNLarxe8A7Zh/gkJGuy33d4J/aF02un8KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=Vgldks0E; arc=fail smtp.client-ip=40.107.22.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7NwIAsAVxhGqu/m9d8SjQ1A4V9WguGwACB+pIzmWK3ZvkTusA3fHNp4LfBnhC7M/YDf5cqsOZ27xIsDf14U7tcjqtvUDliwnDIit0CW3GVcvc6SDurejmJ/Q4RdZQy9xpYBB+dKyP+6YNvNYRCWeMEAl4o+RPHu2r9cmjHy++XQDDdQCwEiSU3QD171BbftM341k5BggGa/r+MuOtjXm+QXLU6GT4P9ZiEmRu5cwQgwbAbtQgqvGysVpzFvAgO/FiSoR6H5DtmyHZGnaaDJicHqGh4HGj/RANnQUyNF8RyzI/ne5t5iGtcTvfmmafswPBRrjxB1ixjnGyehYRbtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xECHvzLyoZS9HtIow+EEjs4minIzLe/fvPakCYt+3KA=;
 b=TlqmhASqnXzyu5YRO5tXiGfg0WY/p7G6qeYeiN3v9IAqww6NJzeZ8v5n7MM19LQq9iL1JC31JLFSN5HeguKYxfDfcrT2zCkJvoKclMuBQ0jcEO0Lza2FrUoTb6X9GoXNIXV9GVrig9peLQsnn3ZzEMDdgxzHPlOMev2SeTYKmkulB8FLB7P4rL6ym86tb/mkF8BB4nuVDgK1WcPd5bxVXVCN3I5GUZkWRdlaTLRn8sN1pQzlwJeNh6jgAQB04FpGy2attf9SfTPZPcyec7DVYNfKi1Hr73teGgUsUJXGZ0k7aauvZ5pRrLZJrGWjgnXQb+u3jWmxeUTu6PvH/zCXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xECHvzLyoZS9HtIow+EEjs4minIzLe/fvPakCYt+3KA=;
 b=Vgldks0EGyGsFbH8mdvLhohDtEz48+BZyTTeF1g9JXjE5Dx/oVtHerkQvZG+9pFtsL/4dJibnpTi928YY/WRB9rL71mhGWzO3j0ghto0M1YdEu1H6BxsVZNK++00FQycHWhcydOBawoWpSLiXiRAuzxNdJxpDWxjsgxeN9XQPcrAKgJp4h/AU46m6JOypDn0CP1WbXHiYEIxV21O4yg/bCp4LHX3tkpsEzd4XxAXOxQg92/ewO6gOflTZY/yjtuUBHKCme8ZTd8FgDqcF/UMPctnyJxWLzRnsF1oXLaECaPP3eWRRlNcqTUuiKJNASDbFZvbJ7Lzh5vrpJM7oJ6Kag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DBAP192MB0988.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.23; Tue, 21 Jan
 2025 15:41:40 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%7]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 15:41:40 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Xu Kuohai <xukuohai@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	BRUNO VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v2 6.1] bpf: Prevent tail call between progs attached to different hooks
Date: Tue, 21 Jan 2025 16:41:17 +0100
Message-ID: <20250121154117.205334-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025011224-liberty-habitable-1332@gregkh>
References: <2025011224-liberty-habitable-1332@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0154.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36c::17) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DBAP192MB0988:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9247c0-60f9-4faf-234f-08dd3a3218e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7RY/8aJ9w7hc/afdDhAWMlvKXcNN8VbC/6tiMbvqvpcNNTMI+07cLZHrTwyV?=
 =?us-ascii?Q?Z/x96epfDD/ujLnDBQoUu8ZcJRJWs8A6LdDkRzO4W4ElG1R680Zdmqq7S/VV?=
 =?us-ascii?Q?MHzX1LGK2ljmLZ9gmz5+v91Moj81GZB5ljYTWsnDJCR3W19pYZrIcDz0MWiE?=
 =?us-ascii?Q?ASEnE1f7bJ1Pxs9catb1CIN2Gis+ho6rtye8iSTvcqXQ7iQCg42a+FlRX+jb?=
 =?us-ascii?Q?+St0jwZqEUR26HHceiQC9jhoVPPnjuEScHAbD+wGIUuc3IsbKmFuuleEAA8e?=
 =?us-ascii?Q?e5ccSo8gkHdfu/p+lI4MMQ1ji20MNKOr6WMvz4K2GtjlANXnTGMEglEQgL+w?=
 =?us-ascii?Q?E35S3DhiHx2kXm7ntvE8F/Mxdm+Pnj5Uwh58Miiqamd2YK8M66D9w4V8c4v3?=
 =?us-ascii?Q?p28ma87VghmV4dSv+YNMFWfEP8Ja4mSv7QuA46FDj5cI5xVYCJlmWb29YW5c?=
 =?us-ascii?Q?6aKkXuR9ibBiXOHPTOJmPMkb/lVg1pY0dJ2D3iQzyseGFP4C3ZVZP9RKiRE5?=
 =?us-ascii?Q?jzz2pu/sZiz+7k7YtAufMF0f0CXhpJmFhTrbaHScKZjcpTzWuA5hwQsYs7iZ?=
 =?us-ascii?Q?Cq9hmfBVGgH3k/QFq36ZcSWi/B3uEHhGLuzRqyodIisNup5FkU92fKjkYeoj?=
 =?us-ascii?Q?qyELM+pZuXXj8IQZBPeTxMznKVIIOBPYF3FUhBzwKTk5wWiBy3gL2ddZNcB5?=
 =?us-ascii?Q?KpkkNsBwDhzEoYmDd8YNYZfpen8is8ct414G8J4oRPouBfyvpLkQofUNpR95?=
 =?us-ascii?Q?w3B6FBhvBfJ3T7GrsBfadW6U6SIIwDX0K25oX5LcnWj3juIH3xg98HsQRGjf?=
 =?us-ascii?Q?8OhfrqD3VYkCuWyq7NB/u5pQaf+wDiMgqYWSZGFWmav9V0QPF2LJ2cgehAKU?=
 =?us-ascii?Q?AFZjCdXbOqHBGtIZSU2Jit+g0VQOkF/cz1uUhMuMxlHMHkA+aqb9B/XZsvIL?=
 =?us-ascii?Q?pdNhmWcuzRRmyoSviCg4nxkOUjKJRWBq14N2PGZ9c2OMlEh3QpEw3g6v/6pN?=
 =?us-ascii?Q?jzz8Qx1aEh/6eqLNg9erFUGs7ktWjVDslu3Kl2ZOCcdfwJBrcmZ+EkKM6n/h?=
 =?us-ascii?Q?gY+njrnyEeW7DWDi8Xdd5hB/8vmgkwVhDNKqnJactwEty1HUHfrCN2SM1hAm?=
 =?us-ascii?Q?kUm515sqCMyFnWW+zQYRJEkGCcL2ot7Je+oiAuqL/r+M8M/C8MXE9TXM1AQf?=
 =?us-ascii?Q?VByewMMt0biUcswPyOYncPXSDiRV20GvyDL6Gu8L0JdovWbjTg/9q0TSdyCs?=
 =?us-ascii?Q?Yjgk8v2DIUU3WaXXttRKIYIpigECxEfqHxQ81H8vVRNR3PE0YeeXSBJXjqoF?=
 =?us-ascii?Q?G/W8yciZcx2RIGpSBZJ4F8exW4GM50ZMe+TAz38Qp/EJeHQHS3U8r1JyBDnE?=
 =?us-ascii?Q?8PNvMwQsa91XmWHsOFKaYbj9sprbbAjtBiV2YyHoBEGLdj2Edg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fdnTcU2w9+YkZzkgCAX0cXWjwyTZ6P/hAT3lR5Zzt/GrySdogHBZYFb9ZWe9?=
 =?us-ascii?Q?mK4Ri4nBzaE/IdiVJZR2lECunMpp4rqlg8UAybzhLgo3xxNkaVMHQwNZ6l8B?=
 =?us-ascii?Q?CTXJUld75l7qWAZeXEsXz3/HDM3zbHGA48/U/SA5w/KitMl7ge+lV/Jc7V3I?=
 =?us-ascii?Q?7rhiZi/MA+GYcb+9xRQWWW3B2sHKnOV/3Ag0TI8Q18Mm8dkHhnbH1rBZOE55?=
 =?us-ascii?Q?cuJz5jtETMobKpyCNXS40Ok093GozRgRva6V8Q0IYAWOx4kgK7lKNn20rO5X?=
 =?us-ascii?Q?+M+HExbBWeXFz9bzL3NxysfKD39BF0Rhs/LgKIlV3OFiUpczcPkNK8JomXce?=
 =?us-ascii?Q?t7AO+QaqT9AUXrGFZccAAqivzov/QtOq7TapwtuBjaCu5hhdBO9wS9X2lgRO?=
 =?us-ascii?Q?QzTkqsDDEFUiWfzqX93HzWEIKulXv2ptUoaY2RqJm1rhzzJNZsfkDryNjxtj?=
 =?us-ascii?Q?7vZbiRbmoPvtv5lk9q7rWNXLel1ak3Xmm+RZwj24Q5Er5W39XlH63CjGLzsT?=
 =?us-ascii?Q?UrF7YG1bauRJ2NkGx2WVymPLN/9j0N6etXno/mPgzXLYy6AuruASJcSg4oPU?=
 =?us-ascii?Q?8nsYXR3i5kNwl3Z+dRe40XVjY8M0CB4tLYbuusAjWsDtjxi7ijRPnSxLD2QP?=
 =?us-ascii?Q?zIWF+PyqGzQrWXdIftkC3auu8F/Wr8CicZk6hP2yHr0OgbsL2oeND+Liieo+?=
 =?us-ascii?Q?FlmzU+RVEEevBYYq/eRHKeYdQeGYOuuLUw7o2MtzKGySsMEr6ub6D00KI8Fl?=
 =?us-ascii?Q?Pz9rSJ2x8zEjxMoenYbK/D5vytAvzEKK3JMt450pGKyVH1JWjuvf+dvYlqBR?=
 =?us-ascii?Q?xZlqEeFYnAryl++Qv4VkTVpwkmITLjBk+S6YJkbfc5ByvRqxu3Xdkw8PExKs?=
 =?us-ascii?Q?BKeKx3mALho0LJ64SXHG/o3Y48OGV6Hb6LtiJNDYdwF40aq9lNUauZ8pSi2X?=
 =?us-ascii?Q?ttLJ+Si0Uy36L5k8Kwat4MvIZgoqbyhen11WG0CGpsHRMTq0rwWmNE5eKooi?=
 =?us-ascii?Q?8Sabk3XrY7eJZXJyM8PAfFOdgQkwrlPKnZSoZECxjQ16wpJu6bFxax/SWvEY?=
 =?us-ascii?Q?ER4euhUETEErDfBh5wP04As0cR0WyL83M/q2EWt/E9MYNP13VMffAF7ljna9?=
 =?us-ascii?Q?22mGnd+6azy/p6/ICqgctzWmLhKu42U2gNZeWed4pxJc6u08UMXci3tgRHU9?=
 =?us-ascii?Q?QMSbjKvbnZ7wz9qB+sZcpk0brrm1zaWAz/ODR3RsudivM71UMLPT1dFHM3hZ?=
 =?us-ascii?Q?aS2KD7Bz7ypGKWH4mXM3rPXXuY94fEjHpRbxlpWkr2mGDAowyNWo6p0wSh+Q?=
 =?us-ascii?Q?d4wOElnj1ydAYl3uG17DWI3KHudSfiJ+p64U/d/J7jpj1EefaWT44XH+VXti?=
 =?us-ascii?Q?MG5R7QiuhcgFwUwexeUav7oAO2eNFalBO8rA41NKfGrQK8cKDYYAObMASwPr?=
 =?us-ascii?Q?PN7w6lIj8XRs23U12O0FJ58GvQgH+Zlw9DqN2DoWCuHa6W54dgondMisvPB+?=
 =?us-ascii?Q?iFRKzjx2AjlqoYCJTrVD2Ls5MEzhqKU9uRrGzdcoTgxVDt8tG+3B0ChA38w2?=
 =?us-ascii?Q?rp4VDv+ZN1fk2K9yqW8W14Xli0u/GYrPR98I1e1ZbFgqFl4qzySyYiRVy+Tx?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9247c0-60f9-4faf-234f-08dd3a3218e6
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 15:41:40.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhAih+6zo3YcR2YhxA7ZlWeBC7r1EzeFAR4Utjjkfy3ON+jRYoMfYaYcTeC42QBnsnUjrCu2hqsUmhplyS4hnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB0988

From: Xu Kuohai <xukuohai@huawei.com>

[ Upstream commit 28ead3eaabc16ecc907cfb71876da028080f6356 ]

bpf progs can be attached to kernel functions, and the attached functions
can take different parameters or return different return values. If
prog attached to one kernel function tail calls prog attached to another
kernel function, the ctx access or return value verification could be
bypassed.

For example, if prog1 is attached to func1 which takes only 1 parameter
and prog2 is attached to func2 which takes two parameters. Since verifier
assumes the bpf ctx passed to prog2 is constructed based on func2's
prototype, verifier allows prog2 to access the second parameter from
the bpf ctx passed to it. The problem is that verifier does not prevent
prog1 from passing its bpf ctx to prog2 via tail call. In this case,
the bpf ctx passed to prog2 is constructed from func1 instead of func2,
that is, the assumption for ctx access verification is bypassed.

Another example, if BPF LSM prog1 is attached to hook file_alloc_security,
and BPF LSM prog2 is attached to hook bpf_lsm_audit_rule_known. Verifier
knows the return value rules for these two hooks, e.g. it is legal for
bpf_lsm_audit_rule_known to return positive number 1, and it is illegal
for file_alloc_security to return positive number. So verifier allows
prog2 to return positive number 1, but does not allow prog1 to return
positive number. The problem is that verifier does not prevent prog1
from calling prog2 via tail call. In this case, prog2's return value 1
will be used as the return value for prog1's hook file_alloc_security.
That is, the return value rule is bypassed.

This patch adds restriction for tail call to prevent such bypasses.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Link: https://lore.kernel.org/r/20240719110059.797546-4-xukuohai@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
[ Deletion of the patch line on the condition using bpf_prog_is_dev_bound as
 it was added by commit 3d76a4d3d4e591af3e789698affaad88a5a8e8ab which is not
 present in version 6.1 ]
Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/core.c   | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2189c0d18fa7..e9c1338851e3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -250,6 +250,7 @@ struct bpf_map {
 	 * same prog type, JITed flag and xdp_has_frags flag.
 	 */
 	struct {
+		const struct btf_type *attach_func_proto;
 		spinlock_t lock;
 		enum bpf_prog_type type;
 		bool jited;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 83b416af4da1..c281f5b8705e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2121,6 +2121,7 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	bool ret;
+	struct bpf_prog_aux *aux = fp->aux;
 
 	if (fp->kprobe_override)
 		return false;
@@ -2132,12 +2133,26 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 		 */
 		map->owner.type  = prog_type;
 		map->owner.jited = fp->jited;
-		map->owner.xdp_has_frags = fp->aux->xdp_has_frags;
+		map->owner.xdp_has_frags = aux->xdp_has_frags;
+		map->owner.attach_func_proto = aux->attach_func_proto;
 		ret = true;
 	} else {
 		ret = map->owner.type  == prog_type &&
 		      map->owner.jited == fp->jited &&
-		      map->owner.xdp_has_frags == fp->aux->xdp_has_frags;
+		      map->owner.xdp_has_frags == aux->xdp_has_frags;
+		if (ret &&
+		    map->owner.attach_func_proto != aux->attach_func_proto) {
+			switch (prog_type) {
+			case BPF_PROG_TYPE_TRACING:
+			case BPF_PROG_TYPE_LSM:
+			case BPF_PROG_TYPE_EXT:
+			case BPF_PROG_TYPE_STRUCT_OPS:
+				ret = false;
+				break;
+			default:
+				break;
+			}
+		}
 	}
 	spin_unlock(&map->owner.lock);
 
-- 
2.43.0


