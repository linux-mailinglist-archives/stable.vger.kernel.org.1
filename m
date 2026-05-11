Return-Path: <stable+bounces-245104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIPeKzR4AWpGaQEAu9opvQ
	(envelope-from <stable+bounces-245104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:33:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C6C5088F1
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC333301A72E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 06:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441442BEC2C;
	Mon, 11 May 2026 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uEiK/uxw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21B224AFA;
	Mon, 11 May 2026 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481193; cv=none; b=oH2i3m7tGEbLFdByW1+ADOsylzsX3wBLiogchcXCsrkfCfqh14SBc2EsZyzpAq44cxtLPslA67qP7SiuCjUyhZ+CX6qAcCgEszcQAKk3M/YGRsXK8TI+/DOo+wNkGcxDe5d3he0ADrDrQpgkbkWpJuh2NFs+kbBXtjxvd2DyNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481193; c=relaxed/simple;
	bh=0ZvXgo/RuGTOi+8wcFPDBhU+8ff1DPuhGhMGifxb2Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0qUeUFoe+mazV1oVJbNz78zSfKltpl2mnJGoZNiKktgd6kpDpju+/rzS/exElozF6awDcg2nc6SE3FH/YEz+kUQzOR67ZjVPJqyBGg2J4VSYUYwCI6QQxO4AmaSOD1RYz7B9UKXo0P6lqDeHyeNdcfl57MwxPUmve2bPkY6zHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uEiK/uxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CAAC2BCB0;
	Mon, 11 May 2026 06:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778481192;
	bh=0ZvXgo/RuGTOi+8wcFPDBhU+8ff1DPuhGhMGifxb2Go=;
	h=From:To:Cc:Subject:Date:From;
	b=uEiK/uxw0og6IcL6rzmp/MI0hTTUNBOoVke4FbI5TkFJ9aw0thQ/ToIv0cMnm32MG
	 DfyaE8xWXWqARJCCUIsTpZZ0lGBHsqRqOHHzYUkTcdZXVv88qjmZwapcRiCmvlbdxr
	 xHsXpN1NyaFMqR+0C6WbJTvroRPI4t9xHvreZhH4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.29
Date: Mon, 11 May 2026 08:33:08 +0200
Message-ID: <2026051107-clash-designate-852d@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 37C6C5088F1
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
	TAGGED_FROM(0.00)[bounces-245104-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I'm announcing the release of the 6.18.29 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile               |    2 +-
 net/rxrpc/call_event.c |    4 +++-
 net/rxrpc/conn_event.c |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.18.29

Hyunwoo Kim (1):
      rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present


