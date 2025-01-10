Return-Path: <stable+bounces-108205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAADBA095C4
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 16:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43CC3AC60E
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 15:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FA32116FE;
	Fri, 10 Jan 2025 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="hi2p3ZqV"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2132.outbound.protection.outlook.com [40.107.22.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019C2116F4
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523038; cv=fail; b=ui65e2y9cJufYCadZRIBrv01gVo9NYUbArR4g6ysYTOZXMIZq6NznM0gV4UEtvFOZIrLbV7ZU0xkYQIHcJhV3iGpKYXKc3buYPqlNYevWiavVZWJQeEI8TCK+SnGbKvfzA6xEIkQaMAqSQSznKE2m47Dt6zYjUegciAiKxqzCcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523038; c=relaxed/simple;
	bh=92dzRXsJS0doWcrobp1KMr4c7RPvcpHAlO9lQjzw83Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EUneauSQTZoXCvYmTZocOzMKA+YXC/R8RLriDWxsNgUSaRCSun2UlzetTbV0SEtlzziuvPRuL33VZKH6m4K3CGb4Zd8SRVxPsAyweHssAUkImD4z+YuTXECThGjvpu32IRF77Ig556ydgBM+oaiXivkozMW1myUDzQtgINeEMOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=hi2p3ZqV; arc=fail smtp.client-ip=40.107.22.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6/zGD0mf2wD9wSA2dxB8r/Xion+XrahyM4nKyovyTfMfl7INDel580Y4DWoAnIIorw+koJdD9qkxzcauEg4iPqgB+wuWrm5PpIgxikNv9VA7ag65wcXaTI+xbkre/Qv3N2Nem4KuQ8nyat1tWNrXEErgnyv1Atj2aR9Zoiq8QKOk7LI4nl1M8VZP1HclIChcpICBtqmnpkthcq4eqq7mWaX4TFptAytT3cOh8issZzqTha7UiZfhmRPwhCV6aICruFet++vzdFt4C2JFXraEK9mMzzex8/SDZZ3C+dEDy/jIDOJvd4AffIzIJpJ1ZRHbENL2s3y8lY74sdMtQIvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEPo2xSso0vif6R25MFp4+MGcH6JLx4bo9T7kbJqFJ8=;
 b=Xu2CyeL9WCbfhSmbwFXPr5ebc4XTqS+mz0H3M8hrPBJ+Sy+0GZkGYnAy90w9Euf4AS49iP71RjLkqIZkII2ch6PQ8qHFA/X4UFS0hyNrBLIIbujm6tJlE+Qbg9Cuuj4Rw92B5c7SttYc+ExuJawsMbx19qciGhvKAkUZrwGD/pA51irKoj/U7kC46l8B7lvmOYS3/DRSBV7aLOYWaT23w46aoEEV23mAwadqvH8Xvah/jppbl183nyNbnWjMuvdOkJp5heuQSz8zxtdoeFSgbkG8c8yBwovDKhbHpYkh7ew259QrhhCXyESMdIlb88sNKAiYihUgRXHSbQUPbFgreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEPo2xSso0vif6R25MFp4+MGcH6JLx4bo9T7kbJqFJ8=;
 b=hi2p3ZqVMf8tlHby4xIRgWWsUdY3WbLH1LcCgPbo13gQGbA3b4xT2zcyg6O+QK95AHBSAiOBqoWROgL4OiXYiKuda/weatTcYm7/8w0dT8Gw/XbygTKpyHi7YHdAn2JiDZREZHO6K/6RPQYgbHIRTFijmaImYSdzCf2Mg9Ge5UTNfkMf3IP3flkJdRaKsZW417t1O8tBW+g3yvjNkTwClyZJyLunXk31qZswK/3y/wviRV4d1SayU5wCAabJZKgdEr6UolrMDTwi0Ca+om0DU2Rp2NE9ArFRIjCW3b0ZRkdroW8/h9kVvS2DPsL/mIGvbUSADp4xNTbfsOXpThgCeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS8P192MB1704.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:525::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 15:30:32 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%7]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 15:30:31 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Lonial Con <kongln9170@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	BRUNO VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 6.1 2/2] bpf: Fix overloading of MEM_UNINIT's meaning
