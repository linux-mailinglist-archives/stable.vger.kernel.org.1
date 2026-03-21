Return-Path: <stable+bounces-227712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGOXFQo5vmlQJwMAu9opvQ
	(envelope-from <stable+bounces-227712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:22:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 295BB2E3A27
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A91B13038153
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7B36DA1A;
	Sat, 21 Mar 2026 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CT2RiAOS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553336074D
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774073961; cv=none; b=W7XxzMFwFJK1KxaAzixZMbgVO5bkY0ANT3d4etJBYeq8ypc1OXMnHu6Yx6OjzLxc5M0Bp7tviS66U8nijYH+Z08ffZ/Cl5e+vCWiiMii6Z+XW7E8K60YZEWsEMVuNYM/+nhNZqNEdM+F6JGGA/M7TcvCgICT3QLmxqQPszzCxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774073961; c=relaxed/simple;
	bh=X71ADP0/DusaTMDtog/eJbWmX8FOQ7pzH3Y1fE638is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlYlO4dZanCcU5M+dcSNE1b8p/HTySYMIutgTwj2H72wjdo+BPH04Fb7DveRs19X1uBSxvojG04X9PMb5ucKOqy6xWvqIGTEwctmYAt7tVZIpzy6UPr4C8gempqAl5ImzWvyqDOVCliaM9Mb55762OAehOXcsjCrI52Oul7X280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CT2RiAOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F41C2BCB0;
	Sat, 21 Mar 2026 06:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774073961;
	bh=X71ADP0/DusaTMDtog/eJbWmX8FOQ7pzH3Y1fE638is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CT2RiAOSC1f2tKTTEbInrvh2Gh5+KjJaregrQXSERxCGYzTqWXzFcl4B/tqPlMAQA
	 MJJlIWGh/QsSoQAs1jWRUvO1ZoGwOLQ1UxFUDfyrxVH/pWxcDhBN08376DUtz6c3Ot
	 pKMD416Vij238Tb1nd3gwEFxKXOCZ1lUkr3oyG8w=
Date: Sat, 21 Mar 2026 07:11:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: francis@malagauche.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: fix multishot recv missing
 EOF on wakeup race" failed to apply to 6.1-stable tree
Message-ID: <2026032137-unstuffed-opium-cfa6@gregkh>
References: <2026032057-septic-boogeyman-daef@gregkh>
 <376a35ee-6a9d-47ef-b4f2-d1e6af5f830d@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <376a35ee-6a9d-47ef-b4f2-d1e6af5f830d@kernel.dk>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227712-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 295BB2E3A27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:10:43PM -0600, Jens Axboe wrote:
> On 3/20/26 11:33 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Since this only triggers after the AF_UNIX inq addition in 6.17,
> we can drop it for 6.1/6/12. I should've done a better job with
> the Fixes tag.

Not a problem, thanks for letting us know for this, and the other FAILED
patch.

greg k-h

