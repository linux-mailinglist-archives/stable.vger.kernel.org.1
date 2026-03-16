Return-Path: <stable+bounces-225624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KzHBUU3uGkDagEAu9opvQ
	(envelope-from <stable+bounces-225624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:00:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE46829DC4C
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33BF53092476
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764A83CEBB4;
	Mon, 16 Mar 2026 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5FjR+i/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg0wkE3F"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952283CF025
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680009; cv=none; b=fFIdg/+UKrn+tT2P8yu59S739tOWOyBHoHpnXZohWVswAlQH/qPpMrbP1u/qea35kKZCZsJXGM9FzLVCyuKXiBLYL0DoGJwXuZIUuFS1varctCUq5Ez6jBEqT4hnCYnb2P9ruRyMgmsaaMv634zb3uAc0Z8Vpt5gvK6RuGw+XHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680009; c=relaxed/simple;
	bh=Gj9ReL21qkCIwwx5AuSkqh932hkHpOSUWcCxA7paFuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8a/oHFwIP9vPy0ERxOKH4eQAXvEn4/dY0hyVv94UkGvQq7A1GyqTkLK2Zd2ThVJiCeko/gm66Ayen0TAKbSSUSK02lxFsDYVZ9a6wCCEnZfXNrceLU29oPlG7qpzned2xzqACah4due6KIuW6op+9i9vbwYBHqeRVcPK+Hg6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5FjR+i/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sg0wkE3F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773680006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwybaCr/UoGq6Cq8k7p5oy22lmCgSShsaMlgHq7FEH0=;
	b=a5FjR+i/viZS+TzSwzhRTAxRUL7KpXlQqAqGQSqnko2mhLZUvcHoMUG8mf+a5R/9+jMK+8
	dhBUjAGjaaEJuD+lZK14RBLpwKUH9NIq3/Z0TzuqpfmbwdjxtkoYTv+J6Q3CXyEwDMGNhl
	p7muL9YiJeG3Bp1Z+lZ4q2RLj0CzZeM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-67SrBBn4OzCgzfZoqmIMPA-1; Mon, 16 Mar 2026 12:53:25 -0400
X-MC-Unique: 67SrBBn4OzCgzfZoqmIMPA-1
X-Mimecast-MFC-AGG-ID: 67SrBBn4OzCgzfZoqmIMPA_1773680004
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48532df52c5so68501725e9.1
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773680004; x=1774284804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwybaCr/UoGq6Cq8k7p5oy22lmCgSShsaMlgHq7FEH0=;
        b=Sg0wkE3FUMZ0gBrbxNxikITudfS6EiEsov0+TQmrNj6wMOrb6qjYotTCpoXEdHhmGD
         gQhMvDeEh4Q+T1B8AXvsDPD5pk1bgnockbjDIDGhSV4rV9hmIFBDwt2zqp5cFq9dupOm
         4D3cnKCuiVaUe2gjznPbahhbb1GSw3DalSuz/RY8e2rksEwyCPdM9jLr0Mv71gTOdkjt
         fxUem/8mFPD/J5mT3YhQyxJFY31cmp62NUMg70q1biWulZv28oEO4F2o/5hDib9Qh3YW
         Gvl0sMV7BCgmFdrgYx51s2l6rvh2v66bkxwantz96Vum37kdNDAvCCA2Z6ebfR4n+Izn
         ZKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680004; x=1774284804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwybaCr/UoGq6Cq8k7p5oy22lmCgSShsaMlgHq7FEH0=;
        b=br+u53zSbDG9311fh86HvmcYNgN7yaoWFLuiFxy+LbO0cpMSywLetxL/Nv+AxTZiRZ
         GwPmFtH85FXIgvburekLBpiAdZcQnTR/lCKr0btybWZsx8Tzudw1m5SOWqwEOPyPoobd
         CnJeHk0fGVji359kNQXW4COLN4VqdNeUeN2QLZK+b7vuZDwg+QFtfNVixaa7N99wJex5
         7dXEsGkzHVL9fQaRfdZkaRsE6dv4KtGgBqJ85TexZzwyfFwDXVakJ3cxF526FW+87h5G
         x6kQGmF5Gx/giSULeHhechCMbwUwLrqO4fCqTw/dQWiJwa763yvLSx2Je6TuwBD+NtY5
         gPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwoQRHqVmEdnqe+5K87fDm/VrwQF52qPV+5xVdvQ7II4G4f5DcSLhW5J5o6w9wgTdVOJXzp1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOJHknVoBbpyV6SUkIdlJ17M5VSRx8E/MI9mqabDyxqP+uDdI
	5Oi6LFUYxwhzdIQKwpJj7Vp5ADdLIy/QfpJeOe1oGcM8PA1RBzmtG9BaSqfXp0gKvyH4NVvypef
	OmYV7c7BP+1ureT+3AGFKpVGCWeEuMyOIlu5nQYsZnuNSpzWcwlccDHf5cw==
X-Gm-Gg: ATEYQzyX+Sm8uNSvT+Jk5y4Y9H/c8eGriwB06nG1EiweIeu4HCAeRRxGfb/5iPG4k1K
	hqozTpW/Ts5Ir+xggkMk3eWPQ8UQafKXH7fQ03S6VMVp6nY8PSznanA/sEZQK1FQZLVQw5JgUaJ
	LNxQWD4zefbAqnG5WUMY5XXqFR2LdlV6yRDgSeRNykmTxJBuJFuM/FBchJO5NxFQY1YfDQSiQOn
	+YyZ0eWJyrcmkXsKhBHbcBcahKrQsmW6+536h0raBoj3Qi5Yi54M6cxnnwRvE1gV2WKHiTy6jCB
	KMAYfjFOvWNDGG9FL5lep3XNxq00FHA5382TMIgMz/m3P4EmrI9AlyuhFq+yAJsSSTKVTkT08SI
	Nay+g/rnw0oyOqV1KZpKeBSLSSEcPxh+BRMifylOHIyZ2qffN2mfCd5yDkV/5IczgIy3OV6cFng
	==
X-Received: by 2002:a05:600d:8486:20b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-485567149fbmr167661555e9.31.1773680003817;
        Mon, 16 Mar 2026 09:53:23 -0700 (PDT)
X-Received: by 2002:a05:600d:8486:20b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-485567149fbmr167661205e9.31.1773680003366;
        Mon, 16 Mar 2026 09:53:23 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-172-54.pool.digikabel.hu. [85.67.172.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9c340sm4978295e9.7.2026.03.16.09.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:53:22 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/7] fuse: abort on fatal signal during sync init
Date: Mon, 16 Mar 2026 17:53:12 +0100
Message-ID: <20260316165320.3245526-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316165320.3245526-1-mszeredi@redhat.com>
References: <20260316165320.3245526-1-mszeredi@redhat.com>
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
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225624-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mszeredi@redhat.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE46829DC4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When sync init is used and the server exits for some reason (error, crash)
while processing FUSE_INIT, the filesystem creation will hang.  The reason
is that while all other threads will exit, the mounting thread (or process)
will keep the device fd open, which will prevent an abort from happening.

This is a regression from the async mount case, where the mount was done
first, and the FUSE_INIT processing afterwards, in which case there's no
such recursive syscall keeping the fd open.

Fixes: dfb84c330794 ("fuse: allow synchronous FUSE_INIT")
Cc: stable@vger.kernel.org # v6.18
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c    | 6 +++++-
 fs/fuse/fuse_i.h | 1 +
 fs/fuse/inode.c  | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 2c16b94357d5..f0631c48abef 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -576,6 +576,9 @@ static void request_wait_answer(struct fuse_req *req)
 			removed = fuse_remove_pending_req(req, &fiq->lock);
 		if (removed)
 			return;
+
+		if (req->args->abort_on_kill)
+			fuse_abort_conn(fc);
 	}
 
 	/*
@@ -676,7 +679,8 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 			fuse_force_creds(req);
 
 		__set_bit(FR_WAITING, &req->flags);
-		__set_bit(FR_FORCE, &req->flags);
+		if (!args->abort_on_kill)
+			__set_bit(FR_FORCE, &req->flags);
 	} else {
 		WARN_ON(args->nocreds);
 		req = fuse_get_req(idmap, fm, false);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..23a241f18623 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -345,6 +345,7 @@ struct fuse_args {
 	bool is_ext:1;
 	bool is_pinned:1;
 	bool invalidate_vmap:1;
+	bool abort_on_kill:1;
 	struct fuse_in_arg in_args[4];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e57b8af06be9..84f78fb89d35 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1551,6 +1551,7 @@ int fuse_send_init(struct fuse_mount *fm)
 	int err;
 
 	if (fm->fc->sync_init) {
+		ia->args.abort_on_kill = true;
 		err = fuse_simple_request(fm, &ia->args);
 		/* Ignore size of init reply */
 		if (err > 0)
-- 
2.53.0


