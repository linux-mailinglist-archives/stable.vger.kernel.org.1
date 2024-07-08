Return-Path: <stable+bounces-58243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDF392A8DB
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 20:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A2B1F2222F
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179B14C581;
	Mon,  8 Jul 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="MAmAPM5Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f227.google.com (mail-lj1-f227.google.com [209.85.208.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24D146A63
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462561; cv=none; b=svRqBl4g7PeWUDlg6wz6tUPUJwbLdDMOlcXDNzoSg8HROo+UXafmoXmUxfXaWbqnaCF9b+sVIoJ7bT43U3MHzrKbwruYOoWtsMY+QFqkNVkk6fwIu7YUQANZUNtcPUwD3JASLxxFtRoDHwXP3asSlu5KFT4ziJLrgNC6wqV9o2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462561; c=relaxed/simple;
	bh=zQwyXlH5ZVF5TCm9+O1XVJlW7UMrvHWYI4dVKxhljRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpL+J8Weo7lstakKBZr4X8A6S6rTH+sYm3yVi87ipwqynzehlwD/BLaYgmYiCNlwcQl9FGvgnH1zBUlyxYOssydxMmpdr3lz+d6XobUUTecjczaHhCyQztTOtyvlR7vaEmvivpRhl5x0LTDn5O+QHQejzxKd1KRu2KmaVHP3cJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=MAmAPM5Q; arc=none smtp.client-ip=209.85.208.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f227.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so21853041fa.1
        for <stable@vger.kernel.org>; Mon, 08 Jul 2024 11:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720462557; x=1721067357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV6Uuuc+7CMJHWF96ycy0YXjsqaz4AJvsOhj3qX4WxM=;
        b=MAmAPM5QfEHe9avUBi6+goCNXPKYf+5BVDkj21WpxGXT6HaRQuNdIHDfGCtkS4LNMr
         eaUBrXkiwr7B4BbKBtpIxL6fCyBQuKDyXKbZ0VY7A3J3Lbtrz8TS9lUqAbGIHpC/q4Yx
         vugI2d/YFTIcoRjZmUbXVtnDma4NB2c5x585OQZhpi7efTyncH5zTTbIjyTESa4lgHPq
         KnIqk5QIuXGR5HgSOWxJC3zJRNn9erSGL4+wYrMS0dNpoe9UBuw4ss4jgxtGfNMpteFf
         3TWr5SAywOgtvQWBjFKVPOvTCBqUXlUKm9jgtH8XzuzrfN+RWBQAz4W8AWh6aVChYMFR
         IV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462557; x=1721067357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV6Uuuc+7CMJHWF96ycy0YXjsqaz4AJvsOhj3qX4WxM=;
        b=uYMTxYTK20/KZ7npWwgbkbBVJLCBm8cPkxWANgRVIrRr1YaMJC5SzupKs/YrapwX6A
         6dKNmYFUIY4IogqbcYg7MNuG2Py8NC1CuISHF/tT5LsG/XGtHLs2KO2babybtJxXDuD6
         V8PXHXv/WHedSUqm5Z+mbh+H+DidqwJDYpVw6nBCHUvNk+vzIK2W4Qf88G7Pc8LIrlzR
         mcyt+hhnDKOwvy9ZNE6BZH3xUF3fm0O9ZnedE542CVn8vt3sJjcISZk15o65OQI263EE
         kGrTvlxf73mrKHzK9ufuWAn3es/QOGmNTFqdBoWzjC+K7oXuw3bPUB1E+y6O8shyt9mk
         sWTw==
X-Forwarded-Encrypted: i=1; AJvYcCU1/24JyfYaRCOCj5AJWGqiIbrwGgFUbhYwPAsoyTOpKmP+a2i5rn7JxBKItYMyMg4PXn2DiN5GVRJ76t6qu777nnnTLtrW
X-Gm-Message-State: AOJu0Yy+tFPDrVLT1WbEnk2n+d5LXojSNSsuL7gUqJyKogzXxBp2FbHf
	afWlgGRBDlVXYMCtFL9Gn5zEbsEuLQZGi1qTKzkw9Ifgc1Rqe+38YB76S0eI5AiWHN54Q+XXStN
	lGn+NpHJUvXiEVey7/SqPYcWDO03+UkUv
X-Google-Smtp-Source: AGHT+IF64yl9851lVilnVXaQ+AdD7M4I2+bnbnXS9xoAOv5flEQNX8j2ts7iI74lanVnsU5A9aw4NR3O9yhI
X-Received: by 2002:a2e:3306:0:b0:2ee:8454:1c25 with SMTP id 38308e7fff4ca-2eeb316b020mr3937671fa.34.1720462556722;
        Mon, 08 Jul 2024 11:15:56 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 38308e7fff4ca-2eeb342d71dsm49451fa.20.2024.07.08.11.15.56;
        Mon, 08 Jul 2024 11:15:56 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 21AC760310;
	Mon,  8 Jul 2024 20:15:56 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sQsu3-00HP8v-PE; Mon, 08 Jul 2024 20:15:55 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/4] ipv4: fix source address selection with route leak
Date: Mon,  8 Jul 2024 20:15:07 +0200
Message-ID: <20240708181554.4134673-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
References: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, an address assigned to the output interface is selected when
the source address is not specified. This is problematic when a route,
configured in a vrf, uses an interface from another vrf (aka route leak).
The original vrf does not own the selected source address.

Let's add a check against the output interface and call the appropriate
function to select the source address.

CC: stable@vger.kernel.org
Fixes: 8cbb512c923d ("net: Add source address lookup op for VRF")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/ipv4/fib_semantics.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f669da98d11d..8956026bc0a2 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2270,6 +2270,15 @@ void fib_select_path(struct net *net, struct fib_result *res,
 		fib_select_default(fl4, res);
 
 check_saddr:
-	if (!fl4->saddr)
-		fl4->saddr = fib_result_prefsrc(net, res);
+	if (!fl4->saddr) {
+		struct net_device *l3mdev;
+
+		l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);
+
+		if (!l3mdev ||
+		    l3mdev_master_dev_rcu(FIB_RES_DEV(*res)) == l3mdev)
+			fl4->saddr = fib_result_prefsrc(net, res);
+		else
+			fl4->saddr = inet_select_addr(l3mdev, 0, RT_SCOPE_LINK);
+	}
 }
-- 
2.43.1


