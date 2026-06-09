Return-Path: <stable+bounces-262301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h37fK+YrKGr//QIAu9opvQ
	(envelope-from <stable+bounces-262301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 17:06:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBDC66183D
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 17:06:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onurozkan.dev header.s=protonmail header.b=AQIOEq22;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262301-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262301-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=onurozkan.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A9E0325028C
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7254535CB7F;
	Tue,  9 Jun 2026 14:46:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ABF31F992;
	Tue,  9 Jun 2026 14:46:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016386; cv=none; b=GkcdH3/z7o6MuF5G6Q0jF2qiCPMmzVAfcFlR0qFi8VnF4kVJiKQmjvQz+SGJztcS+dzbJk0Q6mzWsoeGbaWY3a+YqJvqPzrl+t3GA0JEN+b7DuBc2mFTPvaJIegJmMvo6KGJtsbUt0M/0qfOI1zIVlWHNK/NlwkSnhiI8PXzxWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016386; c=relaxed/simple;
	bh=gyIw8qRJBT3Y+spWZo9h+r3vb6pGmevAvLL0YYRbTd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Roz8jLlkBn7tiEwebZiDjVgXWB9j7YwqvCoDaPzWgZ5WoNXDEXQDT8zHUlTt0AVd9NTTPZtgJctSB/p+t0ZzRY7oiRPM6aYx7CFetxrfgDtGxY57FpkEe3TPhPRCWsFa9ACrltxC4SaZnG4wkca1vWNJDvQiKwmzryJ42rK3SAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=AQIOEq22; arc=none smtp.client-ip=79.135.106.112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781016372; x=1781275572;
	bh=kRZYQmoUTtWL8RaAVkGdWPqztQqU9tO0ZWRSwMoD+0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AQIOEq22dWr4hrPDOiDfdVUAqQs5aUFejqZw57rryhsUV2Z/v9kvUSHgCOyNwdCBI
	 /hJkY+puO8YsrwDqmUokGawR9zhkRrDfqnk44cpVu5gc9ODih3/BZSgiCmU3BOu8/e
	 8lLbWaGHvVGSQr5hdpDHHSoCwQLcmXkSOe4XAOQr4DLRlJusW9RN7/reqz8Nt2wDbm
	 wRvQz/nndySbSTELmq8asa3E/HXTcux/0m0WyjsgDAGwYZdzqP0jxy5U8g9fCUh33V
	 YgeMV54L0tFMrPdO6XeCt9dRTVrdGHBEYxnLfJTDbQcBWYJixaMxcGkZiTcLve6DCo
	 R5SMZm+MNGRxA==
X-Pm-Submission-Id: 4gZWtp3qJ9z1DDWd
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tejun Heo <tj@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Philipp Stanner <phasta@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Creation of workqueues in Rust
Date: Tue,  9 Jun 2026 17:46:03 +0300
Message-ID: <20260609144608.32100-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260312-create-workqueue-v4-0-ea39c351c38f@google.com>
References: <20260312-create-workqueue-v4-0-ea39c351c38f@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onurozkan.dev,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[onurozkan.dev:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:tj@kernel.org,m:ojeda@kernel.org,m:jiangshanlai@gmail.com,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:daniel.almeida@collabora.com,m:jhubbard@nvidia.com,m:phasta@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:boqun@kernel.org,m:lossin@kernel.org,m:tamird@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[work@onurozkan.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262301-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[onurozkan.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[work@onurozkan.dev,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,workqueue.rs:url,onurozkan.dev:dkim,onurozkan.dev:mid,onurozkan.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACBDC66183D

On Thu, 12 Mar 2026 09:23:01 +0000=0D
Alice Ryhl <aliceryhl@google.com> wrote:=0D
=0D
> GPU drivers often need to create their own workqueues for various=0D
> reasons. Add the ability to do so.=0D
> =0D
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>=0D
> ---=0D
> Changes in v4:=0D
> - Add link to delayed work fix.=0D
> - Redo workqueue creation to prevent invalid configurations.=0D
> - Introduce a directory as workqueue.rs was getting really large.=0D
> - Link to v3: https://lore.kernel.org/r/20260227-create-workqueue-v3-0-87=
de133f7849@google.com=0D
> =0D
> Changes in v3:=0D
> - Switch to builder pattern.=0D
> - Drop BH workqueues for now.=0D
> - Mark delayed wq change as fix.=0D
> - Link to v2: https://lore.kernel.org/r/20251113-create-workqueue-v2-0-8b=
45277119bc@google.com=0D
> =0D
> Changes in v2:=0D
> - Redo how flagging works.=0D
> - Restrict delayed work to not be usable on custom workqueues.=0D
> - Link to v1: https://lore.kernel.org/r/20250411-create-workqueue-v1-1-f7=
dbe7f1e05f@google.com=0D
> =0D
> ---=0D
> Alice Ryhl (3):=0D
>       rust: workqueue: restrict delayed work to global wqs=0D
>       rust: workqueue: create workqueue subdirectory=0D
>       rust: workqueue: add creation of workqueues=0D
> =0D
>  MAINTAINERS                                    |   1 +=0D
>  rust/helpers/workqueue.c                       |   7 +=0D
>  rust/kernel/workqueue/builder.rs               | 380 +++++++++++++++++++=
++++++=0D
>  rust/kernel/{workqueue.rs =3D> workqueue/mod.rs} |  53 +++-=0D
>  4 files changed, 437 insertions(+), 4 deletions(-)=0D
> ---=0D
> base-commit: df9c51269a5e2a6fbca2884a756a4011a5e78748=0D
> change-id: 20250411-create-workqueue-d053158c7a4b=0D
> =0D
> Best regards,=0D
> -- =0D
> Alice Ryhl <aliceryhl@google.com>=0D
> =0D
=0D
Hi Alice,=0D
=0D
What's the status of this series? Do you have plans to continue working on =
this=0D
anytime soon? I would like to take it over and continue the work otherwise.=
=0D
=0D
Thanks,=0D
Onur=0D

