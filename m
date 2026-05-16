Return-Path: <stable+bounces-248965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AooJIrSB2reKAMAu9opvQ
	(envelope-from <stable+bounces-248965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 04:12:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 158F5559DBC
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 04:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7818C3019532
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046A51A3154;
	Sat, 16 May 2026 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1itzru4"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845026ED37
	for <stable@vger.kernel.org>; Sat, 16 May 2026 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778897543; cv=none; b=OpwTkW7ALZL36bHSUPSdricLMX3eSWLnPc5rgZDy3hfaw2trdARLo0nkHFlydCG0/pJTWD0F7GeHl7PZn5aF2QGWUkd7AZNz8OfXsJWCxZSCtHeBJfMlMwZ6NeJyYcFdyrjUylTLmD/eyafMjZYbdQ1NKK6LGIg81ngF1LKDyTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778897543; c=relaxed/simple;
	bh=6rDfVuGVwaViFTnt51KivUesECctwWwNG4HfJaZ79Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oo4QbL7/1fiFaitrJ5IfKYd795dP+socwor7ScCWPWqekmtsY3dql6whlfgbLZcgoXCcsyPem/WYr9DHwWpI1Dks7hBKlpetbi6YU5eLRzpUwaG91d6VhzpOEWNEsLtbfAnpfJyI7lPt+MFHx+7hznoOAnxkPexdpNEw6O/fc7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1itzru4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7c52e49d978so833887b3.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 19:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778897541; x=1779502341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYNddEeOwGt0k46UY8z9L6gutGtCdNQjs1ntJnn2kyA=;
        b=c1itzru4+kchqma53pdKBn+FM73zrgb5ddppechgCp4cSpFQpWMiVZ8xw7B8PA9h0o
         9P6/F3QG4KYBOUFrHTmTlKwhslg849NSLxDGoYgEfooINkeMcaGPxV4Iq7Apv1T458vS
         q1otj22XCZTyfUhgmiB/KZCO/i5aqg8/+/w+NK+MLsUIXYDXLU/uFCXUC1vQ0WQd/owJ
         mDuUAd4zZ/ekSnZuVdZ3lm4SO2QDmRmpFRZo1GLfCm4g0n5j6txKA//NimmHbrnXy9t3
         4sFM8jBHI7zYLeNupCKSYFnsLilBzg5lWBOgIy1AziZvn+BZubWhrbDqTQF8TR7pQuUx
         tdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778897541; x=1779502341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYNddEeOwGt0k46UY8z9L6gutGtCdNQjs1ntJnn2kyA=;
        b=cpupHUsC8wUWFts8UCh69EfGvx96TP4/7yEJtlmcvuIK15dcwAEFoPgVS9WbE5kSoA
         fhj8uHAIvqi3Sj122ys41LZa6261zalVzbLeA00MECiGEnKRjkR+FAAOH8wb7Hcp8lzq
         gu2EsX5Tt2rOqlifRKoW1gb5J9/SqR/26FKVH9DlXYFrN0XoKo0PT9XQ59XrOTgN1eW9
         VBSfPeJeGLCeLHHMKY8Vi6secr0FqerDFA26dJbFxgsbzbdoG0+USw2G4Lnu3n/9GVPF
         VQS4hq/jisszuNL/IxMidGQa33lzA/N9t4+jR9kUDR4Dd96ZabX5BTlQ2sEW8fojqLAU
         p9Nw==
X-Forwarded-Encrypted: i=1; AFNElJ/+6UjN8eAzAPL+8HXAiQs85oHibcBV6Jzjw+tdL/er1wkkwJwLT6VgOhxAXyXzoPZTIyEf4w4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Ue0RtzpGj9gFy72IfmnyiwQTmN1W9EevSxDObaqKJLAV+qrg
	ZgSyo+z5vJXqIcBZri2COF5xnsvRQPLxuyr4vVa8dmUjieztNUsoiN6L
X-Gm-Gg: Acq92OFhsU2ZrHn7TruiMaIco4kM1qxxt/wMcQNL9igd/FTioz5StsN0Vj3+Yx25EoF
	i2rvRqmIR6KRDCQiNIdHz4gIbG7Yvz40uyHYcdrklrnnErMIkdT53pnSnZ6vr3bTI0R5OKjssRy
	Jh0NJ3c8hq6GPIpf93I9glXliqDq2j+756Q7xw1HyigzkJIJThUBF3fTdY+6eEVcGyA2vzqtLUJ
	LtJgmuNr4xDjLpyfEUY5RounylLrERVI494IJuNTWaZ2jykWqtKwedXYrCNblpDgOPVt84nR6Vi
	ANSevC7wpuC3cyWB/j9n4jHlDU40oJpsF0Pe4EC31hirTIT5dpkfIcDkUbhn6pw0k4KRRVjbuLP
	CrFBz+jhBbn4/kAOzxzKoW5p0HeaokKbASHYSy+/l6tnS5BPl1BkjL2ZyL6gKWuEArvIRgN1Eh4
	uGIZZ1p8H948RctX/+jso6lANr0UNWU6A=
X-Received: by 2002:a05:690c:3705:b0:7c0:4f0:883d with SMTP id 00721157ae682-7c95d1d977cmr73877487b3.44.1778897541467;
        Fri, 15 May 2026 19:12:21 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:1b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f28b810csm37583987b3.14.2026.05.15.19.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 19:12:20 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	bernd@bsbernd.com,
	ali@ddn.com,
	horst@birthelmer.de,
	Heechan Kang <gganji11@naver.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] fuse: fix moving cancelled entry to ent_in_userspace list
Date: Fri, 15 May 2026 19:11:38 -0700
Message-ID: <20260516021138.2759874-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260516021138.2759874-1-joannelkoong@gmail.com>
References: <20260516021138.2759874-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 158F5559DBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,bsbernd.com,ddn.com,birthelmer.de,naver.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248965-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,naver.com:email,ddn.com:email]
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
Tested-by: Heechan Kang <gganji11@naver.com>
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