Date: Fri, 10 Jan 2025 16:29:58 +0100
Message-ID: <20250110152958.92843-2-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250110152958.92843-1-hsimeliere.opensource@witekio.com>
References: <20250110152958.92843-1-hsimeliere.opensource@witekio.com>
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
X-MS-Office365-Filtering-Correlation-Id: e128a454-7d79-4711-0165-08dd318bb803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fHkzjL4E5Uh8VyGFg9LKzxblC4yRnaf98KVkSgGGXL4Q4Az9MU+QSyOfKhVT?=
 =?us-ascii?Q?t/Kzw2zpv9tScQW3hEDjFF15exKIth27sci1sx4fb/osWJZcPEoFZayLLSmg?=
 =?us-ascii?Q?UW3Zh69b8/VQdGMtN0tcDn4PmmwSQdDNrWuCSXAgiFwQshZcBffHaa7YCA8N?=
 =?us-ascii?Q?BbThr+cVpkirIzhKXVb3Rw+bXG4P/F2HKmMGsMSn+yM1CjB26E4w8P0GftCg?=
 =?us-ascii?Q?YLzZhSWklUcTMEMlIF0YE4VbLfOgy2I2KzzKVV6qdWRbl1m1ttRmMSvTmnm3?=
 =?us-ascii?Q?wAkv3+ZYyAz8JeJ9i3GppOhHUuC94sFJvHVjXUmEevqwo7kikOmO81ZtJ/pp?=
 =?us-ascii?Q?YQ94D2Rw6T0K02dryrU8kfc/lo8/OgLF0vBNgSpDHDD3j+s+xBLTLu36fcsU?=
 =?us-ascii?Q?vUrfMLTmvfekgWBm/dHbGbmQYn0kJeYVkKHtDUl7L0YAXOBRI1YkxaAFRtfT?=
 =?us-ascii?Q?XGDA0PZ1jhwpZzIeG8/GzH4lXtg1mZa5ire8ZUhfZuHfh5urhJNK/WweKUxp?=
 =?us-ascii?Q?LMSLm1hsEhE4rKV0QeZBO6kVr+ctb6sExkh+L3f/M0K/DMABK7kw9DbIu5mo?=
 =?us-ascii?Q?i1K31kszUOql2hKJ601buyxOYuNpKDXu6MDmA8hv6J/VR7R1pd20OnPwq4OQ?=
 =?us-ascii?Q?1aYaWn3m5ZOb/avXgXEj8mRpBlyW+ieiOR41BDIqwB1t3B+uj7je6z6UIl78?=
 =?us-ascii?Q?EIZIlLk2YVUhO2Tor20Y6ry3STgpq813jdbJe+EAiq4E7Gg0Iky9Ge6rSPIp?=
 =?us-ascii?Q?ZuO//CV7nEJd63fT0oTc0vCbJ/stZ90GrscZN/5fAhTo1rGnIFx+NdVlNIPe?=
 =?us-ascii?Q?eBOjZZu+tNcvRHpqTbFh92e1bPdRtGGFcY3oQEWtE6rYPzdIa8gG1ssyH5of?=
 =?us-ascii?Q?LNbz52GRqjYvEez8JUPzEbskhTJ9wN1CJDODhpse/3AuUpU9ivye2MQ+ZASN?=
 =?us-ascii?Q?UhkO4nTEcQMEEms5rgED0jJZNU4R0MeLS4b6FEpWhW9qqLN2EbnEwIvTGJ46?=
 =?us-ascii?Q?4D+8yfDb11iZ6wGebe+aNFDrsKkb5TcD/ZWrJt36ZdsfgEbQayUqtX59uuce?=
 =?us-ascii?Q?pzD+S+cKudCPpGOCDTs2eWK6occHmc2KD329J0sZ+AwPGp+I4PkBot1i5zXR?=
 =?us-ascii?Q?sTVJuE7MBrgO++OKlKcBmNth8lvqxNZ8yt0mQ4fLoHMbseJZwZIyjvUltHOw?=
 =?us-ascii?Q?waiyP4tv4O/vmjXi0VbM8/IC5grqih97ZkG+zQQuMSzbmkAxBKi/Lm55qNyY?=
 =?us-ascii?Q?binLkqQ917fO0AfGHNNKInEEQCjZM35GOkTwhWjB1XleJCaxlOeTgavJ3C1S?=
 =?us-ascii?Q?rxDGt+eqtNFkiLaL+F/EfZGRxLPqoxpvBi339+0XNYaOCECpSpPor2ykqv6m?=
 =?us-ascii?Q?a6YuVEZJF619JJ1RLQboWzAldiDZZ4lsIVbvCiHfwbhIzEOGR6wiXvFizWdE?=
 =?us-ascii?Q?oIQ3FLGhiUYoDOrCqqDDkEgCxntPPzzM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sbj1tJnqi75NglPdWvqoUWZrwBzkGJVlYIGVc95aJvQfUX/9WdUD3g8Mnudv?=
 =?us-ascii?Q?EKKMbSQPD7WX2irURVHuXedg64I42hnvP0d3Cr2f8ZkjhrIl39X/KCatp7EX?=
 =?us-ascii?Q?oykkfo8Yd42YSHE5/GHkK+ROfB5FsA+GnYxOZMF3zu078Na/e3akq9zRfVTI?=
 =?us-ascii?Q?zd/6rrz1HcJvUpwY1kiARUgZyt/s8xvvr0+D+75o2lSt/y3oksqBi72Aa8fK?=
 =?us-ascii?Q?u2Q9k9V6MMB0XahBWR/UmxIqcwtAkP8avURqqpq8vHyrd7b5Lr8oi1QLVgfT?=
 =?us-ascii?Q?vC9pkDnF6S2EjuvcT1+TytPpET8c1NPdGiolTmYb0AbDfNsrLBKu7lKSdZ0C?=
 =?us-ascii?Q?TmgxrP6WNegFIYTQ9Cv5gjBn686vGmXBv5s3YqPMPoFvS8mEA96Jn5gmgpwv?=
 =?us-ascii?Q?ZDQa3mSZBu+z+hboJ/uT2KKXBZYPlgQ/NO/9rkx4jpF7mhZWAXDo+pyjDiK/?=
 =?us-ascii?Q?HAfSqhQHxmomECGKwbSbZRXX8i4RyNiSATx0tWpX7jT02tgF+XU6uW1tIpdP?=
 =?us-ascii?Q?dyHVqYRPchKxaQOgWNivfpPxV2skpp7ve2Wu5v3T7PaTSUgGhHGzGeEILlqK?=
 =?us-ascii?Q?9YV5EbHhaqoOJRILNQDuer3AgTb8OVtFKVivUnbOQm9TSys6wpZ9XdH+5N2C?=
 =?us-ascii?Q?h/wE71E9krzO62p5+2+QpbP2SQR3xp5Ax4w0m4fezLi5MnXpZpiprtEQW/w3?=
 =?us-ascii?Q?UJ2088B2wiEQ3ile9BEol29g44tyXaylblji9qQuPnvNdKqRKWkEf6+ZTfAt?=
 =?us-ascii?Q?fE7B3UX3kBSfjg3MSiHXH17Mnr2CzIDmI1ZerPMKCU3Wqf7vYcxPgploeQNp?=
 =?us-ascii?Q?ANZkDntEjzjhtDk4gaK150VdmFr4Aye40bQQb2wxPHUkRwz6eubvibKfl5OX?=
 =?us-ascii?Q?rh8yoc2ymqBr0IGXF23UWT9xcFKQtGt32k7cXmiiSLXjjf+aS+cJ3FLe7xG5?=
 =?us-ascii?Q?sk5/2RnpY3O8YAi+l81vzzjYAOYDAmLmxX0OEF2Hp0iNo0eAMQ6On7dQHuHC?=
 =?us-ascii?Q?Bv+KOImhg/DqE68YJJ98kscXk2qn0/ahf0nS9ojnaA++UD2hGHjYZDcjGEvE?=
 =?us-ascii?Q?hUpXuorRw7SQlcxS84h3+u1IsCZ5lXSLC2bsKxfQYUtlweOMwQOhbKtL+t+F?=
 =?us-ascii?Q?yPncBgkI3w5VEGiXvZd1Qqapn1eiQiIKL+7i0dW0iWCfvVSPyHWo6Areue8l?=
 =?us-ascii?Q?BUKBQyri068ldEEoEdxvjszxTftCt4n5TTo/OJQRw0Z+gnoFvweNlqag2y3J?=
 =?us-ascii?Q?otzy5hsSSjtcEGR4wVSq+et3xgqtmJDhK9zCrpfU5pKgdSj0KCdBvouHaqwv?=
 =?us-ascii?Q?e2qCHglKhoumAJsGzbmS6qpgRQHxZzpx1/7b6N0IQq35GggYx12WMR97qSv4?=
 =?us-ascii?Q?IGgVgq4scQqhXt8uwpC9GxEWhJ/nAqrvmrsJ7/f/zBLd/uU1KkWD0+2d+NcH?=
 =?us-ascii?Q?dQtHylGkoO9jzqL6OAswcLxMG6jdI8/ZiHQW6XBhLQ+pzULX3PcbCmZDrDj0?=
 =?us-ascii?Q?n9WxwawCbs2dAanpvQ2g6apwONkbPcErlPiJSNhZVS2sqoieF8EcDeqm8chO?=
 =?us-ascii?Q?FVqVW/Y0N07II3OnkD3IPXj0pnRNdFrCzaBagq8x?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e128a454-7d79-4711-0165-08dd318bb803
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 15:30:31.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ek29PHihsCAKr1B2VjAHbnHVYx5q/7qdMXCuUlLYZvbfRTKqBXNixtiNVNTnxp1jKKgmEhUEMTS+H65VPvKBAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB1704

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 8ea607330a39184f51737c6ae706db7fdca7628e ]

