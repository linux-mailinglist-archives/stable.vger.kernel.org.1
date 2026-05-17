Return-Path: <stable+bounces-249143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN71MtQJCmrqwAQAu9opvQ
	(envelope-from <stable+bounces-249143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:32:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7BC563264
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B8330075CD
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C9B3C455B;
	Sun, 17 May 2026 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDZI9mvO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26532ABCA
	for <stable@vger.kernel.org>; Sun, 17 May 2026 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042766; cv=none; b=iin9O0cTGX/E8ghrOm7itvTatKuG1etmszEkTr2fdThkHmDSNTjNKDoss8DMUac5bfIHi6ESz9sYvcvtYvE2QC9JJdcUW0UEZipOAlw2Db9nnlBZjAy2eqEEtp3O2HLJWxpSZ+D0VStTnGkeUnQGCXt/SR0EERrodp8nAY8xWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042766; c=relaxed/simple;
	bh=2gpLkKTi8b89XhOJYb+h4Qu5Tvt0LWquMLx2EAJnZ6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hkKZs2u9qFtR4SjTKHg+zZBivZ8OPiWJ8QOl+hn7PxqMx+LElL1Ii5TUHzyLcmqVz2iHqVUUutIRI3rr/XkBp/Kj5JT9d9Us509depYqgmNpkqiPt4pvPo5iKim0wKNL3ZZCbns6sXFX99LBsWILvSio6bVqG2Ohsp7c5kyAUxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDZI9mvO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so17492905e9.2
        for <stable@vger.kernel.org>; Sun, 17 May 2026 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779042763; x=1779647563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrX4cHfZiq2RSQ96iUeYw6Ac8LjFTgDBJ9ngVRFz7iw=;
        b=IDZI9mvOHX5Fz+WnmWkkCzu0UnPxRbbjtZSr/IkLtO/qIq0W6m8eSeOrYAe/GOH89d
         KVG0csVs6sGuU+sGrbF2Q+kCHE+ku+NGsJwCtaej/Q1ZWEvEHLp7gg9kxd2Znn04hLYr
         pIO5LoGt+uxR1dhk4WQP0Hu5Lte0LE/RiLSgabFtTMsCpR5pJc8Yp8qTt4WD3oUQwJWB
         1D0lcCeMLu0aUzH4WHRwq9yBdvREOiLMrW3agd3dkMDDgmGGMdW78D+EfShp3sDacmjq
         gkk2JSdVfjMdu6iX4i2gyPPdH58auvlY/OVCLbWq6r/qGPZmZdXHRNqCRWPf+mE9jZ7s
         v2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779042763; x=1779647563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrX4cHfZiq2RSQ96iUeYw6Ac8LjFTgDBJ9ngVRFz7iw=;
        b=s+a6UCkCzytPtni1SbbCOuV7typOiwTWKcRKc+zSAeLDGAP++DY+7hLdH7HbNYy6qQ
         YxZTSnSjpD7SolToFOXVsf5Hnz2beBnECcw4+vrlDazcv3HoRCCl8Zb7SjgU9Sda1Ksa
         4MKO7T0ZXlBPqcX2nickQq+XSL13Er9DPsHXY3wVfwesm7KJEZAlcVFOByv4N4E41Msq
         vVRfBHuoFdVD2+mpLSq1t8iUhNmv7qgTTiYVQLYZIm04yJv+IGAUGhZXbnWcwCkRw1cg
         TJgt160oKmHWMY4liFocwN+DCKEXQrEcepLipdsv+ouRtZKCuebdx/fL6WPXSlR2wzIW
         TWlA==
X-Forwarded-Encrypted: i=1; AFNElJ/TILOPLTnfWHNFe7tLYao4o4ue21jWhnTr0SZGk8ILm11wOp6GVDkK6hiRmpkZaKH9dLH2Lzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxwM5DMXdHfO57fAdcoVt45ioZvwsgURJ4lM0ZN4PM7m1CH7K
	stltz2RKzCc0BHc2IaFNu5y/eZ91VKsqm46kGOnl7MTGuJFUNvQf7OnwrdR9X90H
X-Gm-Gg: Acq92OGGpjkpVewj7LDii/rsfWznFaXpaQd9ZR8FK9lsRrwTubye3+qc6HkJ/NoR8SH
	MrqvDnZxecgkNJeXHhVpr1YSUJ9m19XUF0/kfQRgeh5dHNt0pUvJsIuWa8ZvhEN3q8b+ed3vUYV
	8fGhCUnNjgUL6SJgI3dSNy/ZaAJwDWnZ3ZcU3yOyfPRoGBAe4CDEHoGdsxk/56aPlJtzfv+JYPE
	b/mNX4u9f/TPrpwl+oF9aoSjwCe89gjKTESsfv4o4PhGkEUtJbRT7Lb9eICOmO0hBUKBm9nsZNv
	xMRWuhZpopo1MyxsP4j/1vK8zo8tajM5aE4kjUEAiqG3Ne8WeqIPjxUcB5Sql7l/uA5ZdhLHURW
	XWTiVv3gSXut5yRnsTWnAy30lWBKFFMIE2Q7MSlKVoCQRJm6rtgLMBTUBNR7CYVXS1nwOeDnkNk
	tWM5TLxKX9+hK4k1IOj+VkpcAl81BexM90g1qE
X-Received: by 2002:a05:600c:8b13:b0:48a:6315:da26 with SMTP id 5b1f17b1804b1-48fe6513492mr202490685e9.26.1779042762748;
        Sun, 17 May 2026 11:32:42 -0700 (PDT)
Received: from localhost.localdomain ([31.4.47.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c744sm16172225e9.3.2026.05.17.11.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:32:42 -0700 (PDT)
From: Justin Iurman <justin.iurman@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	idosch@nvidia.com,
	justin.iurman@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()
Date: Sun, 17 May 2026 20:30:59 +0200
Message-Id: <20260517183059.29140-1-justin.iurman@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D7BC563264
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249143-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Reported by Sashiko:

The function ipv6_hop_ioam() accesses
__in6_dev_get(skb->dev)->cnf.ioam6_enabled without validating the returned
idev pointer. Because addrconf_ifdown() can concurrently clear dev->ip6_ptr
via RCU, __in6_dev_get() can return NULL during interface teardown, which
could cause a NULL pointer dereference when processing an IOAM Hop-by-Hop
option.

Let's add a check and use SKB_DROP_REASON_IPV6DISABLED accordingly.

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
---
 net/ipv6/exthdrs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 03cbce842c1a..47c5502a34a2 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -910,16 +910,27 @@ static bool ipv6_hop_ra(struct sk_buff *skb, int optoff)
 
 static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 {
+	enum skb_drop_reason drop_reason;
 	struct ioam6_trace_hdr *trace;
 	struct ioam6_namespace *ns;
+	struct inet6_dev *idev;
 	struct ioam6_hdr *hdr;
 
+	drop_reason = SKB_DROP_REASON_IP_INHDR;
+
 	/* Bad alignment (must be 4n-aligned) */
 	if (optoff & 3)
 		goto drop;
 
+	/* Does the device still have IPv6 configuration? */
+	idev = __in6_dev_get(skb->dev);
+	if (!idev) {
+		drop_reason = SKB_DROP_REASON_IPV6DISABLED;
+		goto drop;
+	}
+
 	/* Ignore if IOAM is not enabled on ingress */
-	if (!READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_enabled))
+	if (!READ_ONCE(idev->cnf.ioam6_enabled))
 		goto ignore;
 
 	/* Truncated Option header */
@@ -972,7 +983,7 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 	return true;
 
 drop:
-	kfree_skb_reason(skb, SKB_DROP_REASON_IP_INHDR);
+	kfree_skb_reason(skb, drop_reason);
 	return false;
 }
 
-- 
2.34.1


