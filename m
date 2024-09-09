Return-Path: <stable+bounces-74053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD64971EEA
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7463B285C36
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8307613AA2D;
	Mon,  9 Sep 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="c5N88Fpf"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2113.outbound.protection.outlook.com [40.107.21.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC913C3DD
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898569; cv=fail; b=nVCLNYmsxKp7ZTbwuw4NIrKqfFPH+p09MALFTfDSm1wRRF5CyIvCBmylKs2trxym+ejTp7a9ixiTAA2+Lwl1yLAwTnHYuOMMS9JBKBQvcVfnXuIBBRSTfMA5UgSwZLHRiHG8BjKynHqZpcR++VJ8eFqUu5RU7xfunaKbQul0mX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898569; c=relaxed/simple;
	bh=WOfdG66A5SoZA2YJS0Q2/uMJGtmyUGrTpET1a16kToY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RtE8l3Rddh7IGHg6GVIz6QidcuIj3KVa5np9yG+R9IRHhjElvEkiuUbO2aNELWK11bi+L/fadtNa0vJcKZvYFw7qcDOu+n3Q67CSayuvBPHo9/0rLv2dmHb+M1Ap9JOutxr/ConVI5nmZ1/E9MJwlwG4LHjoGotEAH1LdfV7y5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=c5N88Fpf; arc=fail smtp.client-ip=40.107.21.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FL5xBMAgowTONss6UatBRtv9DwzrooL5alOy5rnSRxuG9btPYc2x7uSJjVTFGD/UceyPo+rSt4Y/yTSNBilLlCWnrwZ5/eg8wJEDiMc6MqbS0PGAd80DU2JX8r9irWsSCwoui1U9m362F/TGLez/rCoE1oo6fpQdF4mUdK2QhvR+SFAyJZ+Ve1Yqz4x1SjaBnW2YY2x2YqSK8VSsWpveAc1ZuUmpnWEEDGpjF9zIkXCD6rlUDgjdnhyDCyxbXnzpEiqCRIRD8olqhPg30rpjAQ66ialF3YBBP/ixbFIyRidYQABUQaDK7XJDfaidD0+wcWqE1zR/eHwJUv5Bps0yNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxzeFsK7RtJ+68+HNPouaXW1/2e/AzXFJh9pvv80o6E=;
 b=YqFoImxL2ncB8Wi39mhLhJTKvNH0Dc8QWrsnMJR8w/4NC6I96MrRdWLw7YpqISJCqlXoPBTL6On80oaEgybw2fzruvbJFKYt1C0spGVyx8baFZ5/lXUcr4w3n3uNXoeOzj8Fw4hDfFHiZMNCPjuMSytXh+Dru3upEHCcSUQkl3Gv1YjqTBFsFZnsO/gEt0gTb8DhQtnZ7Fe78IpQEFh1FfOGNFyBRmPbsri+xPBHC2y40acVG4oFFBNmtdj8VCZdNBQdxFjg7mDXJwOIjicPMW04uBi00nO+zRbbXLnDy7/hHuv9vD+dx+ix5vFBs5tZSnDiAw0iFpYf7/kdXPNWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxzeFsK7RtJ+68+HNPouaXW1/2e/AzXFJh9pvv80o6E=;
 b=c5N88FpfQ2j/4Bvpj1r077A01FFNV8hOLzJQkSz6rYPrsQe8N4Vdcasgs/bWPXNOdIfEtFTCfXDRtYVLrMUbhPpQ+LL1twHpB/SZDx77/CZTtFv+Ck8fmtx7jNLXci9gJP/NrQjUFNfsl2piUmrxA6vnR6lmjNYrlTIKqnfMyC9QBIfSd7yC4jDp5psPJcUXDFELlVL+gtT6IXMgT5jOcs+1zTojsq5R21V2/NUPVURrJnaXHDjmh1p/s2+0fKE9VcCi8nXQsINdqE9QzIGEOJ7pafezi1ED7A5Ja9QJ+T9GDpeg97PydXrNoq/cOQFCTzOBQ+yJ5C2Qg0FUGDnZRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS8P192MB1845.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:528::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 16:15:59 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 16:15:59 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Lex Siegel <usiegl00@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v5.15-v5.4] net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket
