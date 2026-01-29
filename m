Return-Path: <stable+bounces-212752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFMLH6Yne2nRBwIAu9opvQ
	(envelope-from <stable+bounces-212752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 10:25:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 251FFAE1B2
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 10:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1526300A61C
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826D737F728;
	Thu, 29 Jan 2026 09:25:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26E937F756
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678756; cv=none; b=Ssv0GCr3frWKpRu3COsaesouw5DbpZaSJm0eOjOugX8UVC+s9Q4t5mwn5+PmzZoL9N24k5mBSrLDa0ShRBXnrvwvFLpCywtj/VyuywDnwWRs7D2ndMLTcwmb8ZRhP2+nR9yBS9RVeXkwWpl34a96ubzt4FEFGByrVfO3f+Ut6Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678756; c=relaxed/simple;
	bh=juhwcs64IHANHUUHqUh4B8ZIL7sNHsuVp86/J3Ce36Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q5HG//fBBa+BX2CPvAxpedgYSgh+rvB6Ao/3b+aKVDTuFKac1VnD9TdSA+plyrujwknSB+5Ihtv6zJHvBPq4Lj7ewCynroAQUaJ3iYyGDEefvgDHKGwlWd13M/BWjs4JBWtorA3Z3VURoROlJP2yzs5hl5un0JYZ/JJrXgzUFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4B451516;
	Thu, 29 Jan 2026 01:25:46 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.33.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F343C3F73F;
	Thu, 29 Jan 2026 01:25:51 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org,
	tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	sched-ext@lists.linux.dev,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCHv2 0/2] SCX kick fixes from 6.19
Date: Thu, 29 Jan 2026 09:25:44 +0000
Message-Id: <20260129092546.49128-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212752-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 251FFAE1B2
X-Rspamd-Action: no action

See https://lore.kernel.org/lkml/20251022205629.845930-1-tj@kernel.org/
These apply to linux-6.18.y
The issue also affects 6.12 but that reuires a different backport.

v2:
- Add the sign-off, no other changes

Tejun Heo (2):
  sched_ext: Don't kick CPUs running higher classes
  sched_ext: Fix SCX_KICK_WAIT to work reliably

 kernel/sched/ext.c          | 57 ++++++++++++++++++++++---------------
 kernel/sched/ext_internal.h |  6 ++--
 2 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.34.1


