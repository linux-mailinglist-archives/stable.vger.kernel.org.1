Return-Path: <stable+bounces-74001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BA49715A8
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 12:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BABA7B23519
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232C01B3F18;
	Mon,  9 Sep 2024 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="s3RVgmtV"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2098.outbound.protection.outlook.com [40.107.21.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD191B5309
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879233; cv=fail; b=IQlubrUr0zE/wgunHPT/8CBk6ElInul9wZgSgA8csoPKnf6YzcERET3hVLdhhdL5Aeov8a+aTTmV0GBj/88XT2ED3EzOUr9yTXPnbcY4Z5C3rDzkkKqyn+U58rHp8JVnkiB/lNW8PwRsaF/nG5lYFI0UysPaIltET/vIweJox+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879233; c=relaxed/simple;
	bh=qgc+Zcfo5xYpeXjKl81LKBPbokTPXNDjS/DaxP5ZZNY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JzzE9KEAp8pAPXs2lkEpvUQdaE+xpZ2aAQ+QWv18HU0DGHxFTJ6a2SX3otsi2KlDliajzauMLfy1aGtbgaAlTy4WnidGUVPCdCh5bAemmps6DRdqGUDtlAmtcFVcmxl4pxJWXy0HDRj2Chil9PcssUDN4FyeNZC5Mayjbyk4/SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=s3RVgmtV; arc=fail smtp.client-ip=40.107.21.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePNiPNUufi7F+peeuqsZ8znQsDkg1/gA0/egVd/WtBO3rK9cBb5fJj0wPQH6aliny5y6qWWo6KX5rABNqiK2AtuMYn5cgiObPFuymn6UC/QU9NpO4H+sFXsaGeElwRE95B19JUpxi/yQMfHMK0cojh+aL6yirqmZIPSlEgIDAoOcO9STDq2MTfvcX1FdDEmZVddoolzUkWupVY8X75VDh8Eaqj/R0/ebfTS7M5AKsaokMKePvlMxJWjq2yhhAxEQfIBMhIGpnPNbCULvX9SLD0K7Xu57Z7bVAGw4A+lx+xMO799XBvzSTvuxe6JewAv+kqNuWHbitHvZ6nlHzl//Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYEDoz/ruXmR/tYk4+8UKd8QsKlK8dLy8hq1Zt7CAD0=;
 b=l97RLpr6tG/78+me1S7Xr56xy3EQ6HaJjDuw+ITBa3c2Upca2Q5X7SKAF+tczCFMXfvK0dF2CktY+2Qi3S6Gop352EfWK0EOmI/4BpLBg94vtd4gHZIWN+zOkstzq0S/ihSXgwcGqDRurkQDz8+c0nz7/lgzpV/snnDT62tAWR9uke8EhM6xmBlST2BEa0LdeWsL7qHQKwi1o/t/ATj8HFRHirpqyDKuZieNPjNUeb5/gh4hpdZE17vR5g3AJECgNQSJTlMOGEdDjmUYqt26fWgQ2UlVlsD4lhS7OIZVZzKQmbTuYYNf9N1iBDhvMEJdlpgSVd3SxElAI+OXPeTiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYEDoz/ruXmR/tYk4+8UKd8QsKlK8dLy8hq1Zt7CAD0=;
 b=s3RVgmtVX6kOlR2Dg2+mbidFMwDEd2A/Jc7Fa5pJNs3qYblvRFYmHvgF30JXtgMY7jSWHtAgfQtj8zlTSABIUzav98S74EkctAUgJtGD94lr5DjiQQW7mB7YmDsfuiSSzHzQAMG9cbDDqRGeC2XOMAF+srGLEEPHHoFsQL4OFNdHxGps21rNElVZA6DvgfEovr1XfR/Z92UitOvtl83tbifwH3oZbu5sakekM2/cTPsa0BTuOOGLugBXCsu7d4z48Qk139gBcyZyEEGiEepMuBowKIcA0aOpS/0KGjcVWusMDe0e9ytzAgkVyiAZwhn5mcmulxTgRVlNf18rGSFiWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by PAVP192MB2086.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:2ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 10:53:45 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 10:53:45 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Kenton Groombridge <concord@gentoo.org>,
	Kees Cook <keescook@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v6.6-v4.19] wifi: mac80211: Avoid address calculations via out of bounds array indexing
