Return-Path: <stable+bounces-240333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKCGIRre6GnOQwIAu9opvQ
	(envelope-from <stable+bounces-240333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:41:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6AD4475D5
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F67F30783A0
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F933ED5C7;
	Wed, 22 Apr 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j72L0/mI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5934E765;
	Wed, 22 Apr 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868508; cv=none; b=oukhpLuiss4eP0vLxfH6fZ4bixqQcJQEeLBlsAUMiFRd6d/QaK6F2e/zcyaJIApc//WWWUuOQ4pUeixUz8N6UVhSltJhmKlGjBT25wMBg23ytgLVdjlHJNS/2H+mbpRA3YF0eIxZbhptWLLqXin1JKlSd0NG9Bs3On7/FipC2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868508; c=relaxed/simple;
	bh=bi6XcGwk5Sb2RtrCfQVAavSWJYWkUYMGONOn/G5G6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=snM+LEnQQtINofC+WuSb5VS6/o7z8B7DHFfJx/UhmagsSH8vO4gzQ5Jyln8Xb4bgDClSxmVrTwGErOADWmQSOPKzdwbfcsJS3a0M3m+RNEsyvDOx8ZVwlIN3Z1M02N6pb3hafflgMC5gqHVjq6/TGnOL5iH6cEdFBAWbpCSeLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j72L0/mI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF38AC19425;
	Wed, 22 Apr 2026 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776868507;
	bh=bi6XcGwk5Sb2RtrCfQVAavSWJYWkUYMGONOn/G5G6lQ=;
	h=From:To:Cc:Subject:Date:From;
	b=j72L0/mI2RW3vfdJ3HLLEjpK4h7FpsFh8HwcMuZLZue/4Y0Cv4hPqIJj5chF6p6kl
	 ZtW4fD+t1j7RLaCGfaS70ssc3fatz7PyJmxkCI3GfwFCuzuABpraWCWok8W6DHYKvS
	 xNjBEnfGwrqj+kalLhz5RV/PwmF7mGW/gGDAsOkR/2X6Xig5XxOoSe4mNXgL7rt8Vh
	 SCNboo+cs9bGVI9o6p59CkZnSJF8MIUVTKENZvP+z5J3dYDxCSZMbyW4UNWL2zVRHy
	 fk2VU/adTpaNWVfA7jc2STqEyg/GIeiomUnEUMlxZ3m3pDanwjtsABT8GEucSKnYrD
	 zE9O5RefrPS6A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] mm/damon/sysfs-schemes: fix use-after-free for [memcg_]path
Date: Wed, 22 Apr 2026 07:34:59 -0700
Message-ID: <20260422143503.71357-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240333-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C6AD4475D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reads of 'path' and 'memcg_path' files in DAMON sysfs interface could
race with their writes, results in use-after-free.  Fix those.

SeongJae Park (2):
  mm/damon/sysfs-schemes: protect memcg_path kfree() with
    damon_sysfs_lock
  mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock

 mm/damon/sysfs-schemes.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)


base-commit: 0d45806f3a75bf53e59475b0e56be324f650ab09
-- 
2.47.3

