Return-Path: <stable+bounces-108204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8482A095C0
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 16:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562AC188F406
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BDE2116EE;
	Fri, 10 Jan 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="qDUt+Jka"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2102.outbound.protection.outlook.com [40.107.22.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847A211495
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523029; cv=fail; b=DBQocaRFzcyzy/nHTKwYX1ewohLviMVNVkij0q7OG/20bEhCFS34lyXlRPpZfzGuwvNBs7gknd7VVho5byoEHH8izvxzESCOsYNB5tyAJ2rbl8DgJrkBoXqM/cmXhVjldGVcGbgre7IzR1aWNnJ6nGstLuj12gkP2vME8APtE+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523029; c=relaxed/simple;
	bh=LnKXBWdzr22T7EjLEd7dzrV3/2/iCnM7xxKhPYlyLak=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D7siqMGbAqIsa0s42oycYuCnxmcF4zUOFlP+rAUyNjh5WSf2mI+kG4j5s7qTh4p9roKRuPMIdYIWhUqsegdjkHe0XoglTSAx/JR+Px5NscqadSos3hANZnlB5xzD7a1rddr7O4rgoRVvV8Xb2VO5lVo3/KhqOmBHtzhEWpA6bMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=qDUt+Jka; arc=fail smtp.client-ip=40.107.22.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNhYzT2U4HxlLNMWG9cjwNDk11PNz394Nd9cYYm5VQTr47G/aKDj9cpehxHJ8SmoyA25fxa7F8dVQebsCRO8M3MTqMOTZZxX+Gb+WX5Ru3DUXFz9QmTzWN5HW3KLw4M9BiEOnhQMuEQknBSfHmouoAtRmWKKwtnKOabRtnKQdAPfGF1/pdvhcEr0/hpEXf4WAKwHI6GSSHUhrpKGnMc3Bqm95N0x9DfRoJefU2IOuG6i2oGBfBErQ2zg70ps27cXs0g+RobjpLqzywXwbLuS/vcrXqNHww427GGz1dEv0DH+5uj2/1zoSsCMf6Lhqx1knNdGtW/gsfyMmSJ+MH8WXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO8JaVCKt2x7q1yfBmbmAlikKsnq3B0bXrU83T5HJhk=;
 b=QIyxGucoBwfE7ELBN+HwfZsHcqonvkG+5jre19vlY90k1XiCeeF3ckPLZykrfiDdt2ZAhDcQAfnZCZEemLHnJaNiXrmn+lxI755NgQ9lqBNIyxg6fV6vXb5ConJ2qvlD/Hs2S4epKiOC85eHGmeFL5ETrkmh3YhOxeikHI8/JJ5DNtu08cQF5oZnWP9aEqEfLwjr56UKvRl7zRQqNqJhsHeaHFJYBrTeBlw2qgQ9B7i57iLClHKC5jHygAbxfrN0/NkMnjmJYmHa6vIJH0/fMWZ0bk9FvBpwDXOXS+sEuVGcArTH4puaOl3A7i+h3+7uVVeAaGxEIXaoXmXgUwXA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO8JaVCKt2x7q1yfBmbmAlikKsnq3B0bXrU83T5HJhk=;
 b=qDUt+JkayRFOADz9Zwhfbe+UghkrvPgk+SZo6itWJ9Y6BlxDZME0UIfVlOgIbL+pTd/wrawoM9YfYEUsr64YXznTQDWWK5F3Znc4aDJ0+YXr25t7wJwSXjmaxsFHATyoFA8ajsUMX74QpTfSoQqiakEEOgF0mfiM1YvOci1RMQJy3TQlJ+179ZCOZtMLf77eeRIwiKGzDCQBCQkhDLpBmOgLmmdZ8mvNtobzSJRlDjD1INJ9y0HibMExsL9vaylPcoEERDenixualOaXDIhjav8mJK9B6i/dq8kFvrequOx3PdDLwAOm1+dYoV+n1IYsHD0tlmgvD8R8eJEvcKM/yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS8P192MB1704.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:525::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 15:30:21 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%7]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 15:30:21 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	BRUNO VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 6.1 1/2] bpf: Add MEM_WRITE attribute
