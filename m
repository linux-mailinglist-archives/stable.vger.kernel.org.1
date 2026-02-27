Return-Path: <stable+bounces-219977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOpTAke1oWmMvgQAu9opvQ
	(envelope-from <stable+bounces-219977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 16:16:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 799681B98BC
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 16:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4EC3317FBD1
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8357438FE6;
	Fri, 27 Feb 2026 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3wOU3bP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74708436374;
	Fri, 27 Feb 2026 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205016; cv=none; b=jx/YmtVO4kEM0SO+P+11Gdf/EPbweAnCKdLDawo8GbfAYtB5poV8M0/wjUR/YQLhTDp6y27USiHTuV7ClhH6yoC0zQojssHvhqYm5KrKLdLLPRPRtCLXM+Wv/KDzt0abevbA9fmHTdZIDtLvLStLCfbO63QTyZ/wlETU0cJd4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205016; c=relaxed/simple;
	bh=A+0kNftCTVHBA/gr9wUYwklcGsNkEFj9fn64fLK4cMo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZzlkfkgD4BICHlCMranid61sj8uwF9EiyVYi1v7BOq5nF7e/VmoTIHO5FlFtqTVw90t6MeYpP52kfmxEskHS79D/0KjloeO8hDmpMWvLwn2jn1rK2sjsIVM22MIX7i9UPbf22dUz4Q+AAl6hV/2Y/akTRr7vJxC5cxmWWvvTQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3wOU3bP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05F1C19422;
	Fri, 27 Feb 2026 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772205016;
	bh=A+0kNftCTVHBA/gr9wUYwklcGsNkEFj9fn64fLK4cMo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=R3wOU3bPwzjVMt88qdYanywyywgh6ijFhqoRxoky1je2i+67QUwTqzbwB/aUNVoWR
	 5d7hAysaLWZy1DUGSgqG5K5EBU43ZW2MyEqlibvaX96sDOiWFHFOqYM8WkSGbkwgNc
	 G1HNKqKhPrByUtdy3MyH8f4joH+smKTQO6uddbQJDtGhebmWPiFdv0AIDlFC4R78i6
	 TuC4eX8Z4hDJkeAwJmGi4/LnSJH8IL1ai7mB9jxJxEQUmfUZSG6d9cVl6+ZGIpkmzH
	 zmTnuaPnXYoGVy+mL5be4gFXPaeV4fnmZa2wRLtKFn0Pwc1ZqvqcEiUFteTaFLLq8U
	 WT7ypYWwdKz6A==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 16:10:11 +0100
Message-Id: <DGPU8USGBKVH.2D5DH6NTL50U2@kernel.org>
Subject: Re: [PATCH v3 1/2] rust: workqueue: restrict delayed work to global
 wqs
Cc: "Tejun Heo" <tj@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Lai
 Jiangshan" <jiangshanlai@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Benno Lossin" <lossin@kernel.org>, "Tamir
 Duberstein" <tamird@kernel.org>, <stable@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
 <20260227-create-workqueue-v3-1-87de133f7849@google.com>
In-Reply-To: <20260227-create-workqueue-v3-1-87de133f7849@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-219977-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 799681B98BC
X-Rspamd-Action: no action

On Fri Feb 27, 2026 at 3:53 PM CET, Alice Ryhl wrote:
> When a workqueue is shut down, delayed work that is pending but not
> scheduled does not get properly cleaned up, so it's not safe to use
> `enqueue_delayed` on a workqueue that might be destroyed. To fix this,
> restricted `enqueue_delayed` to static queues.

:(

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

> Cc: stable@vger.kernel.org
> Fixes: 7c098cd5eaae ("workqueue: rust: add delayed work items")
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/workqueue.rs | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 706e833e9702..1acd113c04ee 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -296,8 +296,15 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::=
EnqueueOutput
>      ///
>      /// This may fail if the work item is already enqueued in a workqueu=
e.
>      ///
> +    /// This is only valid for global workqueues (with static lifetimes)=
 because those are the only
> +    /// ones that outlive all possible delayed work items.

We should probably add a FIXME comment pointing out that this should be fix=
ed in
the C code.

Maybe also link your approach?

> +    ///
>      /// The work item will be submitted using `WORK_CPU_UNBOUND`.
> -    pub fn enqueue_delayed<W, const ID: u64>(&self, w: W, delay: Jiffies=
) -> W::EnqueueOutput
> +    pub fn enqueue_delayed<W, const ID: u64>(
> +        &'static self,
> +        w: W,
> +        delay: Jiffies,
> +    ) -> W::EnqueueOutput
>      where
>          W: RawDelayedWorkItem<ID> + Send + 'static,
>      {
>
> --=20
> 2.53.0.473.g4a7958ca14-goog


