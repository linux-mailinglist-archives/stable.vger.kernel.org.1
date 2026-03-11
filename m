Return-Path: <stable+bounces-224740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a/bvChSxsWmXEgAAu9opvQ
	(envelope-from <stable+bounces-224740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:14:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2050D268773
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E91E93018E39
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A800F3E6DEE;
	Wed, 11 Mar 2026 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dT8GM4+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B3318BA8;
	Wed, 11 Mar 2026 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252878; cv=none; b=AiKrNzGmzH2Lh/tJLVRTb1m9Kv25q1TwjTjIVD2deP5NY+jx8vGt/WMoku9d8jzpwuUiAAjZYFK56wpwY6mf9NoPGzbNRzuN3qZ/Xv83rIOlMosD6ppv3WQDVj8wYTLWVS/PIiiAyjO2jHL9Iewv5M55UI3JZfcb2kr9fbwGSwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252878; c=relaxed/simple;
	bh=QazkRwUy3McErmvBQbClt/+sIlmmR2iEEOsG1w/764U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=uVPNyXv8FvQI8+bQi/UNqj2gDBFmgIx5bU7q8jF4Lw6ellfDtcVbn4s8Ryj073tZdKNEFPd3XW02FRbToPMKzDqNsTqaDwDFvrWU/8TkF/h+s7L++6qjZHVJGD5WWy5+7XAt/kKD31pean5Ug01nM5drDHzEU+hchCm0iPViqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dT8GM4+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AA9C19421;
	Wed, 11 Mar 2026 18:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773252878;
	bh=QazkRwUy3McErmvBQbClt/+sIlmmR2iEEOsG1w/764U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=dT8GM4+4s/eMO8EVG29pvt9CfjFNVbSrKob4NHDWn1MgR1/bnl9Buv6yJEKiG1XZB
	 RzK5pNBXuwblgONHXT39MdiMJYWALLOmOUpI85ZEVmlfVzlwKGRInA1Sso30dI6YQY
	 oskCbNi0hcsGLROStU/DunNRmSdyv3OIbV6tOu6mMDIzjBKVWhjhH1PttwpBFUW5tz
	 CQxi2TFQ2etqfz7bQ7IlPflH3EAAEkDdb3Q1CqYSsAdIrwsYKpGkmYYIOca6MGhqxv
	 he8i6qym5F89noH4xW/KptDTvpUMpKXv41t2KTv+VryE7KEmpKNa6g7bFq/rQrINx8
	 vo/6mFaNLNCKg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 19:14:33 +0100
Message-Id: <DH05OK4Z9XN8.2FT8K8GBNA6C8@kernel.org>
Subject: Re: [PATCH] rust: pin-init: replace shadowed return token by
 `unsafe`-to-create token
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Fiona Behrens" <me@kloenk.dev>, "Tim Chirananthavat"
 <theemathas@gmail.com>, <stable@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260311105056.1425041-1-lossin@kernel.org>
 <DGZZ0XF0YYGN.1W5UIBXK16HL3@kernel.org>
In-Reply-To: <DGZZ0XF0YYGN.1W5UIBXK16HL3@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224740-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,kloenk.dev,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lossin@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2050D268773
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Mar 11, 2026 at 2:01 PM CET, Danilo Krummrich wrote:
> On Wed Mar 11, 2026 at 11:50 AM CET, Benno Lossin wrote:
>> In the face of Type Alias Impl Trait (TAIT) and the next trait solver,
>> this solution no longer works [1]. The shadowed struct can be named
>> through type inference. In addition, there is an RFC proposing to add
>> the feature of path inference to Rust, which would similarly allow [2]
>
> NIT: I'm not sure if the sentence is supposed to end here, at least it mi=
sses a
> period.

Oh yeah, missed the period.

Cheers,
Benno