Lonial reported an issue in the BPF verifier where check_mem_size_reg()
has the following code:

    if (!tnum_is_const(reg->var_off))
        /* For unprivileged variable accesses, disable raw
         * mode so that the program is required to
         * initialize all the memory that the helper could
         * just partially fill up.
         */
         meta = NULL;

This means that writes are not checked when the register containing the
size of the passed buffer has not a fixed size. Through this bug, a BPF
program can write to a map which is marked as read-only, for example,
.rodata global maps.

The problem is that MEM_UNINIT's initial meaning that "the passed buffer
to the BPF helper does not need to be initialized" which was added back
in commit 435faee1aae9 ("bpf, verifier: add ARG_PTR_TO_RAW_STACK type")
got overloaded over time with "the passed buffer is being written to".

The problem however is that checks such as the above which were added later
via 06c1c049721a ("bpf: allow helpers access to variable memory") set meta
to NULL in order force the user to always initialize the passed buffer to
the helper. Due to the current double meaning of MEM_UNINIT, this bypasses
verifier write checks to the memory (not boundary checks though) and only
assumes the latter memory is read instead.

Fix this by reverting MEM_UNINIT back to its original meaning, and having
MEM_WRITE as an annotation to BPF helpers in order to then trigger the
BPF verifier checks for writing to memory.

