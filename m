Return-Path: <stable+bounces-233366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDNSG1WU02lWjQcAu9opvQ
	(envelope-from <stable+bounces-233366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 13:09:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D89B63A30B9
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 13:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BDBB30300FC
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65228330678;
	Mon,  6 Apr 2026 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOon6fDx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2588530146C;
	Mon,  6 Apr 2026 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473599; cv=none; b=qru8F2h8oVO7Kqn5nAuKTmRCGGaBUysjleXDFco0zabcQyiQ83JYsTAcZ8YR0SruB9SSug8uw9XEa94t29yPUXs7a6gS3YWuF/jVmHH791X0W80pdV4sZ4X8IPs/xwVloo6lf9pa6WAdjTSfMq6aTxrMwcYGBU7wotfQEk5iLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473599; c=relaxed/simple;
	bh=na5IVXsQyHZvUf7OCqXlMrqvQYAiJujxOib0idx4bLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMi/ZKqhvaZNhobwpvk4Fve2uydEWGtI+r6bNGbJIeUx8CuNa3QN6F9IU8AtwEbFEuo4JEg16AyPq1IgCi3NCKWn4hs1nQQrAEYJqfZrns9wup712uVyU0n1D26+pu93+/CTZxYHIcwuFox+LE95NIadkw7j5yxkZ8CFQbf1jCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOon6fDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CDEC4CEF7;
	Mon,  6 Apr 2026 11:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775473598;
	bh=na5IVXsQyHZvUf7OCqXlMrqvQYAiJujxOib0idx4bLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOon6fDxxUl7swTlnAAar6ehLQSivctcp6J//OnHKZKptd7A0ikO/AicGpH0Ohz20
	 tK20q8PxZ+njQuoWzPu7ti7UhnOaEFP8xBHRwg//UGLa1AKrHqYv4RgPgJqvIhIGOm
	 y5Z7dTsWpp4P7l+84eWfCW6nf5pQ1tiUGyzalEPdG2QCoSqde/wVd1y2XnP3EukoAd
	 8RD1fPTY2VjgX97xosTMP3D75WnTtHFnYULuXeLnWlnU8/LwTiDgywYCjVNgRneqCB
	 Zf1KWHYB4I3eC3faBZfAGOdJQAFXDmaiec8MDOAZEZbuRnahvHU7FVprcXuCGWESFn
	 mRRnXGTRVtLDA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Fredric Cover <FredTheDude@proton.me>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.15] fs/smb/client: fix out-of-bounds read in cifs_sanitize_prepath
Date: Mon,  6 Apr 2026 07:05:42 -0400
Message-ID: <20260406110553.3783076-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406110553.3783076-1-sashal@kernel.org>
References: <20260406110553.3783076-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.11
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233366-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,proton.me:email]
X-Rspamd-Queue-Id: D89B63A30B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Fredric Cover <FredTheDude@proton.me>

[ Upstream commit 78ec5bf2f589ec7fd8f169394bfeca541b077317 ]

When cifs_sanitize_prepath is called with an empty string or a string
containing only delimiters (e.g., "/"), the current logic attempts to
check *(cursor2 - 1) before cursor2 has advanced. This results in an
out-of-bounds read.

This patch adds an early exit check after stripping prepended
delimiters. If no path content remains, the function returns NULL.

The bug was identified via manual audit and verified using a
standalone test case compiled with AddressSanitizer, which
triggered a SEGV on affected inputs.

Signed-off-by: Fredric Cover <FredTheDude@proton.me>
Reviewed-by: Henrique Carvalho <[2]henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The background agent confirmed my findings: the commit `78ec5bf2f589e`
was authored March 30, 2026, reviewed and committed by Steve French the
next day, merged via `v7.0-rc6-smb3-client-fix`. Lore was inaccessible
due to Anubis bot protection. No controversy found in the git record.

My analysis and decision stand as written above. This is a clear, small,
obviously correct fix for an out-of-bounds read in a widely-used
filesystem (SMB/CIFS), present since v5.16, with very low regression
risk.

**YES**

 fs/smb/client/fs_context.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index e0d2cd78c82f1..e61bb6ac1d111 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -589,6 +589,10 @@ char *cifs_sanitize_prepath(char *prepath, gfp_t gfp)
 	while (IS_DELIM(*cursor1))
 		cursor1++;
 
+	/* exit in case of only delimiters */
+	if (!*cursor1)
+		return NULL;
+
 	/* copy the first letter */
 	*cursor2 = *cursor1;
 
-- 
2.53.0


