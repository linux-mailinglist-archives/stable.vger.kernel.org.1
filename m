Return-Path: <stable+bounces-223490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIJTNJdUrmlACQIAu9opvQ
	(envelope-from <stable+bounces-223490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 06:03:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46240233CFE
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 06:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EAB2303FAF5
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 05:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25CE2D877A;
	Mon,  9 Mar 2026 05:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="TV2nIJHb"
X-Original-To: stable@vger.kernel.org
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B527CB02
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 05:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773032527; cv=none; b=qaD+ndOfWMqX0NgOXYUTYAQcI/4PgaGowpSHYW9Qy8nt79pIT4ldPYKIlDBxClcb2GKxWQNAMnbNyUj1NFen/nkSbd1sosuO6WtY03Y56GK/N7YiHUhR7A/nyLc+k4Ojed0XxlFcGHSTKGmju2cN7eCFs4YNjmMSmrcEDmpLIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773032527; c=relaxed/simple;
	bh=DJLFSDRnvAp3EhxzBvtGuKZeTxQH2D2T3rwd9dsdcao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYkEAyKAdonIMU/MsUSyFOrGMFZ4XLNIeVTzKiOPJ87Wa7h/Xjozb4GmXalz82ebKzc+8KHqyK/iD0BaB3IDVrK5uW3uEp1lGTFtco01CuL2N5dI1a0QqVBDLFGDI7KVC7lDUpQduBYwIu5ib0lM8LqJH3Rgze/aUIQHeoVBu1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=TV2nIJHb; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773032525;
	bh=lq2pah/fq2C0/GQ5PtUTDXM7+bNvcgMJwTg7UFXIh1U=;
	h=From:Subject:Date:Message-Id;
	b=TV2nIJHbDdVhvtFk5/Juj3RUkdU6Mdq00M3HXiziRegEZqAjAoW/eJqJ+pcHMMCiu
	 zWUwgx78UO1+twSBdGR5CumaQ/o6EbYvyCtPsHm9r5/cNDNbeveNFovjg7VniaVXQq
	 rO2OXLXrxuOvGU/4AzlwXWjbBoXALmoDUUh9ZAbw=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.22) with ESMTP
	id 69AE542F00001DDF; Mon, 9 Mar 2026 13:01:52 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 7435767602749
X-SMAIL-UIID: 7818163A509A42A8987FBEE18C4A2515-20260309-130152-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	willy@infradead.org,
	vishal.moola@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 6.1.y 1/3] pagemap: add filemap_grab_folio()
Date: Mon,  9 Mar 2026 13:01:28 +0800
Message-Id: <20260309050130.912344-2-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309050130.912344-1-johnny_haocn@sina.com>
References: <20260309050130.912344-1-johnny_haocn@sina.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 46240233CFE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,dubeyko.com,infradead.org,gmail.com,linux-foundation.org,sina.com];
	TAGGED_FROM(0.00)[bounces-223490-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-foundation.org:email,infradead.org:email,sina.com:dkim,sina.com:email,sina.com:mid]
X-Rspamd-Action: no action

From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

[ Upstream commit ee7a5906ff08e435ed95ec9fe7c7eed2c11015d2 ]

Patch series "Convert to filemap_get_folios_tag()", v5.

This patch series replaces find_get_pages_range_tag() with
filemap_get_folios_tag().  This also allows the removal of multiple calls
to compound_head() throughout.

It also makes a good chunk of the straightforward conversions to folios,
and takes the opportunity to introduce a function that grabs a folio from
the pagecache.

This patch (of 23):

Add function filemap_grab_folio() to grab a folio from the page cache.
This function is meant to serve as a folio replacement for
grab_cache_page, and is used to facilitate the removal of
find_get_pages_range_tag().

Link: https://lkml.kernel.org/r/20230104211448.4804-1-vishal.moola@gmail.com
Link: https://lkml.kernel.org/r/20230104211448.4804-2-vishal.moola@gmail.com
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 include/linux/pagemap.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index dfaa09901867..be0eb05dbd14 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -582,6 +582,26 @@ static inline struct folio *filemap_lock_folio(struct address_space *mapping,
 	return __filemap_get_folio(mapping, index, FGP_LOCK, 0);
 }
 
+/**
+ * filemap_grab_folio - grab a folio from the page cache
+ * @mapping: The address space to search
+ * @index: The page index
+ *
+ * Looks up the page cache entry at @mapping & @index. If no folio is found,
+ * a new folio is created. The folio is locked, marked as accessed, and
+ * returned.
+ *
+ * Return: A found or created folio. NULL if no folio is found and failed to
+ * create a folio.
+ */
+static inline struct folio *filemap_grab_folio(struct address_space *mapping,
+					pgoff_t index)
+{
+	return __filemap_get_folio(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+			mapping_gfp_mask(mapping));
+}
+
 /**
  * find_get_page - find and get a page reference
  * @mapping: the address_space to search
-- 
2.34.1


