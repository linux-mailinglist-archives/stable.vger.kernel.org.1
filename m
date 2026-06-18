Return-Path: <stable+bounces-267285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kvnQNc59NGovZgYAu9opvQ
	(envelope-from <stable+bounces-267285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 01:22:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B7C6A3124
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 01:22:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="cw/A62HV";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267285-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267285-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7611630226BC
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 23:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ECE349B15;
	Thu, 18 Jun 2026 23:21:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761483403FD
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 23:21:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781824913; cv=none; b=BeNKFMFd8o3niLlmIwEcZbcPQcZHkhI+YaO8+npqa6P+ppzowH5F+e6s5bsJRQZaIqaXMdqLwivIns00MwOsaxFVAzxgaHlwXtNxnMkjWVNhe4qKWvkbksoYZTFgxYzqhTWvnCw15koM+CRyUvlODiDU4+Pks7vq1tdgjpBagSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781824913; c=relaxed/simple;
	bh=FP+cKVSzI65xOHE37Wv/ci3oMoPA/GEijv0vVLmvVl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JB7nDh0jZMJoot+/LROR8isbIZQ0H3e1HUtUFJyD2VxcfXdUJfUIckwTw38N45akT+ygDSjgRUen4BmHGUX5AtPnmHc3aoOJmUiyCmuuBapcqMa0rgBs4UQyTpR1GgSu2eAE7Sc0s9ad0BC8rqWuBCc3wCkgLLhM1bRHVpBsJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw/A62HV; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45fd464d51fso916664f8f.3
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781824911; x=1782429711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1ifYMp6eTzkqzEKoZeR2RnwxSQq3FkUzNIWNL2M6s=;
        b=cw/A62HVjv80TkF/pqxCxaoc2ONvZuE+avVJhirASf6O3QjkJXuekOD/kUgaGyrk5R
         /Jecbk5kX4UPxX/qOcD1fZWHNsnwfuUeEaCR0jauznlNdaedUC1ON9k3hBZNzHqwLLbp
         goXfOe8/8y/zgmj0s1UJgc+iag2WDnl+OASAtfGt3demVoYrEDxTMs4rDR3ax8pWg/QI
         mqe191mlkSb9o8pGkyiY8hTc3NUmgXOI3FXPWFaH+wsjUZf6dV00Hm4yUiZC/fGzg4Vw
         +jXpzPldW+2hUndwYM9tK650LrQW0jtIm0riTFeidevcls92Ivj7vgT4UryD0nliJCbP
         Ac2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781824911; x=1782429711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1ifYMp6eTzkqzEKoZeR2RnwxSQq3FkUzNIWNL2M6s=;
        b=fir9l0eGAelYk9EZ03yVd724nPnwv9ZJ/UWmSaJjBr391lKDgEUnIMMWlGVWropZe8
         kTFT3WgnqTgoW+7V+ddiiKAKQXWb2bThERFwMg9SC0AscfrvX1k4++C3T9C1ljuhDGGW
         4vF5M9akhoRMPoP9ljktp9yvH1e0JXdvwVUHIiqO9NOiFgIhANVq0fiomxgPmOmEr2HV
         5tc+0tup0yf2g1t4LXlXrtgOnhKfRFp4Xn6r1qKWsbrRfdG102xU/DWRU6lzftkvIWki
         EFT7U054mnNn997LgeGbYQ0vnzlX4k/nV+dAOBvMwgozoetE/3PgcxQ4gT68E8uL0fWh
         viFA==
X-Forwarded-Encrypted: i=1; AFNElJ9IPCH6rGTvqe6SpPi4EkHPMCg1HKwtxn4wgXIdkSITwM+GxiFHf3kT+8TLd+DBcw7qCYPDq4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3nwlTL5k+mP1AC7/XMgZGlZDdJVb3hMVokyel1DFl35GBDau
	Y3kHtobDWuV9xGcpDK/oxHBbyaPOt6HnoVvEHfHFcprpFG/k64sYvnP2FBbV
X-Gm-Gg: AfdE7cmkHT/mAQ+SEdmfJ1+YUQcAo2d7PSeX8OdH0beGeyMZMysEXZb8cuIAca5g39f
	xdNWlKvQSNNxU83EQvlGn96Nz6zYNG/hNgsE+IoglfzQ706c7qvP+geLZgqnmG+WLueIfc2hReF
	aZ1FeUZ2nDAYiPi33J7eYxn/YS72WOEA6rxd8bse9n1dO7RGMtddguCsSb/nBvr9L14bo5pPPyi
	qBt+NhSQoVqCAVv11w8lrXC5U6BfksSgTv47nUS3dG7kurUpRh2WnihhXBT5CCDx06E/mumoGxM
	9H6t5pGiGwwNhI5GDLWPqKvudipVVz0Te+g3m+SF+FfKxDU5rcyeUrIv0ZOHaVrobUdoXVwKbpZ
	oWEy1ioTlMZHudEnDm/c3I9x+XuCzoKHdy1quytlpcZ9wEto+PQfSh9CAmw==
X-Received: by 2002:a05:6000:2386:b0:460:1967:abed with SMTP id ffacd0b85a97d-46503646b28mr2545178f8f.39.1781824910620;
        Thu, 18 Jun 2026 16:21:50 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a0546fsm2619200f8f.2.2026.06.18.16.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 16:21:49 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>,
	Richard Haines <richard_c_haines@btinternet.com>,
	selinux@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] selinux: fix NULL pointer dereference in selinux_sctp_bind_connect()
Date: Thu, 18 Jun 2026 23:21:48 +0000
Message-ID: <20260618232149.1780219-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,btinternet.com,vger.kernel.org,talencesecurity.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267285-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:richard_c_haines@btinternet.com,m:selinux@vger.kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[paul-moore.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,talencesecurity.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59B7C6A3124

From: Tristan Madani <tristan@talencesecurity.com>

selinux_sctp_bind_connect() reads sk->sk_socket and passes it to
selinux_socket_bind() or selinux_socket_connect_helper() without
checking for NULL.  When an SCTP ASCONF chunk is processed in softirq
context on a socket that has been concurrently closed, sock_orphan()
will have already set sk->sk_socket to NULL.  The subsequent
dereference of sock->sk at offset 0x18 triggers a kernel panic.

Add a NULL check on sk->sk_socket before use.

Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 security/selinux/hooks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0f704380a8c8..e45588563caa 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5717,6 +5717,9 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 
 	/* Process one or more addresses that may be IPv4 or IPv6 */
 	sock = sk->sk_socket;
+	if (!sock)
+		return -ECONNRESET;
+
 	addr_buf = address;
 
 	while (walk_size < addrlen) {
-- 
2.47.3


