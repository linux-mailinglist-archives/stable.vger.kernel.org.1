Return-Path: <stable+bounces-268562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id byKeEBg2PWp6zAgAu9opvQ
	(envelope-from <stable+bounces-268562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:07:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EA96C6616
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:07:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="c5M/to1B";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268562-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268562-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29674307CFBE
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6193033F5;
	Thu, 25 Jun 2026 14:06:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC17E34B1A2
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:06:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396368; cv=none; b=t9JLMAKfscvZwpLl9UYzkHh2fvHqDqDgFzQB9VsFskA6JGHw9VCNUlXDsPiZL4uA2IJLcvlg63yQHfUHJIwO2xtSU7u29P9YXEd7ECTxvcvEYg4aHYCQFunoIf0xRxsNQ35hSfr8qGMsoh0hiFCa3iVwfE6q63gW9LWLAlK/RUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396368; c=relaxed/simple;
	bh=x1Qk91Mv9x9GkX61JwvxI6F0ybh8lXGU0hhxoOsW7E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e39NuccCAx+O941i0buWmSfdNF8YlltFQRhnAFotUMWl3unIpgj9zcQn5hxmKilB40Pxv1ATiq+ApsBRY4iJsJRSprhSstYiGPMC4tSW1gMQd7mIL8dhYCKxiUGypZyK/gX3HCK3RgTbAY6tdHn/wW9uj+zNT3QZgwWdU1rpoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5M/to1B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370E81F000E9;
	Thu, 25 Jun 2026 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396367;
	bh=IKZXnMy/66CKwYt5r71qkpMWrBMV/vBVtfeVzVlwMRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c5M/to1BYOOKxPa4ne6QoQbXTTU0s/4uGPs23fKeHRzVwY3EzFUuuH2d5ymEhsmSy
	 VJFeL24yNg8hP5xdZvu9e7UdWW+YaQ62B7bEs5lfNgsry08OoGW1y/ZtoqKPubYPg/
	 Cgq9f+wKYf0NQVHd/dObCwzVffoVYnOxV1GWXtStBBsXurtj07pOy2b7fn5Px/c33Y
	 dK9Epal1pULmSdYYw51oobDz+Q/4scVIMnun/BkCTnN4F8o+ZFsK+wVzM34wCFoMeD
	 h1EiV5OTljnkPBXqZ8WssI8B1aBJ17zOVrA9uZ1SUc7P3looQa6jJe8oKH9Vc/z5IX
	 S4U0AEoqrVCzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Georgi Djakov <georgi.djakov@oss.qualcomm.com>,
	"Oscar Salvador (SUSE)" <osalvador@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Richard Cheng <icheng@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drivers/base/memory: set mem->altmap after successful device registration
Date: Thu, 25 Jun 2026 10:06:04 -0400
Message-ID: <20260625140604.2429376-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062556-emcee-reexamine-cc0e@gregkh>
References: <2026062556-emcee-reexamine-cc0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268562-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:georgi.djakov@oss.qualcomm.com,m:osalvador@kernel.org,m:vishal.l.verma@intel.com,m:rppt@kernel.org,m:icheng@nvidia.com,m:david@kernel.org,m:djakov@kernel.org,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:akpm@linux-foundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:email,qualcomm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96EA96C6616

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
---
 drivers/base/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 948e77da1dc3be..2f7e8bab3d10cf 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -794,7 +794,6 @@ static int add_memory_block(unsigned long block_id, unsigned long state,
 	mem->start_section_nr = block_id * sections_per_block;
 	mem->state = state;
 	mem->nid = NUMA_NO_NODE;
-	mem->altmap = altmap;
 	INIT_LIST_HEAD(&mem->group_next);
 
 #ifndef CONFIG_NUMA
@@ -812,6 +811,8 @@ static int add_memory_block(unsigned long block_id, unsigned long state,
 	if (ret)
 		return ret;
 
+	mem->altmap = altmap;
+
 	if (group) {
 		mem->group = group;
 		list_add(&mem->group_next, &group->memory_blocks);
-- 
2.53.0


