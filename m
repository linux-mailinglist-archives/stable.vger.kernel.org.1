Return-Path: <stable+bounces-262025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cbU8MZ6sJmrpawIAu9opvQ
	(envelope-from <stable+bounces-262025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:50:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 464F0655DCC
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:50:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iL3Apo6h;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262025-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262025-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87E023023E1F
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0039C36D517;
	Mon,  8 Jun 2026 11:49:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9F036C59A;
	Mon,  8 Jun 2026 11:49:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919382; cv=none; b=k12F+PQc6+y1IHhqN6Fzy3uD9Yacyfby5PoMpSKM9pFujKVfCKLsBqohn6aUXJ3WwWHZwa4A1j18mMCEo4q0BHC7W4zwlAPlOcw0nPWVGzKbPwWOEL1yvl2B+vIZZaivINeY2Y+u40uMiZZWas8Ed2w31Cuh2O7kDvcgWnuxgS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919382; c=relaxed/simple;
	bh=dYdxg6ijXfN5qa7Z3vIX2/tk9FX45z+yHtZzR0er7ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQzqIkqyNMdk6ccnpTM0urpXP0rTNz9TFcgt69nWDxQJuc6tv37FAYOzI6rYwJxgUwy+TQURfHBlcl1hOokmhu1QwVIqckaLwo8kVDMXuUzax9dduzfr7lqcE0sNvD0ipSlInDumP+dB3HMSvIsIyeayEs8SzNgCX+M3FnkM3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iL3Apo6h; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885EC1F00893;
	Mon,  8 Jun 2026 11:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780919381;
	bh=ncXd4bz7gMyaSPeT66XMpbniNG/IBpW74Y3bxXolaug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iL3Apo6hdDuZsGRtd2q3cK0pnxE69oJAKmA86SJIap3i1yBnUIAlqKK0DKCUA+0nl
	 h+pM3Yr9OwglmF/4cjxm95FoTtDOSWzvZLLE+scqcx3v3RJMV2Q6t7HuQnaxFUKRLx
	 tkX+wwgnik2ueg2MtkGcHg03vLvtfd55ybvjOag0fW02HvxkW8i6d6gEH+013cpalU
	 ZkcSP/pRlRJiEf4KLQ4M/rkC80xFJk4aS/meG5sWI3RY4/r0VS4JzPx/Xw/YGcPBFd
	 FWZdbp0PY6+q/+eOSoNq51saKdprYDak4ZF7ATSCVS6GS54CsB7LlnDrNegNkivNPY
	 fXVEh0/P72MGA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wWYU7-00000002M9s-26ch;
	Mon, 08 Jun 2026 13:49:39 +0200
Date: Mon, 8 Jun 2026 13:49:39 +0200
From: Johan Hovold <johan@kernel.org>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: kl5kusb105: fix bulk-out buffer overflow
Message-ID: <aiasU0LrWGeC0P-t@hovoldconsulting.com>
References: <20260607095114.9375-1-sammiee5311@gmail.com>
 <20260608090926.10506-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608090926.10506-1-sammiee5311@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262025-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sammiee5311@gmail.com,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 464F0655DCC

On Mon, Jun 08, 2026 at 06:09:26PM +0900, HyeongJun An wrote:
> klsi_105_prepare_write_buffer() is called by the generic write path
> with the bulk-out buffer and its size (bulk_out_size, 64 bytes). It
> stores a two-byte length header at the start of the buffer and copies
> the payload from the write fifo starting at buf + KLSI_HDR_LEN, but
> passes the full buffer size as the number of bytes to copy:
> 
>   count = kfifo_out_locked(&port->write_fifo, buf + KLSI_HDR_LEN,
>                            size, &port->lock);
> 
> When the fifo holds at least size bytes, size bytes are copied starting
> two bytes into the size-byte buffer, writing KLSI_HDR_LEN bytes past its
> end. Copy at most size - KLSI_HDR_LEN bytes instead, leaving room for
> the header as safe_serial already does.

> Fixes: 60b3013cdaf3 ("USB: kl5usb105: reimplement using generic framework")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> ---
> v2:
> - Add Assisted-by tag as requested by Johan.

Now applied, thanks.

Johan