Date: Fri, 10 Jan 2025 16:29:57 +0100
Message-ID: <20250110152958.92843-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0007.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::11) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS8P192MB1704:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2999e3-9bef-46e3-da90-08dd318bb1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jA7Mg0bHH1hszFyhsaGJTBJWRggMtZ94PGrFmTrtCm+hXHqCPCH3khxciwIo?=
 =?us-ascii?Q?QD2ekiEuLyqAoou9xUYzFZ0WAC6+qdKFpJYQDVjaZD9mmm+t5uiWPm+rTYTM?=
 =?us-ascii?Q?zQDszidpQCwTS+WIsKgyZz9UME+J3vUT3uimQdQ5Q3owFBWR+PvpvJ/NaIuO?=
 =?us-ascii?Q?kOKFodhlg+G9O5aPdRn80t/XuwMjU4osTlcFZg5Guj6cgqV5qk8LS1Npgo/Z?=
 =?us-ascii?Q?yau/oARBUUo+0ASDL9J4gdBOB5DxQSAxBIeTbVXvW257y1udy2dtpEOztOj2?=
 =?us-ascii?Q?h1aYzZ01jVuTsgD3HqcQf5j2MkgJq4Pq+k5lZBxABtxYO5b4P9B9UGaZQ3Xm?=
 =?us-ascii?Q?1gc7b/rfWZGMSnjEELOEwvbTI1Jk2jhKDpJvn4hqM9481x09I7OFH2vRin7v?=
 =?us-ascii?Q?ZsABb2CsR3GmBSDKRmM+lgbOoPIs4QdLE4GmfR7pss4MLCsOlzwOINH8ehBs?=
 =?us-ascii?Q?PsrLX2jHd3H3FRbcXdd0PbPqx3vhkirsfGvfSaJDah/s09FITWvpp9/+vxcR?=
 =?us-ascii?Q?N7u3J9sQqhakvK73NULgxveXCQZH0EMPePVF2nOzB1XB+Yw2KGRjqnH0Dp1r?=
 =?us-ascii?Q?x9n29Pyovh+P6Ir4N42RipoRPI04uX1m/I7snAd3euM2IIeYN831p3OTwmk3?=
 =?us-ascii?Q?nvqJovVh/6+tPsTXEYCsQUA71yme3z4UpwRTlAkR7+so2euB1p2ERq//5sfb?=
 =?us-ascii?Q?tYaQEc2eEORs+Eq4QhpXhRsZRIYvVbtBVylPOOWj9F9AA15i9Zanun1ltJ3b?=
 =?us-ascii?Q?3WKaPO3mw0VFnRJDfSyRIulEUNLaAtfyyO8vVE/2xS/zUOCgpvszdPpN/1qp?=
 =?us-ascii?Q?vWD+W36jTcqM7OVtmBKTeiOlHzd4NVcOblmmL2ey0/o0aaIo7vde8NtM6grv?=
 =?us-ascii?Q?aa9tNLesxQog5ySBbScRHy0ALFyBny3q+2aemQseGGtij7cSnZtbyMuZbxan?=
 =?us-ascii?Q?PGRsl9bFIfWNPTqQkVkXowN6YSiX/bsJUUthKOJTxClf9ZV8jWuRHq8vYw51?=
 =?us-ascii?Q?1uHimUX9MBCUvITNvil3Io96N7YYtKLamauyWdEW7qeNlsKVpdvtzu1+4jE7?=
 =?us-ascii?Q?zvQ1pECYhUELOwkkWR5if9lvLZD3S57Qts2AWtyVINa5ol80qlXN7k4Ef+5t?=
 =?us-ascii?Q?VSSGXHsymV1RpIAAwIjZVkRE0aXUApSR7x7yKH9WFObeAn1Fsscu9KerWObq?=
 =?us-ascii?Q?M8N9EwAV0Hz4mTMiP1Z7UciphhZJuhIyQTRiDdacBzUOsP54oel0+SCZpF7K?=
 =?us-ascii?Q?Gf7dHanxfIgRT0mdUKzvOn1RbE14i3i89E28R4p5o9ZBo8LnGCAR91tMNQaJ?=
 =?us-ascii?Q?tQghHJCD723Bbveo2hcDMl+n7oIvTTQ4ivaC/H5CDvw2OX+t1POI93gufF+m?=
 =?us-ascii?Q?WflzUSJa6VCa/Uxrv30XLxrht1MvTjJ0NpoHTmuu2fs5jtdUqoWEb2c719e4?=
 =?us-ascii?Q?JSXFteNHzlRbS7L5WiSspoolk0v1CPpR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ToiaKKTd0v5CHwK4Sd/Rycn7G5YRJKjXPTr/0kMVEPC0ELgn7fPZ4AYXRMUc?=
 =?us-ascii?Q?9B0cgWcjok88P3Xf9m1O0yjYruePG03/oaV5rczoeP+DQk8eHxitOjFJdl7w?=
 =?us-ascii?Q?Ah4oYV3y/uf/QQYyD/ZLe0NqVXtmXWJalzcDmGkcb8BCNWw+Qj2oaqhdB132?=
 =?us-ascii?Q?vThhh8AWvVUZqPr3Z9PM701cZEO11vVcns7Q/uTXadxD1bef2DsRwc7HkY4C?=
 =?us-ascii?Q?Jx5UduQGHGI3/tB/nb7b+M7Ktt1dlKT8nLL7FK0TIwSthWtBzGgx78YJagwC?=
 =?us-ascii?Q?pyPUEMyOPvMD6Fsro1kMK/gnnlq2yYLEgm65EP8qCUWRvoLAKke4Q9N5CkYi?=
 =?us-ascii?Q?KwgISaK9Mgi3fM4cYRIEc4D41MsPeCaz2QDxBXvAU4uCcYDspCcFlGb46srh?=
 =?us-ascii?Q?zWIgNtmUGaqzK4ahJt8MWE4LH0oCT/hAgw6RAi0evYtP786ygndUc+efoN6H?=
 =?us-ascii?Q?5S7OT/GiY2vb/GI/xWr9QKlUvlRIxD4exGsh2jE8JQ3y+SfwbD7ngjpZAR2g?=
 =?us-ascii?Q?BGh6QRHvkUwOtiz6SAemGBA6D8W0D23JQW2UgIKe8nH9hIHS8S2J9aDWJckr?=
 =?us-ascii?Q?Cx8lEvzM/oM5WVgeQ8J27ahiqr0rxe5HQ/ehjtkqI+WpskaoHjF/Ababbck7?=
 =?us-ascii?Q?KU5+QQmSiYsOUACcpbhHlD/GSPFi2N4dL6JDhsXRCTZbAh1OA8AozWlTgLSQ?=
 =?us-ascii?Q?nleejPRflZpVHoasIjApYh9mnuiZntwtPhbb95huY2zzb+27S2dOK3LE2bi7?=
 =?us-ascii?Q?s4H7eo0yH1FgfkRv54H9ha+aQswra8UvlvgnIjrIvErU/+ioiZQZzzVmnpyG?=
 =?us-ascii?Q?ceuxtp8lv+fWFuXNmXlzfZqvLch/eWns2SA8DcCWPQd0OkiBrg5If2baB2jU?=
 =?us-ascii?Q?K48MXygBPh70LlGom0h185kQrFKintHW/O9sijpp161NQirZPOKIWs4WHyXL?=
 =?us-ascii?Q?BxvSmo51WoICgA8ErJCRCiwAJR8Q9sS9GgCiO9qvzW9lVnlmV8L0M5eiOew5?=
 =?us-ascii?Q?m1aTqgIhh1a7bRIFgWHU8vFJG1FNptO1nBnfWJ0/+aNlNjgJVhUWx4m1lB/3?=
 =?us-ascii?Q?wjMCW1im8JHJfNWdbdETLCYTnIl9bBIZtPdly/7jBUKgCQdp/e5b4lcque7f?=
 =?us-ascii?Q?+Nw79OSj3griDd4KgmKwYNTOXKf2Z0q3v6PZnzwpt56+YH8l4Xg1x8zkB/bB?=
 =?us-ascii?Q?h8ziTxiGsxhQUGqDoeBx8WnvlGxA63/DVTsFJ2n+VBmA0PYULWEXY4CB3jGb?=
 =?us-ascii?Q?WQN6/GMVoHkImrX3iRftLIKhjzY8gjjCgtVD25IxgeUmdxcfeRK5Bhe1Nqeh?=
 =?us-ascii?Q?znYFw65P15ax05ZPflJTawOL/DaQuSHq4aRrTllgj2RqiVjYfapW5DaC+7sX?=
 =?us-ascii?Q?ip+thoVIJlQ3KEgLodPUJxPW0fnFmyMcpr4MjEPPmwkRkSKgJAfEmHzNj9K0?=
 =?us-ascii?Q?9HRXa0VpGh6jzsI2i0K5aNcAyPLYSMhRwKiPX2erkREjEmbggiJjG4zX30rM?=
 =?us-ascii?Q?Kvd5+N0xL/VaVbkCRU6UayB3gOeBAIYGbevDAMK8/YnP1/HZsUOe47Katea6?=
 =?us-ascii?Q?/YfFNXiI3YmFcAgYFJwRwwcZbf84786dS4dPfZ2l?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2999e3-9bef-46e3-da90-08dd318bb1ea
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 15:30:21.3516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSKtkloS89rZ+0B5k2MpP7Rzy7xcLZehAFBoz5dQJg4ozy7PMjvfGz5qGUI0Uq+TdIvhyiU/YZR6SxATMlcE4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB1704

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 6fad274f06f038c29660aa53fbad14241c9fd976 ]

