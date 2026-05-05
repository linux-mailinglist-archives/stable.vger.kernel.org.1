Return-Path: <stable+bounces-244156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHaWOdPz+WkOFgMAu9opvQ
	(envelope-from <stable+bounces-244156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:42:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BE24CEB77
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 15:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED713053E9E
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1350843E9F5;
	Tue,  5 May 2026 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4ju/N3J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0533DE430;
	Tue,  5 May 2026 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988374; cv=none; b=iO05VMga1tOsHjqwErtTPJibSwTWkWFoU3zetIcrx1ihhtg4cG4fKmupl5/WjTV+QOI17StyJ+3KEMvSfx+SosndxaLOsq30zrGoI9Ii4gleRj5ztFq8B4HXUjGb6CL+VKc1Zo5Cy4wUp3aMPLHGmr40C8wHNreWbOmONl6KBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988374; c=relaxed/simple;
	bh=yP93zuXO35JzbFR2uaIJaF+ZEOQ/IPJfbTeZRtoTuh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PvXBjL+xL9YvYG8lwDnO52Qo7JVHR6iPhsJir1qOH0T7gOB/o77nGt6b8XltZo6q/8JLAIK0DGE1pHhhqV7jzj/EveljcZufnLy8cIpBGguuZxqcS/NfpDOyOuVEcpbb8a2Gr0/QCvJZxKL1LkGnW0UyH919gz/iBSkkjLWbYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4ju/N3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82566C2BCB4;
	Tue,  5 May 2026 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777988374;
	bh=yP93zuXO35JzbFR2uaIJaF+ZEOQ/IPJfbTeZRtoTuh8=;
	h=From:To:Cc:Subject:Date:From;
	b=u4ju/N3Je4WfXZbx4x7zuV2kiqhpzgJ2pdsonvo3LwA4my/a98rxYGyA/i9J3HtOQ
	 el2hHy7jyflpq3tf+c5/Bu6F54DSRThQL5yXeaUuIVIy/oPfgzJ+0jdgXtzeell1zT
	 H7mJKg2IJni55kxpBoZ32XMSqtbNcvWauE7dviTNodsUEQ0VrxujP1lE59Psy3qYHa
	 yUXEh+izXbfU8pkeRkvG8Z5L3RRNypobg/YdsPZTu9iWgUeKk9v4bB3ESGRt9wAOaX
	 t+td1/ZECCYP47S68qfO1dZx0iCEEGuTQKcuHtEaDNOmk4GcLE3msdOCkVRRFxXF0i
	 fPi8754ZNHbAA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>
Cc: "Pratyush Yadav (Google)" <pratyush@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Brendan Jackman <jackmanb@google.com>,
	Greg Thelen <gthelen@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] memfd: deny writeable mappings when implying SEAL_WRITE
Date: Tue,  5 May 2026 15:39:20 +0200
Message-ID: <20260505133922.797635-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 35BE24CEB77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-244156-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

When SEAL_EXEC is added, SEAL_WRITE is implied to make W^X. But the
implied seal is set after the check that makes sure the memfd can not
have any writable mappings. This means one can use SEAL_EXEC to apply
SEAL_WRITE while having writeable mappings.

This breaks the contract that SEAL_WRITE provides and can be used by an
attacker to pass a memfd that appears to be write sealed but can still
be modified arbitrarily.

Fix this by adding the implied seals before the call for
mapping_deny_writable() is done.

Fixes: c4f75bc8bd6b ("mm/memfd: add write seals when apply SEAL_EXEC to executable memfd")
Cc: stable@vger.kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 mm/memfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index fb425f4e315f..abe13b291ddc 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -283,6 +283,12 @@ int memfd_add_seals(struct file *file, unsigned int seals)
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
@@ -295,12 +301,6 @@ int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
-	/*
-	 * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
-	 */
-	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
-		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
-
 	*file_seals |= seals;
 	error = 0;
 
-- 
2.54.0.545.g6539524ca2-goog


