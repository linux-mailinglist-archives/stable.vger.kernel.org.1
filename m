Return-Path: <stable+bounces-27481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288D3879A2E
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FED1F22945
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418FA138485;
	Tue, 12 Mar 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8JyDKoP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46343137C59
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263116; cv=none; b=QGivXtxYKqTIxfEOHlxSs5zMH75vLgk7RGX1OotMSLiTij97AL9Ys+ruJAutkjYa0SX9UVLhhb4qEiBl+KJMRDqUKL4OPSo4qEXhXrR0vsMvIn9d78bNOIc8IInUATVaAxDBKVVhlwHoiPWLdm99H08vSeyB1WGpx6tua4zJapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263116; c=relaxed/simple;
	bh=mqacdEnTEUxZXUuYPzIgUOl/DOwKnYJ/srY3KSwSJmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAnF369XU51Fmy8DoxM5/8a7BWDHHZp6zKvouOx46QiSwM8sTtVzffBHyLHe3Y23KJoNnIZrz5NKbPo0QMhJ6MinmCLWwjg08PrbvFa/eLg9am4Z4I7GAI1HMVDlj6JDBCLvcvcfugYVvbJHIXZ9j/qibnlFTAFzalnrxo8zRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8JyDKoP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710263113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxWm6dgYYUOBOTUzRYhpa5cPMiW/bLetgox5JOgEpWM=;
	b=H8JyDKoPEWGx0S3rfoz/EVrmiADcIGnslmcJLwCAaA8nfiYsndbATd4Y0CW2ipYAOAb75C
	5g8A0vBSDSJN6x8FLjQLsN5pdoO5bCEvtM/n357yJxdt4ezK3XOsMMHTKzenH2PtbJxr59
	v8ViyzDs8HTpoBUh5nXWL6mjna9odnY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-AH5aiwmcPNeuVltqM2i4-g-1; Tue, 12 Mar 2024 13:05:11 -0400
X-MC-Unique: AH5aiwmcPNeuVltqM2i4-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE44F80F7F0;
	Tue, 12 Mar 2024 17:05:10 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B94F8C017A0;
	Tue, 12 Mar 2024 17:05:10 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	stable@vger.kernel.org,
	vvidic@valentin-vidic.from.hr,
	joseph.qi@linux.alibaba.com,
	ocfs2-devel@oss.oracle.com,
	heming.zhao@suse.com,
	aahringo@redhat.com
Subject: [PATCH 2/2] dlm: fix off-by-one waiters refcount handling
Date: Tue, 12 Mar 2024 13:05:08 -0400
Message-ID: <20240312170508.3590306-2-aahringo@redhat.com>
In-Reply-To: <20240312170508.3590306-1-aahringo@redhat.com>
References: <20240312170508.3590306-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

There was a wrong conversion to atomic counters in commit 75a7d60134ce
("fs: dlm: handle lkb wait count as atomic_t"), when
atomic_dec_and_test() returns true it will decrement at first and
then return true if it hits zero. This means we will mis a unhold_lkb()
for the last iteration. This patch fixes this issue and if the last
reference is taken we will remove the lkb from the waiters list as this
is how it's supposed to work.

Cc: stable@vger.kernel.org
Fixes: 75a7d60134ce ("fs: dlm: handle lkb wait count as atomic_t")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 652c51fbbf76..c30e9f8d017e 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5070,11 +5070,13 @@ int dlm_recover_waiters_post(struct dlm_ls *ls)
 		/* drop all wait_count references we still
 		 * hold a reference for this iteration.
 		 */
-		while (!atomic_dec_and_test(&lkb->lkb_wait_count))
-			unhold_lkb(lkb);
-
 		mutex_lock(&ls->ls_waiters_mutex);
-		list_del_init(&lkb->lkb_wait_reply);
+		while (atomic_read(&lkb->lkb_wait_count)) {
+			if (atomic_dec_and_test(&lkb->lkb_wait_count))
+				list_del_init(&lkb->lkb_wait_reply);
+
+			unhold_lkb(lkb);
+		}
 		mutex_unlock(&ls->ls_waiters_mutex);
 
 		if (oc || ou) {
-- 
2.43.0


