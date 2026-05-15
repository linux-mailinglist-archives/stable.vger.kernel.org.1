Return-Path: <stable+bounces-247330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ/vM7CnBmp0mAIAu9opvQ
	(envelope-from <stable+bounces-247330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:57:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5625495EA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E38C3019514
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20C73DA5D4;
	Fri, 15 May 2026 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We8oIRLr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B11F3D9DB4
	for <stable@vger.kernel.org>; Fri, 15 May 2026 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778821027; cv=none; b=VSnbkVSxU1Mihez3TiRIBoSTIuzP+9/f2NvMjU6CAhWpdrM9QYZYxl7YJM1LvnMmwEyg2WrbE24ZzacnAP2DTGuBwSTSuqy6VnJFX8E6YkNP8q7S5zvpKusA0EqhOviuO0NvZ1fgppjCot9I7j6+AQrwzXJVhX8U5R5tlK5XYOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778821027; c=relaxed/simple;
	bh=8anho4fFafOkQ7VO2BHenK+uWV+NyCTbuWoVR44uJFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDxcNY26Aa+4Q2YznJgHtuQ5VC+2yX2bSkIYi6jVoM3PudYOGHoOu8mZJG4mqYXtL5bqQ58eG/InYiBLqkp6VWb/oxFpKWZmdx63w/7NCmroV4db5lQ3O9AOEFcP0BjLPyl8MXvuopLbmrMJ0Ar3xk4fG6Wrrv0rehaRH9IwMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=We8oIRLr; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65d071aac6eso9929019d50.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 21:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778821025; x=1779425825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edgngAWE4Uy3YSnzl78s2yIdpRinkyGEnbGIaCerM2o=;
        b=We8oIRLr3AaxpJnzcUBNLuqqfk2dfji36pTzwmKvVdGc2KwLw3j9PbUWomFiYoxiTG
         ZDK6ePd+PaaGKoxGdZjM/2m8mrodGXT9x+lbEVZrY5vLe6rY2QGQSp2OwhsBJDYriai0
         edSIOYosGwVP7pjz2qEay5dkaTdn4yyW0w4J0iOfq6aLK7J+JwOzbyD8/SC/OfcmphGX
         k6AMScNrZvdYcOy/8hg6HKBSmswGlkYEdgeZDqXGqPbpfLaJ+PmxOkFfNAuN5pose1uX
         JcqMnPovdyajdBcYvVILWUB0tCuqoqim1iWGwLfN2qO21rSzdzhM7d/Nrt2ONbGAnpbN
         Da3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778821025; x=1779425825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=edgngAWE4Uy3YSnzl78s2yIdpRinkyGEnbGIaCerM2o=;
        b=IyQ7D1MgnfyuVZz2vNy+mils1r4fP8KLwOiW+mtbcomotfiwxh1uYgjDPACon5CFxt
         MG5QBmqwfOSORv1EtIzBv/AqhJxv/vDTcYHo2zToKbmhAnzm7MShnCx1TaAoZh6rtSpS
         SJYcUWlrdslmLekmIO9LhzlbTHzrpIzrb5k8Q8RWNBDQ5Ay6VUrZiGs3PmwwbQx7fgjt
         LSd0CmklxSIiusLFgku9Rm+NGoevbVBmfiJbTbc75v/j1fzcJJAAomz5N07TQPRX8qYh
         4PCdHa3EIKGfYRgqQ43FcMbllN6O68mAJIrixRckhtTSEvnNq24KjcNV6JbeCdzrCQDm
         entA==
X-Forwarded-Encrypted: i=1; AFNElJ/CzmHB9f6RkwrlYC3A8uE/KcDfSxbzpQWZPQKTSGLz5Ykre7fgucwiNhYXvELJbaUtaHVkurs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrIbkT5Kfhryj8xp5avqYqKoz6iYo8bUsX3T0HH6rrbivvvQiI
	v3rVR6pUT/1hzai5ClrNbCgU4+Wx+vJrbpCtsLMcC5gLHyeTQgsDycf8
X-Gm-Gg: Acq92OFdj8J10o6Jbo1BoIN2z9PzipyibpCGMdxGU1jgWvjByHNTAR7Mur6YvzVqtYo
	kcyiVtIiYN/yz273QSRacmn77R2X3N3GuI91KVOFFlgOg7Ldfq8mkkZgbQvA4p34dvbl3a2enmk
	KxhlALhViwAmHN8DKrlCLakIj7dSrjjrIfm6PT2s5ku2gYEMF9ALCkpCmNkhT9rTz/dePgR+JmH
	MKrJTL5QN2nca+oxBL0oHUrlpW3MYq5cCnsUtvsWzbt0ygAvP5TTV0Tm+vHY92UQpfSGgI3Rqac
	QKKxBr4qN3clubgO1Sd9S6in3ybDSmAgw/XN46nSrZrWJLxREyfEIwugfUBjOTPL6/nks8eNoYd
	Gy/DGj8rCqYSq36AmJOZOiRex9cH0usvcNNfrJJivfl552wzDrW4AUcSvxX27A4YqcBF3JuhAHV
	yR2sSKnoBjjm/Akl04Hw==
X-Received: by 2002:a05:690c:e3c4:b0:7b2:9347:7bdf with SMTP id 00721157ae682-7c95c202cf2mr28579087b3.37.1778821024944;
        Thu, 14 May 2026 21:57:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f55ba65fsm24152597b3.36.2026.05.14.21.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 21:57:03 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	bernd@bsbernd.com,
	ali@ddn.com,
	horst@birthelmer.de,
	Heechan Kang <gganji11@naver.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 3/3] fuse: fix moving cancelled entry to ent_in_userspace list
