Return-Path: <stable+bounces-48604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6543F8FE9B4
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E445A289714
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3C4198A2A;
	Thu,  6 Jun 2024 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="af1pajPg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACBF196DB3;
	Thu,  6 Jun 2024 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683057; cv=none; b=itiZoA/vA7P9bfyyHJB/dVTrHNfjQPRPNDqjZWCxdu9aSFUno6OomgMl0n3zh9dD0ngwkS1s7mCvrF6HCwCP9o8d0EtRoUFPW6BHM3FOiEx+sy7OSCF6bQur1xKmZ9UwErm/Cpon81Wdy58OVIzKuEquY71+TamTQOmcT0OF2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683057; c=relaxed/simple;
	bh=keMOlsA6aW14XppwiRUBHW9qrkliGuUkOc+SSr//VtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brMhCTxgCcMl+zydmDVzRqPnkw2OEb060MfbjUa0uftz+1AmMS1NIGyXNT+xIi89RM9W2cMl/gSqZqTpVhVOYY7GbX5WL2d+uj7aGNTSZPfN5HFQl6UUXDEQADZJiJHCe1hn9O0JQRIHk49gHH4iH4Vd4c8jPRglUBTTkobaIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=af1pajPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587B5C4AF09;
	Thu,  6 Jun 2024 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683057;
	bh=keMOlsA6aW14XppwiRUBHW9qrkliGuUkOc+SSr//VtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=af1pajPgtYXeOsBHVIuHut63z3gbG06Y5SWsC8G94GDrLj2XnUIZWZ/41uLi6fD1A
	 3LxSS2EfuJUVRVUijg1P1nSccpCyWYJHBss/TYIh7Wx6wPNisaWwt7h3kfVnDWRGUe
	 2uxuB96KoYTofypHbaLUe1+62oovEpxRFQU5r7aI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+a225ee3df7e7f9372dbe@syzkaller.appspotmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 303/374] dma-buf/sw-sync: dont enable IRQ from sync_print_obj()
Date: Thu,  6 Jun 2024 16:04:42 +0200
Message-ID: <20240606131702.009421276@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit b794918961516f667b0c745aebdfebbb8a98df39 ]

Since commit a6aa8fca4d79 ("dma-buf/sw-sync: Reduce irqsave/irqrestore from
known context") by error replaced spin_unlock_irqrestore() with
spin_unlock_irq() for both sync_debugfs_show() and sync_print_obj() despite
sync_print_obj() is called from sync_debugfs_show(), lockdep complains
inconsistent lock state warning.

Use plain spin_{lock,unlock}() for sync_print_obj(), for
sync_debugfs_show() is already using spin_{lock,unlock}_irq().

Reported-by: syzbot <syzbot+a225ee3df7e7f9372dbe@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=a225ee3df7e7f9372dbe
Fixes: a6aa8fca4d79 ("dma-buf/sw-sync: Reduce irqsave/irqrestore from known context")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/c2e46020-aaa6-4e06-bf73-f05823f913f0@I-love.SAKURA.ne.jp
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma-buf/sync_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/sync_debug.c b/drivers/dma-buf/sync_debug.c
index 101394f16930f..237bce21d1e72 100644
--- a/drivers/dma-buf/sync_debug.c
+++ b/drivers/dma-buf/sync_debug.c
@@ -110,12 +110,12 @@ static void sync_print_obj(struct seq_file *s, struct sync_timeline *obj)
 
 	seq_printf(s, "%s: %d\n", obj->name, obj->value);
 
-	spin_lock_irq(&obj->lock);
+	spin_lock(&obj->lock); /* Caller already disabled IRQ. */
 	list_for_each(pos, &obj->pt_list) {
 		struct sync_pt *pt = container_of(pos, struct sync_pt, link);
 		sync_print_fence(s, &pt->base, false);
 	}
-	spin_unlock_irq(&obj->lock);
+	spin_unlock(&obj->lock);
 }
 
 static void sync_print_sync_file(struct seq_file *s,
-- 
2.43.0




