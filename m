Return-Path: <stable+bounces-264539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4iVQMW55MWoTkQUAu9opvQ
	(envelope-from <stable+bounces-264539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:27:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBA4692178
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:27:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CDIJsOJf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264539-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264539-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A06A31C3D66
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0887945BD4B;
	Tue, 16 Jun 2026 16:14:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DCC3BE650;
	Tue, 16 Jun 2026 16:14:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626459; cv=none; b=VZ8YvXvl5QFbHbH1TOncc6wnDgUuTlblhIoDKQk0SE/GYJQN3NR1vMs93m/RpgEq+Hs/ZBnb9/UHUFfZG46LjVNsqifQ2Hw0RGEEQc/IUagvZCsv4D2/AEzp35IzSQSCj6CC3kMKDXG1+5cE5V/ySyplQmKH8OF+WDKEbwPKlP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626459; c=relaxed/simple;
	bh=KhGJnAES7iqBw7FnmICDZHh0j6KaFvyQH3xaJr87EWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Na6M/vm5uzmt7I+jhx3aqHfPvUj55siZaw/EMpidvRywwgjMLAFaMrEZScPC1H1k/X08MwemdbbGL+NMOWiZjkPU0mPD+f2Hip59ep61jcVPUsA1GVYSs/oMCDZJVUrbI9UK66bWIpEzZnX2eD6F5S+tioCz/MbaC5TIig+1eb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CDIJsOJf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DCA1F000E9;
	Tue, 16 Jun 2026 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626458;
	bh=LsNEOL5KvEjsyaQoUkDUibU/flXfH4w7AzxDCTehK1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CDIJsOJfOi3QB0Z1ofoERLnKb8cHGtNrLFfKRFU+ngkS3WilTlMX6ZOGVfFEAS8Dx
	 fyviedGmRvh+3AObOYhnnObajHW927wGRx833lwD5UQJNUdMQgkfZcEOAaeAZGYRTi
	 sSFSXnSpQe5ZDUHarzp23BxWVFumA/Oy1rndPd2I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 318/325] vsock/virtio: fix potential unbounded skb queue
Date: Tue, 16 Jun 2026 20:31:54 +0530
Message-ID: <20260616145114.923242115@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:edumazet@google.com,m:AVKrasnov@sberdevices.ru,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:virtualization@lists.linux.dev,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-264539-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp,alibaba.com:email,sberdevices.ru:email,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CBA4692178

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5 upstream.

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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev
Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/virtio_transport_common.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -425,7 +425,9 @@ static int virtio_transport_send_pkt_inf
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	if (vvs->buf_used + len > vvs->buf_alloc)
+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+
+	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
 		return false;
 
 	vvs->rx_bytes += len;



