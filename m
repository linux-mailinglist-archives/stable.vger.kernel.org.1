Return-Path: <stable+bounces-247779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMDlM/0oB2ppsQIAu9opvQ
	(envelope-from <stable+bounces-247779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:09:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB980551062
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDB9230D1C54
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64BB39B963;
	Fri, 15 May 2026 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzYFd+fi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlGEsQKo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB32D3A69
	for <stable@vger.kernel.org>; Fri, 15 May 2026 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778852976; cv=none; b=Oi6vTMpMWlaFx5CeX688ncV92LbznkXPB/H/1Fgk2W6pj1xtZsLHYZdBMXsQ3LzmTTftEHHII3sdkOxXee13l7XUGQ6z0fVEYE7vYHoX3q2/q8RX0LgsKxFdnXXDsYPz5p+TRfUXEoZcZ5h/qmkZzxWDQNJKbWIHjRv3LfrPjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778852976; c=relaxed/simple;
	bh=v/0VmZgWUbg3S5QFKbUxNBnq//OtHpBN/buwcpHFyuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RJiUmdXAKo74BCH/WLUHhfdVFIXJ4pUs0h9Ok2baAJ7bGQh60qGbzobaeyhvVTLaTtaqJygaaHvGY5fPxNzMsNavk8aQVXid1roRfsOawqpaeyvWCbVHb8Mgme4xSggHJf2cHnRAgIKRxAYM8g4SULzcmgL5JuzbFklU9iwSi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzYFd+fi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlGEsQKo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778852973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GX8N/2Y+zIL32M2JYsw6rh/MSMF1d8bB8oJzyzSowM8=;
	b=HzYFd+fi+JSHZjafGs1dlGX0DLyjX4GRFsQ5VZKReP/QnGsE4mOgotInytWlHxXfpVK5W9
	CDiIP4JiUtQetFwTi/YAm/yAoL6fCB+FZGZdmFTEP+1CmAJHU5F+rsnZ9Z6iV2bOGeVazH
	0fntBtImS6DI3L8uhtBhVFFbDYd42SY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-dO5PwlFZOciDslpuDy3gaw-1; Fri, 15 May 2026 09:49:31 -0400
X-MC-Unique: dO5PwlFZOciDslpuDy3gaw-1
X-Mimecast-MFC-AGG-ID: dO5PwlFZOciDslpuDy3gaw_1778852971
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-90d2d8dc97bso847155385a.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778852971; x=1779457771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GX8N/2Y+zIL32M2JYsw6rh/MSMF1d8bB8oJzyzSowM8=;
        b=FlGEsQKo6Y6fEaRcufX9d2OcfLvZKKfb1bHBPXeVUTI7hz9F+2fHyJnUxKOTMBUVuk
         PfdF7VNL7I+oT3p57igCU/f1QERe6Nmsd0sIJfBIMTYa7NAduT3TFui0HyQsNGsofQdN
         8fouEzqHvEazGgrwaXf7SbRQhEf5OOpAAf1Iq64p2xUuTBFMvpQO0MQuCHcd6/9Ub2/Q
         BVVsRC0tLONZR+UPnI/v/M/zeeQB901ghC0C0Zj+KY7DsUqvuIMooYJvIGajR9vQl3LR
         UeLeAG9xzEDxgXHecXqrWQXGlmnYQZ95B1+4Cxg9j3Ee3W/IPhF0TvZ+18F8N5UjQB9q
         TefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778852971; x=1779457771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX8N/2Y+zIL32M2JYsw6rh/MSMF1d8bB8oJzyzSowM8=;
        b=fVWWjFAEYL59UhYUQuJ44q7vWIfk7NI7BMifxFesajiv2/iwxY48JkAC0JB0ngs2Ud
         uQyU4Dv2sRCTKsdnjxn5Hpx9YPZk3NbpmMMzRx3fowR6V01A0ehByxqrv83pbxumYAL5
         ujPs6iqhC8NKHvgOYwycYkGHj8DmWP0/wIMPPAfXquF0PNIyxUlvATsmtaOvFKIjyzjj
         5K1A7f9bTrf9TDKiIpFB2wdkAuBqjJ0UrTwF17l4QpbZH6pCTCM/ZHDN1wXRLJlIJOyB
         9zvz6JZAzx+nLpP1V91tedgNQR877VrF1lqtm1N0Pndid+WDXUGi873AzKskGAnA+V/H
         RBYg==
X-Gm-Message-State: AOJu0Yy4NbQ45Y1m7uT2CZklEQM983+vSXh3tS18qHPAFhT108NYIm9v
	dN+141sm9/zq/9e/oxleLtQvlueSV4hgVIwH4lHZ0mF/YgcLmeitFMrLktDNWdJxmYROk/XGmBO
	p2FcPXEa5NWgbiaC5cB2nMZYu6M0rQ4NQoMqOziNh4QhzOQy/weBCPK0J5748rRpJwQfpIoRmoO
	Hb/zMSS2WP/hngT/v87DZWdNg0i52kTvqQiy604w7m+A==
X-Gm-Gg: Acq92OE+7IW8WWU6U9B7Xaa8fYVOHTuyjBeuV6iRZLAcZ7/A1eLEKC3f37cDCT7+r4x
	VdmXatMjdKGW1lLHunzAGLy6NVIlCM1g+ic3NLHXtliEMibC3/qt4YdC5zzSaD6jHRnHZ93KqhP
	7rpGRqhGLEMl3a8JB0XDVm+7LwIgAzFWbQQ8c1IZ9zgsgeaO797qBEEmonmDmrdUGAX3HIanCik
	/BP3A9n/dis1dRRYSaWXZIsNm7AWmtEjKC+zngyUp8EQ93tTP1ZIwVlGlVBq08Ld3c339pDI6/+
	RNQENtBIMP0I065JNFK2g4Ly19xNO7icfNWMuz9OdQCfufnoMDfw+WIK6KXeVVgAdzsGduppZCZ
	NaAEZ3u6Yt8hAd8AzV6dg+h973psHlu1CiWhazOvnKHrDXXnkEFlPtePY2lTRMPs4aPG0CT19zC
	eZzO6w/+pzDikGOp1a
X-Received: by 2002:a05:620a:2685:b0:8cf:ed8d:20a3 with SMTP id af79cd13be357-911cef0365amr654814985a.42.1778852970804;
        Fri, 15 May 2026 06:49:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2685:b0:8cf:ed8d:20a3 with SMTP id af79cd13be357-911cef0365amr654808185a.42.1778852970221;
        Fri, 15 May 2026 06:49:30 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90bb80ed0sm52278726d6.35.2026.05.15.06.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:49:29 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
To: stable@vger.kernel.org
Cc: Luigi Leonardi <leonardi@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Arseniy Krasnov <avkrasnov@rulkc.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y] vsock/virtio: fix length and offset in tap skb for split packets
Date: Fri, 15 May 2026 15:48:54 +0200
Message-ID: <20260515-linux-6-6-y-v1-1-b47eaf4cc6e6@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260515-linux-6-6-y-74a11efd41bd
X-Mailer: b4 0.14.3
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CB980551062
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247779-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,meta.com:email,rulkc.org:email]
X-Rspamd-Action: no action

