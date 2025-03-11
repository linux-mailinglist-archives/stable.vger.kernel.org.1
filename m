Return-Path: <stable+bounces-124082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C418AA5CE49
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81891189CE14
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B1263C63;
	Tue, 11 Mar 2025 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qQxbR3Aw"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77598263F21
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719319; cv=none; b=Q8l5CZJkBW1Zxe0DcOI21q7rHyElF5615nmZDmDZbUaoK+/Zkw1uHPbWA8JtzADxTc6rcSrsPrKYu1KowJdEp6rGJj7EkemsMuZC38FlrcTxiB71k1omxBHsCte1cKZ6xS4OrlckXE3fKNSk2CIQVyOQUBX/qeKtH5d3GEkLlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719319; c=relaxed/simple;
	bh=lEv9KAefd2yfb86VxG1Rub41m4O0Iv5J9qHlmrrwolE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EuTVd1wnT0N8skjTA3rWyvezVF+4zfEFJfYqQlUmRMZDPoHOsB8fj/BMJIveMTK/NzozKQILLNPI8rZA73mw2XWwH7ejJ3tOtPpQCrgQfKpLl0pGAfFL3eBno38VHl39r4hEC7YrcgELhI/WqY4SGmP+S1IzqTc/3yXE15r5QGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qQxbR3Aw; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 358DC3FCC9
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741719309;
	bh=RQ2VDqmBaVKoQBHQqIkL0ZuVfNAHWQdvrcZqI3qFMp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=qQxbR3AwZO3pl5Mjo3g0Wn/bWwdFAjaHoWGqPb3Zu3wXZIBqIouTZEsluNZvO1W2G
	 kFXREY/2kxcGtMg7zEuzziQ4jsegOGU7UmHGDTOYK/AbIdHfHJz2bzLeMPM8YCat87
	 cgJA9B2Sh1hdu+vIIMyxvf8y2Z0B0BakePu9v9C2uvfRdAYC5kugLA9RJSA4x9LjKr
	 ZHkRzVTb8noEND7jZLHzq7bZyvG+3d573Y37Bb88EKcl+//qZpYax3R3JxeUoWkmhQ
	 s3iIgNAt1tH3QpKPLwgJOytME424MPPYRBgIu0elaH6jBsUSYnQOMnVMLfuWIk20kx
	 hbuzv8PMQEHnQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22412127fd7so70149465ad.0
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 11:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719307; x=1742324107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQ2VDqmBaVKoQBHQqIkL0ZuVfNAHWQdvrcZqI3qFMp0=;
        b=EDnvL9tbZ8qQwIt1+bMwWLeuB06td9cn65w7AnePSbZwXDC3rfb10qNjVXIBUBu/7G
         Zpyde23tpVdonFggaEHah1R1HO+tm5VEnk0H2XSjMo2W3IyuHE9vDcErD6w91J66gU4D
         l3e/K1hKJA7W2+QD9iOEa9wT5jzTZrUlbH9lxl+4ti/2J9aRbq/9087Ut8D8wubscTHN
         uqngO/LnTZnFjDc3pX89EDYq9jX4xC820SbvJda/zJU4+HxDaHrA7oz4E9kp+pu0ajcJ
         mGO3q5lsieQzBCeDeznk8DhWGnqBgE9oaDnrt0sbN/PL64uDeYGkdSXu4nBDMTiBxw0u
         OgYg==
X-Forwarded-Encrypted: i=1; AJvYcCXDSRRCDq4O7MVKxq4oeV67J+wVxWCdqhg7dlZA5gyWdHi2q0erZHOIualGE9oyUr3kDEO+KVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLJU66f+QKzuFFw8zI/HZGLFPqp7/9uNCGRJuemrpQtQ9tesda
	BqkuFcUM0ksmHUs6uilbwyIU/rBpMoNbtPCmR9G5NIWfSAneylqSTqX5ueq5B9IqChtZ+yUo6kp
	CE8uSkGf/wPFJt+tn3vtIYoVwaslFKYvu9IiU6/YroEaXcz17nJu0S9L5sWzjtmM3aHL3WA==
X-Gm-Gg: ASbGncs+5AWmpwcMpLaQIL1MUfQfJ3UH21dwHGS+T6dFYd2muIFC/8JHxt79NuMy28q
	ioHpjqqrAz23Y73LAHMcBFdviYZF/4nOD/a17oul9+yUGkOX+Jvf1wppQihsWD3R6+WboxQVa7Z
	np6zNARbTmHWA/HHg3uYFngl8FSGzbg1XvVmSddVBbvVdQIOvS1d2pnIGYlGJCSdEM0ASUI6c39
	V1DiZ2Mr29Iwl2vHU0g6hSEfweAaXmxWlnq73RJ3QUbLylrAvHjRMEW6LdKh+F7k4Cu4GN/ASHd
	2DT70SqzNZxk0RcY36b5tAvscLquxsJ0ufLNwI4=
X-Received: by 2002:a17:902:e810:b0:223:432b:593d with SMTP id d9443c01a7336-22428c07537mr278500605ad.42.1741719307280;
        Tue, 11 Mar 2025 11:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFODX0DpL067+G4X5LwxSNwfKA8jfMsrOgCmOYv3Sj+MLeddpbtqGnpwrNflh6318Q1zeKNIw==
X-Received: by 2002:a17:902:e810:b0:223:432b:593d with SMTP id d9443c01a7336-22428c07537mr278500435ad.42.1741719306917;
        Tue, 11 Mar 2025 11:55:06 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:14a:818e:75a2:81f6:e60e:e8f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f77esm101765875ad.139.2025.03.11.11.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:55:06 -0700 (PDT)
From: Magali Lemes <magali.lemes@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.4 4/4] sctp: sysctl: auth_enable: avoid using current->nsproxy
Date: Tue, 11 Mar 2025 15:54:27 -0300
Message-Id: <20250311185427.1070104-5-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311185427.1070104-1-magali.lemes@canonical.com>
References: <20250311185427.1070104-1-magali.lemes@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 15649fd5415eda664ef35780c2013adeb5d9c695 upstream.

As mentioned in a previous commit of this series, using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The 'net' structure can be obtained from the table->data using
container_of().

Note that table->data could also be used directly, but that would
increase the size of this fix, while 'sctp.ctl_sock' still needs to be
retrieved from 'net' structure.

Fixes: b14878ccb7fa ("net: sctp: cache auth_enable per endpoint")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250108-net-sysctl-current-nsproxy-v1-6-5df34b2083e8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
 net/sctp/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 4116b3cd83c2..f6fe63f60acd 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -442,7 +442,7 @@ static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
 			     void __user *buffer, size_t *lenp,
 			     loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.auth_enable);
 	struct ctl_table tbl;
 	int new_value, ret;
 
-- 
2.48.1


