Return-Path: <stable+bounces-242091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC0UH+9B82kGywEAu9opvQ
	(envelope-from <stable+bounces-242091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:50:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCADC4A25A0
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 437F33060C60
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE683FB7E3;
	Thu, 30 Apr 2026 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="LeTbU8JC"
X-Original-To: stable@vger.kernel.org
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A013FF8AA;
	Thu, 30 Apr 2026 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777549692; cv=none; b=Ln64KiLJU7ux/OtFlsgrxkgxPHm3u1zqs9BaUyVAo4s9f2Rrhiqt1fggmMB8DPH+Vul768JyFW89uc1K5aZMAEsuDbdk3KGznYw16E1gRw193CKo/AD7eed5jUAxWr2BidT5GGdlv8N6yAC0oazfsAkzdfXiy+UOrivHx3zd1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777549692; c=relaxed/simple;
	bh=NlYMAWsPda2oH5mbxBgRhqukUi7alByGjRCX9I8eZTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=otonanAg/YPGPZ+zajll1/MZ0pymWikso+cmww91dpJR1ATeBmErFyfakLy/fhZ5js6VNkVC/KvYdojA2MgSy2omIXNnhXabpJEWdLqgTFDjkfMyOcu7tQeA/frF2T/GvjnNEQFzomRjun67sntDQben48KcSP8onvkMiHlcgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=LeTbU8JC; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1777549074;
	bh=NlYMAWsPda2oH5mbxBgRhqukUi7alByGjRCX9I8eZTk=;
	h=From:To:Cc:Subject:Date:From;
	b=LeTbU8JCcVdT0lshwXG1ixC1nKGgv084F5rMcvbSlTtnl1z8HzhWoL27AsJr5DIrv
	 xGHQ1ZIneBXd4zlqD/+RD8MBpkyQ1iuWXuB7DROTpHMyVriWdk9JK8kWT2/4Jet0vR
	 v1YxHAA9b1m8xuNGyvQE46O2YK1DdvTcDgahobp8fApFkTzooIgOfD07Xx3M9rChd6
	 hma3MjkMJN+H0meyVBUldDTTmMeADsglzbYa4cByqV6sVzIzui08tQITo2r969hlaL
	 v0BxXh5VqVnyXIjMKJB041IFM4fw07qVPYho/DN6NOXQvowr7z8auJDVrnBuaSRdgV
	 J4dAA8RPsR1AA==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 48B2B24E7B;
	Thu, 30 Apr 2026 14:37:54 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Thu, 30 Apr 2026 14:37:52 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (rbta-msk-lt-302690.astralinux.ru [10.198.24.65])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4g5sbz2SJLzZcy2;
	Thu, 30 Apr 2026 14:37:51 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Zi Yan <ziy@nvidia.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Luis Chamberalin <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@kernel.org>,
	Pankaj Raghav <kernel@pankajraghav.com>
Subject: [PATCH 6.12] mm/memory_hotplug: fix hwpoisoned large folio handling in do_migrate_range()
Date: Thu, 30 Apr 2026 14:37:31 +0300
Message-Id: <20260430113731.1227-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/04/30 11:14:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: adiupina@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 104 0.3.104 557b3c2486a74077a103cf2acd83f2ecf4c95118, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1;lkml.kernel.org:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 202784 [Apr 30 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/04/30 10:34:00 #28457694
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/04/30 11:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-Rspamd-Queue-Id: CCADC4A25A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[astralinux.ru,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[astralinux.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[astralinux.ru,redhat.com,suse.de,linux-foundation.org,suse.com,gmail.com,kvack.org,vger.kernel.org,linuxtesting.org,huawei.com,nvidia.com,kernel.org,infradead.org,pankajraghav.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242091-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adiupina@astralinux.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[astralinux.ru:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Jinjiang Tu <tujinjiang@huawei.com>

commit 397f6d14f9c370e4910e6885294c340f39dedbf5 upstream.

In do_migrate_range(), the hwpoisoned folio may be large folio, which
can't be handled by unmap_poisoned_folio().

I can reproduce this issue in qemu after adding delay in memory_failure()

BUG: kernel NULL pointer dereference, address: 0000000000000000
Workqueue: kacpi_hotplug acpi_hotplug_work_fn
RIP: 0010:try_to_unmap_one+0x16a/0xfc0
  <TASK>
  rmap_walk_anon+0xda/0x1f0
  try_to_unmap+0x78/0x80
  ? __pfx_try_to_unmap_one+0x10/0x10
  ? __pfx_folio_not_mapped+0x10/0x10
  ? __pfx_folio_lock_anon_vma_read+0x10/0x10
  unmap_poisoned_folio+0x60/0x140
  do_migrate_range+0x4d1/0x600
  ? slab_memory_callback+0x6a/0x190
  ? notifier_call_chain+0x56/0xb0
  offline_pages+0x3e6/0x460
  memory_subsys_offline+0x130/0x1f0
  device_offline+0xba/0x110
  acpi_bus_offline+0xb7/0x130
  acpi_scan_hot_remove+0x77/0x290
  acpi_device_hotplug+0x1e0/0x240
  acpi_hotplug_work_fn+0x1a/0x30
  process_one_work+0x186/0x340

Besides, do_migrate_range() may be called between memory_failure set
hwpoison flag and isolate the folio from lru, so remove WARN_ON(). In other
places, unmap_poisoned_folio() is called when the folio is isolated, obey
it in do_migrate_range() too.

[david@redhat.com: don't abort offlining, fixed typo, add comment]
Link: https://lkml.kernel.org/r/3c214dff-9649-4015-840f-10de0e03ebe4@redhat.com
Fixes: b15c87263a69 ("hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined")
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Luis Chamberalin <mcgrof@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pankaj Raghav <kernel@pankajraghav.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 mm/memory_hotplug.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0a42e9a8caba..16d788547b9b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1802,8 +1802,14 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			goto put_folio;
 
 		if (folio_contain_hwpoisoned_page(folio)) {
-			if (WARN_ON(folio_test_lru(folio)))
-				folio_isolate_lru(folio);
+			/*
+			 * unmap_poisoned_folio() cannot handle large folios
+			 * in all cases yet.
+			 */
+			if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+				goto put_folio;
+			if (folio_test_lru(folio) && !folio_isolate_lru(folio))
+				goto put_folio;
 			if (folio_mapped(folio)) {
 				folio_lock(folio);
 				unmap_poisoned_folio(folio, pfn, false);
-- 
2.30.2


