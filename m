Return-Path: <stable+bounces-249611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIJfNiV3DGqihwUAu9opvQ
	(envelope-from <stable+bounces-249611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:43:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9DD580BFA
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BD783004601
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0891428492;
	Tue, 19 May 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YOFXQImG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB2370AEC
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200986; cv=none; b=jkiTU1+Wjxkczju3SabR2VaYERrSxgGa4hq6QmvwxL9u8IcLkMkEcOeUMEh12qmgDPio04TiuxxgoBGW3r3ouhrEGQB7gQmjtXIiclWY/Oeps2u73kUr532UHWlkJQMjfzoonErgNfagDRFP7x5futloyyUKHXQsAywHWgQdXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200986; c=relaxed/simple;
	bh=aY8s/riUR8NbcTdsHB4cfFhuuDro+tneP/kG5QuD+PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t5j1dMTRQsnvvQPIwex7yTAifRltO6HifR3j9WF9F6M0B2asV9zCDWcKV6tjLydQKZipsSmp9/SFvLsdmkmyPjlKgAFZxz6tCtnj3cHFuNME6juIM2/amgUAo5+/mbJdpyY7g4vRmoxWJqUa7eY1uYz/nqv111mcVmIBFaHbBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YOFXQImG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so815e9.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779200984; x=1779805784; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VeJGd6S2ia6XrvKCx7CRCdCtEvpWnP4MMITBk+g6Kz0=;
        b=YOFXQImGd6ZUr8W2b8Xotc2aumOl0Zul/oz7Eo9EG/MuUHOQBy7iBWYbHg8PH/8xDs
         /Ae/aMAxfaXC7fuzMI6ecmR0E1noFDDwQJgiXwDi4xT6QXx8PwC5mulY/uk4N+UWNXEt
         DPoDjsGNT21GSr07NZb7w9bzlt5u9RLLijUw05LYuS+pPVoxkWTmi5kS8clvD6xPUrc8
         1+bHRQCs9cMWmJpTp5YsfIP1e2yryODtuK2e0ZAo/Xb5exBRehjUfmVCryHnlMQQs0lf
         af4jsSDl8Lkr4bXpEBxOTpsoJBy6IuoVi+7OzqXI2l3VJID/G2k1ntymRpojLPvIGx3W
         491A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200984; x=1779805784;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeJGd6S2ia6XrvKCx7CRCdCtEvpWnP4MMITBk+g6Kz0=;
        b=Ed43wfjCBT+xl74/JUEb3MyM2EGgTw6ztdruGsm/cIHHhLXHw/sVHjD9J4vk7zkWUl
         15THOlAHhviNplNpAuG3aNVzuLsKy4SXlYaCkbPeDxW+WICrNQnwQLg3ISnt74AygMxk
         f9m1zzWl3bVsEcsxnGCOS2ZW94Uk2D08IqqC/ajZj64ACvj9bEBXra7/1LG6Qa9gi5wp
         jchXxRkKbZdLqfQhPTiqt5ksTEpQboVnskZSlJvrWnfLHB/XK3aFFCoVOufyMp40ARwu
         F90H4TlR4JdAIg471rDSSDIGcrT4aouofpnOBl70ZSLzu7QhWkzj8Hpitw2aMyCyj23u
         wMbA==
X-Forwarded-Encrypted: i=1; AFNElJ9H6R2MwWlx+2KhL1UGbWT601tNMpES5pmUIOUfCnPhu26EoNKBBtlq8AejiOGfaK0qKGdAeRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK5jSZlGLQpVnNC0b5i+vzN8+tnuk4w9NIOZMhd9ii4Hrw5cL6
	9OD9GEHyKwvaZVrUCdbbrZcCb6aczWKDwK9ebPxedGGHfS7QvRnSmMbb33y3iK+8gi1BnQA3yYg
	8pA59tZvn
X-Gm-Gg: Acq92OF85t1gVSmQRpHAH4TF2wwD7zNU1VS9dfBKIiqZnq0oX3E3FY4owMVRUgeesjr
	O7eCSaz2Kp7FbUpcbw0MSdqYCbp/7sYaWHf6efzb57yBKyYufuiWeh48zyCQl17RJTdVQcx5DH6
	7nUJOotdZwXyGwXGApSGaHDRgmJHCGzHcDO+HjUD8adE6huFIkafKH99qm+8jHb0CTknDmdvYWw
	wofmEwjsElA/Uh/2KfUtVDyhr16DOm3WlYpVb6yelkiXefz/bEJeEALfjHJCcc7+z892n1pkFre
	OlnT1djn2K82w472xsu5KZT4i6iPc1Ko5CR2NUn/1o+FcK+c3ETBbtFeXKOf+37V628AmTv/zEv
	qGXo5hbInOtUDh0expIhoOBeyErelTj8KpS1d0NQIia70LsNVFbzCjrARBbsC27DJVM/FRFiQo/
	NHqUNIWin3g3dOO/ePObCzIRXiCfdGg/oBX5klc/7uZocyxVw4k6wux3UvvFaw6A==
X-Received: by 2002:a05:600c:534b:b0:48f:d634:b18d with SMTP id 5b1f17b1804b1-48ffa5e1260mr2322705e9.8.1779200983078;
        Tue, 19 May 2026 07:29:43 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c208:c046:d3db:6b00])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6faeasm108628185e9.26.2026.05.19.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:29:41 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 16:29:38 +0200