Some notes: check_arg_pair_ok() ensures that for ARG_CONST_SIZE{,_OR_ZERO}
we can access fn->arg_type[arg - 1] since it must contain a preceding
ARG_PTR_TO_MEM. For check_mem_reg() the meta argument can be removed
altogether since we do check both BPF_READ and BPF_WRITE. Same for the
equivalent check_kfunc_mem_size_reg().

Fixes: 7b3552d3f9f6 ("bpf: Reject writes for PTR_TO_MAP_KEY in check_helper_mem_access")
Fixes: 97e6d7dab1ca ("bpf: Check PTR_TO_MEM | MEM_RDONLY in check_helper_mem_access")
Fixes: 15baa55ff5b0 ("bpf/verifier: allow all functions to read user provided context")
Reported-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20241021152809.33343-2-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 kernel/bpf/verifier.c | 76 ++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 40 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bdd5105337dc..ead1811534a0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5416,7 +5416,8 @@ static int check_stack_range_initialized(
 }
 
 static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
-				   int access_size, bool zero_size_allowed,
+				   int access_size, enum bpf_access_type access_type,
+				   bool zero_size_allowed,
 				   struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
@@ -5428,7 +5429,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_packet_access(env, regno, reg->off, access_size,
 					   zero_size_allowed);
 	case PTR_TO_MAP_KEY:
