Return-Path: <stable+bounces-188287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB02BF48F7
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 06:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F081F18937E6
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 04:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09337DA66;
	Tue, 21 Oct 2025 04:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1ap0kGS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032011448E0
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 04:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019330; cv=none; b=iIVIyGFPw9zcXYmob0qDVmFCPDqcuvlw/8hDHehMORKZ/8e9LX8TS7Vii9wbZ/JO5fNXKq8hd3WU5WNGN67x/0ahXuPT2yEgyi4SEKdE1W2KYocgnRwj9hIJTuSdAMx4ksPbTlgEq0o9s86ZY5blncUGyvlXniHYTBWo74WEmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019330; c=relaxed/simple;
	bh=wDzEUsxTs0HUyl+iDwt3UIdWCbndTkElyHk0pfl57Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=HOKiGof+QOfOiJzLAWJ/+bemAdd+v2YAlJ+n34/HZFb44xaGmo4OwCqE8H6qC6tcqXAyoT8p3rLHymQcpTBbMFSP76syZiDGFndEwWANlzmBt/4ne58jShSoU9Ipm4ZxnJLOy8XWzSSQsyMhuNl03nGbZrSNTXzifftYwz0bPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1ap0kGS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761019328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rL7lFmSI7S3KHfZ01SLxw49A4U6D/hN5WOkCgf3+TU8=;
	b=Y1ap0kGSghWJ067U7zdZZuoRC/Ruve6YCMvhQF82aZtf+EYcZY1fA+5Pq4cJjqz/b2hzQd
	CX4J3NKiiKd2PJ6KV9ykTcm+K4lnT8WoBQbsKB91DZiaXRBTxRLfBqcsc3SYsVvmftAkls
	4MLPqcjMZdu4lnqu++MHVQapTUFf3pc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-_oBuolmeNYyF2XXsrfOPCA-1; Tue,
 21 Oct 2025 00:02:04 -0400
X-MC-Unique: _oBuolmeNYyF2XXsrfOPCA-1
X-Mimecast-MFC-AGG-ID: _oBuolmeNYyF2XXsrfOPCA_1761019323
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 035751800365;
	Tue, 21 Oct 2025 04:02:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.71])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 958F11956056;
	Tue, 21 Oct 2025 04:01:58 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] virtio-net: zero unused hash fields
Date: Tue, 21 Oct 2025 12:01:55 +0800
Message-ID: <20251021040155.47707-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
initialize the tunnel metadata but forget to zero unused rxhash
fields. This may leak information to another side. Fixing this by
zeroing the unused hash fields.

Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO tunneling")x
Cc: <stable@vger.kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/virtio_net.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 20e0584db1dd..4d1780848d0e 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -401,6 +401,10 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	if (!tnl_hdr_negotiated)
 		return -EINVAL;
 
+        vhdr->hash_hdr.hash_value = 0;
+        vhdr->hash_hdr.hash_report = 0;
+        vhdr->hash_hdr.padding = 0;
+
 	/* Let the basic parsing deal with plain GSO features. */
 	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
 	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
-- 
2.42.0


