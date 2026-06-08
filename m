Return-Path: <stable+bounces-262052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PFySIZDzJmpeogIAu9opvQ
	(envelope-from <stable+bounces-262052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 18:53:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE730658F37
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 18:53:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openvpn.net header.s=google header.b=IJyHuCQj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262052-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262052-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=openvpn.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B8E0336B015
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B0A34DCE4;
	Mon,  8 Jun 2026 15:08:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0193314D2
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 15:07:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931280; cv=none; b=KMwNZ6M+sbLdz6liCeXRmI2P9aNuUxWslTy4CFrhMf3VTr/k08HdoCCtlldWuvVfE/cMOLJ1W0iNLEFQwoqaCYwjJFJ9OY4jFhNFWvj29iHHpzdLokRzKMh6boMSrhJD3edZ587wbqkBvmiSi37N012C8CxwZWgyQ9NR7cXCEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931280; c=relaxed/simple;
	bh=xmfoKUNR8so5IaktR9IqC45idfyPgZdeFtFlKzOF5zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzRpQkr6i62YQn8zbNNojj7WLXySSPeFeTN9sIHs8oSq0SYcn4sL8OqISxZsmQCYRlz6ERkAmhk7TYKGCSK29Jo34zcL4s72gbbmtK5xiSzVGscEqwUi9xGiICKi5yIyVrqnruqg1FAOWE2eMU3mUUy5U7pgf02dsHk5tlstqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IJyHuCQj; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so48660535e9.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1780931278; x=1781536078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDzbekQ+Dqd1pdxBTtdax0VXtGGOz7Q6ZLK3fDZEuRI=;
        b=IJyHuCQjSau8fTkd17vxDbEknSt0kF3IQRSDZ3kyN4lbenewiWJmEmChJ8vNReHChj
         DZ5funCwgBleymKsvCnsvNGFI7GbAkeU66RSYRlhgWWTVYHe0ra4CIs2MnMdGfwmFGoH
         5fdhoJsk72LR9K0xNlhlbQm4ggqzPKnWjYdn/ikGTMu3RCn6Zv74Bg+amdnB4HOQGPrb
         r7/N1MwaJGYuHafnOeWNYtKWEdySBKVovHaQEcwZCD5bXKaXhlYYRypvCbVA0zGtpCVx
         hMr0GhH6mtg+6rzY/YTzCXXsSxl3er0+i8kOZyXgl7Ow8bHzh/bTdA7vPESfKXOj3G1R
         /H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931278; x=1781536078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDzbekQ+Dqd1pdxBTtdax0VXtGGOz7Q6ZLK3fDZEuRI=;
        b=HfZLtj1zFhnL55X/EOrfHC3lylT/uhD2RdRDhktwAnDu8ArtfNUTe5frOK7wFEe8Cv
         KJ3ljEae76+rFlZw56wBouGyPMdf7B0GfLowRyRDQ8DrL88nmYSilDgmrYBUndW4hGJM
         WBucaIoZ/q7JGL+f/gGAq/4AyLrQRlMMOzyJdxskzXwpafeZAV8qot3A6fzAe/i5HNUE
         2rb4mtIM8NAiApqlZjJmpac3JL7Qvo3ZHSQbQUdtncB8EXAt6SUiZcuAzh57kgShs7/L
         d2KnLYHAG0qgGHSYElPSfnJ3cT/ARm//wD9R8HIP2ysC7OOrbpcW66HyNxY62Mm6uDJI
         wKsQ==
X-Forwarded-Encrypted: i=1; AFNElJ99z9NalEXlsQPsvE2e2HRz0GA8T9b8HV4A/IlLemwCNBB0fZVAfYFNC4QYnQ2KQfCRKjd2lts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmpik1G/k9UZmyCliZptgak1WODldaT0lWXJ+qir8GTAwEILUl
	gzBPnvGgYlA/q2cenCvHaw49AMXzLP50vOWOK3a8ZiWeKaBQGSaMUVYiJeXzfLdL2ANV7N9aQX9
	9SZMsr3SMX9dXlxjcDkkE+fHt6zZELrPuR2XIP0xK+e37kSNoBqo=
X-Gm-Gg: Acq92OHuK9vrwiriuQ4blqzqSbGsg02RvmjEM6vI1wZevCclWW4sOKkCCs84WNp+Afw
	h0LliPa8swOAAOkKeXGRscpqw8xUUPu4ltLGuqSCqb71bmbMGqf+OHamVJBS0UWHvLjyplchMKv
	KycKdot10a5LKiq0IDSc3OxbltK8jvwbM3giIdcYM6mTo+xPVpNGZVHVURWpmmiVC18Ul5Z5EyS
	Ba3PZUSXah1YwcTWXHCRvYIF0DzA3QXQCrDL72dhjmGE/ENtyUL0JuJSZVIj6YQtR3zQN0WyzG8
	9frA90xOiu+VlF3s03rAyQKAfZdniLC69HxoP1IWVEyhbThXBmuoxG2URlEdz5BsN3BEvsmahcI
	+MNmu9OOVJ651mDI50NvAITQxwSEEomfYnyinK+2erbBoFQWFfZdY9IFXvRyfuW/8G8jHga3Ldf
	2j+6wBykfpvE/R2g3Bd9hGSbbhnHNWwInQR0wSJQ4pHudf52tM/9Kp29+krGIuiELFuK+0
X-Received: by 2002:a05:600c:3515:b0:490:b5d0:598e with SMTP id 5b1f17b1804b1-490c2604783mr249096285e9.21.1780931277859;
        Mon, 08 Jun 2026 08:07:57 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:7e36:aaf2:5280:7b3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm390659705e9.5.2026.06.08.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:07:57 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Shuvam Pandey <shuvampandey1@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/6] ovpn: hold peer before scheduling keepalive work
Date: Mon,  8 Jun 2026 17:07:34 +0200
Message-ID: <20260608150741.3320919-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608150741.3320919-1-antonio@openvpn.net>
References: <20260608150741.3320919-1-antonio@openvpn.net>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,mandelbit.com,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262052-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[antonio@openvpn.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:shuvampandey1@gmail.com,m:sd@queasysnail.net,m:ralf@mandelbit.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE730658F37

From: Shuvam Pandey <shuvampandey1@gmail.com>

ovpn_peer_keepalive_send() passes its peer reference to
ovpn_xmit_special(), which ultimately drops it. The keepalive scheduler
currently queues the work first and takes the reference only after
schedule_work() reports that the work was queued.

Once schedule_work() queues the item, another CPU may run the worker
before the caller gets to ovpn_peer_hold(). In that case the worker can
consume a reference that was not acquired for it, corrupting the peer
lifetime accounting.

Take the peer reference before queueing the work and drop it again when
the work was already pending.

Fixes: 3ecfd9349f40 ("ovpn: implement keepalive mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/ovpn/peer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 1844d97154ce..2b6096d8b1cc 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1284,8 +1284,10 @@ static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
 		netdev_dbg(peer->ovpn->dev,
 			   "sending keepalive to peer %u\n",
 			   peer->id);
-		if (schedule_work(&peer->keepalive_work))
-			ovpn_peer_hold(peer);
+		if (WARN_ON(!ovpn_peer_hold(peer)))
+			return 0;
+		if (!schedule_work(&peer->keepalive_work))
+			ovpn_peer_put(peer);
 	}
 
 	if (next_run1 < next_run2)
-- 
2.53.0


