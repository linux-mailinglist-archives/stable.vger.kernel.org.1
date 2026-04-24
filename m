Return-Path: <stable+bounces-240641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAJyHdRX62nkKwAAu9opvQ
	(envelope-from <stable+bounces-240641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:45:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0701B45DF2D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 414CE300DDCD
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E003BE644;
	Fri, 24 Apr 2026 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZekIzX9J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68183BE629
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030965; cv=none; b=IfSwtR7IHHxy4H6ew9MWvWNUyG8A3qKk9SPEGcKSdQlcqXBKPj0EkU1a28N7hCGkUxHlXeiQoU4LcppvNbF+KcB6vFTGLWtGJwgt3YOBFV6unTQtrmB8+KLPTDOZ555jbAea95Ion/ODUOHEpBhjDcBjAefc/Tu2Vji1kNUIubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030965; c=relaxed/simple;
	bh=mqm0TC09+UJF261GXFt5tudaT3V6fjPWNXFgsdarFIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbR7Yj0YJUL00+zfKGphAUZtWJmVoAghn1dfZnwzxbg0wDnFhjOhqucvFpCsFhwnycxUHa2llQ4ZGfbwfIEDEltCglT9grzfb9yshpR9FTOSsHmDHVbFFYGme7QbXAPK6X9KNVqPXmrU8EkE2KL3B0hfnKk58gFfsqsflX3VoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZekIzX9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49983C19425;
	Fri, 24 Apr 2026 11:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777030964;
	bh=mqm0TC09+UJF261GXFt5tudaT3V6fjPWNXFgsdarFIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZekIzX9JqcRFKlq10vbbYC/lf5UicobRu/asKXXuEguFAGnyeurghY2PB9pT59S98
	 eEYdtCOYs5EFsqdlJbZYZda5MWyDPgl/fjR7cF2swLLMBgKsdIVFYUfSyqdPXsjlQo
	 cQ+n/b60vQ9dQqpaY/0zkU2iVS1kJ96dgSQQMSU8=
Date: Fri, 24 Apr 2026 13:42:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Jeff Barnes <jeffbarnes@linux.microsoft.com>
Subject: Re: [REQUEST] crypto backport for 6.6
Message-ID: <2026042442-absinthe-reversing-8376@gregkh>
References: <aetVcb8pSITaiGg7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aetVcb8pSITaiGg7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Rspamd-Queue-Id: 0701B45DF2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240641-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]

On Fri, Apr 24, 2026 at 04:35:13AM -0700, Hamza Mahfooz wrote:
> Hi,
> 
> Please include commit 35e13e0eacf4 ("crypto: testmgr - Hide ENOENT
> errors better") in kernel 6.6, as it resolves a kernel panic.

I see no such commit in Linus's tree, are you sure that is correct?

> (you will also need commit fc0f08317135 ("crypto: testmgr - Hide ENOENT
> errors") to have it apply cleanly).

I don't see that commit id either anywhere.

What tree are you looking at?

confused,

greg k-h

