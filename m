Return-Path: <stable+bounces-230752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FhObHkEnx2kJTwUAu9opvQ
	(envelope-from <stable+bounces-230752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:56:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9AD34CD66
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ED1F305C918
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 00:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83CE2BE7AB;
	Sat, 28 Mar 2026 00:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFCSSc/2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61E293C42;
	Sat, 28 Mar 2026 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774659256; cv=none; b=CsaPkFqb3uhnZecjiFmGwuTiNBdMOZvXihNrWxM3/K9BHrknTfC4FiL4ZlwUNpZrre9Gh1XzsmFFid39oK98B9nXU1yxZ1cNqzsl4N/eNSNH3Uhh6v12Y3e5XiJgZn9QldPepu/aleHu8r/2EVO/a3z06Ngnn/vm2RbXxYC638M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774659256; c=relaxed/simple;
	bh=eqhm9Aq5Rmy+djcCUmMPesUDKO1sEknpkkUB6CDAm+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlxfBYEAPIrPLI9YVfS3+pXuHkS6+B8xSK+R06926CURXE3nclyZ+GEO2HlQyZrpYsUkr0zIY+RBnpfq57WoOSQPAP2tY5uIyY//NYqpNxmFkYuy7g4zwojZUHrcT71IGk7IEjaCMC4x00jSnuGK3g7SXHyt++81z1ZdQnj9pgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFCSSc/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7F6C2BC87;
	Sat, 28 Mar 2026 00:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774659255;
	bh=eqhm9Aq5Rmy+djcCUmMPesUDKO1sEknpkkUB6CDAm+M=;
	h=From:To:Cc:Subject:Date:From;
	b=HFCSSc/23NanR4XsIuzvw0l1DNRe67PZcYr5rpdC+unT7lDLwnmnHVoZHVMbDXNeW
	 4ViAhTUYX8STYy6HUjLOOUq3Mhrf7LXxtec9l6SJ9Njta7pVwYeGUCrG9xIjelMJdo
	 noGWmSGemPgTi//MkGwY/95WwuGvJtx9D6pyCLjeZQQ7o4KG9VIVR4xI46yoQelvpE
	 /v0T41RB8MoDhneqA2t29DJCLDylRWjB0O4w4khxDwIoxsjHNR3catYhwDg0ULwhD2
	 4y1VvF64zfdtYJ5WbwIWsd+33A/Lz2po6My64SXupstxAZ5ZcIRChzjoMGRDqfbN47
	 DskMYTdJrKsjg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] mm/damon/core: validate damos_quota_goal->nid
Date: Fri, 27 Mar 2026 17:54:08 -0700
Message-ID: <20260328005412.7606-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230752-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD9AD34CD66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

node_mem[cg]_{used,free}_bp DAMOS quota goals receive the node id.  The
node id is used for si_meminfo_node() and NODE_DATA() without proper
validation.  As a result, privileged users can trigger an out of bounds
memory access using DAMON_SYSFS.  Fix the issues.

The issue was originally reported [1] with a fix by another author.  The
original author announced [2] that they will stop working including the
fix that was still in the review stage.  Hence I'm restarting this.

[1] https://lore.kernel.org/20260325073034.140353-1-objecting@objecting.org
[2] https://lore.kernel.org/20260327040924.68553-1-sj@kernel.org

SeongJae Park (2):
  mm/damon/core: validate damos_quota_goal->nid for
    node_mem_{used,free}_bp
  mm/damon/core: validate damos_quota_goal->nid for
    node_memcg_{used,free}_bp

 mm/damon/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)


base-commit: 7da5718476562bc8136c08216a1621aac09bcb51
-- 
2.47.3

