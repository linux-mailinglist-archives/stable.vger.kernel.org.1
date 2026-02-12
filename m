Return-Path: <stable+bounces-215946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKRLNtHBjWlt6gAAu9opvQ
	(envelope-from <stable+bounces-215946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:04:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6638012D414
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 973113062FA7
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1452EFD8F;
	Thu, 12 Feb 2026 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nNArYCtC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BC346779
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770897790; cv=none; b=hCoW7jaCodqHoFAyTJjAkaYdFegRMM246CUmkox9qvehwNGkxyAWffMCxi3DFIlwWmcgEmhEuQnehiGATnMhFo6OTaaeJI25w8Bh6nMMOTbrnWdr94n/7gAGMDI7RvgaH5VgAUtdW87mgZ10P0YPCqryvgkjf1fdDBaO8BsWHX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770897790; c=relaxed/simple;
	bh=QTG7dgC+Wfczdc3D6nBZNoS5vg83J17qa2NZgBfUULo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPmz/CAa1Pmn/MBwGjvkJac7CC6yHq0DnJk9BP4jzjT28/iPtgfofkc5i+N18aQGLSXnI7c1QPpXkxE/kagncXKivSVEqP5RFt1ixOcxKvVEqI/O85Py846rCEo8Q2rp+pkAFgpcRV9B2UjGb+oDSmQrBY/ASbXi+UHrbD9ltP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nNArYCtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3AEC4CEF7;
	Thu, 12 Feb 2026 12:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770897789;
	bh=QTG7dgC+Wfczdc3D6nBZNoS5vg83J17qa2NZgBfUULo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNArYCtCv3Ic1on8deQtB1QWuQq6/gaiUSw3/qE40Mv9zVvHRmK0bhhHlOhkGNi7m
	 6nL+OT4ZaRktRXUY/xjKjIF84TwQhoUrIKlvoquhbyqdk6rklQoyYvk/urmQ0Xkqfs
	 MAs7xykxLH4MrnKU4wer3aSFtd6uGKLRGijPsz9U=
Date: Thu, 12 Feb 2026 13:03:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>
Subject: Re: 6.12-stable inclusion request
Message-ID: <2026021246-rumbling-accustom-025a@gregkh>
References: <51b76881-90fa-4de3-9c39-68d076b5706f@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b76881-90fa-4de3-9c39-68d076b5706f@kernel.dk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-215946-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6638012D414
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 02:58:45PM -0700, Jens Axboe wrote:
> Hi,
> 
> See:
> 
> https://github.com/axboe/liburing/issues/1530
> 
> for the reasonings here, but please add this patch to the 6.12-stable
> queue. Thanks!

Now applied, thanks.

greg k-h

