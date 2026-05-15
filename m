Return-Path: <stable+bounces-247771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH5wDPccB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:17:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0380550553
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38C1E30C382C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8093836894F;
	Fri, 15 May 2026 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hAw5nz0Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDE3101BF;
	Fri, 15 May 2026 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850367; cv=none; b=KStq2CJQXzu5WiSW36NvaplLUsjnUI+tMrcnCcJpBTOJmOBqvrQ9icUTYfU3cQpiTrZ522wQBpAmIVsQu+rDFuvoT0et5craDYYzrMTgsOaBq3a7v/XQeT241qVBHGDroZHRunbJ9WxvsXajuHoRKff/gAl4jCHw5CnpknASinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850367; c=relaxed/simple;
	bh=QVD0KJ7l46HVuqu8dkvhPSk12DuL543VTvYxVtZ701I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/N9Dga087KLyVwTBeQG1bkckhf+aEFoNHj4SHbcMENJ9LGV1wEoL6NwnWgTKAXscy9/mmWkQtYmtrYxOdHk4Fp9zlJZu8nw2BZnD+bAzqR07Z2fYdwIrARFg13nMKkaR/xmdMHKOgl5UqF9xV89AQb6CIaCZDn3lK7JTzzjglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hAw5nz0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC1DC2BCB0;
	Fri, 15 May 2026 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778850367;
	bh=QVD0KJ7l46HVuqu8dkvhPSk12DuL543VTvYxVtZ701I=;
	h=From:To:Cc:Subject:Date:From;
	b=hAw5nz0Z9J91aBmrKPZBu41oraKNpC4Ry5yy3TxVYT/ojlrGWDIhW6KMVi49RzGrN
	 Y/dBQAfPpfIsEOKQ3yzLxzOitvLDyO6dOi9HRYkCWqp+YTtZ8ZrV4ACcnbuMFRY6Fh
	 LU211JDKZyxXXcwWu64Y0P2A36eQlKlbxrOpfLGM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.31
Date: Fri, 15 May 2026 15:06:03 +0200
Message-ID: <2026051503-cactus-obsessed-a6af@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E0380550553
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
	TAGGED_FROM(0.00)[bounces-247771-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.977];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

I'm announcing the release of the 6.18.31 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
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
      Linux 6.18.31

Linus Torvalds (1):
      ptrace: slightly saner 'get_dumpable()' logic


