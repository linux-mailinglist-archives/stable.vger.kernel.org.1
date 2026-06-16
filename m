Return-Path: <stable+bounces-263531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B4XaAi/EMGrLXAUAu9opvQ
	(envelope-from <stable+bounces-263531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:34:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F26368BB5F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:34:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GZTFbBoY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263531-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263531-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D913086FF5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05A03C1F5C;
	Tue, 16 Jun 2026 03:31:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989C2F8EB1
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 03:31:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781580715; cv=none; b=U867TgHCI7MymYrWgMrJjTfTTHPwQ6a/CfCr6YF6Slbx3JXoARrbK0G1pwBPIroSSbbIeDNMH+Te+OOWfT+c19on7rWze9cxHzPYgGSD1hTenww5KiSVhlU9gGrW3p+FPwCeYaTeWZHiQCzHXysT3MEy5RSTEd1//r4F8f8R0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781580715; c=relaxed/simple;
	bh=HdnUOl1l+RkZ5GaFt9HUheU0pn0+jR0TmMe+1dE0/aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cex560lwLsj8TvjIxqzEop+3f1OA3fvJE8rS8litBBPCzZ0DySWFxxqXhRT24ab9jjt5oOxzL3dEihWUf/3TCyKDLx91/vxIyEX9LCKLOzJQ3Dz1Na4L6dYJ1OatEmkJ3Uo9hm79tIiejjy01RlopyNRxq3VtMg5O6A5klhikKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZTFbBoY; arc=none smtp.client-ip=74.125.82.170
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-307631dbfedso8640764eec.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 20:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781580713; x=1782185513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNkVhMAn/58nH69bVy+AD5u4skvW0u4EW5LxAgOT2F8=;
        b=GZTFbBoYo50YrQc7J4eQdko/My2vi/ZMvLLfWuL3p01G6kYHZyzGcWaDYzE7SWFqz6
         gSU57Hi2FCpxywqn1SBRWzH/Mi9UI7NsfJeedLbJnnVqrLQSU4PXmFhUopnKmdby9Pel
         WFnxPamZT2Ejdik0WAjlXv+1i6tzLB62vNPqniCFCKwEqOZqxGIrvxZ19Kaa77mHJhpw
         IUg7S2PfHgIInxf6dc+2H9U2tC4+if54pUdBStEgrFvxCD12+3Y7dhFZqD/zULwLJl65
         OmaEZOBKZcCb7xWLzYtiAb4vNC4cWMo1GLsEPR1kjgwMtSFSlg41Z653Q7BTyrFGofH4
         BD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781580713; x=1782185513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNkVhMAn/58nH69bVy+AD5u4skvW0u4EW5LxAgOT2F8=;
        b=SkGIuEQinoyODfWpy1pXRAmNVbaoZNx/LnaFTt8Fmnv//307EHKA6AMG11X16jOQV8
         3TZ83//JfzofrcnJnBwc1YP7tHOPuuwiSXARUQ1hEdhPg/BTtku9d9Z47vqq5O7hQEk0
         CGF5/R3L6R9AeqECaEbdMvMopgew25svlMjFo+h+O38cT0kKZD1r9yy50KOsU1hcMko0
         iOkJA4T1c/YJdaFcncSfDagMAVViGC5AZ2xZQXgm/xoQlsk9le60f8rpGOxz6PsvG5Bc
         rlXaxZediUDE7PYEtmiEsr0XjO8zh2ed51uFCJzHDpmZCfW+m8JM+YjXnSpKYRLilCVK
         JIzA==
X-Forwarded-Encrypted: i=1; AFNElJ+5+deVxIO7sLQs0Cc1yXo19zQtY3eH47B43EXQvMoFePQXEYggJnVQmuo9/KGQO+7UCoS2x6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGvFLxixWWlIMFywUCXtF7eG84/6THrqWW+rJ4JEtdxvI1z1b
	zD+Yw+va0O3LMz+VmrCBfsiygLvKmvInhE3Fsj2Z2bzpFTEe2SFpbeGi
X-Gm-Gg: Acq92OF3P3lC7A68YuzzBRZw7iRmqmzImANAmre3exkdU67d8Is87Tu6doNRCo8NqQw
	cARWLev9SsiZTiKCfKyb452rebUZBYOz6g4Cj4zFxZ6LgPD6FXrpB/AtsVBbFig9ciNxlWPmlma
	VcSWq6XM13/NpUUyjZnvOIx4Di1P5IQWrqPMyqWq1SCIPpmJMQUir0vR7B2jVnWk/qqMSDR0pc1
	Mi2wrtQp9PafYqteCiK1HZl1DBcf6HWlFyrVRex7Kja0l4FgvRKfAqPNUz0hiHLvtTD/CpFuAPy
	xPAaD4vCm82PKNG75Cu3dEPbEi4EHeipbKCp3FDMn616G9y2Wi/V8RIkVfUnuZZArA+tykA7nqP
	j6voHdyaFtg0EuyMRZmgfzFENpplYA8uKkN5qhagcCIYx6sZqH+I/2Eeg+QerTCJi5EcLp1Tbir
	O1DbAyB4O436oC64KdjlZEpXHG4nr/DEMJMvQIkyZjRXuWprF4x05opgzFm7bG0WUoqxztjg==
X-Received: by 2002:a05:7300:1907:b0:2d9:fa9c:87a9 with SMTP id 5a478bee46e88-30ba598cf1bmr1228980eec.5.1781580713466;
        Mon, 15 Jun 2026 20:31:53 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e92096esm17685798eec.15.2026.06.15.20.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 20:31:53 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: geoo115@gmail.com,
	stable@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v4] f2fs: use post-decrement count for cp_wait wakeup
Date: Tue, 16 Jun 2026 11:31:46 +0800
Message-ID: <20260616033146.127000-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS(0.00)[m:jaegeuk@kernel.org,m:chao@kernel.org,m:geoo115@gmail.com,m:stable@vger.kernel.org,m:linux-f2fs-devel@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:qiwenjie@xiaomi.com,m:qwjhust@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net,xiaomi.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263531-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[qwjhust@gmail.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qwjhust@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:mid,xiaomi.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F26368BB5F

f2fs_write_end_io() decrements the writeback page counter and then
reads it again with get_pages() to decide whether the last
F2FS_WB_CP_DATA completion should wake cp_wait.

Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
decision is made from the value produced by the decrement itself. Keep
the existing dec_page_count() path for other writeback counters.

Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
Cc: stable@vger.kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes in v4:
- Add Fixes and Cc stable tags.

 fs/f2fs/data.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d83a21998ec2..58d23eb74ec2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
 		if (f2fs_in_warm_node_list(folio))
 			f2fs_del_fsync_node_entry(sbi, folio);
 
-		dec_page_count(sbi, type);
-
 		/*
 		 * we should access sbi before folio_end_writeback() to
 		 * avoid racing w/ kill_f2fs_super()
 		 */
-		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
-				wq_has_sleeper(&sbi->cp_wait))
-			wake_up(&sbi->cp_wait);
+		if (type == F2FS_WB_CP_DATA) {
+			if (!atomic_dec_return(&sbi->nr_pages[type]) &&
+			    wq_has_sleeper(&sbi->cp_wait))
+				wake_up(&sbi->cp_wait);
+		} else {
+			dec_page_count(sbi, type);
+		}
 
 		folio_clear_f2fs_gcing(folio);
 		folio_end_writeback(folio);
-- 
2.43.0

