Return-Path: <stable+bounces-96148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437D19E0CAB
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 21:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41513B3ACC6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124611DE2A0;
	Mon,  2 Dec 2024 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="cWZhNUld"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F317C7CE
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163718; cv=none; b=gFQjCSLWuOKN9ASeAz6Nd7r9c9mp1a0fUEPCln7EZQre1M2lDRXNY/Qb90TunECKu2RAbgWvxjCmFTY3h9BA6bqyFKQ0z0ob+jhCmdhp13fAiBJPHDb4NrMQ6zq/0f8hsi182dC482oK+fKrV5moBCjzFiZ2uv0q0MSQwE5gzIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163718; c=relaxed/simple;
	bh=Rn8RSyo6St3YsKMOwIjeKXLonnInDGO7TN+trE/MnzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YqrwPB+u5LZLy+GHIzpAmvWC6ogojNmfNs47cJ1w3Afr1hgdWXiKUGY55IiDykz4JUaopT2GMTGsDTTV9174r0KzWiDNhKrMj4f9A9rnDnydLf7MzlAoMD00US+jTtpo1D+09WpVkOZaXCvL2FytHKsLyHQ6lpNf61Yt/pHophA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=cWZhNUld; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so1270135a91.3
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 10:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733163716; x=1733768516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/B0ei9W1+2IGtRTaS0qVmFrCfQ0sKHpMjt98rIqC9A=;
        b=cWZhNUldzNCwb+shckPOP7uT2ESUZVdKYiHR2Nl9ESsED0gUyjoK1qNiISoUG2ajrN
         toG+itnDlsltclRzzLkEO47QapYS0dK3Ez0WWtWO3EhauTMSYDuuyJghWe2IfgC1UKCu
         f4D27Z97rFJPmB53ipfR0z+1logLyLU0hnxuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733163716; x=1733768516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/B0ei9W1+2IGtRTaS0qVmFrCfQ0sKHpMjt98rIqC9A=;
        b=ixj5t+iM06p+viU0zrrNkm9dzjd4ayo53aRQfycJQSdWpnL9ZS0cRRlpqprpw7zEDo
         aP+9jMSVott17IThma6Jnu5MHeH14+rToCfrJyPtF8ru+oxE4XlDDC7POMxXhDe4KA6Z
         UYT7JGq63puoI5BzvU5DdXCCbvHYq0vHazAXA7qDlIAh60V2cK5uVM02PnvUDwPnWVBH
         JAeOjY46nu6mq4hU23ShEm1GN5Zv2P216t9354S1I1WmuRTHnFDr5qJgJYqZE2Jr4tf+
         vI3IKVErzytQ1X6OoAJBpi5S2Z9L8SgtS1hx/SHKAagYx1vkxiwp32eumntvV6kQQkQu
         lMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzei5O/UKL05EyRnoC5ICmEEMmpHOa9PUurdcWw2KqXdjSQRtOwEh2NXZdDyhvH7Dul1FRQjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydUYvx5nIMS3jr1XsEf6GrOiQa2ygj9ZaNzbDB/EYzeU0uQ0CK
	/8quFurygNQscHMg2eAm+MMHGpR5xCDcJZq+iKlgYxXvsMYmpnN2I/VBAhApTgQ=
X-Gm-Gg: ASbGncvGgwRTMlsF8vW87IkQs2diMV0iEWbisR+f9Icpb4niTMM/8pde+1tMdn8JZm4
	GGsjFcDAkcgIQ60/u+JDZKhesaZUq5CbsDUpfC3Myn8LDsVi+hU6YiWl4iBkVnMWXnM/54/Ta2E
	FpNx7g66P5G5mbJNwlccjaAANXwlzkRfFFJtmNNjk+7fD1W2rEo3SVcQgz2HDM8SUTCiyrPjjXW
	HVf0XpdlrJMLd6YPpG1d1qu0r27Qg3IvG7e/iLH78gGmgi3uN1NrnSMeQ==
