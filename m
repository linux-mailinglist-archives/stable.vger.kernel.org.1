Return-Path: <stable+bounces-74136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B93972BDD
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F72B26083
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 08:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8C9184522;
	Tue, 10 Sep 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="Z0EbkU9a"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2099.outbound.protection.outlook.com [40.107.20.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFA17E004
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955863; cv=fail; b=Z7fP8F/u3atxwTlenP8l21o+7noUjzthtC/BeeC3Pdwb8JRdHzwRd8ExPAFFoxd5Xpei0AL5K8OSAwHj/FGLU85GW47Do8M+iQW7jO9b0i39nGZnQuC0+cQaENEhZPkeZaOR9A3w46cAxdwXtM04Ih8aSoUx5GDxF9azamnsaok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955863; c=relaxed/simple;
	bh=8GRkom8PyMoVyYoTTlnUZQ6bAOSGg/b9dtQbet3wfcg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BAVKMRxzp19Ty5L0E6rrGPKgcRL88rPT+rO9ojJNs9ZmxiN3tEzZSrGiSuVsQNvTggQzfMD1jT+F6szenFovMenJO2WzlPVozGURCyqL2Jx92RAILvDSSUq6zTosMqnq8vFk01KDMNS5y7n0fr6m1yaNYtSbpmrl6rAk3rXZYqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=Z0EbkU9a; arc=fail smtp.client-ip=40.107.20.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueLw3WpirTnamrOx0OJOQvkF1RUdxDKTTYi23WsNaipWHPyM697klpCXxrgQdNICVsJXQKDhSYMwLlAIxxSfqvxxRSB3J1Wk5T3sV54k0kd/0Wjmo0PjVMUndcHhJbmJN6LB5lwiA3BCkG0mrWQ+HYpCgbDO+hhtbcQCrCK2sP0898iS+QwUAVIqdI3TAXN3ZkT+GPEskFGhvzjb9fO/s9h9U9yqwJJXvNoJPRY+h8hWczEwoxo01UX9ofjLYqb4L9nQAt4lbDcfNE9kQW27DoePxNGLE+gUsftgqD05WSZxKJEXPhVrSFQhwVy5Z5PjGs3TOoHPf4eTxupsoVc3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nYxupCEt6vll7e55gLhN6kjZElkCyhOR7Gz+U3Z3e0=;
 b=UzbPCPp242tlMJ1VPntZb8lu4NiMCs+uORK6G8S94Z8cmzVgbZSPh5ccEydS9Mz2JLHvneoldIlM6qG3G1I5dqmjKE0T7/PX+f2NRHpEnnUgT6x9y2VLghG13CPjPOYqiHEsriNL84f/ry7GNcA2QrxUF0MUv3M+l0oxSwnbGLP1USV71CIIPQi4+4VLk23Z2pRgofl3e9zObLL2VB2l5DR8VSvQuGQBOz5XJMziyeVEvYvj/NgeCQe5/dsowsfJqBSU+iSzfikAAjf4xR88WSDNgBBTDGDamvZ7tPTYxdGFQXCOACufzwfwf/0yzhNidVl57IzCIldlLCP2ctrs2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nYxupCEt6vll7e55gLhN6kjZElkCyhOR7Gz+U3Z3e0=;
 b=Z0EbkU9azDALcDTBk2cjGTcp3yoH02be3yEZzes9DqNywB0KhgKS6Hmt8IXMmWF0m848j9KeF15jGmTXpypAkyUq/bRWIO0W5In9L/FFvKaDVBmiBNVJlpmOjOj7AKXdYecVx/vGxGlrrrm5+0u2+fhSEZ12xG89/EjTJfFbIpaENL6/n2VOM7ITgR532LBEQ4DWsgOWaBRWjP8veB/XSjSNiqDqX8ma4lTJZv1h8a4calTV+GhyX69JbF3pND9L567zRoJQVZ4/OYsi1XwMr3R9CGjwPG6lpGTQV6JzPvS0lXaWzomD5aLWC1lRMc/M8sTHDDOC/a2xbbgcb7PCRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by GV2P192MB1989.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 08:10:53 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 08:10:53 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Lex Siegel <usiegl00@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19] net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket
