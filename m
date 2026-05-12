Return-Path: <stable+bounces-245819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCy9C1BCA2pV2QEAu9opvQ
	(envelope-from <stable+bounces-245819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:08:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F66A5234E7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 252883087A0D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C36F38D3FD;
	Tue, 12 May 2026 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="pAr6VnFI"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAA7348883
	for <stable@vger.kernel.org>; Tue, 12 May 2026 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598203; cv=fail; b=QkTqNykC4bFMvjTp7Z5uUQAEVC2rmJBxd6RhhFDK6TJTewfkRdLpm6XSZ/07L+IPReig0/j8k0dk9SjcA78LwQid9eduJ+zdY2r9sL7wbr8mqXC9ZyHpkxvovKzOiQ76oV/1qDmiDftF20Eux4moLTkp6k9uWP88/+PctejlK4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598203; c=relaxed/simple;
	bh=SkIntcRrCohlSN8bXAYx/oPV5IiC+rvPsQ0nLFzgXMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acRSFtVDN2fwW7AE8pyQuVe/uEynK4/AumS7UtMiP+bQ2wCA9aWS/PhI7Dg7+NZVvOLkOX52yp4Hc/MF6RGsH0mr23vBFcz4TtnCmjzQoiVehvEaRJct4z0rAihcfmkkSiZkmk1Fj5muhTn5HAMdmTfRrgGOpiHgnKM2M6o4FNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=pAr6VnFI; arc=fail smtp.client-ip=52.101.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXvDjnqmmpJEs1XFA7RjwmLT9goNkPp3f3ONet2lIJJFmWclFNbq3UQUG31W5cw6NIzqiOIkRJI8afEvy1B7X9vnGOz1SdVon18KoKRD+LW9FH4jkUIAc3mMn4sQHQZQo02UqDFwHs+GhycuN5awlRXIHG5zJbHjWszEzh0RvySfpD0vaLmT4ru8exFE/o+smLHcqNr7195BezbNYETiwHz8iDmxRNnfyy0m0rrmDP2R27hamUW5qn34PqmNAu1j5Q4KgJS9CFAFb/9sJk9Q2FouFIhlJGzOyfVdPlOfs1FnyO2Zj3xmIoRgNfHwrQJSHQCzH9GyG/Jsz3CbU33mfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvrvXRiCDLpvSlWAo2qtuL6vgw7p8BT6/x13Hn5GgZU=;
 b=wFuKnbyKAQqihaJ+V2X8JJe3uRDV9u3Ya0v7lKO3uJmcBd7nb1/NBi7hx5wZ7Keu9YuePQH58RtjNptT9Y2V/7nWO+hI9Qrzg5CzpY7m98xKae5BRlqkvAi/x4OwS29BzWxWYhW7aEIgG9Ie2IdhihIZeY6YC2hjITot300mcRCYf6ON19pa7XDeWA7+eHxnywIv006NEkpE5vieinn9qlZH+u6i60DWSTLOfMk26OebcWNAvuyf8wkshNYsS9RE+qFdHd9dDdfLSS6QkAvqwhPQoPsowvPKnR4y5gdRv3ZNuPoAcrxSzD/TwxUDY7/oum6zmCqtwzrS1JP2TO08Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvrvXRiCDLpvSlWAo2qtuL6vgw7p8BT6/x13Hn5GgZU=;
 b=pAr6VnFIyEeVnmQ9cwtx/XghMRg9WaLRM5RgXSz1mGRBTKfkQhvHmVoVay/5xy0EmuakqubP7WNwkM6955lrwoffy6BdOCNftxWcc1THv9QLOG2UB34rRyPYAzYMew+TQvmCgJngQ1X0oJV/VFSZBYmRUFZhIJT1PRap/YfOnow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5891.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 15:03:17 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 15:03:17 +0000
From: Gary Guo <gary@garyguo.net>
To: gregkh@linuxfoundation.org,
	ojeda@kernel.org
Cc: stable@vger.kernel.org,
	Gary Guo <gary@garyguo.net>
Subject: [PATCH 6.18.y] rust: pin-init: fix incorrect accessor reference lifetime
Date: Tue, 12 May 2026 16:02:57 +0100
Message-ID: <20260512150257.3240635-1-gary@garyguo.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <2026051228-lurch-yogurt-28a2@gregkh>
References: <2026051228-lurch-yogurt-28a2@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0198.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: fdad7760-d85c-4cda-38f6-08deb037994a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nJ5BxQyurqmW5sPmm2Enryg6NiVM0YhYLKWi4oCq0e1f523V+le3s65jI7S5t+nExVm9nIl3p5N9ERIe6gW8hfXnIR7TRQGeWG2kG3JmP/sHtiBYDG1aA4cAFj8gfchhP3kwdSLf6+uadH1083/LT2VKhEzREaI5XvsDN7hhOSI5ihuWDdT8osTylJ7FUjUcpgxWfuIH1hcVkIQqAtVTATXYQwtS/m2HUWmoYD8adwsJIMLYfp65ff5ihL3xZU0AUdjhjojar5ZU4AQe3FExSWVNfon7pMzztzKmTvqh62Sy5gjuDE+vcp76MmXRGXccBvhONC3gsEHocNcBjsrMW3F9x8YN7G5ovYYrj+6fsv0XJZFIm3/vXL4Fa72gEVI1cvstBJF0w+BtOgddE2qGrSJ9sn+40W6iz3WR1K5F6LhrZeTjfjYgercd/hbbZu7tXYCm9Afpvfym/6N+WldVWI8WGXbZRNDaDM5pXiuZwVBd60tITS+17KXdlUvTPxy2OD2ZUXOzn82RU6i9lRwsRY6VPYuHERmB++PNYWua8oeCcdu5Hm2m7B00UbbqFCSxAZhN7UVtMQAB0tT1MMfILwezRqS/Yg1SfnwweTU/PG8pIfUoHvkoDASQJKb5gYBwjEZ89c6sPg7bsIUKQB+n29vshoalc1zTA/dbQTHTbQ6kbcUsZPH48ey5C4/6mxK4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fz5Hsao83HO6oMK6GQPXM5jhvEC99vVKqu1D4V08f5DEkJYtcJiONgKj3muF?=
 =?us-ascii?Q?+7+q2LSfaDY9lrbsp+cPfRaZ7Tpjwxu+qcieZWuM093kuF8KnnuyyKFQELRW?=
 =?us-ascii?Q?HBe9xY39C8fDXGs2Kxp6qsMT2AA0W2jIUCD+rmP2qXoSFpyrzgmraMEDc8Mm?=
 =?us-ascii?Q?5UE5TALVDKrGIcN7FPNGW0t2taUx98Qde2zRsrrTYeiq/P7y8WVS1c+1re3D?=
 =?us-ascii?Q?JSmeBhecaaAgJcC336uQo4JzkHydUEkN4MwNwdq0ALx7eQx5OXEEtgAWogWe?=
 =?us-ascii?Q?0sUAhr1VzXfxmVZUN4bAYuh8BmRr2NdbcwaaE4unmRY9VK2yMZvuXstLN/u8?=
 =?us-ascii?Q?Djjo/B6DApmk/2fK0SfJHes1y+IAsyDBDeKN1V+Dxl4vPU+IVWiCG1K762jG?=
 =?us-ascii?Q?X7fdh6BPu+VtX7+QIloSWFfx/8l2Sm3lvcD1xiZDQiuiGmHJVUohxK427sFg?=
 =?us-ascii?Q?1i3VO2iF+b/R3t9TIcdIM5WJKnBW0kvSPiz5WlyijpkydP8jIteJIqftPwit?=
 =?us-ascii?Q?W5r35TnemSfNLIYNiDf77ek/JSosGRo/6IXUNy9uOO0O8Ir3IEqgJ0FfAUW2?=
 =?us-ascii?Q?BPE72WL0jf0fUT0NNM9epb9hMcTsXKzk2kkMBghAFH5kIzzrhfibx6xPgWJb?=
 =?us-ascii?Q?jCX3GO41gPMKXBDlqP8HuofNJkpHwwbm1Il2rbyezr9I/FmHV4DBM6Qc+zKX?=
 =?us-ascii?Q?evHy6AXvQL/jo3L+llBCI62q+6375UQP2hjljt/thQF7VlbFmitEV+NUqRa0?=
 =?us-ascii?Q?P9yILaFKX879HJAtvi5W0ZDXZSatjPdNLPjxLKh6CkVlkrL+gL5FteNk8G85?=
 =?us-ascii?Q?tttcUAmf6vzb7MTvkzVv/EnWvpiCmNQV706wVt8WJ9xE2yvv49UFiiOvUAe0?=
 =?us-ascii?Q?I38sJjIiJHbOztJ+A6qO+0IRMRPA1wy0L2FTtqh1/yy23n79Iny/Nk+xpNK3?=
 =?us-ascii?Q?lJRfcdMa6GgdSecBO3II4TcLM/dVr2wlD0M41Yc6a/N57es+VPiqYW/H24to?=
 =?us-ascii?Q?F5/5jT2ZwiFJos6MZ0grQBQBeaGCNu8Bbhu7tqiPivUjWJNAGLKCmTHtqCpg?=
 =?us-ascii?Q?fjmU90ioWPkiH5FrSSsoFuIRruvRFt338JRAShfFNZPTdH6FK56l39FEqNmZ?=
 =?us-ascii?Q?5J0cMMsMDYmYx3nh7kfUAoSKEna64tTsqj8jcn7iVH0Ep83hYn6PBNzoycZI?=
 =?us-ascii?Q?sN7YZS7ZpOrS2wnMk6b96HRZoVCyCCbIfZWh3fj5OJmBVxqn+cnW3z81Z+dB?=
 =?us-ascii?Q?hC9x1oeAZ6Y8Vonz//B51vhNAAefkL0FUtq6VqDJg1T64lGEQXhot8h5mBRH?=
 =?us-ascii?Q?GwcSKlSLaRVgjLrPOwoic2q8rM/VZnY2L6ydRezyARMYydHVtZ7Ri0YwhfJu?=
 =?us-ascii?Q?WVSrrfgIeImCzBSQVXnwA4SRvpMbZfnf0el7VnoIcvw/aDB+ZdxIcv1sM/9L?=
 =?us-ascii?Q?jqihcSs4lejHEEQr9SKjft6vmhvLZkkiX1kKKmPb8uN3PAlmZUdMD6Tzdjqk?=
 =?us-ascii?Q?vX4m0MBWj3gemBwbUZ45LJgKVtYTg3D9PXe94ApD2p69TlzkFyOiy0JL9esG?=
 =?us-ascii?Q?ry1Zh253gT3WVoByDod9ic14VSkNXWeh/GIztAtN0wVmmUFDh5zJRlDu+1Xl?=
 =?us-ascii?Q?XRWskR0O6fvb9Y87tHAWrkdnWD7JsUp1qsITPe9bvDY3YUIokDCLL8eAXB68?=
 =?us-ascii?Q?a9EAhGmfwm5EUdDEiTu1bpgX4soK2QHWfofoNJaGi+uN0H2Gpk5HeJQwQje1?=
 =?us-ascii?Q?6enMtkHHvg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fdad7760-d85c-4cda-38f6-08deb037994a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:03:17.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/K29NR5FYXgVTDuvqwC4scU9gO5i+VZ6gNVxyfWkvqrElXKZd0OY2d/vFX9QtBc7hb6Dl24ZSAOwOBHZPguYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5891
X-Rspamd-Queue-Id: 9F66A5234E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	TAGGED_FROM(0.00)[bounces-245819-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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
 rust/pin-init/src/__internal.rs | 28 ++++++----
 rust/pin-init/src/macros.rs     | 91 +++++++++++++++++++--------------
 2 files changed, 73 insertions(+), 46 deletions(-)

diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
index 90f18e9a2912..83cc7ca2ead3 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -218,32 +218,42 @@ struct Foo {
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
diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
index fdf38b4fdbdc..a65ddf6cc873 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -1310,27 +1310,33 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
         unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), init)? };
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // NOTE: this ensures that the initialized field is properly aligned.
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
-        // SAFETY:
-        // - the project function does the correct field projection,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        #[allow(unused_variables)]
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
                 $crate::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
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
@@ -1353,27 +1359,30 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         unsafe { $crate::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
 
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // NOTE: this ensures that the initialized field is properly aligned.
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
-        // SAFETY:
-        // - the field is not structurally pinned, since the line above must compile,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        #[allow(unused_variables)]
-        let $field = unsafe { &mut (*$slot).$field };
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
                 $crate::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
+            #[allow(unused_variables)]
+            let $field = [< __ $field _guard >].let_binding();
+
             $crate::__init_internal!(init_slot():
                 @data($data),
                 @slot($slot),
@@ -1397,28 +1406,30 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
 
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // NOTE: this ensures that the initialized field is properly aligned.
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
-        #[allow(unused_variables)]
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
         $crate::macros::paste! {
-            // SAFETY: We forget the guard later when initialization has succeeded.
-            let [< __ $field _guard >] = unsafe {
+            // SAFETY:
+            // - `addr_of_mut!((*$slot).$field)` is valid.
+            // - `(*$slot).$field` has been initialized above.
+            // - We only need the ownership to the pointee back when initialization has
+            //   succeeded, where we `forget` the guard.
+            let mut [< __ $field _guard >] = unsafe {
                 $crate::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
+            #[allow(unused_variables)]
+            let $field = [< __ $field _guard >].let_binding();
+
             $crate::__init_internal!(init_slot():
                 @data($data),
                 @slot($slot),
@@ -1441,27 +1452,33 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
             // SAFETY: The memory at `slot` is uninitialized.
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // NOTE: this ensures that the initialized field is properly aligned.
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
-        // SAFETY:
-        // - the project function does the correct field projection,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        #[allow(unused_variables)]
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
                 $crate::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
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

base-commit: d31a849ff5011dad5c271b53819a0b279e367d68
-- 
2.51.2


