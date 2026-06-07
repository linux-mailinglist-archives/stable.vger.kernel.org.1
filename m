Return-Path: <stable+bounces-261197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8dkzGAZGJWqsFgIAu9opvQ
	(envelope-from <stable+bounces-261197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:20:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 086D364F8DC
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:20:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=DNazYipB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261197-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261197-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A5A83023DBD
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C01031E85C;
	Sun,  7 Jun 2026 10:20:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BBA23392F;
	Sun,  7 Jun 2026 10:20:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827622; cv=none; b=rgIqEq2feHF+KWSiruVqMdPMei4r0jhHIsm7WYAxAwtH708l+gtANRt69DZvRTL7vcwdYcF7KXKrxkdXyKo/unCm4kxKG//b8h3lKmWBJQt32UPSnLmKD/SSSzoqzNBbp+59zVl/s8waZdjuP9Px2uR1BYm3+/sE6r9RJdfll+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827622; c=relaxed/simple;
	bh=gYR61fBBRTZ7VJUZ7gRAoqVOUoiFIn2JM7DHZ2hARYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gB3VotgTbjXw+VqP+6izqACg7UKefEjcEK0H6XZzeVZ2tWhamWWVf9hSSYzxJp9SYa3kFnC2xlQwzsxnGd8411U099giVM6bqZH9FLCBPrBlOyX5G8+adM151LNDhBd5RXlu1oc6CUG2yij6RtjaQYDsSPpZh/B3mPxbwmuu1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNazYipB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455341F00893;
	Sun,  7 Jun 2026 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827620;
	bh=0cEj2FfVfN/7r/fIEySk702ob5Dty7tssLtVSFX1z5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DNazYipBcCwNPrFCdMLcoppM1okrAx/uE06V2tY6E52/f544mXSrNn3ZqZ0xQWWGY
	 vZfxCU4+CYcM/70QXt8XiLvEQUKuXkhrZ3JUMABnTzezpI2oiEXdlSsIe8ESct7WG0
	 KY585/rRChkNLb3D/2bM6WgQow4n0PSLrclMHcXE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lin Ma <malin89@huawei.com>,
	Rongzhen Cui <cuirongzhen@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 109/332] vsock/virtio: bind uarg before filling zerocopy skb
Date: Sun,  7 Jun 2026 11:57:58 +0200
Message-ID: <20260607095732.119121463@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261197-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:malin89@huawei.com,m:cuirongzhen@huawei.com,m:tanjingguo@huawei.com,m:avkrasnov@salutedevices.com,m:mst@redhat.com,m:sgarzare@redhat.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 086D364F8DC

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jingguo Tan <tanjingguo@huawei.com>

[ Upstream commit 1e584c304cfb94a759417130b1fc6d30b30c4cce ]

virtio_transport_send_pkt_info() allocates or reuses the zerocopy uarg
before entering the send loop, but virtio_transport_alloc_skb() still
fills the skb before it inherits that uarg. When fixed-buffer vectored
zerocopy hits MAX_SKB_FRAGS, io_sg_from_iter() may partially attach
managed frags and return -EMSGSIZE. The rollback path call kfree_skb()
to free an skb that carries SKBFL_MANAGED_FRAG_REFS but no uarg, so
skb_release_data() falls through to ordinary frag unref.

Pass the uarg into virtio_transport_alloc_skb() and bind it immediately
before virtio_transport_fill_skb(). This keeps control or no-payload skbs
untouched while ensuring success and rollback share one lifetime rule.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Signed-off-by: Lin Ma <malin89@huawei.com>
Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://patch.msgid.link/20260527023301.1075581-1-malin89@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport_common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1c0f1e5c75dec8..abe7bfcedc5a6d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -207,6 +207,7 @@ static u16 virtio_transport_get_type(struct sock *sk)
 static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
 						  size_t payload_len,
 						  bool zcopy,
+						  struct ubuf_info *uarg,
 						  u32 src_cid,
 						  u32 src_port,
 						  u32 dst_cid,
@@ -247,6 +248,12 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 	if (info->msg && payload_len > 0) {
 		int err;
 
+		/* Bind the zerocopy lifetime before filling frags so error
+		 * rollback frees managed fixed-buffer pages through
+		 * the uarg-aware path.
+		 */
+		skb_zcopy_set(skb, uarg, NULL);
+
 		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
 		if (err)
 			goto out;
@@ -366,6 +373,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		skb_len = min(max_skb_len, rest_len);
 
 		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
+						 uarg,
 						 src_cid, src_port,
 						 dst_cid, dst_port);
 		if (!skb) {
@@ -373,8 +381,6 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 		}
 
-		skb_zcopy_set(skb, uarg, NULL);
-
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
 		ret = t_ops->send_pkt(skb, info->net);
@@ -1176,7 +1182,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 	if (!t)
 		return -ENOTCONN;
 
-	reply = virtio_transport_alloc_skb(&info, 0, false,
+	reply = virtio_transport_alloc_skb(&info, 0, false, NULL,
 					   le64_to_cpu(hdr->dst_cid),
 					   le32_to_cpu(hdr->dst_port),
 					   le64_to_cpu(hdr->src_cid),
-- 
2.53.0