From: Stefano Garzarella <sgarzare@redhat.com>

Upstream commit 5f344d809e015fba3709e5219428c00b8ac5d7df

virtio_transport_build_skb() builds a new skb to be delivered to the
vsockmon tap device. To build the new skb, it uses the original skb
data length as payload length, but as the comment notes, the original
packet stored in the skb may have been split in multiple packets, so we
need to use the length in the header, which is correctly updated before
the packet is delivered to the tap, and the offset for the data.

This was also similar to what we did before commit 71dc9ec9ac7d
("virtio/vsock: replace virtio_vsock_pkt with sk_buff") where we probably
missed something during the skb conversion.

Also update the comment above, which was left stale by the skb
conversion and still mentioned a buffer pointer that no longer exists.

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Reviewed-by: Arseniy Krasnov <avkrasnov@rulkc.org>
Link: https://patch.msgid.link/20260508164411.261440-2-sgarzare@redhat.com
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[LL: Fixed conflict since this tree does not use the offset added by commit
 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")]
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 4c374c36c29d..bd9f853bc022 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -122,12 +122,12 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	size_t payload_len;
 	void *payload_buf;

-	/* A packet could be split to fit the RX buffer, so we can retrieve
-	 * the payload length from the header and the buffer pointer taking
-	 * care of the offset in the original packet.
+	/* A packet could be split to fit the RX buffer, so we use
+	 * the payload length from the header, which has been updated
+	 * by the sender to reflect the fragment size.
 	 */
 	pkt_hdr = virtio_vsock_hdr(pkt);
-	payload_len = pkt->len;
+	payload_len = le32_to_cpu(pkt_hdr->len);
 	payload_buf = pkt->data;

 	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,

---
base-commit: 3b9f64db049687c0d38b4b3ef2f297f0642179af
change-id: 20260515-linux-6-6-y-74a11efd41bd

Best regards,
--
Luigi Leonardi <leonardi@redhat.com>


