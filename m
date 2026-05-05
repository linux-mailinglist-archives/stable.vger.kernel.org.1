Return-Path: <stable+bounces-244273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLcmDO5u+mnJOwMAu9opvQ
	(envelope-from <stable+bounces-244273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:27:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D96E24D44DA
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1D083017513
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80924921B0;
	Tue,  5 May 2026 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZaNYajOI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BE3ED5A7
	for <stable@vger.kernel.org>; Tue,  5 May 2026 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020073; cv=none; b=A9kS6zHW0b3oCal64bFKyYxZRcYkynNJJWnno6s8z4b1GcgXBNlhm0qwYJHnckGf1Sq4qU5czlvI453QqkKhCfhWwGM+fCvs53ZhQc8pP7SwY504nWV41vgG5Q5Et/XehrQpHtYSQp+R6FDe9z4kREGY3J1+HW+8gIVw/Mvcxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020073; c=relaxed/simple;
	bh=yn1rrlSDpjBT8m9VRGt3BBhC9BQ59TXZ/VCUC0jAymA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTTwxpYVhRR1liuKszQEGeAOl9/pB30TTwuH27HynQ8tGnXF/nfdg8fh5UDnZoZ7s4T40Elil3vJ1rKFS6MGLr52rYtdPghxOBYrUJin2wJ2KHLj3BGvzFSJQR9gU4KptFBuJ1c8K9QSNR6D/SIAUunNsGHDQWiTrVXZabvXnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZaNYajOI; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2b9ea536877so2203755ad.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020072; x=1778624872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYzm7RaU/mexAHzICmjLdIJWWzAicpchLD1vGt1mkIA=;
        b=khXnzxwB1zD9IigBh81PqqTPGbvOttAQ9IQRXPI2H9zXqiKy6G/cmmmeJ1Zs5tY3qP
         DLeWLoxAgxvl9G3eschHTw5cYZzJh0PZwqOjOPAptymTb/Hvj6yA5j7U+PlogElGLegL
         vvzcePQYu/bwNDC5j17vTfXdnLs79ZK7y27Q3NHMvY2BzqxnH5OJMXVpn2japTzixZrs
         +ZZC9Go7KxSWW6EJAPROO8iMMh66t3YPJTJ7XK+UzgBOvZ7gKXdilu+lq/OG4CZhwiyq
         JL8mCA73wQyZvNcr9z4X+GUiRhPYeOUFdvGitb6I79Lf4VbIijSVKdgeQvlyej6u3OZI
         AVJw==
X-Forwarded-Encrypted: i=1; AFNElJ88lRw/hSPoRznj+BM3m9IztbFIRqu1WR3CuCsOENbqXsdyNDyZ+60RpGkWW7c5NnsJKF8Efb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJjrM7HdWbllprDFLUsV1b5EfhowGZqxjPGd0ggoy6ofJtiax
	hOzGZgcjstmhZpMhrU/Gw44pZO+FNaY+LHYhikY5Ovokq5h+Asee+VFEWtTXxtVV/Av1DVgTxau
	4zCrlhEeTwjPEZp3XbXvRrA52F3pi+fYupPxOM0G9tXw6yLmF9XEtyc4sRwvU9KXLWaCS9unFV8
	J7tHdcniSGNxnTc0JyDF7W9EFBTaP+6Yvyc5/80TkLYpozySnjGLjo7//kDFlYkGqQiXSisp8u6
	4j28ucq
X-Gm-Gg: AeBDieud3azRXu2bR1650F6Q7581jGqZ8fB/h3oSX1pBqB0aFtg8CdnyMi4DRWesYKP
	KVb0KHMTKEBFzM47K5qooCnw1ouq9p2a/diEHUL9dJpZCyxjGorXOBlmFNn6wd2U36hI6rfqqPo
	SkN0hgxYTU/mqQh9VMl011eEakrQkBQAuswFBkI09j89aDlcFvWXuA6STort8CCSwFr1+g80jLq
	dAnG+7861qVw2j0uXPLh6KPkaNeUA5CuHglD/7gj/YSN1lxv3AkQfQhGZVZf4tBJ/L8+UIbEyLE
	eRjZbJJPSEwKN+bb3Z3MbK15/8fr0VMnY3LSpB9/LWlSHqXhc0R1truyXoPNwew5CpbsIZigo0G
	B0z2Ngt/BU4hmEml4vVz0PmiXCFTsEycB1X8nFygJTdm4uXJ+RhTVo702quU/K4/m12TMaIrZZh
	5GyUXUOzLxvmTrL2dpUHQN5CLRldts4FFxUGqFsQpxn8pzjI1Jt6MQSgpplrOGqcMA
X-Received: by 2002:a17:903:384c:b0:2b4:5bf8:a7e1 with SMTP id d9443c01a7336-2ba78b0eb40mr5499925ad.6.1778020071554;
        Tue, 05 May 2026 15:27:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ba7c9d0223sm385625ad.32.2026.05.05.15.27.50
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:27:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8d654ade33aso109093385a.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778020069; x=1778624869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYzm7RaU/mexAHzICmjLdIJWWzAicpchLD1vGt1mkIA=;
        b=ZaNYajOILlj1wih80vNCo6ctMmVo3jZqR0WvM8yRhZmLABTSsUOLM6S1jdDCOnPt9O
         tERo2GjNt+VPSOu/pFEgYx5Fy4PwSOQs9F44/DLLYO+nV7PcoGJ0Ji/181fBf4/C9zcx
         0OEiLn1fuyIvHX0uAbmCp2GgY168xNRQ9Fwf8=
X-Forwarded-Encrypted: i=1; AFNElJ/aWLz+/ZMfleb/A/J5kTnyc2IDfAwOP4/ykflSh5WIiwu0oC22BpycCccRbINL1Wci8c1dPD8=@vger.kernel.org
X-Received: by 2002:a05:6214:4b04:b0:89c:869e:4972 with SMTP id 6a1803df08f44-8ba9e692ba9mr106932376d6.10.1778020068906;
        Tue, 05 May 2026 15:27:48 -0700 (PDT)
X-Received: by 2002:a05:6214:4b04:b0:89c:869e:4972 with SMTP id 6a1803df08f44-8ba9e692ba9mr106932146d6.10.1778020068506;
        Tue, 05 May 2026 15:27:48 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:27:47 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 04/12] drm/vmwgfx: take fman->lock around fence list mutation in fifo_down
