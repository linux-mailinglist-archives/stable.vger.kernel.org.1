Return-Path: <stable+bounces-256462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KZnKjT+GGoEpggAu9opvQ
	(envelope-from <stable+bounces-256462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 04:47:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 087725FC792
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 04:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 149C631AEC33
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 02:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA8366816;
	Fri, 29 May 2026 02:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amPlXST+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD835AC18
	for <stable@vger.kernel.org>; Fri, 29 May 2026 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022521; cv=none; b=Nx/HPLOtiKT3vJnkfkg+eKHG/Ya4QiXq1nxHuz4UN5JhfsT1EW65PO+rUwQ9/69D0P87Kz4cFV4AyCvEmlCRjJeTXOBoh7qOO5SGj5WF3eKgM87h4xIRd0top4QjlKSqnV3oYPd/UU931yywf7ml+Hg+DFmEbNbTPIstYhEqRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022521; c=relaxed/simple;
	bh=Ds1p122B60FV2zTmvWNc9nWzQxs8vMilrGSAwxzAFxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUeIWrHQfKwssMjtzf3OjR8J5TBWaro1cUQIatkp35VITni+dUOzhK5AS2yUPMnXNqZebHdjHJ7U6fq+TSvBafMInyXODAtY6r8o4f5mma2mtd7oOPfPN97AWsNxxyNwKHc/sNDR6rnhNX6+pD5KEbMAyXIeCbUZyIWJF17/OyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amPlXST+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bd80b3aa13so89819545ad.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 19:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780022519; x=1780627319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZDub8BcFtFH80ZleNgO+woCxrWrG0i7gSDN+ih8DeY=;
        b=amPlXST+wEFjX8ga5F62ffh03AdDxP5AXZUkZrniJU0c9qqM1WvhRYjr/kU8WLCFu3
         vjKH3ZhDJaOeeLcMksIJzDN75v7CZMAKvbUvHSw5fbq9ZGJ0LoGNME+PUMO6UiqXoC1w
         MG6vZWArSeeTEajwcbbXoGjksTsbyKv9BeMJsmL8cPdd709jfQeytEkBEQlD0nO+6JHu
         LvKC8/DEt6PO5XyfxzNI5382J3vqaearojYWPf5K6tmLTYKWXMSzUncLVej4qMPsDpeq
         2li3jg0iXui2z3Bf5CsiZFpxiCQ4ct8Y95vB7u4XI4BCxosEdc6Gkk1YjAdsafctAx8e
         X7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780022519; x=1780627319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZDub8BcFtFH80ZleNgO+woCxrWrG0i7gSDN+ih8DeY=;
        b=ogiDgiSP+KdaFjfUQMxZQHXjh+v3qpDqHrJUTl7EfVgkWD/edcz0Dex9IEy/IeXqgn
         /wAcSx0TkJAt0IoGArtciOOUdSSa2aDX8B4YlLjLa7K6kHl7p86/I39uzF8vVpge3WEw
         77Xui+ML1wkEH+yBhGGYRC9hdAtQQOlu3Pm4y+OIZTdLBNF81Upj/XN/qNrBAILkYCNG
         Iva/3Ao9zCPFDn2+tIxCzbY7uM2sJtKOj//VRAujlkeYGqxsQWJjXkNLpEC7a0TPHsDr
         irO8ReIHX5nSfYmzua7wnTBaLQ1oG9qvpZ3R6rrtKiZlXp2IuUy6JG5MLez1RTlJNCnT
         8cyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZBTDkvzVJtDSG6Ni3oVKST2Ncdjg6kY7WW+ymTtLFmGl4jsXa+5NgpNGFaIdmU1mE1VB9Ye0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuqrjkO/TeNt4UhIdfd0aB0YMv2ftR6P5JKgzh9myC2QN0A0UQ
	/3hTA7JDeZ7WLNCoIPfXS/gc8OJhjwyNrpLNfoeMsmlleTDZCI7m5Omr
X-Gm-Gg: Acq92OE0k+G9Fqy4el7bsMIxCMq3aJNJf/LCKklYNBKSqLdiA+zc5FTZ7u6aoyKX8yR
	xKgeY0UkL65P0aC/jzeRcruysnM1Mm2dkWdhHwIKZZdZ/RXozYzoyp42eJpQrbzV6eXNG9I/cyz
	lsjq5fs8SHkDq8KGYZcILXUNrEMQ2l0/pGtdE0vxNqde2I3OnKsMrCG5DqUOEWOcqNORJ8ovfEU
	4MmLgc8KfD6iBzvFlDz13ptEwUm7amYI92UP0jIFN748PJtkrsneSA3IG+geV2qa62fsICOH1Nt
	ebJ0M8Z9Vuwy85sdf8Wjd6XpYTLR5OJhr0+7Fe23LhH78rN2IPw8x6zFi/uJBQqf4SYwZLjuj4x
	3ucQsiYhtBkyc2FV1CQstnemKLegAawgMu3GZWwBtImEh7JnDxBkvfnV/ggwU6+2uUkeLlg0XBR
	OOsjOs4ow2ycM7PTzsPKB/imnopudmHl5SnAImHetnnDK0TS7j75G/nw==
X-Received: by 2002:a17:902:f641:b0:2b9:ea53:4cfc with SMTP id d9443c01a7336-2bf20976e99mr12238495ad.19.1780022518682;
        Thu, 28 May 2026 19:41:58 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a0fd4csm1915955ad.30.2026.05.28.19.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 19:41:58 -0700 (PDT)
Date: Fri, 29 May 2026 11:41:53 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	brauner@kernel.org, cmllamas@google.com, aliceryhl@google.com,
	mo@sdhn.cc, wedsonaf@gmail.com, Liam.Howlett@oracle.com
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] rust_binder: use a u64 stride when cleaning up the
 offsets array
