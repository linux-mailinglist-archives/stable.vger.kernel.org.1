Return-Path: <stable+bounces-220015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIj8KvoLomk3ygQAu9opvQ
	(envelope-from <stable+bounces-220015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 22:26:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352EA1BE2C9
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 22:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9905631368A9
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790247A0C3;
	Fri, 27 Feb 2026 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zJfH82CO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413647A0B8;
	Fri, 27 Feb 2026 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227497; cv=none; b=hCofEZ7H5fTMpZGHxGAgaVw7ZMaqiTtUUWvLh9IZ220lDbsayPtHczw9tHwkC9HZK2Em+vHzgn/FrISpGy9B68ag0j4TegqjhylCBXwQI+A5+9rWM5o3imm4x6HC6zCqLxAkG0WL0OAXAuAnPRNXcuDG1LoXNoyI+HgqQU1BhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227497; c=relaxed/simple;
	bh=ZxjwZIqXku/N6bFScnTaFWOgqf6rrtp+L76vkJgBwhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhmA3DjOj9EcgIlJIcEguT0nKn/c/uHcbu2RliOq96toI4LLzwCRNjy87B+64JR+ZGPdAg0TZ8E9KIfsZ+mlDbaXKMPMiTDMN2k0FUr1vtUhm2R0QVtmQTiD3V20NQNiBXdQar8uWXY4ganYh5LPrGeUhIEVMPYt56jL28nMOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zJfH82CO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4456C116C6;
	Fri, 27 Feb 2026 21:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772227497;
	bh=ZxjwZIqXku/N6bFScnTaFWOgqf6rrtp+L76vkJgBwhs=;
	h=From:To:Cc:Subject:Date:From;
	b=zJfH82COLKzVxkaOu8kJV0cTpnE+MZuwXHHYqT4D4DSeWGnwmQpBO3S+DqUW/ish/
	 VYTIJXlbla+1G0awkaG8s4sczFxby9/gG8+GfbLnC84TPOL3JGPzCtW3jZ0pY4W20P
	 m5Muu9UL04uL05vcdOZOSXfRpLkO8yeZmK0FYjKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.19.5
Date: Fri, 27 Feb 2026 16:24:41 -0500
Message-ID: <2026022720-tricolor-starved-baef@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220015-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 352EA1BE2C9
X-Rspamd-Action: no action

I'm announcing the release of the 6.19.5 kernel.

All users of netfilter using the 6.19 kernel series must upgrade.

The updated 6.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                          |    2 +-
 include/net/netfilter/nf_tables.h |    2 ++
 net/netfilter/nf_tables_api.c     |    3 ++-
 net/netfilter/nft_set_pipapo.c    |    2 ++
 4 files changed, 7 insertions(+), 2 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.19.5

Pablo Neira Ayuso (1):
      netfilter: nf_tables: add .abort_skip_removal flag for set types


