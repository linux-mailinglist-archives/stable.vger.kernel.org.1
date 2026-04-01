Return-Path: <stable+bounces-232773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I5tAA8WzWmMZwYAu9opvQ
	(envelope-from <stable+bounces-232773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:56:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 462CB37AD2E
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FA873305663
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC38B40FD80;
	Wed,  1 Apr 2026 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f56YiQEt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9640F8C2;
	Wed,  1 Apr 2026 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046777; cv=none; b=uokVaN0ow0GWtQF1TRF9OBhVWd85zZCZBd/eb/ZidICC6g23CoAS7mFfKeE/6jvUikZ3e4NvIP5rB1B5IGX6uT33nZTvplPbOCjuW5yph1PK6OxpGInK4HHcQc+AY+UmxkcTrJZy1QfVPyzlqCSiIKVjki+EGm4FdYJgl0pFbEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046777; c=relaxed/simple;
	bh=e6OQ1yaiHIlWDY9J0lFKFzg0tlTsiGuriYAhK5xvHU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Moj2Nh5FEZ9hSnofZmnaoIXBpOg9N9prMR7R8IoW6l/zz7anAQh77L8cAgNP5G3SPCni3v0x3dDQncLo+guK+Z2qd/qkwppxubDR6FQchoCyIXKdN//QNmnD7ZKprQBxpH+pfaqyi4UtmG2TubGm0enh8guzUj7IvYqfq8Bk7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f56YiQEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB4AC116C6;
	Wed,  1 Apr 2026 12:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775046777;
	bh=e6OQ1yaiHIlWDY9J0lFKFzg0tlTsiGuriYAhK5xvHU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f56YiQEtlF/u0oMy5gdGFlBznC7vMPPw4Pm6Qj5HGnJuxM7Kjk6NoCkeYMiXbqOoa
	 UMkRcFBQeleBg7y5jAs4aCU0jwJ7bRrhRTsmoGX9IXCQNX+OKOxLRXMChRvVIc6yZD
	 9aGbgy4fKaFsXslHa+R+rOUstRbCFiSOlKTJMeT8=
Date: Wed, 1 Apr 2026 14:32:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: hkbinbin <hkbinbinbin@gmail.com>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org, i@zenithal.me,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usbip: vhci: validate ret_submit number_of_packets
Message-ID: <2026040100-brewing-ethics-990c@gregkh>
References: <20260401120857.1443552-1-hkbinbinbin@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401120857.1443552-1-hkbinbinbin@gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232773-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,zenithal.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.039];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 462CB37AD2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 12:08:57PM +0000, hkbinbin wrote:
> vhci_recv_ret_submit() unpacks USBIP_RET_SUBMIT directly into the URB,
> including number_of_packets from the remote server. For isochronous
> URBs, iso_frame_desc[] was allocated using the original locally
> submitted number_of_packets.
> 
> If a malicious or buggy USB/IP server returns a larger
> number_of_packets, usbip_recv_iso() will iterate past the end of
> urb->iso_frame_desc[] and write attacker-controlled ISO descriptors out
> of bounds. Later completion paths may also walk past iso_frame_desc[]
> if the poisoned number_of_packets is left in the URB after rejecting
> the response.
> 
> Fix this by saving the original packet count before unpacking the PDU,
> rejecting larger values from the server, restoring the original count
> on error, and marking the connection as broken.
> 
> Fixes: 1325f85fa49f ("staging: usbip: bugfix add number of packets for isochronous frames")
> Cc: stable@vger.kernel.org
> Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>

We need a "real name" here please.

Also, this really looks like the same patch sent here:
	https://lore.kernel.org/r/20260329125437.517980-2-sebasjosue84@gmail.com

Is everyone forgetting to disclose that they are using AI tools to
generate these things?

thanks,

greg k-h

