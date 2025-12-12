Return-Path: <stable+bounces-200893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F02ABCB87B5
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 10:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 654E430194C5
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045CF3081D3;
	Fri, 12 Dec 2025 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rPpfGxkN"
X-Original-To: stable@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013082.outbound.protection.outlook.com [52.103.74.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08873192D97;
	Fri, 12 Dec 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531885; cv=fail; b=MeJeqG2GqZllbBxRv+iQPbhpIzZ6lGQXq63JYL6+rAQ3u49aNOcdM3xG/uQwkdIVc17VeFXA15u1ng1/q4DS1nOd/P+9P5BDH/4R24i3jzmE8RFhDmQ8qrRTYg0Enp5enlAtbb7PN3Mp1pSox17Si9PNeLS6IXhxHuxdPt7g/FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531885; c=relaxed/simple;
	bh=t9988uJhgEfWtwNP6SJ7fO8eRccOGJl5ElXlUtoSJpU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Dmqs0StDm7ejuHOymZTrf0biKuIOamOciG+skvAmsf9WwS7waGVHtP8F3gUj/BZp19FHCjOAT5J8qvXnWdOaFdS56EUMJqC9O4SOr+OZ9GEXx+Pfup9xTPrepg05wjANwm7U9oQ1Cs2fJNJxUbl0JxpfrGy8kSiwy9NSMI+Zq7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rPpfGxkN; arc=fail smtp.client-ip=52.103.74.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/vqrHl6DmZoGplFgWOGst9ZSxrMY4t/Zf2Y5njrsXBGqvrhbgDRXuonwO4Lc4Kt7/kdISj7xuTY5eu3C5KypC1EJwEiWj/uKgAc/Zc2j4wtOjfqSolrlOZkpnVF+5IMIsc4l1SFPlnmURDwC4vjPPQkSi8BiBWvN2c3FeVGbvogEnk4uVvRiAxg7M3EjTELV64gPwc+MyhHP5f4H9UXs3wjKCWjnKMxgu0pbWtnHmkNcKsR8SZvy3LUaAYnJ2+bs+ZPNU7aAbaMba7qxOPZg7cg2IBkMR7hPNoZuw+sggQ7wWg0SNon882fm+XE1cPyRJLZEEdQuOiJMvPPbBsAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHDpBJ+OqEx9K9BnwqRHQS4Rvm++r8fbzgpbgIWGOiQ=;
 b=i63i941NzBeRr1nWlkI+xwMwbrMy0pdfj3GfbTDehjV6CnaoUixoe14DO+pXSNnDpcqNBDJQ7OvUk3x5tAHJYUEec3G2fSBcsu7WFTbLTFOoPnzzYFOcNScuV+vFa09P/a6hjLA0xvcABQaUzXsSAV/ISyQQi1rXMIYTi0eAjnR9gM5ax1we44oCjDJhpbCR2L0oiiufmYb3D5EjHQCa01Z10TtZcQz2LxutoIxSA5WlzJzUHrO6vY3OhHvWWiuLCAF+7ghZzBhn1vEQN7CltwNmPgZF5Q17EgjXd7eFeHmp8WmqVL8KMPCaFmnG3GeQcZ0Rb+zOWNYVtcV+rn7Ngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHDpBJ+OqEx9K9BnwqRHQS4Rvm++r8fbzgpbgIWGOiQ=;
 b=rPpfGxkNHWcuAbv4dOmsbntbptsfIuX5tv8C23v53/GUQtM25dBALig12Nk9+F2ZmHcZFsDih7EyRCHLrnbynvTTYjf6mLo2BfjY/6Tcxq4T5eVForSOYId/+xhkWXCfvPEEeBlmS/DEhG86UrOks6CHAN3q3jGnlIkaKetAKWDS+AiL3XiCHB2AL3xzzSr11rcXNnt92LEh7oMaDVyqnzbOSQpTrGt7mbAy3NnUeVwML48DPfVsK654rYSdaQBrG5vgM3zucUHhwqx+kr8kuC/fXLsP5qYVEqDXf37FKHQ+SqozDIy3fXHKwv8S2gtdnbrktFAUSiBzWoRi5hbqUA==
Received: from JH0PR01MB5514.apcprd01.prod.exchangelabs.com
 (2603:1096:990:1b::5) by JH0PR01MB5515.apcprd01.prod.exchangelabs.com
 (2603:1096:990:1a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 09:31:17 +0000
Received: from JH0PR01MB5514.apcprd01.prod.exchangelabs.com
 ([fe80::9db9:d597:8118:abf2]) by JH0PR01MB5514.apcprd01.prod.exchangelabs.com
 ([fe80::9db9:d597:8118:abf2%3]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 09:31:16 +0000
From: WeiKang Guo <guoweikang.kernel@outlook.com>
To: ojeda@kernel.org
Cc: boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	akr@kernel.org,
	mattgilbride@google.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	WeiKang Guo <guoweikang.kernel@outlook.com>
Subject: [PATCH] docs: rust: rbtree: fix incorrect description for `peek_next`
Date: Fri, 12 Dec 2025 17:31:10 +0800
Message-ID:
 <JH0PR01MB55140AA42EB3AAF96EF7F3E8ECAEA@JH0PR01MB5514.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::10) To JH0PR01MB5514.apcprd01.prod.exchangelabs.com
 (2603:1096:990:1b::5)
X-Microsoft-Original-Message-ID:
 <20251212093110.234051-1-guoweikang.kernel@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR01MB5514:EE_|JH0PR01MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: 220b68c1-9592-4cca-82a2-08de3961330c
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SGcafJNwAl3518GuQYRHc1XRJYwme4rmjaHOSPR2yAZNjQC5GCanUODkNUxnU4mOtkGpdh532UwQGRq2CNz3Gjo3YyOE4EmPc8KjILhRGXi47RAolhBKsmyXcrIT+vL5Foofm0KJboVu5A6W//fnW5Xttb3pYaNy+Xw6ZUDJ8KRFweJIH3guZts4YHRO/KoBBgD9W5YNqg/2oHcip55ysRIJOeTsLQtXW1JNhllHeW3DcDBXaW9CKgF39RV3rZLhscK+EumC2ofWC9OTsr1N2jSMU7wpHDr5bKm6/2AvFD3fmiZJ+4ZR2Kwnvkyt5GdIgkbJuV5bxeLWRRpEL5vBOwfDhKfbXiMeARumrXH066uombPYHKUPoDK7E4Wn55rgh4XGM3l05fgVVUe7oFLkrgXgBdgX8A7xayDpJuWU/E/vqnQIxUxRCpCnLAsO8pPH4hX3G0ZaDYhSvsjfFgJGwaRF/fFfcAbgteljulh3RdaFs/M/3Cfu4G4g9oLHM6Fam3IxftEH8/3m5j20dwk3SBpLNw4uEVLndFHz7KjhLxcZOoIXA0xP02Zk/74BmsywILoQRXFmPl22CUO1HMKEUwDJLndbxP0ncjfyOKrYpy0Mxu6+WPKL3kUMR/K85EmsLMfQurCLSpufMVCPvdhaZ/0J4VA+SgUCEtTPVwMchmMrEpsptvJ2ivDujsTSzvZH1MwONxYaMJW1dCOQg/ToZNU/bAWUNuxIRcVGXcALJLFA=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|39105399006|23021999003|8060799015|15080799012|9112599006|5062599005|461199028|5072599009|40105399003|440099028|10035399007|3412199025|41105399003|3420499032|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G6IUPVfUyJ+RJOLnE1TNwPRwDouJWyAFGReuZb4rMa6rgw0m8nEt68ikKYEb?=
 =?us-ascii?Q?cTmWV3i9KTCI+NV8G9fS/VTcErROe3nS+qsgELnEBKXi9szPRlhRxAYouCc3?=
 =?us-ascii?Q?gMpTqO5v6rOZy3tb+WfCzOuHtmegyAAfJZ6k7bFtIZRqQU4sfah69lRLZloT?=
 =?us-ascii?Q?RFKcN9cq5jbm0rvlhiSFB2toDm35IGRlREs/d5YRn85G9JNTc4N9zxISVlxz?=
 =?us-ascii?Q?9VAyqdTzfoeCFuI6Es4cItU6GuX3opvZhEcN0Q8xMXmOGXz6iIIrRPiH/wEj?=
 =?us-ascii?Q?A1CZiHqn07NsUdb9seSlJZQdxz2ImC6DoTbY1XyS/FL3XaZ+jprQbXI1WXY+?=
 =?us-ascii?Q?AAtyoMT3S8J46vl/Ra3UycP7wa1XZ1oBbCGfqNy9eOB7cxUuV3SLGu7yxI8F?=
 =?us-ascii?Q?75Ubq4JjRr/bJDoULaEKki0HcAXXTP2xydvqAlcoHS+mtdOeCiP2EZpXC1F+?=
 =?us-ascii?Q?1Y9Z/Xy5R91VL7LO44za70SApNdLRHEMp9Ro4Ix1JlwUxpqdQMa1ngP22g3p?=
 =?us-ascii?Q?AtXpzQfQwzsx3DFffC/riH2ObvwIay443vqgQfnB8hb93Rq2RDUT9GLLErak?=
 =?us-ascii?Q?IfMVuCI7htvIpXEJdFvcFXLHBCkSlCq0bK8WqlkRKdTbiqZHL+B5D5aHD7VM?=
 =?us-ascii?Q?x+P6j9GjHUGYwnVf/+gSsZrmWkhtKc/dTqNcExMc+suNWM7EyNPd5qyeVS71?=
 =?us-ascii?Q?iHwNEyTQ6Hrmg1zug3H3njMyGlakRKYil8qUSXkTECOeTSajqpVDW1TLwZvz?=
 =?us-ascii?Q?NJogc49zEAXI42v03Lt1cPZxjpu90LNCpTfPCalDm3gxO+fDOGYHiN/H+e4C?=
 =?us-ascii?Q?t5Fg+Z9pPOLED4DLMD0QuqGhKVT4/thv2rGANdCeydMPsLxsBF9AA8h/6qSE?=
 =?us-ascii?Q?l8hCFWgOQXVEEl9TkvKUMm/Hfeg4aj+D//izhZL/PuHTHn/FF4p9EDFkNMyY?=
 =?us-ascii?Q?HIVkrXhmXesBcEEzzbg7ssF+r123vR5ipYbCVtAqxvRSvhZ/jtAfgg9GnQ3X?=
 =?us-ascii?Q?mjarOuxMTCRJ68S1m8t115mMWE5Ww1+gMy1sZTVwFxPO2XfEF++rF9NQSkT2?=
 =?us-ascii?Q?1KgXWHiZoQubErk4j85Ry7oVYQ1HNNNiyWd1ZzYr2CWz+NN+qixPh2DDN6Nm?=
 =?us-ascii?Q?BSpMBnxltnrQMx+5RocU5SHKKpDqy/DR1oqxZXJEoXimfhv3MJx6xIf71Bs6?=
 =?us-ascii?Q?zzsncWc5vGvlDns41gBJS8oYuNN45n+YJ1lXdGodmEUG+W3DAEQa77jv8V5j?=
 =?us-ascii?Q?2Dhc+4l/CAxN74plWMgndEDaXfqgUlkNFf2zKA68IVwbfONpJFntbutufA0t?=
 =?us-ascii?Q?5erw6jMaeGlzPmU6s5AcpFyFePxfFZfBGA0TAozCBoC4kMtIUoSPzPgMIWMX?=
 =?us-ascii?Q?iTxcwCY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QH39BKanzfwTieHQ2fYp3aVm8gBtlVPUxyYaPSl0tp9bhLTJZQWkb+9v4SCB?=
 =?us-ascii?Q?cEaVFHzjtbwi6nLsdTqj/Cr76dIpfKjkVAzRNUSDk92IPqaRxE2CufJZ41Ds?=
 =?us-ascii?Q?rJcTahAtdaaydWZ032ITniyaYwDe2mzHDThLioD7t9FUC8jyoPYjX0IrGnnZ?=
 =?us-ascii?Q?7Y0UTq3c18m6nG2ragkmsSvunTbDmiHgac2d6r6l2D6UCoVLF8MTVdgokEV6?=
 =?us-ascii?Q?mDZcYcaH+sCCgu5NbSzrlECy4I80iYvsEAoPt/n2AjpL5IDGLCNuN1B/ZSO8?=
 =?us-ascii?Q?3ERnwlVQMzwzkq3s8+a/6fwntG0HPOOBnfE/0ZvV+z8ZRVijYJTt1aQHyg28?=
 =?us-ascii?Q?1GRjh3qWHPQ7YE/HGxCcYuZlp6MZSkn1vyLdYp+oGhGWPM0ki66RCYWw5+z6?=
 =?us-ascii?Q?sXXw5jZs9DhoVz2aeY9io1SxXF+GynFNPed9l5EpYedlNOLJeBAyvjXiirAx?=
 =?us-ascii?Q?MK8zV3cfS43hl4N8qxpNUUdhPFrIedHQ+HhoZC+TOCHBi0khlHpBsnxKOak3?=
 =?us-ascii?Q?lVaeHLjfKL4Lgkbidsb2uX2uWAW/cdHXFZ7Sxl0J81kVrdWkY0FrbJt78cr7?=
 =?us-ascii?Q?e/jCsowUvF58Rib017VmoG5dZLMM2G2kTBQ9CHXEiSyialXY7PFidTTsG46+?=
 =?us-ascii?Q?YOsSti27gk9/8EC+l/jCPAjwrksdKRMllNhIxMWHkOb/NAYslGHUD3ESw187?=
 =?us-ascii?Q?AYAyXkSo6KEDKScG1z9sYCqGyZKV6ecF0Ce8oNFJsV9lgfbQhLMkd2tGVXDG?=
 =?us-ascii?Q?SVg7xYbF05x4SS2YM/V7KPZ2lcj7VHVIkiZNDBKCeyAKbJ6P9g4uq50pDQqr?=
 =?us-ascii?Q?GnuJrUOEk+sM6l2KYXeEAdGMxFWZSiCc9bEr8wTkk+4QXck9WpSHcdjjBJKj?=
 =?us-ascii?Q?zGSrwAK8uTrpe6UVkMDOmKwU0b+lKW5nLCdX7cn1N+P+qZlvZeJ2II+SG/Mx?=
 =?us-ascii?Q?aDFmaTDuF/6Z/ApKZAx4fnr1SIFPbANyn+RJveTsLsN5pvQlwaSEx+tKcoBg?=
 =?us-ascii?Q?QkrxAwIAZypO7tQ6GpKV09tkhszF5x8naqqlkqtKjwl8exRL1WWEq2LOzShb?=
 =?us-ascii?Q?rOeNV3npxlQiPQlI8yblZ7pGvxv5Oh+LKSvDBP9XqL6ReGGn7wrbDT8hUZ5r?=
 =?us-ascii?Q?tYZQLSAyu7k8DUH3TsDy5WCx2WDdTOqBQ8SVQvvfaYFj7cdQ9mhEufQhionC?=
 =?us-ascii?Q?Tnci+aRT7OOTc7F8rYYlH5/hVSTCAqox5Pc/kyw6YBsfYnJuJGCjKCdDHiBl?=
 =?us-ascii?Q?veMCQ0pID8XIJ+Se11v/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220b68c1-9592-4cca-82a2-08de3961330c
X-MS-Exchange-CrossTenant-AuthSource: JH0PR01MB5514.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 09:31:16.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5515

The documentation for `Cursor::peek_next` incorrectly describes it as
"Access the previous node without moving the cursor" when it actually
accesses the next node. Update the description to correctly state
"Access the next node without moving the cursor" to match the function
name and implementation.

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://github.com/Rust-for-Linux/linux/issues/1205
Fixes: 98c14e40e07a0 ("rust: rbtree: add cursor")
Cc: stable@vger.kernel.org
Signed-off-by: WeiKang Guo <guoweikang.kernel@outlook.com>
---
 rust/kernel/rbtree.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 4729eb56827a..cd187e2ca328 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -985,7 +985,7 @@ pub fn peek_prev(&self) -> Option<(&K, &V)> {
         self.peek(Direction::Prev)
     }
 
-    /// Access the previous node without moving the cursor.
+    /// Access the next node without moving the cursor.
     pub fn peek_next(&self) -> Option<(&K, &V)> {
         self.peek(Direction::Next)
     }
-- 
2.52.0


