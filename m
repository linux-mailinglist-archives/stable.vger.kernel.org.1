Return-Path: <stable+bounces-268592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K6wXGptIPWoo0wgAu9opvQ
	(envelope-from <stable+bounces-268592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:26:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 565446C709F
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:26:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=e07tngQX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268592-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268592-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DBBE3012DBC
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051553E835E;
	Thu, 25 Jun 2026 15:26:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1A37C918;
	Thu, 25 Jun 2026 15:26:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401173; cv=none; b=fpUSYzW1kecr2OnNrY2xc6hjoES0oTRlfSpsZr0ZzWie1ZpyexACsjcpHfjVE0c+AlmGAoLXRNPAIMJ4kq1XdwsRpyzirloIPSee1XrLimUbZVrq+2RtqrWz2JJuq4RDMOVjk8i9j4fSVJ/SvYEss4s71lLgJbZTGxGqVLv0ldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401173; c=relaxed/simple;
	bh=QDSOj/4/w2gbarjned5kuy5E43lZkbh7k7a9mdMLyBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GE3MAlnG4GR/JInp4e+dkpA3cYkl6Ybdf63J9QF2KteT9aVC1ATQqLMxoblvKlped3gEbVofmRzy+56DMGm3ysA+1sTHhAdARU5iWJIzkXZcq5mpy0VTr2HjmU/5vvCRVUOWGj0wwmnBnEyaW5MYBRyeuhSG5TK1I6ShbhZzVFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=e07tngQX; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782401169;
	bh=5CnqIZrXbOvj5YTogFA5mNwwB12cmB+wEc2uMYZ9VoI=;
	h=From:To:Cc:Subject:Date:From;
	b=e07tngQXAOEZscw7ItyoLzxMsp7Ue3bldidYfHVIzLCq6lk4TxQcueMgQ9+yxl3dz
	 3xNtlINvBBG2n81B7hmWnqomB805PfqiomxKlInI5v4VW66KJAMOqJW6Q3z4tMAQH6
	 yD4iwzTxJJ6gJBE8x4H+AFLjVPljCZbA1sYBgB6s=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gmN1Y5KFRz10hn;
	Thu, 25 Jun 2026 15:26:09 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gmN1Y0NDvz10j8;
	Thu, 25 Jun 2026 15:26:09 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v3 0/4] sys_info: prevent duplicate backtraces
Date: Thu, 25 Jun 2026 15:25:54 +0000
Message-ID: <20260625152558.7450-1-include@grrlz.net>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[suse.com,linux.alibaba.com,ellerman.id.au,gmail.com,kernel.org,linux.ibm.com,chromium.org,vger.kernel.org,lists.ozlabs.org,grrlz.net];
	TAGGED_FROM(0.00)[bounces-268592-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:pmladek@suse.com,m:feng.tang@linux.alibaba.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:maddy@linux.ibm.com,m:dianders@chromium.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:stable@vger.kernel.org,m:include@grrlz.net,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 565446C709F

Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
When they strip that bit, an all_bt-only mask becomes zero and sys_info(0)
falls back to kernel_si_mask, potentially duplicating output.

This series adds sys_info_with_filter() to filter specific bits without
triggering the kernel_si_mask fallback.

Changes since v2:
- Use sys_info_with_filter() instead of sys_info_without_all_bt() per
  Petr's suggestion
- Filter applied at __sys_info() level to handle kernel_si_mask correctly
- Added panic.c conversion

Bradley Morgan (4):
  sys_info: add helper for callers that print some sys_info on their own
  watchdog: use sys_info_with_filter() to avoid duplicate backtraces
  powerpc/watchdog: use sys_info_with_filter() to avoid duplicate
    backtraces
  panic: use sys_info_with_filter() to avoid duplicate backtraces

 arch/powerpc/kernel/watchdog.c | 12 ++++++++----
 include/linux/sys_info.h       |  1 +
 kernel/panic.c                 |  2 +-
 kernel/watchdog.c              | 12 ++++++++----
 lib/sys_info.c                 | 20 ++++++++++++++++++--
 5 files changed, 36 insertions(+), 11 deletions(-)

-- 
2.53.0


