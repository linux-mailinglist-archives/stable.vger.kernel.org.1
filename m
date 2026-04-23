Return-Path: <stable+bounces-240426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ALxBYvA6WkXjQIAu9opvQ
	(envelope-from <stable+bounces-240426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 08:47:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3969344DB68
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 08:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C909F302158D
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C823C8C7;
	Thu, 23 Apr 2026 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ieYOSEhJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB53CAE6C
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926819; cv=none; b=CDondmRu60ZuxsPBUEWkjJ5AwFwUQ2uKPlUbSE6+H81YllUegdGelKxxGRWI/qzk/26iEzWTI+kjBKh8EN21DB0uF58qIbLTP229LD29Kg/88jlX4O8OxPsabNcvZBiTgxNYxJ8PIRxzhTEnSC/mgqkRv0uVxGrXyxTq5XguQq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926819; c=relaxed/simple;
	bh=e1vZ+R1zyrLsWOo6YrVqrPJ/JLHb7qVFyVDpKkB0Sg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udUvoctAqfQS4M0B9Js40tHEGnq1DFxNKUgv96ijC4oLwTyckAy5vzjjb+9vblj3fKqtuoY8t3Gg1kQP9lV+bS7oUZn7gicec3f4vCplOiwjifhJANZ2vCw7YraUJj0muplfIcxhMofptVJPKkstnBDQ2fifxZaWj4yOEc4mfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ieYOSEhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57EAC2BCAF;
	Thu, 23 Apr 2026 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776926819;
	bh=e1vZ+R1zyrLsWOo6YrVqrPJ/JLHb7qVFyVDpKkB0Sg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieYOSEhJeJx/nONok/NRKZFWuQnnBcbLfBibbDK+clokrxM12eQUF1UNX2kwPXpyb
	 r4vJ6egrihLYjUXLTzcBMY8/1tBh8zIyjfqESQORToH8qAifDVJPSadcxv031eA56y
	 yP43x9gxEBiL2lgzvK7qziJ8TWDEqDz8rPWOv+/w=
Date: Thu, 23 Apr 2026 08:46:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Josh Law <joshlaw48@gmail.com>, stable@vger.kernel.org
Subject: Re: Backport request
Message-ID: <2026042320-husband-brought-c7c7@gregkh>
References: <C9577A36-B531-4480-BEA5-42F660C184CA@gmail.com>
 <2026042325-backhand-vanish-f69d@gregkh>
 <fc6ea52a-320a-4821-972c-3376e687fecf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc6ea52a-320a-4821-972c-3376e687fecf@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240426-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3969344DB68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 08:39:29AM +0200, Krzysztof Kozlowski wrote:
> On 23/04/2026 06:55, Greg KH wrote:
> > On Wed, Apr 22, 2026 at 06:04:50PM +0100, Josh Law wrote:
> >> Hello, I would like backports for 
> >>
> >> Mainline hashes:
> >>
> >> https://github.com/torvalds/linux/commit/8cdf30813ea8ce881cecc08664144416dbdb3e16
> >>
> >> https://github.com/torvalds/linux/commit/9003ec6f7f394943880618737d797a9f257e6e1e
> > 
> > None of those have showed up in an actual release yet, so why should
> > they be included "early"?
> 
> None of the code was tested as Josh Law lied more than once about tests
> [1] or laughed at us when we asked for testing:
> 
> "laugh my ass out and your test cases, absolutely ill add some test
> cases" [2]
> 
> and then Josh Law was pushing his patches to get merged:
> 
> "This most definitely needs to be merged." [3]
> "Yeah in my opinion I think this may need to be merged.. if you would
> like I can add the NOWARN" [4]
> 
> And now we see a push for these commits to stable!
> 
> Nothing from Josh Law should be going to stable trees, because nothing
> was ever tested.

Makes sense, is anyone going to send reverts for these?

I'll drop them from my "to review" stable queues, that includes the
following:

	 mm/damon/sysfs: check contexts->nr in repeat_call_fn
	 mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
	 mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
	 lib/ts_bm: fix integer overflow in pattern length calculation
	 lib/ts_kmp: fix integer overflow in pattern length calculation

thanks,

greg k-h

