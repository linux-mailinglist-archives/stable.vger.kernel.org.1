Return-Path: <stable+bounces-108177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB320A08A87
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 09:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843E81886091
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1D417B500;
	Fri, 10 Jan 2025 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="1GkVhhr3"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2104.outbound.protection.outlook.com [40.107.105.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F14207E0B
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498439; cv=fail; b=nK9PRCcQ9O0BrKYQCC0vYdJ9x4QzelM4buvvJRQKnMm07JCciU3g6SILmuooJ7stDbfxjkuVyVek9R81rfwhwPMPExCnI1Y3fs4s8yQG002GuEiFbWgZaBxj2E4iMXWJTo71roYDvmpwljg5V1Sdh5v4VnqyeifPS+UBKE+Hwg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498439; c=relaxed/simple;
	bh=C/EC6ZfIUYm913KRlKUTTAfvE2cqexJf21KgHaMbavk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=huOXFxs9dLp45cjD3YeGQm5Rx8AfpXs4BwQx/S8qsM63EIIn/6+RxwBsr3GZWUbH+SpF6/UwyCMcq5ZnbkjnUYGR97yaRGQjKegHzkabw1YoeG7uug9OWMKEb8kg8PeQKBBYF1gf7mj+hOhGHEdivBugqEoHdxOm1yV7q5THoQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=1GkVhhr3; arc=fail smtp.client-ip=40.107.105.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoBs070lMxOkfpB0+FaSIUOSz4lGr6KlvLQQ2DI0JozevQG177dEwK9ep7DMj5+WcLU2Piwfdjz61V4otxcRqeS+cScPxTFIZuzuHtlGJcReLfDBvDa/+LZfELvm4CtmQppwrfsTICO2DHYa87Y8kBE+oCUll4zoezFF/Y4TijwBeHYhl4ZoS8RKjcXCnCpZF7xuiq2OupzHBgs7F0BRyAqVTUwlAhw1o2A4O8h1+XCT2pth88i250CSjGDH6omtamgzsPxmVQCjS70rsTj6ynOloe5S5+RDfIMYqo9a0HP3J50kyratHX/8AUK/DzpQTIFXbQRmzrqhWtZNGmj4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=733I5Vf1sRFsiWgpb7QJvoodltqVIHhpo1H4vS3BgS0=;
 b=h2TO0eWXq56J9V1zQALGx2Wxm6zOWbX1WCLEr5TNh+VXQEEiJgMZm65GO7nxZj5driroCdTAvax6rIRhjdDCvFoMIPBmQscoqFguuwCQ1JkfUbusyDiBDvQ0GOc4hJlRRdvWbA83PsZVrFSy8Si6wWdEdY9TyPk6hrOekBVonMjQnQcSb2UMUc9kUsdhP9edkcfMOijiI6ar11FvtMun7eToii3Dt4qZfxjrjCDYn0/uI3sozJ+1GbFEr07QeqGn+k1WE7r+opgqUsSsiBMcVC2GThZ6sGAB+iTIQTBdHAQYDnY3lwcTRXVR+zD3gHtQux8/yG3QiuhDI/ZiLiSwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=733I5Vf1sRFsiWgpb7QJvoodltqVIHhpo1H4vS3BgS0=;
 b=1GkVhhr3hxuSX23fXiPM0QcGT/2/2KyjETMBFeogkTHGH8WPjQ2/+d91DD7B2sjP74ZxTkXOKfrMx5XBPdh07Jjd0G1WMPhrVvHX0W8D0ZOxFghAk+7JJmXDQZbKEgMHsljwCPSEit5LVcoUcXkFS4gK4EqT98txH6sp/mTf3g1qEZ4Nar3hzR4HfGBpdfgZX1nXGyZqvVwftrC4sVf7f32OuFsQxmHa7uAW34GpFFnkEIj+hzrTOkoK7b+okdYNvyUPkUO0En6ZAsgC3RSxM9naVBS/e7zq+bzH/JHg4Puq+3R+gI9AcO2puUT7BxDalfniC7S4rAX9cI9NUHfsMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DU0P192MB1722.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:3be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 08:40:30 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%7]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 08:40:30 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Xu Kuohai <xukuohai@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	BRUNO VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 6.1] bpf: Prevent tail call between progs attached to different hooks
