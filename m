Return-Path: <stable+bounces-247768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P+oEGYcB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:15:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CCE550502
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B278308212E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1AE339853;
	Fri, 15 May 2026 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AP8ROBZg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A23093B5;
	Fri, 15 May 2026 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850358; cv=none; b=f367SvY3hr2hcUpK7ZPvuEpo6p8A5CXhE1lvEQ8lZLwXPDjQhZEQ2RLTIZWpd24gkkhUKiOsnaV+CuO6bmbkDlwZavfLio7Ttlu44h524Mza7FNYfRH0VLYrUKeo8srajxx2efO5TRHvXmZEKpI+DN9iBXv8yE6QTiUgfSmwya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850358; c=relaxed/simple;
	bh=vJi5Cl/aN6/yo1lEXyhAsMboPt7eraXTO/OeEuZ1VbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHXJzt2jxJApXVH7ntiEJt5v2f56kWk4vcTuwdby0wJYsDVtTFvzTCQYZ3mwGWGhs2om3OfcO0QPmiWAZmz3rTChZYu4S2uTqD7tY0YurIfZrzMX5xxTeG2RhodaAtQ+mLN5klZD7t4CBcdHQS95+GFYQmvRZTZrjc/U1hsNMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AP8ROBZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2C2C2BCB0;
	Fri, 15 May 2026 13:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778850357;
	bh=vJi5Cl/aN6/yo1lEXyhAsMboPt7eraXTO/OeEuZ1VbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=AP8ROBZgJIh8teAm7ZFyBFgZblYWzu9+SAJrRKXFO1JDz4JCRhxQaJIDwBY/Ge2P0
	 ez7vaT6Getqua9GyO47a9VVk/JtqWPyhcUEWvkEuDimtA/UIoTJ6ee6Hfhl/9y978Z
	 RHDFlEh21l3NSksCEC37gq9ENofPgtw2QKEjA3Tg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.89
Date: Fri, 15 May 2026 15:05:57 +0200
Message-ID: <2026051558-squishy-rubbing-7ac1@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C8CCE550502
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
	TAGGED_FROM(0.00)[bounces-247768-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.976];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I'm announcing the release of the 6.12.89 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile              |    2 +-
 include/linux/sched.h |    3 +++
 kernel/exit.c         |    1 +
 kernel/ptrace.c       |   22 ++++++++++++++++------
 4 files changed, 21 insertions(+), 7 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.12.89

Linus Torvalds (1):
      ptrace: slightly saner 'get_dumpable()' logic