Add a MEM_WRITE attribute for BPF helper functions which can be used in
bpf_func_proto to annotate an argument type in order to let the verifier
know that the helper writes into the memory passed as an argument. In
the past MEM_UNINIT has been (ab)used for this function, but the latter
merely tells the verifier that the passed memory can be uninitialized.

There have been bugs with overloading the latter but aside from that
there are also cases where the passed memory is read + written which
currently cannot be expressed, see also 4b3786a6c539 ("bpf: Zero former
ARG_PTR_TO_{LONG,INT} args in case of error").

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20241021152809.33343-1-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 include/linux/bpf.h      | 14 +++++++++++---
 kernel/bpf/helpers.c     | 10 +++++-----
 kernel/bpf/ringbuf.c     |  2 +-
 kernel/bpf/syscall.c     |  2 +-
 kernel/trace/bpf_trace.c |  4 ++--
 net/core/filter.c        |  4 ++--
 6 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 39291ec48374..e9c1338851e3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -465,6 +465,7 @@ enum bpf_type_flag {
 	 */
 	PTR_UNTRUSTED		= BIT(6 + BPF_BASE_TYPE_BITS),
 
+	/* MEM can be uninitialized. */
 	MEM_UNINIT		= BIT(7 + BPF_BASE_TYPE_BITS),
 
 	/* DYNPTR points to memory local to the bpf program. */
@@ -481,6 +482,13 @@ enum bpf_type_flag {
 	 */
 	MEM_ALIGNED		= BIT(17 + BPF_BASE_TYPE_BITS),
 
+	/* MEM is being written to, often combined with MEM_UNINIT. Non-presence
+	 * of MEM_WRITE means that MEM is only being read. MEM_WRITE without the
+	 * MEM_UNINIT means that memory needs to be initialized since it is also
+	 * read.
+	 */
+	MEM_WRITE		= BIT(18 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -538,10 +546,10 @@ enum bpf_arg_type {
 	ARG_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
 	ARG_PTR_TO_STACK_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
 	ARG_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
-	/* pointer to memory does not need to be initialized, helper function must fill
-	 * all bytes or clear them in error case.
+	/* Pointer to memory does not need to be initialized, since helper function
+	 * fills all bytes or clears them in error case.
 	 */
-	ARG_PTR_TO_UNINIT_MEM		= MEM_UNINIT | ARG_PTR_TO_MEM,
+	ARG_PTR_TO_UNINIT_MEM		= MEM_UNINIT | MEM_WRITE | ARG_PTR_TO_MEM,
 	/* Pointer to valid memory of size known at compile time. */
 	ARG_PTR_TO_FIXED_SIZE_MEM	= MEM_FIXED_SIZE | ARG_PTR_TO_MEM,
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 14ad6856257c..4fef0a015525 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -107,7 +107,7 @@ const struct bpf_func_proto bpf_map_pop_elem_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_PTR_TO_MAP_VALUE | MEM_UNINIT,
+	.arg2_type	= ARG_PTR_TO_MAP_VALUE | MEM_UNINIT | MEM_WRITE,
 };
 
 BPF_CALL_2(bpf_map_peek_elem, struct bpf_map *, map, void *, value)
@@ -120,7 +120,7 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_PTR_TO_MAP_VALUE | MEM_UNINIT,
+	.arg2_type	= ARG_PTR_TO_MAP_VALUE | MEM_UNINIT | MEM_WRITE,
 };
 
 BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
@@ -531,7 +531,7 @@ const struct bpf_func_proto bpf_strtol_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(s64),
 };
 
@@ -561,7 +561,7 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(u64),
 };
 
@@ -1502,7 +1502,7 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
+	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT | MEM_WRITE,
 };
 
 BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_kern *, src,
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index af75c54eb84f..095416e40df3 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -618,7 +618,7 @@ const struct bpf_func_proto bpf_ringbuf_reserve_dynptr_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | MEM_UNINIT,
+	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | MEM_UNINIT | MEM_WRITE,
 };
 
 BPF_CALL_2(bpf_ringbuf_submit_dynptr, struct bpf_dynptr_kern *, ptr, u64, flags)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6455f80099cd..cfb361f4b00e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5265,7 +5265,7 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(u64),
 };
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e7b7be074e5a..f46903c1142b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1192,7 +1192,7 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u64),
 };
 
@@ -1209,7 +1209,7 @@ static const struct bpf_func_proto bpf_get_func_ret_proto = {
 	.func		= get_func_ret,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg2_size	= sizeof(u64),
 };
 
diff --git a/net/core/filter.c b/net/core/filter.c
index cf87e29a5e8f..7f9d703b00e7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6243,7 +6243,7 @@ static const struct bpf_func_proto bpf_skb_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6255,7 +6255,7 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
-- 
2.43.0