Date: Mon,  9 Sep 2024 12:53:32 +0200
Message-ID: <20240909105332.130630-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0059.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::34) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|PAVP192MB2086:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ebe0e8-106d-4d3b-626d-08dcd0bdad02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ujav1b4nQiZj62sb8I7NjABjbEW8iq9S/UfoKiUShNLBzlYHmkGzB8drHuPb?=
 =?us-ascii?Q?dxN1mDY+/ucHrxzNSlttDMytgmEeDNIqWRUceXxuzAjKn8M0ZB9bxObCsyfX?=
 =?us-ascii?Q?fwcjoYIo4Jua4LaTu5eATS/dGNeZwB5hVFZAKX/w6lCPp1R8GsHKzvTxpgHx?=
 =?us-ascii?Q?YdVFmGqmj/shs5X6L4KHSF3ZWBgfjFJyzBNBAkRM2txPADhHPP5ZwUTOUUY9?=
 =?us-ascii?Q?4w++PuzhtO+eIDGY/VP9f9x4X2FUZXfI/L5rKGbSl9CRcz3QvHcUkoVcrmxl?=
 =?us-ascii?Q?SpfInjL7hnGFC0yWhpfogbsEMJxam6SOKY3jYCvouJ6PEliYOEZ50Ag5dP05?=
 =?us-ascii?Q?ECsb/dG7vmMeTHxqDfCcfbIRgJbk1piQ9HdfCfLBZlE5N9ZBqSqCXP6E+XGC?=
 =?us-ascii?Q?UMBYdOMvktGEOXM7baUgvz07C9CJ2T8CqQWCt+H4jtdRyge0IBlQucjBXZBm?=
 =?us-ascii?Q?qj6QQANnHQgIf2kqZJ7RlPNqnJDPzJn+S5ZUFpK8htz9r7maDLMxtg+m7vcd?=
 =?us-ascii?Q?LPoLsK24VqhoXzGQR7Y4KQXzlYNkMdx0KvZ7Hb0U7C17ezGEAMHdJMDcEamd?=
 =?us-ascii?Q?r1yYjahAo+mMlc07gmmpK6188kGr0OTQbL5FGT87Z/cRptY2hEm1LKFwJiNc?=
 =?us-ascii?Q?YJcmOttLtSglPs5rjsnfXPzvPT5N9lSvBYtZfEwa0GUYx08WODdHCn37ecDr?=
 =?us-ascii?Q?FojMlrvs/zVhpoH+ueYiCCayfWaZYjudQwmldQeu64Xn2wZrZabGvjvID9aR?=
 =?us-ascii?Q?jau6G+IbkEJV38nGJi0E0p4CeqBbWVCAPJL1uPZFjt/od90xYaVZeImzM9V5?=
 =?us-ascii?Q?h/yagEj4kCseUewH3iwsNaC962szTZMDBWBkgqcLFsAFB96enW+0jsZmM9IM?=
 =?us-ascii?Q?ejb26t4qcooRol9oLjehqncUy2BxoAH0EYM/nxZcIyfLw7YDTO57HyprMnNb?=
 =?us-ascii?Q?zsSH3ACanvQGR7RftNYAvWlNYrQS3zFOnSGXj/RTOQcJpV2DL0uLD968uAKH?=
 =?us-ascii?Q?9GZ6M0c7Lfs1kSQb0CmAADxsFBbQVS2zYdNKeoWIJlvOOwGPdy0j2HEQhXUF?=
 =?us-ascii?Q?c6Lpf41NL0z1zu/UwcSB1J/50ITll0wi5Tm4iX3Uxv0mHLBL34qdVAgO+eCl?=
 =?us-ascii?Q?F7sTNnqLg4dqfZxxe6Y4PqD11d4D5q1kjf/QnNvwwX7hM+qUN0Goi2gyuFlX?=
 =?us-ascii?Q?wPN6tQbV+uyEhME+94Joa9AnMz23bsFYzQs91X1/Y4k/2u910pIM+TQM+8b5?=
 =?us-ascii?Q?3PbqLnbc7DO1Edr8A4OndFeRVO/CQmVzYtKr2ZO6WHQbGFbRAWlIPHKt8F2F?=
 =?us-ascii?Q?T8Gi+4JGKFmHAO12PhlKklKX9CwLp2a5QDymbXW4bWeH4S74qvL04Tc6aG5+?=
 =?us-ascii?Q?4F6IR9w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eqik9n+5QxfPq8H23nqY8KXK9NkCgIoO+34xZd9nYXPLMwBian7Ua29AH/17?=
 =?us-ascii?Q?GiqreUrRQwXTGgUPx8oyLw/bStGv/y1e8+kOwHhMyevYUP37nnnkfpyBxi19?=
 =?us-ascii?Q?cdqUtieLZzpWY7kyc2dCtiZBSCSURDjYy3DgeZhyyzU/tZ6GscksoptNOmFT?=
 =?us-ascii?Q?gG65g0vkuwISFZJDVD3WyfTAIVgoT9WLUgDof7xaZNK8D4UPJxFbimSNw1pJ?=
 =?us-ascii?Q?eDqn1MpzDPuO/psoV+/BhNTuYb8DngnLWTQBTrT16pDPXDz4YbmXoM2cioOB?=
 =?us-ascii?Q?u6OaYxgyvIGyDLKeB7/Muh+7asUijuG7bOlClL/DxAUTMb0Hjk8xOiWsoybZ?=
 =?us-ascii?Q?M7zp47eXcvk/KOaRqXCdiB2aPsLrr0c2J14mBQRew45ZoMJx9D/CJqJ198t8?=
 =?us-ascii?Q?ParwiwflwlEi7Ud7YlB/owWU0NZuzmd3niWQA1HqhNckJpWExHP+TNfqgH7M?=
 =?us-ascii?Q?XUpGWoVxurQ4JZCIWUpoS/puKv73/CXjOVb/ayblRU6afPZT2Lgy4t6+AJ5y?=
 =?us-ascii?Q?QoPBorob8psM4kBC8pVIJjVwszkuevl3jqK/jQ9bw9RFLNrxMXNViYpZgRLn?=
 =?us-ascii?Q?mln4k9lkIEKHrTRB2wsHflAZsDdUk+LcArbZWWOeq8gga/gAf8f+564FIQ51?=
 =?us-ascii?Q?bMGpSCQhGSUl6ppdQ72l8ZsaNhxa4otdbQRA5sFvm1cdpQ64EOqRUyQHWk45?=
 =?us-ascii?Q?h6UU0WKTEObQh8C0NchU4055ZiUq5VdEfbR5DxkdYnJJgSGve/+y93/xMDMT?=
 =?us-ascii?Q?AgL4tWMF4n1eGy1izEtgM0gnw0XBz2m9WuAkvscO6u4MvgO0IR6vnd4u42OU?=
 =?us-ascii?Q?AFbzAYrZ63nelwTDSuFZWpCDZbi/W0N70ndfFzkRrhpGX6UTufsqpMNZbC2m?=
 =?us-ascii?Q?Xh6wZ0bU61mZMilC+sS/AlAmKcuvat9J5d3gGMIRU8DsLEKvgMckTdiDbWlg?=
 =?us-ascii?Q?dt44jxvGE4r69vjKYLRoGIItEr5q5v7/27O9y1s+umktiC+Hkc1jkGmhALt2?=
 =?us-ascii?Q?2+5JZ9hCUIaaQjAdv/Jez/4ZRmty5BOqYZwuAGqBUmVMVNgQrou1Y6Dpig76?=
 =?us-ascii?Q?AgsZtbCgCc/DpSZmhuQClKukJoRfG6Lutos1g/kWhijjsSirTaVyhHJa/UPs?=
 =?us-ascii?Q?+YoJkEOxkystG9hfQ3/vNbMzgbBXFMnpiKRZkt7YBOoWJac9nV7WrwCXuaou?=
 =?us-ascii?Q?1SA7QWHZvM174JCSKcICiiMljBGVODcHO1TDTWiKpxMzEk3Jt0K1RhiZO4IH?=
 =?us-ascii?Q?LR4sWK/i88f8vp3IjWiFMmEtckPfYuZM85AFs3Y9t62VfAuNAqcuv8qMLsvJ?=
 =?us-ascii?Q?EeIEiuyie7mYyK8ueLdkfeumWLrs8OpPwmGzp6D47jBenB75rMgeNLv4NtH0?=
 =?us-ascii?Q?/8s1ugiwUCXElVuldQr25mvZe4oejzZBmancM2YZWzbcs+pr1ofilMeog9HL?=
 =?us-ascii?Q?yYT3QePr4OU8bB8F/r47kOM9DQ3WMwFdgy+n2kT2RJJo1ixpONVceiQfa+Sg?=
 =?us-ascii?Q?BCj0Po9nuUGNclV0VOWRk0JiX9cyvQbtxAWhG+YbzZAPhjizxPYIQ+k1ffvz?=
 =?us-ascii?Q?34bfHqssHRhHS/+YzSTgua5mrQiG3xMjrpy/wX10?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ebe0e8-106d-4d3b-626d-08dcd0bdad02
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:53:45.1701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybxzBZ9dvaY5naLz/gZq3WC7LuxYvGJDHZoMVqWw74zxJr7V1bk5xaCghyLpEE2D8LTIpVOweVSYkg76KW8QIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP192MB2086

