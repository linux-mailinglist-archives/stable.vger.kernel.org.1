Return-Path: <stable+bounces-250425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GiaMW3oDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:59:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636A592C3F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B5EC314C26A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9984363C6F;
	Wed, 20 May 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pg4WTBSZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAD371056;
	Wed, 20 May 2026 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295381; cv=none; b=ierGv4w+0+BKILO/g6mYI7yjEo6o23QEob56hXQK5AALv+rDnOLBeoCCDp5GkYW+elt2D6YLdRsQkPd7EWlmLUgZGKcrVM8yxvM15RtKiMFtCC/Ddlx10farOEpDeTLo0dRMMoGu8mGbhL5YrWA6o/MdL4z4Mgt0CTKa1WzF928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295381; c=relaxed/simple;
	bh=ZAykyASMUIF7DoK5OpT3tLpzYGc+wlECM29jg7SL9Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnlbEYstNWWryHuZgw3f1VTB33PQ9GdapHq4MFRV1AAqL4obHIdqjSl4I7lKDaoN42vMd0ZqnukAIYzOhBzVqGjfCxZPHf+VoI+nr0iwaj1vcfIXcjeYcixUmNj7hf0+9t2Ou6Mmu8L4FF1eVIHw6aGuBt6q0i4bJtBNUd73Xvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pg4WTBSZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2DD1F000E9;
	Wed, 20 May 2026 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295379;
	bh=SnSLziOAsgnvFXKNB8+OwAbz72J95Ds2UAXEmZwS3dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pg4WTBSZ2wRv2Y5M5ZoCCcqMAyYvoCfXJYx0B+GY64jlXSFLJGa8xVTdUTcq6AQ+q
	 w0OO+V6qAp0dFEFhvDXwS0ezZ+KWvhMtt+LlnzZLcDFC+/uLjj8FneNP1c4kmMXUw3
	 NZu/z6PcLjYyr8c7YUpC6CNMRuz4yBz9Z/SMw/SA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AnishMulay <anishm7030@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Sayali Patil <sayalip@linux.ibm.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0398/1146] selftests/mm: skip migration tests if NUMA is unavailable
Date: Wed, 20 May 2026 18:10:48 +0200
Message-ID: <20260520162157.205456841@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250425-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,arm.com,linux.ibm.com,oracle.com,suse.com,google.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:email,arm.com:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 9636A592C3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AnishMulay <anishm7030@gmail.com>

[ Upstream commit 54218f10dfbe88c8e41c744fd45a756cde60b8c4 ]

Currently, the migration test asserts that numa_available() returns 0.  On
systems where NUMA is not available (returning -1), such as certain ARM64
configurations or single-node systems, this assertion fails and crashes
the test.

Update the test to check the return value of numa_available().  If it is
less than 0, skip the test gracefully instead of failing.

This aligns the behavior with other MM selftests (like rmap) that skip
when NUMA support is missing.

Link: https://lkml.kernel.org/r/20260218163941.13499-1-anishm7030@gmail.com
Fixes: 0c2d08728470 ("mm: add selftests for migration entries")
Signed-off-by: AnishMulay <anishm7030@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Tested-by: Sayali Patil <sayalip@linux.ibm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/mm/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index ee24b88c2b248..60e78bbfc0e3e 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -36,7 +36,8 @@ FIXTURE_SETUP(migration)
 {
 	int n;
 
-	ASSERT_EQ(numa_available(), 0);
+	if (numa_available() < 0)
+		SKIP(return, "NUMA not available");
 	self->nthreads = numa_num_task_cpus() - 1;
 	self->n1 = -1;
 	self->n2 = -1;
-- 
2.53.0




