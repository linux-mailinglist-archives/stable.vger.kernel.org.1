Return-Path: <stable+bounces-211848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D0XDX3neGmHtwEAu9opvQ
	(envelope-from <stable+bounces-211848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:27:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AFA97C15
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08B4B304311D
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256630E0FB;
	Tue, 27 Jan 2026 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+yl8PP5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490D3033E1;
	Tue, 27 Jan 2026 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528602; cv=none; b=QgLEyzBhp/ep1FyJ6JBpabJXa0lP93kYhMGTgtCID9wZBrOZwfEbivxSvLwG6/9OXUVyP2mNqoXT1mPCDGNJmqQC8IcmINZr0DK/c71NzKeRp6fQ1Pb8DfARqwcOMM5nlP18kA5H67AxMmg9YVNXWAJzoQ52DkeX/iO10G9kpW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528602; c=relaxed/simple;
	bh=2bXpqNPy8UzvnsWKX/WQql6ReO58dojYXHGdVh8r2LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDkCTx47fNBOY+5pff4ije9XvjzCgZU+/k+pEI1Za5NJfI4yWD2/AF6s34p9iZKsp4rilYsW82PZnbsX3zKg6tvIhpAMBoYGlB4KZatQCs5Z6ElXUj26iKkQlbygg49OcQUh2S3B6oigrIaKmXNjWW4e/KpEcQczuA3qeJAzDro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+yl8PP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DED5C19422;
	Tue, 27 Jan 2026 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769528602;
	bh=2bXpqNPy8UzvnsWKX/WQql6ReO58dojYXHGdVh8r2LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+yl8PP5HL5kraxXOi8rBxDrwnrk1XuHr1IPx2/P3TpUHdNfU0H/ubffZ11eTbsBi
	 P/gNnrmQCme6cy/82VQuHrQXJNQSHCWxk3f2LnRQ6Dmh0qTueaDhvVMZ+bYfjzT8zX
	 1b/yYA3+ZGGWZ27nDAU1aw5MMSEZWbrFQcBzGEbkJwLI6o9ycVGTSWSMrQnFEsAqHn
	 c8rmtO29FInUTSm9zQuVryzzoGSusDqvjk8aOd/4/fKKJWctztdzrPsdjtymjjsaXa
	 ATAKGSpwWCPSZjiFCgxIOVfsOoj7gchIAy0sUyvtNyaoyrLKMFt32HZOSxbcHdh7R3
	 B8d3TkddlJM2Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vklDm-000000006iE-3oqR;
	Tue, 27 Jan 2026 16:43:14 +0100
Date: Tue, 27 Jan 2026 16:43:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Telit FN920C04 RNDIS
 compositions
Message-ID: <aXjdEqFBGNLX7-DM@hovoldconsulting.com>
References: <20260123151916.25381-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123151916.25381-1-fabio.porcedda@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-211848-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 92AFA97C15
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 04:19:16PM +0100, Fabio Porcedda wrote:
> Add the following compositions:
> 
> 0x10a1: RNDIS + tty (AT/NMEA) + tty (AT) + tty (diag)

> 0x10a6: RNDIS + tty (AT/NMEA) + tty (AT) + tty (diag)

> 0x10ab: RNDIS + tty (AT) + tty (diag) + DPL (Data Packet Logging) + adb

> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Applied, thanks.

Johan

