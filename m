Return-Path: <stable+bounces-220069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB9uOJkBo2kJ8wQAu9opvQ
	(envelope-from <stable+bounces-220069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 15:54:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAD71C3B95
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 15:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD27A30B7195
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675F441056;
	Sat, 28 Feb 2026 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFknBXS3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30443E9F7;
	Sat, 28 Feb 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290176; cv=none; b=rAhliXUaWxTWMoiNudWCaANXNJF8d8MxMFSP9W9YIrwNiqHcN1O7eAw3g9UO++IAKqlYCan5M8CQphkjEGkYDrYv8sNQhjkRuyBnQ4OJhpY2RtQQZyd3FUV22zgr49eMXYxO6aqYizsjkwea9QIfBGDhgpDDaTmsc6buYRafTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290176; c=relaxed/simple;
	bh=wU50kOIHUy1f7lhyOkVxe46gtdtqcn2h7NkuPm+ve20=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CYiU7uiYj0XcZ0if7MPrUSCBANnmB6koAMwoRsLj66ZLqGnCkclK8I9tCHUL1KjZ+LmnhkosnF4VR4zyBjxdSKb0PlDZ6mvh5yBqvQxcajdUENVXPj2FBMCkN9fAyW8BjgTn3cyGDcioVAp0SXl5xhm1RalTpNqryA3gNX/bPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFknBXS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323D7C116D0;
	Sat, 28 Feb 2026 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772290176;
	bh=wU50kOIHUy1f7lhyOkVxe46gtdtqcn2h7NkuPm+ve20=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=BFknBXS3eIbIWpZkPnvGJKZz7cQPtPb91NcYSaiHyos0FbcwYHber52q3nmeu2SAF
	 UTL+sdATV4yn8xaVRBjHRWauWFF6GJLk/yJaQi879UPcblPnsVjNwWjyMUOf5Z4VDR
	 cOhhpkhGME1sJR6QFisUYtnD9acM+DyKlo3elaCDjkoarQ93XSd9k9o7oDRR3ESdiV
	 khCRNSOK3hE7yETxPIlS7ejsJVBe/cxavf/uzRmU2bF2PffSrB6FjcKwp+jkuWCsFF
	 3bKeLYuzTq2U2PjVC1GOzFqUBfW8Hgr0tGPv17b3Wz8O4RleSJBhYIdN76J/dXeeRg
	 mQDAZotSvCvGw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Feb 2026 15:49:32 +0100
Message-Id: <DGQOFLDG5QOI.1IBUD2CCIVG57@kernel.org>
Cc: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, <stable@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: pin-init: internal: init: document
 load-bearing fact of field accessors
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260228113713.1402110-1-lossin@kernel.org>
 <20260228113713.1402110-2-lossin@kernel.org>
 <CANiq72kRjJj=sOke+PWwu7uphL0AsJAi1UL53AYrDzJ=4Z=0Mw@mail.gmail.com>
In-Reply-To: <CANiq72kRjJj=sOke+PWwu7uphL0AsJAi1UL53AYrDzJ=4Z=0Mw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220069-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lossin@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EAD71C3B95
X-Rspamd-Action: no action

On Sat Feb 28, 2026 at 3:11 PM CET, Miguel Ojeda wrote:
> On Sat, Feb 28, 2026 at 12:37=E2=80=AFPM Benno Lossin <lossin@kernel.org>=
 wrote:
>>
>> The affected stable trees that are still
>> maintained are: 6.17, 6.16, 6.12, and 6.6.
>
> Same here, i.e. 6.17 and 6.16 are not maintained anymore, so these can
> be skipped.

Oh perfect, that means less work then. I wonder where I saw these, since
I checked the website, but now I of course don't see them there...

Cheers,
Benno