Message-ID: <ahj88dV6McFC0oFu@v4bel>
References: <ahjpn-3WQTywTdyj@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahjpn-3WQTywTdyj@v4bel>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256462-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,android.com,kernel.org,google.com,sdhn.cc,gmail.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[thread.rs:url,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 087725FC792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 10:19:27AM +0900, Hyunwoo Kim wrote:
> Allocation's Drop walks the offsets array (binder_size_t = u64 entries),
> cleaning up the objects, but it used usize instead of u64 for both the
> stride and the per-entry read.
> 
> On 64-bit kernels (usize == u64) this is harmless, but on 32-bit kernels
> it walks the 8-byte entries in 4-byte steps, iterating an N-entry array
> 2N times, and reads the always-zero high word as offset 0, cleaning up
> the object at offset 0 N extra times. As a result the referenced node or
> handle ends up with a lower reference count than it actually has (a
> refcount over-decrement), and binder's reference accounting is corrupted;
> for example, the owner can be notified of a strong reference release
> (BR_RELEASE) even though references still remain.
> 
> Change the stride to u64, and read each entry as a u64, narrowing it to
> usize with try_into().
> 
> On 32-bit ARM, when this over-decrement would drive a count below zero,
> the driver's existing refcount guard refuses it and fires:
> 
>   rust_binder: Failure: refcount underflow!
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  drivers/android/binder/allocation.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/android/binder/allocation.rs b/drivers/android/binder/allocation.rs
> index 0cab959e4b7e..f4ffc57a8cb2 100644
> --- a/drivers/android/binder/allocation.rs
> +++ b/drivers/android/binder/allocation.rs
> @@ -251,7 +251,7 @@ fn drop(&mut self) {
>  
>              if let Some(offsets) = info.offsets.clone() {
>                  let view = AllocationView::new(self, offsets.start);
> -                for i in offsets.step_by(size_of::<usize>()) {
> +                for i in offsets.step_by(size_of::<u64>()) {
>                      if view.cleanup_object(i).is_err() {
>                          pr_warn!("Error cleaning up object at offset {}\n", i)
>                      }
> @@ -412,7 +412,7 @@ pub(crate) fn transfer_binder_object(
>      }
>  
>      fn cleanup_object(&self, index_offset: usize) -> Result {
> -        let offset = self.alloc.read(index_offset)?;
> +        let offset: usize = self.alloc.read::<u64>(index_offset)?.try_into().map_err(|_| EINVAL)?;
>          let header = self.read::<BinderObjectHeader>(offset)?;
>          match header.type_ {
>              BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => {
> -- 
> 2.43.0
> 

The BC_FREE_BUFFER handling in thread.rs's write() seems to have 
a similar problem.

Sashiko's review:
https://sashiko.dev/#/patchset/ahjpn-3WQTywTdyj@v4bel?part=1


Best regards,
Hyunwoo Kim

