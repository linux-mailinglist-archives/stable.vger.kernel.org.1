Return-Path: <stable+bounces-247328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJnNJJ2nBmp0mAIAu9opvQ
	(envelope-from <stable+bounces-247328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:57:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 352515495DC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EB5C302C33F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3B93DA5DE;
	Fri, 15 May 2026 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKN8x6NR"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C723CF03E
	for <stable@vger.kernel.org>; Fri, 15 May 2026 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778821019; cv=none; b=J4/UIKDHxwhRVd2gDJ0HcNZ1Gkp61ODmPYZG8Xz/tx0NZwLbSUnVetPQo9RRdlWg7Q8059tBESEtNAYZDEl/07w2DNGCQ/we7pIa3PMH5f8Z8SL3GKXSnxzWhsE5mRH+kpTeEkezCs9zC4L06BxU9hBugKU0b/THsJYQQjA6lmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778821019; c=relaxed/simple;
	bh=OFdEVbdpC3AebCbnGGYLJCYlvH+UTf19g3GUYE3pbXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9g9gBPc06Vl5ZbL2uRnUQmOzQ+ye4/tir9+YU1QTD9G8HguEuxcKrOxo/lx4AE91jqQEfrc7T+9o/nOoG3Lvt6Oox9AeYpgUMg2N+jIQqEYZYrxIBSHKyrsClEuvVC5KEuIQK3cHeEZ4nufczInqLhj95fxiTz3Y8n8BdWV4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKN8x6NR; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c364b893aso10626899d50.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 21:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778821017; x=1779425817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lsLoK3AxyGdMTmEXeQJhC+bemG3+7BtONdzPTpcmFQ=;
        b=DKN8x6NRzCJpwsYjapC523kwADQCFnYRTSYrlaqd+CS39NYa+3DoMEkBy4i8nY3ySt
         rM1yAtUMzD//sCWY04bwZNkyf7E0oE9NhtyWIWi0dgQtCnmHmyeJtUweShPCcTIAeRAc
         h3T6Vdd0PRVF6BatD+kQVW5jYmdiG0AYBe9a2SH+t5wYKQ5JnTn6rdG1DjIf1ifr7x0Z
         cAb1uUaf2Z5TOsKRBXf/e/xD76sSNrThDXeWUhkFSZRPKjK45dT+WrEP8+hKT3Try546
         FpEe6cJksRm+g9jCdYEtyaN/SQ7CqNmRkH0f/myuuSURqOp9mU7NbIarqlm+7+ADZggh
         VqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778821017; x=1779425817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4lsLoK3AxyGdMTmEXeQJhC+bemG3+7BtONdzPTpcmFQ=;
        b=o5n5JI3DCZRPkVgkJ21Q4UxsRTwEmRZV4s+XC8OAhfLEawzq3hGo+HMrDlG2jXUv0D
         o25GqP9ysrUGIQdquZl9WO9LpUnuYz4GUc8UNZQeN4e+1HnlzoWQhx5txKF4zk9ELQXX
         wstbfOMpKZFJrhVr4RiedZYVkgCFVEGBv4NKkmj1DmTkJ0l131BiVFfz37fXGD3Qy8D+
         t5BUFz+1thUETqZMVfR/BooN1euf/ekYZtjT+3BaqgUrGG1JcsmuTk2/7j2FwLgCJlih
         7yqJajerOYy3kRHBg7h2lRu+dkggcaf/YwGRX9qVL+mQO5b60s/GIzEK2a8FVyFM2mGB
         TIQw==
X-Forwarded-Encrypted: i=1; AFNElJ9z3cWdam451SIlOeX9JOZ3TFBtEB7kfQKIkWK+zGbKIh8aSl66qbiV3LWprUf0BORgfuX0pO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTnlT3wZyBAGGX50KShXQ5mHJOE+TmtlbGj7dfdt191GhhoJX
	5w6EOxnfY6VY06lNeAjobgaghIUO2rPsJ8+REn6Sw1mz9ixMqwxRxfLZ
X-Gm-Gg: Acq92OEXxAwroNn9loWl40hKZc4DUkVDiJ/3dRFDoXqmFEv1Wtwd7OguwOB2ZwqDLxH
	elL5nyw1ZbkoUqAn6odROqiQwifHzmdeY7RLwhJbHXmdsyc/DXYl5bxJNmEpfzJqkCjfTuh/lkb
	zbWxmlB1N8K9SScKe+UPRcJmB8vBFNOj40qTFhzPF4z7oOIFn2puQUtMz9TPxaKusqZOgYt1Riy
	sLeoggwFQIdhcg3c2glHCY6ItTgYnf2/JxVJApJsO/OyLvGO1kDKA5SE/5Y4JyCTEsGsLPMuhKp
	NUCd8GeFMNFdavlhn43cQURSEZ2q8AOq6W11hHgetcJYLb3Vj3zzAec1CKH5sur+EBgPuJx8Wqn
	D/eFH5htBtc8WwQWyXnnjmB6vfq2vSsVYCSRwLzOmrmHyTfSA0Rr8bGKMszTgQmRv5kEcmC4M4G
	GICtWkOWjoZdpxgWP5xYjYOohna/W8vfw=
X-Received: by 2002:a05:690c:4992:b0:7c8:615c:7b55 with SMTP id 00721157ae682-7c95b72f113mr24415277b3.23.1778821016708;
        Thu, 14 May 2026 21:56:56 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:3b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f22d0851sm24765667b3.1.2026.05.14.21.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 21:56:55 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	bernd@bsbernd.com,
	ali@ddn.com,
	horst@birthelmer.de,
	stable@vger.kernel.org
Subject: [PATCH v1 1/3] fuse: fix race between ring creation and connection abortion
Date: Thu, 14 May 2026 21:55:39 -0700
Message-ID: <20260515045541.1171335-2-joannelkoong@gmail.com>
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
X-Rspamd-Queue-Id: 352515495DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-247328-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This fixes this race:
- thread a: fuse_uring_cmd() gets called, passes fch->connected check
  (connection abortion not yet triggered)
- thread b: abort is called, calls fuse_uring_abort(),
fuse_uring_abort() is a no-op since ring == NULL right now
- thread a: creates ring, creates queue, creates entry

which results in
- leaked ring, queue, ent
- if thread a increments queue_refs before thread b calls
  fuse_chan_wait_aborted(), then fuse_chan_wait_aborted() calls
  "wait_event(ring->stop_waitq, atomic_read(&ring->queue_refs) == 0);"
  which will hang the abort/unmount thread indefinitely in unkillable
  state, as nothing will decrement queue_refs or wake stop_waitq.

Fix this by checking fch->connected under fch->lock in
fuse_uring_create() before publishing the ring via
smp_store_release(&fch->ring, ring) under the same lock scope.

Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e467b23e6895..cd75f61018ec 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -244,6 +244,10 @@ static struct fuse_ring *fuse_uring_create(struct fuse_chan *fch)
 	max_payload_size = max(max_payload_size, fch->max_pages * PAGE_SIZE);
 
 	spin_lock(&fch->lock);
+	if (!fch->connected) {
+		spin_unlock(&fch->lock);
+		goto out_err;
+	}
 	if (fch->ring) {
 		/* race, another thread created the ring in the meantime */
 		spin_unlock(&fch->lock);
-- 
2.52.0


