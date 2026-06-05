Return-Path: <stable+bounces-260593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UX9TELMZImr3SQEAu9opvQ
	(envelope-from <stable+bounces-260593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 02:34:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985E1644217
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 02:34:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n7pG0XHI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260593-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260593-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BFDE3036606
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 00:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5B51E5B63;
	Fri,  5 Jun 2026 00:34:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052437404E
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 00:34:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619696; cv=none; b=quACnsnY83loqL2c9Kfy+2x0oaPZDkit8ItmjVpFvCqqAHzS60pF8mDe2lAWjHQuOKZLLB1D4KsgS7dNxXTnnmmQkRo5yBd2UmKahB4m60FS9QQV/Nauj46LH6u7OlSbFmqC6G9aBrnNCeb7KKbEthtI64FYMSTPa6m/7sCz4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619696; c=relaxed/simple;
	bh=Zd6wnzqiYFXETEvAeD1R7xqqyUMchyPAjtyEYNsDLDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uh4+mm6+2Xcm6osIohpboXOF0mrMmC4G2TP1ZPMxtcCbDJiny9ns6wCVmIPedZj6HJYM3T1CjtDXbeOzbZR8aialMC7N3rVVbwB5w7WFVBPSi14Uo7I0YkaWSmO8k1fUIjwlid4BvU+iRlygUOanBVdHlTexGhEuOPOgRGhTfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7pG0XHI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843EB1F00893;
	Fri,  5 Jun 2026 00:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619694;
	bh=yPSQCejx+rY121F0e6r8BjOMx3ymM5OE7PjgqPUE8Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n7pG0XHINPmzCpT51QNyIGy+1wp7SIk2GjGjgAuBQ1G+5L62Xm2GABWXsnOHMNv66
	 tHQ2iA16mN+jCu1YYtDvPn/d1JmtSRZqhFFruRVDY59Yoh3sdLlvl/XPxY5n7gvGmz
	 GMAqN3sZa/D4jub2QSQllhVsN187UtYVngORcyS8hppylWyVrnXi7h4z56cMEBXy6N
	 0dg0zwyzwFnArFwsTCjd/7JuGZEMyiWP/4de3dHd9jbH4kYKLeVPdeVouTBRN8oaC+
	 QwSaZ3yMdQ4kxZHa9fh5KDrSjdZo9KUkxoNAK9IZdo6i1nMayG7YUCRhMaIKVnm/De
	 KwZG9WJj//vEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Pratyush Yadav (Google)" <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jeff Xu <jeffxu@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Brendan Jackman <jackmanb@google.com>,
	Greg Thelen <gthelen@google.com>,
	Hugh Dickins <hughd@google.com>,
	Kees Cook <kees@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] memfd: deny writeable mappings when implying SEAL_WRITE
Date: Thu,  4 Jun 2026 20:34:51 -0400
Message-ID: <20260605003451.2707256-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060409-tightness-iodize-c0fc@gregkh>
References: <2026060409-tightness-iodize-c0fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260593-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:pratyush@kernel.org,m:pasha.tatashin@soleen.com,m:jeffxu@google.com,m:baolin.wang@linux.alibaba.com,m:jackmanb@google.com,m:gthelen@google.com,m:hughd@google.com,m:kees@kernel.org,m:david@kernel.org,m:akpm@linux-foundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,soleen.com:email,alibaba.com:email,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 985E1644217

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

[ Upstream commit 3b041514cb6eae45869b020f743c14d983363222 ]

When SEAL_EXEC is added, SEAL_WRITE is implied to make W^X.  But the
implied seal is set after the check that makes sure the memfd can not have
any writable mappings.  This means one can use SEAL_EXEC to apply
SEAL_WRITE while having writeable mappings.

This breaks the contract that SEAL_WRITE provides and can be used by an
attacker to pass a memfd that appears to be write sealed but can still be
modified arbitrarily.

Fix this by adding the implied seals before the call for
mapping_deny_writable() is done.

Link: https://lore.kernel.org/20260505133922.797635-1-pratyush@kernel.org
Fixes: c4f75bc8bd6b ("mm/memfd: add write seals when apply SEAL_EXEC to executable memfd")
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Jeff Xu <jeffxu@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 187265dc68f5e8..16dde40afd324b 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -210,6 +210,12 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		goto unlock;
 	}
 
+	/*
+	 * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
+	 */
+	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
+		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
+
 	if ((seals & F_SEAL_WRITE) && !(*file_seals & F_SEAL_WRITE)) {
 		error = mapping_deny_writable(file->f_mapping);
 		if (error)
@@ -222,12 +228,6 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
-	/*
-	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
-	 */
-	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
-		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
-
 	*file_seals |= seals;
 	error = 0;
 
-- 
2.53.0


