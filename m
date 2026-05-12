Return-Path: <stable+bounces-245818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME3oErBLA2pq3AEAu9opvQ
	(envelope-from <stable+bounces-245818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:48:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A69D5523F9D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16E2D31ABDE4
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830FE36A378;
	Tue, 12 May 2026 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QRQRbBu4"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022137.outbound.protection.outlook.com [52.101.101.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8536A371
	for <stable@vger.kernel.org>; Tue, 12 May 2026 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598060; cv=fail; b=U4e8ZWWfPnV0nv7grcxRycyfLuq8UMTjqWQNuK6cc1XrQD3nOPJGz4c2fVkVrFcnrq9wv2hPAtGbRky9hZAYNpxOq/DdUtwOkHqPuJC5MUx3mcHIsv1GRow79D8zOf2ZMheTcM2dDCkxFrldrIIsRNC/ESrQze+GzOwmcQ/PN2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598060; c=relaxed/simple;
	bh=gpBPQcEPkjxA4MueGPKLLiN+uGk6cgG/CP9X7jY8HJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IYcVJYSqyzOXXDCILkzHpHiUxWYgb7qF46/reVEf4f44492WxdvJaVGFA09qmfBOjBfLbPfFbR5kIX7Aij1FZCeKrhK4fVyPIOvJPEdl1ASoHzgPJ6xEWCZCoUX3Ry8ckaHWfzDBe82q0DA9VTlYS5lwYfk01k7xI5Yzm6FMfXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QRQRbBu4; arc=fail smtp.client-ip=52.101.101.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7fmtPtsxecqGMoG1doJ9j4ov/mOWkcUOBMuYp/2d8drh3MPPwQan2mBweLiyD1i/bCnXFc28Z4CFA05/uu/JILlGbuJRe+zyzpJkSY6YopeTHQyTaikaavJlib0JcGbTBOiWCQs1KsQ89qJwe8tEi64d6qpPxSts4bZbme/kGXhEC4+kbQ2j1c0SKHkwfKT9HTDDI5VaqkZEcabfGR72Gh3llxpnxAaPWbN8otOmEutAe5JFou446Z3hgSgE9ihtmFbF1UdmDwGHP801kCw6PMl6fJ6AlvbxPPLfvrBecsF3IzsohHllfM+LPGLvTE1oEHwDAWu2ek2XqHrg1M7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CZQKNKOYAdZrXKJMg/lH+xaX7mvE9QDDc3IUAO9fQQ=;
 b=LU0fSrwcfPw11JhoYUMCOlyOl7B/wNEUjIa1N3yaemgz4OUf93rWAajc2LOFWS0vsNS2Lm/bU8wczfRGHIC3vXrAOfLTHVggJlrqSiZS8uFfxipMgz2qAg2HfUTPM/ACU5NRjIZDmnQ97RNrTSQN2HtdtDqy0tjFAdVsbVoAnl76CcNf9bCIsIS3J2Sxs2p3lMKDBIyDyt5gAq1aUlSGsbGHEunNRXa8atfh89CgPo/DBakKrWcXU2LbfND4atYI+I5oRilKw2IOIJoysUpDv7GXSFXya/Pi3DZDFqw9cS7fExZpls4MlPDYtSlRALSApbkH9PSwtwlORcPcMC1LZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CZQKNKOYAdZrXKJMg/lH+xaX7mvE9QDDc3IUAO9fQQ=;
 b=QRQRbBu45JX2fceAfkY886cyMuvVbaJD9YZ63dgcFNXloONNo5JJB9AsOCQotKHNzjk18KRMMwxAGv6Mc32Z7ZZVud7kGhJAFpJRXrM4TtOVaGIECxrCAr2u5D0JpG2oBEVcGCShxvThHIshusilaR9awUkO9ZOPuGG2EvrOagw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB1952.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 15:00:54 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 15:00:54 +0000
From: Gary Guo <gary@garyguo.net>
To: gregkh@linuxfoundation.org,
	ojeda@kernel.org
Cc: stable@vger.kernel.org,
	Gary Guo <gary@garyguo.net>
Subject: [PATCH 6.12.y] rust: pin-init: fix incorrect accessor reference lifetime
Date: Tue, 12 May 2026 16:00:28 +0100
Message-ID: <20260512150028.3231198-1-gary@garyguo.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <2026051229-bleak-spotty-4f1f@gregkh>
References: <2026051229-bleak-spotty-4f1f@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0228.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB1952:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f2498d-6c78-48c3-8ea1-08deb0374414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	W6PVu4D0GaXXiNAQS00ZhFkyc4SoEe8JGJEFaI5wZeYnoLGlzm9T2+SOtgdAGTUmyZqjZzu/vpkIQ6YetEmqg0BfXmVpmM3KrN1JKfIcvR570iCqZMA5G53cHFSDcKM/dGJqhJPcwAeBa0cFdS9fMB6JF/50s7WzQwvYtUuuLZIl3rQ+syYBF1k9IyJF806mRFe58mfDePO4ptKtJ4G7glaAJFan6X+OIaDn7ryrQIi8tSQLW+8Crj3QHqQbxuPJfXZOphbN2hIhwXoIOlEjbwDOt+GTlPGCyHgd73VQ257d9w4jBM339lQKsiv14mRWXF96KRma7pAqdCcvyGCRbQ0tA47JKhLLXy+ssyD61db9dU1dqe0w9H+Pg/g7c8og7NwhaDS9rB0m/RfIS2JxPPtRWBYcy9IgLC3mMVsNfZoBjgxwAzFH4JKXjA7Il4AdngbcGYY0viQbXqA1455xztcY870EMBTAjMysQlug+5g2hvs04v0kdslVIA5/6Phjxbgt2RfVPQfF3Xit+dFajmNqpxR3EWE9e2PDP0gJeQPpXP/deo4uvfv3G9TRqDKKXw2Ba5lJZzjX0eHu9n6oJGPrXbxCkpo/4jOLDcupO98F456irxokM/HjDHfyhM4RqVW4D+agMPyJsZ0Fi/HPtLQ/POaz8atmH40DQnBdof/0KYeii9VbX2vsn77ID05b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BcpZAuaTmXIsuLMhNtRaJmEbg12fE3lfCDnj2NaBJc4wJz2Q1KJCIsvb7IlJ?=
 =?us-ascii?Q?+w2f7CyyLMh/mdyaJF32/9CvPqI8V0NDjhW9Rg3A+8mzM39xqvDd9Dp0ZrWN?=
 =?us-ascii?Q?7wagP1Tk1tRZBklABPUP/dero6tJqxJyr3Cijfonqmn2n99NINhEtF8LcLBi?=
 =?us-ascii?Q?/H8gHBlLwC4TMt86EXZ9kcwoByxZLZRfRqQqPO9Sxg5eBGj6NvauJXME1sy0?=
 =?us-ascii?Q?Gekf3ov5RiXgU5bjxReuh8jehVWAuoQHilGUOWIfUYoIZo7kL1xtAhpqKjI7?=
 =?us-ascii?Q?WQADleONDgEv302cqUt0Sbzh+flS6eLh7ZK/iWirXixjcL/jQn5PmClRdG0K?=
 =?us-ascii?Q?xP4pco3PtzITyYCMHkQuT4WrmUWNS82lsFETME1L9bjtORKHyOtY+Aq5N+2V?=
 =?us-ascii?Q?OrwSXG6eXppHM5dqk5yNMa8QnZGoFJwLAD/zI/H3POfqfHBNG4cRuisY7+xg?=
 =?us-ascii?Q?vzjhZG9apBotq4or0xTexs7vkRzTG6VHvPofS6jy4++Z1laRszsYnh6I6qdP?=
 =?us-ascii?Q?slzOYVg6sZ9Ql4kE3+/NrMCOcGtmm934JCiJNjzmaaGr9582c8FCBFXGyhik?=
 =?us-ascii?Q?5ujO+nwK6mfbPBq4no7wbDbTluDP5bWNyeAXwty44DDKAWr7orPjNwBl3JPc?=
 =?us-ascii?Q?MKX1H7OZGxBHO8XBQB+k764/Ea5jT13Sn5mq0RyZ4HS5RdjLC95mMLk3dGz2?=
 =?us-ascii?Q?ILVZb80ic6fr9tNErYcG2z20vGPcg+Tr3+T0lSy/jMhP09590qIek8bYpO8b?=
 =?us-ascii?Q?HmBN7LAmswWdAJfQNe+aRbLw9OAPGrsgw1mI0CR7Lru0EbumOD3TtYEgwdiY?=
 =?us-ascii?Q?BZp/rvul8OUKKEf6GS3zdbMi/FEvm2nnG0zXxDq0RsG+yEyjjItRRcD+YTF+?=
 =?us-ascii?Q?RAoSwgC3sedEyqXNZ1iB0eltWte1zmn2aa4XIYjnrp+kQobCq6jhs5XVCBdP?=
 =?us-ascii?Q?IueroR4Rx7l2yJYXIT/nGk7XgKZ02XahdBgYAg9JC0fs2hvp7YPY+pexPVKE?=
 =?us-ascii?Q?RCYU53R7ZyTN9Q+Yzj3FJRcYzxy4az3aBDJUJ3VSb4ux0RMqtSEsTIburcQb?=
 =?us-ascii?Q?IbMonlHlfGsuSVToafPFfhAM3hHN4BO3rHYni2C7MukmetJ5owXwaH3BA7dm?=
 =?us-ascii?Q?MwzdXclp8tQnqynIB0L9zMkJmtIaXlGRQD6TXFsOz2lu2V7DbfAxjIg012NW?=
 =?us-ascii?Q?F7oNQjvhIZR1KPWMsNgH/yrXiStBWrsTT4xbxleIuYDVvA/WzZHcxP0noATg?=
 =?us-ascii?Q?CwXZ5Ht6Wx480N7n6L33Mycn0l9FDqJtDFUfNlxgcnpRKdTFvhUjDlNflw8T?=
 =?us-ascii?Q?dvSencPKEUeWbj5PrbDUhNJFiFhpe8SgQAd7ENLuhfI6tNmo3tDGAe7TVMTF?=
 =?us-ascii?Q?jYxvZPB8JN/txt5O1azCBO85RPnltEopKKEFLo/eL5v/rz668PF6PycjhKi5?=
 =?us-ascii?Q?1LyROupX8gP6CTlkS2rr9wBkzuKDjR4xsWuitqO48CdscDwLHUGM99HuUZdq?=
 =?us-ascii?Q?FFCTDIqaCSfTcrRBMY6hydbY4HGJ3zPacbOTQQXbHxRv5+gFUurfynBJUX25?=
 =?us-ascii?Q?SkuQaZ/IHiVOSM/kWQ2Ykt4Gtoko8xVlJRTxG4ouDBDaZaBqqX/ZOi0sBthr?=
 =?us-ascii?Q?SGjZrP1eoaPFo3yhPAVyJe2jeluT6V3gPM68kozIGxe/iFfl7ZKfm87MGqbN?=
 =?us-ascii?Q?0b7eO3w9fRhglHLQoBJPY2VBIxp1ucSvg/yUowH1EZdP/sKykABlo9x2ynD0?=
 =?us-ascii?Q?A92ynrW3cg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f2498d-6c78-48c3-8ea1-08deb0374414
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:00:54.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CgVqMcB5h4/2nE8Y5V77pe8fRAKfKPBlMUIx/gpmag3QM+sxdguxuFb1s+WkzxDuDgHqREf/TLV8N5+97fY0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1952
X-Rspamd-Queue-Id: A69D5523F9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	TAGGED_FROM(0.00)[bounces-245818-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Action: no action

commit 68bf102226cf2199dc609b67c1e847cad4de4b57 upstream

When a field has been initialized, `init!`/`pin_init!` create a reference
or pinned reference to the field so it can be accessed later during the
initialization of other fields. However, the reference it created is
incorrectly `&'static` rather than just the scope of the initializer.

This means that you can do

    init!(Foo {
        a: 1,
        _: {
            let b: &'static u32 = a;
        }
    })

which is unsound.

This is caused by `&mut (*$slot).$ident`, which actually allows arbitrary
lifetime, so this is effectively `'static`.

Fix it by adding `let_binding` method on `DropGuard` to shorten lifetime.
This results in exactly what we want for these accessors. The safety and
invariant comments of `DropGuard` have been reworked; instead of reasoning
about what caller can do with the guard, express it in a way that the
ownership is transferred to the guard and `forget` takes it back, so the
unsafe operations within the `DropGuard` can be more easily justified.

Assisted-by: Claude:claude-3-opus
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/init/__internal.rs | 28 +++++++----
 rust/kernel/init/macros.rs     | 91 ++++++++++++++++++++--------------
 2 files changed, 73 insertions(+), 46 deletions(-)

diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
index 74329cc3262c..93809ebaf252 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -189,32 +189,42 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit<T, E>) -> Result<Pin<&mu
 /// When a value of this type is dropped, it drops a `T`.
 ///
 /// Can be forgotten to prevent the drop.
+///
+/// # Invariants
+///
+/// - `ptr` is valid and properly aligned.
+/// - `*ptr` is initialized and owned by this guard.
 pub struct DropGuard<T: ?Sized> {
     ptr: *mut T,
 }
 
 impl<T: ?Sized> DropGuard<T> {
-    /// Creates a new [`DropGuard<T>`]. It will [`ptr::drop_in_place`] `ptr` when it gets dropped.
+    /// Creates a drop guard and transfer the ownership of the pointer content.
     ///
-    /// # Safety
+    /// The ownership is only relinquished if the guard is forgotten via [`core::mem::forget`].
     ///
-    /// `ptr` must be a valid pointer.
+    /// # Safety
     ///
-    /// It is the callers responsibility that `self` will only get dropped if the pointee of `ptr`:
-    /// - has not been dropped,
-    /// - is not accessible by any other means,
-    /// - will not be dropped by any other means.
+    /// - `ptr` is valid and properly aligned.
+    /// - `*ptr` is initialized, and the ownership is transferred to this guard.
     #[inline]
     pub unsafe fn new(ptr: *mut T) -> Self {
+        // INVARIANT: By safety requirement.
         Self { ptr }
     }
+
+    /// Create a let binding for accessor use.
+    #[inline]
+    pub fn let_binding(&mut self) -> &mut T {
+        // SAFETY: Per type invariant.
+        unsafe { &mut *self.ptr }
+    }
 }
 
 impl<T: ?Sized> Drop for DropGuard<T> {
     #[inline]
     fn drop(&mut self) {
-        // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
-        // ensuring that this operation is safe.
+        // SAFETY: `self.ptr` is valid, properly aligned and `*self.ptr` is owned by this guard.
         unsafe { ptr::drop_in_place(self.ptr) }
     }
 }
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index d6e27c522115..661258ba532e 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1232,27 +1232,33 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
         unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), init)? };
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // NOTE: this ensures that the initialized field is properly aligned.
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
-        #[allow(unused_variables, unused_assignments)]
-        // SAFETY:
-        // - the project function does the correct field projection,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
+        // SAFETY: the field has been initialized.
+        let _ = unsafe { &mut (*$slot).$field };
 
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
         // We use `paste!` to create new hygiene for `$field`.
         ::kernel::macros::paste! {
-            // SAFETY: We forget the guard later when initialization has succeeded.
-            let [< __ $field _guard >] = unsafe {
+            // SAFETY:
+            // - `addr_of_mut!((*$slot).$field)` is valid.
+            // - `(*$slot).$field` has been initialized above.
+            // - We only need the ownership to the pointee back when initialization has
+            //   succeeded, where we `forget` the guard.
+            let mut [< __ $field _guard >] = unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
+            // NOTE: The reference is derived from the guard so that it only lives as long as
+            // the guard does and cannot escape the scope.
+            #[allow(unused_variables)]
+            // SAFETY: the project function does the correct field projection.
+            let $field = unsafe { $data.[< __project_ $field >]([< __ $field _guard >].let_binding()) };
+
             $crate::__init_internal!(init_slot($use_data):
                 @data($data),
                 @slot($slot),
@@ -1275,27 +1281,30 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         unsafe { $crate::init::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
 
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // NOTE: this ensures that the initialized field is properly aligned.
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
-        #[allow(unused_variables, unused_assignments)]
-        // SAFETY:
-        // - the field is not structurally pinned, since the line above must compile,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        let $field = unsafe { &mut (*$slot).$field };
+        // SAFETY: the field has been initialized.
+        let _ = unsafe { &mut (*$slot).$field };
 
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
         // We use `paste!` to create new hygiene for `$field`.
         ::kernel::macros::paste! {
-            // SAFETY: We forget the guard later when initialization has succeeded.
-            let [< __ $field _guard >] = unsafe {
+            // SAFETY:
+            // - `addr_of_mut!((*$slot).$field)` is valid.
+            // - `(*$slot).$field` has been initialized above.
+            // - We only need the ownership to the pointee back when initialization has
+            //   succeeded, where we `forget` the guard.
+            let mut [< __ $field _guard >] = unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
+            #[allow(unused_variables)]
+            let $field = [< __ $field _guard >].let_binding();
+
             $crate::__init_internal!(init_slot():
                 @data($data),
                 @slot($slot),
@@ -1319,28 +1328,30 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
 
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // NOTE: this ensures that the initialized field is properly aligned.
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
-        #[allow(unused_variables, unused_assignments)]
-        // SAFETY:
-        // - the field is not structurally pinned, since no `use_data` was required to create this
-        //   initializer,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        let $field = unsafe { &mut (*$slot).$field };
+        // SAFETY: the field has been initialized.
+        let _ = unsafe { &mut (*$slot).$field };
 
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
         // We use `paste!` to create new hygiene for `$field`.
         ::kernel::macros::paste! {
-            // SAFETY: We forget the guard later when initialization has succeeded.
-            let [< __ $field _guard >] = unsafe {
+            // SAFETY:
+            // - `addr_of_mut!((*$slot).$field)` is valid.
+            // - `(*$slot).$field` has been initialized above.
+            // - We only need the ownership to the pointee back when initialization has
+            //   succeeded, where we `forget` the guard.
+            let mut [< __ $field _guard >] = unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
+            #[allow(unused_variables)]
+            let $field = [< __ $field _guard >].let_binding();
+
             $crate::__init_internal!(init_slot():
                 @data($data),
                 @slot($slot),
@@ -1363,27 +1374,33 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
             // SAFETY: The memory at `slot` is uninitialized.
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // NOTE: this ensures that the initialized field is properly aligned.
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
-        #[allow(unused_variables, unused_assignments)]
-        // SAFETY:
-        // - the project function does the correct field projection,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
+        // SAFETY: the field has been initialized.
+        let _ = unsafe { &mut (*$slot).$field };
 
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
         // We use `paste!` to create new hygiene for `$field`.
         $crate::macros::paste! {
-            // SAFETY: We forget the guard later when initialization has succeeded.
-            let [< __ $field _guard >] = unsafe {
+            // SAFETY:
+            // - `addr_of_mut!((*$slot).$field)` is valid.
+            // - `(*$slot).$field` has been initialized above.
+            // - We only need the ownership to the pointee back when initialization has
+            //   succeeded, where we `forget` the guard.
+            let mut [< __ $field _guard >] = unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
+            // NOTE: The reference is derived from the guard so that it only lives as long as
+            // the guard does and cannot escape the scope.
+            #[allow(unused_variables)]
+            // SAFETY: the project function does the correct field projection.
+            let $field = unsafe { $data.[< __project_ $field >]([< __ $field _guard >].let_binding()) };
+
             $crate::__init_internal!(init_slot($use_data):
                 @data($data),
                 @slot($slot),

base-commit: 8bf2f55ef536982e44802d99340119dac6f50636
-- 
2.51.2


