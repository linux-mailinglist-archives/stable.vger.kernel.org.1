Return-Path: <stable+bounces-100294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D29EA78B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 06:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B091F16690A
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 05:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F396226190;
	Tue, 10 Dec 2024 05:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3bNebKT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF2226182;
	Tue, 10 Dec 2024 05:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733807214; cv=none; b=aL8htE1BoW6VXYXoQqlw5fG6JlP0eYoKvmtHJSaBXipa88UfUMqWMnq90ViN3FYS/Uc73fPP3P+emlbKpDvDBZuENK93GLQLKXbmbW2nAY46M6kQK9walJu4v3I3SV3W9xw8IMu3DY7Z2tnXezXQamwuo4yEDWj7ptPDrOH07Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733807214; c=relaxed/simple;
	bh=bnkUahMoe/2DYRbSBWm5xIriVjrHBkBhabIvxjeBeXA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ucByQEXKB/UKUacak6fwZ1cbzIBBCDmHGEAhzfDIqCibSwOwwz2GdYSrUOu9RneNCiLMSJWaC8+lfY3k74SQ8CPmcvBUU5nqh5FkqlyOpnNQKxqRzHoLH6ZIV3qHyJ7evyGHU6dMQ27nNcCfV9k3r505SdyVQHuJKrP9WsfiioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3bNebKT; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2efded08c79so90467a91.0;
        Mon, 09 Dec 2024 21:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733807212; x=1734412012; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dydebYrUiZDY1lQnbppwxvbgV+WzSwhPfcXyLsgRJsI=;
        b=H3bNebKTu4UJw0mxGKE93DJAMnx5pU9vtdRk+zwzv5gcH7V/UzAlK62YUpiCNUNkNp
         sb3Uc3fLKQO3GC0qkL+DHsf4+agUtFQZbeh5+HkINIrfXPAIVU0CgURbDaSExltyp6tR
         U9As3OQdSZ8WZMwx6P2/sHOIwLejQinyoS8jjyLvYBDO7pUAhjiQTqrRLz/+C5fSTgfZ
         s+pZYEgNwoJ595ujsOXHnbQnMgx8vwcYzSe8WkXivrQPY9Dg+Msikh6neRIdaWsMLjyy
         pPeo8eUtDjaQrPIFJN6lC6LyV3u1L93iDLNxwsBDAgRS4aZwGziGzTaePEH+ULfQWol7
         mRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733807212; x=1734412012;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dydebYrUiZDY1lQnbppwxvbgV+WzSwhPfcXyLsgRJsI=;
        b=gQQi3q5+5JszzFzA5X9lSf0O0tqQNmWKf1qKSCwxP+Yt0EOrhh1fRiQED9mz2i+dmE
         lJ59FB6+Lc6W818XuvXkmdeTZfbRJg8N7jQGwEpvucA0U5Vf4ek+bVpa3VcyFZU1Er1w
         FRCX3DFAsXzYKFmb3ZQxMzHyQUzaSHXKlZ+VUONEWzWHE72BP7oTk3wdDC3yF6eOpUpj
         oErPcwhIUH4oOadyXAkXxrhxZHu6i2E3ud405oUkpRO82MOTvgDdwDc7WNCzTnjBlZ8S
         h1/9BPu/kA5G54cPQbMTuSikQ08TcVxk0v02pCER34qLDWlS6jJBvMViumrUyh+sOEmv
         cm7A==
X-Forwarded-Encrypted: i=1; AJvYcCUufS8AZ2IDWA0Q0h5vlU1rUVmaooeM7ThUEiAOyBXDDf8Yucwwvsv7Fg8l/y1r8FvE7gMyRBDR@vger.kernel.org, AJvYcCWkCr7YyggkSZV2yx1dQSI7RT/EisETiks+osoBFFk/EyPmkVAqotn7LMEzfMMv1YItXXZvETv3aOiwOJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy83uwEs4rxNDhs5t8yNmubVEmjAQoQ91ZCzKhgr1bOzCTNnWc
	oYh88wfM4JrI3W7GurVXGSKySqr3maNBq4mMp5mToYGHP8eIvfQq9mlY3hka
X-Gm-Gg: ASbGncsuNBGPzywFxNzKnkED4CbWnGHSZjLz7bQcJ120p3YOI4z/Gf2HyztmG/gIW3z
	xbP1LYOH+4i6ILE1iRKN+J/zRlFhHBn0sU+eEWhHUj0/6xsODIjJXNvSq9FpZQHeI/7cSe8Aea2
	GmnEwKnFFyjl9pTvdFWYiu4ux/+VqfhbqTjZRSmQtPQWBTYXhKRdA/cn+yXDgdxepjLMng2sxnw
	Z6B61IYz8j/Hdb73Wy37KVfKdRUqg3RDn7nYhBsTobkqG+6ihurNaDv/gt/0liu7lWagKcAt0wP
	tM56TXB0VRp8
X-Google-Smtp-Source: AGHT+IEAORtju9S5h0kVI3znrOXeKH7w2rA5o0agZXRBE+GxLm5nxeAEr6Xzme+30l7AGcejo40jGQ==
X-Received: by 2002:a17:90b:46:b0:2ee:df8b:684 with SMTP id 98e67ed59e1d1-2efcef21b5dmr5313424a91.0.1733807212157;
        Mon, 09 Dec 2024 21:06:52 -0800 (PST)
Received: from xiberoa (c-76-103-20-67.hsd1.ca.comcast.net. [76.103.20.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd55a9a5edsm1524182a12.55.2024.12.09.21.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 21:06:51 -0800 (PST)
Date: Mon, 9 Dec 2024 21:06:48 -0800
From: Frederik Deweerdt <deweerdt.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Frederik Deweerdt <deweerdt.lkml@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Michal Luczaj <mhal@rbox.co>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	xiyou.wangcong@gmail.com, David.Laight@ACULAB.COM,
	jdamato@fastly.com, stable@vger.kernel.org
Subject: [PATCH v2 net] splice: do not checksum AF_UNIX sockets
Message-ID: <Z1fMaHkRf8cfubuE@xiberoa>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When `skb_splice_from_iter` was introduced, it inadvertently added
checksumming for AF_UNIX sockets. This resulted in significant
slowdowns, for example when using sendfile over unix sockets.

Using the test code in [1] in my test setup (2G single core qemu),
the client receives a 1000M file in:
- without the patch: 1482ms (+/- 36ms)
- with the patch: 652.5ms (+/- 22.9ms)

This commit addresses the issue by marking checksumming as unnecessary in
`unix_stream_sendmsg`

Cc: stable@vger.kernel.org
Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff for MSG_SPLICE_PAGES")
---
 net/unix/af_unix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 001ccc55ef0f..6b1762300443 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2313,6 +2313,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		fds_sent = true;
 
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
 						   sk->sk_allocation);
 			if (err < 0) {
-- 
2.44.1


