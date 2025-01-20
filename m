Return-Path: <stable+bounces-109553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF12A16EF6
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 16:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606E7168E42
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95351E47BC;
	Mon, 20 Jan 2025 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqqffAIW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F931B4F02
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385462; cv=none; b=HFvtgIYrNI7xVGaBsJhkku8SxTijjwtB/RDy132Z1ElCWYf/4THgVbGIgqZltCH5uBvAwdkpSVg/NfBRTNWWaX1R1k1o/N/2ZHH6TwXWvj+HXMNgxjEaQCvZEzjlz7cu2c1SmDMUgI7rIzBJV6CoDy+6uocx3BR0Kp8oizPigq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385462; c=relaxed/simple;
	bh=Mp9wPnZvahoTfrcxj7IbLva+CGbtXm6HhyL++sgSPfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlcyNUVmIOosQk6T7SAHdxVrQ+8bEzdxvh+E5Ij2XAS2DoqKWBiyl9PozsFVC+62EPo8K7QRtubgRqDAlpwI8LTpniaXODQiJs/LIi0fmWXI0KxxNGQvZ6n6tI8fX5TIogrdGw+E/2NrAh+kOe4FuZFS6mEZzqRenenbT086dIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqqffAIW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737385459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quucddcR/Yty1LzeCGy5sYBm3Eiv2uPTwCdl4JJA1hk=;
	b=aqqffAIWvcgxZOxXaPEm5R78DFA+5Smik0WLoFbf4RbcAEyJWniVQqCn1KVmzGVKm3ko+r
	CIIq+jx9stxqEH1a793ec7/+4W9GjS1PhzTlRg0gLgRX7IQJNwyeyFQTn4oxmfZpdUj1sr
	TQIB+O+a+IAgKFr1+PSUScHwOV0yWwk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-cF2dxSp6PNeNshPXtg3xFg-1; Mon, 20 Jan 2025 10:04:18 -0500
X-MC-Unique: cF2dxSp6PNeNshPXtg3xFg-1
X-Mimecast-MFC-AGG-ID: cF2dxSp6PNeNshPXtg3xFg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4362153dcd6so24042625e9.2
        for <stable@vger.kernel.org>; Mon, 20 Jan 2025 07:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737385457; x=1737990257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quucddcR/Yty1LzeCGy5sYBm3Eiv2uPTwCdl4JJA1hk=;
        b=IcWpIydAQ1yhWONYQ4p56Ge0MDnS9NR+7zICJNsc6C2V+3cN+dz7Cv0D8AY4U3RViy
         nYIzbJYjRPTKAc/8AWCVMDjQVEwoqq4m5B0dy7X2ULuaibR4VqutDeIn0Uj2wXICL1Ge
         +vUu1C3eEJUKtP+DLE2i/otvXqjCSy5Azg74bsgvSokvdKBZ+rBrsVX+kNiWDW2RNEXq
         etzmhFe8di6XYK6Vy6gox1THK98ymkMFfAiAun2EA9rIM+0dJfhASV9klTvS8RgTSTd2
         5m9u96neqlDQis1TZSiCCUIH4DhTTdV2gs3HgMhJjZpmG+tEYCwtbw4fhglDBm02zWw6
         S2vg==
X-Gm-Message-State: AOJu0Yy0zsRC/8+QF3ayQMeW4xOxJInruUa8SGdk2EDCu2JyAygpA9Tf
	Qej8X2J0ZMGrucvnlz/08L078QP6NLyMjvBxhKBo+FWEmKvGcYbon8yVaiiS0bJYCuhI0DfY9J7
	SukEwkZWLhxnRVudcldgHJ53I1+Jh3DY08ej/MyDKBAtN+hhMREKy/Ns72InR8iTGT/6O3VhfdG
	CCZ3vk0ghnX1NmN7wfJA+fy4e8tL4UuEUGvIlS0w==
X-Gm-Gg: ASbGncsScDz46vtKmQWjP+8kP9vmEmATtqr/KS6DDnkUZUCr8iQxdSe/JjtAu39C1fm
	QJTPe3sklx+unKsDO/yZEwGJyTH4DkINzNd71pMabFbaEFSww9yhLQgkkDQEHZiATI+p2GzUhpu
	hL020jHCbYudZ7u/eYXNhvgFVvG6O5NCMFrMRev5T4HpaWcJHjSUwkqkBrqNcUr6DAAVgbeXnoz
	oeUIdXFgucTEDtT0CPIIiyRNZ1VqH1II2TnX3jMPeX8WKHuY14C15MVcSm2/qM9onYZVM5tpfPz
	CpA6MQQGu0Feu71/noII8MKZtjph3S6kHQkfmRA1LbRIf94=
X-Received: by 2002:a7b:c8c9:0:b0:436:fb02:e68 with SMTP id 5b1f17b1804b1-438913bdd6cmr123792625e9.2.1737385456413;
        Mon, 20 Jan 2025 07:04:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEw9cUAiD74oJKONeEwGyEN5+hF1yb1s5WBFMS+h/TrFbGi5ROWRqJVMoppZ5MD26BpP7ROAw==
X-Received: by 2002:a7b:c8c9:0:b0:436:fb02:e68 with SMTP id 5b1f17b1804b1-438913bdd6cmr123791055e9.2.1737385455101;
        Mon, 20 Jan 2025 07:04:15 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753caf3sm199005525e9.38.2025.01.20.07.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 07:04:14 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Hyunwoo Kim <v4bel@theori.io>,
	Wongi Lee <qwerty@theori.io>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] vsock/virtio: discard packets if the transport changes
Date: Mon, 20 Jan 2025 16:04:11 +0100
Message-ID: <20250120150411.101681-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025012005-supervise-armband-ab52@gregkh>
References: <2025012005-supervise-armband-ab52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the socket has been de-assigned or assigned to another transport,
we must discard any packets received because they are not expected
and would cause issues when we access vsk->transport.

A possible scenario is described by Hyunwoo Kim in the attached link,
where after a first connect() interrupted by a signal, and a second
connect() failed, we can find `vsk->transport` at NULL, leading to a
NULL pointer dereference.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Reported-by: Hyunwoo Kim <v4bel@theori.io>
Reported-by: Wongi Lee <qwerty@theori.io>
Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Hyunwoo Kim <v4bel@theori.io>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit 2cb7c756f605ec02ffe562fb26828e4bcc5fdfc1)
[SG: fixed context conflict since this tree is missing commit 71dc9ec9ac7d
 ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index ccbee1723b07..90ed4ccd329c 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1158,8 +1158,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been closed before lock_sock */
-	if (sock_flag(sk, SOCK_DONE)) {
+	/* Check if sk has been closed or assigned to another transport before
+	 * lock_sock (note: listener sockets are not assigned to any transport)
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
 		(void)virtio_transport_reset_no_sock(t, pkt);
 		release_sock(sk);
 		sock_put(sk);
-- 
2.48.1


