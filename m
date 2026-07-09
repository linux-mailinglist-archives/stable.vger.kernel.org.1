Return-Path: <stable+bounces-273049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EqIPIvEOUGresgIAu9opvQ
	(envelope-from <stable+bounces-273049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 23:13:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB9735C62
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 23:13:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=JbY5bMRB;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273049-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273049-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1340301907A
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 21:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1DB3AEB2C;
	Thu,  9 Jul 2026 21:11:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58333ACEE2
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 21:11:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631501; cv=none; b=URnmcWmD1aLc/iMWdZV6RFmI2+xKDfjhKPoK7Bcr+nAiay7pRyF5YchiD99tj5cyijJSp4CjruuRfbClOqVAb/lyn4cEbgyMoLcuiYcZgJGb74jsBDoA3RnDvxicJ6LCSNVtgqGyVPCm97SHeLtEBjvXSOkB7BZLGF8vkRZqPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631501; c=relaxed/simple;
	bh=7wR85BSlK6g7rPPLZUmhmMR7qWMPn8HJ/Ov54TKx1o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auZjg1Ka6PynClAxV4vb5Pv7I/8D2lwhBjjtmWFoT+nxPIl91lOAN0wrFxJ5rR0w/JoCkyTMVrtRJrKAybn6FaLVkG6iQWhcR3z1GaJOt7yRBRq6E6qOvQv3ppbBEoKKGcIf9fD3AGI5qBTX13kJ7NgpELr2MxSW+lGpUiLvwBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=JbY5bMRB; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc73e322dbso2232005ad.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 14:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783631498; x=1784236298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XuEkKfOMhfrm+8X9CsfK3WSrB0bxoAf1wJ4HbTJkHGI=;
        b=JbY5bMRBgpKcVY1ZhIt/nTPR2Z3ACmt45JPnkcEu8cAGIXImAYoR4TXywhiuGXXQys
         RKYPjwUFapyErCnTIlLYDj9bFBK7SoOowuH6fIG9iM46aO1ax6NYOH0jlf6TcFg5/T+Z
         piYaHnJ14mSXWhkHaVfSSZoUpi8q4SgWucaaoFPoweF8Nzi/sF3lPq1j+J8sqzaFbVOs
         bOVugGC8DZFf9mrh5wZCqXWc9Uqwr0k/DPinzr+vanCCW0fdRM6q4ljJYBb/BB+C9WRa
         Q3KFQy9+zRGMkC+2oo9wfg1HvwNgciVTifVi+HP3stiZDUwS6AC4oZiXLBKEro+X1mYX
         FBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783631498; x=1784236298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XuEkKfOMhfrm+8X9CsfK3WSrB0bxoAf1wJ4HbTJkHGI=;
        b=ZKnnzAdOfg/VaBVJ8ixKlw/EzIG7ituEo+Qh7IfkC+XTLMC/dFEL51XBSLV3gIsSL7
         441IU/4vS3z7veNPHTrZS6eDbv4ZFKboMBEehOgWl3j0K6jLvXQDUrWjT3zCEwFAPam6
         PgFXCiYylVdFgXkzHuoccXHfp415Pm4L5Cg/20zT10jPnBXukUoiEPY1xdkF4O1X24qy
         3qp3T9584Pmx6bVxM79KzMegFKonMf0IP9/2pF0QmqTcwUqP29EmroAUh2IpicymNdwc
         WWWBqjyqaSzUIjI3rTzGw8otxHD1ilhbnnjPlnIIdgn/H79jbncGN2u/wtLz1ulc+EXj
         qCgw==
X-Forwarded-Encrypted: i=1; AHgh+RrUqI59GHW9gIJkapIumbv/cHPcDLnH+xayNf1VG0GcXdI0FC5e8PnEWslYPwNiBgzBGNYimi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv0Soaw2KzEudweF2CUCreKhgDZ40GkubJ7jb08NevWPleNRNa
	isVp/2ThH53BIce1EB5GPecLHf1XEqsW1uHR44Kv3bvCSAvH/zEFZi5T6loUBYu1fA==
X-Gm-Gg: AfdE7clAFNtlen8hzatHfjFDCnyl9c8N1b3F/+6eWnCLePpsJr1QrlcoOBoIOoJTyQ+
	xqNHwtwUKCXqwFG63vk5oEn7sXkndGwiXjoG/aIN5tct5d9thYhQza7dPYdaRGNz54Sb37OO+vM
	8Yr3hJM8qM6NkSL3eclJByMcC+iP8G02NSjsiU0qkdrE5XhYmK1Fq2wqX5/2nlLyMrjFsF98ScP
	tFTI2UCMhd/pbUzS+LFXvygHsyO7wnA/m80EPf9fN72g+q+RbgSZWvKm64nlCoxwUp7r4Q87cvi
	aiV1Z55diavRsWxcmmtM7I/FVIttfZZtMDoAwGk+XHR1KMAZpk+uwBwOP/W/ksEz1eg97XBQZkW
	tjM+h1UiqRwFobX6tu2wGKgCmW3xD6nW0rUKpXWyG/8zVBZj8oyINXy+jfPA9yAmZiq/C6ifb
X-Received: by 2002:a17:903:4b0d:b0:2cc:ffa6:462a with SMTP id d9443c01a7336-2ccffa65d47mr55654255ad.10.1783631497770;
        Thu, 09 Jul 2026 14:11:37 -0700 (PDT)
Received: from p1.. ([2607:fb91:150f:dd4:6d78:821f:ff11:b509])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm49742475ad.78.2026.07.09.14.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:11:36 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: fuse-devel@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luis Henriques <luis@igalia.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v3 1/2] fuse: copy request headers via a stack buffer for io-uring
Date: Thu,  9 Jul 2026 14:11:29 -0700
Message-ID: <20260709211130.543773-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273049-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,bsbernd.com,szeredi.hu,kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,igalia.com,gmail.com,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joannelkoong@gmail.com,m:bernd@bsbernd.com,m:miklos@szeredi.hu,m:kees@kernel.org,m:gustavoars@kernel.org,m:fuse-devel@lists.linux.dev,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:luis@igalia.com,m:asml.silence@gmail.com,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23CB9735C62

