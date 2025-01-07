Return-Path: <stable+bounces-107802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04D8A038A4
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 08:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46427A1945
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8534B1E0B91;
	Tue,  7 Jan 2025 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="LxqYsGP7";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="gUsR4vAO"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A54197556
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736234184; cv=none; b=dC5wUxatL/mHdljU7AW5oXuQrpZ0x4qjSYpatFdBR4avT+asRnzGYUffsTCPnDvt9qXEOyNbbhJ0MloYWoBTTIoaRndSUDAtdlsNYOTD/1ozOGjsU6dOEatIJpaA6pKNIReQm49OXXbuVSiQj0YZ0qLKhRmxz+2ep6u1EaSXAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736234184; c=relaxed/simple;
	bh=4JOf4vQJKySbNhFzUeO9HfqnUcNDwDoaMz2y5skl6qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJYVRNxzvJLBCYC/zEnkpkYJIlzzGKz5+UNp86oqvz4H+mTqaW0KWBwa3SsATv55k7+EsVgaDML9bHlB4jnlr/pylz0iRkF/t75dHSducTatHg3UdRCI9KPWg1IoBbq3GuOWgCAehj6Vd6ArGo7AR999Dmgc3oIt/wX+rUgx7hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=LxqYsGP7; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=gUsR4vAO; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1736234172;
	bh=4JOf4vQJKySbNhFzUeO9HfqnUcNDwDoaMz2y5skl6qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LxqYsGP7rd9rzP0Oj/1U29fRCe9Y1fnmoOk58JDTaRQOs56OC86uGrd09ssh/xVg2
	 dEWvfi4vneFm0XElCTxppqKCAo0pv/Wdd260CBAx4Ii/pU62q5ulgR7dYi4yVHv78n
	 I2jVJpRlBdMHqBIISNjb6THUN/+9cuihH/HF18r4YU8u6aZbYSfbqgz5LHv3PkVLgA
	 5qeqcz9MwzHri03hhDXkDORp+88yOY5gncW63VZDVmtgvgEuBqnkDI4McVnplDYfip
	 LenHxnV2+ymqg7PSLHX2FK+F0y7Cx74MB1vOlXvRj56loz5uAmVLTqiAs0627ALad4
	 QO6wqAGsdlwyw==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 7FD7F232
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 16:16:12 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=gUsR4vAO;
	dkim-atps=neutral
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 8CC12232
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 16:16:11 +0900 (JST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2163dc0f5dbso192482075ad.2
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 23:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1736234170; x=1736838970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpDKhWdhWoMNZAx6W+tFqQ6UOWX7FUPFoMzc+kYG/bM=;
        b=gUsR4vAOH7mwD6XUFC1SBOvERYdbJtGjkjczkQ1a5qMM3q4NHT6QUsMEZ8bZPLhd83
         GlR6b25agEgQ3dglWsVWoJQvr0YEiDRWuOS98KgR6buaHCjtlKRT1I7fISUAo7XKP6RQ
         8XOxdxDvxYeANcvWmkDaq2KBf0hE4t//1qBhT46jHI0ZMLQrVIpFFVkWNaiHUXJXS9v8
         vAJPAL/Fxju3/tr5jJFz1Qk5l6IJyfkVHt3wSPgXpFNYBkkLFKgj93Tvk89htCM8Ku3U
         wbBzdtrB/j+3MTcvwwAtoG+/u0co+ncF+4UzG5xXVCqTGT7mHVCBAMySP3Exs1ykXUMM
         d3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736234170; x=1736838970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpDKhWdhWoMNZAx6W+tFqQ6UOWX7FUPFoMzc+kYG/bM=;
        b=OwwrvC5DVQo+iqxVhkXp8suwx+oMwaIQxqJ+xzln7UHqUqpoApxM8GDqzYOYyAHZC8
         pjQRi9QVHRZMQPom1Y8qcz/8NI+jtT58bUmx2vwiFN/mLvGO8Hnzi8M8eH3c/NRCfwyq
         4v9wPsGUfnA8IU2aY7D+G3wI5lRboNlfDm/8LX8wJQRRyFrZn/VQ7Shjt3hs5TjcUSbQ
         AorQgubYTDWeMvDS8NjCDu+CyIW3P/1FIeu4wuwHuszfMHYtTxfKF8s73HbLGDpyqgOG
         /+AfbPtGHSSd2CVgMosstRy5YgjvZ2PNn8qJ2N7LDjXzk7bTj7YojEQxpEhuHh/E+qTp
         XBwQ==
X-Gm-Message-State: AOJu0YwoaDUG+sllxJVRiPjFjSOaL2jwmVKkmyxn+iul+F36iSxiJgMm
	BnynEbkXwfZz7bWqxFaqUbz7nr4l1aQsiUOzB6JJSHHvaRuHJgjrCiCkpzx5d/+6doo/VGbZpO5
	NkXpUlAmGlLzxpVQeoGFGOSrlc/r7EgMoO5oNriJgg8Nkv4T7cXm41Iw=
X-Gm-Gg: ASbGncuf+oGdY0nh4aGOiiOeN6yUtPbD9V4c6w/6cCVkw/kf2poubS2NZ9b3awUXSc+
	Ppp8G7ynQr5sKiHuL8OaJwfmQ1KokKE+Y1ZrTnG2C7GYth4idz8jXdPlhuNUjx4+0bTVRILPNuv
	Dpf676t/fOFfxbndtFUVrdc8qt0urnuvRyI6ZlT/XyI7VYvDFXAbkauba3f2/heKuVhMUbJXYta
	gbf1fQ4UKCDeuFZBY90n/1r+oWgAQhqHdE7ApTLudcKxtTrufVPfY2W0OWvkbtuQeQZsfP36JkX
	Mzdlw0YIMVGCjeuKSYLCNtFdeB+uT8tZCgPzL0ox
X-Received: by 2002:a17:903:94d:b0:216:46f4:7e30 with SMTP id d9443c01a7336-219e6f11764mr946279465ad.43.1736234170647;
        Mon, 06 Jan 2025 23:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAAlP1234Rnr9ldpY2k0GzJjVBsLLDKGARicFLlaJ4wlVFeOd9XKA9FdNXUOAGZRvRjOTfbw==
X-Received: by 2002:a17:903:94d:b0:216:46f4:7e30 with SMTP id d9443c01a7336-219e6f11764mr946279245ad.43.1736234170365;
        Mon, 06 Jan 2025 23:16:10 -0800 (PST)
Received: from localhost (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdd9bsm303236805ad.132.2025.01.06.23.16.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2025 23:16:10 -0800 (PST)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	patches@lists.linux.dev,
	Kairui Song <kasong@tencent.com>,
	Desheng Wu <deshengwu@tencent.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 5.10 5.15 6.1] zram: check comp is non-NULL before calling comp_destroy
Date: Tue,  7 Jan 2025 16:16:04 +0900
Message-Id: <20250107071604.190497-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <Z3ytcILx4S1v_ueJ@codewreck.org>
References: <Z3ytcILx4S1v_ueJ@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a pre-requisite for the backport of commit 74363ec674cb ("zram:
fix uninitialized ZRAM not releasing backing device"), which has been
implemented differently in commit 7ac07a26dea7 ("zram: preparation for
multi-zcomp support") upstream.

We only need to ensure that zcomp_destroy is not called with a NULL
comp, so add this check as the other commit cannot be backported easily.

Stable-dep-of: 74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing device")
Link: https://lore.kernel.org/Z3ytcILx4S1v_ueJ@codewreck.org
Suggested-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
This is the fix suggested by kasong in reply to my report (his mail
didn't make it to lkml because of client sending html)

This applies cleanly on all 3 branches, and I've tested it works
properly on 5.10 (e.g. I can allocate and free zram devices fine)

I have no preference on which way forward is taken, the problematic
patch can be dropped for a cycle while this is sorted out...


Also, Kasong pointed to another issue he sent a patch for just now:
https://lore.kernel.org/all/20250107065446.86928-1-ryncsn@gmail.com/

Before 74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing
device") that was indeed not a problem so I confirm this is a
regression, even if it is unlikely.
It doesn't look exploitable by unprivileged users anyway so I don't have
any opinion on whether the patches should be held until upstream picks
this latest fix up as well either.

Thanks,
Dominique


 drivers/block/zram/zram_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b83181357f36..b4133258e1bf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1734,5 +1734,6 @@ static void zram_reset_device(struct zram *zram)
 	zram->disksize = 0;
 	memset(&zram->stats, 0, sizeof(zram->stats));
-	zcomp_destroy(zram->comp);
+	if (zram->comp)
+		zcomp_destroy(zram->comp);
 	zram->comp = NULL;
 	reset_bdev(zram);
-- 
2.39.5



