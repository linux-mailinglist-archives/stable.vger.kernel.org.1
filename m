Return-Path: <stable+bounces-176708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49EFB3BC78
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 15:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709433AE142
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CED31A548;
	Fri, 29 Aug 2025 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJuP1z9e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164BC6FC5;
	Fri, 29 Aug 2025 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473819; cv=none; b=QM/ZHfCsrtW1NR9xHtOJq+r5204bnaLJNHU3JrRrkw1oKO1+1yeS5jb5mpAGS4nKi43qKTfebMI/lyipN0+7Ux8t4hTNJEmoZGnNz1MmPyHVzK6wbKirFKRd+6ny1BSBX8IDcSuP96Bbw7aB64o6KD0O+78jJ3tx2mPURbqPrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473819; c=relaxed/simple;
	bh=uftIey/kDewVzHrnVcmLL9rZu1wmE0j/IP3oDq/orCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/dTgD9qO3rRovTxenB4o3a3XuhKxO6gbgMtQ+w/Gq1K1RmRTm/YN1BnlheWvYSJcPYZprgclmxHnsKvHxU/8JcG5rko4dQwfNOaYDfnW1oy9j3w+uifwjhWeALjYxb06liLPIWpmZTYZjl5DjmAWeRvLJeKNiNb9h/doLEedk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJuP1z9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FFAC4CEF0;
	Fri, 29 Aug 2025 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756473818;
	bh=uftIey/kDewVzHrnVcmLL9rZu1wmE0j/IP3oDq/orCg=;
	h=From:To:Cc:Subject:Date:From;
	b=PJuP1z9eXFKD227sW1+apYQKx4mRlPB33arzkfsePLcHJtm0ctJwbjDz5EEfcfJfr
	 EGX4FPrdYYHFYtBjKnr9aKnDgY6POkABESlAvsBLQ+3QFppyeps+HsQ4kef+zdCp5N
	 tMlBM7tjaxIvv1OS8yWleE641mW/ZXL1bz8qiS0yaUvR5sE5nf1fHDN6wV3CCELrLc
	 F8D+zCkSMBxmRH8pne717bGqaBXBVzCh69D0ztIVyhunYOGYRYEu3hw3DKvLwzR/CN
	 Brm5Rs9FhJs/WagMKa6UMFRKIYPNKdUZWJ/TJ5Y1ffuZ8T08xwiy8tRDOMVk2LLw2w
	 tgMnsEPIq1fyA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1urz4h-000000007N7-3tyo;
	Fri, 29 Aug 2025 15:23:28 +0200
From: Johan Hovold <johan@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: quirk: fix write to string constant
Date: Fri, 29 Aug 2025 15:21:52 +0200
Message-ID: <20250829132152.28218-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The quirk version range is typically a string constant and must not be
modified (e.g. as it may be stored in read-only memory):

	Unable to handle kernel write to read-only memory at virtual
	address ffffc036d998a947

Fix the range parsing so that it operates on a copy of the version range
string, and mark all the quirk strings as const to reduce the risk of
introducing similar future issues.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220437
Fixes: 487c407d57d6 ("firmware: arm_scmi: Add common framework to handle firmware quirks")
Cc: stable@vger.kernel.org	# 6.16
Cc: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/firmware/arm_scmi/quirks.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/quirks.c b/drivers/firmware/arm_scmi/quirks.c
index 03960aca3610..e70823754b0b 100644
--- a/drivers/firmware/arm_scmi/quirks.c
+++ b/drivers/firmware/arm_scmi/quirks.c
@@ -89,9 +89,9 @@
 struct scmi_quirk {
 	bool enabled;
 	const char *name;
-	char *vendor;
-	char *sub_vendor_id;
-	char *impl_ver_range;
+	const char *vendor;
+	const char *sub_vendor_id;
+	const char *impl_ver_range;
 	u32 start_range;
 	u32 end_range;
 	struct static_key_false *key;
@@ -217,7 +217,7 @@ static unsigned int scmi_quirk_signature(const char *vend, const char *sub_vend)
 
 static int scmi_quirk_range_parse(struct scmi_quirk *quirk)
 {
-	const char *last, *first = quirk->impl_ver_range;
+	const char *last, *first;
 	size_t len;
 	char *sep;
 	int ret;
@@ -228,8 +228,12 @@ static int scmi_quirk_range_parse(struct scmi_quirk *quirk)
 	if (!len)
 		return 0;
 
+	first = kmemdup(quirk->impl_ver_range, len + 1, GFP_KERNEL);
+	if (!first)
+		return -ENOMEM;
+
 	last = first + len - 1;
-	sep = strchr(quirk->impl_ver_range, '-');
+	sep = strchr(first, '-');
 	if (sep)
 		*sep = '\0';
 
@@ -238,7 +242,7 @@ static int scmi_quirk_range_parse(struct scmi_quirk *quirk)
 	else /* X OR X- OR X-y */
 		ret = kstrtouint(first, 0, &quirk->start_range);
 	if (ret)
-		return ret;
+		goto out_free;
 
 	if (!sep)
 		quirk->end_range = quirk->start_range;
@@ -246,7 +250,9 @@ static int scmi_quirk_range_parse(struct scmi_quirk *quirk)
 		ret = kstrtouint(sep + 1, 0, &quirk->end_range);
 
 	if (quirk->start_range > quirk->end_range)
-		return -EINVAL;
+		ret = -EINVAL;
+out_free:
+	kfree(first);
 
 	return ret;
 }
-- 
2.49.1


