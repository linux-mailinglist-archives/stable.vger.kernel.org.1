Return-Path: <stable+bounces-216730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHDEJtlEk2kP3AEAu9opvQ
	(envelope-from <stable+bounces-216730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:24:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F22146187
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C204A3034E18
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4690329E53;
	Mon, 16 Feb 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z+U9LMl2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B49242D76;
	Mon, 16 Feb 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258753; cv=none; b=AqK3vZO1ctJhHyHmj8Jr9/57QJZ2k1BPAZBNfcG0bN6PTPj7eKP2y44wwoQOOc+XNWNiZlD58gd+AkS7OOn9R+lDzr2f/nacRAwq04YZo9uQCmtUQNixZZWLJx4qcBNGcLiMXiN4hrjjLnf9rukuBrkxDqKfE8IPhiW4s8R/vnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258753; c=relaxed/simple;
	bh=N0xmiEw0x+IUwYqDQqtXStfFadaAz5GeYMAdp0PRxLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BfdvjDr/2Ul8BSz0yY1hXb5spPHpndwasu7XiyiQ77F/HFaXd1Sc71OrMBfgkMftGTqjFWn2zccWMXHIp/oJJ21UyeCegoBRgDwl18i7ZugNGu3SD+taGWThkf+tanprnPnHiSlkoq5BQ4S6Wc3Ma7h9HBQpQGQ/zKftt1PNodg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z+U9LMl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15F8C116C6;
	Mon, 16 Feb 2026 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771258753;
	bh=N0xmiEw0x+IUwYqDQqtXStfFadaAz5GeYMAdp0PRxLE=;
	h=From:To:Cc:Subject:Date:From;
	b=z+U9LMl2DkQNrQSh1KMOfvZVIK8DNwT+UPkYnzstD/W6tIzqKJuIrbrccIyRj6CQm
	 zBp2sx14wgHl2pHYmrdM8Qa43tcHDrW7A8ZXnZHTyLEwnTUsQNEWn3n9fOCelDNkjt
	 NsPqGz+nvv19bAS88LFAX+2A3zMued82N98FHy1E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.126
Date: Mon, 16 Feb 2026 17:19:08 +0100
Message-ID: <2026021650-sneezing-establish-a5bb@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216730-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24F22146187
X-Rspamd-Action: no action

I'm announcing the release of the 6.6.126 kernel.

If your system did not boot in 6.6.125, then you should upgrade, this
reverts one problematic commit.  If the last stable release worked just
fine, no need to upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile            |    2 +-
 drivers/base/base.h |    9 ---------
 drivers/base/bus.c  |    2 +-
 drivers/base/dd.c   |    2 +-
 4 files changed, 3 insertions(+), 12 deletions(-)

Greg Kroah-Hartman (2):
      Revert "driver core: enforce device_lock for driver_match_device()"
      Linux 6.6.126


