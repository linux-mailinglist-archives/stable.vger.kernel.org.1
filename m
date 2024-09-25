Return-Path: <stable+bounces-77504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C414985DDF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28544289E20
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F551B580A;
	Wed, 25 Sep 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwCWueKa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405011B5802;
	Wed, 25 Sep 2024 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266068; cv=none; b=lJ95qtwBSxWhmcq9mKIHkygdzjJiYNbC4Y1tWs4G6ZvxGxSKhIZv1VyxMVZ6vtCbpTmZrqCoeUikeTxVZxEasr53DW5gIYRXVn59j1szSpNKryXkaUEw6KUwegc5xfWOwV0Vo6osufR/IF/EGn9PiVkprTr+8ENQnVBYQI1QPwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266068; c=relaxed/simple;
	bh=BXO+iQL/2h0J1musHSu3iLi8C5DvsueCxhxVBiZJi0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UU+tP/808S0tHyITUUmgKs2gCVWQroiyqHxZGdnbC9KpqxKnwRNvBQrhGqS3/o6wQjSwt9r3rcUeKeAPf8Igzx2zLqq5UdY4D9kW8MB5TF2uHs+/pCfoXVDH1nwOCh13wZSI3BWx5zmkkLbDRPKOclJZxqPVU6/UeP6MndJGa+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwCWueKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63949C4CEC3;
	Wed, 25 Sep 2024 12:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266067;
	bh=BXO+iQL/2h0J1musHSu3iLi8C5DvsueCxhxVBiZJi0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwCWueKaorAmJNHCd3yPdoMiQnpteAJxXwsyZBZbxk07j833RqilX1MP2kviBdyJI
	 kUxjF4jUyohN5VXW4uJ6bQXQ0yRZPA9vhgq6kb9i2AmuJdg+FUAao1ksEcajUaldtR
	 k0CSEx5ua1FI4aEbcY8nZgmw/yGHF7K4Cez60KvGxgBuupSw7wSl6W+WkvzhjzP1fk
	 gniGbbd3V1UuzU/KXdKf4BgTrncDIGD73cdgx8btxsCBiFINYNVZ+/jlBks6hzSAaJ
	 ZYNCUzqflpGN+T1GvvPqEsIetzxwsm44TWAJRs/u59Oc2A56IxrwOduUIWSAjkrZVa
	 w61kEZIfGMYIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 159/197] drm/printer: Allow NULL data in devcoredump printer
Date: Wed, 25 Sep 2024 07:52:58 -0400
Message-ID: <20240925115823.1303019-159-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit 53369581dc0c68a5700ed51e1660f44c4b2bb524 ]

We want to determine the size of the devcoredump before writing it out.
To that end, we will run the devcoredump printer with NULL data to get
the size, alloc data based on the generated offset, then run the
devcorecump again with a valid data pointer to print.  This necessitates
not writing data to the data pointer on the initial pass, when it is
NULL.

v5:
 - Better commit message (Jonathan)
 - Add kerenl doc with examples (Jani)

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240801154118.2547543-3-matthew.brost@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_print.c | 13 +++++----
 include/drm/drm_print.h     | 54 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index cf2efb44722c9..1d122d4de70ec 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -100,8 +100,9 @@ void __drm_puts_coredump(struct drm_printer *p, const char *str)
 			copy = iterator->remain;
 
 		/* Copy out the bit of the string that we need */
-		memcpy(iterator->data,
-			str + (iterator->start - iterator->offset), copy);
+		if (iterator->data)
+			memcpy(iterator->data,
+			       str + (iterator->start - iterator->offset), copy);
 
 		iterator->offset = iterator->start + copy;
 		iterator->remain -= copy;
@@ -110,7 +111,8 @@ void __drm_puts_coredump(struct drm_printer *p, const char *str)
 
 		len = min_t(ssize_t, strlen(str), iterator->remain);
 
-		memcpy(iterator->data + pos, str, len);
+		if (iterator->data)
+			memcpy(iterator->data + pos, str, len);
 
 		iterator->offset += len;
 		iterator->remain -= len;
@@ -140,8 +142,9 @@ void __drm_printfn_coredump(struct drm_printer *p, struct va_format *vaf)
 	if ((iterator->offset >= iterator->start) && (len < iterator->remain)) {
 		ssize_t pos = iterator->offset - iterator->start;
 
-		snprintf(((char *) iterator->data) + pos,
-			iterator->remain, "%pV", vaf);
+		if (iterator->data)
+			snprintf(((char *) iterator->data) + pos,
+				 iterator->remain, "%pV", vaf);
 
 		iterator->offset += len;
 		iterator->remain -= len;
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 089950ad8681a..8fad7d09bedae 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -220,7 +220,8 @@ drm_vprintf(struct drm_printer *p, const char *fmt, va_list *va)
 
 /**
  * struct drm_print_iterator - local struct used with drm_printer_coredump
- * @data: Pointer to the devcoredump output buffer
+ * @data: Pointer to the devcoredump output buffer, can be NULL if using
+ * drm_printer_coredump to determine size of devcoredump
  * @start: The offset within the buffer to start writing
  * @remain: The number of bytes to write for this iteration
  */
@@ -265,6 +266,57 @@ struct drm_print_iterator {
  *			coredump_read, ...)
  *	}
  *
+ * The above example has a time complexity of O(N^2), where N is the size of the
+ * devcoredump. This is acceptable for small devcoredumps but scales poorly for
+ * larger ones.
+ *
+ * Another use case for drm_coredump_printer is to capture the devcoredump into
+ * a saved buffer before the dev_coredump() callback. This involves two passes:
+ * one to determine the size of the devcoredump and another to print it to a
+ * buffer. Then, in dev_coredump(), copy from the saved buffer into the
+ * devcoredump read buffer.
+ *
+ * For example::
+ *
+ *	char *devcoredump_saved_buffer;
+ *
+ *	ssize_t __coredump_print(char *buffer, ssize_t count, ...)
+ *	{
+ *		struct drm_print_iterator iter;
+ *		struct drm_printer p;
+ *
+ *		iter.data = buffer;
+ *		iter.start = 0;
+ *		iter.remain = count;
+ *
+ *		p = drm_coredump_printer(&iter);
+ *
+ *		drm_printf(p, "foo=%d\n", foo);
+ *		...
+ *		return count - iter.remain;
+ *	}
+ *
+ *	void coredump_print(...)
+ *	{
+ *		ssize_t count;
+ *
+ *		count = __coredump_print(NULL, INT_MAX, ...);
+ *		devcoredump_saved_buffer = kvmalloc(count, GFP_KERNEL);
+ *		__coredump_print(devcoredump_saved_buffer, count, ...);
+ *	}
+ *
+ *	void coredump_read(char *buffer, loff_t offset, size_t count,
+ *			   void *data, size_t datalen)
+ *	{
+ *		...
+ *		memcpy(buffer, devcoredump_saved_buffer + offset, count);
+ *		...
+ *	}
+ *
+ * The above example has a time complexity of O(N*2), where N is the size of the
+ * devcoredump. This scales better than the previous example for larger
+ * devcoredumps.
+ *
  * RETURNS:
  * The &drm_printer object
  */
-- 
2.43.0


