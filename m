Return-Path: <stable+bounces-253949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPkRF7W/EWoNpgYAu9opvQ
	(envelope-from <stable+bounces-253949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:54:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3725BF7B0
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C892B3024137
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3372B184;
	Sat, 23 May 2026 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUQod8IG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79F1E8826
	for <stable@vger.kernel.org>; Sat, 23 May 2026 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548018; cv=none; b=SgnZkFpJk7u3xDV58RZKjfH5qRqfDsAVo5yZA9mW6jn1ZCUtuyh1jxhpT+EarQLPFpk3UK+IYs132+ux/5lKlebP06H2TbnnsAN/t/K6sZ/Qn0neL6gkpWQVu7KvQqFpIhG0w/D6meP7MVCXrAhu3XxGNyBZL5QBb7AJQmXeqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548018; c=relaxed/simple;
	bh=yyyr4Ie6lPu+jIbRXSP0Mil/Vfh89VQwXsVF98DJms4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dbtXBFxOeR9K0s6X/ysJnzcA9eSQ6m31yqY4NtVTni4Bc7bqlbqu+cJCXYutBaAG+BL39Mez4dsk5jfYechSW3kFs4j9+E4Bxxl5v6dVE7O8R1VSYyi2sdzZn3qr7a1HktIKKgcneEKdziZBd8oBGBePwz8BjvsXXHnBiGoPoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUQod8IG; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8025500cc7so6258423a12.1
        for <stable@vger.kernel.org>; Sat, 23 May 2026 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779548015; x=1780152815; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dqryLwyecP7XdFRP1fnNAzkgGZpfDJiUeUJsd1fBfx0=;
        b=lUQod8IGEOUGlco2J64NEi5RYJ7nrN58yUbUNg1hRHyNsc0UmACG3lOXGaMGDBhMVi
         KRDZgCfChV0vV1ha4GoOF/hyGwJ7ANpsxtloWbLNInwFboGeYZK8jIgyeHU3ZBZEoJII
         LDSvwSf490Q0XUHQtrPxCRrb4mNmB2KfxEJgK9mJ5JTrOTdkr1ej5BMk8iV8z7I6aBdf
         58Yv7dfs9/z1asCB9KYFq5J5pZyG2dXdBI7gHDkkbm9aEeTAejUfuzsWTpG4fszslRFX
         QKd0naNzoBoe7b9q1JLvOeWQ+pjk6lf7DxJi/m5S80kbTRjwuFxnDI8LjeyMhPbmeZsQ
         LrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779548015; x=1780152815;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqryLwyecP7XdFRP1fnNAzkgGZpfDJiUeUJsd1fBfx0=;
        b=luE7SpUi/zWuqDJ3F8hXNUEdAEbZUvf9+qx/5R45Bbd3LtakLY36X0/DZWW8bmUXh0
         IYdbo5EdsYBhcGn8eMpeORloXkG3jruwqAgU0kyURMPQHH68uVMyMXxBN1nH1fJEO7eR
         Ri3M+VDi4RjY7i7IBHiIZ4GcPKAWa6UWX3jaBhnLZpNd57ucBJVnxq3KKbJuw1zr+F+9
         uElNEor1smL/ucqZj6qQlf5r/7SxmZareS4Q5geqbjdjOsQsWkBxFvl/9ZYjc2TK9UgS
         N7WRtu3zOI1+ld/3XZgu/9TmgvwBQJRDN+MSsN7udazKG7UMjBFOxFlKH8yi8C3SA0E9
         WjgA==
X-Forwarded-Encrypted: i=1; AFNElJ8DouWwQYEApCeJBfaotEo/w2LA029NuzNZldDvJQHBCfB4e8pDLBTChlMuGlq0oohs165UxGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhqwPQugpofwZWNPfK/LF5Ec1pqbDbN/j3iiqQka+FRoRO2MGA
	OO3OUHsAIxWNnVNWx6vqSqlbTrmuaZpW9BOE7vi5CYLZlCY8m1qtJLwR
X-Gm-Gg: Acq92OF6P7al4G6IeJB0h/FHZhHybTuEaOlI+Hxz0FKw2qHpGHxtwaL03vyiZnOKYyX
	8/uRvsCaau5pg2I7JHIsheeIFyKA1MdMSj/U+UdBUy3WOy8YX+jio2qhUBW3tqNLSlzhY2NIJd9
	ULiez1WVJS0JXE5HwzZ4iMdhhDRIJBdO8ELu1d4Va/s2ipQjg0ortx1eLqLOxt1yD+3W6cJOQMM
	Iou1/LQnkLVdlk9pm12VZXnRduve2aVtFBl2waBcWguKt8jph7XXzPJBdsvO3dy9gm9zxlWEyb2
	/yQIkhLQqYDYzLT7cQ56C4lX/Dyncj9UED129pcTwcuyjokK3QXfdIstWpbichjDgqVRzuHgm10
	XdodKbY0NEsH8eeftkNWMGSHQV6m3NcE21pOcYtkCbhgaAEJXDuojkQnQoKgUNIi5WB5EWljPrN
	37q61TqSLZSOnMBaz5nP0Dn3/SgxZX2atvKHrBKrlOeG1t6aK3sYAAuRqUnbZzAytQ65DFtgGIg
	YIrwZI82iUnWC3UDIiJ234SxwI4hu5L2A==
X-Received: by 2002:a05:6a21:b8a:b0:398:6ea8:21d8 with SMTP id adf61e73a8af0-3b328cabaa7mr7949186637.15.1779548014578;
        Sat, 23 May 2026 07:53:34 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([103.129.134.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202902a6sm3974345a12.3.2026.05.23.07.53.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 May 2026 07:53:34 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Antonio Quartulli <antonio@openvpn.net>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH net] ovpn: hold peer before scheduling keepalive work
Date: Sat, 23 May 2026 20:38:27 +0545
Message-ID: <177954800752.73238.12097994883239164708@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253949-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuvampandey1@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BA3725BF7B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 drivers/net/ovpn/peer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a09d61296..4e6cd2b69 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1285,8 +1285,10 @@ static time64_t ovpn_peer_keepalive_work_single(struct=
 ovpn_peer *peer,
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
=20
 	if (next_run1 < next_run2)

--=20
2.50.1

