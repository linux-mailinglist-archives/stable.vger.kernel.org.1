Return-Path: <stable+bounces-124775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE439A670F1
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 11:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B416422F4C
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 10:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311D9208970;
	Tue, 18 Mar 2025 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLyoYZ09"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B9207DE7
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292899; cv=none; b=HJGbYVqMoWwkT+gbnzfpcT/N3ziQ3+Pm/Rir7G0ZYGuxeitS7gTDow8b7H2r4+gnmBSEo9momldSUrFcmZT+PK1Mvv01SXbg1xJubb6ZsLD5TvW02HvYgQ4Gezri5PRpZM0d5CpT5LSl1KseLNK2voowbrtT0Xum3hvwnwtAtq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292899; c=relaxed/simple;
	bh=qgbreH565IsTmANQ6jcuU4QnCgPcSjS+1zqr0JjRNEs=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=k1/k3kfYB9gr3yw5fGiBW1FgLd/SLGeUL362qj6FHQiUlKmWNVGMkJB8iFFA9sEkPB0YKer+Cm8vcK7iysjUP0c+I85zziwuVY0/0D9dvvkJQZn5ebF6jWyR5NunMpXEb7s6wsTqJZLVsff3iR69XemDCKv9P5LSCjbat3h2n38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLyoYZ09; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742292896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=N2pxJRjJyW1cw5QoeNfYeEt/Fo+VzjEblG5ngppUQIU=;
	b=bLyoYZ09m1C6pDcGCkps+0/SZ3P/IeA/BN1Y/YJChKZPg6SGSve51zEn9/o7SoyAuE0GbA
	cZG/SSk0aZCMYbdzFwXq1/nqeNMAcNqLqxMYqmC6firao5tycrd94mADbMN0OBdxK+QeDY
	wI0HN8b7A+wmlJP/ckuMtT4GHP0ZKrA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-CGAihJ3WNlyH7E1GrkaaBw-1; Tue,
 18 Mar 2025 06:14:51 -0400
X-MC-Unique: CGAihJ3WNlyH7E1GrkaaBw-1
X-Mimecast-MFC-AGG-ID: CGAihJ3WNlyH7E1GrkaaBw_1742292890
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AE83195608B;
	Tue, 18 Mar 2025 10:14:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9FFD19560AD;
	Tue, 18 Mar 2025 10:14:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
cc: dhowells@redhat.com, Kees Cook <kees@kernel.org>,
    Greg KH <gregkh@linuxfoundation.org>,
    Josh Drake <josh@delphoslabs.com>,
    Suraj Sonawane <surajsonawane0215@gmail.com>,
    keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
    security@kernel.org, stable@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] keys: Fix UAF in key_put()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2477453.1742292884.1@warthog.procyon.org.uk>
Date: Tue, 18 Mar 2025 10:14:45 +0000
Message-ID: <2477454.1742292885@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Hillf Danton <hdanton@sina.com>
    
Once a key's reference count has been reduced to 0, the garbage collector
thread may destroy it at any time and so key_put() is not allowed to touch
the key after that point.  The most key_put() is normally allowed to do is
to touch key_gc_work as that's a static global variable.

However, in an effort to speed up the reclamation of quota, this is now
done in key_put() once the key's usage is reduced to 0 - but now the code
is looking at the key after the deadline, which is forbidden.

Fix this on an expedited basis[*] by taking a ref on the key->user struct
and caching the key length before dropping the refcount so that we can
reduce the quota afterwards if we dropped the last ref.

[*] This is going to hurt key_put() performance, so a better way is
probably necessary, such as sticking the dead key onto a queue for the
garbage collector to pick up rather than having it scan the serial number
registry.

Fixes: 9578e327b2b4 ("keys: update key quotas in key_put()")
Reported-by: syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com
Tested-by: syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com
Suggested-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: Kees Cook <kees@kernel.org>
cc: keyrings@vger.kernel.org
cc: stable@vger.kernel.org # v6.10+
---
 security/keys/key.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 3d7d185019d3..1e6028492355 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -645,21 +645,30 @@ EXPORT_SYMBOL(key_reject_and_link);
  */
 void key_put(struct key *key)
 {
+	int quota_flag;
+	unsigned short len;
+	struct key_user *user;
+
 	if (key) {
 		key_check(key);
 
+		quota_flag = test_bit(KEY_FLAG_IN_QUOTA, &key->flags);
+		len = key->quotalen;
+		user = key->user;
+		refcount_inc(&user->usage);
 		if (refcount_dec_and_test(&key->usage)) {
 			unsigned long flags;
 
 			/* deal with the user's key tracking and quota */
-			if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
-				spin_lock_irqsave(&key->user->lock, flags);
-				key->user->qnkeys--;
-				key->user->qnbytes -= key->quotalen;
-				spin_unlock_irqrestore(&key->user->lock, flags);
+			if (quota_flag) {
+				spin_lock_irqsave(&user->lock, flags);
+				user->qnkeys--;
+				user->qnbytes -= len;
+				spin_unlock_irqrestore(&user->lock, flags);
 			}
 			schedule_work(&key_gc_work);
 		}
+		key_user_put(user);
 	}
 }
 EXPORT_SYMBOL(key_put);


