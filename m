Return-Path: <stable+bounces-222619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGiCKHikpWngCwAAu9opvQ
	(envelope-from <stable+bounces-222619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:53:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E55A1DB363
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8AD5300F134
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0F8401489;
	Mon,  2 Mar 2026 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF9HctBM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC33E558F;
	Mon,  2 Mar 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462933; cv=none; b=MfcTTjcWg0xaiwM3u8PUiOAdtUOrUVLsD5urVL12sIow5U0SOiD59ZCyHyraZQNH0E1opjqjnBUXCPLWiKXN3ErbQ50gidxzDlXM9WDmanCKSPPucwdso1/Xe85NoVrdyIWxw8dbsUov+sygLuUVr9Vf6ny6THY6UH40rfyKZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462933; c=relaxed/simple;
	bh=k68oi+DG4aKXnEQ2vm1Yt+VFr3uZ5dWnaQrBSVsbMFk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=N/Se5XB/+1HGKR/mySoB9h9ISQ/5cm/5+NwXqTEQavPrvX130uUbYOi+fD/XN/JVC8Svt9U/vXDgeV0Z+bYVGNa08I+28bhR9heKIyrIjitV5q+gAG9ZPQo2fszo8kiG0mfMF2qc4kuhKFk2CBT8WP7DFaO2XmTH5ju6vXXCAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF9HctBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3274AC19423;
	Mon,  2 Mar 2026 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772462932;
	bh=k68oi+DG4aKXnEQ2vm1Yt+VFr3uZ5dWnaQrBSVsbMFk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=hF9HctBMivGe5BVx/YbhrGtDjYbKCp/t5eBvIzD3AH3OpTTpbvkLzFBKpwwO5LJM1
	 vnTaioGnceLfJxf7FegwLy8axOD/JpujYsU7DO4OvUnp6XxdsoVH8/62hj7nMBJse8
	 RLTTJc7jAgKqwt+r/4RELXN4wGC6n4Warjww4HAMGrm73zGNB0ZbXDqEYWIezTYlJm
	 qYbRGFTlHs5ESfn2q6IwPPl4Bk2Mhvd43/6bk1IxCG4joM9OVausJ8OEKO21YCsIP1
	 jyzsVdBK9s6lC3FGNPYMV56wLJvSZD43jggvJ+3pFGa2BEnEkphxrWaUBP2LTJar3b
	 u0+m/JomFhiIA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 15:48:48 +0100
Message-Id: <DGSDO460JUJ5.2VSG2QHHGB8HZ@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>, <stable@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] rust: pin-init: internal: init: document
 load-bearing fact of field accessors
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260302140424.4097655-1-lossin@kernel.org>
 <20260302140424.4097655-2-lossin@kernel.org>
 <DGSCXPXGW2SW.D8VR5QI5OVNT@garyguo.net>
 <CANiq72mWrPR32O-1rgs7fz0aJTS2rcjGMd7omwvr2cSQkM9rig@mail.gmail.com>
In-Reply-To: <CANiq72mWrPR32O-1rgs7fz0aJTS2rcjGMd7omwvr2cSQkM9rig@mail.gmail.com>
X-Rspamd-Queue-Id: 1E55A1DB363
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222619-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,garyguo.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,google.com,umich.edu,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lossin@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon Mar 2, 2026 at 3:20 PM CET, Miguel Ojeda wrote:
> On Mon, Mar 2, 2026 at 3:14=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>>
>>     Cc: stable@vger.kernel.org # 6.12.y and 6.6.y: need commit 42415d163=
e5d ("rust: pin-init: add references to previously initialized fields")
>
> Yeah, something like that is what I would have probably written. The
> docs seem to suggest a format like this:
>
>   Cc: <stable@vger.kernel.org> # 6.6.y, 6.12.y: 42415d163e5d: rust:
> pin-init: add references to previously initialized fields
>   Cc: <stable@vger.kernel.org> # 6.6.y, 6.12.y, 6.18.y, 6.19.y
>
> i.e. first the prerequisite, then a line without it to indicate "this com=
mit".

Yeah I saw that in the docs as well, but I thought that since the
cherry-pick wouldn't succeed (due to the syn rewrite). However, I wrote
that 6.18.y and 6.19.y applying the patch would succeed, but that's also
not true, there we also don't have the syn rewrite...

The two Cc lines you gave seem like the correct thing :)

So when you pick them, change the Cc's to that (unless I need a new
version of course).

Cheers,
Benno

