Return-Path: <stable+bounces-220005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BbKKYL0oWkwxgQAu9opvQ
	(envelope-from <stable+bounces-220005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:46:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE371BD090
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BE1B30AECA9
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF61946AEE4;
	Fri, 27 Feb 2026 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyTPu6Dx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BFB46AEDC;
	Fri, 27 Feb 2026 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221564; cv=none; b=J6tRFvoSooDGme9ZUqtrE/jUBNKnUreXR8eDCKznRyy1cOXpwIfAotBlo1TipbIEWnDQMA7kkKWFEzP8ZQfS+LqKYNUwj3sR9zoLbX+N+qc5RhkzttjZaAPjq2ECrXEiS7X4MKa5dYRJ7b09cX3P07MkHieWVhwwu7XT2zFjxTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221564; c=relaxed/simple;
	bh=SbGsqwk+eKr1sQ1ASH0LTxIHPNgop4DN4OJiqwPR/Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtIykggGWhNtamB5Mkqe/clKOVcX9X5b7k7Ta2b0Y5y5GDXQlQ+zw2jPABpOzseNsEn7tKqNXAb68r3NnK18Wrn7aSxuF1r9l6Lwtv73rBZGdchHbfOfZbyxyWJz1c26HbbQ0oNGMvgbyEjHTYRnaiNaoZQvp4hfUJnrtCvKbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyTPu6Dx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3565DC116C6;
	Fri, 27 Feb 2026 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772221564;
	bh=SbGsqwk+eKr1sQ1ASH0LTxIHPNgop4DN4OJiqwPR/Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyTPu6Dx7VhkX1s2fcN1zLSD6t/pkg1ANt/671Sl01LVMZj4EVJO0jbTmeiTRNVGy
	 1AEoGGPuHUm6OhgqJzowwDkt2Hvwyd8dvxxjMFpxs7P3+zNeQpu6WGISfQ+4FsOvW7
	 jH1y9SeTUsnr6R2zp4J0hNHahpNX+tj+YsZ13xSTE7vG7sEM/2rvWFUeYg5ua266KO
	 vJfGh8qsO2aQ2hvHGQFlX+bsC20gHF/5l2HkqIBnYlzqK8ppRBuopZqyC88vvfPD4b
	 oMcnpvcQiqQ1lW4XQ5Oh/6QiI5YhkyuSALV2/WOg+bDqudkf15anvLcCBBTDnVaME1
	 NleszU5/SlGzA==
Date: Fri, 27 Feb 2026 09:46:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: workqueue: restrict delayed work to global
 wqs
Message-ID: <aaH0e5YKnH7x1gCB@slm.duckdns.org>
References: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
 <20260227-create-workqueue-v3-1-87de133f7849@google.com>
 <aaHPs-nULPEt_wJB@slm.duckdns.org>
 <aaHp_pGBxA4pNiXJ@google.com>
 <aaHrxzWIFFUjzWhu@slm.duckdns.org>
 <aaHuXEO64ONKMW4O@google.com>
 <aaHvcvbmkl7oSFOR@slm.duckdns.org>
 <aaHwSxIaTqLWndkw@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaHwSxIaTqLWndkw@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220005-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 0FE371BD090
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 07:28:11PM +0000, Alice Ryhl wrote:
> > delayed_work is just pointing to the wq pointer. On destroy_workqueue(), we
> > can shut it down and free all the supporting stuff while leaving zombie wq
> > struct which noops execution and let the whole thing go away when refs reach
> > zero?
> 
> But isn't that a problem for e.g. self-freeing work? If we don't run the
> work, then its memory is just leaked.

Yeah, good point. Maybe we should just keep the whole thing up while
removing it from sysfs. Would that work?

Thanks.

-- 
tejun

