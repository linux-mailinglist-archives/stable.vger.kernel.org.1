Return-Path: <stable+bounces-222675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCUeC6HYpWmuHQAAu9opvQ
	(envelope-from <stable+bounces-222675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:36:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CFB1DE6D2
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D860300E3A3
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D9C342532;
	Mon,  2 Mar 2026 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzCHPyne"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8A337BA6
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476570; cv=none; b=ZxNGh1naX/JqTtIxZqDaIkIKUOh05U6ytzca2YnTx7Cfo+sVtz7nTcqxJfVLVSiyRik5FVxvFdiiSLN4Z4V1mr7N5miUtVBEPIKyKdTb3+QpDM6/0FRtthsDB37bj+KOP0uAqKpcOCvxFoe5xAFndWYmeS0b6d+r1OQQh4hHd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476570; c=relaxed/simple;
	bh=gE+jXU5agoQWTZebEDnDXNxEhHacPNAY9q51lw7KMLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNj9qtSEVHfdYkg/OUEkbXmKwNfcrpLqv84/goF1D2UTvYWC2hL7d/Drsguc2qcOAjwLKLYfe9CIIHZHa5tHgEosGn1hFkJT15taSvlYkrjDfjvyM9LxEZ33L89CO3PZY59GY2mEJCk8WHqULJ9b1zCYFLL+y+xxQnIQ/i8GHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzCHPyne; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae4b40999bso5415ad.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 10:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772476569; x=1773081369; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TNGbC+n/FkqePeOY//UBg6AI1QctrOX8iaSRimJodOQ=;
        b=mzCHPyneiY261XfAVBrXgOzej8xAJlb7jU8TJqzrwazDKr476xUrHUfPrUHFd5W1Yu
         K/nHuaLuK/0XVy+8AfnsEJkbklyOS48YJQnkygmsojCkhwRfDTbaCzHtQggvsFjkxDWG
         W1P6ZwapsdPgFssbMFegNd6ofWHwAs0kDlahVe/EBJ1pvSkuTbmFZgdsmak69sqRVHGb
         nJhxvCPQYcW87DOjpMoT+IOuZvoeS73LYdOWvFML6UtYW56tTWpNe26oF3P3DnVQlaSh
         aDVqc//WnkoaOTFuU0kNA0sMx0gQgXRbyOHpdMhn2DmVgsTas3QYakhoFjGJOAVsOe51
         p+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772476569; x=1773081369;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNGbC+n/FkqePeOY//UBg6AI1QctrOX8iaSRimJodOQ=;
        b=olGs1DHyWxljRM3MrKeVTdGPRgPojfA7udWXKLJaINmdo72jpRe3bSIekBUiDtlF5h
         M75EwnKbpO6wgHGAIC33J5WdphKtQe1GMN6Y45GIoqcmDKamTtNv8B1lx62QY2STrSOm
         /AUOYjxaJ7qEzt5lTGXc7J6uVd1BLdrcTrPrVbSmg0M87tF+2nEe7KV0Ektlbvg0yLo6
         AfD1YkeL7eo12QXQp0IGY/YkPK1lV94jOaELyHVTo4a3spZVo/J3AXwSkGtCANvXKD9V
         ZAG9eGQv1kTr9xKK4MWF02GK7Z6v9g9GRH1CL51UlE39NbL+Qq12ISTax8OvAvHUZ6Co
         ndRg==
X-Forwarded-Encrypted: i=1; AJvYcCXx6aepzglpeXIcmdGS527oRdNdmC7QxBJohdft9O6QJUVSt6ygzDRXznnF+vEuLBFK549ektA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynevtE5aOWSCRs3oIqCQFzI/xCOiJMDeOWXIXM1psC8fUT2ajY
	VW53SiqlryvJ5uPrO/RPaMEPtLBhpW+sWhQ/rFxbCGbPYnBQDSSyfr7dJH1Bjh6hmQ==
X-Gm-Gg: ATEYQzyg0H7CPj7suRGjgMwfcuBTubThd7MZFvLULqUHcARNGA9J6Lg/DK4wIXig4FT
	RJdbT3GLV978sOxOoyCFOAfLryxceqxuPWpB0nbLr0ny1Ymx2VpXZkWcMscKWKnt4VMqDwFbH5H
	N23VYne0qfmHDUEWjMmUrC/gqPiAJ4ntY1/fQfFUt54LSHjIhGxd+fOfbcRBflllUUlE49ReLrT
	+canlN4wmez83/ub/xXBjbPw1EOW7BSrwiBHQsHHclIrpmEbykYDPB6xPK8SJjJjnsUxttZwJhn
	UyWPHO8iJYZIKUDWqzxJNPApJeb4qt/9UQUyf/ykt1twU9HdWe9+3XEorfGbrqlfot5KNH06BR5
	RfFsuRHVG82ypg4eGJfRTUFtUxSgWbAeLQTglUMCYctEeqY/GwOE8L0wjAjVZRzZn+O0yXdkyFX
	3FBtowgNnWLdPJZKu25t8nPkTMxU+RIVXH4Eye1HWc7lky55MKJkH3tZvfgdOVdH3ZFZ6S7tZs
X-Received: by 2002:a17:903:1b6f:b0:2a9:5ef5:399b with SMTP id d9443c01a7336-2ae3b553cd7mr4766455ad.19.1772476568598;
        Mon, 02 Mar 2026 10:36:08 -0800 (PST)
Received: from google.com (154.52.125.34.bc.googleusercontent.com. [34.125.52.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d94de6sm13941615b3a.24.2026.03.02.10.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 10:36:08 -0800 (PST)
Date: Mon, 2 Mar 2026 18:36:03 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Jann Horn <jannh@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust_binder: check ownership before using vma
Message-ID: <aaXYkwQ0Yg5b7sTb@google.com>
References: <20260218-binder-vma-check-v2-0-60f9d695a990@google.com>
 <20260218-binder-vma-check-v2-1-60f9d695a990@google.com>
 <aaXGZlfAmk-DCuBW@google.com>
 <CAG48ez2M4fj15gqyKrP7ADRUhNQZkpy9m+NSz2N=vo=PSefm0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2M4fj15gqyKrP7ADRUhNQZkpy9m+NSz2N=vo=PSefm0w@mail.gmail.com>
X-Rspamd-Queue-Id: 76CFB1DE6D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-222675-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:28:17PM +0100, Jann Horn wrote:
> On Mon, Mar 2, 2026 at 6:18 PM Carlos Llamas <cmllamas@google.com> wrote:
> > On Wed, Feb 18, 2026 at 11:53:26AM +0000, Alice Ryhl wrote:
> > > When installing missing pages (or zapping them), Rust Binder will look
> > > up the vma in the mm by address, and then call vm_insert_page (or
> > > zap_page_range_single). However, if the vma is closed and replaced with
> > > a different vma at the same address, this can lead to Rust Binder
> > > installing pages into the wrong vma.
> > >
> > > By installing the page into a writable vma, it becomes possible to write
> > > to your own binder pages, which are normally read-only. Although you're
> > > not supposed to be able to write to those pages, the intent behind the
> > > design of Rust Binder is that even if you get that ability, it should not
> > > lead to anything bad. Unfortunately, due to another bug, that is not the
> > > case.
> >
> > This all makes sense to me. What I'm missing though is why not reject
> > VM_WRITE mappings all together? Is there a downside or something that
> > prevents us from setting this check?
> 
> You could, and it would probably do the job (assuming that you check
> for VM_MAYWRITE instead of VM_WRITE), but I think it'd be more of a
> surface-level mitigation than a robust safety check - in my opinion, a
> robust check should, at a minimum, confirm that the VMA being accessed
> belongs to the right driver, because other drivers might do random
> things you don't expect in their own VMAs. (For example, it wouldn't
> protect against interaction with a driver like C binder which reads
> PTEs back out of the VMA in binder_page_lookup(), makes assumptions
> about what kinds of pages that yields, and writes into those pages.) A
> driver should not be touching VMAs it doesn't own.

Alice just informed me the VM_MAYWRITE check is already in-place:

	rust_binder_mmap() ->
		Process::mmap() ->
			try_clear_maywrite()

I just wasn't aware of this, sorry for the noise.

I also agree with your comments. The following two safety checks should
be addressed by binder:

  1. mappings should be read-only.
  2. don't operate on unrelated VMAs.

(1) Was already covered and (2) is addressed by this patchset. So we are
all good here. Thanks!

--
Carlos Llamas


