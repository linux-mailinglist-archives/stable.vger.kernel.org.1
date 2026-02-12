Return-Path: <stable+bounces-215952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC3sLpLFjWnT6gAAu9opvQ
	(envelope-from <stable+bounces-215952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:20:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466512D60D
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19094300E585
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BEE357708;
	Thu, 12 Feb 2026 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ait6T45Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04752FF150;
	Thu, 12 Feb 2026 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898829; cv=none; b=OHUTDCFA5XBiXzYj/er8LTcE7I7feopYcMbjC4wVrmCEBihhCcLaxCpNGnmgD4d8mOIkXtQjSjxu8IrTPucs4UNTYoMimzpf2BXYs/6I/3GKphIrjThhMihoTYc1k+3hDFbia5A4iGN13kgIflGvfL7Wf8cog4DNS9hjjaZVl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898829; c=relaxed/simple;
	bh=EsVPA6igSHogdWunbQbxpBLhZdkZH4NQp46IhTeVY5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLOceT49qlQQazcdYcdDHD/5kYGLcblAgk2AVfr5mgSyxK1LjdbBgiWcMKJdHRsFpRRJVK5/yi2AoYGYbVIUB+Oph0T6HvlNAHFJeBdB/2vgDgdTc1f9KUefGumNms1dvmobzLBsZPJpd3nAWc/pgZIPZ6kZ11X7UcYpOJsZJCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ait6T45Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1ABC4CEF7;
	Thu, 12 Feb 2026 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770898829;
	bh=EsVPA6igSHogdWunbQbxpBLhZdkZH4NQp46IhTeVY5E=;
	h=From:To:Cc:Subject:Date:From;
	b=ait6T45QErAa+WKgfUF0JqhbgWNV13Ex9aLKhucWdr1kx8CaO9CyM5dkV0BS3ghAc
	 /wylcGZ7znSOW31adupJpeH21LrbETQ16oUlKM19VJVt0nBIDA4DBDCmHdCgDsjbvt
	 1F+x228TTQChgI6tvFYjTRkxzDpPQFQSJO0iT0GE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.71
Date: Thu, 12 Feb 2026 13:20:24 +0100
Message-ID: <2026021249-prepaid-scant-755b@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215952-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8466512D60D
X-Rspamd-Action: no action

I'm announcing the release of the 6.12.71 kernel.

All users of the 6.12 kernel series that had issues with 6.12.69 or
6.12.70 should upgrade, as some regressions are fixed here.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                  |    2 
 drivers/net/bareudp.c                     |    4 
 drivers/net/geneve.c                      |    4 
 drivers/net/vxlan/vxlan_core.c            |    2 
 include/net/ip_tunnels.h                  |   13 +-
 io_uring/rw.c                             |    2 
 tools/testing/vsock/control.c             |    9 -
 tools/testing/vsock/msg_zerocopy_common.c |   10 --
 tools/testing/vsock/msg_zerocopy_common.h |    1 
 tools/testing/vsock/util.c                |  142 ++++++++++++++++++++++++++++++
 tools/testing/vsock/util.h                |    7 +
 tools/testing/vsock/vsock_perf.c          |   10 ++
 tools/testing/vsock/vsock_test.c          |   51 +++-------
 tools/testing/vsock/vsock_test_zerocopy.c |    2 
 tools/testing/vsock/vsock_uring_test.c    |    2 
 15 files changed, 197 insertions(+), 64 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.12.71

Jens Axboe (1):
      io_uring/rw: recycle buffers manually for non-mshot reads

Konstantin Shkolnyy (1):
      vsock/test: verify socket options after setting them

Menglong Dong (1):
      net: tunnel: make skb_vlan_inet_prepare() return drop reasons