Date: Mon,  9 Sep 2024 18:15:48 +0200
Message-ID: <20240909161548.255373-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0055.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::15) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS8P192MB1845:EE_
X-MS-Office365-Filtering-Correlation-Id: d155115e-8fcc-4c3d-d336-08dcd0eab0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EjaZLfzqlTiLZ3EnHLcmmn/wltDlJDl7lNT44VKUEW8n9iQvA1ChlzYFlqnn?=
 =?us-ascii?Q?3OuM/KAx2qbr1z3vkqRmOdsACdYJ/eXX60GWcoud/vttIncG2O8p9nZlXO5K?=
 =?us-ascii?Q?7NtJkEoUkThuTM9gEbC5I+tz3ngExjA+x+n+HR5wHw+luK3kZ3z9NK/VnzBT?=
 =?us-ascii?Q?0fP3lwPQfCz+A26CpGlwrNvpTW8uHzHTHEE5yEbvuQ0FvIWn4oz2++YHQy5r?=
 =?us-ascii?Q?lHWlJVeWdhjpdv8Or9yTqnZmjbCVbKM52cv0SgXRbE0FNxYHzkn6LL7V/cup?=
 =?us-ascii?Q?AGOzGShv6s0BB3r4/M8UQIbZDuyIqr6jFApe27w8UeBK1sidIQVoDt5OaMqk?=
 =?us-ascii?Q?Y9KSDjn1thnPMEbo7tXvajxSM+YuJIegHp5sej4kjmquOu7NgtmMztDckpmo?=
 =?us-ascii?Q?JkjphxcsuQqRHIYiJo8HLPcVXnNaFB69edmFqJbj9Xs8h0ExvD+8fwf9BFXe?=
 =?us-ascii?Q?GL0P69HfurVMBqSldexGR9Q/JcwBo6jWG51HFgpx4ig5XDLNa0T9NiiwqJ66?=
 =?us-ascii?Q?UZWazCkqAzHPgkN5s4bbuRQ53aynU3Ep81Jfys9aIeHH3UInB1XqIjruoXKe?=
 =?us-ascii?Q?3nKWCRBLo/0wcoRxoSB15ZJLr+XMWeMO+04i/ttXELxzS+bvzsRftHHlJT/R?=
 =?us-ascii?Q?f8stOygdeS75BWVErDzcsU66O/Wcz9xn2UXPfyVZxGgGQdcXOVzfuznmG/4G?=
 =?us-ascii?Q?MvKmaOVm3lmVdIo6ya8Xx0juqSz6B1IkWnt1craUJxl4Hn17PDGrq28FjTTn?=
 =?us-ascii?Q?JfikPalhKACLVglEvqGXCHludZAjnXzOPaxvK1tcWCUD+kbL6h/b/6FYoDGY?=
 =?us-ascii?Q?tPZi0x/eg8aOpAZpYGsVAGQrl6hCSleuD/FKeYQMANX+2q/oHXIBc9o3s64M?=
 =?us-ascii?Q?ULyDd99Y16Ar1W7t6VwdpSE5+vdAVvt7Hv8F/qqGuy4NFu/fG6zC2J9LBdF2?=
 =?us-ascii?Q?HFg4eWt/PJjAFi/ydZ1PmuS5lG7miAf2oEU/IwLZB+l39SYzXfco7XuivUjy?=
 =?us-ascii?Q?uog1aWD2EjpADk0UyOOhCWvTW6LdTLLwEDW5M/Sk7PpISuPhKcjbVJc0srTt?=
 =?us-ascii?Q?JdSKlz7wLagn/vHcCokzZq/47cuXJ/vBgJiHmELLmHoLS+/dclAN1+WdTJs+?=
 =?us-ascii?Q?rTCins2SVIgwvj3bVd04L+nXc2NxmQuVGHkbyQT8gnnR1oLcXA6QX+vifCWQ?=
 =?us-ascii?Q?hqXkEyxYycMo96cAEIUkmPBEJSraUdWJ2ndEzmzWM8eEQEofnnz/BqiUNyG/?=
 =?us-ascii?Q?mnNIhf0C+9vX+zs0vBInDOWTm5vnqEuPjyHwZroRFyGFwWg+xQKxr+xEeNin?=
 =?us-ascii?Q?BlPFi7hg6qRvNBQbmuxeaLurl02Ni6vvrXKumt4z58F0tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qkm4xBnbzFpNN05R9Ettk1gAdEEXy/k4C23teKsI6rvqhqG75g422bXyd4UR?=
 =?us-ascii?Q?rxUmpuga+u5tQC0+l/UW+xVTJ0+MYIrzHo0Qm132+MokpSckFW0bbw74yxQg?=
 =?us-ascii?Q?cDJORhgYw/eAQ3+9nOVQIaW/F80uJj8yHJ2tWAN0gtuzSqMUBDecpDKok0GF?=
 =?us-ascii?Q?t5mVQjc3puNjhTd7mkM3SZa4VnFWoH1d7UuWRyXLP8mahwW+3FjKB94gan6/?=
 =?us-ascii?Q?OpH3aCD/Sl7J72+B65GRJzS5FP+IyJ+9UmZVYnOakUQx5HiJHcRhnVniYwqG?=
 =?us-ascii?Q?y4qcm9xXznJLZ0mswtAHcsmhfVTVyznXLPMz0VLU6hJDjfD4utoGimpdOjGC?=
 =?us-ascii?Q?ymmN/gjUY0884HHZBv2/WY0QcXXPEKxx7mTVefdLjiz4+xgIN2XEm1hZea43?=
 =?us-ascii?Q?Zt7dSRFY9OAeS5X38mjGz/0WpitHnrBAvZLfJtAeYHnIZVS2uKL0oHYYc5vC?=
 =?us-ascii?Q?Qs4bRYCEokupX4bc2y9zevH0dkk8kH/BGqRkIgkjHhY82XJVA1fyiRaLSPQv?=
 =?us-ascii?Q?daqQAufWOJVK+zbaDhTE/5Fd+sERYXkjGMqr1yQAJ2a/guj7nNMx0yTSWF4W?=
 =?us-ascii?Q?s9wHlfzkmjXY8xzg6VR7qoRzl/rB6B7K0S4YFlpPlhiR3IrVPmrmzA868vpV?=
 =?us-ascii?Q?62usXJMD4HeuOQL9/g+DJ+Ftu5xwGS43oEcf7YOPp/midLm7ZmKglQQ+NerM?=
 =?us-ascii?Q?cIThy3UTmryGEGZFv6AORL1Aau7/AjJBBZABpav43TECk6xhK43XFl9dJyym?=
 =?us-ascii?Q?aTnjIjyLIX/ZFpWDEkxqqRyOTx8oTXyMsoQZIZ+HwoC3W54p+PIAgEp4Bchw?=
 =?us-ascii?Q?waJZCJMXkF/cxU4j1W15ic93tACpupBudVcevIQZdawMX+BtE23eNQ0h6UuG?=
 =?us-ascii?Q?DBnk03MBVPIE+WBPkV81jD5QmvDs0SaEhdCKNDcc6RnTSgSnrn/WduEiMjMk?=
 =?us-ascii?Q?r9JNRRW2WaavsgCa91jUU9dlrsUt9dZndlZHxRStdh4NcsMvPMWOASi8Hz1y?=
 =?us-ascii?Q?z74X+Zv+k32NNSxOK+V+NaxMuzbL66YGQMo2VUQ79sf3ERHcqC/4K0QAYfNF?=
 =?us-ascii?Q?SC6EuWad69ngh/0eDQ6D4cqNVe4eiQbEQGXzmorRiTW3z+uc9K0HJTw/UgrE?=
 =?us-ascii?Q?ATYOmHn7bBHUXjPoH+eWViLj5xHWMVmIf48BX+d4KyqbCGWQ+gO71elk2fVw?=
 =?us-ascii?Q?RzUrFV5VpXGLlTt9PpgJL8P9n+3UDIaRX1XmKnrkg/RdzI09K0IkmMKcYTsV?=
 =?us-ascii?Q?Q7aHQ2saYPOBFQEn8pIvXXvDqJcxxtMyQK6/nykcXTJBHDRHz1SDctDJreSP?=
 =?us-ascii?Q?pvCvdC+Z90DVmMDLrgp7Sx+vyKKEBds3Jiqw5AGVDFvkQm386v+2wzmCwX2P?=
 =?us-ascii?Q?Mio3Ka9n2mpYf9r3je2SNY+1CQc7KQVBJyaX/3S5aEZsVajPlnl4XSmcQtxt?=
 =?us-ascii?Q?F1uSa4tO9WD0dh3llqRQMRlJCuDmGSOdeHPJNpmxIE+3v3DZYNCwbRyYlbR3?=
 =?us-ascii?Q?/5yRMHhIvLXXGjPZbdNxdpGPC9+XCk8NyktDzcfQ1ihmIY3kIdztErNglFPt?=
 =?us-ascii?Q?Vb2AsF3KhGq0b2X3R20jFil5a58yMV0f4JY+uqW12RxFwpbM6hTRuFZdwTAM?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d155115e-8fcc-4c3d-d336-08dcd0eab0fc
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 16:15:59.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ih7YBKS850fp4G1aiceA9EObiELAT19Qs6iiJFBGRSiaZo7tAcboEZVMdLI5BMu4i0mNw2jJV5XR/0QHNkYmoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB1845

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
index 0666f981618a..e0cd6d735053 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2314,6 +2314,13 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	case -EALREADY:
 		xprt_unlock_connect(xprt, transport);
 		return;
+	case -EPERM:
+		/* Happens, for instance, if a BPF program is preventing
+		 * the connect. Remap the error so upper layers can better
+		 * deal with it.
+		 */
+		status = -ECONNREFUSED;
+		fallthrough;
 	case -EINVAL:
 		/* Happens, for instance, if the user specified a link
 		 * local IPv6 address without a scope-id.
-- 
2.43.0


