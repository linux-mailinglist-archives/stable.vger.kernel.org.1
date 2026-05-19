Return-Path: <stable+bounces-249599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLTDD2ltDGpKhgUAu9opvQ
	(envelope-from <stable+bounces-249599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:02:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F11580310
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EA313012C42
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C5B3ED3D9;
	Tue, 19 May 2026 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qIBsI1u1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF53ED3D1
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199225; cv=none; b=Dbf8w5RqwspGoWO+KOz4VVG107al0O3iM/Vb8HtnjHZfcNOM+2EVkrF8YG5eZ8G5+aYLsrKCekIohC+PrS3hAsoezXY/ETnT0/uGERoL4tRvKtWTKWcr5QT1asnJeHWlUnuR4m7Xl8N81gdTV97jW5sEy9E2ikjxo0+53isXTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199225; c=relaxed/simple;
	bh=rh00+8CkvhUf5L5qQeiUYys/cEAiNnU8gZcvDzmdR6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DzKZkIBeh6X09xxc66VFKMyLPPTcX/sgPo71kE0Wk252v10fSzM/sih5OwYj/vp2dKTn0JIenqlDB+lWSdpF7TFg7C7drcsz1E1ytFUAl3zo0n7n2UcH1kBwGPRhJAe1ttR27aXBzPktbyd43SG7czH+ngwyojZxK9GNP+9WdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qIBsI1u1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so235e9.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779199222; x=1779804022; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj6Q3RQDF1dvwe9sYLWhvH0vVhTSMw/WV5aqKETF4Bs=;
        b=qIBsI1u1rWRS66GIYQG7ye4vCbtT9RaWxIGm/NQPwbz2j7/CRZOMFoTYLiegznDeqc
         mgkCs7550vbiO19PvvLccjdCIXl2mJfIwXBOKNCdjWC5NlIjAz5FnuRPXbpWS0X3SIDn
         s+eHrGUWiUYTNhk1vbSy4CAfczPhObYT2Vx9+lT3hoy7xJzZ4hlyPSsRLzQU4pSgqfA1
         W8praf34GV4Tz58AOPFrjx7Wsq4gk8Jdr1/i48jIb69ODP6Lq5MuhkoVe3l3oF2Xq6EW
         MITfyCcmoH/EBlgzYdifZm38lIY6HG2NcsT3GI/KqE/lCcVz2Cx81AXyuzm3XII5ln4V
         oqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199222; x=1779804022;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj6Q3RQDF1dvwe9sYLWhvH0vVhTSMw/WV5aqKETF4Bs=;
        b=aXIsH4Cazzf2fYOfiiwdVykejQYFUj7q/HZxg2epTyN48c+nF7Wpen1NMnCovpowRH
         RREpsF96CtJESTV+g6ltp4hA9RA6l1ORNZNCEVNDQf/vBLg290D2TcAN6hMPR7/b+cTd
         bayU7zS5u1X3gznh5/DZdB3G4Bur6TPkh/PbJdPreGSX4prRoE527ET5RolltCjWmsBB
         mqmg7Kga1Jjfcl7WNL/6ZO2WG2W/Ge+dLRe0K/nNAd4KKL4lzuFxatdYj798LOAxGfV/
         DwOFxk+C14gBSjvSSxB38Emtzb2ZTPrmWCC4q7vy3rUQEMAXHxZ1OBG4Ev2kj2cizltz
         neZg==
X-Forwarded-Encrypted: i=1; AFNElJ9WzJyLXGgSD6OiF3ITyzvrLP9w8XS99ESCNYhVVvqrb67BvO2Nhxlse6lFXrnnhmUQgM3Gcqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxduexmlRVLXEXn3XRYoZ2Xilq8mrlFByOqNxth8IoBrAM7pfDN
	ldfz2W05MA74KVgPlkfonGdUHg7/PFVs9RKXtIeg7QtXAlUWJUxEkHE58xgLPV5jR+HhauEQI1m
	wwsROGSX0
X-Gm-Gg: Acq92OFTO9rLU7cOKIFWhlRXgrRL1EUpzLeB0bAV3tJ949FvqEMMfWamnMI4yfbr/Hp
	oOwqdv0Ed6SJkX80bwerrABXbnPH6tKJj3Qv5RkPh9+cEi2x/GKJLvGPvq22+NMRSnggdH5ahFn
	K//4dftIw0hhk9uAI/wUTp8Mnr2kf8SbXS5oR1cmgmllNE+g5dhYH2LTofgqwvH0EyndDjyFvBQ
	OknJJ8pk15y+8El1NHk9v4geSAthAdkCjT9Sqj6gf088qzrq8D7btomv0T8El0JNlL5Fsj/p/8N
	r5BYa8TbW18b4cgJ6PdtGvfjjrkPWCHC/UbkL0KYOqEray96TeZWZknHaRAW1XMWRX9En+FmQof
	gu9hWVmzwhyNJQaqkKK4THn8tyEiIse4tPWZDA7W/tlCYcf98Js8NvNNtE3E1yjwShFee9s5lp1
	yGIUF/H464e4qj22uioVyplQjyjr2fkr6MFG126RPjdSrjx84Yeihemfmr0lEkYvUkU8gtG2Gj
X-Received: by 2002:a05:600c:1716:b0:477:86fd:fb49 with SMTP id 5b1f17b1804b1-48ffa5f3d4amr2992925e9.10.1779199221326;
        Tue, 19 May 2026 07:00:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c208:c046:d3db:6b00])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17a22sm46180982f8f.22.2026.05.19.07.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:00:20 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 16:00:09 +0200
