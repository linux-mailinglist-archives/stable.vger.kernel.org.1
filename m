Return-Path: <stable+bounces-211633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBlrON2Gd2m9hgEAu9opvQ
	(envelope-from <stable+bounces-211633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:23:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F2C8A14D
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF727301584A
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795425771;
	Mon, 26 Jan 2026 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aVnJjsee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014513C918;
	Mon, 26 Jan 2026 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440972; cv=none; b=aHLiWiPbd5Q04qB+oWeNqI3rf/a2mWmIpB85U1zGIeKXuRaq6h9ZvDQg8RGneH35tqc5fLOIxhgcklwtU4l84Jdy/XoxaM5NuH/JiJH93L0az6KTeS9oEheAPunHNphLaTJPmKbjCnjc4D1nsWsENtweMmkCh/At9NnrBU1ZlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440972; c=relaxed/simple;
	bh=DmwDU1ZSxQquMJbXXEuhX+T1ZNCCmDgqQkVoC1Z2MMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbsijgC75L0X8W8Y5lGDj96XAL+WuccqWIqCBR3orm1xFyDL4OXyXKv18R1E3d70kDKlTkoy3U5bEoGkN2vPBlQ24lrUb5ZAGmG/KTVvHDqQu2NmyBU8ZEMJohuj9ZY0XjcOLMzNREPDjQCCO8YxXyh1gFkEilIdtzb/J9RT0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aVnJjsee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C83C116C6;
	Mon, 26 Jan 2026 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769440971;
	bh=DmwDU1ZSxQquMJbXXEuhX+T1ZNCCmDgqQkVoC1Z2MMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVnJjseeBIgm99F4fDOItpCSedMm9jhxgVXZ+pVvz15wpqSeRkdC/+3cLdpb7nKhX
	 TxSlxcfM9F0vzqwyzm0EP/C2O2fPH0GtHG/UI5N/+Tpo10D64XBSNsEE6jqUOax3Y0
	 D1Ykdqd1nE0BIzQZHjNkh4cRZM3KKFlSIYexSiC8=
Date: Mon, 26 Jan 2026 16:22:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	Markus Mayer <markus.mayer@linaro.org>,
	Tim Kryger <tim.kryger@linaro.org>,
	Matt Porter <matt.porter@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jamie Iles <jamie@jamieiles.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>
Subject: Re: [PATCH 6/6] serial: 8250_dw: Ensure BUSY is deasserted
Message-ID: <2026012608-slicing-vehicular-6987@gregkh>
References: <20260123172739.13410-1-ilpo.jarvinen@linux.intel.com>
 <20260123172739.13410-7-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123172739.13410-7-ilpo.jarvinen@linux.intel.com>
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-211633-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.intel.com,163.com,arista.com,linaro.org,jamieiles.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arista.com:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67F2C8A14D
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 07:27:39PM +0200, Ilpo Järvinen wrote:
> DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
> Existance of BUSY depends on uart_16550_compatible, if UART HW is
> configured with 16550 compatible those registers can always be written.
> 
> There currently is dw8250_force_idle() which attempts to archive
> non-BUSY state by disabling FIFO, however, the solution is unreliable
> when Rx keeps getting more and more characters.
> 
> Create a sequence of operations to enforce that ensures UART cannot
> keep BUSY asserted indefinitely. The new sequence relies on enabling
> loopback mode temporarily to prevent incoming Rx characters keeping
> UART BUSY.
> 
> Ensure no Tx in ongoing while the UART is switches into the loopback
> mode (requires exporting serial8250_fifo_wait_for_lsr_thre() and adding
> DMA Tx pause/resume functions).
> 
> According to tests performed by Adriana Nicolae <adriana@arista.com>,
> simply disabling FIFO or clearing FIFOs only once does not always
> ensure BUSY is deasserted but up to two tries may be needed. This could
> be related to ongoing Rx of a character (a guess, not known for sure).
> Therefore, retry FIFO clearing a few times (retry limit 4 is arbitrary
> number but using, e.g., p->fifosize seems overly large). Tests
> performed by others did not exhibit similar challenge but it does not
> seem harmful to leave the FIFO clearing loop in place for all DW UARTs
> with BUSY functionality.
> 
> Use the new dw8250_idle_enter/exit() to do divisor writes and LCR
> writes. In case of plain LCR writes, opportunistically try to update
> LCR first and only invoke dw8250_idle_enter() if the write did not
> succeed (it has been observed that in practice most LCR writes do
> succeed without complications).
> 
> This issue was first reported by qianfan Zhao who put lots of debugging
> effort into understanding the solution space.
> 
> Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
> Fixes: 7d4008ebb1c9 ("tty: add a DesignWare 8250 driver")
> Cc: <stable@vger.kernel.org>

Why is patch 6/6 only marked for stable?  If this is needed "now",
shouldn't this be a separate patch?  Do you need all of the first 5 for
this to work properly?

I can't take this series as-is because I don't know how to route it :(

thanks,

greg k-h

