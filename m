Return-Path: <stable+bounces-219989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJAeCdzQoWkfwgQAu9opvQ
	(envelope-from <stable+bounces-219989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 18:14:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DDA1BB47B
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 18:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6FD9311EB56
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B556735D5F8;
	Fri, 27 Feb 2026 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5vrgOoN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D52C2349;
	Fri, 27 Feb 2026 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212149; cv=none; b=QzyRxgQq8+1LRnpUA1xv/BnKd8WBvLen01X2KVcUNb3ErajryD2etj5HleYGOqwtQAT/8+aWAoR/R8luAOXtrCbMniFf6gnMIbaVYgNCYOCN+teD3MT4f+rr7DP8lwCCH34Mu46/3WxmPTRkuTLUhyaBJpXdu0G29dwyoZG/Ess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212149; c=relaxed/simple;
	bh=1KAqzA+8uV1poJl6va51WArWnnZz8PlW6lqjGx93yZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi8aciYOs1ElnnbW3fPBsCxn3kFiJSSsi0uP2PJKZcwE8iQ9+F+pdjxwIv/eXWBcDm7BbACUwuGWq84XbGagbpsEHLrJGLcIhJJIZ79GsZbqmW4+0RBNpNXDrntQFDJmnxPeNasE4L97xnpGsVI8lSApD8LmFyYuwOtZY5o19Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5vrgOoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11CDC116C6;
	Fri, 27 Feb 2026 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772212149;
	bh=1KAqzA+8uV1poJl6va51WArWnnZz8PlW6lqjGx93yZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5vrgOoNFZRn6r17oo6ZnPu4in2RySHro2gEKyq2gHCFPo4mT0vGT7VDHABNFfVqD
	 tJ4JeqsEhmVthfTExHl81tgvd8Ur4u/twkqpqcshWu27PdyFIEm3NAH8sGMOTeifPU
	 0mhp2U/4nKAiu4lKnaCHIsju/4ilXiaxfDhlfUliXz3v0rXIAXSGBmejwoAlMNthEC
	 pP2FS9kU4PspfktVWDf/xLrlHia4TFOAEkOnK2b1HOoC6whKVKIeLUSZp0YkVes4xY
	 WGO5kAzj8oKF+hLVg9OcrtkiEBntZ2/yojytgq4vTU/n3Z/ilBBMbRNK7VsYBHNBe8
	 6knRk8HXDdbdA==
Date: Fri, 27 Feb 2026 07:09:07 -1000
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
Message-ID: <aaHPs-nULPEt_wJB@slm.duckdns.org>
References: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
 <20260227-create-workqueue-v3-1-87de133f7849@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-create-workqueue-v3-1-87de133f7849@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219989-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 78DDA1BB47B
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 02:53:20PM +0000, Alice Ryhl wrote:
> When a workqueue is shut down, delayed work that is pending but not
> scheduled does not get properly cleaned up, so it's not safe to use
> `enqueue_delayed` on a workqueue that might be destroyed. To fix this,
> restricted `enqueue_delayed` to static queues.

C being C, we've been just chalking this up as "user error", but please feel
free to add per-workqueue percpu ref for pending delayed work items if
that'd help. That shouldn't be noticeably expensive and should help
straighten this out for rust hopefully.

Thanks.

-- 
tejun

