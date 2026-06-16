Return-Path: <stable+bounces-263713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GRG5A8JEMWr8fgUAu9opvQ
	(envelope-from <stable+bounces-263713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 14:42:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9163168F754
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 14:42:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b="p8QX/iBe";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263713-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263713-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04874319BF19
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 12:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25A361DCB;
	Tue, 16 Jun 2026 12:36:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE2361DAE
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:36:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613402; cv=none; b=jZt5nDOO/1qa/ayMgCd2O4KHwd+NBdADjBIKWeE3pkR3ni0LS3wk+86m6Q1WyUp9j7wnnfaBzXnrfp1AlSo1PDuK6Jgh3526b0eFngbuvAbWneNlp4CrP6Ry5fhVIa4zB+qXGbehoN2/uA0xfblQPUyQJghOyowMkKXD6pdRAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613402; c=relaxed/simple;
	bh=tUklhDdmWWlFUOuDNIXZDa/U/aTBNHxk+FXqk++pZGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/ASNY7fTRHlDATX/38GUkNQoWHoVBelTi54yll0SsekCP/hx6wxGuKRDygA4Wxjv43RH4ZgDgkdLvQmdI+nkpsrNy+U8RMGpXbWnlwkqpYJ16bQ4UnRXkA/9gb8xh4TqtYiiNF+z7oNZGSzNw80I0TUYEFECRLy1v5BvrVFE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=p8QX/iBe; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=PqKBoL/8y6XWPOM4t2Vcyzx0gB6K4LQR2E1hqQnBWEw=; b=p8QX/iBe54sz/gWf5OedsRTr7g
	h1ZVPdyVx5Wwhinu+Lmao0AL35XyI29Eegctkx8ZcCWRrAPF1mV3FcMqEics8C5m4DvdW+NSoMvdL
	xUGWWXcR+Ib+6K/qhRSby4HlMSYPm68JLhPUkR6/T7vd5JvVWlNp/S17GwGCFgXJZoc11OKYCDQcc
	+yi6rcceoZrmVcw+cSxU/gpeO3V+8caQgTOTLHVKQXItx9khu41LNkMXepYvUkGkHAXnfhaYaPaRW
	7azcY2uPggQX4JdlYCNAXgfLuVZtyWlonnuRGAm95MBmH8pHJhWFHrlknbpxsWPjXaegZ0yWAj7hb
	sT5Ink8A==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	edumazet@google.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 0/3] "tcp: secure_seq: add back ports to TS offset" and deps
Date: Tue, 16 Jun 2026 14:36:26 +0200
Message-ID: <20260616123629.1218562-1-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263713-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:heiko@sntech.de,m:quentin.schulz@cherry.de,m:edumazet@google.com,m:heiko.stuebner@cherry.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cherry.de:email,sntech.de:dkim,sntech.de:mid,sntech.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9163168F754

From: Heiko Stuebner <heiko.stuebner@cherry.de>

tcp: secure_seq: add back ports to TS offset needed two dependencies
to apply cleanly. With them just being the IPV6-specific symbol EXPORT
change.

I've tested these on top of 6.12.93 with all of
- CONFIG_IPV6 = y
- CONFIG_IPV6 = m
- CONFIG_IPV6 is not set

Eric Dumazet (3):
  net: introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL()
  tcp: use EXPORT_IPV6_MOD[_GPL]()
  tcp: secure_seq: add back ports to TS offset

 include/net/ip.h         |  8 ++++
 include/net/secure_seq.h | 45 +++++++++++++++++----
 include/net/tcp.h        |  6 ++-
 net/core/secure_seq.c    | 80 ++++++++++++++------------------------
 net/ipv4/syncookies.c    | 19 +++++----
 net/ipv4/tcp.c           | 44 ++++++++++-----------
 net/ipv4/tcp_fastopen.c  |  2 +-
 net/ipv4/tcp_input.c     | 22 ++++++-----
 net/ipv4/tcp_ipv4.c      | 84 +++++++++++++++++++---------------------
 net/ipv4/tcp_minisocks.c | 11 +++---
 net/ipv4/tcp_output.c    | 12 +++---
 net/ipv4/tcp_timer.c     |  4 +-
 net/ipv6/syncookies.c    | 11 ++++--
 net/ipv6/tcp_ipv6.c      | 37 ++++++++----------
 14 files changed, 205 insertions(+), 180 deletions(-)

-- 
2.53.0


