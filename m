Return-Path: <stable+bounces-223491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FopJKpUrmlACQIAu9opvQ
	(envelope-from <stable+bounces-223491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 06:03:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDBC233D06
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 06:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F10304521D
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 05:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8F32D592F;
	Mon,  9 Mar 2026 05:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Ru8/VAjl"
X-Original-To: stable@vger.kernel.org
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74B2D3A7C
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 05:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773032528; cv=none; b=HDtpawp5BjT/xgEX1HWPGfVm6g2aYgsHeJY9BqjPhjZHe/w1bKk5QF2xzxQwgOHpsaCG1BpMXXVSxqdjbsxVIruvBovtCwpKD/6uvTBBwI0S/+6z1/PDEvpmv48mMYRHqrelM9V/G/CwVduzinWszOU6tG3gZ1ngZSHXs3ofuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773032528; c=relaxed/simple;
	bh=xGzdmJDVkagBJ+m8u/7q/0EnpUau8XUMHQU8NXWzjTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QZValHlIl0QaW6KUnjwqGo7JXjE7IhQuToXPUlLb6DuBKNITod6g8JeFI3mvX4wwa5JlKQzQbEiSb4lACY/zpiSlo7NHgrL//Yz7CifgndNn5MoglrV4PRgnXjHYW8sNVPz6HRj/kw7/M9QGsW6IfIY+F+YnQHsLhDW01hNocxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Ru8/VAjl; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773032526;
	bh=oM9kcvMKEwsqRBBNAyTWcihzlsuQwz3LwFf0Tfp+R1M=;
	h=From:Subject:Date:Message-Id;
	b=Ru8/VAjlPvZY74gBGval3K87REk347iLW4e9YtCbaa77zHRgQVnawXNM6Ig90j76m
	 5yCOM/Uah4ELUirqaSgbEDQC8g7hSCXgO1tjzEsoDxCab/ydfdxJWlvWkYodUAhe2G
	 GYU93F/SHEwAgzDzo8ZSO8nD21/s1Qz92P0r4Xyg=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.22) with ESMTP
	id 69AE542F00001DDF; Mon, 9 Mar 2026 13:01:54 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 1196067602751
X-SMAIL-UIID: 1436BB3E5EBA45179967AAC3E78A0F9A-20260309-130154-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	willy@infradead.org,
	vishal.moola@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 6.1.y 2/3] highmem: add kernel-doc for memcpy_*_folio()
Date: Mon,  9 Mar 2026 13:01:29 +0800
Message-Id: <20260309050130.912344-3-johnny_haocn@sina.com>
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
X-Rspamd-Queue-Id: EDDBC233D06
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
	TAGGED_FROM(0.00)[bounces-223491-lists,stable=lfdr.de];
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 9af47276ed83cc346263e56243756543a2a33c9d ]

This was inadvertently skipped when adding the new functions.

Link: https://lkml.kernel.org/r/20240124181217.1761674-1-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 include/linux/highmem.h | 164 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 44242268f53b..a2a0cfbc19a0 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -415,6 +415,170 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
 	kunmap_local(addr);
 }
 
