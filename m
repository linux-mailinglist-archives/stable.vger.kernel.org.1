Return-Path: <stable+bounces-242342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOvHHI2S9Gm7CQIAu9opvQ
	(envelope-from <stable+bounces-242342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:46:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F04AC1CE
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77AF43008693
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553752D5408;
	Fri,  1 May 2026 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WZajc3k5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182249443
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777635976; cv=none; b=OCtmZJebnp1Yput9AkbHtc6qt/HCw1DxtzFXk1RxMgvmKB0mSKpdn1JshmguW8s/nshtgUPEyrlxUpVdF2ifYJsmOp1Qan07VSyeCwRBAMwj9ZidtAtGenILoEzqdPMDvJrZTGoouqMwUUXf/qhN79Dz2prGWxOyVT7zZCfLzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777635976; c=relaxed/simple;
	bh=9WEiHF2paShYoNbttWoafFyGomkumKcjzHSpIfvojJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY2apALifHTtqXc5iLeIRnXV6vlTs0jcT8Fnx66CJzVHIf0TLkanhkYT5XnnTtZa9WPBMj5uBayrWhlaIYYH5zeNHPCHBhk81lKCYAU6rge72dtdxOrhsh6l9ut9Js1ckRnvjYdkY7lHHyqMCxy+L3fEQxVpsMKsHWk5JKqv5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WZajc3k5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E97DC2BCB4;
	Fri,  1 May 2026 11:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777635975;
	bh=9WEiHF2paShYoNbttWoafFyGomkumKcjzHSpIfvojJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZajc3k5X9HmnZGcaA0jg10GNqYH/woMfCrbdaSgkRlAN7/x6ZPeE38jQCK9/yHK2
	 m41Z2/xeuuLyTvc8Zt8JKXRxfZ94oO4myWbbEFzY+nKrIwgSO6Cd5Lyoi7QC+135S2
	 Y4jkGrKhoEGKIWi6IwygxsD0j2HoJ+SFYlvQHK84=
Date: Fri, 1 May 2026 13:46:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: krisman@suse.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/register: fix ring resizing with
 mixed/large" failed to apply to 6.18-stable tree
Message-ID: <2026050106-apache-oncoming-03a0@gregkh>
References: <2026050117-strenuous-scrunch-c2ce@gregkh>
 <8630d4bc-119c-46dd-a39f-d699e1b830be@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8630d4bc-119c-46dd-a39f-d699e1b830be@kernel.dk>
X-Rspamd-Queue-Id: 692F04AC1CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242342-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,gregkh:email]

On Fri, May 01, 2026 at 05:10:00AM -0600, Jens Axboe wrote:
> On 5/1/26 5:08 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.18-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 45cd95763e198d74d369ede43aef0b1955b8dea4
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050117-strenuous-scrunch-c2ce@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..
> 
> Here's a backport for 6.18-stable.

Now applied, thanks!

greg k-h

