Return-Path: <stable+bounces-211506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB0NOh7SdmmyXAEAu9opvQ
	(envelope-from <stable+bounces-211506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:31:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A483886
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5048F301549F
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 02:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8772C234A;
	Mon, 26 Jan 2026 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5sQpun3"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C7299937
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394670; cv=none; b=kxsJp8hW6s2lTLgOa+wFLA5To5gNRVZSG5vxenACiCIp0AXDoshvH7vOH6Ic7BT0hAcaDKopNJlHD1De6a2ekG5S9PKsWCerozAqtyUpvcfx2nRK5ZqgzGYPUcFjq6vhKDLfim4Wa9/s4TdVQ2aOAS5CRLOm+Z5e3RN98BBjgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394670; c=relaxed/simple;
	bh=xreigetpjHdKa6OZ71uh6zOcPjuDFrwATx0og6exOHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKhPCp3XVskoAY7c1GBmt2WkwLc25VvG+JGkcIdoqaALuB8StikEYRAfIyInwmLm1nnxZ/bzyR5iV0hAaWWq9gita5xw4Yv3IhnpFwNW+VInkHoj+lLq1sR3J7xuHxfU9DOrG8afTrZp7GnrMpMRv6kkSwie4yKyCsQDiIAyLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5sQpun3; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1233c155a42so5551700c88.1
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 18:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769394668; x=1769999468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OeqEToDWh87NKXAJBkWa10HlZtuXDj/TYqt7IVavaQ=;
        b=a5sQpun34domUif7GnfgZYl25NskFflCpMYZekv2FE2b3UNFQ4ca3mDL5YQP2bydJn
         kLFIsU5x7RKY0qNA7WxGTaZTfCmihrhBOdW2uAVR4ZlHZfMrZDqhDi5gRZ0EOjw7N9Ub
         kKD4UbMTvpzdVMFMlWwVD7zAbxnCjQrhSAAVQKjJPyPAHxtqTTjaNgUWaAOzYAUBd6p0
         h2VgjQbGGjmZgjYh4zKp1zbohqaB32CrsMMJC0MT6E3ebMiMybed73hcnyshhvFdsHeB
         vuHk7m9RFow6+pWpimROCROmWP9k7Jw/Rfhb4SEHmx1g691eb3P7Wi26tRBoVmrmpkS/
         DpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769394668; x=1769999468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OeqEToDWh87NKXAJBkWa10HlZtuXDj/TYqt7IVavaQ=;
        b=hOCrtWNC3XzMWrrJvU3s/02V4YVe6VlkBRvKktilInEEXtQWdHRU5KMjgxgNLNbpBj
         dD6lSaIc4bdTX65Y1qpoGbVA0GwNjKBehuo0kAr5IvtOMoPKPtlUAhKEWt2Po9nM/T9U
         U9uxaSUOE/Hyr7336d60/nLPlNhIbvyzN4febgHQ9EfzMW9tspdHAnoDSr+r2USuclBl
         c7ErM4iCKW/z9nmu8C17Gsi9+rjqtKIf1DQffy8ouB55YvULCrIOh8lqVLgxFK89C4Us
         4KSvtin+ld0ClYZsId9sd6v7l1b7zD6b4wUfWibDUFXYbyflFgGo9c/NyVTYNwPN9/+X
         0oMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwwjWSX9d2Kq6q4BIqi1cifqgRw/Wh4BBmfws6mxkIkIUICXpm6477fQuWjaQfTF7HF8WgKSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypSuE+zVAPPuFSlPqT+sZlm8ccMe85MNEWdrZbPEevT69mkQNE
	48HGF9R/x/d4KgcTGzdg5Kw8GPpBy8lCWQfON71JK7WEDvsEZx8xHn0Z
X-Gm-Gg: AZuq6aIu9iN1OWjaZr4omPk4UXfmbS8cSS+r7VyrT5mbQDvgzPzPtQq/VCCKKV17m7d
	qKFt1gyCciebnfQ7ke+zHNqLIShDIetKxoeRotxhGJraJ5XRB9V4LUT2hz/mTtj7HP8m0uQKy4Z
	r89ZaS7tZM668pwFSzUrT5Cqr8Z4lGABiSLgd2qxIiFtAoQMC4LrRxWWmM79DdfaiSLk33wECXj
	syvnzrxJYS/ZVBPnB2YdgnP81B4PKiarUCtHhKA2FLKmr2SoB7lc/eKXqlCIaY3Zr/1lJp5W0Vl
	C4O8PJGvwMxe5afrz1wNCHwDOJQrokdWDBPryIErKdCeFstVa97kgN2jytPNCGeB0Fr3C8eTOUn
	94BT5BO9kqc6ZAhhxgIFI1jTtBNK0hgWefkEBBSrdmSTKHO0NEVl6ZaE6oroEI2JYaxxjBYgViL
	p0rbRBeufxJEVvawumaTdohmJJtwaoZ2E84MznXsgkJczl4sZvCTIt
X-Received: by 2002:a05:7022:238d:b0:119:e56b:98a1 with SMTP id a92af1059eb24-1248ebe99acmr1414133c88.8.1769394668050;
        Sun, 25 Jan 2026 18:31:08 -0800 (PST)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91c52bsm17212277c88.6.2026.01.25.18.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 18:31:07 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Milind Changire <mchangir@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/4] ceph: fix write storm on fscrypted files
Date: Sun, 25 Jan 2026 18:30:53 -0800
Message-ID: <20260126023055.405401-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126023055.405401-1-CFSworks@gmail.com>
References: <20260126023055.405401-1-CFSworks@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ibm.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211506-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E4A483886
X-Rspamd-Action: no action

CephFS stores file data across multiple RADOS objects. An object is the
atomic unit of storage, so the writeback code must clean only folios
that belong to the same object with each OSD request.

CephFS also supports RAID0-style striping of file contents: if enabled,
each object stores multiple unbroken "stripe units" covering different
portions of the file; if disabled, a "stripe unit" is simply the whole
object. The stripe unit is (usually) reported as the inode's block size.

Though the writeback logic could, in principle, lock all dirty folios
belonging to the same object, its current design is to lock only a
single stripe unit at a time. Ever since this code was first written,
it has determined this size by checking the inode's block size.
However, the relatively-new fscrypt support needed to reduce the block
size for encrypted inodes to the crypto block size (see 'fixes' commit),
which causes an unnecessarily high number of write operations (~1024x as
many, with 4MiB objects) and correspondingly degraded performance.

Fix this (and clarify intent) by using i_layout.stripe_unit directly in
ceph_define_write_size() so that encrypted inodes are written back with
the same number of operations as if they were unencrypted.

This patch depends on the preceding commit ("ceph: do not propagate page
array emplacement errors as batch errors") for correctness. While it
applies cleanly on its own, applying it alone will introduce a
regression. This dependency is only relevant for kernels where
ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method") has
been applied; stable kernels without that commit are unaffected.

Fixes: 94af0470924c ("ceph: add some fscrypt guardrails")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3462df35d245..39064893f35b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1000,7 +1000,8 @@ unsigned int ceph_define_write_size(struct address_space *mapping)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
-	unsigned int wsize = i_blocksize(inode);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	unsigned int wsize = ci->i_layout.stripe_unit;
 
 	if (fsc->mount_options->wsize < wsize)
 		wsize = fsc->mount_options->wsize;
-- 
2.52.0