+/**
+ * memcpy_from_folio - Copy a range of bytes from a folio.
+ * @to: The memory to copy to.
+ * @folio: The folio to read from.
+ * @offset: The first byte in the folio to read.
+ * @len: The number of bytes to copy.
+ */
+static inline void memcpy_from_folio(char *to, struct folio *folio,
+		size_t offset, size_t len)
+{
+	VM_BUG_ON(offset + len > folio_size(folio));
+
+	do {
+		const char *from = kmap_local_folio(folio, offset);
+		size_t chunk = len;
+
+		if (folio_test_highmem(folio) &&
+		    chunk > PAGE_SIZE - offset_in_page(offset))
+			chunk = PAGE_SIZE - offset_in_page(offset);
+		memcpy(to, from, chunk);
+		kunmap_local(from);
+
+		to += chunk;
+		offset += chunk;
+		len -= chunk;
+	} while (len > 0);
+}
+
+/**
+ * memcpy_to_folio - Copy a range of bytes to a folio.
+ * @folio: The folio to write to.
+ * @offset: The first byte in the folio to store to.
+ * @from: The memory to copy from.
+ * @len: The number of bytes to copy.
+ */
+static inline void memcpy_to_folio(struct folio *folio, size_t offset,
+		const char *from, size_t len)
+{
+	VM_BUG_ON(offset + len > folio_size(folio));
+
+	do {
+		char *to = kmap_local_folio(folio, offset);
+		size_t chunk = len;
+
+		if (folio_test_highmem(folio) &&
+		    chunk > PAGE_SIZE - offset_in_page(offset))
+			chunk = PAGE_SIZE - offset_in_page(offset);
+		memcpy(to, from, chunk);
+		kunmap_local(to);
+
+		from += chunk;
+		offset += chunk;
+		len -= chunk;
+	} while (len > 0);
+
+	flush_dcache_folio(folio);
+}
+
+/**
+ * folio_zero_tail - Zero the tail of a folio.
+ * @folio: The folio to zero.
+ * @offset: The byte offset in the folio to start zeroing at.
+ * @kaddr: The address the folio is currently mapped to.
+ *
+ * If you have already used kmap_local_folio() to map a folio, written
+ * some data to it and now need to zero the end of the folio (and flush
+ * the dcache), you can use this function.  If you do not have the
+ * folio kmapped (eg the folio has been partially populated by DMA),
+ * use folio_zero_range() or folio_zero_segment() instead.
+ *
+ * Return: An address which can be passed to kunmap_local().
+ */
+static inline __must_check void *folio_zero_tail(struct folio *folio,
+		size_t offset, void *kaddr)
+{
+	size_t len = folio_size(folio) - offset;
+
+	if (folio_test_highmem(folio)) {
+		size_t max = PAGE_SIZE - offset_in_page(offset);
+
+		while (len > max) {
+			memset(kaddr, 0, max);
+			kunmap_local(kaddr);
+			len -= max;
+			offset += max;
+			max = PAGE_SIZE;
+			kaddr = kmap_local_folio(folio, offset);
+		}
+	}
+
+	memset(kaddr, 0, len);
+	flush_dcache_folio(folio);
+
+	return kaddr;
+}
+
+/**
+ * folio_fill_tail - Copy some data to a folio and pad with zeroes.
+ * @folio: The destination folio.
+ * @offset: The offset into @folio at which to start copying.
+ * @from: The data to copy.
+ * @len: How many bytes of data to copy.
+ *
+ * This function is most useful for filesystems which support inline data.
+ * When they want to copy data from the inode into the page cache, this
+ * function does everything for them.  It supports large folios even on
+ * HIGHMEM configurations.
+ */
+static inline void folio_fill_tail(struct folio *folio, size_t offset,
+		const char *from, size_t len)
+{
+	char *to = kmap_local_folio(folio, offset);
+
+	VM_BUG_ON(offset + len > folio_size(folio));
+
+	if (folio_test_highmem(folio)) {
+		size_t max = PAGE_SIZE - offset_in_page(offset);
+
+		while (len > max) {
+			memcpy(to, from, max);
+			kunmap_local(to);
+			len -= max;
+			from += max;
+			offset += max;
+			max = PAGE_SIZE;
+			to = kmap_local_folio(folio, offset);
+		}
+	}
+
+	memcpy(to, from, len);
+	to = folio_zero_tail(folio, offset + len, to + len);
+	kunmap_local(to);
+}
+
+/**
+ * memcpy_from_file_folio - Copy some bytes from a file folio.
+ * @to: The destination buffer.
+ * @folio: The folio to copy from.
+ * @pos: The position in the file.
+ * @len: The maximum number of bytes to copy.
+ *
+ * Copy up to @len bytes from this folio.  This may be limited by PAGE_SIZE
+ * if the folio comes from HIGHMEM, and by the size of the folio.
+ *
+ * Return: The number of bytes copied from the folio.
+ */
+static inline size_t memcpy_from_file_folio(char *to, struct folio *folio,
+		loff_t pos, size_t len)
+{
+	size_t offset = offset_in_folio(folio, pos);
+	char *from = kmap_local_folio(folio, offset);
+
+	if (folio_test_highmem(folio)) {
+		offset = offset_in_page(offset);
+		len = min_t(size_t, len, PAGE_SIZE - offset);
+	} else
+		len = min(len, folio_size(folio) - offset);
+
+	memcpy(to, from, len);
+	kunmap_local(from);
+
+	return len;
+}
+
 /**
  * folio_zero_segments() - Zero two byte ranges in a folio.
  * @folio: The folio to write to.
-- 
2.34.1


