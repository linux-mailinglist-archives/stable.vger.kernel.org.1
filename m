Return-Path: <stable+bounces-225572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCcEH2AbuGlYZAEAu9opvQ
	(envelope-from <stable+bounces-225572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:01:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E129BEBE
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7885030101F6
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09922F6170;
	Mon, 16 Mar 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PGkGnd9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18653176FD
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673303; cv=none; b=EEkcaLeFK2+JCH6gZXXsOCT+obAmVqShWx3wO0p11zf4KJFR+7xVPdK2nlKqA5/zOkbQil62qly0u91gTVRaLaeKEfs1/AjuN7VJs3GOKDZOJwwOwOaFi1ipicXfnvshYM8n/pziDLU3QpA/iHRpRbbs2KgWgxDhKiIt7nUuYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673303; c=relaxed/simple;
	bh=HkLW2dcj0QBsG8gu9grI3wqKx806NuHtswkuvTE7uso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCEsTrYx6i8zl76jmeQ9Nt9n+j2ruAriCyy4oJRviBqDHchE61Ii7usKsQ71NAbkJjsK5W7AU7g0ySkvueV10bUTiYuvrNsoz4TMj5nFvaZHglFfvFp8v1sWke6Ov/874eBCaHCTdpCmyVbE7gZ7zdmDyOIHrXXR0mOqg5LQLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PGkGnd9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E88BC19425;
	Mon, 16 Mar 2026 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773673303;
	bh=HkLW2dcj0QBsG8gu9grI3wqKx806NuHtswkuvTE7uso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGkGnd9d4PUxHZYnOGAAR9RSn9A/ybJOydbyW0/iEHIfzAmZkAaxVDR1w2mxezlEB
	 JWfIqnyt3tb8Nxn17msjhOfUzVvMAndqwMacPNal+idGAVu+HoKuZFFxEA3XcQ2Dhw
	 DWErnDCNLSkeEjON5cWx0/VC4Di7haRpfSLw5Gfk=
Date: Mon, 16 Mar 2026 16:01:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: lossin@kernel.org, aliceryhl@google.com, gary@garyguo.net,
	ojeda@kernel.org, theemathas@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] rust: pin-init: replace shadowed return
 token by" failed to apply to 6.19-stable tree
Message-ID: <2026031619-shone-storeroom-3ae3@gregkh>
References: <2026031601-outrage-unheard-916c@gregkh>
 <CANiq72=DogsD6Y7C5owQ8raQd7S9NEz2EBX5=11qTtn+BSE31A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=DogsD6Y7C5owQ8raQd7S9NEz2EBX5=11qTtn+BSE31A@mail.gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225572-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[linuxfoundation.org:query timed out,gregkh:query timed out];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,garyguo.net,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 538E129BEBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 03:38:39PM +0100, Miguel Ojeda wrote:
> On Mon, Mar 16, 2026 at 3:34 PM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.19-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x fdbaa9d2b78e0da9e1aeb303bbdc3adfe6d8e749
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031601-outrage-unheard-916c@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..
> 
> This one and the other pin-init ones just sent were expected -- we
> will need a custom version, but we added Cc: stable@ to get the
> notification (if you prefer we avoid that, please let us know!):
> 
>   https://lore.kernel.org/all/CANiq72kk5_wzA9izJ3YPWUcQGiEUQmCif+iqFfwK9b_5mq145g@mail.gmail.com/

Nope, that's fine with me, treat our scripts as a trigger to backport
stuff :)


