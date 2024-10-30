Return-Path: <stable+bounces-89324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E499B651B
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3131C21B43
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C4F1EB9FC;
	Wed, 30 Oct 2024 14:02:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062AC1E47BC;
	Wed, 30 Oct 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296965; cv=none; b=nfPNEljOapPHhLVZWQenusBf0+Ik9K07WpTuxILtMjQcTZtV+Cnw7V0rpbvO1bwasaJ0Q9PfuMP6vyJKbijHs9SYhzfqzSPICFNBhJiwOwNbYAN9hkAEX2XIyNJMc7nhHy3DOC5OE855hPN31KpmRpiOYXoyRodCEx0LxGpLALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296965; c=relaxed/simple;
	bh=IRPUtmjRRRWTQls7HsvP5G4WzpSHfHn5+ycAibYhoto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9Y0FcP6fUGU9xJnjsfVJvV/YPmmbnzA8vegKSPFu+UF4T9rZagf9hE72jEal0NHTdBqSFF1UTpQhQVKOR3LfaxCxRnes4hD9stoicxokKbcQHule9vZMlwGc3b+uJ+DlUkzZC4IOEEj9jtq0l793RuSDlS8BDVVX5nIebmnjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86e9db75b9so991194366b.1;
        Wed, 30 Oct 2024 07:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730296961; x=1730901761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGmFgroH7JaHubQUsglUYJKecaiUoqcN47UqSxEZ5cA=;
        b=Ii/Lb9f8sxMj5IvgXgoFG4asxZUEZDwUP8OQWuL7CMpUdS9ujQPA5B2HJetxBqO/Zv
         DBhwWmJo5Whqjp5wgCvn2Q69Qtume1i/RUuLd7dRpa1XZGYqlhWlZJ0CORTr74PYRKL9
         52z9s9ifRj4ZJOUuys9DQ6UbzuT549rmZcUsc3QFSf3e8BIm9BHpn+lAGJ04p3O6LO1A
         3C+MjRw5ytNDMgTzWLLW1tyO4bHIok0ax/b2OQJarBImGFxcDyZmqib+aLYFXUEpCV93
         3LJsoKq5sG2k2owixHnnBSKrKsN3cPg7DMKCJY0NIUhZhXwU7ijCRF0kVaEdK0gij0a0
         H0bw==
X-Forwarded-Encrypted: i=1; AJvYcCXP/XDRqWv60bxRfu3fb8jLUsmvNgwkBVWLamShhm4OYWFPnhFaiR1iKiwUDMJi0PIOCE/jmf6/8UvFTqo=@vger.kernel.org, AJvYcCXmmvPqSTedMCqdBHReigCmc3zqugw5mpRVGBfnqt5Oy9uqQm945FfgkjFzxyzZrCW3HiPJQTCz@vger.kernel.org
X-Gm-Message-State: AOJu0YwymHST+tdoBGrKdyiXmU2OxYo5WS+yp8h1HzTzMlteUhg+eQPB
	TVVHPJnNDvUp/LCbTBk9o6pQp1GAQj/9k+OGyi5czKi+EjTr7vxa
X-Google-Smtp-Source: AGHT+IFLheYALN0Q+h1qZVZyYyfGjs+k4p0+ar7AYK/KpTy5X6XvSJSR4jgGNXMTmFntMr8STHZ0mQ==
X-Received: by 2002:a17:907:7f8b:b0:a99:499f:4cb7 with SMTP id a640c23a62f3a-a9de5ce4e4amr1512071666b.23.1730296960746;
        Wed, 30 Oct 2024 07:02:40 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7aa9sm576513066b.35.2024.10.30.07.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:02:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com,
	aehkn@xenhub.one,
	stable@vger.kernel.org,
	mptcp@lists.linux.dev (open list:NETWORKING [MPTCP])
Subject: [PATCH net] mptcp: Ensure RCU read lock is held when calling mptcp_sched_find()
Date: Wed, 30 Oct 2024 07:02:23 -0700
Message-ID: <20241030140224.972565-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mptcp_sched_find() function must be called with the RCU read lock
held, as it accesses RCU-protected data structures. This requirement was
not properly enforced in the mptcp_init_sock() function, leading to a
RCU list traversal in a non-reader section error when
CONFIG_PROVE_RCU_LIST is enabled.

	net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!

Fix it by acquiring the RCU read lock before calling the
mptcp_sched_find() function. This ensures that the function is invoked
with the necessary RCU protection in place, as it accesses RCU-protected
data structures.

Additionally, the patch breaks down the mptcp_init_sched() call into
smaller parts, with the RCU read lock only covering the specific call to
mptcp_sched_find(). This helps minimize the critical section, reducing
the time during which RCU grace periods are blocked.

The mptcp_sched_list_lock is not held in this case, and it is not clear
if it is necessary.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
Cc: stable@vger.kernel.org
---
 net/mptcp/protocol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d0e201c3eb2..8ece630f80d4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2854,6 +2854,7 @@ static void mptcp_ca_reset(struct sock *sk)
 static int mptcp_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
+	struct mptcp_sched_ops *sched;
 	int ret;
 
 	__mptcp_init_sock(sk);
@@ -2864,8 +2865,10 @@ static int mptcp_init_sock(struct sock *sk)
 	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
 		return -ENOMEM;
 
-	ret = mptcp_init_sched(mptcp_sk(sk),
-			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	rcu_read_lock();
+	sched = mptcp_sched_find(mptcp_get_scheduler(net));
+	rcu_read_unlock();
+	ret = mptcp_init_sched(mptcp_sk(sk), sched);
 	if (ret)
 		return ret;
 
-- 
2.43.5


