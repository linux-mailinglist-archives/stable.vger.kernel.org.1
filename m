Return-Path: <stable+bounces-213261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ew/FUIJgmmCOQMAu9opvQ
	(envelope-from <stable+bounces-213261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:42:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F752DAB9E
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0888E3002912
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EAC3164D6;
	Tue,  3 Feb 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vL+kHJTZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E33AA1B3
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129725; cv=none; b=nD/Lgevijnaq4c4Iq2eRv2LE+peZvimFGLdEF8QtjgmotEJN4c8VyDP8PhEK0ikg/NcZvQ0aqpqCH3Xa8G1J12CufZBmsgmUx45qvDIs5t4Y7RN6SqCiFKXQRZlZEnKZFj3OUdOsA/QNyVsqnOdllhYc98iAVvCN8iDDPnzpt3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129725; c=relaxed/simple;
	bh=J2c8W+ly6Yrsegv01jJrvFep3ShpRthaDu5KYP2XttM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEVMbFA+JRjwj6bspmNVBxw1ieIg1tm5E3WTifOrMukeRCfQbZpY8sWWco7eDc+G6dVd8326R6Bc5ENQo0Vr/tXzRQ8pTCJYxOVe7CnYOk3RJmsnsTtBfk2k6iXS4aOPYZIyDnJYMWJCuRK4KWVqxTshFeaQrG/LhFim688yEnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vL+kHJTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDB3C116D0;
	Tue,  3 Feb 2026 14:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770129725;
	bh=J2c8W+ly6Yrsegv01jJrvFep3ShpRthaDu5KYP2XttM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vL+kHJTZSRrz/UCkATLjSX6tsHOoctudBP/4OaaJQ8OMMSoYsJrxYXHoiUOmfDuaX
	 lCj5ek7qBSbXU6qSCY99yMuAk/nqCZ/v8rAhwV8CxuYizDidwU4vAdhGw8WO8A1xbj
	 nTdkp6+B8IqZ9Y4nFEyE2p+6XNJ/wzFcRDPv1PHY=
Date: Tue, 3 Feb 2026 15:42:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alyssa Ross <hi@alyssa.is>, Sasha Levin <sashal@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>, WANG Rui <wangrui@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>, stable@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>, Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH 6.12.y] rust: kbuild: support `-Cjump-tables=n` for Rust
 1.93.0
Message-ID: <2026020348-rehydrate-glider-b1f3@gregkh>
References: <20260129133715.23095-1-hi@alyssa.is>
 <CANiq72mD7BZB4KUNNnboK81zLRLVqrZ7CaQQJsG0GTqTO_ZU=Q@mail.gmail.com>
 <CANiq72kXfdBtGAxdqer_t4JC+57mjgTpEE=D1VkAeODCf2hiZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kXfdBtGAxdqer_t4JC+57mjgTpEE=D1VkAeODCf2hiZQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213261-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F752DAB9E
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:03:06PM +0100, Miguel Ojeda wrote:
> On Thu, Jan 29, 2026 at 3:55 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Thu, Jan 29, 2026 at 2:37 PM Alyssa Ross <hi@alyssa.is> wrote:
> > >
> > > From: Miguel Ojeda <ojeda@kernel.org>
> > >
> > > Rust 1.93.0 (expected 2026-01-22) is stabilizing `-Zno-jump-tables`
> > > [1][2] as `-Cjump-tables=n` [3].
> > >
> > > Without this change, one would eventually see:
> > >
> > >       RUSTC L rust/core.o
> > >     error: unknown unstable option: `no-jump-tables`
> > >
> > > Thus support the upcoming version.
> > >
> > > Link: https://github.com/rust-lang/rust/issues/116592 [1]
> > > Link: https://github.com/rust-lang/rust/pull/105812 [2]
> > > Link: https://github.com/rust-lang/rust/pull/145974 [3]
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > > Acked-by: Nicolas Schier <nsc@kernel.org>
> > > Link: https://patch.msgid.link/20251101094011.1024534-1-ojeda@kernel.org
> > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > (cherry picked from commit 789521b4717fd6bd85164ba5c131f621a79c9736)
> > > Signed-off-by: Alyssa Ross <hi@alyssa.is>
> >
> > Thanks!
> >
> > Greg, Sasha: yes, please take this one -- this commit should have had:
> >
> >   Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is
> > pinned in older LTSs).
> >
> > which was in the email thread, but I didn't pick it up and neither
> > `b4` did, my mistake.
> 
> By the way, if LoongArch (Cc'd) would like to backport commit
> 
>   74f8295c6fb8 ("LoongArch: Handle jump tables options for RUST")
> 
> then this would be a good chance to do so, since the one here would go
> on top of that one (Alyssa backported the x86 subset of the patch --
> for the future, by the way, it would be nice to note it in the commit
> message in between [ ... ]).

It doesn't apply to the 6.12.y tree cleanly :(

thanks,

greg k-h

