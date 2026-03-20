Return-Path: <stable+bounces-227447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH4qOKb3vGlW5AIAu9opvQ
	(envelope-from <stable+bounces-227447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:30:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A482D6A0C
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A55C83026A89
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116E22EBDDE;
	Fri, 20 Mar 2026 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6me9896"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3127FD51
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991832; cv=none; b=hHoWUbt+V9Fu+ZXfXyGnxJ6nIRyUwtU/P9ArrnKLPtbpAjWGbLaKPMJAqCa2GPVJoAyo4BW3ioOfU/yajYOsIo7Yw2ZSH4NxaIWym1s/RjgszlKjO1saet/xdaoWYMXWHhjembwIZ/MAm3HKfmvDEIzBUmHewUIqxLTMdINqb4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991832; c=relaxed/simple;
	bh=VmTtvLpeKQO5Y2kiwXZpXHqc0rLQnZxDq9Sen3bILZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YaN5xJ1hK6sFJvnzTBQdEioQrX8k+bGEjd1HgtGcFLrDQqqjgSwaYhEnVuc+11wb+On3eW2nX3TaBFcP6OR25G9AtcS/1b2lJqUSF/c3KUv2h0M9Q/9lo5otAq1MRXeie7BRfaGnVH1WUgT8+uESeiOrwiusqpG2cMgN9oE57EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6me9896; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82985f42664so1235194b3a.0
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 00:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773991831; x=1774596631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EKZSuB/AoQE2+nK92YoyDWIhnKbiEvomcgy+9ah15Q=;
        b=g6me9896UWPSPFiIf1CodM1k7Px49E4WYJI/eavSilMk9yn07ryJHlYpvF6fd/sGsh
         62rMKutxyO+OktntwWtAQPS4XBOAFzv/wgYWQH7eDn0DPIeDRb4krJQOU4dxXv+LEiOG
         FpWc9mYy85JYzB4c+Dxp0LJ5fhBHOP8Fh1CZkFp/VS2qW/pJNUZZeWK1j708MQ+QLlu2
         uHVgQpQWGJ+AR0K/eoaT1NYrIO0S0puCdMo9Mbq8RAiAZlol+Ewl6pg1sz7REI7oLB+g
         2zOnuiA+QODGVR/ucCAY8ZUUH7TgYOhRrv0LpJxJ+sifICSDWpeNMR97w6tfAMaQGXCX
         uuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773991831; x=1774596631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EKZSuB/AoQE2+nK92YoyDWIhnKbiEvomcgy+9ah15Q=;
        b=LYJN5yT8HXIJXAiQofbBVzuwzneoMIX3WI27EM0raIWAvGGoEsa5pNpscQhJ5Zfool
         8FWloJaGLBxmZHp2zvGf2Tdb52moXkhFIbgJ5rUcGmWfdiX9KB9jwOjgJisONWegkYEg
         cOVh+Np2ZHCH7gY14TYtRryWKdkhdiXk+OoGZJADccN/jWvUg/t6+5sO+uHXFUXedU1u
         P8qf2iIlUFr6iPI1V9hXAD7l+8Mu/EeVYJfLRUdDaADg9iWaJQjTvLpQL790gxXLOTkX
         del0+EqZ+Bs2tzmy03h/y6MFFjIHf4nUNH2pkjhA+4gVJctTwpkfebYQlGxPi3Lj+k1b
         vWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9DggUzKiB6DiU9Y0L+0UWiJHOqd9rBc4TfGKnnDBkvbjv1g2TsayaNfml47Fv9EzWnPz+0Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5AQ15nfSYliZBRawYXIImZQD+7rXFX0dcjiayRzYH8tLgIKt
	O7olPvLXXl3VtS0otbLYf3ESIDHsTmcm1qKeMBO7qSM0cYFMxQJxmoZMHgYjkI6kqFU=
X-Gm-Gg: ATEYQzxm+DwhlXqWOH45I4d/xx4he1gqRANyvNGvNSwl/py7QR08F/ugBVQeQmeJUfO
	YgiyKQGF9VLwIIJrQogBZR5Hw6eO5bOpJM04PwemUibg2qSSCi2yIiffgjqhl+zGir9tIPKsQt/
	Mb114BZHnUtwFPfzy51YdTBNBCc10wVxAn/T0o0kpqQ5QziP3IvNvbH4SCI7lsZrPuF+oGsPxfz
	GpefG9q3TAV3OQm2dmLkDIT4ocEjkosh7QunLvc1tII9CC+IKC00i683xkFK0pcUQccMGjlaKXR
	CQBRSXSrZ6O8uwNhhQxCvs/czilqfA8b2oEPJPn8vQHqTPDKO6eIoxUgdnA4jlfDm1xxD6T4HwI
	Z9yWQ8PHrTCER03sialzQ3D/3rF/2KlsIktWRTVMXzeFoOk0Dna/OtJGXRcmZ3IB0cdgi1+ouwQ
	z+zFa0rMc/sNlk0ttCqv6O1DesT0LiDdVaWLU5Ni2cXbYKdw==
X-Received: by 2002:a05:6a00:a85:b0:82a:18a2:91b9 with SMTP id d2e1a72fcca58-82a8c39435amr2028620b3a.49.1773991830963;
        Fri, 20 Mar 2026 00:30:30 -0700 (PDT)
Received: from localhost.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bbf0c2sm1477677b3a.15.2026.03.20.00.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 00:30:30 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] xfrm: hold skb->dev across async IPv6 transport reinject
Date: Fri, 20 Mar 2026 15:30:23 +0800
Message-ID: <20260320073023.21873-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227447-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.943];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45A482D6A0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfrm_trans_queue() queues transport-mode packets for async reinject via
xfrm_trans_reinject(). The queued skb may still be reinjected after the
originating device teardown has started.

Keep the device alive across the async reinject window by taking a netdev
reference when queueing the skb and dropping it after the reinject callback
completes.

Fixes: acf568ee859f ("xfrm: Reinject transport-mode packets through tasklet")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/xfrm/xfrm_input.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 4ed346e682c7..4b5147cb44b7 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -40,6 +40,7 @@ struct xfrm_trans_cb {
 	} header;
 	int (*finish)(struct net *net, struct sock *sk, struct sk_buff *skb);
 	struct net *net;
+	struct net_device *dev;
 };
 
 #define XFRM_TRANS_SKB_CB(__skb) ((struct xfrm_trans_cb *)&((__skb)->cb[0]))
@@ -784,9 +785,13 @@ static void xfrm_trans_reinject(struct work_struct *work)
 	spin_unlock_bh(&trans->queue_lock);
 
 	local_bh_disable();
-	while ((skb = __skb_dequeue(&queue)))
-		XFRM_TRANS_SKB_CB(skb)->finish(XFRM_TRANS_SKB_CB(skb)->net,
-					       NULL, skb);
+	while ((skb = __skb_dequeue(&queue))) {
+		struct xfrm_trans_cb *cb = XFRM_TRANS_SKB_CB(skb);
+		struct net_device *dev = cb->dev;
+
+		cb->finish(cb->net, NULL, skb);
+		dev_put(dev);
+	}
 	local_bh_enable();
 }
 
@@ -805,6 +810,8 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
 	XFRM_TRANS_SKB_CB(skb)->net = net;
+	XFRM_TRANS_SKB_CB(skb)->dev = skb->dev;
+	dev_hold(XFRM_TRANS_SKB_CB(skb)->dev);
 	spin_lock_bh(&trans->queue_lock);
 	__skb_queue_tail(&trans->queue, skb);
 	spin_unlock_bh(&trans->queue_lock);
-- 
2.43.0