Subject: [PATCH] fuse: reject fuse_notify() pagecache ops on directories
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fuse-dir-pagecache-v1-1-1f060c65930d@google.com>
X-B4-Tracking: v=1; b=H4sIAOhsDGoC/x3MQQqAIBBA0avIrBtIU6muEi3EJptNiVIE4t2Tl
 m/xf4FMiSnDLAokejjzdTbIToA/3BkIeWsG1SvbGznhfmfCjRNGF8g7fxAOo3JGS21HZaGFMdH
 O7z9d1lo/XBar62QAAAA=
X-Change-ID: 20260519-fuse-dir-pagecache-382a54146826
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779199217; l=1640;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=rh00+8CkvhUf5L5qQeiUYys/cEAiNnU8gZcvDzmdR6Q=;
 b=iDn1y5baDHzNvdkad7LwoFZexvVnhokCz3wZmVRWkO3YZ/cefv06OcAjXDIHSHk5PIdC4bnRE
 j+yMRcD4jwUBgSgS0h/GxU3cJYSDlnJPBWa/Cz7HWvazYB4u/r7tRmW
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249599-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E9F11580310
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The operations FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE allow the
FUSE daemon to actively write/read pagecache contents.

For directories with FOPEN_CACHE_DIR, the pagecache is used as
kernel-internal cache storage, and userspace is not supposed to have
direct access to this cache - in particular, fuse_parse_cache() will hit
WARN_ON() if the cache contains bogus data.

Reject FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE on directories with
-EINVAL.

Fixes: 5d7bc7e8680c ("fuse: allow using readdir cache")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/fuse/dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5dda7080f4a9..7096f53d335c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1793,6 +1793,10 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	inode = fuse_ilookup(fc, nodeid,  NULL);
 	if (!inode)
 		goto out_up_killsb;
+	if (S_ISDIR(inode->i_mode)) {
+		err = -EINVAL;
+		goto out_iput;
+	}
 
 	mapping = inode->i_mapping;
 	file_size = i_size_read(inode);
@@ -1966,7 +1970,10 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
 
 	inode = fuse_ilookup(fc, nodeid, &fm);
 	if (inode) {
-		err = fuse_retrieve(fm, inode, &outarg);
+		if (S_ISDIR(inode->i_mode))
+			err = -EINVAL;
+		else
+			err = fuse_retrieve(fm, inode, &outarg);
 		iput(inode);
 	}
 	up_read(&fc->killsb);

---
base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
change-id: 20260519-fuse-dir-pagecache-382a54146826

--  
Jann Horn <jannh@google.com>


