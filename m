Return-Path: <stable+bounces-241906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HgDEP8i8mlmoQEAu9opvQ
	(envelope-from <stable+bounces-241906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:25:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5BD496CD0
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA9A6302814E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921A637AA7F;
	Wed, 29 Apr 2026 15:18:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052AB3783B4
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475890; cv=none; b=tbiDIq1zeAqizgNGlgz6B5HDfGl9Vo7GtXh5KGLbXWM15W432rVAl83Q6E1dSaSemzrJN12IH31GJ7QjjiUsYsEfvwLTZ59+KMVXYlpEr0Cir7/iHQZ83HDI/3atWGV0fdSvllqq0odjTAXRLm6o4RyR1v33qHgIWIZ+/MUVgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475890; c=relaxed/simple;
	bh=IcSgz7CPtBhFf1K8izNXcbPchRtKjVsJDl/ciso75PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR/WUjof2rDHhHtxMFHkGQLkAP8e1Iev+kO4mxF7cbRoAX1+AEB+dDWmRLg5xB1g4xCCDJR2SzzT7otC5sEZNcMPJRLXV3HQJRWe3t6bwK36w28iEuiR59h60WpIlXH2LS36bQeHbj/gXruJudBJt0BZXt7k9HgILZ1p0TjRCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-483487335c2so125692735e9.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 08:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475887; x=1778080687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wI/PIcTVy7eu/PfacjAoItlkhWbBUZ77v7uqcAyLoWE=;
        b=cE/VRl6/1Yk+RRlyrvEQ2LjdACcqr5PubSlvVq1VhIl6rIRnZ+5TOQtUI1DCrADfLl
         sPDO0SG4ZNSeV0vvkKP+6VOv95Wt4uZ9GYsorBXzWerMCDujB7oHD+EbnwFQPc1rvG5f
         UToR1342PyG5QAsQgbE09EefvJo8vrpYCtx/dxNeVHjWjUS1f3sD7uVpftRfXnr5fitJ
         1dQ0XnlIW1p0SuEzZz57H6HWH6SbncPuCL4fUw4tyxQpQmh4J9PdWC8pfrMVH/S2PGo0
         OUu9oaTkYd/5E1gwh1i8+9cQtwUc04DyuoCtQxHGqsbgfH9mirdmxJ0+XM0YvG707Cwm
         yVyA==
X-Forwarded-Encrypted: i=1; AFNElJ9BjGCy76VSM2lRr/t8jhO1EebliYe4SYzVy9Fn76mUtBi5ofo8xvsjy8RKbdVpTGs51u1wAxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0B6KZN610T0ZTHJud+iwXQnHyZNw2ygGh07RWGAzl765O5RtO
	zxsmScQyhcLwluKdrEdS77CensTYofzGaFQ3BBbSeK02EkmB+Bk+Yyb+
X-Gm-Gg: AeBDieuZd2jS0wUV/ZL7omQ8q/11dC8X4nHb1I+K+kl8m5neT4OvDTe2+991/N3x9sR
	pOV1v+swrWyQblVwj/y0BXtrrOZyYqdlLDiiaiJ3r22mXlV7uVtOB29ouWvR7KlJWp6uOZJffgr
	Xi+2LO/1rP/hJbBJV+kbKy5g6VR6Z9kNfNkIhEh6r6ntBfSUXJ7kKnQmHZykaHZ1v02TcTUUrRs
	RaZKiPtO61Bbt1fhbhy4LI2thXuidgD3jqxYLKnY4CJn2TM07tf+lrAhF26KxHvzEzjP4+IwmN4
	g4mQlTqVAhjkamMHajiFTe3RcgHZdDVwljwRXiuAIZh7w9TWlgElHTm88Dr09pRgqLay39wHeIF
	qv84WSr5CzRFJIzaVdY04HAvdtjNMQkEMw7ddvHaVJhbsuklRPjyb1hqGMmU4dGIgieD9q//17d
	LTxneAnBYLVutwYv8hjrd63VEnTp9NK2hSUFdrJoEfX/LJ47bvbCQCeP0f+tot43GS+KhMZQ==
X-Received: by 2002:a05:600c:1396:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48a77b1b85fmr132416975e9.22.1777475887157;
        Wed, 29 Apr 2026 08:18:07 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2d3811sm32358165e9.3.2026.04.29.08.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:18:06 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuan Tan <tanyuan98@outlook.com>,
	Yang Yang <n05ec@lzu.edu.cn>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] openvswitch: vport: fix self-deadlock on release of tunnel ports
Date: Wed, 29 Apr 2026 17:16:36 +0200
Message-ID: <20260429151756.4157670-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429151756.4157670-1-i.maximets@ovn.org>
References: <20260429151756.4157670-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B5BD496CD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241906-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org,vger.kernel.org,ovn.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.311];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ovn.org:mid,ovn.org:email]

vports are used concurrently and protected by RCU, so netdev_put()
must happen after the RCU grace period.  So, either in an RCU call or
after the synchronize_net().  The rtnl_delete_link() must happen under
RTNL and so can't be executed in RCU context.  Calling synchronize_net()
while holding RTNL is not a good idea for performance and system
stability under load in general, so calling netdev_put() in RCU call
is the right solution here.

However,
when the device is deleted, rtnl_unlock() will call netdev_run_todo()
and block until all the references are gone.  In the current code this
means that we never reach the call_rcu() and the vport is never freed
and the reference is never released, causing a self-deadlock on device
removal.

Fix that by moving the rcu_call() before the rtnl_unlock(), so the
scheduled RCU callback will be executed when synchronize_net() is
called from the rtnl_unlock()->netdev_run_todo() while the RTNL itself
is already released.

Fixes: 6931d21f87bc ("openvswitch: defer tunnel netdev_put to RCU release")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/vport-netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 12055af832dc0..a1df551e915bc 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -196,9 +196,13 @@ void ovs_netdev_tunnel_destroy(struct vport *vport)
 	 */
 	if (vport->dev->reg_state == NETREG_REGISTERED)
 		rtnl_delete_link(vport->dev, 0, NULL);
-	rtnl_unlock();
 
+	/* We can't put the device reference yet, since it can still be in
+	 * use, but rtnl_unlock()->netdev_run_todo() will block until all
+	 * the references are released, so the RCU call must be before it.
+	 */
 	call_rcu(&vport->rcu, vport_netdev_free);
+	rtnl_unlock();
 }
 EXPORT_SYMBOL_GPL(ovs_netdev_tunnel_destroy);
 
-- 
2.53.0


