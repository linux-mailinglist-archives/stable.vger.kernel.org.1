Return-Path: <stable+bounces-247774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKkCOrcdB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:20:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 410315505E3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBF02304179C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36204311C2C;
	Fri, 15 May 2026 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2C/o7de";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+8TnAbp"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E6314B76
	for <stable@vger.kernel.org>; Fri, 15 May 2026 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850838; cv=none; b=pMjsW1WD9lI48pXYa//wIFj56xAATIxAikSZjpLKLaw50w4HDRC6j1iMLM4EIF1h0bf16viY54xFGAqmlLgHvRG+ZAZQVrw05QSUKG9y8VIPEfX3FUQhqHkXBNieKGLls158QyY8nJgWiD7HrjfXf/UbOhh3P93gFWBdvT6xPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850838; c=relaxed/simple;
	bh=4wE60Dh8VrSJ3iCzOIMBiUpEZqiA0F8QlWVO04gaQV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QjhIg+W7DoKeiRzKicwUw7XmusJjmCcEmLO3XltkEDm5Go/AJF16aoNrpHcOT5RSJigMqLRXBsJclfpUxep2y61WtdI2zU7dbwqyYFnaYuiiuQ1INS1gXQzBU6sMLFadE9uuVaoJzoU7rL6SNLR6dDuAptvrHcKwd5swfFelb0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2C/o7de; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+8TnAbp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778850835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F+qocEc/uefjnPzKkHQLc3iaqA2Mki7M8Is2wjEthV8=;
	b=c2C/o7deCb0ipEOgyXcGxciZVptDRA8WAgjsu3rLpmuOXoUjsKyd9rXLB9llJ8t0wHg8o3
	9yjC291tlY4Ow3Xa0XDBE3G+s7lt7lulvL/prHWM4VqnZt1X8SsdQ6WwFJCI1q+vj8otbb
	2n8AoguSO/gPm1U/ynnV4yv5AnNEESs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-DIiJHMXWMYC4HYmOjWcc_w-1; Fri, 15 May 2026 09:13:54 -0400
X-MC-Unique: DIiJHMXWMYC4HYmOjWcc_w-1
X-Mimecast-MFC-AGG-ID: DIiJHMXWMYC4HYmOjWcc_w_1778850833
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8b5f089a5c3so6127276d6.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778850833; x=1779455633; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+qocEc/uefjnPzKkHQLc3iaqA2Mki7M8Is2wjEthV8=;
        b=e+8TnAbpnNFuY8IdHxpTN8vY3OlIWtlUYpt15ldt2JXZ5bB5QcUwD/870S8iRGmeYC
         h+aHVfywhyAkYUQV0rSSTnmaqOflIyZDuIdKQDCeJzBpN5k3ok/6t2axxuEpcipq+B7i
         sY+Yl8b1eOGEideyVLFhzjIMfookzu1vR3TkTGEZa4Fy1+nndTX4mRzfU061pgyWEM79
         OdqUJfh2+vWzpt7RJ55ksrlJeheD3K6xgCe20bKJB69UMljWAGIFc8nh1Fgd3pBdxuDT
         59F8U5S/2t1LIbQ64KNe9M6HnIOr2T418Jx39C5eDd7FtKzoXwW/LSheqUjNnSLE07Ia
         IUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850833; x=1779455633;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+qocEc/uefjnPzKkHQLc3iaqA2Mki7M8Is2wjEthV8=;
        b=DyTxLRcs1AEZNwxcofz9hu48WX+k4M3ziHpmbR2l0jaOWOjsonJWEonpSvkCryIBm4
         0GYQPoY6ySQgKeNm8qZNXnQKuEp7JU4cM+qNC9yoNFbgy/U+JsdchTOLgqAnMT/VCVzl
         l0NjbGGK8nttpbGhyheQRqr4X7S85HbvpeJXsYC5YhHR9LSD1i/x+0RzZBCnWpaUWVcf
         VMXvUfYQIGGwNLcHEw1gVC2trpvryxvSVXrN2RegR8z3cgRgruLjEmzYuAejdo6SfVYn
         ldvkb/sSlQ9BaQMqScVYIR9c5F4I112jULRtFDOkWL3nfpdu2dzsleZwQucvoVHoOBIQ
         m0pQ==