Date: Tue, 10 Sep 2024 10:10:40 +0200
Message-ID: <20240910081040.4102-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P192CA0016.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::21) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|GV2P192MB1989:EE_
X-MS-Office365-Filtering-Correlation-Id: f63954ba-9c12-4aea-b734-08dcd1701708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZnTuSuI6Vd6p4qstIcORUuJnxiRNiBSri8bZ4PQNXIhZw1lafu19IV3K8rGY?=
 =?us-ascii?Q?pDENIE2SH+qNXW28De6gWQ1+Ymln0JVdKdhYIyw5ZOrmGHMFlnIHyPQcNOXu?=
 =?us-ascii?Q?3PzrkuLFl9lj05O12Ql/hJCImNphOo+3/xNQET6IlBdYzvOwUQr24wPxigCp?=
 =?us-ascii?Q?ce7cxuJYUJu7gukM10FEL53Sw3MzQptcYa+pMu3YvXSU5RXB6W9zhG8e141P?=
 =?us-ascii?Q?ChyuQVn0jzfPelr0nZ35Y2iB7CFoBFZ8E/Qh0C8/8vAN2iQXdJOwBWDMM49Y?=
 =?us-ascii?Q?oD0g1JHABeLIxHHHfNbO2Y98Ij9adl635BeyvXQwOORtWiE1Wb0Rbind6XC9?=
 =?us-ascii?Q?MEo6lBpXfbDmN8KOMDEz4Aa8ImoXUgOpovlriBNv1h6Xq4vV3dkOvhj+rfyH?=
 =?us-ascii?Q?CocigMCLmy+QCqgr5BfAazL9FR1E7L8G0dpqwbogY6cQyNo31q2B6tN0G0x8?=
 =?us-ascii?Q?bhBh0WnSH4zCHmxsl6HQZZSKyFstsFlZs9sficK1LU8CkC5NWGzj4rrm0c86?=
 =?us-ascii?Q?5578uMF6uCqPrwns/RCeS5Izv0WINVQzfgg9pGvniEc5Wi8Chpm6lZxiTlrB?=
 =?us-ascii?Q?0UWO9si4lkrv1QQZaC67kC+GEnNfTWJzNqncCA/aPrzoHaD5iQgABJQwOjFI?=
 =?us-ascii?Q?kXwSqOyWPrMksBI6IlLQVmJCa1ELnsFYUoHCNIrPPkmQuyhcOdzAfBQh/ADz?=
 =?us-ascii?Q?/I6LfN8OZ3QOh2lVB/VG0RRpu6QjPSZ4ms9jJsK+qCUk5DQyofbJu0CzgSwr?=
 =?us-ascii?Q?PBR35iFdwbZqngD4jMr+7y1x1S1RyR6P6+1M1ShqpliceF1i4MwQTijn9JKf?=
 =?us-ascii?Q?e7UX+aR3CxjXtvOypVzCBhL/daBmScRWY1qEzJIv9dVAUMzMVRaNs/fwhr4j?=
 =?us-ascii?Q?jjulW+fGFJ7a7doiiJxGde6+fadOw+JAVhtMEaahaAMOZsoQjmS0c+YV+/M9?=
 =?us-ascii?Q?/68utl1dGd74/x7j1dDiYlHv0CfE+oQJqv5Ayez7nqkBU1fmf9cgpZsq2pX3?=
 =?us-ascii?Q?Ucvs9Oo1YIYbdNexpul2iTC4IRpvazKDLIbeB5aHTLX+CrvB/b0vMHXg5Xew?=
 =?us-ascii?Q?OtibcB4D2BsOHv6rIb+VRuYAynlKyPfuSXT+PLlDAoaO2LF2y1hpYj8nxXxF?=
 =?us-ascii?Q?8f86LHsjFXAZ/YoNtUvqx1p1ISPQrRmWQ04y58ye4xqc7/7GQck1DH67YPyj?=
 =?us-ascii?Q?OrXP7J3QwYGTGBrXxXv0NLU76mNCQ6bG7TkIEfsTSiyiluMYSydVba6fRkcl?=
 =?us-ascii?Q?MHbxgRQUm4wzxCYhtlO5XWvKizd5y6lUaFoHYukVKT6jh5j+mPHp02z9GZuH?=
 =?us-ascii?Q?Rd2qHMI9ZU3dKY2bDWUuZW37HGg9rsMO0d06whQMIPXMf84HXEwu7r5P0jLc?=
 =?us-ascii?Q?XYAOync=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FwPFuIk3E7SWop3agQ7ItzMEBvpPHIYPvRGFo1OadINCtyQIeY+SNbrU8gvY?=
 =?us-ascii?Q?C8f91RgZPEP9x/2GJPxZsE9dNqn/enjrnFlT1K/TvA7L92Pyig/siW8pdOq2?=
 =?us-ascii?Q?PZLLIE1acixRhffKPnYayw2e8ybkiULLsEF/zdG7c5X9ejvFkCg6hmPI/tjR?=
 =?us-ascii?Q?IPZBkd4NNulPTrhsOabChgNYaO2t3vdPOnJv74Rnv5W53x2/OhNUYBI10m4y?=
 =?us-ascii?Q?DTjGw3p9g8AET8wh074lP3EZNXRLvK/YxA2ByNq6Wt8vsVKxdgu5qGoJkVQI?=
 =?us-ascii?Q?Z/U/ian2ga9v8KJETN7RMcT2wDpjA6uDErD6vUWWE4OGipKBcacYMGAcM2LO?=
 =?us-ascii?Q?tZDdZOMN1e55n2FmI3sST5mvseqKaXfbMQSxWeUGzzimByka7vxlwpHYW110?=
 =?us-ascii?Q?UaaZFsRi/WKuGld8UNYMCxNfLijqHwxeHdcTuYF9czGKu/+mvdUHmvc7KKV+?=
 =?us-ascii?Q?B46gcshZtVSk/GqAeFzF7uFW6PxLh8VWjIw8VkwHZZ4FbSKZg5w+icCyjRNf?=
 =?us-ascii?Q?TsPfv2F9HT1vv1pQPmZMXED25B1bPTy9z0ZE94ZuGDnDm+i9ZxqZtm9Bzexa?=
 =?us-ascii?Q?4Zwu8o8hBoQ3r6ywHfTUyIk3kvQJIa985RQUAFU+BBqq6FTzNyU3Y95qWDE5?=
 =?us-ascii?Q?bJRGfd8L5dWEuAhh/oRWtKxSnpUjuxZoaFfbUMwOTBy/51e0jMxoohmDLnjz?=
 =?us-ascii?Q?BGpv1cdrsB8dLufX8kCQZJMNdkSFU1ANDj/89lYN33FmuNZ/p5pB6psiIeBb?=
 =?us-ascii?Q?izhPVIlUlLUTSygXCrcOgGHn6fxclhC/h3WDczaZi8AoCL+cEhcyFSndg1xS?=
 =?us-ascii?Q?n/N9mMFDL4JOtKWI9EL3t4lslk6Gp0tMtK4spyLrsWYKWOSvC3fEmeDW8MLs?=
 =?us-ascii?Q?3rRGXcnUqI65YbpOAhBmUmALoKKb60NkO2gMe/t650fr3j0Nszu2X5TUJMq6?=
 =?us-ascii?Q?1eid5FEdd9JTtN8iry+59Yo7pwVu7o3VPbhnQPxzTvYE7Aq6tAIJK2xTdWt9?=
 =?us-ascii?Q?e4fwfKWrQCB5f/suOYQV37aT3pA1TLK1Tm0+ufyQ9GuOhn9EKP9s9ts9n+VL?=
 =?us-ascii?Q?DtvN1V2BDp3NCkuiN/YCChAFXnpp790O1Fsc02TYrx44DWgW2By4DEVlb/NW?=
 =?us-ascii?Q?9iHvViyffDt5TuQb+aB2Dlbb3elZxLUnkmCUYkm7madDueSUGWLvytCx8Jiy?=
 =?us-ascii?Q?Tc0RGA4/qkxMXSJn8JkaYNjTSg8ZivEvknWdKRwoZ7ATbpTwu95aBEmWwN+7?=
 =?us-ascii?Q?m8jj/DsIh7u8F0wPJCrzuWhKQcoJwGlef9dIJQEjlQnlnBQu9Hfw0/U9+nAO?=
 =?us-ascii?Q?UhTpslyLkt6q3icrKrxpIggWIJ/1WnyxaRe3AkxdOV/P1tzYRWOkCgNg1wMI?=
 =?us-ascii?Q?KHDyifA/j8nf6o+dmo25n8bhnqP0JE8glLqSIo9y8dFYupR7x+V2os1NVp6S?=
 =?us-ascii?Q?JO6pVTYD9J9CST2JLzBIfY7R5WaAFNl9o0VO1DdDGs3LeCuWCz6Yb4WhALEF?=
 =?us-ascii?Q?0LfMkDArUpBZkyZwpJbypiPKYaBH8ryEmOAVA+cnM0CuCQSSX5ZqOzHlDOzc?=
 =?us-ascii?Q?dQGbblnsVX9jrNSHLSA4WvOnkrla4z2OHe31OYMQsTlVvXBZSo9AZmEGH9Gp?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63954ba-9c12-4aea-b734-08dcd1701708
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 08:10:53.4346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPJ3fAhtr1bdw8zFPfvYNerKfwPFq9lrBw8rF/h2nozBfjV7j/m5oB4lkqUbOfauK+lAm1RmaXp9N1CHyxVEPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P192MB1989

