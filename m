Return-Path: <stable+bounces-211447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP5DLveOdGmw7AAAu9opvQ
	(envelope-from <stable+bounces-211447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 10:20:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4C7D105
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 10:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49E6D3012BD4
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE941C5D57;
	Sat, 24 Jan 2026 09:20:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805903EBF34
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769246453; cv=none; b=T9J67YdxRZ5UF1Pmz330BZqusRVjQhfJD2wVeWuiD8M+jvuP/wIHeTVvSyGJ07dSJzhcQFYQK9MMoYNzFaLlGY0q99hswLMPIyzaqwwTtgibpedSCpizGLpVobnAOAEaq09vMYdBfoS8DW5uwjai4mZtk7eEWXkcQ08jOuz/EHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769246453; c=relaxed/simple;
	bh=4jCaWuby+q75eLXUzGE2JYwbV9Xd6JSl9WJZJjzBjTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MrSMxOlC/u1mYQbOQFhLD2lhVlpmKhV8JsB+z/UpxiwDY2ybVie+I4A/GzK4V0q6OeGMYxUolBwzdhjrG+crP5eVaRRidkjw1GH6GrvPkhWyRO6DVlcJms6XFR2l4BLSYGpVHiMvMb5pDuxuSupT27T9WlJDTI7IpSzTIS3afac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3912E1476;
	Sat, 24 Jan 2026 01:20:44 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.81.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EB0C3F73F;
	Sat, 24 Jan 2026 01:20:49 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org,
	tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	sched-ext@lists.linux.dev,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/2] SCX kick fixes from 6.19
Date: Sat, 24 Jan 2026 09:20:41 +0000
Message-Id: <20260124092043.349976-1-christian.loehle@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211447-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid]
X-Rspamd-Queue-Id: 52D4C7D105
X-Rspamd-Action: no action

See https://lore.kernel.org/lkml/20251022205629.845930-1-tj@kernel.org/
These apply to linux-6.18.y
The issue also affects 6.12 but that reuires a different backport.

Tejun Heo (2):
  sched_ext: Don't kick CPUs running higher classes
  sched_ext: Fix SCX_KICK_WAIT to work reliably

 kernel/sched/ext.c          | 57 ++++++++++++++++++++++---------------
 kernel/sched/ext_internal.h |  6 ++--
 2 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.34.1


