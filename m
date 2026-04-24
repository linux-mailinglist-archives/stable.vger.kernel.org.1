Return-Path: <stable+bounces-240984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLh2B+l/62lLNgAAu9opvQ
	(envelope-from <stable+bounces-240984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:36:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6770746048A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF35301112E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CAC3DCDAA;
	Fri, 24 Apr 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxdeLR99"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8F3DBD65
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041222; cv=none; b=Rvx1rLF9ihH2VatKCjmqmTYBrghL2TIdDIGlCKRd6+Ug8AaRa5RWArBH8xx5F+RrkgID+F2DGyO+sVK7cnTmwYfO/RcMUHVjTMV2DWap+PFIgWeJhT+lmMTlXR4zG8uhO8hzMLoZr/+Gi301785Ptt2r3ZW3gHmPkyu6bXs9KZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041222; c=relaxed/simple;
	bh=Wl1Y8epJen+zJQcpjlkXfh383DafM/zdX5VqJz6vFDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUc25rUWclYjqSn5aAreJ1l27GjGaOTZehD5PK84jBjMeltXcZER4P0JfU/PwTkM05/WYeOIVzqiwy0UP0VVjdJzjBTQ43zbSi4LsTUUTR4fN951tnueuOjS48ZV3CxKNl58l8p+Vbi0CDZTI9s7FWS+/oxAQ75+c50VKOQGdvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxdeLR99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546D2C19425;
	Fri, 24 Apr 2026 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777041221;
	bh=Wl1Y8epJen+zJQcpjlkXfh383DafM/zdX5VqJz6vFDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YxdeLR99iL8n5Bo8lvAPlcx3yuuLqIGNZiyd6lquWMaS48ilzNzwVBv6mQMHxG4xp
	 Pnf07bc5wotd+LL+f4rtNscBteY9cRSVxEn88k+TkontSS+epGR2Pi4Z+ZZe7gMfkJ
	 SAf/itMxPm1wwftscmtxubsf/r42qZkNuQ70aLvS2Ks68ysdbhanOU1Cl8t8NZBWX6
	 L6+oLYLzIFp2tf9tXLqdAwQInP8CRagTpSmgWskxqgkEpNtXZrh5apyQpEjESk8HMu
	 lQcjy7LWQcpxpCPgNL3xuP8SfYYckPG4AWcMxfHwnmptFkyk8T6u+pdk9N+WqELyNh
	 tmNjAK3ScgYuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: require a full NFS mode SID before reading mode bits
Date: Fri, 24 Apr 2026 10:33:39 -0400
Message-ID: <20260424143339.2171783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042429-hanky-simplify-54ff@gregkh>
References: <2026042429-hanky-simplify-54ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6770746048A
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
	TAGGED_FROM(0.00)[bounces-240984-lists,stable=lfdr.de];
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
index bf861fef2f0c3..0a7fbd9fcdb3a 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -807,6 +807,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 			dump_ace(ppace[i], end_of_acl);
 #endif
 			if (mode_from_special_sid &&
+			    ppace[i]->sid.num_subauth >= 3 &&
 			    (compare_sids(&(ppace[i]->sid),
 					  &sid_unix_NFS_mode) == 0)) {
 				/*
-- 
2.53.0


