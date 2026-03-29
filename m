Return-Path: <stable+bounces-230919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHibDmgoyWmxvQUAu9opvQ
	(envelope-from <stable+bounces-230919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:26:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E163523BD
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65FF2300F1AC
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F255D371877;
	Sun, 29 Mar 2026 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W1zpxXKP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE631F98C
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790756; cv=none; b=hzZw79SV36ztstfHHFUlzjEpxVi0Jw9F3grHDuEIp4921beitUgtWwesylP598UWiRjdNJAHqeGAdBDdU+b3b/V1e2h9536dE1OFs0VysS4gBZPcVcu3+uJhCR9sNpThDLx9XWtdfzInfY0oO7+E46K9wsiGhIaqssqQNkZnJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790756; c=relaxed/simple;
	bh=nfmIB7Ydsg7mpbMLsnx0oFBNOSOZlyf/0UHJQhidLeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZcfGrTqvu2s3K0qg7DGjRgSr/JNZZu6BihF00HpCP2xt1mTCWqiNLgzMztY3FsCKSKUpLnBywVovl2dnI2qhLK3/gkMP6mkgYDlgMH1mF3srMB/FjQgGZF3Oa2x0LnI/fj444HPTH87ICtoyJkeSz2yBZXjiHdkBYj5wwZT0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W1zpxXKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29317C116C6;
	Sun, 29 Mar 2026 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790756;
	bh=nfmIB7Ydsg7mpbMLsnx0oFBNOSOZlyf/0UHJQhidLeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1zpxXKP80QmsZw4UYTZKAoso8LDuvD5TNSTGSzbkDch7ENDZdjFG5UQP0ya23pTr
	 /xJzr9Aee4+crK5JFzcrEGZDKkVSTv4O8wCb4+Nl7+Z0gBzP3BLLp5mL+IrhM1bt9l
	 NpSjagORG+1DdvUdwM0tg+zejvnbauJlHKVlQ2bE=
Date: Sun, 29 Mar 2026 15:24:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Cc: security@kernel.org, shuah@kernel.org, stable@vger.kernel.org
Subject: Re: [SECURITY] usbip: vhci: heap buffer overflow via crafted
 number_of_packets in RET_SUBMIT
Message-ID: <2026032939-salt-cod-3bc2@gregkh>
References: <20260329125437.517980-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329125437.517980-1-sebasjosue84@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230919-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A9E163523BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 06:53:32AM -0600, Sebastian Josue Alba Vives wrote:
> A malicious USB/IP server can send a RET_SUBMIT response with
> number_of_packets larger than the original URB allocation, causing
> usbip_recv_iso() and usbip_pad_iso() to write beyond
> urb->iso_frame_desc[], overflowing the kernel heap.

Ok, this is just getting funny now...

What is the AI prompt that you all are using to "find" these usbip
"security bugs"?  This is like the 3rd or 4th "report" of this in the
past week or so.

Anyway, as always, the usbip connection is considered "trusted", never
connect to a usbip device you do not trust (on either side), and patches
for this where invalid packets are sent are always appreciated.

Note, patches for this have been sent on the linux-usb mailing list in
the past few days, so you might want to have checked there first to be
sure you didn't create the same thing that others have already
submitted.

thanks,

greg k-h

