Return-Path: <stable+bounces-242056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKG/Hc4Z82nNxAEAu9opvQ
	(envelope-from <stable+bounces-242056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:58:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A2949F8C7
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 369643048DD5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273C03FE37C;
	Thu, 30 Apr 2026 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0ltCjHX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3453FBED9;
	Thu, 30 Apr 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777539395; cv=none; b=EOo0GgX+F0byxCCfJ6AxEIjuWe8TJLC+dISeKyOAAqBow8Vi3YmToR8cSF08NHPZNcqLIJO2+jHX5iPF3+r6+8tFFXoJF/hAG9Xenq8Yuzcf+ZjtPXkkKMkflN5ueZBGsulFKLpilB/54KZWyogLHvjJEtyxbcsXK2v/xSBNFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777539395; c=relaxed/simple;
	bh=FQR/S+RpWT97WnJGGeSpim/zgiZzyQlg33WWZPgos2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM0+KwJOuy1WPqIcwKF2lrtY+943AN/m72VF9lYqGR6T/Lxqvo5g6srguzX6HF4HuhDe1CApvWl5WFoyecfZWxbe53kJU7WPOw/8UDU/sTZX/IRTTP6PcVl8GQTT2HKO7qKS0WrBaa3GUDFi/AwOhJMfXMCWPhlXZdm9QuAF9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0ltCjHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7140AC2BCB3;
	Thu, 30 Apr 2026 08:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777539395;
	bh=FQR/S+RpWT97WnJGGeSpim/zgiZzyQlg33WWZPgos2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0ltCjHXOi+pqUufJBmKR1LNCbqD5G2QUXb8t8wUiPExNAcoPhVqfmAtuXmJENmR/
	 q/+gkKyp6JJ0jFLumAy5OdbYjtrs+0xdvo69Zv78iRF+r3t4kySJWFaq865+FKH6TH
	 3VqsUT0Na3XIEz+BmMS6CyzvSBPVP6VHMbtrqpLyfwP6Y8s5PW7TRoJ1Y176uV8tyg
	 AxKrRT472ONott6zwo10rkPDWroDbuGdAWWdjXLW/pOvYaWIrPV/bE9rIvGvgnH4xi
	 /53Cvzd9QqW3oiJBrcB/lIUkjDSahchbIcofkxIa0insaz2WZsGbuvQImbBrXe8A3M
	 iEtEs9RLeB2aw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wINCD-00000000wNg-0TPg;
	Thu, 30 Apr 2026 10:56:33 +0200
Date: Thu, 30 Apr 2026 10:56:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: option: add Telit Cinterion LE910Cx
 compositions
Message-ID: <afMZQStRrVMbGycz@hovoldconsulting.com>
References: <20260427091746.592613-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427091746.592613-1-fabio.porcedda@gmail.com>
X-Rspamd-Queue-Id: E9A2949F8C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-242056-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hovoldconsulting.com:mid]

On Mon, Apr 27, 2026 at 11:17:46AM +0200, Fabio Porcedda wrote:
> Add the following Telit Cinterion LE910Cx compositions:
> 
> 0x1251: RNDIS + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (SAP)
 
> 0x1253: ECM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (SAP)

> 0x1254: tty (AT) + tty (AT)

> 0x1255: tty (AT/NMEA) + tty (AT) + tty (AT) + tty (SAP)

> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
> v2:
> - Add stable tag

Applied, thanks.

Johan

