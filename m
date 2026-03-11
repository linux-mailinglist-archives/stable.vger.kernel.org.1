Return-Path: <stable+bounces-224687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK1SNnxosWnsugIAu9opvQ
	(envelope-from <stable+bounces-224687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 14:05:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B52264189
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 14:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D850A31CF15F
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF65C2BDC0E;
	Wed, 11 Mar 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsRP0mEJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D827CCF0;
	Wed, 11 Mar 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234099; cv=none; b=f+B+eefPlb/i8oDFCpSS51ivQ/oDQk1C3yqzneYqsu5wPsj2mi/5bVcudemZbE5iVnUaZC0U9AZXjOqObQXfz4Rk9HoF9AA8R+VksbKVLDav+PuASSyDVFigaiK3tOE4ZIvZNvxT+ZG5OBmfOy9w9OdZ0sfsR1cvbI8WAwO8h8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234099; c=relaxed/simple;
	bh=lCWMvbjyU8tevvIUXKuX7UIyxKKdpPdXp+DqEchSsPU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=t3gVi2D4CGEjeYgn72g6/yU9yOp8AmOVi5UGyLS2EnFRJy94tCtXX/gBS1oUPLnqllr8eM3bLN5EjRIXecXfHAO+wFEUwJhY2W3B3qUqqAtuXl2BqCA4KQinqSLDPHuUjFgfDH7bMtyqaQy0n1Xf2JtIGPn88c68mF4ApcEIxt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsRP0mEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A61C4CEF7;
	Wed, 11 Mar 2026 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773234099;
	bh=lCWMvbjyU8tevvIUXKuX7UIyxKKdpPdXp+DqEchSsPU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=UsRP0mEJH5oV1pyMIETFdwA0Ga5QaoLwblpZo7LHHjJiP+uXEhUN8APZf84wQINk3
	 3wbeTQBaJ46uMBIc1zR3kF6yxC6R+DllqduXoPDAHQX//em7TpESI1vS4v5PkZISPK
	 MAwKebCYeW2dL5amcoFe/fWDuN8BgaB1T+cPWphutfu9xtmZKaYL89ysc1fgT4Xmfb
	 6r6Rv2OMkoraGMcsT2N+LJVn0/OyE9tw5eRP8vGdre0OfFaj7zj8M/Pjg8BVg1OQIy
	 36+ucMd+W+HMsBYaxxIDM+trPqqz6WkzB6twq7FAx0POumI+WjlzWxERVy45IlMdPn
	 teDLAQPQGkdng==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 14:01:35 +0100
Message-Id: <DGZZ0XF0YYGN.1W5UIBXK16HL3@kernel.org>
Subject: Re: [PATCH] rust: pin-init: replace shadowed return token by
 `unsafe`-to-create token
Cc: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Fiona Behrens" <me@kloenk.dev>, "Tim Chirananthavat"
 <theemathas@gmail.com>, <stable@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260311105056.1425041-1-lossin@kernel.org>
In-Reply-To: <20260311105056.1425041-1-lossin@kernel.org>
X-Rspamd-Queue-Id: 50B52264189
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,kloenk.dev,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-224687-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed Mar 11, 2026 at 11:50 AM CET, Benno Lossin wrote:
> In the face of Type Alias Impl Trait (TAIT) and the next trait solver,
> this solution no longer works [1]. The shadowed struct can be named
> through type inference. In addition, there is an RFC proposing to add
> the feature of path inference to Rust, which would similarly allow [2]

NIT: I'm not sure if the sentence is supposed to end here, at least it miss=
es a
period.

Besides that, is my understanding correct that the changes mentioned above =
are
targeting a subsequent Rust edition?

