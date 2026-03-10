Return-Path: <stable+bounces-223967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BwHKWf9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AC424A40E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEBB9318A15D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ECF2D978B;
	Tue, 10 Mar 2026 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lonfsc+o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D82BF3E2;
	Tue, 10 Mar 2026 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141101; cv=none; b=Exe9XHpGM85vUoiVTt8fsiNARuUZess+5ZN77J+4r6cZjRL8GSYemVOGTRhcVEYcxwxhA7JU2lhYaL7V+abEM+e6n1hyT+2ZypTXrfOR6G6CsIqq24OKCzTGbeFHgNdcljLfczTVt5ORlS9BQReGUY9o1+fl9OhNRjpxj2G7hSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141101; c=relaxed/simple;
	bh=GaTadElwZ6hXtr0r9Yks9f8iem+UMkSd8+02Z1rS110=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWZm6XH9hsi13LpbepLcFZpZHt9v1qhlrWrbE+PqSUCHYTz2trREEBW7Yg6bq2vuiGv7Pm7VT/TAu/UQYGboh/uelVyhsCF73kgk3hs4ar/VlgAi4sA/rvCnQAYl8e++xaHHdNRbP+31DBTKvVuBabQXTShdOSdPaLrdeuUsMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lonfsc+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57736C2BCAF;
	Tue, 10 Mar 2026 11:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141101;
	bh=GaTadElwZ6hXtr0r9Yks9f8iem+UMkSd8+02Z1rS110=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lonfsc+oRGfXBxgPcmgY6pk3t0vQ4hBwizvvwJuYlD2FPILEX0+T9/jKi6v4JsXud
	 tHZueHcgb7y4jTvq6V+aQuuIMAGUCopBX9cWpCToUg4n6wGuWtk7h0bap3DAUdSO3H
	 l2BWFKqPYPwYFb2pCsZXzfkyoku+spWPGk/czD1ACdjVp0n4SjXP7259bWa/q+zsR7
	 lKDyLQo/z25JG4XV2iABaOvzSKBtns1CxkvaCzfMy31tYhKn63w9yHi0zUygtoCDZS
	 3p6NX2ww9/CVoarAOaJ8Xhf/awWbZ71uLuFsfH7ybqL+8RJqdeItmLIhif9Fg4rJTX
	 TTv9/oYl51FZg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	syzbot+ab12f0c08dd7ab8d057c@syzkaller.appspotmail.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.19 102/311] media: dvb-core: fix wrong reinitialization of ringbuffer on reopen
Date: Tue, 10 Mar 2026 07:02:29 -0400
Message-ID: <e9126debff40c1b8b4e856f324be6b6a34da0ab4.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 13AC424A40E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223967-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,ab12f0c08dd7ab8d057c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,linux-foundation.org:email]
X-Rspamd-Action: no action

From: Jens Axboe <axboe@kernel.dk>

commit bfbc0b5b32a8f28ce284add619bf226716a59bc0 upstream.

dvb_dvr_open() calls dvb_ringbuffer_init() when a new reader opens the
DVR device.  dvb_ringbuffer_init() calls init_waitqueue_head(), which
reinitializes the waitqueue list head to empty.

Since dmxdev->dvr_buffer.queue is a shared waitqueue (all opens of the
same DVR device share it), this orphans any existing waitqueue entries
from io_uring poll or epoll, leaving them with stale prev/next pointers
while the list head is reset to {self, self}.

The waitqueue and spinlock in dvr_buffer are already properly
initialized once in dvb_dmxdev_init().  The open path only needs to
reset the buffer data pointer, size, and read/write positions.

Replace the dvb_ringbuffer_init() call in dvb_dvr_open() with direct
assignment of data/size and a call to dvb_ringbuffer_reset(), which
properly resets pread, pwrite, and error with correct memory ordering
without touching the waitqueue or spinlock.

Cc: stable@vger.kernel.org
Fixes: 34731df288a5f ("V4L/DVB (3501): Dmxdev: use dvb_ringbuffer")
Reported-by: syzbot+ab12f0c08dd7ab8d057c@syzkaller.appspotmail.com
Tested-by: syzbot+ab12f0c08dd7ab8d057c@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/698a26d3.050a0220.3b3015.007d.GAE@google.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-core/dmxdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index 17184b3674904..9aaae55ce7b4e 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -168,7 +168,9 @@ static int dvb_dvr_open(struct inode *inode, struct file *file)
 			mutex_unlock(&dmxdev->mutex);
 			return -ENOMEM;
 		}
-		dvb_ringbuffer_init(&dmxdev->dvr_buffer, mem, DVR_BUFFER_SIZE);
+		dmxdev->dvr_buffer.data = mem;
+		dmxdev->dvr_buffer.size = DVR_BUFFER_SIZE;
+		dvb_ringbuffer_reset(&dmxdev->dvr_buffer);
 		if (dmxdev->may_do_mmap)
 			dvb_vb2_init(&dmxdev->dvr_vb2_ctx, "dvr",
 				     file->f_flags & O_NONBLOCK);
-- 
2.51.0


