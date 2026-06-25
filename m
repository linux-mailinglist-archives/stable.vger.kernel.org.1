Return-Path: <stable+bounces-268570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FMBjCbI5PWr2zQgAu9opvQ
	(envelope-from <stable+bounces-268570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:22:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D70C6C6943
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:22:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mUfS92fN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268570-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268570-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB219304DE8F
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1216C349CE9;
	Thu, 25 Jun 2026 14:14:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77BD2E040D
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:14:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396886; cv=none; b=RMjd3oCzqyVj4pJgMuOlOYgg7+h4MIuKMD2vcti6HfKv+4TERTLoOlQWbcda7gmKhZB51HQ/Xy/h5Nuo90SRBdGiBl1fC1Z56XSdBH/xNdDbUbUc3wT1Zr0+YeFlDQuEoGMinP71thJn9HEm4JXLMgeBUqbDh+856U2OF9r/45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396886; c=relaxed/simple;
	bh=FjP/1uRLYnfJfXQqOJSDagBeINnaOPSsv11qg53ixTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX2ctGihZsjxmPwglcPp4wOM0+qgm4Dwa9Yg9jG/+EiVakgb7M3hGqcqS3oPGnWpKMop2+EBy+GOFsHF9XCittl7cnX9GIpSexgu2DlGCirC4p++ML+5+ooDVSUkkMs4igZs7vOg1BcXFXfkMBLo7+KTZyCoM3d2LPHjY6gF7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUfS92fN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B2C1F000E9;
	Thu, 25 Jun 2026 14:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396885;
	bh=6EQsWvo6oNp9KR6xzPK0XlOpLQCk9C1iaAatME+hfW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mUfS92fNw+WJjSl4sF8/CYcmrrfBlnMItePZ/thYmMOYZgHfkf10Zjd6Ob3W/CG5h
	 5oR7hkHDT8bVTNuRStTKc+QDDXA941ah50NII3pzjo4wvoj9MFhaJJfQlDSh8HRoAk
	 GeIc93s/R0ZV0znhug26XJTWCF/RrWcvShkrZ750wnM/UGJeap9jitjhK9IN5VlVE2
	 2GFY+qxMtFXXJi4lrRw9JnkkF/tMnTR6X32JIuz896ygdBoYhsmJLMKdYXNmkTxxpu
	 VFxBHZdaXyoMJgfQHRy7BozgKScZPrD8P/aDoIG7YkSmdTOQekC+4sSXJdSZdbG9L1
	 NkSrjc+9jSKUw==
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
Subject: [PATCH 6.6.y] drivers/base/memory: set mem->altmap after successful device registration
Date: Thu, 25 Jun 2026 10:14:42 -0400
Message-ID: <20260625141442.2436561-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062557-blinker-quartered-5591@gregkh>
References: <2026062557-blinker-quartered-5591@gregkh>
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
	TAGGED_FROM(0.00)[bounces-268570-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp,nvidia.com:email,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D70C6C6943

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
index 9e413f522bd629..468ef9b3983cf8 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -773,7 +773,6 @@ static int add_memory_block(unsigned long block_id, unsigned long state,
 	mem->start_section_nr = block_id * sections_per_block;
 	mem->state = state;
 	mem->nid = NUMA_NO_NODE;
-	mem->altmap = altmap;
 	INIT_LIST_HEAD(&mem->group_next);
 
 #ifndef CONFIG_NUMA
@@ -791,6 +790,8 @@ static int add_memory_block(unsigned long block_id, unsigned long state,
 	if (ret)
 		return ret;
 
+	mem->altmap = altmap;
+
 	if (group) {
 		mem->group = group;
 		list_add(&mem->group_next, &group->memory_blocks);
-- 
2.53.0


