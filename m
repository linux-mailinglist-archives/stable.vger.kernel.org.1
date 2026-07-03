Return-Path: <stable+bounces-271725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o6cUH8OVR2p+bgAAu9opvQ
	(envelope-from <stable+bounces-271725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 12:58:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 222B1701831
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 12:58:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=2qIkdEJ3;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271725-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271725-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0283303F1C8
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C6B3D9538;
	Fri,  3 Jul 2026 10:43:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893F3D952B;
	Fri,  3 Jul 2026 10:43:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075432; cv=none; b=SwgjWjG4pbHXEuODDkhJ3MmPN3ixrpb1+Ahu5fu5xhEr3Wtr87qWPGaN1Axju1/4XbFxCrG84vnQ1PSsQdmqFFkbm0cReEnp23+QZKjAGU+ZhY51TLZCdwVmoBrd59Ufh1xhwtFZSmC97f1R9qVb4PZADoGrVcCpZXUtrmBUraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075432; c=relaxed/simple;
	bh=fBrun7eOA73kZc7NK6fiNO2andM9BoI/53VKoOLQtRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1V76kViFe3acmuYc4J3Hcs33o5AizI3jLFN5lVAs8sZdSzWtjMahEDaUzeKcjUjCF7z4BP7d8LewC+PqmvchZ54ss+W6dtKW0Ii1F/X+eM+ae4kK+phr80CIOZcFNEpEfNpbVh9kho3w/lWUb9JC9/aht+1vsu7nTDWTl/z3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2qIkdEJ3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF281F000E9;
	Fri,  3 Jul 2026 10:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783075431;
	bh=FAC+Sn738JC5K5fZooG4j32IFdZBaKWSzQu+dKY4nj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2qIkdEJ3Dyyep0wbGY63F9d+QBfwa/1Et1FE4DvLnrfRtfgfrqPG3PqcdglXJc+TT
	 ouOTqHafGcf7ctt4V3v0Akqw1gIPYbZpTfjgu9gdZRcUqP08V5noQ+bCNASZVYxCtW
	 3+5971SADThzSh9FrU9Ocms1n46Vee1pEMga30pE=
Date: Fri, 3 Jul 2026 12:44:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] rust_binder: clear freeze listener on node removal
Message-ID: <2026070357-expediter-neuter-b331@gregkh>
References: <20260615-remove-freeze-on-remove-node-v2-1-93b31766e7a8@google.com>
 <2026070344-alike-ducktail-5fe0@gregkh>
 <CAH5fLgj=YDfcaKAVseHrNPwfLe_yJM4zjZsZqvAEK_QjmrT7rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgj=YDfcaKAVseHrNPwfLe_yJM4zjZsZqvAEK_QjmrT7rw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271725-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:cmllamas@google.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 222B1701831

On Fri, Jul 03, 2026 at 12:31:43PM +0200, Alice Ryhl wrote:
> On Fri, Jul 3, 2026 at 12:27 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jun 15, 2026 at 01:13:16PM +0000, Alice Ryhl wrote:
> > > Generally userspace is supposed to explicitly clear freeze listeners
> > > before they drop the refcount on the node ref to zero, but there's
> > > nothing forcing that. Currently, in this scenario the freeze listener
> > > remains in the freeze_listeners rbtree and in the remote node's freeze
> > > listener list, even though the ref for which the listener is registered
> > > is gone. This could potentially lead to a memory leak due to a refcount
> > > cycle. Thus, remove the freeze listener in this scenario.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > > This series is based on top of:
> > > https://lore.kernel.org/all/20260615-binder-noderefs-spin-v3-0-3235f5a3e0a0@google.com/
> >
> > Hm, but that's not a bugfix series, so I can't take this patch now for
> > 7.2-final.  Do you want to redo this one or wait for 7.3-rc1?
> 
> I can reorder them.

Great, thanks!