Subject: [PATCH v2] fuse: reject fuse_notify() pagecache ops on directories
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fuse-dir-pagecache-v2-1-5428fa48e175@google.com>
X-B4-Tracking: v=1; b=H4sIANFzDGoC/32NQQrDIBRErxL+uhY1UZKueo+ShejXfGhj0FZag
 nevzQHKrN7AvNkhYyLMcOl2SFgoU1wbyFMHdjFrQEauMUguNVdiYv6VkTlKbDMBrbELsn6URg1
 i0KPU0IZbQk/vQ3qbGy+UnzF9jo8ifu1fXRGsxXPNrVZTz901xBjueLbxAXOt9QurxG9ntQAAA
 A==
X-Change-ID: 20260519-fuse-dir-pagecache-382a54146826
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779200979; l=1836;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=aY8s/riUR8NbcTdsHB4cfFhuuDro+tneP/kG5QuD+PA=;
 b=1buKvnGP3P5SX8ycYvMxAc4AImC7lHVMZf1DFKNbo8dj6Y1CfP4DCb2dufCQGnMBD01yIA9Cl
 dQDEyzFgY0FAjBje5ihyZnJzNAi2VXN3Ro9I52ngmP3nqpcFwQkPDRo
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
	TAGGED_FROM(0.00)[bounces-249611-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: DC9DD580BFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The operations FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE allow the
FUSE daemon to actively write/read pagecache contents.

For directories with FOPEN_CACHE_DIR, the pagecache is used as
kernel-internal cache storage, and userspace is not supposed to have
direct access to this cache - in particular, fuse_parse_cache() will hit
WARN_ON() if the cache contains bogus data.

Reject FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE on anything other than
regular files with -EINVAL.

Fixes: 5d7bc7e8680c ("fuse: allow using readdir cache")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v2:
- reject anything other than regular files (Miklos)
- Link to v1: https://lore.kernel.org/r/20260519-fuse-dir-pagecache-v1-1-1f060c65930d@google.com
---
 fs/fuse/dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5dda7080f4a9..f07c97358b36 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1793,6 +1793,10 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	inode = fuse_ilookup(fc, nodeid,  NULL);
 	if (!inode)
 		goto out_up_killsb;
+	if (!S_ISREG(inode->i_mode)) {
+		err = -EINVAL;
+		goto out_iput;
+	}
 
 	mapping = inode->i_mapping;
 	file_size = i_size_read(inode);
@@ -1966,7 +1970,10 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
 
 	inode = fuse_ilookup(fc, nodeid, &fm);
 	if (inode) {
-		err = fuse_retrieve(fm, inode, &outarg);
+		if (!S_ISREG(inode->i_mode))
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


