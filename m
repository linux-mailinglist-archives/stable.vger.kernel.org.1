Return-Path: <stable+bounces-230686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FaxN9izxmmiNgUAu9opvQ
	(envelope-from <stable+bounces-230686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:44:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF386347A41
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CA0D309F38C
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB62B3C73F6;
	Fri, 27 Mar 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dFlUZDKm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816A30CD82
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628609; cv=none; b=ir674hHzCefAnQNJKYdmCSmmwkeMurqqwf1sMGqbr6J3PYmbUfc8HlEVl/LiBASnC9YqPOZf9CKj0CIWZeoLZZNq5OoIHWmQ4kts/IuHh+u4V3j7IshH0Ib0gqxBdWWmX2S7elyyooL3gHD552ajHyJT9cUw5v6z1kg9iXRlSZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628609; c=relaxed/simple;
	bh=kM6h7buYmvPWe3WeN4m+xIms9TRX4kj6vu1ECi4LQ8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIBWukQa6XkoyqQeCKuB5OwAMQW+PkbIPvbuiqP7tnawZjG4WfkTTZJ7cTRVouYH6xHTqKD7WExgWxMg4tZfwfJG+X1gifIKUEg3OyPt/lm4ROzlsGR/doIuKv6ct9tzllJtn14SW5PnXksK8QBBMhhxy8sSrE+lsKughyi33ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dFlUZDKm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso17866445e9.2
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1774628606; x=1775233406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Li+MhdhKR/VteHKksntf5bm/t2yJMb4kcBZQfykWGTU=;
        b=dFlUZDKmBRY1fmnnK16YeViu7Zb+gj1Z2dR46ickp8ZY5iSqmX3bwV8lQYjpS9VOgR
         sfUPMUTTholfEsJ7EBlVJxmlNFt3uATsJ5eBKD3/zXbnOpieY7oHjLooLdeaOK7Yc6P7
         XvyR9Feg79e3c8dKcv9oVTwms8bUmOnMtThKvqHK0K9pf7Y+jU6nqCbt0Ut4Sy0yyOX8
         bXDl6cvtKtJWxgrgTuqF2UbSYvem+jVADrqOLVQLipJX49kdXART1WIfJMiUeSnpvz9T
         UZ4p7Xu1AUimd+GlMElEBn0NWHMv8UkSimpyCL+7gU9+C/gqRUKxYUEbd7Dh4Vt4AftS
         VOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774628606; x=1775233406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li+MhdhKR/VteHKksntf5bm/t2yJMb4kcBZQfykWGTU=;
        b=PxK7L60CGZF9dukkYOvGnjjT2XLkUQY2Vp8pyPD+yNS2pNtsAYeC48Fu6Gq6maqPQ5
         LWzRwYhCX7yS/8bDHkZDGNTbRGmRDUPplAxOKQ88NC/DU9fWc3EPRabuenydBElxwO9e
         Zb8tEPeEc1nFQVuuAxo3FrOem/Zajcb+Pe9SCwXoqczgFptE/HeG5hZP0sO77R52KAjw
         rcmfaGWwxLzyY6Jr82vDdkUtxuKjw5RWutwfxL5Y97DwI6rod0Yi321444zH7qc3qziO
         jsbPWYuboU+sSEM0vpYqyDJmtlF3gaBV4+HExlgJ6HFuNEeiAyfxy5Av4BZiwk1rHUYs
         NqDw==
X-Forwarded-Encrypted: i=1; AJvYcCWKdCRAYehvWUjxs+JPccT/Erezf4q4dmluURKMO82HwklzIW4pUw6P2RVv+gbBOLm8hyXfgh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3UpBW8u1XFUkdbGLTcFryVBmpxWdXFi0Ct8eL6KBDsBC2fPra
	LUdz5aAPPbCq6bvzAEP194yLCAYUlWmbOIgExX/BuBlDdC2+/Km/OeNrJFt/MZeBd3k=
X-Gm-Gg: ATEYQzw0W0yP9mUn7gh9vIho/Br/mWEt1ED22Fr4OCh5OSVnGl9CHUOAdz/ZbyiCrdH
	ouh/zVKF/felguAD2Fe12Vf39EQhMd+QBeIuW/TCYCAhaTTr2v/9tmmGULCjsJT26zm5kgkv8xz
	MxBbhljobfZIiqCpIs/kC1LkszsdVfIkdX4ClztAy3h0iWbVSmpLwL5OzujdEzN0SF5i9qM4OEG
	ftiwaSaMYrXCAFkp0QilDHsccIML2Q+QKskBoj2SgWsnwoz1066RI1W7wgUUpX+dkAIIhEkiVUy
	MhNtKoZEaN4vTknKymaAyTSauFT1sEZ3TY8z1Ua4AkboStQHetT5lhXgM9MNFeUkguBmQOmOwiR
	ljvwLDeTwlLNSVibzgrQrViexdDQbpVaqWKBQhFUTPmblFHW1G/qcn+MsdRyw9lpVpYm+7gpN/a
	tkIQok/4WbPv+XnNZtc7s2o18eozRCbSFnMwBAuCNU/uSmECBLU9RZkP1gxq3nF81eqkew1uA4r
	BKQuJGzcFjeki7C7YHUBIpNgpI=
X-Received: by 2002:a05:600c:a108:b0:485:4388:348b with SMTP id 5b1f17b1804b1-48727c81d77mr45901305e9.0.1774628605920;
        Fri, 27 Mar 2026 09:23:25 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f2b4400023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2b:4400:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c7cec3sm97085725e9.6.2026.03.27.09.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:23:25 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: only d_add() negative dentries when they are unhashed
Date: Fri, 27 Mar 2026 17:23:08 +0100
Message-ID: <20260327162308.1118621-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230686-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ionos.com:dkim,ionos.com:email,ionos.com:mid]
X-Rspamd-Queue-Id: DF386347A41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ceph can call d_add(dentry, NULL) on a negative dentry that is already
present in the primary dcache hash.

