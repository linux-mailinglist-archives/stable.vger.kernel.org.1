Return-Path: <stable+bounces-249212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OJlMk/ECmoI7gQAu9opvQ
	(envelope-from <stable+bounces-249212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:48:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0D5568174
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1095B30063B4
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC263DE420;
	Mon, 18 May 2026 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIdOD8Se"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C093C13F8
	for <stable@vger.kernel.org>; Mon, 18 May 2026 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090183; cv=none; b=iY3/qiHZatyZL/IOOWIFhBiGSlsDwrG/y0c7egBWS9gTtYNlb4Q2cK+2wTeRbjKhnsFSff/LFn2KMkO/6teO1K+nTYRUAQkxhgAMTdluUqcM2utoxXGJm5THhk+anz/vyPQ3evgSSy4B8CArva5n6VcbaiMJZ7fvFmFy+Zq1xPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090183; c=relaxed/simple;
	bh=eSueVGjl9kpfrC/9O9pfTUZGg3av7Bo0jfk9t85JoS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uEQf5QiGOMqIt0HCnnXydF+oEw5mTwiPqWRSmbaJYJp/ewctajKzoLx5SQhLvbfzEvQbzALYkIjaDzGsjSyFZX5dwtgREhgFmT4Z+BHYoc3eKPy+ow/6+IX7Ex5OcKvgWvrDDKlKVf5LMB3+U/L2cKC1f4cUwVXNbY88OGiq9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIdOD8Se; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36810434abaso173671a91.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779090182; x=1779694982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8yME935TMtR1RQ2fzR/XnTzQNsnJA37aJzNpTqM9xk=;
        b=pIdOD8SeVbL7F/gl0FTHJs5dVrgwzJK2nMb96IgsgXYxy+BonXYiRNcJPV5MuiEhYF
         REIlnS150rd2ZuRcRh8belDH5Fh0z+XCOGdKzLCkQjS28MCOaS54DRYEC3B/6CnnaOvI
         2GACY3w+88Z2c+hHlhklHrOMf++a0jEXBJKy5OVcd6iNplokTX/nDHfs+nTEV/KydS4I
         uXvQc4grdSZ6e6JtMEPzAp3miQaQjfdfxZJLwwQj0FZGwjqGo0bX2iFLTmmbtL+30TO3
         oN4TPZ8+Zd0NTENU7WLVu7HEXvzdwC9JaGNBEEtQ1Wi6Z87PLvwSggoQY5XQr2W025Eu
         rW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090182; x=1779694982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8yME935TMtR1RQ2fzR/XnTzQNsnJA37aJzNpTqM9xk=;
        b=DLGNoNgZ3OtrXQaDJZv8DV9YPOsFx6dW5ZUcL1pLDV4wDGh+G0K5b7vXGDb+mhXiHb
         gp6YQnIYbxp7gwEUDRMD9i1F+M3HlAGxvH397LZcqsL082rXqyfbFO+zmlucJRowuT47
         KoLvfsgGWS2XTKIwQdBc/kxndkYuN0Wvgbt+juPrmUrOE4IYVnV+jKvtjnNo4PlU+Nne
         T0Dmp7pIHH28BbYkSbVtUKgwm+cVg8pyYCG3uO3Jgd4a+Tyk1P83LThGFwrSmWbTemJ4
         Vy0As5eKr5wxzsJYG3IaHcdM3LGF6bSCw7XmADSmIToI0aWyvgG+YCVw77SxQhk3sQwk
         gu2A==
X-Forwarded-Encrypted: i=1; AFNElJ/TinDCFzQhH6AIIfOHeOuZflGlqlGByafUpxejUlDvQGS6DSdJN2oK08mm/0DQ3+RxZfYwvK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJKZT32TlH3PqTHkxwVnUPrmVgFD9eBX4mFTA9KiQ/22WfJHKY
	AQHX5H/jqdWymGfhhvqbPG/RfZOWU+WRbPZCmRmLPow5wRDHnDT+fY+N
X-Gm-Gg: Acq92OEE4TCEjHRkd6MXW+1Ycn3q7Vm24I+nd2dHnA0zFYOuQm8F1vR6AINjKIPeFUC
	3qIz05gtdNXO9HDljNRk8YNRBAgLK+sfKHQ33mrK2bUoCtVrv/hIf7np9cj/py/Y51Zppwe3red
	ao/7QlFgiebvgsNBSGU2ISmZJnJUV/0/6RZVoYAmlLWOWrOJk/WidXQQnZD+rcq6QmFAibHuM9j
	4a4Aq+qd8BU1ErJx+6LUp8NUs5lgBn4rDoymemZ+XDIJafQ+DiB7Enka2NzkYbUVadeL48t2j6A
	xGb9BG4OkYt2Ih78yj13/5S8D2obtYKHy90dRrHvcdy4ctV87HY00kI9Pk1czF/s4//hKyCEt7x
	u90LW7jtQnMyrmod6kgXwBu53ajsn7gSQcZsO0rTjGR5a6qYw6hXiXxx63kGt80lKc+Vftqk1Ag
	bky1/SPPmgD6NSG0H5murP+/MzCTSpGynJOsdnPkbY5Ushm1R4B+kSRfCUqxQrWgHmZqYFFmnDo
	MsQIfTpLResX+hxNmZJqlohqws/NJgnLA==
X-Received: by 2002:a17:90b:4d0d:b0:368:44d:bbac with SMTP id 98e67ed59e1d1-36951ca93d8mr7586429a91.6.1779090181689;
        Mon, 18 May 2026 00:43:01 -0700 (PDT)
Received: from localhost ([240d:f:a5c:fb00:b9d0:5976:9793:153b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517a8612sm10167726a91.12.2026.05.18.00.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:43:01 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH] block: fix dio leak on integrity metadata mapping failure
Date: Mon, 18 May 2026 16:42:58 +0900
Message-ID: <20260518074258.1600307-1-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2B0D5568174
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.dk,samsung.com,lst.de,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249212-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In __blkdev_direct_IO(), when bio_integrity_map_iter() fails on a bio
after earlier bios have already been submitted, the goto fail path frees
only the current bio and returns the error directly to the caller.

This is incorrect because the fail label does not decrement dio->ref for
the current bio, and does not return -EIOCBQUEUED. The in-flight bios
each hold a reference via dio->ref, which was incremented before their
submission. When they eventually complete, blkdev_bio_end_io() decrements
dio->ref but it will never reach zero since the failing bio did not
participate in the completion mechanism. This permanently leaks the
embedded dio/bio structure from blkdev_dio_pool.

The trigger is deterministic: a multi-segment direct IO with integrity
metadata where the user-provided metadata buffer is too small for all
segments causes bio_integrity_map_iter() to return -EINVAL on a later
bio after earlier bios are already in flight.

Fix this by handling the integrity mapping failure the same way
blkdev_iov_iter_get_pages() failure is handled: set bi_status and call
bio_endio() to enter the normal completion path, then break out of the
loop so the function returns -EIOCBQUEUED for async IO.

Fixes: 3d8b5a22d404 ("block: add support to pass user meta buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---
 block/fops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index bb6642b459..39280d761c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -239,8 +239,11 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		}
 		if (iocb->ki_flags & IOCB_HAS_METADATA) {
 			ret = bio_integrity_map_iter(bio, iocb->private);
-			if (unlikely(ret))
-				goto fail;
+			if (unlikely(ret)) {
+				bio->bi_status = BLK_STS_IOERR;
+				bio_endio(bio);
+				break;
+			}
 		}
 
 		if (is_read) {
-- 
2.54.0