From: Daniel Borkmann <daniel@iogearbox.net>

commit 626dfed5fa3bfb41e0dffd796032b555b69f9cde upstream.

When using a BPF program on kernel_connect(), the call can return -EPERM. This
causes xs_tcp_setup_socket() to loop forever, filling up the syslog and causing
the kernel to potentially freeze up.

Neil suggested:

  This will propagate -EPERM up into other layers which might not be ready
  to handle it. It might be safer to map EPERM to an error we would be more
  likely to expect from the network system - such as ECONNREFUSED or ENETDOWN.

ECONNREFUSED as error seems reasonable. For programs setting a different error
can be out of reach (see handling in 4fbac77d2d09) in particular on kernels
which do not have f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err
instead of allow boolean"), thus given that it is better to simply remap for
consistent behavior. UDP does handle EPERM in xs_udp_send_request().

Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
Co-developed-by: Lex Siegel <usiegl00@gmail.com>
Signed-off-by: Lex Siegel <usiegl00@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Neil Brown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>
Link: https://github.com/cilium/cilium/issues/33395
Link: https://lore.kernel.org/bpf/171374175513.12877.8993642908082014881@noble.neil.brown.name
Link: https://patch.msgid.link/9069ec1d59e4b2129fc23433349fd5580ad43921.1720075070.git.daniel@iogearbox.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 net/sunrpc/xprtsock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 938c649c5c9f..625b5f69d3ca 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2466,6 +2466,13 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	case -EALREADY:
 		xprt_unlock_connect(xprt, transport);
 		return;
+	case -EPERM:
+		/* Happens, for instance, if a BPF program is preventing
+		 * the connect. Remap the error so upper layers can better
+		 * deal with it.
+		 */
+		status = -ECONNREFUSED;
+		/* fall through */
 	case -EINVAL:
 		/* Happens, for instance, if the user specified a link
 		 * local IPv6 address without a scope-id.
-- 
2.43.0