In the current VFS that is not safe.  d_add() goes through __d_add()
to __d_rehash(), which unconditionally reinserts dentry->d_hash into
the hlist_bl bucket.  If the dentry is already hashed, reinserting the
same node can corrupt the bucket, including creating a self-loop.
Once that happens, __d_lookup() can spin forever in the hlist_bl walk,
typically looping only on the d_name.hash mismatch check and
eventually triggering RCU stall reports like this one:

 rcu: INFO: rcu_sched self-detected stall on CPU
 rcu:         87-....: (2100 ticks this GP) idle=3a4c/1/0x4000000000000000 softirq=25003319/25003319 fqs=829
 rcu:         (t=2101 jiffies g=79058445 q=698988 ncpus=192)
 CPU: 87 UID: 2952868916 PID: 3933303 Comm: php-cgi8.3 Not tainted 6.18.17-i1-amd #950 NONE
 Hardware name: Dell Inc. PowerEdge R7615/0G9DHV, BIOS 1.6.6 09/22/2023
 RIP: 0010:__d_lookup+0x46/0xb0
 Code: c1 e8 07 48 8d 04 c2 48 8b 00 49 89 fc 49 89 f5 48 89 c3 48 83 e3 fe 48 83 f8 01 77 0f eb 2d 0f 1f 44 00 00 48 8b 1b 48 85 db <74> 20 39 6b 18 75 f3 48 8d 7b 78 e8 ba 85 d0 00 4c 39 63 10 74 1f
 RSP: 0018:ff745a70c8253898 EFLAGS: 00000282
 RAX: ff26e470054cb208 RBX: ff26e470054cb208 RCX: 000000006e958966
 RDX: ff26e48267340000 RSI: ff745a70c82539b0 RDI: ff26e458f74655c0
 RBP: 000000006e958966 R08: 0000000000000180 R09: 9cd08d909b919a89
 R10: ff26e458f74655c0 R11: 0000000000000000 R12: ff26e458f74655c0
 R13: ff745a70c82539b0 R14: d0d0d0d0d0d0d0d0 R15: 2f2f2f2f2f2f2f2f
 FS:  00007f5770896980(0000) GS:ff26e482c5d88000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f5764de50c0 CR3: 000000a72abb5001 CR4: 0000000000771ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  lookup_fast+0x9f/0x100
  walk_component+0x1f/0x150
  link_path_walk+0x20e/0x3d0
  path_lookupat+0x68/0x180
  filename_lookup+0xdc/0x1e0
  vfs_statx+0x6c/0x140
  vfs_fstatat+0x67/0xa0
  __do_sys_newfstatat+0x24/0x60
  do_syscall_64+0x6a/0x230
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

This is reachable with reused cached negative dentries.  A Ceph lookup
or atomic_open can be handed a negative dentry that is already hashed,
and fs/ceph/dir.c then hits one of two paths that incorrectly assume
"negative" also means "unhashed":

  - ceph_finish_lookup():
      MDS reply is -ENOENT with no trace
      -> d_add(dentry, NULL)

  - ceph_lookup():
      local ENOENT fast path for a complete directory with shared caps
      -> d_add(dentry, NULL)

Both paths can therefore re-add an already-hashed negative dentry.

Ceph already uses the correct pattern elsewhere: ceph_fill_trace() only
calls d_add(dn, NULL) for a negative null-dentry reply when d_unhashed(dn)
is true.

Fix both fs/ceph/dir.c sites the same way: only call d_add() for a
negative dentry when it is actually unhashed.  If the negative dentry
is already hashed, leave it in place and reuse it as-is.

This preserves the existing behavior for unhashed dentries while
avoiding d_hash list corruption for reused hashed negatives.

Fixes: 2817b000b02c ("ceph: directory operations")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/dir.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index bac9cfb6b982..27ce9e55e947 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -769,7 +769,8 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 				d_drop(dentry);
 				err = -ENOENT;
 			} else {
-				d_add(dentry, NULL);
+				if (d_unhashed(dentry))
+					d_add(dentry, NULL);
 			}
 		}
 	}
@@ -840,7 +841,8 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 			spin_unlock(&ci->i_ceph_lock);
 			doutc(cl, " dir %llx.%llx complete, -ENOENT\n",
 			      ceph_vinop(dir));
-			d_add(dentry, NULL);
+			if (d_unhashed(dentry))
+				d_add(dentry, NULL);
 			di->lease_shared_gen = atomic_read(&ci->i_shared_gen);
 			return NULL;
 		}
-- 
2.47.3


