Return-Path: <stable+bounces-219998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EyiHvfsoWlDxQQAu9opvQ
	(envelope-from <stable+bounces-219998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:13:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D005E1BC877
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 780EF318EFE3
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366693A9D94;
	Fri, 27 Feb 2026 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOcrH5QY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D963859CB;
	Fri, 27 Feb 2026 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219337; cv=none; b=JPqaDoHeQtnqtoZGjIZMa5VjdGrDXXfK8grDKxxweHWkeTEFv+mLZ6QXXa++L7Xr0eqpATZD7WZTlYoURSE62s3CoIo3SaJ5g7Ok5zDhY/jUD4CeP7vUzrjyUj11oHvXOLstXUCJV/R01jwKcmhi+4ii4u3OEKpeEHzwPV7bdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219337; c=relaxed/simple;
	bh=OX3Fxxu84DxxqCLZDuNx1vaZ6SJgo1D7Ku/XQzsJrvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjScw7WYNgQATsT48tJdrJkqOWDeKg1QPMXmC8fKg/6WhRmOzanIg62DTr9laydCKs+x5EwRkMomy9uhsfri2fsNfbpKzOrcVQU8QlMzgCJb694uaQeArTePly7q+v5eeA7FJS0DJrYu1ZS8uM0fUzraxq/4/TzkFYZ+/8nhwKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOcrH5QY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F191C116C6;
	Fri, 27 Feb 2026 19:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772219336;
	bh=OX3Fxxu84DxxqCLZDuNx1vaZ6SJgo1D7Ku/XQzsJrvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOcrH5QYJOUZ4r/9jMDxJ7qq3Jx5oNyBOVt3DSvtLNAA4NlWWiqi367iJbOOu0B7+
	 yuzwGNc+bGfIq5w8h/asqp3R8g4fFBFEl5NGDjxXs/n4gc2GO7061X5dv0icV0J5Gl
	 JFTTefnDxm/ahqqv9bSz5gk2OU0wAYDOHRqAuv9uO1tSW+usgnJRZ/0uGM6dapyUG7
	 /V/MIl1MnObtbFD22zQxUupUFEjGRGHFS3IEg4CsaqTm+NjXPSEF4xy1twGENSBWqy
	 28z9vM5ZkKz4WP2g30wSG0JOLV5sR5Mj2BxFOhJZwjVZKJ5guINuhpmniMJ/2EyWbk
	 NB3qrNTUz/3BQ==
Date: Fri, 27 Feb 2026 09:08:55 -1000
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
Message-ID: <aaHrxzWIFFUjzWhu@slm.duckdns.org>
References: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
 <20260227-create-workqueue-v3-1-87de133f7849@google.com>
 <aaHPs-nULPEt_wJB@slm.duckdns.org>
 <aaHp_pGBxA4pNiXJ@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaHp_pGBxA4pNiXJ@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219998-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D005E1BC877
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 07:01:18PM +0000, Alice Ryhl wrote:
> On Fri, Feb 27, 2026 at 07:09:07AM -1000, Tejun Heo wrote:
> > On Fri, Feb 27, 2026 at 02:53:20PM +0000, Alice Ryhl wrote:
> > > When a workqueue is shut down, delayed work that is pending but not
> > > scheduled does not get properly cleaned up, so it's not safe to use
> > > `enqueue_delayed` on a workqueue that might be destroyed. To fix this,
> > > restricted `enqueue_delayed` to static queues.
> > 
> > C being C, we've been just chalking this up as "user error", but please feel
> > free to add per-workqueue percpu ref for pending delayed work items if
> > that'd help. That shouldn't be noticeably expensive and should help
> > straighten this out for rust hopefully.
> 
> I had been thinking I would pick up this patch again:
> https://lore.kernel.org/all/20250423-destroy-workqueue-flush-v1-1-3d74820780a5@google.com/
> 
> but it sounds like you're suggesting a different solution?

I'm not remembering much context at this point, but if it *could* work,
percpu refcnt counting the number of delayed work items would be cheaper.
Again, I could easily be forgetting why we didn't do that in the first
place.

Thanks.

-- 
tejun

