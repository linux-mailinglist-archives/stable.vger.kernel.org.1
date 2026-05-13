Return-Path: <stable+bounces-246918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDvtEZOkBGogMQIAu9opvQ
	(envelope-from <stable+bounces-246918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:19:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E546536EF9
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E888D31E8067
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCD5492181;
	Wed, 13 May 2026 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npRkMkoU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138F47D925
	for <stable@vger.kernel.org>; Wed, 13 May 2026 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686505; cv=none; b=e0c8//6syxRzYfp6KkMA8EtE8o5ffUeawmvRfoJiSD8R9R8LUCPKNoHijCatjb0TUX5sLiB2PjM0jrUa7dFZG7Njdc9Tjx9gJ3wkQXiesmvnUBAXWLy2kXv+cgqqOn3vdvR0VsT+4jbfmHuFi2DAYu35US4pVVpeOFPla6kdOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686505; c=relaxed/simple;
	bh=380OIoxziQ8FlKx1mJdOpqZlW6QTVqBF+ru5RUN6Y8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cWueL6Gk8VzIU7sKuUsl0zs6jBM7JK09+jggXhPTRaTwnbWtx/5quGC+xs0DNCgMy17NQUbJk63P2IV/ZsKqI2ag2ID3N7wC+lAtXFIUSzT7BlCTZymj7j/5xt4pQT+3nf/FyynuSeC1dDiUPas1WLmJfjv0gX5BIVL3HuC2KoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npRkMkoU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba21d32776so47202905ad.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686501; x=1779291301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ruAzbMeVdqPrvuygkIYeYyoYSoRcGERUW0xC+xQv0o=;
        b=npRkMkoUGnX70IhNC8M/ofOyKtFVwAiVdmWCIefbzRBhb9ApUHkAZn/LSblKzBFCRA
         wlOTJp3WKEN6cxWpj32fSDOxvmJSFeTaxHXGELTCZkENr8/dsHQWW/BOJoD+RiPc4Wcn
         ZHiMizZfcam6yOMHqJjLkpz1EZFQxJlQNPObFaG3u+1Gc+WXSMhmbCySzPER2zv5gqNz
         0uWCMkz3b/u06VCJzxJY4G4G/nJghKTash9R/knJHy53JLg5TKFtcJ2Hdt+pZs+3b3bZ
         +pv541wOv/ki2bCzgMngHRTw55QDIm5EekSXN0fiV8dWHh5YU5mK2PsXZaii7QyhbjRg
         KZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686501; x=1779291301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ruAzbMeVdqPrvuygkIYeYyoYSoRcGERUW0xC+xQv0o=;
        b=MiLlUNB5CPIbAHhelvGVY92mZydiT6Binxo7/DBRGvUn+lFc1y/yOCfNcN1yxKlk4q
         rGK6sxDnxa9kY+HMNZSqcHDSC3gopT+mhkWGwbO2YUtSRnsMZAjmzImxzwM22AHEwvi5
         cP/blTW/UnjVxc/3BGCn1gynX5uTFhIhSRl0KGuURXp20EGyHbAnb/nP4gxtgYHRK35D
         ali9Hv00LnfbmOCz4GDrZbRuTvCj7zyDuJJ6ZBFwSAWNjolf1xwGe3KAMawSL9Q+eJS7
         gQSZ6N0c0QfpTj5bHR26eqftmpN6Z7EX31LNIKlCz9PXiepuQp3/kI6YvzWILHwTU8gH
         /uIg==
X-Forwarded-Encrypted: i=1; AFNElJ9c7r0T+ANdDwD48HFCJbkzI85d3cXJhwDmdyI2dYFp9CXLztSyQNQ0W5jcE/alK+gAuESRt2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YymkVdIR9SiOn1SJuxePJYuitl7huC8mgMIgckk6A+SiG1Yl5hY
	8rOhWU0M7YN4yItxmJ/F+Qpo5Rj15TIc4c+WtOajqL/u+myxRVC3B7Hg
X-Gm-Gg: Acq92OFubmCAm8sZimyYxyEVO9kDUn9SDRFZcnUOEs62U2yX6m87550Z8gU0CaV6F4Z
	dVMZmbv9Wd+kOoDwqbC+5B1XJopY++0p3sBmoDZl7GlGtE6NgQwwEVqI5sLJZeCM+SjjoMYIWHr
	FrAI1HHxcL3amiqBW+TC7xY4LAT62V2liPhbInYqA4y9fDT0sJGGzaMcV5d9LlNlagAtt7+epVx
	mzXG7yFwLheVQSTzZ6Y2UWav+djLiVH2rZ5DsaLgtTqB9BPSV62WwMtP4Sk2sQsWSG9sV3G9ctG
	JQ1liI0uxwuGfh21aw+D3/PKoBllw4m/hPRQd//kWpMO9IsMiw4IR8KMljvMB7fzS4JRJM/m32r
	xUpB1f8MhsLj6oPHVOlBpzC8tFoOvFNlRYAKLOvMGYpHHjWxsGloAbKnj7SWraAI7s34CS2jSsK
	biV93r7hjJxNecnIyb5aXKa8cBJCKqeAI3kyFdbpCYxLl5NN/DsJItnvqjZwzekg==
X-Received: by 2002:a17:903:f8c:b0:2bd:147d:c712 with SMTP id d9443c01a7336-2bd27133c75mr44261705ad.1.1778686500924;
        Wed, 13 May 2026 08:35:00 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27055sm173821065ad.6.2026.05.13.08.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:34:58 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH wpan] ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit
