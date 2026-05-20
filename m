Return-Path: <stable+bounces-251457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFHMINoaDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:34:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D74599CAA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0A1A3359B7B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9A3E0C70;
	Wed, 20 May 2026 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xA/ezMGZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8DA36A36A;
	Wed, 20 May 2026 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298031; cv=none; b=rm184FrRM8efeIUfn0aYbJbfBISQK2yCSDuKdT8BkMPcrV7/lKjQoSlX0wMKTg4yuMJUJriM200t7s+mJZeuFy8vTGNY1Pme+ETDoLAvZw/Zw/jHSryWkjCwA9dIbOnVZHJCXAc+dI7cjkkXyT+47Ffz3LjBIvfuW4tzMUjxSok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298031; c=relaxed/simple;
	bh=qxHRYBSsM8alJHtak0KtnkwbHAzZyjWYtYJXeH3Pgcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2aT7TdBqK7K1aTb63961wf/FZVisHDZst0kNr0SK8Qi8k2LoBl7YaLOfwgvhNR3ESm/2S7z3kP9I1x2AB/KVicHnwbPXIwFCWXDUFyhsNWuIkJkiG2cbQe80Z16zOwJCzE1ICp85RPXxdOYrOMaRQNUdODF5CSBINYHNRYrE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xA/ezMGZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1E91F000E9;
	Wed, 20 May 2026 17:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298030;
	bh=CX3FcvWLjdTPQ3BCdnFDwDdJ+c/kH9kyqmekbtssWNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xA/ezMGZdMnQPzCbgIToaDzwSRmR8FcQIFBSVw/D9qK3bzmuvGiRKglx30XmtaATL
	 o4fyu9+kTV6nWRjtJp3yA6ojbn8hKdq7Z3iGgCuLREiXdve96/cfMiL3/k/cpfY97s
	 ZSMFYAGflaX/aUsCxq62s0PO+qKCpcaeD2wh9nzg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 219/957] selftests/sched_ext: Add missing error check for exit__load()
Date: Wed, 20 May 2026 18:11:42 +0200
Message-ID: <20260520162139.291211195@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-251457-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: F3D74599CAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 1d02346fec8d13b05e54296ddc6ae29b7e1067df ]

exit__load(skel) was called without checking its return value.
Every other test in the suite wraps the load call with
SCX_FAIL_IF(). Add the missing check to be consistent with the
rest of the test suite.

Fixes: a5db7817af78 ("sched_ext: Add selftests")
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/sched_ext/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/exit.c b/tools/testing/selftests/sched_ext/exit.c
index ee25824b1cbe6..b987611789d16 100644
--- a/tools/testing/selftests/sched_ext/exit.c
+++ b/tools/testing/selftests/sched_ext/exit.c
@@ -33,7 +33,7 @@ static enum scx_test_status run(void *ctx)
 		skel = exit__open();
 		SCX_ENUM_INIT(skel);
 		skel->rodata->exit_point = tc;
-		exit__load(skel);
+		SCX_FAIL_IF(exit__load(skel), "Failed to load skel");
 		link = bpf_map__attach_struct_ops(skel->maps.exit_ops);
 		if (!link) {
 			SCX_ERR("Failed to attach scheduler");
-- 
2.53.0




