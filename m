Return-Path: <stable+bounces-249778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCOnAhtqDWqGxAUAu9opvQ
	(envelope-from <stable+bounces-249778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:00:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75598589483
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D572304D915
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0D39E6F0;
	Wed, 20 May 2026 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTmmpZ0T"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BC4371CEA
	for <stable@vger.kernel.org>; Wed, 20 May 2026 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264007; cv=none; b=Ys1xkxgI+BqIBY/ouTiMYuuuUpgQItmA3SWb02ewA3OV2HeENo1KDHYXoJ+WzKwRWcTiVrSKIM7EEu2d8S5FBgFmKeYQMAKWPg4HxlWoDvKGOklIcql2iGJOK4VtIC/J2Cb6rGDGpmuQIUHBnAmsNKx5x/71x7Qw6zlcbzAaLdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264007; c=relaxed/simple;
	bh=bylUaJtdDzwGNVF4Uktdq+iIyOjiXM6Hq+EFEhzDvAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgLaM6crCe5kK7dU9GM5URNx5YBVbluFYzS6vZyF0bZ+jRNS7g3kBkXxIeWZHLGkjSgqnSTFyH2R3IbsPX62arx69VrDQxoLk2gV8p4ic7V40vokm/E0aaPcJQw3XK6ymySOzOb609dnWTG669dNtD8jLV7e8ehtS4S7plz47v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTmmpZ0T; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12ddbe104ccso3209076c88.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779264006; x=1779868806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSnyB4XZYPvq8d1lcWiPY8NYEotO8Fxh7ugf2SByLY4=;
        b=KTmmpZ0TpDXRO550qmmOQxwrfZ3iKXqEKbKHx7lVeh9+puhNZrJB5JBJ9NYX90PoZ+
         s9yfLXp1jvFGgZPQfc/yrk9QjWEs4UG9YO3hWSSbB+onGyT7MdFhZLkuXrkdSHJiWmME
         59in/N9+fJ3Q1RbYYgvByw1k5w+AVa9nxW6h81hpRKynbUtNZ0ZGaOehD2eaBQB8N78r
         xZYhlKa7keTiE38ySI1b1lB3Secjq+bS9za33h2Wg5dUU9FNAHJ70K3P92c/aWYftLgy
         ipV3Zdy8aKqJuQ92mnCkd0cWaJ//vkQxqxGGNIzC3B5/42w7qXP7K8rJu+JU/1NAUdGC
         SAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264006; x=1779868806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSnyB4XZYPvq8d1lcWiPY8NYEotO8Fxh7ugf2SByLY4=;
        b=jP20ZiQrbLMoaDLyuAqPsXYWlPEwY3cI/n0uZByQVkcYVvGY3BeKFXbyiHHOZiwyzD
         jrypAyo0pYUDnup3Nlyu56xqKmCwns42jC9OumMnzuxYZV/qKiMy8W9WSO1rD5kHrFW2
         wilCYd2gc9MmuzAFDd171NAZxE4z7izMvMWC/gs4ygsFKFkLuI/B69PyVDdvMU5fjC1p
         WojtnuhOhR1/kpdtkbftb8rNeVKc5zDqGCYffGE39T/i8x6jZhXFma3Jkk9Z2Fh/libP
         rGyMCwl5X3j4069ufDGc719lysD+Qj9TjNEW0Guzqano7rRlGxfSvcFbeTF3P53NkX9n
         T4XA==
X-Forwarded-Encrypted: i=1; AFNElJ92QKKV4baEZ+sQicnfTRWC6U4n6EPBslTmnYnoVfh3d70o4BKdOF0IXeBElgHv/XXchWatYEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJw1Ey52ohewgc/X81ryc7cNA5xIQx0zAuQGm+XCvyQ45xg2Kn
	4r3eUQPw10mKyxy/ERGcWhLChOADrDi/RaltPJ+lV+l/KXQcS71eMrvUHtdhooyC
X-Gm-Gg: Acq92OEcofr+MY0CFisrIexPrpjko1hl9W9GxJGOErQqVhu1khSHAS7QlVv+ZNxpq+1
	jSGPwPbT0pr57cSFsct9uv9ksEeOSxAmsw7xpLAHVpyrbRuElNc66kHSKcGRNq3osJMUPokWziZ
	d1a3M7VOZzPANn2BW0BSi88F2bcQEWySupQk5ziWhFezA4cZ1awCseN2RhW2nFZk+hNXQSjS8LA
	Zh4XEsgvuFm1LaH/fyA1jJuvNm4P5LNfr5XVKwOvn4yYvJpdZK94oW3gIW0N7s8Q5H94PytvpMY
	bBZEO+ntwYkLsydjDozXiRzoxMvM8nRcxrHFsE4HqeTOwzJgSn9HVGZ52IHuOQl0VAexq3oeika
	yM7HBt14JsjXe3BHRM4OZHwxf5/lDB9HF5WZ45vmmmKvJaSLw9Ccqqw0EOdu2GEATHhAiie6VjY
	nLK2bUkPD3W/lb75a7ewFXaojT9VR4dsiRe+egJiXgcdKddsFqBxctWqbbS6LQiZC2asqf
X-Received: by 2002:a05:7022:4193:b0:12d:de3f:d84e with SMTP id a92af1059eb24-1350494d102mr8420228c88.39.1779264005251;
        Wed, 20 May 2026 01:00:05 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm26136361c88.1.2026.05.20.01.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:00:04 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	cong.wang@bytedance.com,
	stable@vger.kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
Date: Wed, 20 May 2026 00:57:38 -0700
Message-ID: <20260520075736.3415676-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,bytedance.com,vger.kernel.org,asu.edu];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-249778-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 75598589483
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the SIOCGIFHWADDR path, tap_ioctl() copies 16 bytes of an
uninitialised on-stack struct sockaddr_storage to userspace via
ifr_hwaddr, but netif_get_mac_address() only writes sa_family and
dev->addr_len (6 for Ethernet) bytes, leaving sa_data[6..13] uninitialised.

Those 8 trailing bytes leak kernel stack contents; SIOCGIFHWADDR on a
macvtap chardev returns kernel .text and direct-map pointers, defeating
KASLR.

Initialise ss at declaration.

Fixes: 3b23a32a6321 ("net: fix dev_ifsioc_locked() race condition")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index b8240737dc51..e1522101b9e4 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -923,7 +923,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 	unsigned int __user *up = argp;
 	unsigned short u;
 	int __user *sp = argp;
-	struct sockaddr_storage ss;
+	struct sockaddr_storage ss = {};
 	int s;
 	int ret;
 
-- 
2.43.0


