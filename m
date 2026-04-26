Return-Path: <stable+bounces-241173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNV8BPsl7mn0qwAAu9opvQ
	(envelope-from <stable+bounces-241173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 16:49:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5949446A70B
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 043AD3021B21
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DBF36AB4D;
	Sun, 26 Apr 2026 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dvsEkto2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9D366567
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214717; cv=none; b=eAAj+zQ4al+UqaFrGVP3Y7rvlP0yyRxt1YkM1SI/hlbk3d1F2syEgFTh37VBT9GNDeXlERjK62MwZVpx0S00wK+nKntUYg9o+Ay3PPUMPS6omW2VzwxFEX56W7sK1en2J8PQA2ME0o0By67dzqNoflKEYGYrkA4j15JCRntnZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214717; c=relaxed/simple;
	bh=G65XguRFTm7zXcup5EUJgGsyJNI1Wz/tFU4uJ30YpbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DnuPVI5kA7M6w7cGFzZniXo2dvwbSzMbjiaqnV7WNmQW3m1c1BLWuMyRwK+OAg2roqVxz1y3S0iQKpbuAbxQqqhCmoiCCvTGukd9GxrdLAdmPKS8cDvJKEs/kRhacp/BfabP/5FpvEEC3dmXlqWr6wrzN+0w0aVXKr2uyREcde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dvsEkto2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so4196316b3a.3
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777214713; x=1777819513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OiFyBmC7gClh7pyL8uPE736qSNuG55EW852NdgZNRz4=;
        b=dvsEkto27OfbYJLDAIeOEeWXLn0Xmr0p3Qrs7DhBQSdrAAQlc/StsHuMWvLho/Bu06
         +o6Ip0rx8pFqs80YDXHKaR49ZE+2WLyAt0KlwtQyj3Q6boTMxIv7luP/Rc2mU7uM1lv8
         LpF5OiCMxEUMKIDETF8lIT4fPuTU7EbgZa/lI+ORnjPMSHBJL6rhBLTa1p2jdb/gE2gN
         qYvWlCWL6p+OG1ewSm6CTyRbGcCfikSgqCEUQtLhJx9/TQ2e2VKdu5ozRRsIf3NefE/5
         8i2K4lOmJF7ASlm5HVhl2KIjBTTv4d0+/iTR25dvnfpFrIHsRAL3z4bwUMlSEX8DgbQn
         4JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214713; x=1777819513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiFyBmC7gClh7pyL8uPE736qSNuG55EW852NdgZNRz4=;
        b=HVQ9ge3DrI/DHILn5lJbVKR6rMRTTvxPsqQfO300pUKxNTUf6bAzCMBbtynyjY7RqG
         5UlBXU8ARjqQJvKEEYDB4JlTT1vD5a44EWA8fYa47k/eqFk68UJ9Jk0wpS9bHgr2ZDRu
         pmoKaww1qcg78TjjGBVARvCNrTHisKMkhrp1XHhSbgnXLROXvPSbRWghbplVntdevx3W
         tTJFxNztPaF102FXKW8QfH9LY1MZcOCTTI19rVN5e492RYlY8lviuzhx5NEG1G/J53Vp
         eB974i0y9BFYmAxOcYPoMd0qNvGjAis3xE5xYR8yydyWN5ZADw2Mzu3nJWLeDMUMaNbn
         bK/g==
X-Forwarded-Encrypted: i=1; AFNElJ/ZfUWCM7BSqJe5xPHXP4x3nYcnzg3gZRL1o2pGtcr+2L8dTEMorormFZ9pEc8lusntp6xZQiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvzRGJGnSxm35A8JW4yi42RPjDruprKVNceXx03MdyxZw2xlu4
	HxRkA8ZOTHDvMixqovAIMkhXsBPRLSFE5kOpd3bbtnrH5qNcG8jsCM6uKpL+LQUE10I=
X-Gm-Gg: AeBDiesGXriwmSTLGCFk4pdhgMwlSjtk9e0f6e04oZuWk1YpXW83EyqrI90ZDPYdUB7
	ICeSKEmKci1iijZ8i3cW0zUZsXLS6ZR/9YNe0sXk/hx4nzBiizx1hqytKFU2HRpIFroNHqbmI+o
	+/DgKGsMouzX8pr1I1OsYjxRZhA81/TdZYEsrx8WK4MneZgWxjhke8ksYLVlWuICvOxZmQ0BfPw
	AvY+/GRfIEGLmm4EDywZpCW3w346ono2+B9DKvMlfTc+uaIxiPn248c5ehQRtG6R0+qmX5y7vDy
	AIV3y4Ixb2E+BlMpcw5wRx2PM/SrMcI31SM11jzij24evHwvMF3ClWOo8YwiVtNr5X0SIu5fFGN
	6kah8A+rHyqb01Q6Xjbg+Ff845AkykNMYaz2jO99mxpBAkkSDQDBIMbdA1iBfhW9RScpYn6mMzC
	SaIggKczJIYgwUZbrLUogixgr/D+U8
X-Received: by 2002:a05:6a20:1b17:b0:39c:241:65a3 with SMTP id adf61e73a8af0-3a08d68777fmr31746742637.1.1777214712721;
        Sun, 26 Apr 2026 07:45:12 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::349])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703059fsm22340550a12.24.2026.04.26.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:45:12 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: muchun.song@linux.dev,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/memory_hotplug: fix memory block reference leak on remove
Date: Sun, 26 Apr 2026 22:44:46 +0800
Message-Id: <20260426144447.817722-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5949446A70B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,intel.com,huawei.com,kvack.org,vger.kernel.org,lists.linux.dev,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241173-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid]

remove_memory_blocks_and_altmaps() looks up each memory block with
find_memory_block(), which acquires a reference to the memory block
device.

That reference is never dropped on this path, resulting in a leaked
device reference when removing memory blocks and their altmaps. Drop
the reference after retrieving mem->altmap and clearing mem->altmap,
before removing the memory block device.

Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory requests across memblocks")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memory_hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a943ec57c85..4426abb05655 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1422,6 +1422,7 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 
 		altmap = mem->altmap;
 		mem->altmap = NULL;
+		put_device(&mem->dev);
 
 		remove_memory_block_devices(cur_start, memblock_size);
 

base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
-- 
2.20.1