Date: Fri, 10 Jan 2025 09:40:00 +0100
Message-ID: <20250110084000.3208-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0244.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::17) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DU0P192MB1722:EE_
X-MS-Office365-Filtering-Correlation-Id: d42539f8-d3a1-4694-408e-08dd31527072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bmkaRnuDOZ1Vog2D/bcKmgKlNRc6RMbMiONGHuI88apsY/2+c2OFPkiQ/255?=
 =?us-ascii?Q?rQAUmFYB4AwxsVXqMAtLtdRREfnmQ2Cp+XvLcM7lvwSSaN+Pp4R+srZozsNe?=
 =?us-ascii?Q?x0JjW/pRxFCuqo3oB0cnIvtJSiHirk4MZ1seKXYfpvw6mNr2+h12OcIq4EH0?=
 =?us-ascii?Q?aUtA+s2R0xsLEmXKPgHKwi9cPdoJNFD9vKWqbzbp690yL7lmIckU84CL8AZ5?=
 =?us-ascii?Q?tUqrjRbsKRZfLjVPvQ5WxGYtV9Mt6IXqENoBMEgr6AFbN7Qsf6XLy0/dJ2R3?=
 =?us-ascii?Q?WUPc9mpw4Minq3XA90WG9sLHU9fSBwhdi85Y5hJ6MJue0lSJbBlhXGu90+c/?=
 =?us-ascii?Q?M7rkMIXvmF9bD69KdyxsWvvE3rdnLl5lHWGsHEJ3dY+efpQDmH4viL1ENh3i?=
 =?us-ascii?Q?9nQpZvoP7lRILfeVzadEWMae/vCGvxyPhFE2t4TBGWV+obaLaRPTiat2W7oY?=
 =?us-ascii?Q?quv4gr0BlXN8axwq1F+Xxk6oAjwE6mBFWqwLXGX+6Nr9ArfLhuN0GXE4DVLj?=
 =?us-ascii?Q?YV5yyNYZA7a6uClobI327tS6OOW6fI4LMNx972ggXRzzA0OsbpsBJv1vseag?=
 =?us-ascii?Q?l5y4aV72/klTDN2+5eQdN/6Sr0vLX0YE4XqApj/GBNnypXg+Hxf/xGHKFklD?=
 =?us-ascii?Q?IBIZqY6mpgLfKfHXH6JqfjA225Qaomg+SRauzTR71bqWe/WMScT07Il9LdAR?=
 =?us-ascii?Q?e9adW8XiTm+W7GnKXvOTEHJu8CvtkIcjsc9LuxtwxeRPPcNQktomvQaLu/5p?=
 =?us-ascii?Q?lAWfrrrs4YtvEYVsbUyzO1rPpbcU/ucVFUoarXEIde9vtWlXX7fveE65FbkL?=
 =?us-ascii?Q?24cnF/8TmsMr0PoXnfEOdoGFV5SGDAn2zdlxETn6MyNArimC7T5u6p6fBxzb?=
 =?us-ascii?Q?5iBZ/b3T1cgVjAXYvIzWbHo+a3DR8GaguJ94oj+IgrPWMvFRPQIrt7FHOoVs?=
 =?us-ascii?Q?wkUF7XElsTiZwhxPXHMhN9voI5GYRgGqJN5voO4QvbMQS2u9gBhHepNmovtl?=
 =?us-ascii?Q?lmp94u/x2swjqMO9DDmuIWzOb1A5ju5dgXP0jlvvr9MnBKWwUwT4vZZsotAJ?=
 =?us-ascii?Q?VTOCExwl78ghuxvmsc9mf50wq/sIcLAd/9BaYtkMSJP75TPfIRmED5DxOCXM?=
 =?us-ascii?Q?9/VHoZHS2Pvjn8zHhGJTRdoYFR5NUszyYME84MOzVlyatFTgjRJmsBbTrkIu?=
 =?us-ascii?Q?V3qn5OmW+gpCyeP14Yfk2FImPOSKhytYEjTzo46+DaGQQQnDhfreUbpFa2Zc?=
 =?us-ascii?Q?Z8yzLwRbKE2zgW55k4mpontTGFp/9BbXJuOcSpKM3TvGsrTmTqijC6yxYzY5?=
 =?us-ascii?Q?JiatmDxK0MvzVRbBwFThOsW4uATyTlcF9H8rjgSE5sIvOo53jNvwjWNUosX+?=
 =?us-ascii?Q?9EyAtuZ8BuvORIVI79EmV6I2/X2TBqbTLmUx+NGbSfCp0t6iSnmfUTJXQF+Z?=
 =?us-ascii?Q?RgxSbui6rI5mdsXEhrqtQ+Y9HKvQ7Wi+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qm7nD09ulmVbtsZTkHKjgcQGa3kIkhuTnxrRWpNH7LXW1ZhIhhobaPcuhLsr?=
 =?us-ascii?Q?dJo5grTr7YvWbnOya0dnOO8zl4UQ4k/RkpY1/0P9WPeNm1JwvD4Sc4s+ZeJh?=
 =?us-ascii?Q?0BoRym2zodZDPR9QwERcEj3lSFPzeK5l6p/oW0IU5qp8KaIepqugs7JPf+Fv?=
 =?us-ascii?Q?5ZBb9WE7iS5YfQ7kh2/BuNZaxt8wbtqV4kwyrxqZZI6lpM27RAuyFCziPAXE?=
 =?us-ascii?Q?OAdLXm8SMtw4vvUnswpicK8qvBjbR+3DqdcbLrYYiQNPv2RcvbV0GYiFGVuk?=
 =?us-ascii?Q?zCtX2Pg5L6P9dLrxOCcei01tKzHAhtG/jVCSaXd9zo+E5Frlh6oimc2wkCMX?=
 =?us-ascii?Q?9ys1/lb1pSHnsp2vrXj4XpfOp8WO/XMCa2zOsMFLBMQRX2HKcCM+5j3bKeLA?=
 =?us-ascii?Q?GGrn4b7iPSfOcqF7EppkGCIqoX/RSB8ZEeOASFCqZ2pRFwCdQPxp8dqMkatv?=
 =?us-ascii?Q?zht+90II4wn4MImz5lDiWhYapLHooyFFAYIBSH/dESQO9VWP/4jiY1wlnABS?=
 =?us-ascii?Q?Zh9ZOdcAfmh9gqg2HxV3auTiibr+APqxhG7r6jl4gZm9eqfRBl5pmGQD58L5?=
 =?us-ascii?Q?/ofTUgNHchlUv9vUEqp6rKveETvKN8KQc+D9+zvwOfonL6vizaXDJCC5y60i?=
 =?us-ascii?Q?73E5roCK8ka0qzCdhKBzR1Ungycck7rc9Dy/baHTWaxf+yBQEwyA4T3ihvJP?=
 =?us-ascii?Q?CZrrsvusfS6Sv2mO/XuG/QaMRwpVPi30+FUGOn6P2PlNOtUcCZ1EGYB2yt5Q?=
 =?us-ascii?Q?hnSBMykS1J4jNgcoBEiS7fkT/JTCEuBqYUAKkMZRaXerPlVE/+wZA2oloLTh?=
 =?us-ascii?Q?t2UEg/iDCLYPAiAUbku0Nlum8pfiwmHv+ZGIiMr0xMP41wdPB6YJ6Ueq4Z3i?=
 =?us-ascii?Q?/5EgbQY5soHPZKVrilrhla70Zog9z3N+rqq5AtJoBXXLb7V5iDgggJAbqWU/?=
 =?us-ascii?Q?YwgqUuf/xRXmt1OVZQucxEwHowrpdMSEYcrVg30XZzauQV/ZQPJnuLNj3axY?=
 =?us-ascii?Q?HTf7a6LdNJHSb1lZTjzvXQVX+dsba/I6mo42ttwm4MqK7spAanz5lVCMzFQx?=
 =?us-ascii?Q?rirnchrqLa+8CsItEFcB7j8MsN6VbscscbK7gfd8Mt8zEzck07WahzpSApfI?=
 =?us-ascii?Q?DJGjiV3VMFNREFUxCQPeOKyouMEqhEeLT3wgmm4fGwID4UO3sGP87Y+Iuxfx?=
 =?us-ascii?Q?uhqaqjX8piXpN/uu2TfcP6T0SKuw+fTKLYJKldNP3N9oiFBkviQGViLUykwy?=
 =?us-ascii?Q?IaIOzW+P0TvMNXm4pjk7O3TZjAnIlby33XxcnCAXS6HjULK0dcJRFtjEMayG?=
 =?us-ascii?Q?+Nvw+/Ny+DduHsJeWkCi6+NW+DgeYzpYYJLfrInM2DfjUndla0ib8JKSl6HC?=
 =?us-ascii?Q?MfryigulIvg9L9vc7Uze8+O5Gp2AAd0P1mTz3BDfls9NJSzVuCV6sdwdqUQl?=
 =?us-ascii?Q?n6Cu17BGY72cHjndrCrO1P1IvlTVIbyWaov6SGFKLUkJbjHWthsDJyYBZeUC?=
 =?us-ascii?Q?yMqV9sCv0FTS/8QogK2csxCcHZtFsfvIolDqEUQLznW14zbmRojqk/cujo9W?=
 =?us-ascii?Q?TQr5nDgm5BmDb8/AyPS6kAABIdqO8s3jA+s8XGtx?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42539f8-d3a1-4694-408e-08dd31527072
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 08:40:30.6331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81Q52w10WMtj86gyCb3mnQhVZdgVEPqcxDp1ME6g32boiooxUIGTQXIwuHimTU3zNgSNTErDpl/lKheXUTcOpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1722

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
Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/core.c   | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7f4ce183dcb0..39291ec48374 100644
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