Date: Tue,  5 May 2026 18:22:25 -0400
Message-ID: <20260505222728.519626-5-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: D96E24D44DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244273-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

vmw_fence_fifo_down() drops fman->lock to wait on a fence and, on
timeout, mutates fman->fence_list via list_del_init() and signals
the fence without re-acquiring the lock.  __vmw_fences_update() walks
and removes entries from the same list under fman->lock from any
other waiter, the fence-IRQ thread, or vmw_fences_update(), so the
unlocked list_del_init() can corrupt the list head.

Re-take fman->lock before manipulating fence->head and use
dma_fence_signal_locked().  Wrap the locked signalling in
dma_fence_begin_signalling() / dma_fence_end_signalling() so the
lockdep annotation that dma_fence_signal() previously provided is
preserved (the same pattern as __vmw_fences_update()).

dma_fence_put() is moved outside the lock to avoid a recursive
acquire from vmw_fence_obj_destroy(), which also takes fman->lock.

Fixes: ae2a104058e2 ("vmwgfx: Implement fence objects")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 4ef84ff9b638..384c6736cf6b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -367,13 +367,24 @@ void vmw_fence_fifo_down(struct vmw_fence_manager *fman)
 		ret = vmw_fence_obj_wait(fence, false, false,
 					 VMW_FENCE_WAIT_TIMEOUT);
 
+		spin_lock(&fman->lock);
 		if (unlikely(ret != 0)) {
+			bool cookie = dma_fence_begin_signalling();
+
 			list_del_init(&fence->head);
-			dma_fence_signal(&fence->base);
+			if (fence->waiter_added) {
+				vmw_seqno_waiter_remove(fman->dev_priv);
+				fence->waiter_added = false;
+			}
+			dma_fence_signal_locked(&fence->base);
+			dma_fence_end_signalling(cookie);
 		}
 
 		BUG_ON(!list_empty(&fence->head));
+		spin_unlock(&fman->lock);
+
 		dma_fence_put(&fence->base);
+
 		spin_lock(&fman->lock);
 	}
 	spin_unlock(&fman->lock);
-- 
2.51.0


