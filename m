Return-Path: <stable+bounces-244734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ArHI/2//WkpigAAu9opvQ
	(envelope-from <stable+bounces-244734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:50:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 292414F5473
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF5363036716
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC631282C;
	Fri,  8 May 2026 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h8j6cjtf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026A30FC23;
	Fri,  8 May 2026 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237431; cv=none; b=sT1DPvnAxALAfUwBsWf3qomvNl4s6PACoMI5YBcygglJ4kPxomgAuBb41iFdXnub4egDX7JzuR/y7WMpkK9osp5Ta9dF8PFkF0SAl1D3aBob3PSoFZdjBxi2cjUmo1CpPYVXYW5bkOGZEIKUAs8WUKw969un8vfnoEjJMuvmpvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237431; c=relaxed/simple;
	bh=LvLWHdzxe+o1476+dEL3AEQULJLxhUU7eOuxk/BGPEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8j33suvzas8tHkmrWTG6ZAZEK2j19zuyT67FiadrnhUcmVvGVJp8ADchhFAeBiPCQPmEK1YTqu1ZMZhyQ3MwcPfDOl8TrE+VLiAy8d7f2d8QwiPJmlg9f4g9zaoZir5dp7eCK04LEQQqAmO+s2iaajjnADQuCwXGZTqqK8kO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h8j6cjtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B268C2BCB0;
	Fri,  8 May 2026 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778237430;
	bh=LvLWHdzxe+o1476+dEL3AEQULJLxhUU7eOuxk/BGPEg=;
	h=From:To:Cc:Subject:Date:From;
	b=h8j6cjtf7C5uuVtsRFXXAEgdaYyhq33lMjoiSjMyxkX4QK56rqU4oDG2Z6CZwSD2S
	 7L/am/uMaQZYkfa7J3NHO0ITnoSN2xrISRjnaOkbXh0RJLoOKWoZE8pNYQx9vtZBGU
	 2ZHUfPeWRhGC7tbrs4Eub0lIF2KHoD6bASmpX+jk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.255
Date: Fri,  8 May 2026 12:50:26 +0200
Message-ID: <2026050827-wobbly-amply-778f@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 292414F5473
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244734-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I'm announcing the release of the 5.10.255 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile             |    2 +-
 net/ipv4/esp4.c      |    3 ++-
 net/ipv4/ip_output.c |    2 ++
 net/ipv6/esp6.c      |    3 ++-
 4 files changed, 7 insertions(+), 3 deletions(-)

Greg Kroah-Hartman (1):
      Linux 5.10.255

Kuan-Ting Chen (1):
      xfrm: esp: avoid in-place decrypt on shared skb frags