X-Gm-Message-State: AOJu0Yy5mXmCwlVV4CQEOvHp2BYiRH/3yuC5LPNU9nD+JRQX2hrMW3V3
	EUAZVDVPNJVD+TTQIifDEh8TCTCxyOvEy4rzIL8o7GkbQrB2eGAE5I5nM1IDkUwhg91rt0nfjuH
	5d37Rv3awldPlP9SpXzkhCqUr4KvctytKX8aS3nI8x0BITv2/yihe02yjg2ek58KUs6GmyCo8re
	bbbUnAbyB7AJdjEMkXlnCS3pFlZcTZbKP55eaHwjXX0w==
X-Gm-Gg: Acq92OGx3FXQFZr7S4y6qntaLIbnur/0zRrC26iMhaDUT1P2ExSNj/8a+NK4cDX3OCi
	PFRVEoJq65OdiL7UbXCw++03iUfSwwUJNw9ZD1xB6Th8R1H6ci7UVIbjzu4NTrmalYoF3/aOGA1
	cq3zr5KB4lodHhO2K31EcrCzfu7WIc7xT0TCVvlMZv086uEA6muH6myv0AVuOmo60qf/FI/gGdT
	7mTj+WWNtPbScUlEi/xThivlEbQNnIOhemuiRkzapgZeYqedgr39clpPxL9t8bfvSoolyU0eyIG
	C4ONAQ4KwUpCKTtlAG1K6l7pNTQqekeM6A/ATNX1apSI3n3nlQ4g5EkeMahdrZH9JW9h/u6sZzi
	jx3oxt4CnD++oFviHR5+6o4OGdpHP+jC2neK/UF6pW6ue7q7PvttXhz5vfA8CiQRS6zNfXo1JK8
	oBpx3rm+gZ1IrXdBJg
X-Received: by 2002:a0c:e6a3:0:b0:8c4:edb4:a42e with SMTP id 6a1803df08f44-8ca0f6b2854mr44578686d6.40.1778850833151;
        Fri, 15 May 2026 06:13:53 -0700 (PDT)
X-Received: by 2002:a0c:e6a3:0:b0:8c4:edb4:a42e with SMTP id 6a1803df08f44-8ca0f6b2854mr44578296d6.40.1778850832648;
        Fri, 15 May 2026 06:13:52 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c37bc64sm50371576d6.48.2026.05.15.06.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:13:52 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Fri, 15 May 2026 15:13:38 +0200
Subject: [PATCH 5.10.y] vsock/virtio: fix accept queue count leak on
 transport mismatch
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-linux-5-10-y-v1-1-ee25f57b93dc@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0NT3ZzMvNIKXVNdQwPdSl2DFAvjxCRLQxMDM1MloJaCotS0zAqwcdF
 KpnqGBnqVSrG1tQBbMxitZgAAAA==
X-Change-ID: 20260515-linux-5-10-y-0d83ab914065
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, Dudu Lu <phx0fer@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Luigi Leonardi <leonardi@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 410315505E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247774-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url]
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
index cbe8d777d511..79548967eba5 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1089,8 +1089,6 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
 		return -ENOMEM;
 	}
 
-	sk_acceptq_added(sk);
-
 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
 
 	child->sk_state = TCP_ESTABLISHED;
@@ -1112,6 +1110,7 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
 		return ret;
 	}
 
+	sk_acceptq_added(sk);
 	if (virtio_transport_space_update(child, pkt))
 		child->sk_write_space(child);
 

---
base-commit: 8d9ad8de1c07b07bc75178cda26a7c47f2cc0812
change-id: 20260515-linux-5-10-y-0d83ab914065

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