The fuse-io-uring transport copies req->in.h out to the ring in
fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
Both headers live inside the fuse_request slab object, whose cache
(fuse_req_cachep) is created without a usercopy whitelist, so copying
them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
panics:

  usercopy: Kernel memory exposure attempt detected from SLUB object
  'fuse_request' (offset 56, size 40)!
  kernel BUG at mm/usercopy.c:102!
  RIP: 0010:usercopy_abort+0x6c/0x80
  Call Trace:
   __check_heap_object
   __check_object_size
   copy_header_to_ring          fs/fuse/dev_uring.c:618
   fuse_uring_prepare_send
   fuse_uring_send_in_task
   ...
   __do_sys_io_uring_enter
   entry_SYSCALL_64_after_hwframe

Bounce both headers through an on-stack copy so the usercopy touches
stack memory, not the slab object.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
v3: no context change; add Bernd's Reviewed-by

 fs/fuse/dev_uring.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 77c8cec43d9c..0814681eb04b 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -744,6 +744,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
+	struct fuse_in_header in_header;
 	int err;
 
 	err = -EIO;
@@ -765,8 +766,9 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
-				   sizeof(req->in.h));
+	in_header = req->in.h;
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &in_header,
+				   sizeof(in_header));
 }
 
 static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
@@ -871,11 +873,13 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 			      unsigned int issue_flags)
 {
 	struct fuse_ring *ring = ent->queue->ring;
+	struct fuse_out_header out_header;
 	ssize_t err = -EFAULT;
 
-	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
-				  sizeof(req->out.h)))
+	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &out_header,
+				  sizeof(out_header)))
 		goto out;
+	req->out.h = out_header;
 
 	err = fuse_uring_out_header_has_err(&req->out.h, req);
 	if (err) {
-- 
2.43.0


