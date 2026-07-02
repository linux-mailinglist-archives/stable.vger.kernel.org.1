Return-Path: <stable+bounces-271098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tNghI9OjRmo0awsAu9opvQ
	(envelope-from <stable+bounces-271098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:45:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6F26FB99D
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:45:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=iaCUpUyl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271098-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271098-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5731330481BB
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754F73AB47C;
	Thu,  2 Jul 2026 16:44:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3104A82866;
	Thu,  2 Jul 2026 16:44:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010665; cv=none; b=CMIFiJ9G4TiBpLd3EUIt5tg8TPLzwYbGeA9jcyE9blgp4NY65+8ESU6IA+B3qTgvbQ+KKfpj8diq5AaOaQHNnufrRGfd6l+CM2mZa4sOe84xXXHRExTHGiVn7DyNiJwuLbp002Wntr4HKh2CXwHAbl8yAv7EAUu7Rf5+LrPm+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010665; c=relaxed/simple;
	bh=hEPjnRB2vbnraqwb8VIWkC+9MNjFgDPLftCjvztkDbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ue+y92Um5mkwgiN8S0o4ycS8ZrvRzAUfKQZXawCPHAFQ5nVu/jRDMWBJ0wngqV/Mva5GtUBY9xRCw2gYtQkOWAAqIUKkV4zfgp420gKDEJ39/O7MmPx2lQ0wAPuXlOCuytx2uD5Cb0cANppuXulSR+5xGZ/fGvlfvBVyS8xByY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iaCUpUyl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1831F00A3A;
	Thu,  2 Jul 2026 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010663;
	bh=OSB+bhFD1js71tRayNH9Fko0i6Vy9ma5UZvuQsYKkCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iaCUpUylKTJ/+gMBZiZRRZymH8Gl1/UcQbxHJfk5+9+WSL1Ah1+O+VojA9BvaX4he
	 FxCFU4LoSBNJq5TBPvvSi/Lhi8+tse9W7tqBmcqrjznOSfd8sS11af2gQp+cY+hyD/
	 WJvIc45phuanWFquqFqeOvkFGFL/8JKn47qn77ZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Georgi Djakov <georgi.djakov@oss.qualcomm.com>,
	"Oscar Salvador (SUSE)" <osalvador@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Richard Cheng <icheng@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 194/204] drivers/base/memory: set mem->altmap after successful device registration
Date: Thu,  2 Jul 2026 18:20:51 +0200
Message-ID: <20260702155122.724830154@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:georgi.djakov@oss.qualcomm.com,m:osalvador@kernel.org,m:vishal.l.verma@intel.com,m:rppt@kernel.org,m:icheng@nvidia.com,m:david@kernel.org,m:djakov@kernel.org,m:rafael@kernel.org,m:akpm@linux-foundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271098-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,qualcomm.com:email,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A6F26FB99D

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>

[ Upstream commit a2b8d7827f48ee54a686cb80e4a1d0ff954ec42a ]

If __add_memory_block() fails at xa_store() (under memory pressure for
example), device_unregister() is called, which eventually triggers
memory_block_release() with mem->altmap still set, causing a
WARN_ON(mem->altmap).  This was triggered by modifying virtio-mem driver.

Fix this by delaying the assignment of mem->altmap until after
__add_memory_block() has succeeded.

Link: https://lore.kernel.org/20260514092657.3057141-1-georgi.djakov@oss.qualcomm.com
Fixes: 1a8c64e11043 ("mm/memory_hotplug: embed vmem_altmap details in memory block")
Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Richard Cheng <icheng@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/memory.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -794,7 +794,6 @@ static int add_memory_block(unsigned lon
 	mem->start_section_nr = block_id * sections_per_block;
 	mem->state = state;
 	mem->nid = NUMA_NO_NODE;
-	mem->altmap = altmap;
 	INIT_LIST_HEAD(&mem->group_next);
 
 #ifndef CONFIG_NUMA
@@ -812,6 +811,8 @@ static int add_memory_block(unsigned lon
 	if (ret)
 		return ret;
 
+	mem->altmap = altmap;
+
 	if (group) {
 		mem->group = group;
 		list_add(&mem->group_next, &group->memory_blocks);



