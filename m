Return-Path: <stable+bounces-253724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP4vA9MgEGpNUAYAu9opvQ
	(envelope-from <stable+bounces-253724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:24:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB725B11C9
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6AD9305ECF3
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDB43BADB7;
	Fri, 22 May 2026 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd/nvuFy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F2B3B95EC
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441468; cv=none; b=lmFo6p4NVgM3jAStAWK3xnfToHFWt33u7F264QYcL4GEtyhCQ5Fk0psWbepouK5jZCVKNBcPTjiy/9/karAPqA3Go5LyENNA84CEJR48r2hcH7P778c23/g4iuwrYoF4zP/QZIF14A4jJc4CjCBIFErQGUtNO9X224NRMiV5nOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441468; c=relaxed/simple;
	bh=HJlZ8TI3+tSU99T/0bHZwWtEb0SFSnsG7S0YfidSIJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oghPCTwkVkpJSgYrppj0c3X0QjNjI9pBtYQYUlqv8BZpnBDxdONFz1pNLGXlM8FlWEKZWuW8T5B3suQaQhqaP/nYsA+VvxOCwepb/Q9/ef1pI/xj9Ruso4+yG0OAMXja3yIvAqw99CB2omMZE+3yXigdRetN/NIuxD89HIpt0+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd/nvuFy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-835537a9278so262014b3a.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 02:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779441466; x=1780046266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFK655wZK0lyhsPu8M6I8j5XnIjP+tTr87dEjsrnrnI=;
        b=hd/nvuFymTMMKN+p1x+ytJeFZ+DpN3csmGdMgP71hcH6mlHuCnRSwvglmt0adNL3Zp
         I5InicC6t3+kqNgMJ3ovgxk0XIDTZ3XolPSHJ/RZmt3PuVM73pfL5FBhOV3vnYtKgaaJ
         lfNzH4hVttJFnlBVvpuKY4hKbivYdNaWPT6OvmBgXafC74zbPnbf2bMyHRz0FTCKbicp
         gPbBH9ozR+YULYPebk7IqPH3qBitIyFi1gA910Vcp6fnBri0joy+gD7DtymaTtpGv0IX
         kkv+Yl4kiEqQLY197td4SYOruBP0c8UKsE+xF7GeQ4xH2sN3sWv5e00PkROm4VZnDhN2
         sVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441466; x=1780046266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFK655wZK0lyhsPu8M6I8j5XnIjP+tTr87dEjsrnrnI=;
        b=I4+7aLMjz4zqwQ/bd9W8a7KbyRR9ucVY53Ex5wVbkDnR3D4BukJ/RlZe0ZXNl39hm4
         uNmdvVKxOeYPm9ryDnRUuNkfPNDVHiv7zo4kMGyXed8ucRNtGkAvW4aA/CknaombjDrZ
         5Bvpb/cVMlwN7U1XqYqK3zGjb1aK2+HyKopTGTD1YwMainyS0sGOUZi0+KPUoDIA1SCq
         ey8K8CG/xqZBykqmd39c10idpFdJLzgI5jlljxEHUM3L7wkVwIdqZ/8/7RB1pPBMr7Rk
         HlmsflNR8X9QV+IekRS5sjitX5UBbIrrD/JrUcvP84zwd96jfDayKBbvB0qzQV9DjtS9
         1Dfw==
X-Forwarded-Encrypted: i=1; AFNElJ9SGIFG0LwR3Jdq3pxn3U67CgRQuLIYwzbkc7XzXNaMfLpkjGajNG6WVwiX0L4s32vC0y9GXXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybXWkphLOYHqbwqhAZg7HBAJPAprudLpvcos695L3Xx0rpgT7g
	OOfZZ1SolseblfoEGUBtU/1UN0P2MT8sQ/qsL2xLjzbig5dQjab5s0kJ
X-Gm-Gg: Acq92OExDV5YLIg2u/h+OZ7CyMO/cbUCpStFrdCMCxQ+CPSdgWS7whS+LnK8iHguQBq
	eMsDMo9HAkOIh4N/8pz2WYpOdb89aAgRurqsCC+6/OFdcvTrIbKt6OLMl3duCYWetRXaCHpTv1Q
	JEAsUvF5KWlxDAhBM6PALQmo+kwxwBETK6hl8wqFRyfFW4fM+TY8HIKOprpDjvKLilUgxaiw8Hl
	zvM8TTT8C95HsljBAY69ugkBsOpczy9CGej2cOrSqePylb954+fD+w5d1CrtPCC+yEEn6G/Nlvz
	uYE5CBmb0IOBm6HuCtvb7q7az+y8OVQWPKPWbfCH1rIiAACf7RsPbQ/5aEMhO2IwTbibajFDiXU
	c/ftFz2QETkZSPZOx2icxvJmtjjazolyuIRK4zqYfFLVO5IpPU1QFC97R16gmzvBmIwzuSFXdDU
	NDVUGilKt68S+hJQSJS+tnOUYdW8g=
X-Received: by 2002:a05:6a00:2d07:b0:835:443e:4be5 with SMTP id d2e1a72fcca58-8415f40ccf0mr1605564b3a.1.1779441466347;
        Fri, 22 May 2026 02:17:46 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fb28d5sm1517038b3a.41.2026.05.22.02.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 02:17:45 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: antonio@openvpn.net
Cc: sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] ovpn: fix peer refcount leak in TCP error paths
Date: Fri, 22 May 2026 05:17:17 -0400
Message-ID: <20260522091718.270956-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253724-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9AB725B11C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When either the TCP RX or TX error path calls ovpn_peer_hold() followed
by schedule_work(&peer->tcp.defer_del_work), and the work item is already
pending from the other path, schedule_work() returns false and the work
runs only once. Since ovpn_tcp_peer_del_work() calls ovpn_peer_put()
exactly once, the extra reference taken by the losing path is never
dropped, leaking the peer object.

The race window:

  CPU0 (strparser/RX error):       CPU1 (tcp_tx_work/TX error):
  ovpn_peer_hold()   <- refcnt+1   ovpn_peer_hold()   <- refcnt+2
  schedule_work()    <- queued      schedule_work()    <- NO-OP
                                    (work already pending)
  ovpn_tcp_peer_del_work runs:
    ovpn_peer_del()
    ovpn_peer_put()  <- refcnt+1
                                   <- peer never freed

Fix by checking the return value of schedule_work() in both paths and
calling ovpn_peer_put() to drop the extra reference if the work was
already pending. ovpn_peer_hold() is kept unconditional in the TX path
as it cannot fail at that point.

Fixes: a6a5e87b3ee4 ("ovpn: avoid sleep in atomic context in TCP RX error path")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
Changes since v1:
  - TX path: keep ovpn_peer_hold() unconditional per Antonio Quartulli's
    review; only check schedule_work() return value
  - Link: https://lore.kernel.org/netdev/20260521083739.65061-1-jhapavitra98@gmail.com/
---
 drivers/net/ovpn/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index d651ce85c..2c7d830e7 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -283,9 +283,9 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 			/* in case of TCP error we can't recover the VPN
 			 * stream therefore we abort the connection
 			 */
-			if (ovpn_peer_hold(peer))
-				if (!schedule_work(&peer->tcp.defer_del_work))
-					ovpn_peer_put(peer);
+			ovpn_peer_hold(peer);
+			if (!schedule_work(&peer->tcp.defer_del_work))
+				ovpn_peer_put(peer);
 
 			/* we bail out immediately and keep tx_in_progress set
 			 * to true. This way we prevent more TX attempts
-- 
2.53.0


