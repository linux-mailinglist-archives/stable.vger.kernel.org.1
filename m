Return-Path: <stable+bounces-144666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AFFABA905
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 10:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A0C7B40D6
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122131D6DC5;
	Sat, 17 May 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="b3QjpZBh"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021139.outbound.protection.outlook.com [52.101.100.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032944B1E45;
	Sat, 17 May 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747472204; cv=fail; b=Ofnmh26D9NqalMzdho+/ZxefY5UTYIWYM+KE4mbL9/WzBp8owpBYTbcYODdHk7onEc1iR03B0Ejdz7famVSwYFOFifj3x97zPl44Ly7KJFnn+fPIaSQmke3gjskEkMNI3USbKDnjpGmzqkFoDmJwEIW9021NdXF6K7ZlLv8JDw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747472204; c=relaxed/simple;
	bh=9UdXj4ZyZO6SCwmWzwACdjdoiCuFNjzAHlzwmYQ03qs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f+HZObQfKACs5VmyEkuc7DPhfrowETtY55Y1OIneuP1jO4uue01knZ3hIMfyziNBNl20U0d1hH+yC2+85XCws8JrpyKnxbVDU245beXBmaAKxAFrQDIZUiNLn72m+lfQlDVhYzAGVmonJTbPSGNPPesgHfyNTTFV+Gs2rK44CKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=b3QjpZBh; arc=fail smtp.client-ip=52.101.100.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrvpB4AQ6RxqG/Qpt35io/HOvRwpWIFSDtrVrjP1OGTm0golgAdx6O+tvUr9zBo2hZmrkCvnaOAv7cFG1eHqdDmiLBb/bWcbvz5cYM7q1HBgDCRmcZwc11jr/V9x0zAAadpVOFOpqMbNt7bcye1nVXEuBhBcpXz/4qqlLG5HYHMOZFiqqqYbDgljhJ2fBL9pcBUvqPFgm3Q3UBkXg1Nqu7l5fCvwfkjXVplSca/tIbh3LCUH64ygDR0sHkvJJ86/1hjfj4bN2cgw89OspohR0W29Oo0H3zX5ZoSPxK2jmvuDxwetLF1MByKQ31jnOM9W90G00QXNVPLPzjXSTZKOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2C1MQmwvubSUVJQq5WxSwqKPhK89U3EtcZNf4l94KQ=;
 b=K5/RBlQ7bpJF3bOVbpqAZBmhabo+yDrM/0w7XipH9aH6kZHu4JcD7xbOrF/mFpqEJqUYtWFbBvUDJLhgw1oQZeJdOPg5LDXU06XuAjHB6aDHp8tIRt2EI03bkVvD+D+vcnFlVYhjq93leau9aaYTXHATfoLllvl3dm9NoZAk3gkPJzt6w0V2dKO9vIMv21RpzGwzTDtq5ZDbgL+r5f59jwqzeGqn/8radXHlMOGzS1E7vd+kJFIul/OgVWTy6ctma5KdJ87u9nGU4qwIvHGROBYmoCTfrtbhKwSnlgbxEtZh7Vb4qJq5X7ZigNhHxPyZuGK6FPdZNz9xPFvZgwe61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2C1MQmwvubSUVJQq5WxSwqKPhK89U3EtcZNf4l94KQ=;
 b=b3QjpZBh5o0dl4uxuL7shi3te4884bnDAITf9/pO4wRJepvtD9+M47qelkQ5mSNE/wlrjYzZyF9MRPtvCR3o+wNnxbkMQErnbaKVhqPw7pAtKSMum+i68iLkfWKzbJyiL4UE2DlkZNiJ5Xw8rnmeSMF6wxr0cv2SBU4S1B2SzVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CW1P265MB7710.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:203::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sat, 17 May
 2025 08:56:39 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8722.031; Sat, 17 May 2025
 08:56:39 +0000
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: stable@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: compile libcore with edition 2024 for 1.87+
Date: Sat, 17 May 2025 09:55:59 +0100
Message-ID: <20250517085600.2857460-1-gary@garyguo.net>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CW1P265MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 796cc813-78b4-49df-4cf4-08dd9520bc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Omo/+wHy+p7+LbL/7cMnT1q7j2Cm1zUjJs2Swj2vPrd3JNfTRDuxqevvCZz?=
 =?us-ascii?Q?Ilgl/5jrGv7aCNNa/CWEJt4TdVdKiXX+jKSHh9g2+OZq4r5v2l+jQFwcOrX2?=
 =?us-ascii?Q?yKY7elJwG/oMB1h7LgD+WxTlDEDCic0EWa3XubXnFen/otfXo5qfAzqUA5mn?=
 =?us-ascii?Q?8FdLy0HlGICmzJx00+LW26Oab/mMOL1my6ooFx5QaTajmDnnLiX1wkDrmSCb?=
 =?us-ascii?Q?k2Mby5skCNiOLkVVcZq2iqsnbIO5iUhw1g0S8V3IZzyRzbrvHtkpxjta6Eya?=
 =?us-ascii?Q?CPosb/Q1ipZZ81cSBDKxrXVgRlTdqa3AyWbK+yUeuAWli9pV1tnH9YJ8okYT?=
 =?us-ascii?Q?a4SzH2gZuPWEuilzohDObRfm8CGHQ+tqLULR7kk6YSlsm9WwOmV5qBdg8moy?=
 =?us-ascii?Q?Rk01g2m6y2zcxKfRE+O5w4N6avrySD9q2vuTjTmbN4T7Mu+JqMtmhfIRkgNT?=
 =?us-ascii?Q?cDOl/OohN6e/7oDDhGUit4jTGtSlWz2dBXznX3UkEFnaH9sWhm/tvsxdKsOc?=
 =?us-ascii?Q?9gddcPkKn1Un/C0KiITlT7SFuDWjxrxidS4hg5q2Tk/rbKTMUffwo9qxFPc1?=
 =?us-ascii?Q?u1nSCMbDUqSPbb+p+h2v/zfj4Ds7DYOg9y+VqfiDNg6AhqSYhiU8zwh6rpzW?=
 =?us-ascii?Q?QQtd19oj+SH27CWYGLQUXLs5gTvzPUZGkKrDvcZVyBnQy/WD+A2lmcUag9al?=
 =?us-ascii?Q?seP+hMZlwqKoSEG3wohrLzJ9FbVVkxN1A2K+eRCBYWaFdLtf8kKIu+Es7blV?=
 =?us-ascii?Q?r3kl0nCDRKaLERaYd4XIlQ289BhzlCTnxdPloX+MYRKRjlbyBzyEPTL3RLpu?=
 =?us-ascii?Q?c7XVMh8rxoMptQ9iW48hael5hPN84aNFEpxM6Posfu6zqI0+QrxR+PjEmmEu?=
 =?us-ascii?Q?ikFLqDALK4DNv2HfQX0pedq3sfP1MNdOOhSUF+ciAjPnBk7b3XYnlZxkMxLA?=
 =?us-ascii?Q?HsKGdNzxhhUxx6BLn4UI+40XKvf0NKIcjeoFdrnl0wCYqkRVIVK2HVrfMk2Y?=
 =?us-ascii?Q?AEmxp0MshvYfwjbXdH7YVct5nhT3zTAk0E4Nor0ZUEXQEOQB25PBFn9yrIt9?=
 =?us-ascii?Q?xbOxvej/y+tY3cmORXGf36L08dlEo/gdVA8qA8b6VRdK2XLjtfJevF3tOhHP?=
 =?us-ascii?Q?QbdSrPT4bAHp+3Onm2we1aHyv8O/zjWPoSWJsM0Qu3cC7YZ0sOC9QlDuXXoo?=
 =?us-ascii?Q?cOtayKSH3zZaEipCk2POXfJ+EYBxdrufhCi4FB6tswS/nkMptTTUcxo+XTVC?=
 =?us-ascii?Q?yTJubwd8+21/HzQ5MAuOV7QS11YybQG/cj0/VDAzg6qPQ7etbOXlNrfatzNB?=
 =?us-ascii?Q?C12U8bVRpBzTkim93SEib/2dhlvytLe9GT9YowkNVYSTKYiqlqBmJnN8hBOr?=
 =?us-ascii?Q?gOu9Nruja8LU0C/g9CGz85iUwdG7BzM4fiWtIseuXjB7la0wwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zxc7IWK3diD30ix1pW1NpVvoys1Wz3+bOZ6VDOgWeMOEEOBuvidqpr18EwKd?=
 =?us-ascii?Q?MT/NRqXcVwFTAdTpwiqZd0Gt1g2gBsPa41SnqzFN7aOrxUd9xowBxUINZQuJ?=
 =?us-ascii?Q?hv1eBxEbbnHiLrQhb9851oA0Oa493mrb+g+/Es07162eYWHO+Aw4XOvdj1IH?=
 =?us-ascii?Q?m6azaNcej9+tc/X/UsQpTvluZOzB2JKFNAK3oCqMYgr/D1X7Mc9mDOugTjmg?=
 =?us-ascii?Q?rZEj6UuRc3fHu/DK/6fH/eyYKjyRcfhRrxYukZV/xbqvhQM/l0T/LFk0ksMZ?=
 =?us-ascii?Q?/kZ6zxBA6DkiLQVhnvNYC/qyHkqGcUxqU2By/GChBQv76orlICjE2yxbG7qG?=
 =?us-ascii?Q?coiZctreuQ1zuttDNHD3/Wjmpc8OlDB91xZikJ6QWqjliGgsQWFWJRBbjLOe?=
 =?us-ascii?Q?AxBEdElOBb58SpXkBLVj35cRXXXxIoYzx51Hy+48XISom6I84fjjYlHW33bU?=
 =?us-ascii?Q?FZfttbNXqYOhCvV4uYG35GyosJ60T7DltC7cqoSJ/yU7oqKTIWZlMFnIuu7g?=
 =?us-ascii?Q?OjBUQGKrHznCuG1TZOf78C2TQFiraTOL19OZEt2BZ8OP3Pzee5PwXvOmUxSa?=
 =?us-ascii?Q?zhyRWPpOlroqAkd6IaYyM4i8VwjTKAtS2uN8HJFA2lFknQdoY5aMmNsp5rdc?=
 =?us-ascii?Q?CW1qVZECzxhSuUow1jVMarzbxz0+jgIjbVjrisR+BrL7d4Wb5Dr57LXGyuW/?=
 =?us-ascii?Q?jSfz08v+uL82DOkT7RW9WD97YOFCfNp4q0fej7F4F8KFroTS2xjHYRcaYiir?=
 =?us-ascii?Q?/N07btt3jeT4aO1t2nz5vLU6G4IRxHFaQo1kbCcgvy8vB+G09Mzs16+BhtRN?=
 =?us-ascii?Q?xtycQUokdjAYAxAJBzQBO9kLKKXF8IAPZ+9UWM48BtS6RVJUgNj+8+SholHo?=
 =?us-ascii?Q?qBKZsqG71dRf1CJxhXc+TIyd/qXwFWlXN9a1Y67Iwmjjsc9bOGsnI6YaVVFA?=
 =?us-ascii?Q?BQgLcv/Tf5X3mEtqiMXcaPoGz5Z6uqxYgHsy8OOfZecK0oab5GvQeVJ3VjOh?=
 =?us-ascii?Q?YkO8YWEMa+FE35fYhfym1InoBKf8PiQvZtU1NAeISkUjWusUKLWGTm+RvcOq?=
 =?us-ascii?Q?9+6SeXkZ9TKZiW5QFDLeWZ2RmxixfWcCI/3B0A2AxjQl6QgwhTAcQo2WpTrK?=
 =?us-ascii?Q?Gn/azJMEdBHegsBnkA2ZDsPf2njKegboTzmjjUxOCMp7UZazGmTZ2iGVEa9I?=
 =?us-ascii?Q?4gTnTZxKjzcW9+2LRELRxYag6xVajGWJT8GyfomwDI5nTDbO3W26pUPon1FM?=
 =?us-ascii?Q?bIrWX/msp6VjT4GFYw5RnfuhigwrLObLN24o0F7q9CdVPSSVeNiOGkg8gkYY?=
 =?us-ascii?Q?Blf93XiyybhgVxB3ycZHKoGo58MYH3GhMf/9Q/j5iifq7nKuQHJLila7fMd1?=
 =?us-ascii?Q?gwXPYF9w3zoEIfeTSgc0gRAsrhvVb+8qsqUaTI7oUM+3UF/qYDJ2kHxrsNyG?=
 =?us-ascii?Q?eIH5/B4n2zEE+/Q2FNaM6Wj6edKh1wNbVhQnEO1ROAHRKKuJn4qDSUGP70/o?=
 =?us-ascii?Q?KzJ/cQu1Wd/a5b7BH/QD3Maiud27oHCAZIlQJmBAEB/hujGjCuhO1jmfT1DW?=
 =?us-ascii?Q?NTNcW1tlaMeabG3tY42gPcpwjAe7Au/E+BttEQzL8KC/7IUZ1OWLbydjUXSm?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 796cc813-78b4-49df-4cf4-08dd9520bc63
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2025 08:56:39.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoYIvhhj2ti29hOkXxxr5FGOO+0X5B/Y6FN9kfcLQ10JF6/2pd2ObOUnLEcQUmnGLHQD6qk8Lr530+Rxx++y4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7710

Rust 1.87 (released on 2025-05-15) compiles core library with edition
2024 instead of 2021 [1]. Ensure that the edition matches libcore's
expectation to avoid potential breakage.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust/pull/138162 [1]
Closes: https://github.com/Rust-for-Linux/linux/issues/1163
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/Makefile | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 3aca903a7d08..9e7f1ec06181 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -60,6 +60,12 @@ endif
 core-cfgs = \
     --cfg no_fp_fmt_parse
 
+ifeq ($(call rustc-min-version,108700),y)
+core-cfgs += --edition=2024
+else
+core-cfgs += --edition=2021
+endif
+
 # `rustc` recognizes `--remap-path-prefix` since 1.26.0, but `rustdoc` only
 # since Rust 1.81.0. Moreover, `rustdoc` ICEs on out-of-tree builds since Rust
 # 1.82.0 (https://github.com/rust-lang/rust/issues/138520). Thus workaround both
@@ -106,7 +112,7 @@ rustdoc-macros: $(src)/macros/lib.rs FORCE
 
 # Starting with Rust 1.82.0, skipping `-Wrustdoc::unescaped_backticks` should
 # not be needed -- see https://github.com/rust-lang/rust/pull/128307.
-rustdoc-core: private skip_flags = -Wrustdoc::unescaped_backticks
+rustdoc-core: private skip_flags = -Wrustdoc::unescaped_backticks --edition=2021
 rustdoc-core: private rustc_target_flags = $(core-cfgs)
 rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
 	+$(call if_changed,rustdoc)
@@ -416,7 +422,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
       cmd_rustc_library = \
 	OBJTREE=$(abspath $(objtree)) \
 	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
-		$(filter-out $(skip_flags),$(rust_flags) $(rustc_target_flags)) \
+		$(filter-out $(skip_flags),$(rust_flags)) $(rustc_target_flags) \
 		--emit=dep-info=$(depfile) --emit=obj=$@ \
 		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
 		--crate-type rlib -L$(objtree)/$(obj) \
@@ -483,7 +489,7 @@ $(obj)/helpers/helpers.o: $(src)/helpers/helpers.c $(recordmcount_source) FORCE
 $(obj)/exports.o: private skip_gendwarfksyms = 1
 
 $(obj)/core.o: private skip_clippy = 1
-$(obj)/core.o: private skip_flags = -Wunreachable_pub
+$(obj)/core.o: private skip_flags = -Wunreachable_pub --edition=2021
 $(obj)/core.o: private rustc_objcopy = $(foreach sym,$(redirect-intrinsics),--redefine-sym $(sym)=__rust$(sym))
 $(obj)/core.o: private rustc_target_flags = $(core-cfgs)
 $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs \

base-commit: 172a9d94339cea832d89630b89d314e41d622bd8
-- 
2.47.2


