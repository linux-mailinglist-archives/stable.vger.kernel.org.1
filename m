Return-Path: <stable+bounces-233262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHeQGLyu0Gmy+wYAu9opvQ
	(envelope-from <stable+bounces-233262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 08:25:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6F639A1E7
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 08:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7B7E301410A
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 06:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704DA372EF5;
	Sat,  4 Apr 2026 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="obDr7y5D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8C35A388
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775283890; cv=none; b=gy+jhWhZQZRlU9Xp+si3I5mEbsIwVCJRMbst04lmtql3y6MHuD3fjVx5xObfWZLSqGCVEp3/8mHC6xPt4dfh1E17cLlFtJVLyRgDeeLQMphrF1WceCgTDec9MZJKpLXXBiTSyO1UDf3GFT/jFfopanqmuBpuq1zK0Tk/XKb/OUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775283890; c=relaxed/simple;
	bh=69qbniI/yDPH9O8gmb5zEow+XJP7lfA+g1rRL0NMW24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtPCF+jkAutqAuBmBAc32Wc/+fC6GWv6lQQU38FHtBITahSCMRCeSERJh8gABFC4Dej85pcLRbQoPdhoCmR7x+3BSnM8gv+PcxcfQY7hBrlJLCTleyix1Gvfo/xQEWWj4fZ/rpVN0Pn710bJeR+CLld2EPhmfq1duzO9uajje5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=obDr7y5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693B6C19423;
	Sat,  4 Apr 2026 06:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775283889;
	bh=69qbniI/yDPH9O8gmb5zEow+XJP7lfA+g1rRL0NMW24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=obDr7y5D6wS1E/Tax8cgZ8qTmG9U0qG8Gfwmh4U/gSJyVPpsHkWCmzIaOG+ZrX4YS
	 n7k4HWBtcY0ojTKMWm2Va+eA9//JwphZZJKxgL+BpyTOmTSkrK1cqOLOwqt5BRC5Qb
	 Ikl5bwpVtrnE0VGCzG5fM4O/TyKoP/yJm9+Tv3nU=
Date: Sat, 4 Apr 2026 08:24:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brett Mastbergen <bmastbergen@ciq.com>
Cc: stable@vger.kernel.org, pmladek@suse.com
Subject: Re: Backport request for fda024fb64769e9d6b3916d013c78d6b189129f8 to
 stable/6.18.y
Message-ID: <2026040448-prideful-feast-eae5@gregkh>
References: <CAOBMUvhG4DQDiEarc_P132=a+zGN4hySrNPYigUf6qC2Kh9iqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBMUvhG4DQDiEarc_P132=a+zGN4hySrNPYigUf6qC2Kh9iqg@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233262-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B6F639A1E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:30:35PM -0400, Brett Mastbergen wrote:
> Please consider applying the following mainline commit to the 6.18.y
> stable tree:
> 
>  commit fda024fb64769e9d6b3916d013c78d6b189129f8
>  kallsyms: clean up modname and modbuildid initialization in
> kallsyms_lookup_buildid()
> 
> The patch applies cleanly to 6.18.21

What about 6.19.y?  You also need/want it there too, right?

thanks,

greg k-h

