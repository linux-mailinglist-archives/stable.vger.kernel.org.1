Return-Path: <stable+bounces-108175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A03FA08A75
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 09:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA19E3AA39D
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 08:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D4E20B205;
	Fri, 10 Jan 2025 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1PPdZ99"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A2208990
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498144; cv=none; b=pJ2dLSiWj1euC5yn0S3JrMJhs9rgBMty8OX/LV+8MAXd3R/1Uk5vciT8IczJyLJMELqGWX8rpKUU30ZgNTk2fc3/IH+siSr/QU9lR6nCvGiDtmarf/wY46WEZR0pyBtEaXCSA+kXXs6tblAqiw6ZlEcywMILrCowAzcWxI2CkNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498144; c=relaxed/simple;
	bh=uPsduUWhdScehzIkWWVjxwh3m7xAtK9UHuNXKkdV3cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzymEtnorTlB5xM2MkQmVSZ2OrsikZP5QUEtpVGA98+jtpY1eXXBXc87knP/Mog3wWZ/ma/ht21F9/e7hQP5tsWiWShwoD73nBDSoCc4gmJAnpvBGdtvksRxsjC/5om7VBn6Ctd/k4awPdXzcfJFiGJ9BwkeF0CS49Q7E/9lG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1PPdZ99; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/UxJFQhjZHiTLyDu6i94GmVxCXul14lCOVKyB1E+sY=;
	b=P1PPdZ99n92Uc8zsuCYTOeZlzGlJxfQS/MdOUwvWN4jZpsSXH4HhxlXpBPMmW1VMV7E7ie
	WpREVjgCOgbdg8QBx4SnprjyRyKeQChMUrYPUMfKtsyFzGL+gxBUM6fdOnVjlui8GssAdj
	rLd0OH7bg++sr8DLtp4oSC3aGhjBMIU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-OVoqZCSzNQ6eJ8dlnX3STw-1; Fri, 10 Jan 2025 03:35:40 -0500
X-MC-Unique: OVoqZCSzNQ6eJ8dlnX3STw-1
X-Mimecast-MFC-AGG-ID: OVoqZCSzNQ6eJ8dlnX3STw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862f3ccf4fso616513f8f.0
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 00:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498139; x=1737102939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/UxJFQhjZHiTLyDu6i94GmVxCXul14lCOVKyB1E+sY=;
        b=QIG8of3OisrKIlzmR6ylKrxgUHNLI31+EO4Ke8Go/xy3AIfEkVTlzXiXrtDACDKp/2
         EAzn6QZ21VjlQGEVqoNah0/iIqwxn+8Ri2h6Rr4cbg/9WTdr96ZizZfVwd7ysCH1zuvf
         16PivfvkV/IBpn45AiFAizTZdYxUi6pgCp8vl8lbcdRp7YG1cZ62xgIxVHrzP5dPAwuS
         VuvLGql609xWQHUpif4ZNG3t98XlW3XV8zdKp9DHKVT23He7X/IU3RZjRM/MTjs8yOj6
         HhexMHn9+k59hKm3KKu7yaqRizAMFBqVPQjeeUDpnpl34F1Ns4hRw8kF91+EGWKH5gho
         7O6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMfiHIvnGhTEgnhiCdEsejaTpwKO6sTwGsxvSnN5sGmyypuhibLWuG+D5U17P0FXYuDAJfaH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3IRWYI2kQkwTGNBaLF9283DXvvzyUAkjbNWCHzwMoKY1ei9t+
	jJgVwd3yoVkf4D5vfIAyMoWx2/uXyhph1HfpjQO5BC2EJd0QX82fKw6DwVNvuK5ZZgUG6ONogAN
	b6O46ACbv4ddoy1SIz7LnLMhnWyR3BBMfz+IFqebKyXDIRPTka+SUwg==
X-Gm-Gg: ASbGncuX+GLnjy2F+oYTpAJ0zptP+aZJweenWRrnC2DD3C4bCUQhbHJrYPmYBVNaDf+
	Gls5g3JsIJaeR1Y76M4bsB6VocD06UrYHTQVyAwicflCus9fe9TzMmfoD9G5U8h8GHiE9bK3q0o
	3YkAju/syYilmlOKjR+4608xwkRiJSFEuyrDI/H+HJwbEUkl4LuQygcMRRLMSfxk+fMNvNnFj99
	Mi4J4QCkZ0Kye//vNd5gyhN6dyr4j42pFIBLU2XR9fJhV0=
X-Received: by 2002:adf:ae59:0:b0:38a:88b8:97a9 with SMTP id ffacd0b85a97d-38a88b898b4mr6672309f8f.2.1736498138763;
        Fri, 10 Jan 2025 00:35:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0wfwdkUAlCHyAfjqywZwwjbDz7xJE+/6M4bU0+8jxnFXT/mEU5AdPqfdlVeWVXgoMTeKpvg==
X-Received: by 2002:adf:ae59:0:b0:38a:88b8:97a9 with SMTP id ffacd0b85a97d-38a88b898b4mr6672275f8f.2.1736498138249;
        Fri, 10 Jan 2025 00:35:38 -0800 (PST)
Received: from step1.. ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8214sm3895187f8f.78.2025.01.10.00.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:37 -0800 (PST)
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
Subject: [PATCH net v2 4/5] vsock: reset socket state when de-assigning the transport
Date: Fri, 10 Jan 2025 09:35:10 +0100
Message-ID: <20250110083511.30419-5-sgarzare@redhat.com>
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

Transport's release() and destruct() are called when de-assigning the
vsock transport. These callbacks can touch some socket state like
sock flags, sk_state, and peer_shutdown.

Since we are reassigning the socket to a new transport during
vsock_connect(), let's reset these fields to have a clean state with
the new transport.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5cf8109f672a..74d35a871644 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -491,6 +491,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		 */
 		vsk->transport->release(vsk);
 		vsock_deassign_transport(vsk);
+
+		/* transport's release() and destruct() can touch some socket
+		 * state, since we are reassigning the socket to a new transport
+		 * during vsock_connect(), let's reset these fields to have a
+		 * clean state.
+		 */
+		sock_reset_flag(sk, SOCK_DONE);
+		sk->sk_state = TCP_CLOSE;
+		vsk->peer_shutdown = 0;
 	}
 
 	/* We increase the module refcnt to prevent the transport unloading
-- 
2.47.1


