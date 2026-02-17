Return-Path: <stable+bounces-216824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODknNWZulGk0DwIAu9opvQ
	(envelope-from <stable+bounces-216824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:34:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD2914CA06
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D5C7300B87F
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B52E360758;
	Tue, 17 Feb 2026 13:34:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8917E32548C;
	Tue, 17 Feb 2026 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335265; cv=none; b=ikP+yF6XnekU/uM6mv94ILqp5n6qlTPPqrqIhR7yEbl/9M70dt+ud894/rjag37fi1sNF/KBSKf21woAoPplDO+46YR/ItSA3WQ3HeZ6hM8xsHy5kjUjkhy3a/ZLvug92qOU7zbOnGo/rOqPm0YwXM5s9KzSvKpF9ia9/82SbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335265; c=relaxed/simple;
	bh=35EcbOx3vdvBUlCfifywkKBqu/GT7DxuOwi/k8gtogo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvBuKXFUK6OsTW/L+jLmLgjElEWCToaXu4hhpmWXlVdemh4fF7UncRkX6j4Cw5wnvXCD67wpOOljmHt99lByxky4WKginwVUF5DweIziXb0HOcf/rgcSOeK+x5f2pzVFKPaHWeS9RYQqQiaxUYaFGBt5nBARepaEO0D5HWi7Upo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A5ED1477;
	Tue, 17 Feb 2026 05:34:16 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A12F93F632;
	Tue, 17 Feb 2026 05:34:21 -0800 (PST)
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
Subject: [PATCH 6.6 0/3] arm64: Speed up boot with faster linear map creation
Date: Tue, 17 Feb 2026 13:34:05 +0000
Message-ID: <20260217133411.2881311-1-ryan.roberts@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216824-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid]
X-Rspamd-Queue-Id: 6FD2914CA06
X-Rspamd-Action: no action

Hi All,

This series is a backport that applies to stable kernel 6.6 (base v6.6.126), for
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


