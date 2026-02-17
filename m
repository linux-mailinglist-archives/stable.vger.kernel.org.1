Return-Path: <stable+bounces-216828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJeOKq9ulGk0DwIAu9opvQ
	(envelope-from <stable+bounces-216828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:35:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ACC14CA58
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8A5D301E94F
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170EC36AB5B;
	Tue, 17 Feb 2026 13:35:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871C532548C;
	Tue, 17 Feb 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335338; cv=none; b=KWEHf1wOS20svOq1ew9H0sYPGBeQZxdIWhwWW2UmgxW+7XSGv7QNLb0OiXtSHQs65p92FTLJGSBUzkeKdOcXyh8qWi7vmB4sRP+NZWSK2Spb8WEkqZwchYQWPAXX73WY3sauSblnlMIG33G6+fQjUjQuOU7SHjbNDyWsr82KqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335338; c=relaxed/simple;
	bh=ErQaq2N1OpIlQ8O1BU3XfX0wBySppb/0vbxAZ5EOsH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4FYkEUX4V6yYcsLt/fX/DS2CE8098VQtcTRxoqQe8LPzaHraL79gHxaMfQCAvowOoHjHi2gMlxHaTkTXzFPZZuPUr4fagg6VyPgHIx5xvRjwjgrnD4a4N8W3q6D2GWdAWghLiysdAS7E6VgZoX19JJg8tNhVrddSMui+Qi08kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90B221477;
	Tue, 17 Feb 2026 05:35:30 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 988F63F632;
	Tue, 17 Feb 2026 05:35:35 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jack Aboutboul <jaboutboul@microsoft.com>,
	Sharath George John <sgeorgejohn@microsoft.com>,
	Noah Meyerhans <nmeyerhans@microsoft.com>,
	Jim Perrin <Jim.Perrin@microsoft.com>
Subject: [PATCH 6.1 0/3]  arm64: Speed up boot with faster linear map creation
Date: Tue, 17 Feb 2026 13:35:21 +0000
Message-ID: <20260217133527.2881603-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216828-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37ACC14CA58
X-Rspamd-Action: no action

Hi All,

This series is a backport that applies to stable kernel 6.1 (base v6.1.163), for
some speed ups to enable significantly faster booting on systems with a lot of
memory. The patches were originally posted at:

  https://lore.kernel.org/linux-arm-kernel/20240412131908.433043-1-ryan.roberts@arm.com/

... and were originally merged upstream in v6.10-rc1.

I'm requesting this be merged to stable on behalf of a partner who wants to get
the benefit of this series in Debian 12.

Thanks,
Ryan

Ryan Roberts (3):
  arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
  arm64: mm: Batch dsb and isb when populating pgtables
  arm64: mm: Don't remap pgtables for allocate vs populate

 arch/arm64/include/asm/pgtable.h |  7 ++-
 arch/arm64/mm/mmu.c              | 92 ++++++++++++++++++--------------
 2 files changed, 57 insertions(+), 42 deletions(-)

--
2.43.0


