Return-Path: <stable+bounces-243845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAHkApGz+GmWzAIAu9opvQ
	(envelope-from <stable+bounces-243845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:56:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE624C03A7
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9AE130136B5
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A153DEAEC;
	Mon,  4 May 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WdZQGZZb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C1F3D6CAF;
	Mon,  4 May 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906562; cv=none; b=i8064fGhcDYvtLKBbQwxv6EbFhBMJTmLYiNQxs4ypwhMxI9P8kX2H4lA/2TxJHFSoZbIpvW0X9k7suI9TgUUuWryT3m8cYf3TO6laB68Wb1WtJUhWf/QqJCX4PLIdcgE/8MAB2MiBFNP3IxCsPDj0mnNnHCoVyfG8DWUq4nqLgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906562; c=relaxed/simple;
	bh=ll2v9LtrrjMsGgNSxTPb6ZqOV1wGfR+gmcgznhRqy/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBIncwvX4rB41ppsN6i207SIo5M+lHY0wB1me72EAOsHZvbbYdyXwz7Tq6rnMSlpp2uej/EoQWGOpm/aZ+gUNzKmnyPhSiEETfWChdPfRpB67Py/HixzgFf0xydk2T2iO/8lxDmt0S4tc3Z4qGAzYe/o0JMpaNxcL2Jj8ByaHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WdZQGZZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63C4C2BCB8;
	Mon,  4 May 2026 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777906562;
	bh=ll2v9LtrrjMsGgNSxTPb6ZqOV1wGfR+gmcgznhRqy/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdZQGZZb8opP8HLqbENELliDurAIeeR0GiwccSngxzIaXg6MeJ5dqipaN/l/lAIoC
	 XUCoeM3dTkyvZFG9zGLW+9sU9tEhYVvZ35BKPqeZyGSGdoW+CXiDEuClP7N1yesqWb
	 udcIqiVpXAoKhUjcMpjO4jfxa1yxmEYfgROGaDXs=
Date: Mon, 4 May 2026 16:09:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: luka.gejak@linux.dev
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4] staging: rtl8723bs: fix remote heap info disclosure
 and OOB reads
Message-ID: <2026050408-simmering-widen-91e5@gregkh>
References: <20260415163322.42682-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415163322.42682-1-luka.gejak@linux.dev>
X-Rspamd-Queue-Id: 5FE624C03A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-243845-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.dev:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 15, 2026 at 06:33:22PM +0200, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> When building an association request frame, the driver iterates over
> the ies received from the ap. In three places, the driver trusts the
> attacker-controlled pIE->length without validating that it meets the
> minimum expected size for the respective ie.
> 
> For WLAN_EID_HT_CAPABILITY, this causes an oob read of adjacent heap
> memory which is then transmitted over the air (remote heap information
> disclosure). For WLAN_EID_VENDOR_SPECIFIC, it causes two separate oob
> reads: one when checking the 4-byte oui, and another when copying the
> 14-byte wps ie.
> 
> Fix these issues by adding upper-bound checks at the start of the loop
> to ensure the ie fits within the buffer, and explicit lower-bound
> checks to return a failure if the length is insufficient. For
> HT_CAPABILITY, also clamp the length passed to rtw_set_ie() to the
> struct size.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>

Please address the review comments found here:
	https://sashiko.dev/#/patchset/20260415163322.42682-1-luka.gejak@linux.dev

thanks,

greg k-h

