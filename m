Return-Path: <stable+bounces-233504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDKQACqv1GnvwQcAu9opvQ
	(envelope-from <stable+bounces-233504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 09:15:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACC83AAB2A
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 09:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F46D30465CA
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE782145B3F;
	Tue,  7 Apr 2026 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7jie/kw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E09E392C25;
	Tue,  7 Apr 2026 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546119; cv=none; b=rQDrXxT+XTykn0UWEwub3/CUjadU8JyWI86StsVsCuCDR8ffrnMTOXk2N+UlhwK+ZnC/xebNvfA54WQDLsQBTZ9kUhQsjJJZUi9dVRX6REgd6EpAxB/cI96j23mbrAXNjs07lbE9mLFTqid9TyQlxYy+p0tWNHVEzmUiibmNGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546119; c=relaxed/simple;
	bh=JK7SS5vNkXB3cmmAuHdGhiZGsP1gCik+zSjoA2DSEKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmBjtHw2p4LSL5GDBJW/rqnI02bK47PYOtkxojM7U184Wu0dTNP3dTR7a5+fXff7ln7ml3bAsWvMVSf8Rg/MW/VqtesZUoSfW7MyeOMPffO+K0U1MDn4loEXC3sti8ShXKV2U9wltzZBXJPVAPzDliTz7FvXhjfWrghdgvuTxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7jie/kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A30BC2BC9E;
	Tue,  7 Apr 2026 07:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775546119;
	bh=JK7SS5vNkXB3cmmAuHdGhiZGsP1gCik+zSjoA2DSEKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7jie/kw19dUEZZduMSMx2B1GuEIypE3LUSZ69iE37MvpzmDWtgtEw3MH4GlY/em4
	 +oGscg8pTWYX8dhViWeHueKoPzwKWpq6uzH0zUBXc863UPQxHbXd2920ANcmwXj2Kv
	 iM74d3xwrMeTRc5zosMAZ7qKcqvQvibG/RLwgI1WjVD86OlE5OwmZx9Sfn3IwFBC4A
	 hgPmWoUW1hHbLU9PcJ8FFrKGdcs8mDMlFnkgqY+yx7aoeoTgKEVclDoBtci6Wen5HE
	 4vzPmugBrhfUNFTughD8aGg3J+kV/Pec0sB+mD8h4aHltcyAXQGIV5lzvWH59+M692
	 OkazXMPfA8bBQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA0ea-0000000AhTS-3cxO;
	Tue, 07 Apr 2026 09:15:16 +0200
Date: Tue, 7 Apr 2026 09:15:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: option: add Telit Cinterion FN990A MBIM
 composition
Message-ID: <adSvBMMUp-t1yPiu@hovoldconsulting.com>
References: <20260402095727.108281-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402095727.108281-1-fabio.porcedda@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-233504-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 6ACC83AAB2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 11:57:27AM +0200, Fabio Porcedda wrote:
> Add the following Telit Cinterion FN990A MBIM composition:
> 
> 0x1074: MBIM + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (diag) +
>         DPL (Data Packet Logging) + adb

> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
> v3:
> - Added the full output of usb-devices
> - Link to v2: https://lore.kernel.org/linux-usb/20260402083722.100973-1-fabio.porcedda@gmail.com
> 
> v2:
> - Added "Cc: stable@vger.kernel.org"
> - Link to v1: https://lore.kernel.org/linux-usb/20260402082747.98441-1-fabio.porcedda@gmail.com

Now applied, thanks.

Johan

