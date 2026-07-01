Return-Path: <stable+bounces-270215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IOmJHMxHRWoA+AoAu9opvQ
	(envelope-from <stable+bounces-270215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 19:01:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DFD6F0182
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 19:00:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZSTGIew2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270215-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270215-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C468D30265D0
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A55236CE1E;
	Wed,  1 Jul 2026 16:42:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B765C375F81
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 16:42:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924152; cv=none; b=X8psNZQUOqUC13mevBz1eDxw/+IASzXvjbEvkQYHjmL4HiSkVcFv1z6oGI5IX94imsqQi8hw8F38wjvbl08n4IoHbJZ5qjC8pf1yMitwCijqZZQ+7bvccnoCJwEfozWS0H+byhtWBLoBaZH+8t1XXA+du8ynqnGN1png1myzLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924152; c=relaxed/simple;
	bh=d9ZiF7LjaiiY1OZofmWsgVZV2t94SKMbzoBzxGqUi88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBfrAaemc8p9ioTs95z99TgTRRMsSOJIIWPz75gtyuoBklCi7UJGBVLGqIYIK+/sPjwH0aCTdUlWmmtwQ12XmjOeRhHQzknlZBZX+CFXOrDjNe0IkNfqhvgVhd/24wzNj94K4wjqmfIQOEDjLY4lu1oE/9zpIKQBhYD/AJvDv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSTGIew2; arc=none smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80e4455b9a3so12876717b3.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782924150; x=1783528950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUTIvVd7hXVFaVubObi/HnQ0CBjtLgoeqk9bLxy6OA4=;
        b=ZSTGIew275uqpmk0BEhIxaJsx7WtTwHZ7Ty+OwzZBbP0Bm6R4kc9d3qmUMdEDjP8s8
         5BuliDbXsffYVavapIaqoFTq72zweZw9RDwzH+ijFoU9ndBjQIxdNBemMlxCQwkfKrdn
         f3AxrXsqMm9Di0mT56nKEv/zm/yTy1e8tYeTxVx2T9xwRwvPtjehnJL4g0FiRVpC2Siq
         hlbGhxm39ETzbZxQIOIRYBXHXVGsGaMlOiUI+0x5094PQGAUReqqe0vnkgUyHZWKI1jx
         ApLlTLguAApRmNvyVz48bEpY3oBWQH6Lr9RAxGqPwmbyf48f3xVOn8bQERxcWFF3+yCm
         aS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782924150; x=1783528950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUTIvVd7hXVFaVubObi/HnQ0CBjtLgoeqk9bLxy6OA4=;
        b=ewQZdjWywtzb8w5Zmv1BEQUkF18PdUnOAdizGGwixT43B1EPuo/pJnVprIoeYJJhSg
         gOfHfTk+BY18A5Spvfm/SPlhA6/k73WSwk48O/INm/ucN2WX6WCh7b3wveut/P4KsLVE
         Rch3RBXlSGIU+2ISZjRk9OxaJI1zlk12Q+G/TUdctzJ/Q0+jlHRyQCex4DurZnBbOCmV
         V3b410GPNQPExeTMW1sxfNVrWPEWtj8t4yF+W6vO6rjZiWeQKqTwzu/nwTzU/M+g/y+f
         OpralAlQxo4DmmQ/S3a0+kv3u5sWGKetfdUEO0aMT1olAagWKu7lWvrJF+dxfbCThYiL
         c6jw==
X-Forwarded-Encrypted: i=1; AHgh+Rrt59w+3xI/g3J1emeZI2HESNVHFMRbFYVpA4I8gmjvNuxMbUI6GE72JZtz6+YwEczqt1vdPVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ssf5srOKNyx2WaAZAHoaXS3YRcktYIcFe7D2/FZ3oCnUulKI
	MudjICk+KmTUWVcOfb7Aa13SqbnDa4ouLuMStNjlEXyumdkUTezhS9ls
X-Gm-Gg: AfdE7ck7djMpOgFzbkIGZz49d/3u2dbCxA3ctF9UAjDjrNd9IgREovEl1VcXb8z+8xV
	FiPKiJGMj+xr0XfHiYWmSSqtdY6g7j8GIshcwi33Tmy9CQ/DGx0Ta77TfGHoM94beoHtR0p+feQ
	N8WTFdG5tRv0TRgKcVYlmIMOm96enBMkxxjBeOa5SL8pSn7WXJsr1worKclBYIkSeHmgHfAXSCJ
	z+GAySOf+g3cqz5dYH6KQp9vKdXX77zIceXpSxgM7hvVj2cPa29JVgbucLPU/I8iP5P1Zge7EfF
	BHlz917RYaRYxS/25ZjHknUzvqQxHBNq5/V9Rg2ugD7+F3rMjqS++YZVCIDUeVl/k0e2gu6o9HK
	/HQFS4ItTCt8V3PDAC+p58q1HV7G51lWHNdY2PLCK1Cd2qHPy21qPtgBpuZW4s1m+Tz/xyp8n09
	PvwRgiPYtvNtP8ChlkB8hzMBiOAA==
X-Received: by 2002:a05:690c:734a:b0:80c:85c6:8987 with SMTP id 00721157ae682-8138b95e350mr17913177b3.70.1782924149728;
        Wed, 01 Jul 2026 09:42:29 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81448cd06a1sm2213857b3.21.2026.07.01.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:42:29 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	marcel@holtmann.org,
	kuniyu@google.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH net v2] mac802154: remove interfaces with RCU list deletion
Date: Wed,  1 Jul 2026 18:42:22 +0200
Message-ID: <20260701164222.9094-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260630211808.50440-1-alhouseenyousef@gmail.com>
References: <20260630211808.50440-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270215-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:alex.aring@gmail.com,m:stefan@datenfreihafen.org,m:miquel.raynal@bootlin.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:marcel@holtmann.org,m:kuniyu@google.com,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:alexaring@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,holtmann.org,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,36256deb69a588e9290e];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63DFD6F0182

Queue wake, stop, and disable paths walk local->interfaces under RCU.
The bulk hardware teardown path removes entries with list_del(), so an
asynchronous transmit completion can follow a poisoned list node in
ieee802154_wake_queue().

Use list_del_rcu() as in the single-interface removal path. The following
unregister_netdevice() waits for in-flight RCU readers before freeing the
netdevice, so no separate grace-period wait is needed.

Fixes: 592dfbfc72f5 ("mac820154: move interface unregistration into iface")
Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=36256deb69a588e9290e
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Drop the redundant synchronize_rcu() noted by Kuniyuki Iwashima.
- Clarify that unregister_netdevice() supplies the required RCU wait.
- Narrow the subject and commit message to the list deletion bug.

 net/mac802154/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 000be60d9580..b823720630e7 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -703,7 +703,7 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
-		list_del(&sdata->list);
+		list_del_rcu(&sdata->list);
 
 		unregister_netdevice(sdata->dev);
 	}
-- 
2.55.0

