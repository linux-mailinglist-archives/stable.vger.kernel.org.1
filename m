Return-Path: <stable+bounces-254303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBv3A5B5FWrHVAcAu9opvQ
	(envelope-from <stable+bounces-254303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:44:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 943345D454C
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 005E03028C92
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA6313B58C;
	Tue, 26 May 2026 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reJXFF/c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117E3DD855
	for <stable@vger.kernel.org>; Tue, 26 May 2026 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792269; cv=none; b=TQD3GqdVSZCGa4Z53pwhTq4wLAZfovr8BQxJzs0CG/PKfDlUuLsWo8HJlkboAD/NEiSUC/nkcykCyZNi48hoAYnoXBYylKXLIcDUgnCTxJuO7H/YnogbGN92jrjRRkbFxat0Ka4FQ6HfVLI/GC+MybxLx8MTzwfGp1V2cEjtz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792269; c=relaxed/simple;
	bh=mRpirCObCLZqN6l4iv03pml9AZxIqV3ehKRFmi90YGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJ8/TeeDlRnMjHNv+rLUqQ7JPV1diMEDY7a4a0owK+9QAjm7QSQdWGxMzyZKBrklDU/aFIpbmVWTwTCRBMCwp/dWU11yHC7kU7e23TPl3n0/RIgyVks3sw4ODcHLKuR8L/rxsXRS7bNqe2W+AQ0FZZTScdJjE77YBpsgXDRf9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=reJXFF/c; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-83ea84df1d0so3442099b3a.2
        for <stable@vger.kernel.org>; Tue, 26 May 2026 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792267; x=1780397067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsmUW9tamcq3E3x3Xj8H36QoMdq6sDlAu1sIPsLwdow=;
        b=reJXFF/c78UJzqnKBd0YF1788g8Aq4MTuEdjHKYodYH8J6siskR9kZmN1tT86MG08t
         BBk2yttOebGV87gYtvtQcuhcj8dEKDN7Bq/k6/f65h7pXcydDNTUBcguyTfydAcrCqCd
         QOzS33DpQCzHl5l9k76Q/4SjeSBqMyqOjW/4DbfiAbAmuNXWaEKax7uzJnynUDowOx8B
         p8b4JFP78Gz/CBk0kd3QJ8YErdgYvP7re2Z7Ffz8w3pZncDRwV2lvIsaOBHpQL/7qkHa
         zn2OrPEYYAcvpCxUAD2sTG2RpP9r7qzoeLRMX+46XvNIpqymTtRofJbNMJdIKoC2LvBN
         YpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792267; x=1780397067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsmUW9tamcq3E3x3Xj8H36QoMdq6sDlAu1sIPsLwdow=;
        b=WRPgiW7yMSD/Zq5AjusqyT9k3l5ecjn1dM8T9ol4M3OxIZBn83jUDM24qEOc5bsfjy
         9dxOLrFA2SfN1/a1mEBg4rd57Z3v48ZvTw4/YwaKOMhMfSpyEYhLZyYR3frB3z/Ewhon
         DDTlrPYXuDcEFqZGMEOJewlrX9JwnwzPWb2AzlwOlLiAiWChb2hwQu/qqtf457g0NeN/
         gkFEUbKu+SBp9kXe1x3xVFD+L5f9mX3OOAUqx7WlxjMzcVgHJZXIEOy6rJ48+W0ta2Zl
         3khmhgoLxmIKa8Byrbe3hA/wK9VW0qa2NIQYBKkaD8amJj9OCOZISVKh13htoQfKRUEW
         o4ew==
X-Forwarded-Encrypted: i=1; AFNElJ+7WtkBAjtFAlRF4+2ty//krrZgb9ijm58FMEhi59OFoSoNeKShq5QplS6FcjfVnr8vjUhfF3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHUp70QTAQgDdnTUZP9KcHPGD5/IaUk2umU17w6WqYWuovcr/+
	C8DmSzzGVHwWEfMet3aGpQ1ybhfxbKYDONVPANoew8O3w1dcjLb40Xde3qP24hoEoDEuvwo=
X-Gm-Gg: Acq92OEbYxnHIf+Q2NaVRvp18ho0gXZO6U30YP5CduKBjxyh/l6OOhukis35aYGFOiK
	CH7NA4OIMWJlYbDv74kgMmIk6XFIimPX5eBno9EWVygoZYXolQpSM1CtHduI5AwwNGToKx6A57b
	+fDhHEkMXO1ygpocfNmnf8R8KN3NVphpSMnrbSb/v6r33LVbrlxbrqK5VZLjnJtK+eNQITZLg6i
	FRFs3bp/xHrhurWNuetWpq/1eIyPmV+eidBZWImjd3BFOkZPs8WohjEvtbfWRz38E2VTG08f/HH
	1ZGVEOGUFpdsLuAYlyQba6/qod5oScdz2QDQinYjhKYsfIWOCSmJv8DyVPUVJmxqvoteXTQKojj
	7Zv+H9Brcp2Nw4d74jPGK3+UZ5a+Cecvr8yYLw5JogY89AQVkPfuRQ/eTX2ls7D3ORDDYeDDhRt
	W+THWIZAs356q5K80q3Y3XsRhqbUXlA7IRBjrxN+n37z6McmFoqLOyCks7wNlBOKFWP7U=
X-Received: by 2002:a05:6a00:4c07:b0:82c:6b23:6d10 with SMTP id d2e1a72fcca58-8415f580e58mr17482367b3a.3.1779792267413;
        Tue, 26 May 2026 03:44:27 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164affc22sm12235270b3a.21.2026.05.26.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:44:26 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	stable@vger.kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Date: Tue, 26 May 2026 10:43:56 +0000
Message-ID: <20260526104356.469928-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254303-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 943345D454C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When vmci_transport_recv_connecting_server() returns an error,
vmci_transport_recv_listen() calls vsock_remove_pending() but never
calls sk_acceptq_removed(). This leaves sk_ack_backlog incremented
permanently.

Repeated handshake failures (malformed packets, queue pair alloc
failure, event subscribe failure) cause sk_ack_backlog to climb
toward sk_max_ack_backlog. Once it reaches the limit the listener
permanently refuses all new connections with -ECONNREFUSED, a
silent denial of service requiring a process restart to recover.

The two existing sk_acceptq_removed() calls in af_vsock.c do not
cover this path: line 764 checks vsock_is_pending() which returns
false after vsock_remove_pending(), and line 1889 is only reached
on successful accept().

Fix by balancing sk_acceptq_added() with sk_acceptq_removed() on
the error path.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/vmci_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index d2579380f5..88ccc55455 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -980,8 +980,10 @@ static int vmci_transport_recv_listen(struct sock *sk,
 			err = -EINVAL;
 		}
 
-		if (err < 0)
+		if (err < 0) {
 			vsock_remove_pending(sk, pending);
+			sk_acceptq_removed(sk);
+		}
 
 		release_sock(pending);
 		vmci_transport_release_pending(pending);
-- 
2.54.0


