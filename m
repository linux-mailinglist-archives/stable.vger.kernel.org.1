Return-Path: <stable+bounces-249523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yApBGek4DGq2aAUAu9opvQ
	(envelope-from <stable+bounces-249523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:18:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0901F57C0A2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 642763036420
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E864BC019;
	Tue, 19 May 2026 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAG29ITP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD294C6EEC
	for <stable@vger.kernel.org>; Tue, 19 May 2026 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185793; cv=none; b=XtW9Wx7seldGJ7EtUIfqtg56vyQooxMeOm6E2tQPuZ1t3Hqro254io1Lo3tFmUHbbiFK2qKbpQ9T3prn5PVl7G3IcJVpwee+YlsIatuy705D1tBhSpDwSCH/WKEkkmbTye44F3t69oQT/r5bbLdhqLdYbZuP/GWHRF52RL0Vx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185793; c=relaxed/simple;
	bh=A8lCk64tyDutpdWygpqGjJXORX5zZQ3IQ4DQQhG5Q8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwYLI/vJ6ONh/NuZvDcPLpnI0TkqQR4FgKvCgJTPtKlkgXP6Nhi0zkGrjFsN+df93251uh12SByedpx/5mnBf1z1It1ICfWKVxUkxoCiC+0uo6y7GjZnZTjGu6idm+FY9MBCTCatrHpfyh2qz17w+Tts/SoumbJn7oK8ixayyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAG29ITP; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36974221f93so1598354a91.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 03:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779185786; x=1779790586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6PE6oczvQzlzFTW3XERm2G8PX98I8qUZJMdLKZ7oFc=;
        b=DAG29ITPJ/oltyXTun/ebhMLfI83fqgSN5oYsS8vRj/qE1KkpfXMT5DP39bLfwUYKR
         A6BsCPu6Q7ejgyDVjPGZzdCTDcGFuJbTDWldnF1AIX7qzyQw1hb4iD6DikwQIAm0hk5I
         Joa75cPtaN+xi+JdCSK5IEGsGP3hy8FzGGDho8DnGsK1oNn69lBhVSWIg845okyayfgN
         XwH2LITXECyTa/FmUOZYrrP84s1HQ60j6XeEqRarl27x7qAyK8IXwc6qoRQ0vsFFbI+L
         W1KzxEBC7kFJYAPkvUiusmzN1FbPmLRmNtF5s8svPufgVbe2VqbgnTtzXMgWxtSxoerD
         dO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779185786; x=1779790586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a6PE6oczvQzlzFTW3XERm2G8PX98I8qUZJMdLKZ7oFc=;
        b=byMJMpPr39+CeEcxahSKO8rDLrG0TDE1Wj1p9TGtDTgwaF3tzXAS583BHvt95SwtCN
         Si9yKnUFI6oSI6aG0Crx/ZzaN8907L60i5LdRpJ7D+u1/DBdz7nXH4fy3ROMXVMRjMP0
         VHKIzAFiHcOS3WF4vshEYHM3BhDkguw7rIisDwsOgdp24+daSlBbacxOFKe14ubzy+oG
         OfuM9yd9nyIMczqoQ3rVoiCRIMZ5rr3ccafUL1n1ZIoF1gu1F6WAiN+mC/Vfb11BeThV
         x7f70KxyNb6HgCNDv5qF0DfiuReaVsHb5MCxwuBDCoSJnH1Eee+5PgrOp/eonu5D7KID
         W5og==
X-Forwarded-Encrypted: i=1; AFNElJ8YvJHPdfU5flQcUaEAlgypa1ibc3S2FGkSCKeiQbvL+bhwWtwp/avmn57mVcw1Zv/xxU8mHZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyedIr8zN1pnvj2qmFbI3F+eauS5PCNA8NodGrGbjtTzdUAkodH
	U/RWjKgjiehw7pLJAVa8HHDsivApX283IFDp96rgLztA34HMoXESQlLM
X-Gm-Gg: Acq92OHHDhBQ+IGOm05jJrf4M9mQ977EMiaFsVCQV55XeE2sG+xbaotTYb5WVxIGb1G
	dmqysdyM/d/PTucA0Fmdvr/VBndOOV8nj0E9eVNWj19uRx+3fgMqHXrKj2EdoJdDbDg6NdQrOyn
	Mozc8/8zfRLq/X1oVcwL4Bo2ZNy6Q9hLgLI/o3YHyYabExjEWxSDkIb5nDYoEjWtx91xMKMeXjZ
	afj7r+ZdoUEzoUPkT50GrUQvMyugpSarT4HybED6iQsmIC3ii7PKBwfOrnCFTdnuyyuKA+GTx7v
	+ROXRKDqs2QFVb2q/o/XVJjaPMYSY7BGquu5fVGu6YpG8F/jCChlnhBaXaOJj6sQMQODyK/T25z
	PHKRTeHeR/xFGhbXz5JuirUqxAKOoPhqDEbcBMDWDvvSmM225a8L3K/IxRJHL7zdxPsjJJMSDx5
	s6sxYa1Lo8CCoSHezP17OFnoexIA==
X-Received: by 2002:a17:90b:2742:b0:368:cefe:ddd0 with SMTP id 98e67ed59e1d1-36951b82f8fmr19522119a91.15.1779185785623;
        Tue, 19 May 2026 03:16:25 -0700 (PDT)
Received: from fedora ([171.243.49.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d234540sm177683165ad.79.2026.05.19.03.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:16:24 -0700 (PDT)
From: Minh Nguyen <minhnguyen.080505@gmail.com>
To: pabeni@redhat.com,
	bryan-bt.tan@broadcom.com
Cc: sgarzare@redhat.com,
	vishnu.dasa@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] vsock/vmci: fix UAF when peer resets connection during handshake
Date: Tue, 19 May 2026 17:16:10 +0700
Message-ID: <20260519101610.233070-1-minhnguyen.080505@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <agwv3YkxYIC7mvyj@sgarzare-redhat>
References: <agwv3YkxYIC7mvyj@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249523-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhnguyen080505@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0901F57C0A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vmci_transport_recv_connecting_server() returned err = 0 for a peer
RST in its default switch arm:

	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;

That made vmci_transport_recv_listen() skip vsock_remove_pending(),
leaving the pending socket on the listener's pending_links with
sk_state = TCP_CLOSE while destroy: still dropped the explicit
reference taken before schedule_delayed_work().

One second later vsock_pending_work() observed is_pending=true and
performed full cleanup: vsock_remove_pending() then the two trailing
sock_put(sk) calls -- the first reached refcount 0 and __sk_freed
the socket, and the second wrote into the freed object:

  BUG: KASAN: slab-use-after-free in refcount_warn_saturate
  Write of size 4 at addr ffff88800b1cac80 by task kworker
  Workqueue: events vsock_pending_work

Treat peer RST like any other unexpected packet type (err = -EINVAL).
All destroy: arms now return err < 0, so vmci_transport_recv_listen()
removes pending from pending_links synchronously and
vsock_pending_work() takes the is_pending=false / !rejected branch,
dropping only its own work reference.  This also closes the
multi-packet race Sashiko reported on v2: pending is removed from
the list before any subsequent packet can find it.

The pre-existing sk_acceptq_removed() gap on the err < 0 path of
vmci_transport_recv_listen() that Sashiko also noted is not
introduced or changed by this patch.

Tested on lts-6.12.79 with KASAN: 52/100 unpatched -> 0/100 patched.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
v3:
  - Different approach to Sashiko/Paolo's "trading UAF for leak"
    concern: normalize RST to err = -EINVAL so all destroy: arms
    take the same err < 0 cleanup path -- no special case, no
    multi-packet race.
  - Sashiko's secondary observation ("while not introduced by this
    patch, does this error path leak sk_ack_backlog slots on failed
    handshakes?") is correct: the sk_acceptq_removed() gap on the
    err < 0 branch of vmci_transport_recv_listen() is pre-existing
    and is not introduced or changed by this patch.  v3 stays
    focused on the UAF; a separate fix for that gap is needed and
    would be welcome from anyone closer to that area.

v2: https://lore.kernel.org/netdev/20260512025851.189140-1-minhnguyen.080505@gmail.com/

v1 was sent to security@kernel.org on 2026-05-10 (not on lore).

 net/vmw_vsock/vmci_transport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4296ca1..ba3a66e 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1161,10 +1161,17 @@ vmci_transport_recv_connecting_server(struct sock *listener,
 		}
 		break;
 	default:
-		/* Close and cleanup the connection. */
+		/* Close and cleanup the connection.  Peer RST is treated like
+		 * any other unexpected packet type in this state so that the
+		 * pending socket follows the same cleanup path as other
+		 * handshake failures, instead of being left on the pending
+		 * list for vsock_pending_work() to find later (which races
+		 * with subsequent packets and was the source of a UAF when
+		 * the cleanup work observed an inconsistent ref count).
+		 */
 		vmci_transport_send_reset(pending, pkt);
 		skerr = EPROTO;
-		err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
+		err = -EINVAL;
 		goto destroy;
 	}
 

base-commit: be48e5fe51a5864566307998286a699d6b986934
-- 
2.54.0


