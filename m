Return-Path: <stable+bounces-106235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2329C9FDC15
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 20:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5788C3A13D4
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 19:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF981607AA;
	Sat, 28 Dec 2024 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty8jqJUr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DDF1EB36
	for <stable@vger.kernel.org>; Sat, 28 Dec 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735413301; cv=none; b=U3iz1/66NjseiT3ljKAqA9dyLoD9s1FmpEX/v42EPX7yjSVRPnkbEMePGMnJwgJqR3fup93yiPcsuAT8zhxqtQIGtpvJozIHycFnH1NLfPfrHWPRwio0MIsAaEFA17mc6yb0Bj/uoavHs0WmcnTLNIqOJjtEUiXuDXlzMUjQAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735413301; c=relaxed/simple;
	bh=05/CWKPmNHnJ1kl0ZeLZkfHWsf3l3GKGPyn9G4+dKC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKdmPMUAslJDUS3xy0t6kh0pfOVZERR1seH8bO1pgfINZZQnG2rdrqNEya9ifH8uiJ60Hd77+32nm6GSo6BdpBBVX1MbDUQMnO8wKGe9OD01ERSizSioIJe5Vs201G9f1gn6bouDHHSO3Sq14F6oB+N8NXzkUzzeB7oQ9JMZQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty8jqJUr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2167141dfa1so99589755ad.1
        for <stable@vger.kernel.org>; Sat, 28 Dec 2024 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735413298; x=1736018098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wnJJrPymQsyi6rQn5duCSRWZMy0mcWIVLDm579CLt4w=;
        b=Ty8jqJUr5wcP8iTINlHfyJM3Pe05neqpylgAAH0+MiMcYJsZTs2RaHhBtQwPI86IS0
         f6wZJSGpSKoD0hkdxuoO4isbLJe0PHLv8A5BXDksScURcZt3QVNyehUrx3+51loLbdTE
         I2W7xrYo8Dm89Ws4Fk81dwHjUi2lQequhewnN5fHvw8j/qESKW31xg+eDkyAbj1/zTwf
         OK8tONXyqkbDDCLRwbNFljDgiGpgdTtLDWHpardrv6wSX26jR7mjoSKN4dA3cAYyHxVl
         6EK3ajZ5bGSWjwNFAKj0kCiVL8jbp0G0tibNhNXSXTwHHixPnr8f/agw9S4Olz6WVbdj
         1PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735413298; x=1736018098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnJJrPymQsyi6rQn5duCSRWZMy0mcWIVLDm579CLt4w=;
        b=umUf6S11C+VQoWqXqFCG+bwzy+Yz1FrTsR7aGHBYFGNRX8lnBaE7u8oJwob9jOKbv4
         QUHFllGQG5Qz3E0vyfKUmAOivO6WwgVreMrZovYTEy/ysUnyFZFYDXgXKYpyCKaNL9h6
         Oe7htvIrUPfrQgOyHh9fUAZQVcjsreY0KqPc4VvlkAlLePgZBUP4Dv8mRXOG0y39vKQs
         1WjBg+Yxc2acdpX3ySjRA85kWFeQ3QH471a7+rHWrO7o5XLUidYnR7zfJLTafS38Jn90
         NHJTO5npZydOnK72/yCz/NOI9GWOkruSFX6NwtFfJ0JD652kZEJwZnYAjw48UhH+qGnf
         84Yw==
X-Gm-Message-State: AOJu0Yw2/hFvI8IvbWpCOgrZDtDMgo0/yfJPDpkurgSSTayROQq/PzQF
	g1+npT68YI6TjGeaMHIrMzmtJq5c0UK6P5zoHFl7HVXbSGSp/IpoVubM9wcu
