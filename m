Return-Path: <stable+bounces-231245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEUxJSWUymnF+AUAu9opvQ
	(envelope-from <stable+bounces-231245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:17:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC7E35DA48
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DA2430C459A
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF113264FC;
	Mon, 30 Mar 2026 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MUKA3nIz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6940DFC8
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882368; cv=none; b=Lh4gE/KFs5o3rgBkqwh8xLhK4nicm9glP8s5HNIfXXu3xA7Hm8qWfyJQDGvrlXwvWU4wtfHzpU8WpBk8vQj1Ru929bbxikSAzlUluI+Jz6iSsZTy5+WHvUGlu/gbvSOSuecVG0ulnyBHlKSonQ+BsWXARz3/fcqc6uXfBraQF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882368; c=relaxed/simple;
	bh=yvrVASvtQeZWimBhI5sZuQUgTwAze1R0mu/dDFhRC2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIgPZiJ7TQpPrEYPDYzisTDgAlr2XZ5Z4/M4C1Sh5ZIgru29MqKCASoZnxUXFjNi8UOIoak/vXSLeRCjNrj7hwZQ+KVzHFLFWQudjuYcdf0Tdw5jJOUiFflPOxIpzfrCNS+0BnlyDVvXP0f8AVoxyUiXnM+M4G8Kic5PLORCMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MUKA3nIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2D2C4CEF7;
	Mon, 30 Mar 2026 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774882368;
	bh=yvrVASvtQeZWimBhI5sZuQUgTwAze1R0mu/dDFhRC2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUKA3nIzczxqBBTfsuV0nHU2Roa/l9bAJkcCDu+NxACKQ9ZsAcTAqmh+rYxVppMnB
	 E/guyItb3pj2ePnCXPQ+cF8R8f3+KB8EIHa5juoDtHu1vKhfn54evTJXbk8rd2z+/W
	 L+b2S7ju8ZyRgNi2dGw3kP4dNgfnOdQDw4fEqE1I=
Date: Mon, 30 Mar 2026 16:52:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: feilv@asrmicro.com, chenglongtang@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ovl: make fsync after metadata copy-up
 opt-in mount option" failed to apply to 6.12-stable tree
Message-ID: <2026033023-reawake-mutation-b00a@gregkh>
References: <2026033031-backpack-decorator-faaa@gregkh>
 <CAOQ4uxjUDHxSk8uauLrjou_E_D0N4Frv2ddQwkH7xbXK31B-fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjUDHxSk8uauLrjou_E_D0N4Frv2ddQwkH7xbXK31B-fg@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231245-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 0AC7E35DA48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 04:15:48PM +0200, Amir Goldstein wrote:
> On Mon, Mar 30, 2026 at 11:36 AM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 1f6ee9be92f8df85a8c9a5a78c20fd39c0c21a95
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033031-backpack-decorator-faaa@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> >
> > Possible dependencies:
> >
> 
> Please apply this dependency patch as described in commit message:
> 
> Depends: 50e638beb67e0 ("ovl: Use str_on_off() helper in ovl_show_options()")
> 
> Should I describe the dependency using a different format in the future for
> the scripts to catch it?

Yes, please use the way it is documented in:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

thanks,

greg k-h

