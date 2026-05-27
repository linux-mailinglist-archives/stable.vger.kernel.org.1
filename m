Return-Path: <stable+bounces-254692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBkMDvJ7F2qqGggAu9opvQ
	(envelope-from <stable+bounces-254692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 01:19:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E075EAE3D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 01:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF4DD3065F38
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 23:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0173CCFA8;
	Wed, 27 May 2026 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJ3XS4BG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF843C8729;
	Wed, 27 May 2026 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923932; cv=none; b=tl2zVplBQ9kXJVphdO/N3qozVojYgVAaWwGbgZQDneyUnqF9T5yX4qON1kA6UkC3zxAuvDXGnn5S7dCiQS/Q10wxifhBd3f1h00kaxHoS75LsjkncCHdbi4ANRMrRQd/uY4cWUsIPLYmtr49XRtF7U1E3CvXlppf4F/IRm9sDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923932; c=relaxed/simple;
	bh=XYYLIkMdUjyt8VZh1T4Ts2Zkw0+goRDp5iOhBj3vL88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcO4h739l3xEypM/VjyK4UKjo4ydB/xZeSoRO8W/7igFIhFC9pDTVmM5Sd1Z+9y/oNU4ivU9vlj9dxQN2Qe/sIhGjhnH3VXZS5d8JEDX/HLKn1+UITv8pV8CqwTPP+zm6lUhV3P1qQbUx55+/IgYE9EKecDbjbjg1BEkdTt/Lr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJ3XS4BG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C36F1F000E9;
	Wed, 27 May 2026 23:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779923930;
	bh=gY/uWptPNlFRUA8uDIAujD0ayLukvJN5W3pkFRqPqWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JJ3XS4BGxKlbtH60vsC6yyppzSpldkdBEd9l0v/VrqkC1kAR8gVsM2Sy+ScmVBFS6
	 GMC5ZKXFQg9vec01JGBXpwBD+a1ZmzlkUX8cSXrGePmqKU3aQVOw4CL5eN+D5mHva3
	 U/EOe3F8Hl4vPTRMw7U3FxTXi7wd3g8PzQJipiQFV3O/OHXnlUyTcp+XhMQ/+uQ0+0
	 v05voTtrQJ9BicmTChr35m2XlHfJNVsFESQuKOqTOQDxf1N4nAiA8Kyol6NYpNyyV2
	 8iEai48aknM0b5WDlcZgqqsOMzHrGF/gheECEfsQBgJOeb+Cu6/kizsi8AlK3gYv+A
	 tuQ9e8hV5crKw==
Date: Wed, 27 May 2026 16:18:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jan Vaclav
 <jvaclav@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Taehee Yoo
 <ap420073@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] hsr: broadcast netlink notifications in the
 device's net namespace
Message-ID: <20260527161849.738b7f1f@kernel.org>
In-Reply-To: <21df0b14-f530-4e9a-931a-21154ec18c78@suse.de>
References: <CAHPEe=GO=2qqWZPwBB4rrXc3mkD0dznp2K78nCsKwF=c-QwxEw@mail.gmail.com>
	<20260527075924.2707856-1-maoyixie.tju@gmail.com>
	<21df0b14-f530-4e9a-931a-21154ec18c78@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254692-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 16E075EAE3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 13:11:57 +0200 Fernando Fernandez Mancera wrote:
> >   	genlmsg_end(skb, msg_head);
> > -	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
> > +	genlmsg_multicast_netns(&hsr_genl_family, dev_net(master->dev),
> > +				skb, 0, 0, GFP_ATOMIC);
> > +	rcu_read_unlock();
> >     
> 
> The patch makes sense to me. Anyway, I think we can reduce the RCU 
> critical section here.
> 
> What about moving rcu_read_unlock() after the if and extract the net 
> before unlocking? The benefit is minimal but I think it is worth it.

Not sure TBH, we'd need to take a ref on the netns and allocate 
a tracker (on DEBUG kernels). One could go either way.

I'm replying because I wanted to question whether this is Fixes+stable@ 
worthy. Sending the notifications to the namespace where the device is
makes sense. But it's as much a behavior changes as it is a fix.
The commit in question was merged to 5.6, real users clearly don't care.

