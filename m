Return-Path: <stable+bounces-226109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDLnGBB2uWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:41:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6547D2AD322
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50820300253C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38BD3E51CC;
	Tue, 17 Mar 2026 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J97z4Izl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F63ECBC7;
	Tue, 17 Mar 2026 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762030; cv=none; b=hGa/hMFZ2ArqUi86tAkSHP34qfTJoAtrT+XJ8yIBiUglUOjJj+hIirUFmOUwGizF3d1NCmAwVhHGuqIJbj1JVqrwpaMp/SW3JIET3fiOE+YtfXUE1pEoUWvM/AUTZ082VAChiBvYM4M5asnZCGzTLhnlW5tGfhObr2FLE37I1Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762030; c=relaxed/simple;
	bh=BfaTriaSJ29MVQqp85gTBqfNh1IyY82NUXnhV6iiVc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yc6Qgbc43RfTBM0dm5lhm6OX+cLXgXQcK4Voq6ZT7AZJmez6t24N7lGP7si+GAKNiiELoEND5dtUq6BL5Cu3gfGrziuWRepkDHYBvS/vXhdssbwXIPzvIEsODjUw0lJu4HX/nw0ZI4+SAjNdEkTXHa/c5ryJyGRp6+DQR3RTne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J97z4Izl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7683C4CEF7;
	Tue, 17 Mar 2026 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773762030;
	bh=BfaTriaSJ29MVQqp85gTBqfNh1IyY82NUXnhV6iiVc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J97z4IzliuhNK/eTc2HVLuQfiAy8nOseVESl7NG9YuP9kiwQ0mmLF4dI03zWAY3rv
	 HjKWAGBPFxHSBx1PF4Mtit/holR50ksVi43krc7iz5/oyLPLRYCXm0XhwbB2zwPwa6
	 V9XRbucKMJd48/8XZkM1deGt3zBSv7HxubPHLsqo=
Date: Tue, 17 Mar 2026 16:39:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
	jakub.staniszewski@linux.intel.com, pmenzel@molgen.mpg.de,
	przemyslaw.kitszel@intel.com, sx.rinitha@intel.com
Subject: Re: Patch "ice: fix retry for AQ command 0x06EE" has been added to
 the 5.15-stable tree
Message-ID: <2026031723-graceful-chaos-9ca2@gregkh>
References: <2026031705-nimbly-relatable-1e23@gregkh>
 <c0b7e32a-b46a-4376-a3f6-f01ccfd85622@linux.intel.com>
 <225eb7e2-c470-4307-90d5-0b56a35c4543@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <225eb7e2-c470-4307-90d5-0b56a35c4543@linux.intel.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-226109-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 6547D2AD322
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 04:24:15PM +0100, Dawid Osuchowski wrote:
> On 2026-03-17 4:14 PM, Dawid Osuchowski wrote:
> > On 2026-03-17 1:11 PM, gregkh@linuxfoundation.org wrote:
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > > 
> > 
> > Hey stable maintainers!
> > 
> > This patch **depends heavily** on the change "ice: reintroduce retry
> > mechanism for indirect AQ" which failed to apply for 5.15-stable and
> > 6.1-stable trees.
> > 
> > Until I can try to resolve the conflicts and resend, it might be
> > necessary to pull this change from the 5.15-stable and 6.1-stable trees
> > immediately as it will result in multiple WARN messages being printed
> > into the dmesg upon issuing 'ethtool -m' on a interface under the 'ice'
> > driver control.
> 
> !!! FALSE ALARM - ABORT !!!
> 
> I'm sorry, a bit of a chaotic day here at work...
> 
> I was worried the lack of the "ice: reintroduce retry mechanism for indirect
> AQ" patch will result in issues for users. It will not, as my colleague
> Jakub Staniszewski politely informed me that the 5.15-stable and 6.1-stable
> doesn't have the code from Michal Schmidt that we "reverted" using "ice:
> reintroduce retry mechanism for indirect AQ". No warnings will be printed to
> dmesg and everything should work correctly...
> 
> Once again I am very sorry

No worries, I'd much rather people warn us and then say "nope, we were
wrong" instead of not saying anything if they think there might be a
problem.  So all is good here, thanks!

greg k-h

