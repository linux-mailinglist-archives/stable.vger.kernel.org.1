Return-Path: <stable+bounces-241506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCpUHAR58GnMTwEAu9opvQ
	(envelope-from <stable+bounces-241506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:08:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 710F9480F27
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68018305C9FC
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E673D75D0;
	Tue, 28 Apr 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kOByzhFP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BFE3D813F
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366366; cv=none; b=M+Bu7rfrFxz9UhTf5B+QN8JeKF1pdUQSOuj1DWFt+mQUcpLHw6Pq77pjgxTdWIsuCQdYVUTugOXn4LiN8ZRXqfyGOIwWtaRyGXfnKB7GNcTulHhVDuKOSlN3L1HQ5jJCFGcYVvn854NB18qTBeMhtjVNaoFcNlN7H/bBBGGrq5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366366; c=relaxed/simple;
	bh=iuwtwcgHq3raBwyHyUBxeAqB9w0cY8KY67dh1gll2ME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ruzJnb3g5gwgdnpkAXiP6c5WckFuAUQPN2Xjt2QMBBra0PL6ZI4X6ApQoXhz7fEDc/Fb+6sJYh+bXT+cgYgZnK8IAlBNNq0JN5XlKs1bBCrb0QsgXvDVZMK8ybiS5QxU2sQePwCcsCaZ79X2p6InWRrC3el8MDa744gqwWGgEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kOByzhFP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35fc0d7c310so7242158a91.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777366364; x=1777971164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSJ/Zlq/U4yHk19v3uYTHivwFzozYncFCgI5ZpuZJfE=;
        b=kOByzhFPX/q1ULrXheyyTe7xYjJI+jpR9TPJv4TMg687wAWdTx853MgeLdJkK2cepa
         w6v5svS+337LAiuHfSX133NZT/IICOxTPT5yBGtiIZHiP/wIizRBsjIg+cTXfDgI5EtH
         SIPlSAyudZFGxzQ4LunKSQicp9E3st/EOcXYE5Q/hb3+EEmgrCUd/6rn2/+m/NoNtqs7
         45tQo84VlxTDdUOyhVYsv8vogD6yc3w78eiuR6dn8KI4JdiYaFHz/bed9APCsuPu3xeg
         DDHiQeEe0vg7VoW+n9dl6h0rcydF8s5iMW3UA6C89gLLb9x05jZSyS3jjM72KKOMPENO
         AGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366364; x=1777971164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MSJ/Zlq/U4yHk19v3uYTHivwFzozYncFCgI5ZpuZJfE=;
        b=DozzSD/57gnp722OYbRzoR5JlabHLOML65jSmeOGAoghXpsfAJdM7lYo3vqiCMdehT
         jTV2RwDqmfZkzvbxfo63FWR5L5JBbkCxvpP7KjZa/IoNqlsnIXbnScRCcwaeMuadnPK/
         uNB7Ld/BldlojVdkUbOuduYyuek9Wskau4QisU3PhKzjK5LTtrR1ZJ91liERwf27zJsf
         PnpQbXJkiNWHMZEERV2xqD+95yO6B8ryBU90xEwA1KhUg35XWvMAHyqS40hvJS4HsV5b
         ArDBmaxeL600iurzewvVs8wFdj1ZobrCmjlSIdjjkO7w/ch803FmSa11DzCT27GCaUrd
         WxaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kSQDZQK61jvTyIcP64pSYplRKhfBPZU0ZaZTOYtU75yM4YA+Th928xBuS0CCnIN8a/Ns549g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKlieX9hc3xbzMjHXljQchmekgtNrA+JF1pJ3VVpMK08qdUK6B
	eZR+9B+IL4qmO2Q1vCTKYkaBWPMICnZQMiRzsWf2lVdnuU53zIX4DLPPQu/+96yBIE4=
X-Gm-Gg: AeBDietAIba2dPWDnB2UOHX9emOi+/LQs2OZ0QAS3RlPuthU+CDNvIOQuE/W6GvKUa7
	23mhYIRacnC/ddQTw97Gd2WKDk+HC87luua03fUtFJQwWW5HTx5hqB0ZNjdM7wOFN+DH0+mbxjt
	OSKQAb46eVCq9Dzmenl7qiRlElhTRBTSQw9jAIVP+vJ2VYb9S5l6C8gLLC0GEIKvyRSeTsI4IDC
	GQdysX5P4L1vYnl0T34Fnj3uWJDgpVKUY9/OqB4WaKLhc4xn3rDDnqwD3ztzlMKPX25ssbdvIrQ
	2mMfS8aRm/A47NPkQMU8lzu2Rjrne8feamNo68SvX+n1ZowKiOr/IikiAS9/XC0tuWExHB6mdgo
	diX7CTANGAJafxTPR+nTbG1F91vNcIIuiBDRbH10dwdl6QF8SDWtOUOhfBCHwzGZWPjUpDwqPWk
	s4A0gE6tQ2166TqJkMqQRhBFgwWBmpvXIeIM007ZrMYXfLE+pSVym6eq0=
X-Received: by 2002:a17:90a:fc4d:b0:35b:e4f8:7cc5 with SMTP id 98e67ed59e1d1-36492068746mr2311671a91.25.1777366363725;
        Tue, 28 Apr 2026 01:52:43 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364902e7debsm2889080a91.15.2026.04.28.01.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:52:43 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org,
	muchun.song@linux.dev
Subject: [PATCH v2 3/3] drivers/base/memory: fix locking for poison accounting lookup
Date: Tue, 28 Apr 2026 16:52:19 +0800
Message-Id: <20260428085219.1316047-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260428085219.1316047-1-songmuchun@bytedance.com>
References: <20260428085219.1316047-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 710F9480F27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,kernel.org,huawei.com,kvack.org,vger.kernel.org,lists.linux.dev,bytedance.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241506-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid]

memblk_nr_poison_inc() and memblk_nr_poison_sub() call
find_memory_block_by_id(), which requires device_hotplug_lock to
serialize the xarray lookup against memory block removal.

Take device_hotplug_lock around the lookup and nr_hwpoison update so
the memory block cannot disappear between xa_load() and get_device().

Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 6981b55d582a..f76aee29e9a5 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -1228,23 +1228,29 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 void memblk_nr_poison_inc(unsigned long pfn)
 {
 	const unsigned long block_id = pfn_to_block_id(pfn);
-	struct memory_block *mem = find_memory_block_by_id(block_id);
+	struct memory_block *mem;
 
+	lock_device_hotplug();
+	mem = find_memory_block_by_id(block_id);
 	if (mem) {
 		atomic_long_inc(&mem->nr_hwpoison);
 		put_device(&mem->dev);
 	}
+	unlock_device_hotplug();
 }
 
 void memblk_nr_poison_sub(unsigned long pfn, long i)
 {
 	const unsigned long block_id = pfn_to_block_id(pfn);
-	struct memory_block *mem = find_memory_block_by_id(block_id);
+	struct memory_block *mem;
 
+	lock_device_hotplug();
+	mem = find_memory_block_by_id(block_id);
 	if (mem) {
 		atomic_long_sub(i, &mem->nr_hwpoison);
 		put_device(&mem->dev);
 	}
+	unlock_device_hotplug();
 }
 
 static unsigned long memblk_nr_poison(struct memory_block *mem)
-- 
2.20.1


