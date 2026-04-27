Return-Path: <stable+bounces-241368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAkkFJSL72nuCgEAu9opvQ
	(envelope-from <stable+bounces-241368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:15:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F45C476227
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A4EF3085CFA
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14B234D93B;
	Mon, 27 Apr 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fbNIrjaB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB5348860
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305503; cv=none; b=KLkk8VvkA/WyIB5oOV75VqE5dsxabQQsPebtsOTyUsRxey4t5Og7a0MyFcnCezTcG8ZLPYZM/IBJjQwZJWNzbgX1Os5Wmhz0fwXTbs8XF9RtzLIQ7iUBLo3PjtybGR9EuNI3Ksa5bGOC53sYnaTP2cQKVaS0bhDDmlOiNkGmfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305503; c=relaxed/simple;
	bh=pCv+FMmg4bDM0R8r1ysnaVHdTxdZ42LE4SRbeeP6ITQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJ6SAH3a0HSyxzEKdMqa7ADMCrO5XeDw5VY+nXWKo0iDmfBIgvNmTTnj0GFRpjBP8UJHj19LA69h9f1cYXn+TGbyTa0mIkrOvAw/ppOnvS2UUUSAes9mp0Qp7QFWjTSmcWqMPyY7Hf7vvbm4O3yLKZWaNrXIzDfdUrGB8PwD9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fbNIrjaB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso111353495e9.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777305500; x=1777910300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtFAIK+j/XCoVY73JQb1aVbAbSFTEbUxClYYOwgSKnk=;
        b=fbNIrjaB4jrHKlgbHOe70KwF5nrIrFX7CNKpuEmympdHMrtAffOcGDj0hc29kpbCtI
         BofB6mkX2ERMJc27HO/ELDJzmCot0SxBhbXdsYKhlVFeq+0ZBT8kIQZWCVBlIkFE/AQI
         3ElTEcCMBpgcLC3QcjlsPCCNKUvLMKiy19v75cFBNPym4brcckjW7pC0jfbXDTJcBCXf
         h1BuBC5XWjpduH1W3+h7luVpCo3EHDhQ8uJEANdKiQRGyTYOFKy/h5HvebOMIwDVWVKD
         xzwE5BC5gpg30y1A0UTDbFcBPkbFLamPEe/zzJ09hdWa38V4X2zUQVubE6G9e1fM/4oO
         fJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777305500; x=1777910300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtFAIK+j/XCoVY73JQb1aVbAbSFTEbUxClYYOwgSKnk=;
        b=PW8J262haDn8/MXD00gcTDjgC1N5ETG7FqUnJ2duB3Klt2TBnwnPHDjDkoFqxelNlf
         Lmowq2mfp/a7n0cEA5hMAjoBlO1SXQB4Le1YUhaHd7rOnP45OHpJcRRDu5TtpdXZMKy6
         0bljwOKhZtDvuRmwzHstwIj7Dme9HwZS/TG2YWMoN2dpLQehXEVw1uzbc3gXq3a+z6Fm
         tCUbbla5pueHGvNdjCAIHA+nEXAFW4qA57qyp8oAnMMV/z2oZE9D6lv02wgBu5UIJQ3M
         qrGFULvetCzyg5s+8p7Rir7dYwM6h2IY9WIIWM0L4scUai3PcGNgD0Ec4jfVMPVhf8Lt
         11fA==
X-Forwarded-Encrypted: i=1; AFNElJ/TdQb5fLXGM0DMI5iwv5LOG/T22jTTvEt1FYqTUyK0UYjdx7l6PiOXZH57ZgOSQDB/6hPmpb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcTD4tDFEfGkibWuUmL4RaW5y7uOHBaT5HfrWY10jNaSglXw3x
	6Tdi5J4F9cSeE5lakTynmt49UNazaU3M3SCJhNTclsuU1xdM6m1K/hLmwFys+OUDVlU=
X-Gm-Gg: AeBDiet8FmxFG3ace5CiOyURDfpn6R6L+XvbHOSh5e0gGv+WnKovnxC7HPcHAUM4MDH
	qWmUT/Wzr+on70ugzqOFkAABNeOB/MMGbaJM1eg5l5zz/jpkoMyzvSvt4R2bxl3Z1Mz7WwR+T/M
	OkbljnKhqClQPqPjtLqlizVwjMokF4J36FeLXr5GsAfJYAkLJ3PtHC8nAQdemO+pUmYyJV9Jit9
	ZGAm34ZeKBRyLjDb61Htv5eo2I8ORJrcBRkJD3GLc/sZj1OCxyXKTWGch0wOiUcXEuApRlgoyVd
	+p9vOzr/hsOwIsShoOI0Xz82Q+pJzQCjVt90rNJ5lFNnCXr88Yt/5NW7uX3wfp7ebtNQ8hxs4o8
	8zcr9hXazrw5I+RKpPb6preuhS3d7UjULZJZxHXFYNSV+0lI2jezTWNq+2gviNaVPfDtXD8oPAn
	jcnALQQDbSwx6kUvEkJxSRkBisfyVqfZiSTuWd0XbFOLY1inibAfVyl4DUMVzTlYu49wYPK51ZH
	TeURTV7O2+CnG7kMwwh9MrLwqrAJPR1olETTw==
X-Received: by 2002:a05:600c:a30b:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-488fb750a2bmr438385685e9.10.1777305499942;
        Mon, 27 Apr 2026 08:58:19 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f029600023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:9600:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5c4b9e8dsm121183915e9.7.2026.04.27.08.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:58:19 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: fix hanging __ceph_get_caps() with stale `mds_wanted`
Date: Mon, 27 Apr 2026 17:58:13 +0200
Message-ID: <20260427155813.2561935-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F45C476227
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-241368-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[ionos.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.kellermann@ionos.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ionos.com:email,ionos.com:dkim,ionos.com:mid]

A reader can hang forever in __ceph_get_caps() when the client no
longer holds `FILE_RD`, but local cap state still says that the
capability is already wanted (via `mds_wanted`).

One way to trigger this is through MDS cap revocation.  If another
client performs a conflicting operation, the MDS can revoke `FILE_RD`
from the reader; the next read then has to reacquire `FILE_RD`.  If
the cap update that should request `FILE_RD` never reaches the MDS
after `cap->mds_wanted` was raised, the reader is left holding only
non-file caps while local `mds_wanted` still includes the file read
caps.

In that state, try_get_cap_refs() sees `need <= mds_wanted` and
returns 0, so __ceph_get_caps() just waits on `i_cap_wq`.  If the cap
update that was supposed to request `FILE_RD never reaches the MDS
after `cap->mds_wanted was` raised, no further request is sent and the
waiter can sleep indefinitely until unrelated cap traffic happens to
wake it up.

The ordering issue is that `cap->mds_wanted` is updated in
__prep_cap() before the `CEPH_MSG_CLIENT_CAPS message` is actually
queued for send.  That makes one field serve two different meanings at
once: what this client wants, and what the client believes the MDS
already knows it wants.

A proper fix would be to split those states and track whether a cap
update is actually in flight or has been observed by the MDS.
However, simply moving the `cap->mds_wanted assignment` later would
not be sufficient: queueing the message in the messenger does not
guarantee that the MDS processed that specific wanted set, and
reconnect or message loss can still invalidate that assumption.
Fixing that properly would require a larger rework of the cap state
machine.

To allow simpler backports to stable kernels, this patch implements a
simpler workaround:

- stop waiting forever in __ceph_get_caps(); after a bounded wait,
  fall back to the renew path

- make ceph_renew_caps() issue a synchronous `OPEN` request whenever
  the inode still does not actually hold the wanted caps, instead of
  only calling ceph_check_caps()

The extra issued-vs-wanted check in ceph_renew_caps() is necessary
because the previous test only checked whether the inode still had any
real caps at all.  That is not enough after revocation: the client can
still hold something like `pLs` and yet be missing `FILE_RD`
completely.  In that case, falling back to ceph_check_caps() is not
sufficient, because it still trusts `cap->mds_wanted` and may resend
nothing.  By requiring `(issued & wanted) == wanted` before taking the
asynchronous path, the code only uses ceph_check_caps() when the
`wanted caps` are already actually issued.  Otherwise, it sends the
synchronous `OPEN` renew.

This preserves the existing asynchronous fast path when the wanted
caps are already issued, avoids changing cap-state semantics, and
fixes the hang by guaranteeing that a stalled waiter eventually
retries through a path that does not rely on the stale `mds_wanted`
state.

Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c | 20 +++++++++++++++++---
 fs/ceph/file.c |  9 +++++----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d51454e995a8..dd11611f250b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3087,11 +3087,24 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 			flags |= NON_BLOCKING;
 			while (!(ret = try_get_cap_refs(inode, need, want,
 							endoff, flags, &_got))) {
+				static const unsigned long wait_timeout = 5 * HZ;
+
 				if (signal_pending(current)) {
 					ret = -ERESTARTSYS;
 					break;
 				}
-				wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
+
+				/*
+				 * If a cap update is lost after
+				 * mds_wanted was raised, waiting
+				 * forever will never make progress.
+				 * Retry the renew path periodically
+				 * so we can resend synchronously.
+				 */
+				if (!wait_woken(&wait, TASK_INTERRUPTIBLE, wait_timeout)) {
+					ret = -EUCLEAN;
+					break;
+				}
 			}
 
 			remove_wait_queue(&ci->i_cap_wq, &wait);
@@ -3125,8 +3138,9 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 				continue;
 			}
 			if (ret == -EUCLEAN) {
-				/* session was killed, try renew caps */
-				ret = ceph_renew_caps(inode, flags);
+				/* session was killed or a waited cap
+				 * request needs a retry */
+				ret = ceph_renew_caps(inode, flags & CEPH_FILE_MODE_MASK);
 				if (ret == 0)
 					continue;
 			}
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d54d71669176..47c7d4a5ffed 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -314,7 +314,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 }
 
 /*
- * try renew caps after session gets killed.
+ * Retry cap acquisition after a stale session or a lost cap update.
  */
 int ceph_renew_caps(struct inode *inode, int fmode)
 {
@@ -322,14 +322,15 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
-	int err, flags, wanted;
+	int err, flags, wanted, issued;
 
 	spin_lock(&ci->i_ceph_lock);
 	__ceph_touch_fmode(ci, mdsc, fmode);
 	wanted = __ceph_caps_file_wanted(ci);
+	issued = __ceph_caps_issued(ci, NULL);
 	if (__ceph_is_any_real_caps(ci) &&
-	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap)) {
-		int issued = __ceph_caps_issued(ci, NULL);
+	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap) &&
+	    (issued & wanted) == wanted) {
 		spin_unlock(&ci->i_ceph_lock);
 		doutc(cl, "%p %llx.%llx want %s issued %s updating mds_wanted\n",
 		      inode, ceph_vinop(inode), ceph_cap_string(wanted),
-- 
2.47.3


