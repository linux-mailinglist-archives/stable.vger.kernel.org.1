Return-Path: <stable+bounces-222651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCaFKXXGpWnEFgAAu9opvQ
	(envelope-from <stable+bounces-222651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:18:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 281091DDB2C
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0DEE300AEDA
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 17:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE554279F5;
	Mon,  2 Mar 2026 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ee+SlY59"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C842EEC5
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471920; cv=none; b=m9Gzz/HGpcnpXeDpWRnh4AY2ILXsTEGWyBScxNIw+pRIT42g312BmOPjNPwJMgOqQ6yFxiVQSvvGlFbh8AAoZ+5Up9V909IklA/OYumXybLXWl9KRqVsyaAXncptcXcyFjneA3qSlRBTrfCd3MW1x9VysuV6bsXO90kbyS4KVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471920; c=relaxed/simple;
	bh=Pv2qpIk3MvXi6bkzaURmK+swy1UybcwU1prgxX07c/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s46i3YFvWAGIJ2FeH8bUGMjrJmfdLa5siO2VOMHxjaw0zJHyRJjHUqS0HC7yG+HdZDS3Rv1NuUFuc5R8jhCx5/1U2U9dR/Yr6d3QUKnfmk5FpPiWhpq2cBFwpsQxHTltzi99MpSj1Vr7AqJTvQHayymL1fanpH29cSNZ1dSp/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ee+SlY59; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae49120e97so105925ad.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772471916; x=1773076716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gmjyFqn2IXkUrXbwMN6/szcLPp+gfk/WNKWPoNt3xHc=;
        b=ee+SlY59p0blvuRcE3KRq1cPytLWsk3tj8cu0KzLJ4GCGIXfnBihzE63BosPQ/MC1Z
         00mtDEyiflDkjCl7w/HJvLjm4FwU4q6Xz5GOpbphoW4JyWqa8DpejTQGfiM+uKiIhxFW
         rKbQQipuiIcMY+LiI4CT6W9ybbnRdt2qVufnlMV6np8iRAmNipXpEDDX3tLUXtQnNC7I
         kL05mNm8TxKJEry63U3Cxvt+Q0sz8PsqJS4UNkmctIY4NEZRY5WCfdloMpS+3thD0D7n
         u8KrNT9tYjIWaWA7SbsjbX5peyLpolazsrjHmmOucT0vzL56UVet6gSm9HimgQ01/TN8
         gzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772471916; x=1773076716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmjyFqn2IXkUrXbwMN6/szcLPp+gfk/WNKWPoNt3xHc=;
        b=K28Xffe1ZaWfZIzJ13l+D9411TphbhioXfSKKRpv6PhX+Wx1+kx7MwytyK39t885bG
         TuQsPpuD3RRZRwZ5Qp5LoHuS/w8X5oHh/HD+U6kxkOEIcwpLOdsZHWA9t6mfjnCPF+vn
         z+wZPGyzJ2RVQfD4MDk9ac9OFfvqb/WteBR+OkYaBaO162P6SkbflW/GuUtrAPU4edJP
         xNLr7QP+bgJHHrrlbvtyGhwehtNPBkuvY2bMn7VOGVJ+sweMXFdNlmPYok7cdjMteU7p
         y5VldhG1U+c879iPa6m6e/GWYCFm+Odszji8cp3DIVf550EWPtskmJpaGhOym92gMYyh
         bd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXu2OI5rd21k7qfo15SLl5e8mIUZCAhg/jvkkvtNrYpCbmkwz+asdmmX72+mkiVtg7DUvTTRI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvxwKpjajChvK5f3ZOltF/JjDQ+XZIm1O+WwkjZJMRm3c1sS8Z
	xCuTri1Xf2EaayR7ST8DLbtVEryKulgG4PePzfblunc0h/x4K8fOnY94oplquN5RJA==
X-Gm-Gg: ATEYQzyy900mlgqn/bvKencxmKOa0p3r2dwWxHUSP37tl6M+Q7ooGVQh4PPigDoJuTj
	DmYb62+UspSnO+RbM9UWHfS8D8Y8PbUtlsib384PsVPO+Kh6NiQFwhTqkR1Zta3ZT4RXnXTqL2C
	m1585prWpHIC4rgcHcCtcDR8yadL7Fco1LiaVovp6h6uXg8wje5KDv6s7vMe301cCMwFjVYkP2a
	asO+VRF4ACdxCg8oNBQNAUOcqP6skt4hdQL8bjXg09hkF8LOiGi1iikYlZ+dCnxLMzOJBw5EEGu
	XCDAeh2Nasv02GacOj46h5dJaB9Mkpf4OrnyDy4mRMguR3/sQTqUqHbyAV6L//GJ89Y+H5twXom
	r7vCSpXpZ7ItCsqm0c88m5i8EmI1xK7diKSMsb3NikptCRjHMtIVdTJa4F94GTkdrp0fNs89YRN
	AXnXvdLJoMQeZ32eUQEuM8gZdeFhr5fMJoLNLgm0f7Lcx3MPA5JFN4MQnUkh3de4nQ9ojSId0H
X-Received: by 2002:a17:903:2d1:b0:2aa:d5fd:5d76 with SMTP id d9443c01a7336-2ae3b3868d1mr2934195ad.1.1772471915887;
        Mon, 02 Mar 2026 09:18:35 -0800 (PST)
Received: from google.com (154.52.125.34.bc.googleusercontent.com. [34.125.52.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4802645bsm55239085ad.12.2026.03.02.09.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:18:35 -0800 (PST)
Date: Mon, 2 Mar 2026 17:18:30 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jann Horn <jannh@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
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
Message-ID: <aaXGZlfAmk-DCuBW@google.com>
References: <20260218-binder-vma-check-v2-0-60f9d695a990@google.com>
 <20260218-binder-vma-check-v2-1-60f9d695a990@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218-binder-vma-check-v2-1-60f9d695a990@google.com>
X-Rspamd-Queue-Id: 281091DDB2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-222651-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:53:26AM +0000, Alice Ryhl wrote:
> When installing missing pages (or zapping them), Rust Binder will look
> up the vma in the mm by address, and then call vm_insert_page (or
> zap_page_range_single). However, if the vma is closed and replaced with
> a different vma at the same address, this can lead to Rust Binder
> installing pages into the wrong vma.
> 
> By installing the page into a writable vma, it becomes possible to write
> to your own binder pages, which are normally read-only. Although you're
> not supposed to be able to write to those pages, the intent behind the
> design of Rust Binder is that even if you get that ability, it should not
> lead to anything bad. Unfortunately, due to another bug, that is not the
> case.

This all makes sense to me. What I'm missing though is why not reject
VM_WRITE mappings all together? Is there a downside or something that
prevents us from setting this check?

--
Carlos Llamas