From: Kenton Groombridge <concord@gentoo.org>

commit 2663d0462eb32ae7c9b035300ab6b1523886c718 upstream.

req->n_channels must be set before req->channels[] can be used.

This patch fixes one of the issues encountered in [1].

[   83.964255] UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:364:4
[   83.964258] index 0 is out of range for type 'struct ieee80211_channel *[]'
[...]
[   83.964264] Call Trace:
[   83.964267]  <TASK>
[   83.964269]  dump_stack_lvl+0x3f/0xc0
[   83.964274]  __ubsan_handle_out_of_bounds+0xec/0x110
[   83.964278]  ieee80211_prep_hw_scan+0x2db/0x4b0
[   83.964281]  __ieee80211_start_scan+0x601/0x990
[   83.964291]  nl80211_trigger_scan+0x874/0x980
[   83.964295]  genl_family_rcv_msg_doit+0xe8/0x160
[   83.964298]  genl_rcv_msg+0x240/0x270
[...]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218810

Co-authored-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Kenton Groombridge <concord@gentoo.org>
Link: https://msgid.link/20240605152218.236061-1-concord@gentoo.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 net/mac80211/scan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 62c22ff329ad..d81b49fb6458 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -357,7 +357,8 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 	struct cfg80211_scan_request *req;
 	struct cfg80211_chan_def chandef;
 	u8 bands_used = 0;
