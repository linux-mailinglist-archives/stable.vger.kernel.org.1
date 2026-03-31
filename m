Return-Path: <stable+bounces-231394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAK3JuWqy2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:07:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10009368849
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 985983093D00
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EAE3A9017;
	Tue, 31 Mar 2026 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JdrhLM2J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7E3A7F60
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954924; cv=none; b=b9FFPcMTxONL/zAqD0kllHPtO6buLt6vhZHYK1GGqHFtIbUEKL3GovRJjx3kBdVAI+gaRO6AVf9vgBOUriZvWmDDzbgBv5bf3+yV9Kcyxg2149X/FdeC4AMDvMQ1NBGdMZpoN/qVew3dDGfUg/bi21yk5aCTDmvDtdq1G8vFtfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954924; c=relaxed/simple;
	bh=1HFO7+Slb1xqlwIb4xFhg2hJWiRbSt/TuGoyy9ORYVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfWB+Z1SYw/nHgfA1nGUrr6F1S69RF8Fa5ZkLcesMwJrGGjnCzwvnlZY9vVJAgk1IVcxmInAPbI876Bbhd9w/3maWqKQziZdAxP6Yfk4tRvTaAlceQ9Q+QxudyRHmUdFf1HdhYIQpeMXFGLuKM/8TToSqatZcsy3YCgbgXKDLjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JdrhLM2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DA1C19423;
	Tue, 31 Mar 2026 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774954923;
	bh=1HFO7+Slb1xqlwIb4xFhg2hJWiRbSt/TuGoyy9ORYVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdrhLM2Jf4sKrfjWdXHDq4ftV/YUosEPclu2TUAhtSTqW+uiEL3kdRklXIVEblQlC
	 CBx/TNvgrUB9HCpA+MbVojYrVOxYpSU2ewv0h9jJ9qMGMwdPqxagJpi43aZXZ8JQRp
	 Tp04GHmUcd8VKR+YuxUJY5XvyvNvdg6oC3yGl77M=
Date: Tue, 31 Mar 2026 13:02:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: feilv@asrmicro.com, chenglongtang@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ovl: make fsync after metadata copy-up
 opt-in mount option" failed to apply to 6.12-stable tree
Message-ID: <2026033156-delicious-bagful-4526@gregkh>
References: <2026033031-backpack-decorator-faaa@gregkh>
 <CAOQ4uxjUDHxSk8uauLrjou_E_D0N4Frv2ddQwkH7xbXK31B-fg@mail.gmail.com>
 <2026033023-reawake-mutation-b00a@gregkh>
 <CAOQ4uxgY733g8UzJTcEcGPPYO2yL93jtTXsuFZsJSxj=cBUb+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgY733g8UzJTcEcGPPYO2yL93jtTXsuFZsJSxj=cBUb+A@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231394-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.968];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 10009368849
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 05:25:46PM +0200, Amir Goldstein wrote:
> On Mon, Mar 30, 2026 at 4:52 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Mar 30, 2026 at 04:15:48PM +0200, Amir Goldstein wrote:
> > > On Mon, Mar 30, 2026 at 11:36 AM <gregkh@linuxfoundation.org> wrote:
> > > >
> > > >
> > > > The patch below does not apply to the 6.12-stable tree.
> > > > If someone wants it applied there, or to any other stable or longterm
> > > > tree, then please email the backport, including the original git commit
> > > > id to <stable@vger.kernel.org>.
> > > >
> > > > To reproduce the conflict and resubmit, you may use the following commands:
> > > >
> > > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > > > git checkout FETCH_HEAD
> > > > git cherry-pick -x 1f6ee9be92f8df85a8c9a5a78c20fd39c0c21a95
> > > > # <resolve conflicts, build, test, etc.>
> > > > git commit -s
> > > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033031-backpack-decorator-faaa@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> > > >
> > > > Possible dependencies:
> > > >
> > >
> > > Please apply this dependency patch as described in commit message:
> > >
> > > Depends: 50e638beb67e0 ("ovl: Use str_on_off() helper in ovl_show_options()")
> > >
> > > Should I describe the dependency using a different format in the future for
> > > the scripts to catch it?
> >
> > Yes, please use the way it is documented in:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> >
> 
> Very well, I will keep that in mind.
> For now, going with "Option 2":
> 
> Please apply
> 50e638beb67e0 ("ovl: Use str_on_off() helper in ovl_show_options()")
> to 6.12.y. It is a trivial cleanup patch and it will allow a clean apply of
> $SUBJECT fix to 6.12.y.

That worked, thanks!

greg k-h

