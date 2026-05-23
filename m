Return-Path: <stable+bounces-253970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fTmxNJ/uEWpfsAYAu9opvQ
	(envelope-from <stable+bounces-253970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 20:14:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 477325C04DA
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 20:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2340530156C1
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09433360EFB;
	Sat, 23 May 2026 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEC7+VqS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500673090C1
	for <stable@vger.kernel.org>; Sat, 23 May 2026 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779560092; cv=none; b=tsC48QRwo7c6FzUhJ1SxZk7AGCfy0InJ2lmACPtMtXKo3sykCg24RWMvw/g4jvIYB8jY7XLxis0dQajujSsEeP2dF1mMgDecW+aCXWQmCkNNNMa1trkUIB8Rwvf7r5XIpaiU8I5z8DZDz2gHPsFaqpuoEUejarI93Fa1IU/RMeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779560092; c=relaxed/simple;
	bh=mm5xjnozPR6r5jkIAcvDPU4KbucjiTawPGqvlrw3/Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hr/+HxXnMFT2AyHfVqzUkZGDzJ0DHK6KgW+kx7YDh1O0SX4XjMuN8zy2dgX8eFTZT7igT8MJrMKGjy/v1U2DPMxCuilr132QRtSMj0RGbuYtY9mHnwXndB6NA0JrOPvESA6/QewT+LxYndQ1iFvj1z075gOh8pgqestj9bLfuMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEC7+VqS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-449de065cb3so8000526f8f.2
        for <stable@vger.kernel.org>; Sat, 23 May 2026 11:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779560090; x=1780164890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PKrZA3SQ6hneCPeQUwipbEL8KL38eo+epb8OIzHcMbI=;
        b=QEC7+VqSx6/ImnjTGUnEN0N1GUTdFsb6mosbHAA+8PQBS00xAjx5p/j9mNjP+9NtYt
         8y1w/oQ0qylmGsQ3yiL/YByhN8BRu7bkNpy7pnHDsJpef3auF/RTSsL+OYPn+3pOqN7y
         KhsHN4oy4IpMR0T5eSmcsLRIhQTkb7+Eh6PV/Rqkwtu6kS3UDCIDLQ4jrkAL9+LrUE3Y
         5rjZz+4jwYs/evwwdk8ZjfanEw+wpsasi3KfEAHVnQhVd+qBAiLpgVMC3TByh892G4JL
         PPE7CO70JMj6Dg/ZMxsXfn2G1tY18cLCp0glkhIS9pDZqRewfbrzgFt8+r9gKP6LV262
         fpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779560090; x=1780164890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKrZA3SQ6hneCPeQUwipbEL8KL38eo+epb8OIzHcMbI=;
        b=oE0vsVafuTRGGGSi4e2qhhG+vhI+ubn355QGLQd49YCypD3vdUKjViROF6zzEE7fdm
         Y35YeLv9VHpRka5tYBVFHJ5Y15xGTWE/cx6HyzuCOoY23tUrtTze+JClVnQOo0k8FkRE
         wGV6Eyek5IKvwykUF0VQENkbzki0R6YWsuFVVMPlid40V+hfjeo+bEONvMezBjwnLOzu
         N6v3T1sBKRl5uFkMQGHwmzV2tWmvHFLsVU56g0MJUJpIEyJIKiqR64FJr+7QT0sEqr45
         714jZRdkZgSl+VeFm1Me6+BZrKE8m9LMpYVviDHRIMGXU1+8WODuV1Q4I77bToYoDFmu
         5Hag==
X-Forwarded-Encrypted: i=1; AFNElJ9D+5hb69wjPJxlrIMkwEdlgizFmx+W2x58isH4bCyaDtwc91j4cMJOA8eQFORSg6hd0CrYFLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxxKa7AMWAISRN8ixof3Z0hAcPqJn1yeaHjBxV3aekqNLXxox
	AUH+eoufPFVbrrTrK192mSXGqvf7Xw458BALXx4fPbvYa5ce0KNFJmuf
X-Gm-Gg: Acq92OED7hYAkBhCInjgVdvSoIXCZEns9bPUodvhFOuMCQtDhtcTzPZFxxTXiy7rIpX
	sD+KHry9zAIdWR12F20lWGjKaP+qE/CTnzr16fwMLlUmGdrJIWjq/CUeODmDunx++9re3QVwW7D
	jYXCkLwi7QnJOqAlhrn2zsGzOnJccN0BGvGxQT16ayGPpyTU6pXX3v9wD1jCzn0EAXhQORnblng
	DF22KX9/owiU8KNQlg87yMBSrS1ielgQThswUwa6+p7XCl5wNHiRt/0HxOg89g8pM+j9tZZbn1G
	VeSiKN6mjanlytNldqBzLwSD+JfhfsEiBwJ8sqZUYI8A7o1gjMgFzGVbkkK69Vkpwln+4W23lO5
	dBMsJOQrfRjXNN/NvL8ytZ+3HBrnbollcdZB/fINnYdiPE8GExrq5IpdyWtczkbqsHuorCGWlKF
	p1zpyLDJr7tCUmHkZvk3yHcitzdPZN/JpBGdQ5FW6j90PvdZLK5u1gBq1r0N1XuJ6C3OkIjgJHa
	b5DkhxcboA=
X-Received: by 2002:a05:6000:41fa:b0:45a:c0e1:37b with SMTP id ffacd0b85a97d-45eb389fdedmr13444344f8f.32.1779560089580;
        Sat, 23 May 2026 11:14:49 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4850dsm13042447f8f.17.2026.05.23.11.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 11:14:49 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: gaoxiang17@xiaomi.com,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	syzbot+7f4987d0afb97dd090cb@syzkaller.appspotmail.com,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dma-buf: fix UAF in dma_buf_fd() tracepoint
Date: Sat, 23 May 2026 19:14:46 +0100
Message-ID: <20260523181446.69525-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[xiaomi.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253970-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,7f4987d0afb97dd090cb];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 477325C04DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Once FD_ADD() returns, the fd is live in the file descriptor table
and a thread sharing that table can close() it before DMA_BUF_TRACE()
runs. The close drops the last reference, __fput() frees the dma_buf,
and the tracepoint then dereferences dmabuf to take dmabuf->name_lock
-- slab-use-after-free.

Split FD_ADD() back into get_unused_fd_flags() + fd_install() and
emit the tracepoint between them. While the fdtable slot is reserved
with a NULL file pointer, a racing close() returns -EBADF without
entering __fput(), so the dma_buf stays alive across the trace. Same
approach as commit 2d76319c4cbb ("dma-buf: fix UAF in dma_buf_put()
tracepoint").

This undoes the FD_ADD() conversion done in commit 34dfce523c90
("dma: convert dma_buf_fd() to FD_ADD()"); FD_ADD() has no place to
hook the tracepoint safely.

Reported-by: syzbot+7f4987d0afb97dd090cb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7f4987d0afb97dd090cb
Fixes: 281a22631423 ("dma-buf: add some tracepoints to debug.")
Cc: stable@vger.kernel.org # 7.0.x
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/dma-buf/dma-buf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 71f37544a5c6..d504c636dc29 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -792,9 +792,13 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags)
 	if (!dmabuf || !dmabuf->file)
 		return -EINVAL;
 
-	fd = FD_ADD(flags, dmabuf->file);
+	fd = get_unused_fd_flags(flags);
+	if (fd < 0)
+		return fd;
+
 	DMA_BUF_TRACE(trace_dma_buf_fd, dmabuf, fd);
 
+	fd_install(fd, dmabuf->file);
 	return fd;
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
-- 
2.53.0


