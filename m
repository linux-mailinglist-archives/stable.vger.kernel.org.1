Return-Path: <stable+bounces-247792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNEGE14vB2p3sgIAu9opvQ
	(envelope-from <stable+bounces-247792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:36:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 488A1551856
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BAC4330034B9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4813644C6;
	Fri, 15 May 2026 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLIPnHkd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEaplGFB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B5A302756
	for <stable@vger.kernel.org>; Fri, 15 May 2026 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854952; cv=none; b=aO2itgmVQB4o/tT07YVW2t8S0i8joBexYSKtNGGVfY3T4yb8fl5ZvDTugycYxDsBJDs3W84zOjT0a1A7NdwNr0hK/3eLjSdM+cTyrkdDfqeXUqBTl/07ux3eKqEJjv/0A1PwT5kZ+GFL+BOWFY41Ldo6hsdv94YSg0d1afIZdJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854952; c=relaxed/simple;
	bh=4tkmWdr6khBnvueIXG5owwtPoJDfRf7F71EXLOezePQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UYMbJqiPmVkRUBZBR55Z7MEVQp7bp0Mb6iYygyzwxTQ7x+fkfTj7HEc+pgOKtOvJkf4ouIawBs7KOdzuXLW8KiOHcz/eKhv2yqEiKx1wAI5QfhHK4wpqzj3GJ5fLy0eiQTf2FbZ81/YvLcTAMk+OyduSS+3A4gEYn/vsBRj+zA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLIPnHkd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEaplGFB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778854949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sk8Y35SRjUOXJt7VGjNApwhzLk5NuWjeB/6xvK4VHMg=;
	b=DLIPnHkdCJHqfm4/yuMPLotYIDuUBqf2j9qwNpR5iFMX6GZwWbpmXrHblx86lxl4szKue5
	8sfdLtJfU8WGzT4DIxZ0L3BMoaxBgxfCX9+L2AJLf3pdtdhv9ZgbITsobIptwNhGpYPd6D
	Ht32tIrNzy2nnzI77J5UvKRVT4iInNA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-ASxKn5YtN_COr4JuBBFPZg-1; Fri, 15 May 2026 10:22:28 -0400
X-MC-Unique: ASxKn5YtN_COr4JuBBFPZg-1
X-Mimecast-MFC-AGG-ID: ASxKn5YtN_COr4JuBBFPZg_1778854948
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8badccc9194so149284826d6.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778854948; x=1779459748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk8Y35SRjUOXJt7VGjNApwhzLk5NuWjeB/6xvK4VHMg=;
        b=WEaplGFB7gSOPDt+2c21A4OjgF4bdwFZxsp0pgARccF+i9JqdDdqp24mR9SJ4UnCWJ
         ASGE7dkJYQofV6iQpaZlJiSqnTTjIzW4Vov/GAJS+KuR0J6dnsqXieWbXFG24uLZW2DL
         NjjTIAnRYRRDO3Y0rOON7GcjbMvYxmecc1dP1RpwB+2grR0x4rKbMDQ+vvggxp2nTKbc
         T5mMa66hH5Up3mlHu4yTSasAJxPt8AUY2WpDqDWN2zqIHVkOWBBKi9FnvtPGwANIj26b
         EeWFVmqFEa6zXR7z4zCDEAjSXJn3BEhlJdHVASx4Z0qRFpwZt3Z+/GEae8GTmagF4xRL
         8GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778854948; x=1779459748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk8Y35SRjUOXJt7VGjNApwhzLk5NuWjeB/6xvK4VHMg=;
        b=eSnxcpx6tuHL7QY3OQByjNUxohIFQa/KDP/GmZP67nrmfWkSrWji+048aA42y2Qsyx
         IlaYoJCZDxX5rH7vIdDdvebQyZtJH9UYXRrFtvo+35ioIV7FoxUDZyTpsbC5hCkDGBoa
         t8RPsOxjMpwGlfrUZ4IGyn8O9TPTGzFowDsHZIbHVex2yKhdReI5DT8SLtyXX4ZTX3AW
         f+bphaYZPSCHrlzYDRgZqRsEB/tyWA6CpPq0sgYYdl0ktJjJ3U7j2lqp29Jatk1o9GyC
         ruQWOnS0r0ZZQpGTdANITyOy6Q1ovoWPjFDCRO1aEXw/FCU5SHAERgIhvl2vX4acPHWv
         uB+w==
X-Gm-Message-State: AOJu0Yw1QIcgCNhS2KAAIX+x0WtSfqqdjZMgIusxjiY+plDMK/mvMoNg
	wHkwO6Z0y4/4WBtS3STD7XWxA/LutiVNT3KnKkdvwWsrlvHSFxB/Q4gbCdKQBX7GboRnNMeYm/R
	yGQvzNqHVQNQ9Eq1z9hb8d1IlfI2iiwTB5IhOnACKSiKV7IW7G+fCD9Z7EPfS3+4AgA1Ojl/p3n
	Nk4NoWW5PCO+3gpjBv/QJ6rvZJn98Embosw4Ro85B+BA==
X-Gm-Gg: Acq92OFeOPya2uZoigYCHOBGGjPjiAe3UikWS7viNitkMgr+oG//HPvqMnY7H/DmEV3
	v+s7TFVHJzoIOU0MmCVeVkjfZWChooixXp0L5f74L2vuIBNNbgz9vjIRf3+ov8lO9xiTaWRuzm8
	K+azP4LKHKEFVAaitzOeT/flFqhZybVLpjOzjLWYd4r1sbJmDb5H5LjnPAjyWDmpL6qKy+H+0X5
	oPzcHja8Jbl+MC+F1CeRHMazJOHFBsLVP4TmnrmQyPOQq19BlBUi/lFQkxDL+lggoBrFfo1Nif0
	5n3vLHPuufyrJMC01JsRIr3LvfjyyRzBW4l5ooS4Y5k/jd2rPuFEON3nWIgVACC34YJdn/Fkd83
	BF83AS4yIPEM0+HXPwYbSrHYbt67VkkSqk34ZR2O8SzfJ5Xzdub87wt5VHtEFxaPeASa8qIjAfr
	PXmbrTzwtNVgupba3hpJBcLOt2ONk=
X-Received: by 2002:a0c:fe0f:0:b0:89c:bcbd:c26e with SMTP id 6a1803df08f44-8ca0f6893b0mr53900036d6.25.1778854947869;
        Fri, 15 May 2026 07:22:27 -0700 (PDT)
X-Received: by 2002:a0c:fe0f:0:b0:89c:bcbd:c26e with SMTP id 6a1803df08f44-8ca0f6893b0mr53899356d6.25.1778854947274;
        Fri, 15 May 2026 07:22:27 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c358539sm53014106d6.41.2026.05.15.07.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:22:27 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
To: stable@vger.kernel.org
Cc: Luigi Leonardi <leonardi@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] vsock/virtio: fix potential unbounded skb queue
Date: Fri, 15 May 2026 16:22:12 +0200
Message-ID: <20260515-dumazet-v1-1-73468c902889@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260515-dumazet-07c0c855a9e2
X-Mailer: b4 0.14.3
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 488A1551856
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-247792-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sberdevices.ru:email,alibaba.com:email]
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

Upstream commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5

virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.

virtio_transport_recv_enqueue() skips coalescing for packets
with VIRTIO_VSOCK_SEQ_EOM.

If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
a very large number of packets can be queued
because vvs->rx_bytes stays at 0.

Fix this by estimating the skb metadata size:

	(Number of skbs in the queue) * SKB_TRUESIZE(0)

Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Eugenio Pérez <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev
Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[LL: Fixed conflict since this tree does not use buf_used added by commit
 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")]
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 4c374c36c29d..86e3051d000e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -283,7 +283,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	if (vvs->rx_bytes + len > vvs->buf_alloc)
+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+
+	if (skb_overhead + vvs->rx_bytes + len > vvs->buf_alloc)
 		return false;

 	vvs->rx_bytes += len;

---
base-commit: 3b9f64db049687c0d38b4b3ef2f297f0642179af
change-id: 20260515-dumazet-07c0c855a9e2

Best regards,
--
Luigi Leonardi <leonardi@redhat.com>


