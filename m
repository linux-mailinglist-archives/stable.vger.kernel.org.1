Return-Path: <stable+bounces-108176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E947A08A77
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 09:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3D53A8D88
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 08:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4D20B7F2;
	Fri, 10 Jan 2025 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWoQpmNj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ED120897B
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498149; cv=none; b=OKBv6XRIw7mcJ77E0faFYf5CGHKH1i90GoulTJRN1vZaWnMdiJK1cgVYUyzEcj7Umh1ppvWrTSGeGdWtk3//ksK8ETiZaY2JNDqeZ23ZtOgC0sE1AtwizR3FLKNm539rthFw/BDPuxsCx9nifO4MQN6eww65BFwAFWE+QNGIm8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498149; c=relaxed/simple;
	bh=ZkTGYail/OHpw8whko7T8HSpEewACyZ6yzZNkHMM848=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJDPov7b08z1Tip7P/gcXvEjmFBqH7nLR/hUwo0mou/DE8932lY7bTrc4OKX4Cxnj1Eny0vSpUPArS7C1908fXSJj9TfGHSiscJZgwqESvTbhBnZBdn2Vkx5c11+WK+9U/8onKUhsBxPmLmYBXrtf43632hu23WDox42jlPhRAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWoQpmNj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5v5m4rv3lPn2u8LD9NON66qt3Pvib6QUvVJIVTGvfw=;
	b=hWoQpmNjaZ9KNQGE+LwN5kZc6fi0+Qe4Xqan99Z7WjYHMu+UEYtAoSAn28HHmH8jctwwj5
	CzY1UTuaeI0yq3w3/0spm8YOyYh+1hvtJ/fJFnsqffjajjQ59NpmKdZoDoldMu7GyNk1FN
	KZnyW2owg/BwZ26aPAJKZazANZ4trzg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-UU5OWAi1MUGx1zu9HI8MsA-1; Fri, 10 Jan 2025 03:35:46 -0500
X-MC-Unique: UU5OWAi1MUGx1zu9HI8MsA-1
X-Mimecast-MFC-AGG-ID: UU5OWAi1MUGx1zu9HI8MsA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43625ceae52so9655455e9.0
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 00:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498145; x=1737102945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5v5m4rv3lPn2u8LD9NON66qt3Pvib6QUvVJIVTGvfw=;
        b=npqjgfnejzB/WuYEmey2fO7Ei+oB6SieJJFqch0Ncf4vGo368422Y/za5QJiJR1Ml3
         Nxd2GmrhyGqdtVtZ1xnqaYEmsEF/+WFgFzBzgy4k7/LmLR/fysfmdVhW5F7wA14oQjAF
         DuRJK97/4dqN1yWVmLckQF6GjJeUVL/HhNieiZ9o6S1H8PUlpd7v3xXQgFH9VZRU/tlq
         ERFQEXCKPk1SJSkDICneH2htfCDzsZRENva39jsV4Iy5cHQA2E3CjE2rYCSNmJTBUCqe
         hG1wmzlNkm49f8JBSHGWLamEApnl9htIgjjgGAhPCPOCGhOUv36k5qdJFgOY0vUgKLbM
         fBKw==
X-Forwarded-Encrypted: i=1; AJvYcCWgfox9WZho33MqL4cvRLCn3IXzbPe7H0+lfAYhNbIwct1fPaZx4Mg/JfuI7xv0SdaEknG43vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO6OcBlFmq5FMqaehPTs7SBowoNrJyTaupr/1VT6iz3ZqWHu1+
	q+yBs9Hqq+3Ga5qUJhc7hmbOm+LMyL+wTo/Q6ash3sflw0H4jVQxKBup5mpWnz4odcOvsJ3zHwi
	NRf81AF1RcRbplTeka6M3Jfh4aPzgeSmqBTeMSZPpz7/txJxpLobK5Q==
X-Gm-Gg: ASbGncsoCi/4/96szsN4DExic5tvE1uIr2tXYrfz1tAI/9Ylg7ZzIudwrHpDfJwRpcN
	fTgeL5HIZgn6l1YDEFqpH+2hj9Joa2a3AgQRn7Lb6h4BYkOs+zE5L5eIRluhusEpj7oKBImGmzo
	4sMkQBObyC/srmxJu4TfBzZ5JFyWqXnm08L9t+amDDTM8FhaiZpoXbuE11GaSxB+fzl6UL3RsuO
	OSR+cUgy33iH/axnNMKvzd6ISFlI0riiEPc95jXQRZI/mA=
X-Received: by 2002:a05:600c:4fc2:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-436e26803f4mr84609815e9.3.1736498144868;
        Fri, 10 Jan 2025 00:35:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpqRZ6c+WoEWD0O+MqMW8gszvq2OTzZ1nbLSdaSb4uThngbiKtv0ftXVfyIYyqEi2yR41t1A==
X-Received: by 2002:a05:600c:4fc2:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-436e26803f4mr84609315e9.3.1736498144222;
        Fri, 10 Jan 2025 00:35:44 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92dc4sm78738505e9.39.2025.01.10.00.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:43 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wongi Lee <qwerty@theori.io>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hyunwoo Kim <v4bel@theori.io>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	virtualization@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 5/5] vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]
Date: Fri, 10 Jan 2025 09:35:11 +0100
Message-ID: <20250110083511.30419-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110083511.30419-1-sgarzare@redhat.com>
References: <20250110083511.30419-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent reports have shown how we sometimes call vsock_*_has_data()
when a vsock socket has been de-assigned from a transport (see attached
links), but we shouldn't.

Previous commits should have solved the real problems, but we may have
more in the future, so to avoid null-ptr-deref, we can return 0
(no space, no data available) but with a warning.

This way the code should continue to run in a nearly consistent state
and have a warning that allows us to debug future problems.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/Z2K%2FI4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX/
Link: https://lore.kernel.org/netdev/5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co/
Link: https://lore.kernel.org/netdev/677f84a8.050a0220.25a300.01b3.GAE@google.com/
Co-developed-by: Hyunwoo Kim <v4bel@theori.io>
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Co-developed-by: Wongi Lee <qwerty@theori.io>
Signed-off-by: Wongi Lee <qwerty@theori.io>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 74d35a871644..fa9d1b49599b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -879,6 +879,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
 
 s64 vsock_stream_has_data(struct vsock_sock *vsk)
 {
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	return vsk->transport->stream_has_data(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_data);
@@ -887,6 +890,9 @@ s64 vsock_connectible_has_data(struct vsock_sock *vsk)
 {
 	struct sock *sk = sk_vsock(vsk);
 
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	if (sk->sk_type == SOCK_SEQPACKET)
 		return vsk->transport->seqpacket_has_data(vsk);
 	else
@@ -896,6 +902,9 @@ EXPORT_SYMBOL_GPL(vsock_connectible_has_data);
 
 s64 vsock_stream_has_space(struct vsock_sock *vsk)
 {
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	return vsk->transport->stream_has_space(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_space);
-- 
2.47.1


