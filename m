Return-Path: <stable+bounces-245820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAQPJMdJA2pU2wEAu9opvQ
	(envelope-from <stable+bounces-245820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:39:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5052523D83
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1762E30A0448
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBDE37CD31;
	Tue, 12 May 2026 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="kuyiifNP"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022124.outbound.protection.outlook.com [52.101.101.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B1737C925
	for <stable@vger.kernel.org>; Tue, 12 May 2026 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599188; cv=fail; b=nbUvJCWdOlUDD84jlOgHpfwW1c73/5TmomGj4sqlzZvOqY6p0eqS6U9Bx5o7HbfKaythErs+zGpXv04uyaMwOWitf0o4+btNMP3xr4MXVL78wIWwbwujw/iFU4mAZD6KSCBPgC53ycTvXhlx7QstLDYOposoH0a5FUDKOw9uDGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599188; c=relaxed/simple;
	bh=aGxiwzg2eEwikof8K4ar7WR8b/EIkOFl5kk4F33hP68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ii+nshxs8xC+HEWcv7Mo0z8Bb2O9kC6gz7ej8g8rc/GomTji6ICe2G4HUKLVclN71t0jKW8ai+IzbDAh4IetE78Odqwrv2RvVWYdkF7+UV+5EA0gJHGCPHR0Ilm59/WeKorWWecJMw0CvawPXe/Os/k5o0RE9chS6KdVFN9n/HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=kuyiifNP; arc=fail smtp.client-ip=52.101.101.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2NhuYt5F9bi78Y4xMphSlcS0V7ybLUkvhUgVO8nw/zejGH7uitiZEoc703/ZcQs5Nm0BhAvBNtub/s33dTV8FKbOdBwehzEz3f+GLA1GnhaQy8sbEePxrkcRQAqUOOzduARmCtmJbuG8v98fjRKsc7n3+3uB4J1nEHW0vX2qmeN5/X9YONGczdtcuCsQp8ZGWSPD82fdHWnNYXp50DWT0VUf/zHDnWZx1D2v9OPNhj/q3JilM6339kRTIzZ82dMrMgIpF0+5FrpcCpiaXxc+JsEVckhhQdDqWJtpcCnCCrmjApGonBtji4hEZgzftjfV0xmlgWGpLsCfuAvIAUPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gSV6TfBzCPoQjdkzeGCaJFOLSq46xng3fdRq8vgwJY=;
 b=QOtoKLPXngaP4r70pEb3bRByCtE/vWJ1QFZJcKN+j0O35TaY3iJOyBAGu30/irCFcYLpsctdLavGzPiKZImA1jZ5AUyjmhao4jT//Y+0dko7fn5UiEsHfsdFNVVASrQZRA7Kiufo293CACHdDUKkuZ/hrOwMjiaS8gOFJQ+JFph52TNWaUJ6vTnmLp+D3jfwTMNtGXsYEdR/IBpd2gMfXCP/b0kktegMEK+ij4zUESllbgNm8y4y9lQ/d4aHgMyevZeD083IIs0E+wWxkTIBz1VRJm2GQR92CUrjxGMT0HF9PCBHwySKZlxtso/Gt6HaSAM73K6Bv5zMT01TcDnyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gSV6TfBzCPoQjdkzeGCaJFOLSq46xng3fdRq8vgwJY=;
 b=kuyiifNP8Ow840cvhIfR2dJcT4chCfIAoI/o7xoCngWv7zCdYRHLckxwsIFbcInhAZXNMs6JIyynmDlF87VROp6KnJU3afQNnqn0e6eti/WUK3QJlnIh1mSNzZckx+X+zVRHtBck/njyv3TYelyWZdFYpGWwuFP2Dtaho+BGD2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB6412.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 15:19:42 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 15:19:42 +0000
From: Gary Guo <gary@garyguo.net>
To: gregkh@linuxfoundation.org,
	ojeda@kernel.org
Cc: stable@vger.kernel.org,
	Gary Guo <gary@garyguo.net>
Subject: [PATCH 7.0.y] rust: pin-init: fix incorrect accessor reference lifetime
Date: Tue, 12 May 2026 16:17:20 +0100
Message-ID: <20260512151719.3309464-2-gary@garyguo.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <2026051227-nuttiness-dropper-e89d@gregkh>
References: <2026051227-nuttiness-dropper-e89d@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0254.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 885a1562-4869-4222-33c9-08deb039e47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ANNAD2mXEBwzeh0CyvY3iq/5PDSvp3qd5y29haGkvnc9IaEjYlZoTo7IBBZClMj3jAZxT1C+dJKKhqLhXZk5oTk+WGsaF9qKJ4sTWh4p29MwiENStRVFLcfHdBrs65iw8qBcuoZ6Wgoe+UAOtZ+v28pocaa26qp8qfWSSfgszWnq47xB5z+zz/kJicLpqcQ9db0kJUnGaGGjlvaX4opxRB5YgV1cz8HiL6Nb87wTcpt/k8unDWUk6ualO8KEVM0sgB4R3icI7NpRPPUwe9yuU+q+S8MrBTvhVjQZZQKPsMqLI3TTGICEM7u5dXHxQhxJB6iPbfxMcnAwNN6IEyApj7AurORsIxVM5lsmy+G5W+baLdWAqGx2cb8n69luK7BpdiEeXogrpdBFQLWSTKNG1FUq7cGj+BxFkUUZvBn+z+TgajyfXaplYqzNA3GhisPGpRxu17KH7dLq7Qd8l6MUKFqpu9rSlF/OmOXukpTCElmMXKTRh8yjCw7lzSufjjti9Euco+T+bsdNAu3yH7KjaoBX+YrBCykOhZZIcJOpcwM8nzYHNdIxZLON0vQPnqwCMlwboP/0EsM5hrdUMX2+xfcc9yd5ZZ7zL85o+3eeEAGeJJH0jCpWPlLZF0jCk3b3fOrd3L2Qk/pn5b3oqwIAwJM1eRrqxJ7rAWAHtProLuh3BCFZduvjXG8Wkp8yPMTt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MG1ruNzrtTRmhM42jq/rb9LvxrR2gFIGMyHBXkHU49VA5KLb6Uy0dcpSYNaa?=
 =?us-ascii?Q?tFnDGT4Lpxo98XwStGb4V1NMpO3MolcF97Zf/j/YqQDZkv6A/EKnpgScMI53?=
 =?us-ascii?Q?7ISggjzt/ZyO1yrvTU3q99gfWyjI8CBFJmECne+2YUvD8eb/GVX9thNCmVmt?=
 =?us-ascii?Q?HGImsNQOoP1PJ7FtVwy2ydNmKwfzEfN03EBbvxMhCQCiRKUk90WFIsS/XN6G?=
 =?us-ascii?Q?bs/2RIhTxq8v6G2KkUk4K5gGYm9wtKe9GyK9rKGE6tHhtMVOjQvAd18Q0h/a?=
 =?us-ascii?Q?P5kPAnYWmPh+lA5tkoDHkAbKOXTGsi3VtDcN4Xnmp8zyN4X1LVeQpX6pcXpO?=
 =?us-ascii?Q?+C01YLfzIvCaVyu0D0U1ZAil0PI/xokd40qxqxaNQfdrsZAMx/EjTsHzEHpo?=
 =?us-ascii?Q?qEQ9MS0D4UVCMg8z/YWrXLx6xZQue50msi5BVA4zW0HJZjKN+Bqomr8aBJES?=
 =?us-ascii?Q?yB6jD1+I8LugxZoeWYCz7R3W4ZV/GvDI/ILsKrpc0CyQXerXW657rX7KCeoz?=
 =?us-ascii?Q?rJs6Ldba/MtbYT/ke0ZjQhtL8zkMBdyK5zIwq8c7U9GmkTGY837LinISWpp0?=
 =?us-ascii?Q?CG+K8LQaS6I+hm+GY0xaOsRPLEGIpcbKcAToPKM3TR98OQfui3STnFYu2u4E?=
 =?us-ascii?Q?dBxMmgKSCjwSpYe6/FyxtooNV5QFcGKvgwcdNTnpq/KcHrFWmRw1qZKH3BiM?=
 =?us-ascii?Q?1bIQycJ8RiRc+E/O9IEYpTmf3H+PL1HDMpUmFpxtkfDeiL3n/Kxh3eehfjET?=
 =?us-ascii?Q?Y+Ia6dMbRqCjlgjei2cj4D8OsYddpdB+JY2WucJybb7+mWobd4vh2RtSecnP?=
 =?us-ascii?Q?rBNiL0ZZgSwtKYnDFNKK5XfrpaAg+SaXgs3K3Hi4mhMQtt1NIQIvV/cdTcar?=
 =?us-ascii?Q?TInYuTRo2j+QYo35DLawsCW9uxZHg5De+RN4oMtsciCaONKZq+KMjNXMq9Zn?=
 =?us-ascii?Q?KyBPeGEMgWhhZdim+Q/L8zdurEp88cubjTK5WcdT42U0lv/5YWmvOXBCGfEz?=
 =?us-ascii?Q?A848wqERcnnXUjHWGsIHEKy/mK4ZqR87J774xCiRHTt30O8++1uUE3yZZvBc?=
 =?us-ascii?Q?8gQQA4r7cFW2Pj8YJbAZw1YHCak+a+ngWUinLD2FCePNd1105zmxlepqQ0BJ?=
 =?us-ascii?Q?0T8moG+VjzKN/y8GKL8QceqIFDjr6Ma9GngYEl3LzYNnEKjN0/l6l6URURXO?=
 =?us-ascii?Q?kJGJyHAFY3Fk4UgYjLNeT6a0HMq48ZkwnGlDytdidzpZLjkRR02JSDHVc48B?=
 =?us-ascii?Q?MQJnz+u2oTlo3w9QEKnxHoBo+tKC/6/BTZizQx6S7p4ppDh7nR0fzDfQLDXk?=
 =?us-ascii?Q?5+SWStmi9aev9ZbXOKdgQJQwlWUkkJyVBeWc5FQr8luV1kO4DJRftmve6QmX?=
 =?us-ascii?Q?7eTAAttDCtl3VASfevV9hFCNIKnFJAK7JS1/uNSA6z0k79h7WL0LBQR9czog?=
 =?us-ascii?Q?Ya63xh2UQoXZdSQoTlx8SCP/mm4AwexrOLaqJT/XrVFx+t62Nj+2/PbSrhyw?=
 =?us-ascii?Q?gQGKScyfHCNa0G517ltwUqLD3bBxjGwA1Jy9ZradAaOBgg6Mj236/626BZ3P?=
 =?us-ascii?Q?ZpKjsulFWM7NA18Qjw2FVe6iKJDLCQREZ5HDm8k/Czb9jqOM5zfXowc7mxyM?=
 =?us-ascii?Q?KFE+SrVP4pd2B5iKxZVAGWJDD7e3ZLu3fN2NYcbEADjqIqr7JuKA/GhDqiNj?=
 =?us-ascii?Q?QPt0RpZhNc35OjNiLlyftMofdVGYE97SLR3lN/K+Xk8oLf/wrhmx9UweYk/F?=
 =?us-ascii?Q?YV/6oRQ17Q=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 885a1562-4869-4222-33c9-08deb039e47d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:19:42.7205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovXM3GzFFcc7Cr6X5B8PJv2ZW9NX5rGJlPb0q/pMebiwlQREvFan/V8cH92OYiGl1jFALrdBDYAVC/L0bi89dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6412
X-Rspamd-Queue-Id: E5052523D83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	TAGGED_FROM(0.00)[bounces-245820-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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

This is caused by `&mut (*#slot).#ident`, which actually allows arbitrary
lifetime, so this is effectively `'static`. Somewhat ironically, the safety
justification of creating the accessor is.. "SAFETY: TODO".

Fix it by adding `let_binding` method on `DropGuard` to shorten lifetime.
This results exactly what we want for these accessors. The safety and
invariant comments of `DropGuard` have been reworked; instead of reasoning
about what caller can do with the guard, express it in a way that the
ownership is transferred to the guard and `forget` takes it back, so the
unsafe operations within the `DropGuard` can be more easily justified.

Fixes: db96c5103ae6 ("add references to previously initialized fields")
Signed-off-by: Gary Guo <gary@garyguo.net>
---
Depends on 83ac2870310b694775ab7e8f0244fdd94fc21926 which is already queued
for 7.0.

The conflict for 7.0 is just `&raw mut` and `addr_of_mut!()` difference
as we moved to the former syntax last cycle.
---
 rust/pin-init/internal/src/init.rs | 106 +++++++++++++----------------
 rust/pin-init/src/__internal.rs    |  28 +++++---
 2 files changed, 66 insertions(+), 68 deletions(-)

diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/src/init.rs
index 342d39b162b4..bda2ae923c78 100644
--- a/rust/pin-init/internal/src/init.rs
+++ b/rust/pin-init/internal/src/init.rs
@@ -243,18 +243,6 @@ fn init_fields(
                 });
                 // Again span for better diagnostics
                 let write = quote_spanned!(ident.span()=> ::core::ptr::write);
-                let accessor = if pinned {
-                    let project_ident = format_ident!("__project_{ident}");
-                    quote! {
-                        // SAFETY: TODO
-                        unsafe { #data.#project_ident(&mut (*#slot).#ident) }
-                    }
-                } else {
-                    quote! {
-                        // SAFETY: TODO
-                        unsafe { &mut (*#slot).#ident }
-                    }
-                };
                 quote! {
                     #(#attrs)*
                     {
@@ -262,51 +250,31 @@ fn init_fields(
                         // SAFETY: TODO
                         unsafe { #write(::core::ptr::addr_of_mut!((*#slot).#ident), #value_ident) };
                     }
-                    #(#cfgs)*
-                    #[allow(unused_variables)]
-                    let #ident = #accessor;
                 }
             }
             InitializerKind::Init { ident, value, .. } => {
                 // Again span for better diagnostics
                 let init = format_ident!("init", span = value.span());
-                // NOTE: the field accessor ensures that the initialized field is properly aligned.
-                // Unaligned fields will cause the compiler to emit E0793. We do not support
-                // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-                // `ptr::write` below has the same requirement.
-                let (value_init, accessor) = if pinned {
-                    let project_ident = format_ident!("__project_{ident}");
-                    (
-                        quote! {
-                            // SAFETY:
-                            // - `slot` is valid, because we are inside of an initializer closure, we
-                            //   return when an error/panic occurs.
-                            // - We also use `#data` to require the correct trait (`Init` or `PinInit`)
-                            //   for `#ident`.
-                            unsafe { #data.#ident(::core::ptr::addr_of_mut!((*#slot).#ident), #init)? };
-                        },
-                        quote! {
-                            // SAFETY: TODO
-                            unsafe { #data.#project_ident(&mut (*#slot).#ident) }
-                        },
-                    )
+                let value_init = if pinned {
+                    quote! {
+                        // SAFETY:
+                        // - `slot` is valid, because we are inside of an initializer closure, we
+                        //   return when an error/panic occurs.
+                        // - We also use `#data` to require the correct trait (`Init` or `PinInit`)
+                        //   for `#ident`.
+                        unsafe { #data.#ident(::core::ptr::addr_of_mut!((*#slot).#ident), #init)? };
+                    }
                 } else {
-                    (
-                        quote! {
-                            // SAFETY: `slot` is valid, because we are inside of an initializer
-                            // closure, we return when an error/panic occurs.
-                            unsafe {
-                                ::pin_init::Init::__init(
-                                    #init,
-                                    ::core::ptr::addr_of_mut!((*#slot).#ident),
-                                )?
-                            };
-                        },
-                        quote! {
-                            // SAFETY: TODO
-                            unsafe { &mut (*#slot).#ident }
-                        },
-                    )
+                    quote! {
+                        // SAFETY: `slot` is valid, because we are inside of an initializer
+                        // closure, we return when an error/panic occurs.
+                        unsafe {
+                            ::pin_init::Init::__init(
+                                #init,
+                                ::core::ptr::addr_of_mut!((*#slot).#ident),
+                            )?
+                        };
+                    }
                 };
                 quote! {
                     #(#attrs)*
@@ -314,9 +282,6 @@ fn init_fields(
                         let #init = #value;
                         #value_init
                     }
-                    #(#cfgs)*
-                    #[allow(unused_variables)]
-                    let #ident = #accessor;
                 }
             }
             InitializerKind::Code { block: value, .. } => quote! {
@@ -329,18 +294,41 @@ fn init_fields(
         if let Some(ident) = kind.ident() {
             // `mixed_site` ensures that the guard is not accessible to the user-controlled code.
             let guard = format_ident!("__{ident}_guard", span = Span::mixed_site());
+
+            // NOTE: The reference is derived from the guard so that it only lives as long as the
+            // guard does and cannot escape the scope. If it's created via `&mut (*#slot).#ident`
+            // like the unaligned field guard, it will become effectively `'static`.
+            let accessor = if pinned {
+                let project_ident = format_ident!("__project_{ident}");
+                quote! {
+                    // SAFETY: the initialization is pinned.
+                    unsafe { #data.#project_ident(#guard.let_binding()) }
+                }
+            } else {
+                quote! {
+                    #guard.let_binding()
+                }
+            };
+
             res.extend(quote! {
                 #(#cfgs)*
-                // Create the drop guard:
+                // Create the drop guard.
                 //
-                // We rely on macro hygiene to make it impossible for users to access this local
-                // variable.
-                // SAFETY: We forget the guard later when initialization has succeeded.
-                let #guard = unsafe {
+                // SAFETY:
+                // - `&raw mut (*slot).#ident` is valid.
+                // - `make_field_check` checks that `&raw mut (*slot).#ident` is properly aligned.
+                // - `(*slot).#ident` has been initialized above.
+                // - We only need the ownership to the pointee back when initialization has
+                //   succeeded, where we `forget` the guard.
+                let mut #guard = unsafe {
                     ::pin_init::__internal::DropGuard::new(
                         ::core::ptr::addr_of_mut!((*slot).#ident)
                     )
                 };
+
+                #(#cfgs)*
+                #[allow(unused_variables)]
+                let #ident = #accessor;
             });
             guards.push(guard);
             guard_attrs.push(cfgs);
diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
index 90adbdc1893b..5720a621aed7 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -238,32 +238,42 @@ struct Foo {
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
+    /// The ownership is only relinguished if the guard is forgotten via [`core::mem::forget`].
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

base-commit: 5d83f95062a860326fd9c69a9d7a1f01063270c1
prerequisite-patch-id: 46afd6371c36354a490ed82b74e36995c8289eb0
-- 
2.51.2


