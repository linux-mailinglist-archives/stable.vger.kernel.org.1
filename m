Return-Path: <stable+bounces-240513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFN2AtA06mk+xAIAu9opvQ
	(envelope-from <stable+bounces-240513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 17:03:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8264540DC
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 17:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76E05301B069
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94068363C64;
	Thu, 23 Apr 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPORGTu8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B9361DA7;
	Thu, 23 Apr 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956583; cv=none; b=bCCYUE7h8yX8lLSP6CEosHBJq5LS+k1guZlXbMXSpdSv+sqGi070XSC4xsOOPqlPQrDhJXuHqdgrxTjnEMx3iseAoX2kPaKN70mifv9tbfS71HbbZbKMnS5BdpwiaLEHb4v3obtzN0MuZQ9ojrSSLnwj6mPvuhIuVfAQfFuH6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956583; c=relaxed/simple;
	bh=pgIYrrAK6X9JUhNoZ3jKTnGdrjt9Atw8Bt+OO+9uPx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWMYvdQq473+cjL7ex7N+HrIic33L2RHhTzAG9TK40leDdcDwtzu/CylwM5K8q3+u4odyZQOqwoyky5nme4LMAw3RK5/HmH27SWhINjSp3A6RjWsU6nXy0+AIuIAJ2HAkXTAZ2y0tdWiBl+c7TW80yeYHhU/gacr3KfaUoYyXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPORGTu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76B9C2BCB3;
	Thu, 23 Apr 2026 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776956583;
	bh=pgIYrrAK6X9JUhNoZ3jKTnGdrjt9Atw8Bt+OO+9uPx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPORGTu8YrJGGYX+HnAjs4fhHzD34EJaP8VvY8cmPf2H1h2K+ynmjdiqsDJRpNLx3
	 oAm8LmDxiObij537YgRsVv9oM6ALhzLZkIQDw1MEvXIvNKegud7BicI9LVHanw4j7R
	 3t2gL/IrQucxdYlwOPIdTfmG1QMwtO6BtcCK1qYkgnmzXqXjInGFKvYrEhKnmXyCyH
	 1ZaFAbhm8Ku55oGUt7sPh1Bc9RRftEt7WR0RJUwyCPEkJCbaEisbwjOAlB55phTjfx
	 ZP00VagCX+shexDpBGPApTmnSfdHaW0XBr33sR3yM7T8Ucy3gX/c1EwD3zf2KJV69W
	 mA0XhtYkvvv5g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 19 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Junxi Qian <qjx1298677004@gmail.com>
Subject: [PATCH 2/2] mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock
Date: Thu, 23 Apr 2026 08:02:52 -0700
Message-ID: <20260423150253.111520-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423150253.111520-1-sj@kernel.org>
References: <20260423150253.111520-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,kvack.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240513-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C8264540DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

damon_sysfs_quot_goal->path can be read and written by users, via DAMON
sysfs 'path' file.  It can also be indirectly read, for the parameters
{on,off}line committing to DAMON.  The reads for parameters committing
are protected by damon_sysfs_lock to avoid the sysfs files being
destroyed while any of the parameters are being read.  But the
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

