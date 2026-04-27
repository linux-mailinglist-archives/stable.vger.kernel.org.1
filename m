Return-Path: <stable+bounces-241382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B9ZL5KS72nRCwEAu9opvQ
	(envelope-from <stable+bounces-241382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:45:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F495476A22
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41CDC30659CA
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26CC3D34A9;
	Mon, 27 Apr 2026 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7dG4nPH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1032C11E7
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307922; cv=none; b=ODfBmZmIRw2KSCJGuMe3HzxjIyLHfc4RapREuQTOk4jOnyQQR40kyN3ithVQc8twbtF/mWK7jETJPQurXrZKC2Rm/46TK8KOBqKWpjwsgAzAftqCSB90VH6dYRYU+7hRLSmW1xZHm6H+7bHXVYkjVkJwHKKAGn0oWFoxuDwIy2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307922; c=relaxed/simple;
	bh=pEuRsdljZmjc+RoYwAvseZ3l4VB48jTAMQ3fA6OmMhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9VYofUTVBDQqF8Dy5dULFMk8rswR2svXOOmPjHiWlV3MmhmSt6xzy5RS1hsa7U3Lu1AtLe/xTGD8A7b0ZyvnoYbDTBD6dFhDllIctjmd0YNDndR9Py5zaVXX8CO1o+5em/IPx3+A87OaUj/o15ENOSo4vQbdUWDo1TlOGlgoHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o7dG4nPH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1955ad.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777307921; x=1777912721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mou5LEOoziZ5hu0rzC5dRRjLgyBf9T8pKLIONhy+oAU=;
        b=o7dG4nPH2NTCgJrsN0eLVVIMBEqDRVdopVdPshr7a6EynziulCzAKtSitXboMkt918
         VA7Pv2RvunqcI9yRtQM3Z9Wu0efWj94qJ1kpwN/lNjrtCF29lkKS6bAwPpPk6xlkNh6/
         K/z0H2/yNKaj2MrSx6Spl1+1oELx5fcvvQGRp3806xYX6dT2MnRHi52lACMBw53YeeL3
         Bozm6ZgiOEUFliqchxvffovBCC3zMKpEYmqhNFRuFmh3M8qtdy9TxG5q18+TA3UfRzEH
         WxpozvlLLZlZA3kaNPqUR/Am/8nHrFBrPhVVn4iRPgJPUHfQS47DS/EsAHpna3l6/uw3
         YA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777307921; x=1777912721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mou5LEOoziZ5hu0rzC5dRRjLgyBf9T8pKLIONhy+oAU=;
        b=DCCAPa9y1DcxXo4rZWgkEdjvjKT7/UQjMDCV5nbozbAnIDt8zPboZulOGEgT7SP/g4
         TBUmmgzYwUC5Je2G1iK2OkwurFzrA71M6bLHhlwnKQQ9GLDNOjx4/qykjneiYHNoTAXV
         hjtH0sVQpkq98Gp63OsemnhmHEc9Z0OZzsFqTiA7oSj9+zZcJVEGK+X3xdNJod4vfm9C
         x1AQ+ghUL0Ivd11bbtsogvVpP/Of/QiyXzAtYU0/HY8UFQQVjiaKLHxrpjrobdD3M/nJ
         vd2em33uOKRFsPejmcda7MZLK6S6IF4EVroqSflMpuzE8r4QaP1ixPL3u/J1A6Pa+3GD
         pjXA==
X-Forwarded-Encrypted: i=1; AFNElJ9IW8V0IQBv62ZGyvEI1AubYE8XYgXrQ5CPB69/k7Vxssd9o9MKcc8rmZwSZuMch+fMbamkU8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLu6Zz4sadz0vRlG30R7VU/kSNcpde8yNIKcxAEmMZmXhkOtzi
	4fxLO1MWvGgfIbJTfNGQ2+R846ZjRIEF0hyKQvlnZyfhYh7ZfL4kD44huo8EFPwGQA==
X-Gm-Gg: AeBDievxxavAzTExV/zB3A2gPTdZ+FdInXHpiqOspqT1sLvFJnn1ei4/xCPjUdyPuC3
	dr0Ih1qorVpkvok11+N3eS9Z2H97Nkku+oz/Kk9LJsx/MsDq3LGQH+X+oV2ew8eP21AZRMfd7R0
	0qOn6JcIxitGBFqDDvC97jn2E2YXYmjoxu9ukrhPh0dgiNWLl4HhA5HgN/+oxolBg4T5w/wVDQ3
	J7eOKQRjR9Jq6B6k8YekgBcC9CK1Hir5jm3jI3zCtmOCrdXqlV45G9h0Y39JM9rBczJhxAbpnEL
	tdkCiGyQfTGuRQSjzB+TDFDaNFI5XMGUgR+ypdAv4G5Y3R10VsRIbZSE4ls0NSEAC/m+afjMOez
	s7jYZRfB+O3UhFFQUTGRH/s5Baz2+bPrTCd3Gmv65zmGRBday9oe16s0nCCmdCqI30bjVeiZpQH
	pcqoQ88WSa98I4Aw28Fn4E8NfaFopC1/yvbUHrII0qwQMuwVgifFj6rsz7FUgdECn3QZ8E86Lio
	qb05b4q5i1Xg9oib06UZc7er/SradZhQp3qbILx80p3t+XOjltyOhBazvscR3OBcGcc4wITeca2
	pQ==
X-Received: by 2002:a17:903:c05:b0:2b4:6529:7bae with SMTP id d9443c01a7336-2b97a4e7ca7mr109235ad.17.1777307920150;
        Mon, 27 Apr 2026 09:38:40 -0700 (PDT)
Received: from google.com (210.53.125.34.bc.googleusercontent.com. [34.125.53.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3f8asm34437785b3a.36.2026.04.27.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:38:38 -0700 (PDT)
Date: Mon, 27 Apr 2026 16:38:34 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rust_binder: avoid calling pending_oneway_finished() on
 TF_UPDATE_TXN
Message-ID: <ae-RCudmZw2NFDba@google.com>
References: <20260414-tf-update-txn-fix-v1-1-d2b83303acc9@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-tf-update-txn-fix-v1-1-d2b83303acc9@google.com>
X-Rspamd-Queue-Id: 2F495476A22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241382-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 14, 2026 at 12:02:34PM +0000, Alice Ryhl wrote:
> When an outdated transaction is removed from `oneway_todo` due to
> `TF_UPDATE_TXN`, its `Allocation` is dropped. The current implementation
> of `Allocation::drop` calls `pending_oneway_finished()`, assuming the
> transaction was executed. This leads to premature execution of the next
> queued one-way transaction.
> 
> Fix this by taking the `oneway_node` from the `Allocation` of the
> outdated transaction before it is dropped. This prevents
> `Allocation::drop` from signaling completion.
> 
> We do not call `take_oneway_node()` from `Transaction::cancel` because
> it's actually correct to call `pending_oneway_finished()` on cancel if
> the transaction did not come from `oneway_todo`. This ensures that if
> `BINDER_THREAD_EXIT` is invoked and cancels a oneway transaction, then
> the next transaction is taken from `oneway_todo`.
> 
> This bug does not lead to any issues in the kernel, but may lead to
> Binder delivering transactions to userspace earlier than userspace
> expected to receive them.
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Assisted-by: Antigravity:gemini
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Acked-by: Carlos Llamas <cmllamas@google.com>

