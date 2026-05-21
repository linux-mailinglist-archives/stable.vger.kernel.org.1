Return-Path: <stable+bounces-253468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIIrOjC7DmrBBgYAu9opvQ
	(envelope-from <stable+bounces-253468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:58:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE85A0866
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90948301745C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E5D397E8B;
	Thu, 21 May 2026 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt19zBoH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932FE377EBF;
	Thu, 21 May 2026 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350308; cv=none; b=SNdtiXQ8RouJweKxQoTOXB4lTXm+pyyuv1uOwF+8iH3NdqG/TgYP2EN7MjOLo0cqFTa+8RyBci5T4hIMEpfHHRhSsJUgqKm0pT6aQyH5ms1XiHTip5oJnFUaO+XZtZMm+Ov7DNhBTn9ZlcDYaTQlZFY+qo+0aQWYvsYJGhjUKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350308; c=relaxed/simple;
	bh=nZOk2k8R+NIh9xUYxK9J1XqMp5bYirsBOdG6ifKziYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyCyw9PkQt8a7hcnBZxa+4pmcs9ekWMvIsC8wmM//uaPJajH7LfNoLxNSG+xygGK9T/FrASjnNfJfOkXhYch3tYGNGYE+cjDtU3nnmXssf2qXD5kH28A74S34RxhaPm+J8lDHCvlQXu3X/QDYQvetbyHKf/F67hZ/ze8ikC/alw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt19zBoH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A58E1F000E9;
	Thu, 21 May 2026 07:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779350306;
	bh=85oIQuLoThsXhNF76XjJLp/k+dFrF+C3BWhgBYJ7kqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yt19zBoHnCk7VGBh3019EcYIFEByB5XKm7XMoqnnKKIU05NbZTF8ZBc4Y858ekpFh
	 bA0SdpUySThN8ylkwI7BMQAhOekmJYqtvCB+eRRjmoLsyH5GkqSwLt39pBMKO368Dp
	 5S/sCKpGa+EfZi+CpeO72QRnECxRJOwnw1xWAC3id2qlv6JA8rWzaCTZX2Qy8vNwcy
	 gmia26Ws0Irt0c0fq8MjCXko+oRcH8YhzkWueuYKyqvwoSXml6NGFDmYzlSs6wc8le
	 MR3+qRo8F2GHyCsHYnaSVHUgmVZcpVtJtbcWbTXoLzxzRjep8P+rHzawukf2BS2kOG
	 nJdtrrX2CpGqw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wPyIS-00000003Nkm-0Qy4;
	Thu, 21 May 2026 09:58:24 +0200
Date: Thu, 21 May 2026 09:58:24 +0200
From: Johan Hovold <johan@kernel.org>
To: zwq2226404116@163.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wanquan Zhong <wanquan.zhong@fibocom.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/1] USB: serial: option: add missing RSVD(5) flag for
 Rolling RW135R-GL
Message-ID: <ag67IE23NlLi6wcT@hovoldconsulting.com>
References: <20260520113246.305594-1-zwq2226404116@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520113246.305594-1-zwq2226404116@163.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253468-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hovoldconsulting.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fibocom.com:email]
X-Rspamd-Queue-Id: 89CE85A0866
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 07:32:45PM +0800, zwq2226404116@163.com wrote:
> From: Wanquan Zhong <wanquan.zhong@fibocom.com>
> 
> The RW135R-GL entry added in commit 01e8d0f74222 ("USB: serial: option:
> add support for Rolling Wireless RW135R-GL") was missing the
> .driver_info = RSVD(5) flag used by other Rolling Wireless MBIM laptop
> modules (e.g. RW135-GL and RW350-GL).
> 
> Without this flag, the option driver incorrectly binds to the reserved
> ADB interface (If#5) in multi-interface USB modes, causing AT/MBIM
> communication failures after mode switching. This matches the handling
> of other Rolling Wireless MBIM devices.

> Fixes: 01e8d0f74222 ("USB: serial: option: add support for Rolling Wireless RW135R-GL")
> Signed-off-by: Wanquan Zhong <wanquan.zhong@fibocom.com>
> Cc: stable@vger.kernel.org
> ---
> v4 -> v5: Use 12-char commit id and correct Fixes tag summary; move
> changelog below --- separator; restore usb-devices output
> v3 -> v4: Device table entry formatting aligned with existing pattern

Thanks for the update. Now applied.

Johan

