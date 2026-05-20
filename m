Return-Path: <stable+bounces-251554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMOgJgj2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:57:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6959E594FAB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBCB5314ADFA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8486C31282F;
	Wed, 20 May 2026 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MEZyFZmG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786A2628D;
	Wed, 20 May 2026 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298282; cv=none; b=oHZKSoYevRxMfiw5SULGs7HjrKxSOhrVJZF7eFu/Qf4ORB5GwnjT11oFmo9yT9HyjijVwg3eqztQqLF5B6ZkI++vrVtYJn2IxiVZkufOIKpFI+sknb+fRZZcpfhypGoK/s9TokOuOxZ9L96+GGYh0O+2jONr9C8MdaELU5EwS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298282; c=relaxed/simple;
	bh=Qpqm1L0A2bCox12pQYVQmbaoXRJPedaQ9YYOWCHSER4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKJVhp3v1km38ynEoLDgVEShpZzvQeU9Qtm+fGPxCYYWQXMdXEkapB1clZh5V5ww6QkT5v3GjnqBDUrzwsNOJ3jt+8lCeGiSVcw2ckqhpMc7VyoymDcZ32FVC/REd22EMh1CK5zaO8I2tD1EOVQ5HR3pdld4wKuign0ShBlqsDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MEZyFZmG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB811F000E9;
	Wed, 20 May 2026 17:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298281;
	bh=mdKLpfOxzf9mnIkQSN4VDMW+TRX3el5Vr192YHg1DEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MEZyFZmGjJqIP8VVlB8cnN3Sg84k6cT1dcuYwoMHFZmPzUkqF6PflX+zPtzkgO16s
	 dot22zX7Supl6i2KL14x32KL4/7VkXL0bI8D5I2rnHBG/zcGVX7ZuIhXkC568Yf5Bg
	 EHrFl1R0WpXlERcHZA5r80VhlvVsXgxngNs9T/5A=
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
Subject: [PATCH 6.18 310/957] selftests/mm: skip migration tests if NUMA is unavailable
Date: Wed, 20 May 2026 18:13:13 +0200
Message-ID: <20260520162141.255389542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251554-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,arm.com,linux.ibm.com,oracle.com,suse.com,google.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,linux-foundation.org:email,oracle.com:email,arm.com:email]
X-Rspamd-Queue-Id: 6959E594FAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index ea945eebec2f6..aa556c708d6bc 100644
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




