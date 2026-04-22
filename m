Return-Path: <stable+bounces-240335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJovBi3e6GnOQwIAu9opvQ
	(envelope-from <stable+bounces-240335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:41:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1CC447602
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA20330EDF8F
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1590B3EDAA1;
	Wed, 22 Apr 2026 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pomsCqr1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE003ED5D0;
	Wed, 22 Apr 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868508; cv=none; b=Q0FA+Ta5WZrMN3HWXSSGYOMVH8C+6YGvbKdzxEmO5ccbtGuu8UP8IwRJrjdU07KNyauUyOFTd2l17GYuU7PNVGigEyC6YSuMX0qWG80/nuAN5maZXB3bTarj4MVMI9Q+eR6XiFyXc4BFvwv/Vi6LdWNsVZfqXBVFRXxhLYbHhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868508; c=relaxed/simple;
	bh=phPSB3hsN5vcta7v48KcUcyjcHZo8DALfnPrjPsZe8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4Js+KhDo5p59pqFiuxPJOwwC7FRmTId4MY1H5inY2RCv2HGxEN3Vo7D8Z2zGdnL8x3rCjbW30szCDW5Gwj7y3o7tA1HTPfV/AYvZms7yEeu0DlRO0j+eYRcPOCZdThxPKv3Z6nYarsyvMUMYJPQZqwuvYEPKdFYl9NKneoCFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pomsCqr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767A6C2BCB4;
	Wed, 22 Apr 2026 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776868508;
	bh=phPSB3hsN5vcta7v48KcUcyjcHZo8DALfnPrjPsZe8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pomsCqr1yF5C/tYG71y0u5knBxZDPNu8jOtVIz8EULIbQ/BnIhYMFquAqfIrBrsmc
	 uiSK8toywvsJI50TlUAzEtP7y0pAzGCHCmUGtSPbT9TMpiimgZoeE/XQeXFfXM4ZvM
	 ndVypsrEmtwcqpdA9QHaU98HU4WcWzvFwmot2DDK/S1NFfB/VYi1eKrE3vcQDI2AF4
	 W6ebe39N0NmhMT07OvfcPrLMVDL85n0ArqhBszKLldyuDEr6RqdppAwphxSA8isIrW
	 gu8YiLT7b4/1+I68ihHiTS4wBxvnWppLdQC3TBU1vmQoAUA28ofVWRGR/+WdH7f5Xn
	 koRpV4sM6CnGQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 19 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Junxi Qian <qjx1298677004@gmail.com>
Subject: [RFC PATCH 2/2] mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock
Date: Wed, 22 Apr 2026 07:35:01 -0700
Message-ID: <20260422143503.71357-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422143503.71357-1-sj@kernel.org>
References: <20260422143503.71357-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux-foundation.org,lists.linux.dev,kvack.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240335-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD1CC447602
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

damon_sysfs_quot_goal->path can be read and written by users, via DAMON
sysfs memcg_path file.  It can also be indirectly read, for the
parameters {on,off}line committing to DAMON.  The reads for parameters
committing are protected by damon_sysfs_lock to avoid the sysfs files
being destroyed while any of the parameters are being read.  But the
user-driven direct reads and writes are not protected by any lock, while
the write is deallocating the path-pointing buffer. As a result, the
readers could read the already freed buffer (user-after-free).  Note
that the user-reads don't race when the same open file is used by the
writer, due to kernfs's open file locking.  Nonetheless, doing the reads
and writes with separate open files would be common.  Fix it by
protecting both the user-direct reads and writes with damon_sysfs_lock.

Fixes: c41e253a411e ("mm/damon/sysfs-schemes: implement path file under quota goal directory")
Cc: <stable@vger.kernel.org> # 6.19.x
Co-developed-by: Junxi Qian <qjx1298677004@gmail.com>
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8d32a20531d49..245d63808411a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1197,8 +1197,13 @@ static ssize_t path_show(struct kobject *kobj,
 {
 	struct damos_sysfs_quota_goal *goal = container_of(kobj,
 			struct damos_sysfs_quota_goal, kobj);
+	int len;
 
-	return sysfs_emit(buf, "%s\n", goal->path ? goal->path : "");
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	len = sysfs_emit(buf, "%s\n", goal->path ? goal->path : "");
+	mutex_unlock(&damon_sysfs_lock);
+	return len;
 }
 
 static ssize_t path_store(struct kobject *kobj,
@@ -1213,8 +1218,13 @@ static ssize_t path_store(struct kobject *kobj,
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
+	if (!mutex_trylock(&damon_sysfs_lock)) {
+		kfree(path);
+		return -EBUSY;
+	}
 	kfree(goal->path);
 	goal->path = path;
+	mutex_unlock(&damon_sysfs_lock);
 	return count;
 }
 
-- 
2.47.3

