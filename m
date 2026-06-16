Return-Path: <stable+bounces-263650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oT8KJtkcMWolbwUAu9opvQ
	(envelope-from <stable+bounces-263650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 11:52:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2750E68DB9B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 11:52:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=IS9er9Zy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263650-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263650-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1334F3019017
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2634423A67;
	Tue, 16 Jun 2026 09:51:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220A4218A3
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 09:51:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603510; cv=none; b=CRrObJfGkzrYLBGWv1Mv99dCQOXMS7jfooYP6X4e1tdkN45ZwrfW2pHmrLMLvaEYzB+ZuCs9iCb/DuS2l36chtfGc9XLUugoKO8qqjdU/3qNUzgXatBGjrKd8g62ME0diJ6+bXe+5vctE7k2UyIb9mA2NYjMkdFg/GhV9rSIJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603510; c=relaxed/simple;
	bh=4QJiPHhQcMVIgoWrGQcv7JcIHUWB0PJwmlzg53rbZnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP3a6oqwoYjWd/wFDHlt/QVP40EOF5OxhzJOKNjwPr+UPOTD0VbOt+/SnJ+Qdg+1MD0kE/UDGQeX3qwBLOYPf2hFczuZALVtHQC6gCuxBcQMdgFg1yxLg5yKwi29ode+nqSy27S+ldiac4f3dT7hobbu0gumGTCAE7N7fNro37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IS9er9Zy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AC01F00ADF;
	Tue, 16 Jun 2026 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781603509;
	bh=tnPXwz8Ljl+BTZQqNNRCKO7wyV6CLmiC3uhVOmPGa5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IS9er9Zyzzja3pNL6479/n91Kfbrlv3GEao8x87CZ/kwMX315D/3NAjgQ6Q96E4Ec
	 LtQkYBalW4ZMC3+yMoSRTFMhk/w5GNh5CgPfT8busqSdleInsbtCN4IZcwZ4OXrTM9
	 8Dccd/xjnadhwjlUuYAKwhwZMvsmnB/vybX5//PA=
Date: Tue, 16 Jun 2026 15:20:42 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Waiman Long <longman@redhat.com>
Cc: bigeasy@linutronix.de, tglx@kernel.org, tglx@linutronix.de,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] debugobjects: Don't call fill_pool() in
 early boot hardirq" failed to apply to 7.0-stable tree
Message-ID: <2026061622-manager-quarrel-8346@gregkh>
References: <2026061558-amiable-showman-7ea7@gregkh>
 <1ba5a885-ac2b-46e2-b18f-f5b3e02e8094@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba5a885-ac2b-46e2-b18f-f5b3e02e8094@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:bigeasy@linutronix.de,m:tglx@kernel.org,m:tglx@linutronix.de,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263650-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2750E68DB9B

On Mon, Jun 15, 2026 at 04:03:09PM -0400, Waiman Long wrote:
> 
> On 6/15/26 10:31 AM, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 7.0-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 0d046ae106255cba5eb83b23f78ee93f3620247d
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061558-amiable-showman-7ea7@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> 
> Commit 0d046ae10625 ("debugobjects: Don't call fill_pool() in early boot
> hardirq context") has dependency on commit 5f41161059fd ("debugobjects: Do
> not fill_pool() if pi_blocked_on") as they both modify
> debug_objects_fill_pool(). So commit 5f41161059fd has to be applied before
> commit 0d046ae10625 to avoid a merge conflict. Since both are fix commits, I
> supposed they should both be applied to v7.0.y in the right order. Similarly
> for the other stable branches.

That only worked for 7.0.y, which I've done, but it fails to apply to
all older trees.

thanks,

greg k-h

