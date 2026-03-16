Return-Path: <stable+bounces-225524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHdmNmDit2lDWwEAu9opvQ
	(envelope-from <stable+bounces-225524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:58:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FB129858B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 648E63028EA7
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 10:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDB1390C8C;
	Mon, 16 Mar 2026 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/gFOFmV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB843909B0;
	Mon, 16 Mar 2026 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658675; cv=none; b=EFMcEt8KLd6l6bjmdHTjqwKVuWlbr1103XqXq3NgbAGzkGx3CjOXwlG2SMqcPfYaxtacOOWIwjRDEFPknJvewl53ojJPQEwyWeA+hwIsmSLeY2w8JEIuZc5U3T48fbI/uECCnGtMaE0jNRzjuguqzzzLxzlDOdGlWwZp7BKW/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658675; c=relaxed/simple;
	bh=uTvtvk3GAk2uT9AfKNo+rlWkiY3iS/8gX3I6jUg7iLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OLqbiCm0u/etsW2cuibEQInlt7kFcZdpjpmFTTZGYA+FifeR4ISJmHwxVXUrTRBPUhzL2BsHlXLW36WGaphpN/sOgWJ1sK8rNAdUA1WgPhoRNHFWLO+Xo0SwaWT1IDvyey3hfyMIdXeb1YgN04vDQBBhM786dQIn6Tp+2LsQoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/gFOFmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2FEC19421;
	Mon, 16 Mar 2026 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773658675;
	bh=uTvtvk3GAk2uT9AfKNo+rlWkiY3iS/8gX3I6jUg7iLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q/gFOFmVkq4Pm778gbHUJ8q27kgf/f+MkRZ7DdgrVI0ywbMOPIXujiBYLGWFRdpFn
	 0z8BaYjFyEf7Fo+C4JL6hwWl16dmTqveFHBraJH/Mgwf/u/CEA+iUifDwzO+Zn9PVk
	 RNRTGs2yPsCXuWq7ndojzVPUNMBJrNBGuUpq8Er2p9ulIsh2GxHsCgtO3Lbjr/Pm8k
	 05iErkjysbW4YBk+ocAcTfWtTwB8MGrc2d9oXs7CTc+0DUI/QXrSlafI5gEHkRSWi4
	 5uPKecZJzelhmBLhaBrcTGOld/q0Nd2FxL9RvqG2BFEDMRdcZl9huTkCx095Tck8ie
	 gsya79Ckmuxiw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Tejun Heo <tj@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, John Hubbard <jhubbard@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, Boqun
 Feng <boqun@kernel.org>, Benno Lossin <lossin@kernel.org>, Tamir
 Duberstein <tamird@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] rust: workqueue: restrict delayed work to global
 wqs
In-Reply-To: <20260312-create-workqueue-v4-1-ea39c351c38f@google.com>
References: <20260312-create-workqueue-v4-0-ea39c351c38f@google.com>
 <0c-9WEfiH7pF4a6Iy7NI9bvO1Wx2bXvOldxFj3PPz5Ri2xhBLV9h0PWtVGrZsq18yUc1FeB805RajPjkpNsYhw==@protonmail.internalid>
 <20260312-create-workqueue-v4-1-ea39c351c38f@google.com>
Date: Mon, 16 Mar 2026 11:24:14 +0100
Message-ID: <87pl54rs1d.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225524-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,garyguo.net,protonmail.com,umich.edu,kernel.org,collabora.com,nvidia.com,vger.kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62FB129858B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

"Alice Ryhl" <aliceryhl@google.com> writes:

> When a workqueue is shut down, delayed work that is pending but not
> scheduled does not get properly cleaned up, so it's not safe to use
> `enqueue_delayed` on a workqueue that might be destroyed. To fix this,
> restricted `enqueue_delayed` to static queues.
>
> This may be fixed in the future by an approach along the lines of [1].
>
> Cc: stable@vger.kernel.org
> Fixes: 7c098cd5eaae ("workqueue: rust: add delayed work items")
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Link: https://lore.kernel.org/r/20250423-destroy-workqueue-flush-v1-1-3d74820780a5@google.com [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>



Best regards,
Andreas Hindborg




