Return-Path: <stable+bounces-217914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHpPFJajnWlrQwQAu9opvQ
	(envelope-from <stable+bounces-217914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 14:11:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B20E11876BD
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 14:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C5D5317366B
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE40539B49F;
	Tue, 24 Feb 2026 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="afpQawon"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AEA39B49C
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938645; cv=none; b=MHhIwD1k3e/hyL5Oc4kDoZE9QTpekY9CjNi3uad70mJsARNrY+LFcADBQG8zeXC43Q4ar4Qq7kNUAcgQ+YJFpb5x16UU9yuJ2lzZgeSbiqrf6HF9beJc+O43SmzXwr7U2uS6ScIPDzvdQ96UB5gTOn6REGGjjwmHG616aZrax80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938645; c=relaxed/simple;
	bh=7KbyPvsnIyffv8erfPVQaDbjs1ksW8LpD5GRCqCoQwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNkcocRsZ4B3gSQQUpQNRXw2Kz5g3OJcJrQ8U79aQQKrhUf/Uql9dSHwifi8xj1PjwGv20Slm1k/dgjGg5/9eec1W8xlDojY//jEsjYpJVy8L3k84a5epusZfZ4LQCHlv8PDSK1iUhfWGCBUXLCju3Wcpv9kK3UOBMon0A577sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=afpQawon; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43770c94dfaso5419388f8f.2
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 05:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771938641; x=1772543441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf+c8hVZNgFP3BiEHZouqSwT6ALbJDbEZGSHCOTFUzI=;
        b=afpQawonFPFfdrC2ZaMhISCOvJaCLQdrJSJ4W34ASxvmjG7+H4FEoaB/PB90U0aejH
         o/BUmZVGEWki9d2v/O25FpHeprAWRNOAK3Z7OINjY0TPbt4XG6g/8OhynolgL+N14Sem
         o5QkHt3GHujFJhNwfTCNAjB4I3cKloq1a9oxSduqj1dD8QiaVYqnsqA2FC9w03NnWjM6
         ViqJ9qH4VZ/5uenae/QoMCRhwqIl2QY03fbhWp6m2TOaSkud2TsddGxNodrQjG+Y8O+t
         5jiHtISMzec0eSC6lmo3Z2CybH6fEjMe4Gm+h1ikkFEbvmCluFnVVr5wV9rvmw8BiLYf
         Y+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771938641; x=1772543441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gf+c8hVZNgFP3BiEHZouqSwT6ALbJDbEZGSHCOTFUzI=;
        b=SeMRiyHyURfWc8oujk+vupgFq2sNJUj5laL3kEMe8Lx3Z9eBQE9Q3IOyr2d/bk31S5
         4r6GMeolaHH/uvY7yhgFOVozfFUc6Uly+Elkpf4KaRV1Y01v5Kz0zuI/n6wwBwPARBO0
         o5KX4DtOgOLbtv35fgliUe+gxUzDyA1KIG066m7bvoXJNdeGP5hw8p4OipbdBpYNd7UX
         bEcvU8Q4h3pMB8FYRIQW+k6SpIJt11XTchV31ehJjCL5dLWoABqY0UswFkW4FJtqrwN7
         HDT3HfXqmCr0S/t1rmILAdsiqPRBOirJ4rH2BX4KERDi0DQaoyBEa3C7XWdcbHFVckgR
         nv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUSTjDcOZG/EznJ5hGufT/o2eckQbwq+TRwYU/dqCb5bHgIP3zoyeqedmvZGaPmlCRplY93lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAD+H364T86uAAigDN/KR9ky2hm/X4TdEnyrhLQtvLAFViOZl
	7qfI9hp2tmiKxaSR9NWbaxLcgGEnaaSZeeVWC3k7WlY3JocsQvARtpQI2EAmQkZPoCI=
X-Gm-Gg: AZuq6aIfLtnnt3lIdGbWihVacS4GOPxsJhrVpPrFAkVGTyyvowQBVpe6o/sL4RoNOyj
	bvODJauCow1CNFH03Y6bXO4wGdyGijrT+BsdXgK6N/FzCwaAo51eHaBJqhrBffbdmhCzJ5dRAa1
	YKzSGKZY+l3OtyBjvcBJEFz0ZGm53H4KyMMfuQYLspa/mmqGMcqr1THQzbbEKg2AXGk++tUk0Pc
	ynHsT1+QiM0C2G4C7r3BARlWM0ohtvO0GdRYhgIR+++9h9DsIllWcQvG65o2IoaVkBc7OBmfeMK
	gCws9R1bX0qD6IZGAxii1W/E/Y783aTMrMrgmO4IdFeNCTSBPxyPltBzHm/nfvjYWz84nWGXprX
	pUwMQEyULvBZuFfWyu37By7+39O/YPlEODBkWn85X3s1EFszbfbLxH2h9q8OACDAQW7lmWCcqR8
	jQ5Hbka11lNcDyJY4SMPjNCHl/emEfquJyC0HZ8VobtJTa4Xt87HWWdXO3JXTdm3P9g/5f4bEWw
	UTqhmkVwv5Jvp9+Z/QsIu2sUw==
X-Received: by 2002:a05:600c:a11:b0:483:361b:deff with SMTP id 5b1f17b1804b1-483a95c9e16mr214164825e9.14.1771938640642;
        Tue, 24 Feb 2026 05:10:40 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f3d0100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f3d:100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b87db57fsm33188865e9.3.2026.02.24.05.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:10:40 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: to=idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ceph: add a bunch of missing ceph_path_info initializers
Date: Tue, 24 Feb 2026 14:10:29 +0100
Message-ID: <20260224131030.3049328-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217914-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[ionos.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.kellermann@ionos.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ionos.com:mid,ionos.com:dkim,ionos.com:email]
X-Rspamd-Queue-Id: B20E11876BD
X-Rspamd-Action: no action

ceph_mdsc_build_path() must be called with a zero-initialized
ceph_path_info parameter, or else the following
ceph_mdsc_free_path_info() may crash.

Example crash (on Linux 6.18.12):

  virt_to_cache: Object is not a Slab page!
  WARNING: CPU: 184 PID: 2871736 at mm/slub.c:6732 kmem_cache_free+0x316/0x400
  [...]
  Call Trace:
   [...]
   ceph_open+0x13d/0x3e0
   do_dentry_open+0x134/0x480
   vfs_open+0x2a/0xe0
   path_openat+0x9a3/0x1160
  [...]
  cache_from_obj: Wrong slab cache. names_cache but object is from ceph_inode_info
  WARNING: CPU: 184 PID: 2871736 at mm/slub.c:6746 kmem_cache_free+0x2dd/0x400
  [...]
  kernel BUG at mm/slub.c:634!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  RIP: 0010:__slab_free+0x1a4/0x350

Some of the ceph_mdsc_build_path() callers had initializers, but
others had not, even though they were all added by
commit 15f519e9f883 ("ceph: fix race condition validating r_parent
before applying state").
The ones without initializer are suspectible to random
crashes.  (I can imagine it could even be possible to exploit this bug
to elevate privileges.)

Unfortunately, these Ceph functions are undocumented and its semantics
can only be derived from the code.  I see that ceph_mdsc_build_path()
initializes the structure only on success, but not on error.

Calling ceph_mdsc_free_path_info() after a failed
ceph_mdsc_build_path() call does not even make sense, but that's what
all callers do, and for it to be safe, the structure must be
zero-initialized.  The least intrusive approach to fix this is
therefore to add initializers everywhere.

Fixes: 15f519e9f883 ("ceph: fix race condition validating r_parent before applying state")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/debugfs.c | 4 ++--
 fs/ceph/dir.c     | 2 +-
 fs/ceph/file.c    | 4 ++--
 fs/ceph/inode.c   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index f3fe786b4143..7dc307790240 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -79,7 +79,7 @@ static int mdsc_show(struct seq_file *s, void *p)
 		if (req->r_inode) {
 			seq_printf(s, " #%llx", ceph_ino(req->r_inode));
 		} else if (req->r_dentry) {
-			struct ceph_path_info path_info;
+			struct ceph_path_info path_info = {0};
 			path = ceph_mdsc_build_path(mdsc, req->r_dentry, &path_info, 0);
 			if (IS_ERR(path))
 				path = NULL;
@@ -98,7 +98,7 @@ static int mdsc_show(struct seq_file *s, void *p)
 		}
 
 		if (req->r_old_dentry) {
-			struct ceph_path_info path_info;
+			struct ceph_path_info path_info = {0};
 			path = ceph_mdsc_build_path(mdsc, req->r_old_dentry, &path_info, 0);
 			if (IS_ERR(path))
 				path = NULL;
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 86d7aa594ea9..a87c2bc09965 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1363,7 +1363,7 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	if (!dn) {
 		try_async = false;
 	} else {
-		struct ceph_path_info path_info;
+		struct ceph_path_info path_info = {0};
 		path = ceph_mdsc_build_path(mdsc, dn, &path_info, 0);
 		if (IS_ERR(path)) {
 			try_async = false;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 66bbf6d517a9..5e7c73a29aa3 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -397,7 +397,7 @@ int ceph_open(struct inode *inode, struct file *file)
 	if (!dentry) {
 		do_sync = true;
 	} else {
-		struct ceph_path_info path_info;
+		struct ceph_path_info path_info = {0};
 		path = ceph_mdsc_build_path(mdsc, dentry, &path_info, 0);
 		if (IS_ERR(path)) {
 			do_sync = true;
@@ -807,7 +807,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (!dn) {
 		try_async = false;
 	} else {
-		struct ceph_path_info path_info;
+		struct ceph_path_info path_info = {0};
 		path = ceph_mdsc_build_path(mdsc, dn, &path_info, 0);
 		if (IS_ERR(path)) {
 			try_async = false;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d76f9a79dc0c..d99e12d1100b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2551,7 +2551,7 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 	if (!dentry) {
 		do_sync = true;
 	} else {
-		struct ceph_path_info path_info;
+		struct ceph_path_info path_info = {0};
 		path = ceph_mdsc_build_path(mdsc, dentry, &path_info, 0);
 		if (IS_ERR(path)) {
 			do_sync = true;
-- 
2.47.3


