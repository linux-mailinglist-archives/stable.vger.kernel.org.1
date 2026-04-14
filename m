Return-Path: <stable+bounces-237980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGv3KrzF3mlOIQAAu9opvQ
	(envelope-from <stable+bounces-237980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 00:54:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 215873FEED8
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 00:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC2093074CC2
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 22:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DF03AD538;
	Tue, 14 Apr 2026 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0kBa/tN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E938654B
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776207287; cv=none; b=tJ1eTzDWk8qYhlPcW3T8p9+JF4cJwv/JaPqwg48M6fgwA9lNSriSRm+peob+CIPelJOXFl2S+npi0GSUjr6rxClybpa8riZMyi/u/K/1mpggFPNGKXvWZHk3nH27JJKeydqS3oBV3uxtLWSnF9A/vwKvA/JS0XGOjqbjj0KUysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776207287; c=relaxed/simple;
	bh=ho6A2HcxcWcGu1Rs/FicjzU6aBukuBzdo9A82COYqT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wf0k/mu7YuW/nXgxZVL6Uc+SE5tB1XC6NCmGEd6K2vyzedq4voOyqAuIX1mIILlyvg2iPkeIQlM+Wl01x++3nPMoo4NqQSjqfqoct+vJuQO7KHIkgmTYRDpOx9PwujYRtFN9p+mpcZB53Ga3qhpjBwYmKYDUifkw5EyT2ac1g3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0kBa/tN; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89fc349b5ceso95230076d6.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 15:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776207285; x=1776812085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NaXGnHrbdCiIDMKHtNSSlUWGn4HDHfRgUpLhX60Y0kQ=;
        b=n0kBa/tNgYA7MjP0BOt5GCqSEI+gzP29KqZZ5YLKRqdgPAj7zDBq500Jt5ARiItXc8
         56ykvObPRKDuCKn0bZl73DGw+5/uKFBS45kTK3zLArp2iJ5qPfBzHeCdXCckCLIWJYd0
         6t9ioGjnPsri1G30PoOUWGiZRkcFvCVyxHdjwXt7eR42yshiaubcT1b9zjviPPqpxD20
         hLjwMvkMdJZYitU3EZvNcX9E1FaaNfWWjG0s3KnJNfkTF2xYEQPjEWtdlsNepGs1c+8k
         xYmedJVWrYc6WZLxrVCSOegQX+sXE1laCwlEWrnIfSNUOXiC71oTt3jJEcW/wWZwjRKa
         ucwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776207285; x=1776812085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaXGnHrbdCiIDMKHtNSSlUWGn4HDHfRgUpLhX60Y0kQ=;
        b=VVNW9stilbsLW/bddLPLlImhXDFQ/l/5nQYSly7EoMN/ufLj3qAAGzBK4Q3eZgqAMp
         QHhed/R8VpUtaQq/cPliW1dViDEec2dLqoP2PE5/7T+mCnWqlcezdwt7k62HRueh9soX
         7hgzKbtQ5cbiqS8xUrN63bE0i0t2jhWrve/aPQs0y0SfFUnEWzXmlQKQijga64gX6KM4
         PjdQ2BrLR/1oLLSSlkfvDNqOR44NAqizQpxytQ0KhXJN60x5D2t1WLuDK2sFZ0fChHQm
         BX42aoj+pxbHlZtsQ9bv38x/T/Rqhq6hdbt+2ncEHQBI2A1eXErKKolEm6DBbsMsYWen
         j00w==
X-Forwarded-Encrypted: i=1; AFNElJ9EBgrn/TnEmSNjjGFgRN7EyK1OodjF+oZ89xhLdMRGoxSHb9WyPUjaIMf3DkPBooKUa2K8hU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Atu7NNIdBtd2bT0HsOy7eS11FIwxVNJYEKBdSCQHmGyxl1gd
	lZKjgrizwNBDKUPEDHUXpMbhVnRVCH1jQ7MV1Mv9Fj+0b4mW6QF5OotTXEYMkw==
X-Gm-Gg: AeBDieu7psMbX/h6T/YCo+aBc8PH8VYxz0doQntD5570lfaAasl6RP8iD/F2t91R4aP
	Z4JM2uoKPL4TgLhMFlkUtdkGUdb2YzUkApa4Rh3hKVz4Xt6pILkV+vYS6q8FIuQdd9ZIwKslqSx
	lFH5clJmoj5YyErG8WKbf7txd/ynPNb+LShX5Q20N3r1R2yAe8OLHYk+QlX8dzaSCgZmdBfT94L
	Ysb+BoZWzSCqOlpUez24IiwTfYoHFrXFMaiM6lYqoxfVSROoeqnaFtqdDlBmverDVsclue69lCU
	KRucoN8OlZjYbw6lvIm4IS0CanEMVWe8/RUJxYHhqYtaIjjaOtN/o0yOBUwZ/ZR43Z4PsvQ5lMW
	Opjsx+9dV7tacKQzvXdwvdkXIIibxRAxJkYHtMeA12rsSsJZGz9UWMLi6phavGQSEkFuwrEQw5J
	e622wzLP78J7O70EmuzRY6sf7d/mdH2auxpEkY9C4J8Z+xJjR+Zg0NNWBrplCFPwIe9PWZGqMd7
	Qe7BBanO0YzELNEvcA4iW3s0ekEjvE=
X-Received: by 2002:a05:6214:808a:b0:89c:bcbd:c26e with SMTP id 6a1803df08f44-8ac862e0e88mr291184596d6.25.1776207284790;
        Tue, 14 Apr 2026 15:54:44 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca9f7e0b0sm70648316d6.11.2026.04.14.15.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 15:54:44 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-cifs@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Henrique Carvalho <henrique.carvalho@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	stable@vger.kernel.org
Subject: [PATCH] smb: server: fix active_num_conn leak on transport allocation failure
Date: Tue, 14 Apr 2026 18:54:38 -0400
Message-ID: <20260414225438.2210243-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-237980-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 215873FEED8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 77ffbcac4e56 ("smb: server: fix leak of active_num_conn in
ksmbd_tcp_new_connection()") addressed the kthread_run() failure
path.  The earlier alloc_transport() == NULL path in the same
function has the same leak, is reachable pre-authentication via any
TCP connect to port 445, and was empirically reproduced on UML
(ARCH=um, v7.0-rc7): a small number of forced allocation failures
were sufficient to put ksmbd into a state where every subsequent
connection attempt was rejected for the remainder of the boot.

ksmbd_kthread_fn() increments active_num_conn before calling
ksmbd_tcp_new_connection() and discards the return value, so when
alloc_transport() returns NULL the socket is released and -ENOMEM
returned without decrementing the counter.  Each such failure
permanently consumes one slot from the max_connections pool; once
cumulative failures reach the cap, atomic_inc_return() hits the
threshold on every subsequent accept and every new connection is
rejected.  The counter is only reset by module reload.

An unauthenticated remote attacker can drive the server toward the
memory pressure that makes alloc_transport() fail by holding open
connections with large RFC1002 lengths up to MAX_STREAM_PROT_LEN
(0x00FFFFFF); natural transient allocation failures on a loaded
host produce the same drift more slowly.

Mirror the existing rollback pattern in ksmbd_kthread_fn(): on the
alloc_transport() failure path, decrement active_num_conn gated on
server_conf.max_connections.

Repro details: with the patch reverted, forced alloc_transport()
NULL returns leaked counter slots and subsequent connection
attempts -- including legitimate connects issued after the
forced-fail window had closed -- were all rejected with "Limit the
maximum number of connections".  With this patch applied, the same
connect sequence produces no rejections and the counter cycles
cleanly between zero and one on every accept.

Fixes: 0d0d4680db22 ("ksmbd: add max connections parameter")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/smb/server/transport_tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 7e29b06820e2..8d7fe71f525c 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -183,6 +183,8 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 	t = alloc_transport(client_sk);
 	if (!t) {
 		sock_release(client_sk);
+		if (server_conf.max_connections)
+			atomic_dec(&active_num_conn);
 		return -ENOMEM;
 	}
 
-- 
2.53.0


