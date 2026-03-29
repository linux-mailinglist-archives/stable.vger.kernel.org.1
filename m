Return-Path: <stable+bounces-230920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDssIYkoyWmxvQUAu9opvQ
	(envelope-from <stable+bounces-230920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:26:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F73523C4
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF91F3012260
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466DB35DA66;
	Sun, 29 Mar 2026 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xoqbOAPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B07131F98C
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790760; cv=none; b=MwG6tDmOG1SWJZPKEoQ1uLzzbntth92jNwKaD5qwRZld9Yw/AflvQfKrppWfNy91ajtqZbRK/zeGKxJsMUKvPwCu6qXWHsabv34ALGgX2e5kr0Jxmu97quA7k7QFQg89d9CMhLvXH28o5Dd+fVnDpzA0ffRI743ofnle2KF1Sis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790760; c=relaxed/simple;
	bh=z1rRFh6rBqDbc9QvHkUlLjYjsyOxxohrqor5OOhbpkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B08GrCJf2As9DRY126QRrTtld2W2KIb/zIlhe3pNygAnaa9LaW0u2/NkOqAqtoZLnAXe3J6P+91L4A0gnW0XANFD93FpnZVBKTCO4VxgzO01d3Nyothe8ZX0ngRkWLa5o9399kpxOBWNJ5H5CGz+B45vnP2pPupheqKz2vMbLSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xoqbOAPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BCAC116C6;
	Sun, 29 Mar 2026 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790759;
	bh=z1rRFh6rBqDbc9QvHkUlLjYjsyOxxohrqor5OOhbpkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xoqbOAPTC9txlaY3jTD9XUsiUtn6o603c7mBism9Ekdm8ZR7YXlGHpauqnDU462+u
	 iRFIMpjIiLXyvKCts9JKku44D2ZBoCBFIhG0pTRnr3tXUMD90FB77X4L6FTmuzFpMa
	 MIzTFXuaIAjsFnWYY85//c/2vk2XJET+M18BYviM=
Date: Sun, 29 Mar 2026 15:25:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Cc: security@kernel.org, shuah@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usbip: vhci: validate number_of_packets in RET_SUBMIT
 response
Message-ID: <2026032940-corny-cursive-c360@gregkh>
References: <20260329125437.517980-1-sebasjosue84@gmail.com>
 <20260329125437.517980-2-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260329125437.517980-2-sebasjosue84@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230920-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0C7F73523C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 06:53:33AM -0600, Sebastian Josue Alba Vives wrote:
> From: Sebastián Alba Vives <sebasjosue84@gmail.com>
> 
> vhci_recv_ret_submit() calls usbip_pack_pdu() which overwrites
> urb->number_of_packets with the value from the network PDU reply
> without any validation. A malicious USB/IP server can set
> number_of_packets to a value larger than the original URB allocation,
> causing usbip_recv_iso() and usbip_pad_iso() to access
> urb->iso_frame_desc[] entries beyond the allocated array.
> 
> This leads to a heap buffer overflow in kernel memory, reachable over
> the network without authentication.
> 
> The attack chain is:
>   1. Client sends isochronous URB with number_of_packets = N
>   2. Server replies with number_of_packets = N' >> N
>   3. usbip_pack_pdu() blindly copies N' into urb->number_of_packets
>   4. usbip_recv_iso() loops N' times over iso_frame_desc[N] → OOB
>   5. usbip_pad_iso() also loops N' times → second OOB
> 
> Save the original number_of_packets before usbip_pack_pdu() and
> validate the returned value does not exceed it. Also add a defensive
> bounds check in usbip_recv_iso() against USBIP_MAX_ISO_PACKETS and
> use array_size() to prevent integer overflow in the allocation.
> 
> Note that stub_rx.c already validates number_of_packets against
> USBIP_MAX_ISO_PACKETS for CMD_SUBMIT on the server side, but no
> equivalent validation existed on the client side for RET_SUBMIT.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
> ---
>  drivers/usb/usbip/usbip_common.c | 18 ++++++++++++++----
>  drivers/usb/usbip/vhci_rx.c      | 27 +++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 4 deletions(-)

Please see this series:
	https://lore.kernel.org/r/20260325104841.8282-1-addcontent08@gmail.com

and this follow-on:
	https://lore.kernel.org/r/20260327064449.735-1-nathan.c.rebello@gmail.com

and if both of your patches are still relevant after applying them,
great, send them on as a follow-on patch please.

thanks,

greg k-h