Date: Wed, 13 May 2026 21:04:12 +0530
Message-Id: <20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E546536EF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-246918-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cambiumnetworks.com:email,cambiumnetworks.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ca8210_test_int_driver_write() and ca8210_test_int_user_read() exchange
a kmalloc'd buffer pointer through a struct kfifo, but pass a literal
'4' as the byte count to kfifo_in()/kfifo_out().

This is correct on 32-bit (pointer = 4 bytes), but on 64-bit only the
low 4 bytes of the 8-byte pointer are written into the FIFO. The reader
then reads back 4 bytes into an 8-byte local pointer variable, leaving
the upper 4 bytes uninitialized stack data. The first dereference of
the reconstructed pointer (fifo_buffer[1]) accesses an arbitrary kernel
address and generally results in an oops.

Use sizeof(fifo_buffer) so the byte count matches pointer width on every
architecture.

The driver has no architecture restriction in Kconfig, so any 64-bit
build with CONFIG_IEEE802154_CA8210_DEBUGFS=y is exposed. Issue has
been latent since the driver was added in 2017 because it is most
commonly deployed on 32-bit MCUs.

Found via a custom Coccinelle semantic patch hunting for short-byte
kfifo I/O on byte-mode kfifos used to shuttle pointers.

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ieee802154/ca8210.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 753215ebc67c..154af346c936 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -597,7 +597,7 @@ static int ca8210_test_int_driver_write(
 	fifo_buffer = kmemdup(buf, len, GFP_KERNEL);
 	if (!fifo_buffer)
 		return -ENOMEM;
-	kfifo_in(&test->up_fifo, &fifo_buffer, 4);
+	kfifo_in(&test->up_fifo, &fifo_buffer, sizeof(fifo_buffer));
 	wake_up_interruptible(&priv->test.readq);
 
 	return 0;
@@ -2541,7 +2541,8 @@ static ssize_t ca8210_test_int_user_read(
 		);
 	}
 
-	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, 4) != 4) {
+	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, sizeof(fifo_buffer))
+	    != sizeof(fifo_buffer)) {
 		dev_err(
 			&priv->spi->dev,
 			"test_interface: Wrong number of elements popped from upstream fifo\n"
-- 
2.25.1


