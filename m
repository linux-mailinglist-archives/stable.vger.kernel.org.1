Return-Path: <stable+bounces-240986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id orD4CSyC62n+NgAAu9opvQ
	(envelope-from <stable+bounces-240986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:46:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9938A460583
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21C143008741
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4250F3DFC61;
	Fri, 24 Apr 2026 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tac2xG9N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444B3DA7E0
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041960; cv=none; b=CAcjxukAdfKadlXq3PlpdIlPZMIgQOVlZFzYBo0FEwOYh8R3cO+hVAOGriZ7xEAF8D1FmTK+n/FeB/OhJbC2AbzNkq3PdBAscG2Js9Se7uQSE+GDoBaMIQuJuVv0HreDkWZmRXhN6Kxb4hjxb2k/kQapy2XjnwMi1eAz6IqlXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041960; c=relaxed/simple;
	bh=GhRtXjymjCNijOdTAQCVBgkGME0C1c0P4CwG9l0l5SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnvIsZq+6h/ZR6V8HAMDsgoQ9wqenXxXtlT47MSgTgwpnQyBviYrBfHNIrFaO0xUhjfYneaaU/wJHTnVz2n7Rm8i5dc/sS7j1jyioB8zc2Z262HyDncqJs7HSIxM4jvQ7IgA5noYolPP1ITULLQrm2bSg2CV07PMDBuGI8qSsrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tac2xG9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550ACC19425;
	Fri, 24 Apr 2026 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777041959;
	bh=GhRtXjymjCNijOdTAQCVBgkGME0C1c0P4CwG9l0l5SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tac2xG9NO74YSVpt8VlQCUKxF9hDGezxWyYfCr56g46K/6/N0rjts0lEu/sfL0gAN
	 M6NFpSRCG33l76ay20VnJHaBv5SuE2XWTO++5hki6XM+JsHGO+JgdyAyIiwUDeTIcM
	 ZWPPh/9RTNx5zYjgN9HXnKb7QZX/uIec81gZdyll3keTfM7GBoMlNTPmlvLkIrLxrP
	 1osGxzQJJbWZtZ7tr8eH9BMWb+K6oGjMmPXsIubts2mjLXnLmE6gYHdm/5O/kxFECs
	 o6voPxq9+r6ZF9MP5N3bWBCj3ztI3ILhfdyvPvASOt185O4A8ES4j93r+irPdltNZd
	 gh38zsSc+JaPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: require a full NFS mode SID before reading mode bits
Date: Fri, 24 Apr 2026 10:45:56 -0400
Message-ID: <20260424144556.2184965-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042430-gumball-harmonics-5661@gregkh>
References: <2026042430-gumball-harmonics-5661@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9938A460583
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240986-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 2757ad3e4b6f9e0fed4c7739594e702abc5cab21 ]

parse_dacl() treats an ACE SID matching sid_unix_NFS_mode as an NFS
mode SID and reads sid.sub_auth[2] to recover the mode bits.

That assumes the ACE carries three subauthorities, but compare_sids()
only compares min(a, b) subauthorities.  A malicious server can return
an ACE with num_subauth = 2 and sub_auth[] = {88, 3}, which still
matches sid_unix_NFS_mode and then drives the sub_auth[2] read four
bytes past the end of the ACE.

Require num_subauth >= 3 before treating the ACE as an NFS mode SID.
This keeps the fix local to the special-SID mode path without changing
compare_sids() semantics for the rest of cifsacl.

Fixes: e2f8fbfb8d09 ("cifs: get mode bits from special sid on stat")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsacl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index ef4784e72b1d5..472a110158eca 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -757,6 +757,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 			dump_ace(ppace[i], end_of_acl);
 #endif
 			if (mode_from_special_sid &&
+			    ppace[i]->sid.num_subauth >= 3 &&
 			    (compare_sids(&(ppace[i]->sid),
 					  &sid_unix_NFS_mode) == 0)) {
 				/*
-- 
2.53.0


