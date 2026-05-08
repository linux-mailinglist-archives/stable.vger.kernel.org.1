Return-Path: <stable+bounces-244736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULhoKqvA/WkpigAAu9opvQ
	(envelope-from <stable+bounces-244736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:53:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF934F54FB
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D719308C1BE
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6415D1F427C;
	Fri,  8 May 2026 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wMR8jmgE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A9311973;
	Fri,  8 May 2026 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237441; cv=none; b=bubfdDGOBFQzEMD8NRCRpiYMgT1eUnopZmKR+yZaa/7vLXkPJwA04Nz81uKd+GjLGRaNXQOQPrSFee3SccHJc5NadejfWDPfI2PeHR6u7WIPKzJ/+f/KZ4M8E/r5wi7i3Bpe8aZUpaoqk3qJYlRRwhHFo4Jr/njHxfhsy5IKq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237441; c=relaxed/simple;
	bh=KI2j+f5xmph4+c1AwFg3zwnVM+Y9KPgcs3bU+ypSpiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goccqTCmBwJoGqqF9wur8tHG2A2ZTHNgDo5ORB+IHRX9WUNZaSI1MMp7D6ZqDBHTFpbQhKPa8fwBxW3jrq92zrRJjZxka3zyIU82t1CnI4giXfXQ5xv7Hyeb7jJWtQ6yk7YxjxHJsqurAPFSpuF/+pBelb0SvpjtrJSxwJRBIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wMR8jmgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731C7C2BCB0;
	Fri,  8 May 2026 10:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778237440;
	bh=KI2j+f5xmph4+c1AwFg3zwnVM+Y9KPgcs3bU+ypSpiA=;
	h=From:To:Cc:Subject:Date:From;
	b=wMR8jmgEH0LNjqbP/7Kc2S4EmxgfpS1LvqY8l3Q/J4J5RBeo02B3KLZFy/UxdvsAt
	 r+AOvE9e0MaHXNtLQWAnncSbs6gCpeQnY0hOrNnhkwE59Hn2vEkTHlRRUmRlcm8Kyz
	 wQwtEJI0Na65RtW0GweiWqj7Gf++WAJK2YnZpgMo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.205
Date: Fri,  8 May 2026 12:50:34 +0200
Message-ID: <2026050835-giggly-erratic-e459@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5EF934F54FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244736-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

I'm announcing the release of the 5.15.205 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
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
      Linux 5.15.205

Kuan-Ting Chen (1):
      xfrm: esp: avoid in-place decrypt on shared skb frags


