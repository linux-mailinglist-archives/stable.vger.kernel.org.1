Return-Path: <stable+bounces-59199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106D292FCA9
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 16:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFD31C22618
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F7A172BCE;
	Fri, 12 Jul 2024 14:34:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19DC172BAF;
	Fri, 12 Jul 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794878; cv=none; b=HbN7WlrtRtV0aLJDMEMZHusdiincbKBm81fQrAYEa19rjzQ2zDi2KOiuO6D00IkFQ6if1v0V65F04QRbagb3wfI0VWaX1IgXjtdQY1BjRgu7z4ywyivfL8/x7GZMsvDwPG++eg+SHeRq3Vur6Rp7FkBjJ17A0ho+EGNZ2y8H0D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794878; c=relaxed/simple;
	bh=l7PJwe3KWvK5haT5OB1kVY4lIVopAz5D0IUJmHHLV5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFHurp/tK+E8YqcBIaoduL/3tOJfHDh2mqh49Omh6N4wjOdJoOG8+oCPxCwgY9TYFHaOM0+AnwMr29cC5fVqOiObaO4fuv0lqcc3t/CKTnw1p7rXeDHLSdzm3WhB3IBoixxQu65hfBd724psfZMgOsDGImuuRTekDEwqP/y6Low=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso2852783a12.0;
        Fri, 12 Jul 2024 07:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720794875; x=1721399675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTHbgE6h5G2xxuO/oI+Wjht6sqYDxcfoXzE4OLT7DJE=;
        b=sS/gsoXbXu5miNMu3U4LZkuOQd1p5f/LcZaHLnXf/uw2eFNnujn/ZJ/49oCALt+Gee
         Bp/+A3Uph3BXRtVd47O2M/T18voNlToQfBP0SqSk1/oOGBaLxP1JCnksxJVsj13c0D5c
         2Rhu2CGIpGUCUKHlH0t+iEJ6wnWBZayWBAfeckekHyqpJzLsC0Z1rxVM4WHYXzUMFAih
         EG2o9AHrunCLANQO/uScm2OYKolk0AzmT/p+xwWYqawO5fuSju6wbzjbtvYWF3IQwIDF
         YBzoWqt7yj8aKzZXMrndFLAfPN3XMwWW8sVw0YkojePYQc478JgL+DoBLnp4WE6G+VwQ
         kv8w==
X-Forwarded-Encrypted: i=1; AJvYcCWFE3C3m1+PltdtYhJVWyrjmITSHr381z4EN1DubS4oed5GrHnPdAWFpMNSyoqKsvOt9MrstTdXrHl4pL2DSqdOELYlBWh9JTWt3zMX1BkGKuxrPDM+soVcmYrN4bLbRxm2jZ4t1cBwcFbPfcnRg6ACVYCIM2oRCLv6+c7X
X-Gm-Message-State: AOJu0YxdvOS1/aUkJwMFrT910BQl3yLMXLzTgYS3M+zwvQimdbzndvd3
	vdl+s7nOD2weptjp2VZQduvjHYR9tob5rgKfDSaQrJ+E3dIdb8Pw
X-Google-Smtp-Source: AGHT+IFx7bkphX+JOo4An8ROVYQ7B6+7lTK29sRJe5lcOp44HVCPT6mVOPXizz7IVkDmbqw4pyxUww==
X-Received: by 2002:a05:6402:2742:b0:57c:610a:6e7f with SMTP id 4fb4d7f45d1cf-594baf8719fmr9753671a12.11.1720794874945;
        Fri, 12 Jul 2024 07:34:34 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bb9605dcsm4634440a12.6.2024.07.12.07.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:34:34 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Matt Mackall <mpm@selenic.com>
Cc: thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: netconsole: Disable target before netpoll cleanup
Date: Fri, 12 Jul 2024 07:34:15 -0700
Message-ID: <20240712143415.1141039-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, netconsole cleans up the netpoll structure before disabling
the target. This approach can lead to race conditions, as message
senders (write_ext_msg() and write_msg()) check if the target is
enabled before using netpoll. The sender can validate that the target is
enabled, but, the netpoll might be de-allocated already, causing
undesired behaviours.

This patch reverses the order of operations:
1. Disable the target
2. Clean up the netpoll structure

This change eliminates the potential race condition, ensuring that
no messages are sent through a partially cleaned-up netpoll structure.

Fixes: 2382b15bcc39 ("netconsole: take care of NETDEV_UNREGISTER event")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:

v2:
 * Targeting "net" instead of "net-dev" (Jakub)

v1:
 * https://lore.kernel.org/all/20240709144403.544099-4-leitao@debian.org/

 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d7070dd4fe73..aa66c923790f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -974,6 +974,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				/* rtnl_lock already held
 				 * we might sleep in __netpoll_cleanup()
 				 */
+				nt->enabled = false;
 				spin_unlock_irqrestore(&target_list_lock, flags);
 
 				__netpoll_cleanup(&nt->np);
@@ -981,7 +982,6 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				spin_lock_irqsave(&target_list_lock, flags);
 				netdev_put(nt->np.dev, &nt->np.dev_tracker);
 				nt->np.dev = NULL;
-				nt->enabled = false;
 				stopped = true;
 				netconsole_target_put(nt);
 				goto restart;
-- 
2.43.0


