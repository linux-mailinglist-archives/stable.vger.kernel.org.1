Return-Path: <stable+bounces-223508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O7eG+13rmlwFAIAu9opvQ
	(envelope-from <stable+bounces-223508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 08:34:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1718E234D56
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 08:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D5DC3006122
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 07:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC1932AAD1;
	Mon,  9 Mar 2026 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S6tVM0FA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962EC1474CC;
	Mon,  9 Mar 2026 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041640; cv=none; b=uA5Qh5PFSfNyEChpuPMBQWvcJmSiv3AIntloQV4tVFDprJIyr+n24EuAfbaf6iA5y5p5U5496DPT4yy7eogKLNYt3lcl7/1JFD+r2nl2MXfUbBB5qzGlVXpSwVdDzEVizrIElTDNipVtpNNsTTjzVQO2uV3c+7arQa2C0odVLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041640; c=relaxed/simple;
	bh=rlCyKwXcQJicATG0ejS+Bw9m63m1OiUw1+YSAgoy528=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDzWLMd9JCKGZMPkmZPLy6ZiOwRFTi9ZmaWmREdgAD5RQZtFO1V5Sfa1cunXWgUbxxB89u0kR4PyDVRDfiSr2/8eTFgImh6F+vyouQWiDcH3AbQsB+eYQILQWagJTS4PXx+WxC4LHVQ1WkFV1H3suZzzgi993+Cy/lHJfFzCa6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S6tVM0FA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B27C4CEF7;
	Mon,  9 Mar 2026 07:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773041639;
	bh=rlCyKwXcQJicATG0ejS+Bw9m63m1OiUw1+YSAgoy528=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6tVM0FAGduASaFRkvLCgQGudpMgIcxKkj0lFRGo1fPJBlifPPs7d/CHDiaA3pEe/
	 qmhhURdhGnDCfkEGSQntumjgIhj/7ccbXuyVutjQW/9VYNPUgHlkVoVR4cx3R4P5MM
	 hbL6lD2WvnT5w8q71vEOpO4gu/L+3m6yBw3k5+g4=
Date: Mon, 9 Mar 2026 08:33:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	stable-commits@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: Patch "driver core: enforce device_lock for
 driver_match_device()" has been added to the 6.1-stable tree
Message-ID: <2026030939-replace-refining-8b4f@gregkh>
References: <20260308164617.27847-1-sashal@kernel.org>
 <CALbr=LYLwyqdkOY08f1VGZbW-Zrfns1kprUjvCUNcqYrMVoCZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALbr=LYLwyqdkOY08f1VGZbW-Zrfns1kprUjvCUNcqYrMVoCZQ@mail.gmail.com>
X-Rspamd-Queue-Id: 1718E234D56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223508-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.353];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:44:54AM +0800, Gui-Dong Han wrote:
> On Mon, Mar 9, 2026 at 12:46 AM Sasha Levin <sashal@kernel.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     driver core: enforce device_lock for driver_match_device()
> >
> > to the 6.1-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      driver-core-enforce-device_lock-for-driver_match_dev.patch
> > and it can be found in the queue-6.1 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Hi Sasha,
> 
> Please drop this patch from 6.1 and all other stable queues.
> 
> This commit was reverted upstream. Enforcing the device_lock here
> introduced side effects [1]. We are currently developing a new
> approach to fix the original issue [2].
> 
> Thanks.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9de68394a615
> [2] https://lore.kernel.org/driver-core/20260303115720.48783-1-dakr@kernel.org/

Now dropped from everywhere, thanks for catching this again.

greg k-h

