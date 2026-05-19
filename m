Return-Path: <stable+bounces-249547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIQuFaw6DGp8aQUAu9opvQ
	(envelope-from <stable+bounces-249547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:25:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F057E57C2EA
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBD56300B470
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7576C4C0413;
	Tue, 19 May 2026 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw0uXmx8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621034BCACA
	for <stable@vger.kernel.org>; Tue, 19 May 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186208; cv=none; b=mW/fCGrgYIS9+uf1Mw+zaAheXAsFkjVo3DhbsODNdnjYz//eo/wrcX3BWx2yjBF/lCI2lF1jes2Vai5aaRBJ4WOtFpJaEYeQOsH2yvlyNjhUr5MbQUqtRv0p10v6cIDC4hTohoGPDxUzBW48Vb6OjMgX2G25rUcxK23hgdemQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186208; c=relaxed/simple;
	bh=DO0Gh9yEyPAdPj/ANVn8igAk2S/1BupY7L+OcOzpdyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKsLB5rqVB/KyXj3bE3+0HO6VY52EUOGoFw4i7sK7yGp31bS6cwqu+N0vmJUn4vHPda1KfDOQftyi3vMhgmzDQ3MF/2/4GSlKasa7p30leJklSQamNzE5aF2LqN1WsYj9WstJKQIjokS+5JBoHMKfUyeLjTznXE5h+XM6BNW72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dw0uXmx8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-369576666d5so1509332a91.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779186205; x=1779791005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wI00RqYwNVXaarsJLcvON/gPH4U7fY7Oeb6rc01MfGw=;
        b=dw0uXmx8wfhvQErBnHKHsyXQmIHBpuoHrvL8TmqDp6nVpzUDm+BgeFRVfEX808Ufr9
         gsO/JCrPk2ijFo0+nlgSyVDB1VEIodsDol1ss/gybvby+jGmdT2oKEMSiEIZXi66JgU1
         ZwJ1g1/oHI0Qyks7ewwGrnWR+bwwjUwQpJebi5Oit0CmgjUx9gm4RnX6W3p5eFm7caXB
         iXWTdAcIVphJdAc7uJXHTbl0mbGRKRSoGmJYEA+V+zx0NwAxElx+PNtxyVRZGdgVTRDA
         S8Z8nY1OzbZj9TUmvGzQI4iIDOG6hxj4LkjoxBk0pqXfxDPmyVgQ17ExUvkaB/3+488O
         lgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186205; x=1779791005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI00RqYwNVXaarsJLcvON/gPH4U7fY7Oeb6rc01MfGw=;
        b=ZgiHs38dNYTloTOKqR/b/ChbI014gYaJY8bTfufZ2DNd7p+P/0pSVpuZdp7kEJYSej
         KNE+AFfr/2gAh6cV3UJdC/lz2lviB2O0SoBS1CXBAhYMzLTRCtpKsSUhAPVoLuZKEnIx
         scrV1Dscx2EzSzS74/MUqnPwnHtKqx2fSM9Xa0cBO80uH/p8I8tzF2f3N+g2JnkfGJOj
         L24u9mADbqb0kPcLoSt+yMBYzX2yaJlWKMhY99sAGNFl8HQUxJ6ApxnzG3zgKBNQwEYj
         GIx8uTLP7fIhn24YoWHrcBZugdTD4W+frBXj7Snv1H2qe0Ny533JMbUwlud4+3Pd8srk
         RQmA==
X-Forwarded-Encrypted: i=1; AFNElJ9cvf8pXXt7o0+SAQ7pIxlOMC5ABm5wFNwjFrjT31GGHR4nPHSR06A3s8W3BTJQW+Z0bdECnvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCUdOebIQRtWte3+02totabJzC47S6JkF+KGV7I2GzSHiU+Ws
	i8TRSw4BbjpTwFgv95tn03P+p7ZutoIsC3WqnkJCgQPfgM+ZleeJ1z52
X-Gm-Gg: Acq92OGM8n4C7sCBPQ8Ul9SHO2wS0ec4hvoVtwBxe2ARyhytqBYk/cTIqY5w53wemD3
	+Ck7wyqVITKVZAdU04c8xNlmVAU4Pj3ibqjJL/GqTugfJS8cj3O5RGWJ7abPVrwVa/7mHvCFf7i
	raLweXWBc5daTGmrMIgUGDN/oNCy3/k2sCLel889kmESFian8P/d1VuocKOO1/fCYdH/tipf1dK
	M7f6Co3dZKkdgw/FD2GNmYLU/i72P2HRUGqvKz/AvvZpKCWtOCFYJFuI2zpWIJvrtpndhPfC3jP
	OoIg9cZ/GW0E1gbfzB8/g1zodp+DjvXN/dNoRR6GQ6b1r5I1oChFNex9EAGDFpaf8X6EvnLmu4r
	LpqUwJzY074ZP/WbZ2S1ng3A8F8gL4GKaQC0WxpjfbsY7HFMlmVP9ppFnFl4LxTHmE+Umai04FA
	I6lekzWAvZ1k46wIgm/Kg+GidEXA==
X-Received: by 2002:a17:90b:5290:b0:366:1bab:c3d6 with SMTP id 98e67ed59e1d1-36951a02b73mr18385801a91.10.1779186205288;
        Tue, 19 May 2026 03:23:25 -0700 (PDT)
Received: from fedora ([171.243.49.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695148d53asm13708947a91.15.2026.05.19.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:23:24 -0700 (PDT)
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
Subject: [PATCH net v4] vsock/vmci: fix UAF when peer resets connection during handshake
Date: Tue, 19 May 2026 17:23:10 +0700
Message-ID: <20260519102310.237181-1-minhnguyen.080505@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249547-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhnguyen080505@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F057E57C2EA
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
v4:
  - Resend as an independent thread per netdev workflow (v3 was
    incorrectly posted in-reply-to the v2 thread).
  - Drop the inline comment expansion; keep the original
    /* Close and cleanup the connection. */.  No functional change.

v3:
  - Different approach to Sashiko/Paolo's "trading UAF for leak"
    concern: normalize RST to err = -EINVAL so all destroy: arms
    take the same err < 0 cleanup path -- no special case, no
    multi-packet race.
  - Sashiko's secondary observation ("while not introduced by this
    patch, does this error path leak sk_ack_backlog slots on failed
    handshakes?") is correct: the sk_acceptq_removed() gap on the
    err < 0 branch of vmci_transport_recv_listen() is pre-existing
    and is not introduced or changed by this patch.  A separate fix
    for that gap is needed and would be welcome.

v2: https://lore.kernel.org/netdev/20260512025851.189140-1-minhnguyen.080505@gmail.com/

v1 was sent to security@kernel.org on 2026-05-10 (not on lore).

 net/vmw_vsock/vmci_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4296ca1..d257938 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1164,7 +1164,7 @@ vmci_transport_recv_connecting_server(struct sock *listener,
 		/* Close and cleanup the connection. */
 		vmci_transport_send_reset(pending, pkt);
 		skerr = EPROTO;
-		err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
+		err = -EINVAL;
 		goto destroy;
 	}
 

base-commit: be48e5fe51a5864566307998286a699d6b986934
-- 
2.54.0


