Return-Path: <stable+bounces-247775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G5aMJQeB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:24:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D73550683
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 658AA3086BDE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B0A2EC0A2;
	Fri, 15 May 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTm6zLRP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sWqolspP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1727A33F58D
	for <stable@vger.kernel.org>; Fri, 15 May 2026 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850947; cv=none; b=dmE3MjYEbkCdD2xZKhY8SXjO2y8TwXE+mTvzLrfCq2G56Xeg7yDvDRbAnBsVX2dmmBSD0IHu8lO2RBdNYdQ6y5Jo5JSbPU+WFhUH+euvw0Joe0zYgMPauXOzs5ORrRrHfIw7kaw4uVcv87EcKYdRNmt3f831SHm31RluYAUbJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850947; c=relaxed/simple;
	bh=+37+WWk39pP9Idoz77AO+paZHCYneaJMYJNwABjoLfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aCJG83qYD0Rm8mKKTozfWZlLARW0kqlnQrioInqdi/spXr8v+dMQyoZ23UZoU7NgZQmUxxS2rdAp9dmfKKIajeDdtSZguX7CaTLhakcM3+eYf9QOlp2eL6NxSUAsGAjOvhEQ4FrCP79+AcMyd6VsILL/0/k2DDP++VCIKqaY3A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTm6zLRP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sWqolspP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778850945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xhd8+PPUEue3GZ+urv500vjnXnjmEFbpJ7AEroA65Pw=;
	b=UTm6zLRP39uGnhMygfrbgcFiKV3/+mpk78uQBQZu9G8B5hNSpbXIzV2sqH3N+UzbNBWCIT
	3Jngj7r0uPdn2J7TTlPZDm//13QUB5N7iZ64GPbFgeVGA8Vf8+nYWpg2zlFxpJkbHDVyiA
	T6o789FILnxkYGk833qWvn7gKgkmApw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-k9m4d-4IN2auY0eY-dsZeA-1; Fri, 15 May 2026 09:15:43 -0400
X-MC-Unique: k9m4d-4IN2auY0eY-dsZeA-1
X-Mimecast-MFC-AGG-ID: k9m4d-4IN2auY0eY-dsZeA_1778850943
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-91030497912so496909085a.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778850943; x=1779455743; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhd8+PPUEue3GZ+urv500vjnXnjmEFbpJ7AEroA65Pw=;
        b=sWqolspP+rwC/D1w9pp/Bas4nXXqR6cvJ3dytjZT0qpTW5WVdoC8ZkHeQRB1jOF2kz
         TudKIhSf1B9C3aRxDNq1NdSvKu+uqN7pv5wz5kFfP3Jn1SraXbgL97fGSVcmZuWBfgHu
         dvqjgi7+K/xHqBkXocQfg437soKKoNRxJpdqCzyVqJ7h7VekJIdQ+UbJXSxtgDh2CHuH
         GdebFquSF6FU4+dcZqlgfVVBCAW2Wc0GSOCjj862rjtWLh6uKpZJl1vdSRQrDZQT+Zz8
         jTlkGDOlr4GMLm5Zdi321SP+dnY37Eu673pY/5OPiRVNnb8FtLF60Ru6A39Cg/6WmEuD
         ptJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850943; x=1779455743;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xhd8+PPUEue3GZ+urv500vjnXnjmEFbpJ7AEroA65Pw=;
        b=UDEi/DCD6/eu8I2+Sqlh6CnNUCU9vBkwHh89YsAvLosWfV9piC+xNG3FyN8/eqzO8o
         Sps0tBDk/GwwnbuUYWdjgOxukjM7F2X02pvppcUWrZpE+PeFaaWLTx/onnM6S4YQlgX4
         2P02BWy4i1eghLfZYjniD7DpDLYgLStQTZygwYKFniZsbfwqLJXAuwkd5VKxe58ibKhS
         mcB/yOsJiSQ+5XAzZ/uFQI3xAFGjoQ5p29xN4bsNFSWpvaLSybI7Idd5Rh0KeHyM2Shj
         hRYk385H1d1RaTH8d/vmamDIRwAXGmDvcEJzzgvX7w4Uzy/sn21KEcwHrT13gADxbAS5
         aZGg==