X-Google-Smtp-Source: AGHT+IG5hA1szOqSgQik4MsxCUTY/OHGOcKWS9WjuBzdQtP1A6LkTbTXItK5kcH9MvJqbQsODhHFHg==
X-Received: by 2002:a17:90b:4d0d:b0:2ea:a25d:3baa with SMTP id 98e67ed59e1d1-2ee08e5bad3mr30665194a91.5.1733163715640;
        Mon, 02 Dec 2024 10:21:55 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eec5eabec6sm2359185a91.34.2024.12.02.10.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 10:21:55 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net] net: Make napi_hash_lock irq safe
Date: Mon,  2 Dec 2024 18:21:02 +0000
Message-Id: <20241202182103.363038-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make napi_hash_lock IRQ safe. It is used during the control path, and is
taken and released in napi_hash_add and napi_hash_del, which will
typically be called by calls to napi_enable and napi_disable.

This change avoids a deadlock in pcnet32 (and other any other drivers
which follow the same pattern):

 CPU 0:
 pcnet32_open
    spin_lock_irqsave(&lp->lock, ...)
      napi_enable
        napi_hash_add <- before this executes, CPU 1 proceeds
          spin_lock(napi_hash_lock)
       [...]
    spin_unlock_irqrestore(&lp->lock, flags);

 CPU 1:
   pcnet32_close
     napi_disable
       napi_hash_del
         spin_lock(napi_hash_lock)
          < INTERRUPT >
            pcnet32_interrupt
              spin_lock(lp->lock) <- DEADLOCK

Changing the napi_hash_lock to be IRQ safe prevents the IRQ from firing
on CPU 1 until napi_hash_lock is released, preventing the deadlock.

Cc: stable@vger.kernel.org
Fixes: 86e25f40aa1e ("net: napi: Add napi_config")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/netdev/85dd4590-ea6b-427d-876a-1d8559c7ad82@roeck-us.net/
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/core/dev.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 13d00fc10f55..45a8c3dd4a64 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6557,18 +6557,22 @@ static void __napi_hash_add_with_id(struct napi_struct *napi,
 static void napi_hash_add_with_id(struct napi_struct *napi,
 				  unsigned int napi_id)
 {
-	spin_lock(&napi_hash_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&napi_hash_lock, flags);
 	WARN_ON_ONCE(napi_by_id(napi_id));
 	__napi_hash_add_with_id(napi, napi_id);
-	spin_unlock(&napi_hash_lock);
+	spin_unlock_irqrestore(&napi_hash_lock, flags);
 }
 
 static void napi_hash_add(struct napi_struct *napi)
 {
+	unsigned long flags;
+
 	if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
 		return;
 
-	spin_lock(&napi_hash_lock);
+	spin_lock_irqsave(&napi_hash_lock, flags);
 
 	/* 0..NR_CPUS range is reserved for sender_cpu use */
 	do {
@@ -6578,7 +6582,7 @@ static void napi_hash_add(struct napi_struct *napi)
 
 	__napi_hash_add_with_id(napi, napi_gen_id);
 
-	spin_unlock(&napi_hash_lock);
+	spin_unlock_irqrestore(&napi_hash_lock, flags);
 }
 
 /* Warning : caller is responsible to make sure rcu grace period
@@ -6586,11 +6590,13 @@ static void napi_hash_add(struct napi_struct *napi)
  */
 static void napi_hash_del(struct napi_struct *napi)
 {
-	spin_lock(&napi_hash_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&napi_hash_lock, flags);
 
 	hlist_del_init_rcu(&napi->napi_hash_node);
 
-	spin_unlock(&napi_hash_lock);
+	spin_unlock_irqrestore(&napi_hash_lock, flags);
 }
 
 static enum hrtimer_restart napi_watchdog(struct hrtimer *timer)
-- 
2.25.1