-		if (meta && meta->raw_mode) {
+		if (access_type == BPF_WRITE) {
 			verbose(env, "R%d cannot write into %s\n", regno,
 				reg_type_str(env, reg->type));
 			return -EACCES;
@@ -5436,15 +5437,13 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_mem_region_access(env, regno, reg->off, access_size,
 					       reg->map_ptr->key_size, false);
 	case PTR_TO_MAP_VALUE:
-		if (check_map_access_type(env, regno, reg->off, access_size,
-					  meta && meta->raw_mode ? BPF_WRITE :
-					  BPF_READ))
+		if (check_map_access_type(env, regno, reg->off, access_size, access_type))
 			return -EACCES;
 		return check_map_access(env, regno, reg->off, access_size,
 					zero_size_allowed, ACCESS_HELPER);
 	case PTR_TO_MEM:
 		if (type_is_rdonly_mem(reg->type)) {
-			if (meta && meta->raw_mode) {
+			if (access_type == BPF_WRITE) {
 				verbose(env, "R%d cannot write into %s\n", regno,
 					reg_type_str(env, reg->type));
 				return -EACCES;
@@ -5455,7 +5454,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 					       zero_size_allowed);
 	case PTR_TO_BUF:
 		if (type_is_rdonly_mem(reg->type)) {
-			if (meta && meta->raw_mode) {
+			if (access_type == BPF_WRITE) {
 				verbose(env, "R%d cannot write into %s\n", regno,
 					reg_type_str(env, reg->type));
 				return -EACCES;
@@ -5480,7 +5479,6 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		 * Dynamically check it now.
 		 */
 		if (!env->ops->convert_ctx_access) {
-			enum bpf_access_type atype = meta && meta->raw_mode ? BPF_WRITE : BPF_READ;
 			int offset = access_size - 1;
 
 			/* Allow zero-byte read from PTR_TO_CTX */
@@ -5488,7 +5486,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 				return zero_size_allowed ? 0 : -EACCES;
 
 			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
-						atype, -1, false);
+						access_type, -1, false);
 		}
 
 		fallthrough;
@@ -5507,6 +5505,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 
 static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg, u32 regno,
+			      enum bpf_access_type access_type,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
 {
@@ -5522,15 +5521,12 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 */
 	meta->msize_max_value = reg->umax_value;
 
-	/* The register is SCALAR_VALUE; the access check
-	 * happens using its boundaries.
+	/* The register is SCALAR_VALUE; the access check happens using
+	 * its boundaries. For unprivileged variable accesses, disable
+	 * raw mode so that the program is required to initialize all
+	 * the memory that the helper could just partially fill up.
 	 */
 	if (!tnum_is_const(reg->var_off))
-		/* For unprivileged variable accesses, disable raw
-		 * mode so that the program is required to
-		 * initialize all the memory that the helper could
-		 * just partially fill up.
-		 */
 		meta = NULL;
 
 	if (reg->smin_value < 0) {
@@ -5541,8 +5537,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 
 	if (reg->umin_value == 0) {
 		err = check_helper_mem_access(env, regno - 1, 0,
-					      zero_size_allowed,
-					      meta);
+				      access_type, zero_size_allowed, meta);
 		if (err)
 			return err;
 	}
@@ -5552,9 +5547,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 			regno);
 		return -EACCES;
 	}
-	err = check_helper_mem_access(env, regno - 1,
-				      reg->umax_value,
-				      zero_size_allowed, meta);
+	err = check_helper_mem_access(env, regno - 1, reg->umax_value,
+				      access_type, zero_size_allowed, meta);
 	if (!err)
 		err = mark_chain_precision(env, regno);
 	return err;
@@ -5565,13 +5559,11 @@ int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 {
 	bool may_be_null = type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
-	struct bpf_call_arg_meta meta;
 	int err;
 
 	if (register_is_null(reg))
 		return 0;
 
-	memset(&meta, 0, sizeof(meta));
 	/* Assuming that the register contains a value check if the memory
 	 * access is safe. Temporarily save and restore the register's state as
 	 * the conversion shouldn't be visible to a caller.
@@ -5581,10 +5573,8 @@ int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		mark_ptr_not_null_reg(reg);
 	}
 
-	err = check_helper_mem_access(env, regno, mem_size, true, &meta);
-	/* Check access for BPF_WRITE */
-	meta.raw_mode = true;
-	err = err ?: check_helper_mem_access(env, regno, mem_size, true, &meta);
+	err = check_helper_mem_access(env, regno, mem_size, BPF_READ, true, NULL);
+	err = err ?: check_helper_mem_access(env, regno, mem_size, BPF_WRITE, true, NULL);
 
 	if (may_be_null)
 		*reg = saved_reg;
@@ -5610,13 +5600,12 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
 		mark_ptr_not_null_reg(mem_reg);
 	}
 
-	err = check_mem_size_reg(env, reg, regno, true, &meta);
-	/* Check access for BPF_WRITE */
-	meta.raw_mode = true;
-	err = err ?: check_mem_size_reg(env, reg, regno, true, &meta);
+	err = check_mem_size_reg(env, reg, regno, BPF_READ, true, &meta);
+	err = err ?: check_mem_size_reg(env, reg, regno, BPF_WRITE, true, &meta);
 
 	if (may_be_null)
 		*mem_reg = saved_reg;
+
 	return err;
 }
 
@@ -6227,9 +6216,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->key\n");
 			return -EACCES;
 		}
-		err = check_helper_mem_access(env, regno,
-					      meta->map_ptr->key_size, false,
-					      NULL);
+		err = check_helper_mem_access(env, regno, meta->map_ptr->key_size,
+					      BPF_READ, false, NULL);
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
@@ -6244,9 +6232,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
-		err = check_helper_mem_access(env, regno,
-					      meta->map_ptr->value_size, false,
-					      meta);
+		err = check_helper_mem_access(env, regno, meta->map_ptr->value_size,
+					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
+					      false, meta);
 		break;
 	case ARG_PTR_TO_PERCPU_BTF_ID:
 		if (!reg->btf_id) {
@@ -6281,7 +6269,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		meta->raw_mode = arg_type & MEM_UNINIT;
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_helper_mem_access(env, regno, fn->arg_size[arg], false, meta);
+			err = check_helper_mem_access(env, regno, fn->arg_size[arg],
+						      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
+						      false, meta);
 			if (err)
 				return err;
 			if (arg_type & MEM_ALIGNED)
@@ -6289,10 +6279,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_CONST_SIZE:
-		err = check_mem_size_reg(env, reg, regno, false, meta);
+		err = check_mem_size_reg(env, reg, regno,
+					 fn->arg_type[arg - 1] & MEM_WRITE ?
+					 BPF_WRITE : BPF_READ,
+					 false, meta);
 		break;
 	case ARG_CONST_SIZE_OR_ZERO:
-		err = check_mem_size_reg(env, reg, regno, true, meta);
+		err = check_mem_size_reg(env, reg, regno,
+					 fn->arg_type[arg - 1] & MEM_WRITE ?
+					 BPF_WRITE : BPF_READ,
+					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
 		/* We only need to check for initialized / uninitialized helper
-- 
2.43.0