X-Gm-Gg: ASbGncvUBtih1ygJaaHQ/b8P94oc2L6MI2zn88Nkh6JgXkJmcDOaamvTiIIQKTrYOkl
	DdkjgYOfdoDUSEDqmuNPk5eBHFf2s0KvH3Ntzaz23T9v+TMiFj2S0dJLSvXtgpRulvlLF8M0tf6
	yzPqjlxr6cGU1D5OMnKh/gf9noEIwbQUa3pdJgRgDaHPbGxdUKhxHZdda0bUlfsTcYuiTj+asdt
	tFWHm2NSOSZqk//YPE+/T1uQfcLslWca5TDhqfFafqgZXORMWVIO6FONwO9khvMkw==
X-Google-Smtp-Source: AGHT+IFkoC9SPW7qkMAjCqRYGjjPXGamI0kjTGnW2vQrt9WMZ7J3vLGgTMMc2RaQc5jQ5tDYFXnIXw==
X-Received: by 2002:a17:902:c94b:b0:215:ae61:27ca with SMTP id d9443c01a7336-219e6d6b172mr523491145ad.26.1735413298299;
        Sat, 28 Dec 2024 11:14:58 -0800 (PST)
Received: from ssrish-desktop.. ([2405:201:d007:6848:f867:cbf3:5f70:299e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962cb8sm153227365ad.10.2024.12.28.11.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 11:14:57 -0800 (PST)
From: Srish Srinivasan <srishwap4@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: john.fastabend@gmail.com,
	daniel@iogearbox.net,
	jakub@cloudflare.com,
	lmb@cloudflare.com,
	kuba@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	Jiayuan Chen <mrpre@163.com>,
	Vincent Whitchurch <vincent.whitchurch@datadoghq.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Srish Srinivasan <srishwap4@gmail.com>
Subject: [PATCH v5.10] bpf: fix recursive lock when verdict program return SK_PASS
Date: Sun, 29 Dec 2024 00:44:15 +0530
Message-ID: <20241228191415.41473-1-srishwap4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <mrpre@163.com>

commit 8ca2a1eeadf09862190b2810697702d803ceef2d upstream.

When the stream_verdict program returns SK_PASS, it places the received skb
into its own receive queue, but a recursive lock eventually occurs, leading
to an operating system deadlock. This issue has been present since v6.9.

'''
sk_psock_strp_data_ready
    write_lock_bh(&sk->sk_callback_lock)
    strp_data_ready
      strp_read_sock
        read_sock -> tcp_read_sock
          strp_recv
            cb.rcv_msg -> sk_psock_strp_read
              # now stream_verdict return SK_PASS without peer sock assign
              __SK_PASS = sk_psock_map_verd(SK_PASS, NULL)
              sk_psock_verdict_apply
                sk_psock_skb_ingress_self
                  sk_psock_skb_ingress_enqueue
                    sk_psock_data_ready
                      read_lock_bh(&sk->sk_callback_lock) <= dead lock

'''

This topic has been discussed before, but it has not been fixed.
Previous discussion:
https://lore.kernel.org/all/6684a5864ec86_403d20898@john.notmuch

Fixes: 6648e613226e ("bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqueue")
Reported-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Signed-off-by: Jiayuan Chen <mrpre@163.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20241118030910.36230-2-mrpre@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[srish: Apply to stable branch linux-5.10.y]
Signed-off-by: Srish Srinivasan <srishwap4@gmail.com>
---
 net/core/skmsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 51792dda1..890e16bbc 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -940,9 +940,9 @@ static void sk_psock_strp_data_ready(struct sock *sk)
 		if (tls_sw_has_ctx_rx(sk)) {
 			psock->parser.saved_data_ready(sk);
 		} else {
-			write_lock_bh(&sk->sk_callback_lock);
+			read_lock_bh(&sk->sk_callback_lock);
 			strp_data_ready(&psock->parser.strp);
-			write_unlock_bh(&sk->sk_callback_lock);
+			read_unlock_bh(&sk->sk_callback_lock);
 		}
 	}
 	rcu_read_unlock();
-- 
2.25.1

