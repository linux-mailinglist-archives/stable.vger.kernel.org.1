Return-Path: <stable+bounces-76166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ABA9799C0
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 03:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0511F2338E
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 01:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EBD79C4;
	Mon, 16 Sep 2024 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XsfvUZB1"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E42F32;
	Mon, 16 Sep 2024 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726449075; cv=none; b=JEQqxAanKEwKe7nGP2NMu6uW9uHnHjl3sxb4IRxsgsBLMxxNY9yOR8CvNYoveVWrk13To/QxwD3ImFHZU/6kFTRiuT+Wanvl1Izp2METUuEV7jv+b2LeVZGoqmkW2VzbvrTAGRTRkPD3o8kGt+aig3JEQVppVR5+F/fbDlTkUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726449075; c=relaxed/simple;
	bh=PsVP+c5GC24BmqXza0aPpBm3E8gZ4G6OrGPD1VPx6vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HTEUQVy3RU1EUP+f0Blu0gRswFUwPKGewD7UpDEZkQVqtwyNwGieTlGRPWFD5kGf/ks4XnCnQrxF23kdUXZbFPk6AsrYUz4HZKnpJRRJ47Yo753O1MYQNWxnjFhRt5sfclbbNAuQxleh6Zq0rzbqzen//Zb8p1JR1KSSDyVNCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XsfvUZB1; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ssPUF
	PQWyxAsIOYliR4pLBv/PxhAoEP5u6GcBq01eyo=; b=XsfvUZB12xGxsjKt6gs3w
	LsQwexPWF/2KSZEd6vrBSbwdm25P+sjOQ1WgGeA1WlBC6TtS8i9ML4vl9EldX7ZK
	FdrBQV5JWGz4V7Iws2I2JNpTxCo0SMLf969m+Bh1146W7ugxn4Usl0Ri524fG3AM
	HI3MaPXA93to47E5dpYz3A=
Received: from debian.debian.local (unknown [183.167.14.112])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wDnjy2Thedm8GGhNA--.32834S2;
	Mon, 16 Sep 2024 09:10:44 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: aniel@ffwll.ch,
	deller@gmx.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Qianqiang Liu <qianqiang.liu@163.com>,
	stable@vger.kernel.org,
	syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Subject: [PATCH] fbcon: Fix a NULL pointer dereference issue in fbcon_putcs
Date: Mon, 16 Sep 2024 09:10:28 +0800
Message-Id: <20240916011027.303875-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnjy2Thedm8GGhNA--.32834S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWkCrWxZrW7JF1DtrykAFb_yoWktrc_ur
	95Zr98Ww4DCryIkrn5CFn3Ar90qa429F93Wa1qyFWaya43Za4Fqr1DXr4rXrW3Jr1xXFnr
	twnFvrZrZw4fCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUcAw3UUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLxVcamVOGXOP7wAAst

syzbot has found a NULL pointer dereference bug in fbcon [1].

This issue is caused by ops->putcs being a NULL pointer.
We need to check the pointer before using it.

[1] https://syzkaller.appspot.com/bug?extid=3d613ae53c031502687a

Cc: stable@vger.kernel.org
Reported-and-tested-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 3f7333dca508..96c1262cc981 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1284,7 +1284,7 @@ static void fbcon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	if (!fbcon_is_inactive(vc, info))
+	if (!fbcon_is_inactive(vc, info) && ops->putcs)
 		ops->putcs(vc, info, s, count, real_y(p, ypos), xpos,
 			   get_color(vc, info, scr_readw(s), 1),
 			   get_color(vc, info, scr_readw(s), 0));
-- 
2.39.2