-	int i, ielen, n_chans;
+	int i, ielen;
+	u32 *n_chans;
 	u32 flags = 0;
 
 	req = rcu_dereference_protected(local->scan_req,
@@ -367,34 +368,34 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	if (ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS)) {
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		for (i = 0; i < req->n_channels; i++) {
 			local->hw_scan_req->req.channels[i] = req->channels[i];
 			bands_used |= BIT(req->channels[i]->band);
 		}
-
-		n_chans = req->n_channels;
 	} else {
 		do {
 			if (local->hw_scan_band == NUM_NL80211_BANDS)
 				return false;
 
-			n_chans = 0;
+			n_chans = &local->hw_scan_req->req.n_channels;
+			*n_chans = 0;
 
 			for (i = 0; i < req->n_channels; i++) {
 				if (req->channels[i]->band !=
 				    local->hw_scan_band)
 					continue;
-				local->hw_scan_req->req.channels[n_chans] =
+				local->hw_scan_req->req.channels[(*n_chans)++] =
 							req->channels[i];
-				n_chans++;
+
 				bands_used |= BIT(req->channels[i]->band);
 			}
 
 			local->hw_scan_band++;
-		} while (!n_chans);
+		} while (!*n_chans);
 	}
 
-	local->hw_scan_req->req.n_channels = n_chans;
 	ieee80211_prepare_scan_chandef(&chandef, req->scan_width);
 
 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
-- 
2.43.0


