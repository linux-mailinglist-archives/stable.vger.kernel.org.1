Return-Path: <stable+bounces-247297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM+VCeNcBmrTjAIAu9opvQ
	(envelope-from <stable+bounces-247297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 01:38:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B59547CC2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 01:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D9B53026A90
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 23:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911F0399364;
	Thu, 14 May 2026 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB2fBhYZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311E26FA7A;
	Thu, 14 May 2026 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778801884; cv=none; b=DUzSsFbpHOxLt11dK19G2x+hJmdtTuG1JHFtw1mil1h7SdoHQN25DJmU2YJGhpcSbOdTzpWGSAPGk3I+vc3VqSO6g9h7YlzB6GaDFIda8bC/jM30UCSkaPLpOQJBDTSVFv8lGpMGUntJJ4LdOuM6CW8qJhtWnd5PH89kBI8p+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778801884; c=relaxed/simple;
	bh=o5LnbVLbHp6X7yEJwBPrx6jvJSS9LiXpZGfvuzKwsqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHW6DorFLagrtJN843rDJdplUIz+yZcykbH6+kNWW/1aOJQqE9bZYn52IRgTHYEEEJ8QP5L5ZSVEo5MQSxsJ39CV8/e4C9V9gCtcab0aA/SWtCwcoBKhvm/Q7p6cMEizW8xHdJ3j6QaRBQflWKtR2PxIVqTMgDRaaEinKq0uATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB2fBhYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E752C2BCB3;
	Thu, 14 May 2026 23:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778801883;
	bh=o5LnbVLbHp6X7yEJwBPrx6jvJSS9LiXpZGfvuzKwsqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kB2fBhYZyr6RiCsknHizzeP4aEAC5mbk6EK8HUMIQLZM8ewxVeIhE6YXtia0AeQ5A
	 bVFjqUD0mbgEsj587G3yIYX2fRYIYYoXeH4YpAbaZgnAAgZA4+yACDD1j8C2RGWjbh
	 FqlTk8mV6pzTmIjlfEoBd3+fDpI39SCrX4WLloVeaViHUZHGF0Jta3TDqpTFcnhVEx
	 SzzWOGNDasxyjNBBoyI4SimHe9OI2H/649lutJiyVd7lxQkydwQ9NFblmyZbV3Dg9e
	 r+24lHZ5yzgKVN5Qs0ITsG+PYTfduoXei4BNqrSrQyL5tNW5Nl1I3U3XpSdo4bLh/s
	 LX/q0C8PZPYGA==
Date: Thu, 14 May 2026 16:38:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: David Ahern <dsahern@kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, steffen.klassert@secunet.com,
 netdev@vger.kernel.org, stable@vger.kernel.org, mhal@rbox.co,
 davem@davemloft.net, horms@kernel.org, edumazet@google.com,
 kerneljasonxing@gmail.com, herbert@gondor.apana.org.au, vakzz@zellic.io,
 kuniyu@google.com, jiayuan.chen@linux.dev, ben@decadent.org.uk
Subject: Re: [PATCH net v2] net: skbuff: propagate shared-frag marker
 through frag-transfer helpers
Message-ID: <20260514163802.1d49d7cb@kernel.org>
In-Reply-To: <agXuKbQMVTYT5Jgb@krikkit>
References: <agToIEDI4TaTNLRb@v4bel>
	<92ec6190-0255-4b7c-9524-254cb37476ab@redhat.com>
	<agWYGuJ__OtpgjnB@v4bel>
	<agWiDlvu351MSuqO@krikkit>
	<69f72d09-8054-4d26-b277-9e9b7a8854c1@kernel.org>
	<agXuKbQMVTYT5Jgb@krikkit>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C7B59547CC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com,secunet.com,vger.kernel.org,rbox.co,davemloft.net,google.com,gondor.apana.org.au,zellic.io,linux.dev,decadent.org.uk];
	TAGGED_FROM(0.00)[bounces-247297-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 14 May 2026 17:45:45 +0200 Sabrina Dubroca wrote:
> 2026-05-14, 08:37:19 -0600, David Ahern wrote:
> > On 5/14/26 4:21 AM, Sabrina Dubroca wrote:  
> > > It would close this group of vulnerabilities, but there are other
> > > parts of the networking stack that consume this flag. For those,
> > > chasing missing flag propagation is still a useful task.
> > >   
> > 
> > Seems like this should be an skb helper to manage the flag with really
> > good documentation on when it needs to be set, reset and propagated.
> > 
> > I walked skbuff.c yesterday as well, and there are several places where
> > it is not clear if the flag needs to be propagated or not.  
> 
> Or maybe even something like a skb_transfer_frag that handles updating
> the frags array and copying the flag. Then we wouldn't have to chase
> functions that mess with frags[] directly and forget to also adjust
> flags.

FWIW IMHO I'm not sure this flag is worth the effort. Most of the code,
IIUC, needs to look at it for crypto. And for crypto it's cleaner to
allocate fresh pages for the output. That way the code has the same
perf whether frags were indeed shared or not. Vide tls. And non-perf
sensitive code can always cow frags.