X-Gm-Message-State: AOJu0YyEWm/kpkUu/8qp2aapXRjIK96MkfXHFugZZMSso2bh0mGJPm7w
	FolnuSCwdzBsPDnB7AMl/JSc6pEVLi1RdLAlcIJN1/GYmeltPuSutFmoPgC/C/ie4tQAsNQOHux
	s4/+LTzsgpaIA2iZQpzpZ4EFwmDHU9rPySmGgUBNZhIBi6LtD20bkfBF07R7HG7jAmiGi6GzoSs
	rg9bDCuIawQzJxgI9hG2QAthRwEEHjBF8fkPo9XvALAQ==
X-Gm-Gg: Acq92OEtjM6t/Jc7duCUbtqFn7deFo85knfONOdn+z7D9h1Cxu7lxRIPf16sWRfTw2e
	aq+P1YVFn93rvKngLdXd+jGTuETgcMuyu1y16Nm5QCAYeyjeShuUlLSBcllPn1WnUVmRZze82tC
	1MH2JiIc0Sd4sCGBt/tlzKtR30xccIDwngqpZs+3l8wgwXVYlBQMLbDoB5KN1vXXxKLN/McHoSV
	jnw0/gk/h3s8qsHEr3rbkJfNY0EMXzWNrCNwTRuRFqIwrW0x7AJ4VcQp1N7/kYB8FuQ5Xu/7uAY
	ROdfry0QHlCz7j2eYRC32Fc4eDFHSI8dqrgm/8HI67RTxwvSmqQGNVL+C+At7wNe73f4qfPOZjk
	brdoxccK2ZuSEy2ilVqrFgG8ZooH4qhEeQpYqicCflpLG9YJoZMLR1RjWBZG9dSzz0+Cz6OMRUW
	OMihbZX+dNtvj64xVn
X-Received: by 2002:a05:620a:4612:b0:912:bd42:b46f with SMTP id af79cd13be357-912bd42b73bmr98411985a.26.1778850941239;
        Fri, 15 May 2026 06:15:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4612:b0:912:bd42:b46f with SMTP id af79cd13be357-912bd42b73bmr98311485a.26.1778850933680;
        Fri, 15 May 2026 06:15:33 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf35843sm533915385a.38.2026.05.15.06.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:15:33 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Fri, 15 May 2026 15:15:10 +0200
Subject: [PATCH 5.15.y] vsock/virtio: fix accept queue count leak on
 transport mismatch
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-linux-5-15-y-v1-1-033f2ea86d6c@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqDMBAAvyJ7dmU3ZbX6ldJDMasuSCoJikH8e
 0NvM4eZC5JG0wRDdUHUw5J9QxGuKxiXT5gVzRcHR64lYcHVwn6iYMGMjnpPxI/O8xNKskWd7Pz
 vXiANS5Phfd8/NLg4AWYAAAA=
X-Change-ID: 20260515-linux-5-15-y-209d00137d18
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, Dudu Lu <phx0fer@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Luigi Leonardi <leonardi@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 39D73550683
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-247775-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

From: Dudu Lu <phx0fer@gmail.com>

Upstream commit 52bcb57a4e8a0865a76c587c2451906342ae1b2d

virtio_transport_recv_listen() calls sk_acceptq_added() before
vsock_assign_transport(). If vsock_assign_transport() fails or
selects a different transport, the error path returns without
calling sk_acceptq_removed(), permanently incrementing
sk_ack_backlog.

After approximately backlog+1 such failures, sk_acceptq_is_full()
returns true, causing the listener to reject all new connections.

Fix by moving sk_acceptq_added() to after the transport validation,
matching the pattern used by vmci_transport and hyperv_transport.

[LL: Fixed conflict since this tree is not using skbuff addd by commit
 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")]

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://patch.msgid.link/20260413131409.19022-1-phx0fer@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index ffd4db198bdf..12eb365c1603 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1223,8 +1223,6 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
 		return -ENOMEM;
 	}
 
-	sk_acceptq_added(sk);
-
 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
 
 	child->sk_state = TCP_ESTABLISHED;
@@ -1246,6 +1244,7 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
 		return ret;
 	}
 
+	sk_acceptq_added(sk);
 	if (virtio_transport_space_update(child, pkt))
 		child->sk_write_space(child);
 

---
base-commit: de8dfb3f0278dbf02ec63612f0ebdf7b92870d58
change-id: 20260515-linux-5-15-y-209d00137d18

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


