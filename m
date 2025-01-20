Return-Path: <stable+bounces-109561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4996CA16F43
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 16:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AF77A1F55
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB871E8837;
	Mon, 20 Jan 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUAN4hGg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D841E7C00
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387198; cv=none; b=p7qwJ3qeexj6CPkVqHVnKvaFusnOKymFZqBahcustZ3TIQ5zEJ7anoXyJ3qdL0ABgephx7U24+2QcL8Uv+0XRl/bbrEPIsHMVyfGHyC5HxqaSI9FYsxx4aRR+V4sOMKtKRD96gktxZJV23yzs6vV45s0AEKtD1RM4K9AwD4o5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387198; c=relaxed/simple;
	bh=bYKPtLOr43A5OTnwTGtxr5cNbwxqAfi7LHcm/WQ8QWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfM7Y9Js2+h/xCZpWkg8EMnqNU/9aAH5wE1W3T3xK6IOHohkAqjm8SusjCFmvV8rVrKk6NToL0DVpkxojSzMaXHNs4TQqjjcpfuFygGVkgAW/JCUxGt4PSP6zpnUuyhvusFKCEV/ObJCrbBBztopao+qejd7Ho1PlKDcwU2GjlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUAN4hGg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737387195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hNDI6BrmozmrJx+YHos2c05rIsWF1iLe6J05SQb7fgQ=;
	b=gUAN4hGgvrayRxhZecRY4VJBS1noORwlA1UPzQ5EHHvmn4UsoQBlKClcX7N6w7uC2N4oQa
	AfQeCft+cJRmfm1xtnbnkLwnTx/AwrPUv9htEYfhX7IhMfGYAW3OLUxga83Iv/JR0Fe08y
	GIgzqec8zAEYf7GbTmARzNizSNOVTPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-zwXEzrZYMM6ciWEG5ig_7A-1; Mon, 20 Jan 2025 10:33:09 -0500
X-MC-Unique: zwXEzrZYMM6ciWEG5ig_7A-1
X-Mimecast-MFC-AGG-ID: zwXEzrZYMM6ciWEG5ig_7A
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so25200985e9.1
        for <stable@vger.kernel.org>; Mon, 20 Jan 2025 07:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737387188; x=1737991988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNDI6BrmozmrJx+YHos2c05rIsWF1iLe6J05SQb7fgQ=;
        b=HWHsVLPAQqtVD/hFegvZ5EvcDWDk9tWzfIkEqeeTd4dabv0HlHwuOhH5wN8rdferli
         4cHboXVMiAMJ5hNGsBkEf0MO3SqZdvDxmSnsvettvPY4fMVTQkinUKWFkhBfPXmsGsvy
         mgrzjVcCl9McyU3mO8STODM6BYrFP97GIN7J4D07QP7Gr91Btp7GFlQ4oost3y1Gv0xy
         L7UWdVTSMWa9nB0WDh7AjHt8aGl2XB7MGaWd18lFuTOQ7U4rsgLd1HPL/VOVj9GwDIS9
         89CrQyB9wZRjWmcFo0f2onSx5wzCNBENcAc+hE4V7175XOQSztB6f2OMKbF0sUudlYSz
         Fqlw==
X-Gm-Message-State: AOJu0YwgFNPR6YEhhUyzS20tsbj1fUU6V3zONM94CGfbf8TOZjnLQZSZ
	Jq5IsbbddJGYQa4nCDePEQL51KQMwaw+JRx04v98F2Xrz7paqnMvPvS4GguIB503rELxTMCdleA
	puuOr93aQ5XaFzVv/PYE8azoNgW0qutNgk6wh44AK52qOch6NsuetNFEA0z7jxkVqZSjgiwuEya
	bH9CEJ5lLVYadUSSD64A38CQz3J7DZKocXEo9IBA==
X-Gm-Gg: ASbGnctdzIovPioXragqLY2ejZPZcuLJ9W4YyTp8Tn/yYEFJmf5/gXgA2Bted1zEk6M
	qkVnGYX7w2uDAqJqrTNdzYrNeRjahHlhe4a3Wr33JU/VuuIyPvW2WMNnn0bUrArzJOAd/nzigCE
	sF4R5KAe9cEtvR7UoUgXC/g+4WrZj1j3I5tjmf6nFqr3LJFO2pBtAceT061r6Uy5XnoxU6HC3mf
	LqfkHEE69/eqIku8vb7lbcCk7FZ728l5LQQy6OS1KEq/TJogQes1zvXfyo59xVdYhV/OiTs0YnJ
	AXp6D8PZK/g8nBfQ3WnSwLazBS2ONtXsaidpNCkldS/6OCY=
X-Received: by 2002:a05:600c:1f8e:b0:434:f82b:c5e6 with SMTP id 5b1f17b1804b1-438913c7ed2mr105474505e9.1.1737387187612;
        Mon, 20 Jan 2025 07:33:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzb5K+wn588SV6h4eKqgcvh/KM5HOZgCw7YZ6d3DVBS3IpdWfvs6q1PS9kc9KAC+xQoOL/Iw==
X-Received: by 2002:a05:600c:1f8e:b0:434:f82b:c5e6 with SMTP id 5b1f17b1804b1-438913c7ed2mr105473965e9.1.1737387186818;
        Mon, 20 Jan 2025 07:33:06 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890462195sm142867435e9.30.2025.01.20.07.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 07:33:06 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Hyunwoo Kim <v4bel@theori.io>,
	Wongi Lee <qwerty@theori.io>,
	Luigi Leonardi <leonardi@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]
Date: Mon, 20 Jan 2025 16:32:03 +0100
Message-ID: <20250120153203.217246-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025012045-irritably-duplex-5af0@gregkh>
References: <2025012045-irritably-duplex-5af0@gregkh>
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
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Hyunwoo Kim <v4bel@theori.io>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit 91751e248256efc111e52e15115840c35d85abaf)
[SG: fixed conflict since this tree is missing vsock_connectible_has_data()
 added by commit 0798e78b102b ("af_vsock: rest of SEQPACKET support")]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index ce14374bbaca..d1ab66b90f8d 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -828,12 +828,18 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
 
 s64 vsock_stream_has_data(struct vsock_sock *vsk)
 {
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	return vsk->transport->stream_has_data(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_data);
 
 s64 vsock_stream_has_space(struct vsock_sock *vsk)
 {
+	if (WARN_ON(!vsk->transport))
+		return 0;
+
 	return vsk->transport->stream_has_space(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_stream_has_space);
-- 
2.48.1


