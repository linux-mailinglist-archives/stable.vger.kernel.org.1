Return-Path: <stable+bounces-238601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPW2FcO/42nJKQEAu9opvQ
	(envelope-from <stable+bounces-238601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 19:30:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA586421D07
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 19:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C9533034ED1
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F53296BBC;
	Sat, 18 Apr 2026 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4a7aoy3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140C2D7BF
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776533438; cv=none; b=Kmzo4qj3C3iHLHbWikMS7YRibUIhQkB7pe0XI4bCeIp+dD9Nno+KPrzUvtUtJMvzCRLThJYttm8mPvE4nDRCf12HP4baE01RDSiM6JBCJdFzDEs/uIAvBU6JzOwdaDymK4Rix6C3Pa3S82xRr38jZ0zV6dS8EzHy7Ut9dsAiGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776533438; c=relaxed/simple;
	bh=vv+uXWXTBOrZTKIXNUPiy6z/3X6izwegkuK8RtLwUfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/IC98SknvAtt7e4t1Xwdns391kUjr2xjCKNAcKPRDoqdLfmcFlsjxhp6LjDMwJjpHG4pF2Ol02ic9qcj0QFKRHdAmTBee68c++7K4fC3eafV3OqjN5UAgwthuRXa8fyDG6kcsHlsyloMK9V0wTknKYOoQRbU4/4vvbR7nUuIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4a7aoy3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35448ca4689so331587a91.0
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776533436; x=1777138236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lo0L+uxbWuB7MGwK8DGzVQOOZjXqL0ZQUgEg2W2lmI=;
        b=S4a7aoy3tUvTUTXw+BOjDg7X0HRrz6kWXCg9C2Yv65Nm5h5NuBjeZTpQDaly1AHg5K
         Qoiv1j2J1X6LgZs09hW/VRPoyqTM3mQFxAG5f03Au6iBd/LXz7jXsuujJYpc21DWUjKP
         j+eJ7imew6hzPXzC9jHoBfXL1GE4tHznPb+TTM/A5TiQW64X1qmu9oWsuOCabYOjKtrU
         04ijDFJpdOeOY0sFhxLG7es7YDROQGMMlUgR8Qw6MUsCTKcsJ8RxDV3hgxUBesppvVI/
         yCXYeySgBFHVmqHFeUbO/7+yFr8JU7ktyVwUTcJwb+roC7SEHPJ4bNWm1rWa3SHcjbqL
         TVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776533436; x=1777138236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3lo0L+uxbWuB7MGwK8DGzVQOOZjXqL0ZQUgEg2W2lmI=;
        b=adqwaM7IY8xsko/LjbDprxedwJ8poliNj1dP6DmLVEN82VEdJ/1JzIh3AURHP5HVT1
         0ze/5KxjGfKk3KTlMTIUjkXC2xWWNQBQV5jM8TNgPJ+moVsP/FL8ESIa0xrQ+Gc3j46f
         DKvxE07pdK7awm6lds/TDxN1xkC1AK/28ykHHgoW3q9IdnXYKXrtyjcwLgSeE4HmMtj/
         qgWv6iJRIGR5Jh+v3JXPbp330qN/DWfAA7CK3QsuHTsMmH7XCvN7YdsbfCm/hCqkkvAM
         PxnBENG9A6KaPVE+u083yrR8MlHV5iVxAYxrOG2aqM974eKjggLbzkM/0f5afb2T8JEb
         f0vA==
X-Forwarded-Encrypted: i=1; AFNElJ/Cxmu2/bSS0QtHntk0PPQ1I0As2Zw6x+EM5xK7VOvcZeMHdDfHF+8QyiuWz2gDuB21/U2xZsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8MiZfz8F/mJz+cWH7iZrvgFy9MNpH9ncbeIj1P4BEpIOon6Uk
	iZ+uY6fnm4uh0ajggSrBqmRCU9qsVWj8jTp3c2TsPxTrIhrCtrbocRHh
X-Gm-Gg: AeBDiesSt/jtSO5yg9JK7BVDi4fcNZWHPRZvZJUeE5rdnW6w7aOxyzn1IGNnTFAhjQY
	Bm1hZZamAoXfiQABPPgUpx59MHOvYWpwa2fdm/XqRQUEzAL0KRa0AXilOZULPNFEYWmO73k6P8U
	JgBaXz5/+ytxXqxWTpYps9feFsbmwn/KkgszMaZafGy4io8msIxFc9jxPs4TSeFAFn+9eRdu25D
	gUrdehO+vw8VkcE1sAykMj5RoDXcYWrIIF5AbZgbdHcnVwhqrkbym21/2CTUEqRMHiBazYgr9l1
	yQxCODHhFr/ERlkH15x0mSofjh5xKJTHbubrJtk/HFpJ36sceA+McVuPsWGta7ClYuxbMq3dXbC
	PAAQze7Y/j08KQq3NuORhXv+SBy/5ue2cYnry7UoTXDrsdXJW6HE+OGcbNI+hGEDiFYUkuuM88G
	LG7ryRv0gXgaKd3OBxHdl1wMjdmvk=
X-Received: by 2002:a17:902:d505:b0:2ae:3f3f:67c4 with SMTP id d9443c01a7336-2b5f9d67131mr40408135ad.0.1776533436099;
        Sat, 18 Apr 2026 10:30:36 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3bfsm69694965ad.7.2026.04.18.10.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:30:35 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: linkinjeon@kernel.org,
	smfrench@gmail.com
Cc: senozhatsky@chromium.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 1/2] ksmbd: fix active_num_conn leak when alloc_transport() fails
Date: Sun, 19 Apr 2026 02:28:43 +0900
Message-ID: <20260418172844.1333378-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260418172844.1333378-1-charsyam@gmail.com>
References: <20260418172844.1333378-1-charsyam@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[chromium.org,talpey.com,vger.kernel.org,suse.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238601-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charsyam@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA586421D07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ksmbd_kthread_fn() increments active_num_conn right after accept(),
before calling ksmbd_tcp_new_connection().  The decrement normally
happens in ksmbd_tcp_disconnect() at the end of the connection's
lifetime.

If alloc_transport() fails in ksmbd_tcp_new_connection(), the function
releases the socket and returns -ENOMEM without going through
ksmbd_tcp_disconnect(), so active_num_conn never gets decremented.
Under memory pressure, repeated failures monotonically inflate the
counter until max_connections is reached and new clients are refused
indefinitely.

Decrement active_num_conn on this error path, matching the accounting
rule used by ksmbd_kthread_fn() and ksmbd_tcp_disconnect().

Commit 77ffbcac4e56 ("smb: server: fix leak of active_num_conn in
ksmbd_tcp_new_connection()") fixed the sibling leak on the kthread_run()
failure path; this patch closes the remaining one.

Reproduced with a debug build that adds a temporary module parameter
guarding an early return at the top of alloc_transport(), forcing
the first N accept-time transport allocations to fail:

  * Configure ksmbd with "max connections = 3".
  * Force 5 successive alloc_transport() failures at the accept path.
  * Without the fix: active_num_conn drifts up to max_connections and
    subsequent legitimate mount.cifs attempts are refused with
    "ksmbd: Limit the maximum number of connections(3)" in dmesg.
  * With the fix: the counter is correctly decremented on each
    failure and legitimate mounts continue to succeed.

Tested by injecting 5 alloc_transport() failures with
max_connections=3 and verifying that subsequent mount.cifs attempts
still succeed on the patched kernel while the unpatched kernel
refuses them.

Fixes: 0d0d4680db22 ("ksmbd: add max connections parameter")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/smb/server/transport_tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 7e29b06820e2..400412444838 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -182,6 +182,8 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 
 	t = alloc_transport(client_sk);
 	if (!t) {
+		if (server_conf.max_connections)
+			atomic_dec(&active_num_conn);
 		sock_release(client_sk);
 		return -ENOMEM;
 	}
-- 
2.43.0