Date: Thu, 14 May 2026 21:55:41 -0700
Message-ID: <20260515045541.1171335-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515045541.1171335-1-joannelkoong@gmail.com>
References: <20260515045541.1171335-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C5625495EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,bsbernd.com,ddn.com,birthelmer.de,naver.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247330-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birthelmer.de:email,naver.com:email,ddn.com:email]
X-Rspamd-Action: no action

fuse_uring_cancel() moves entries that are available (these have no reqs
attached) to the ent_in_userspace list. ent_list_request_expired()
checks the first entry on ent_in_userspace and dereferences
ent->fuse_req unconditionally, which will crash on a cancelled entry
that was moved to this list.

Fix this by freeing the entry and dropping queue_refs directly in
fuse_uring_cancel(). This is safe because cancel is the cancel handler
itself - after io_uring_cmd_done(), no more cancels will be dispatched
for this command, and teardown serializes with cancel via queue->lock.

Since cancel now decrements queue_refs, fuse_uring_abort() must no
longer gate fuse_uring_abort_end_requests() on queue_refs > 0, as
cancelled entries may have already dropped queue_refs while requests are
still queued. Remove the gate so abort always flushes requests and stops
queues.

Reported-by: Heechan Kang <gganji11@naver.com>
Fixes: 4fea593e625c ("fuse: optimize over-io-uring request expiration check")
Cc: stable@vger.kernel.org
Co-developed-by: Jian Huang Li <ali@ddn.com>
Co-developed-by: Horst Birthelmer <horst@birthelmer.de>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c   | 6 ++++--
 fs/fuse/dev_uring_i.h | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index d9108b5b5db8..f4ba64a1796a 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -511,8 +511,7 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
 	queue = ent->queue;
 	spin_lock(&queue->lock);
 	if (ent->state == FRRS_AVAILABLE) {
-		ent->state = FRRS_USERSPACE;
-		list_move_tail(&ent->list, &queue->ent_in_userspace);
+		list_del_init(&ent->list);
 		need_cmd_done = true;
 		ent->cmd = NULL;
 	}
@@ -521,6 +520,9 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
 	if (need_cmd_done) {
 		/* no queue lock to avoid lock order issues */
 		io_uring_cmd_done(cmd, -ENOTCONN, issue_flags);
+		kfree(ent);
+		if (atomic_dec_and_test(&queue->ring->queue_refs))
+			wake_up_all(&queue->ring->stop_waitq);
 	}
 }
 
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 368f4d0790eb..22ec67e39ee0 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -150,10 +150,10 @@ static inline void fuse_uring_abort(struct fuse_chan *fch)
 	if (ring == NULL)
 		return;
 
-	if (atomic_read(&ring->queue_refs) > 0) {
-		fuse_uring_abort_end_requests(ring);
+	fuse_uring_abort_end_requests(ring);
+
+	if (atomic_read(&ring->queue_refs) > 0)
 		fuse_uring_stop_queues(ring);
-	}
 }
 
 static inline void fuse_uring_wait_stopped_queues(struct fuse_chan *fch)
-- 
2.52.0


