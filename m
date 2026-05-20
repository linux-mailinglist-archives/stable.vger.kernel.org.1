Return-Path: <stable+bounces-252729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDIRLtgoDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-252729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:34:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6FE59B06E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0831439CD16F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781923FD126;
	Wed, 20 May 2026 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dH394VsF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2C3FCB1E;
	Wed, 20 May 2026 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301437; cv=none; b=kd3KkXSjB24nvV5gqc338iH+LrQjvKEo16LwvUuJ9iHMYTxrdvUtGS7wkVBxUJbrS28Ux+TtZyOJ98ZDcUrbI0+JD3JHRs5H0QWUawdjFnqZfIuMMurzOgK7yniiMT1EicgdCBx/d4Ck3iynIB7iP+mgeYr7k1wHfROi8DLM3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301437; c=relaxed/simple;
	bh=PBYycczVWqznAEGxdSYHULjhg46aW3s1ZtspX3Mrp7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjhlGclcIDMsG4SWqvIwSinYUn2Bg26qx/T9wzCJGr7C3gcq+mhhUsUOQBQuM2U55zTw/dWs8N9oz5dbBRVr3KJfE1kVq43YzV0WFFpbnwmolE7t1nKoJRJAUnPnjgCyAP9LlAyi+QUSkFgbFbaP0a8Nx/QauekHQDP0+A5T2ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dH394VsF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935B81F000E9;
	Wed, 20 May 2026 18:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301436;
	bh=eYLEc6hkGSDYCZz3AmfsHFCvOq77YFn/iMh+D1cUXyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dH394VsFgRPfuPb8IQC2rLZf6sKqOdGmLCq4bzYOuQocpu8rLxS8sAUIIj0WtLpRz
	 JFfttruymbef3YQikem3iir63mfV2gJap5QS0frQhBu1YK3I7+MvhVRjNifl5evBCI
	 kuqtGH0hrM+WosatrKhNoR6JkI+WT4o40brFcIVc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"William A. Kennington III" <william@wkennington.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 553/666] net: mctp i2c: check length before marking flow active
Date: Wed, 20 May 2026 18:22:44 +0200
Message-ID: <20260520162123.252575549@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252729-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,codeconstruct.com.au:email,wkennington.com:email]
X-Rspamd-Queue-Id: 1D6FE59B06E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William A. Kennington III <william@wkennington.com>

[ Upstream commit 4ca07b9239bd0478ae586632a2ed72be37ed8407 ]

Currently, mctp_i2c_get_tx_flow_state() is called before the packet length
sanity check. This function marks a new flow as active in the MCTP core.

If the sanity check fails, mctp_i2c_xmit() returns early without calling
mctp_i2c_lock_nest(). This results in a mismatched locking state: the
flow is active, but the I2C bus lock was never acquired for it.

When the flow is later released, mctp_i2c_release_flow() will see the
active state and queue an unlock marker. The TX thread will then
decrement midev->i2c_lock_count from 0, causing it to underflow to -1.

This underflow permanently breaks the driver's locking logic, allowing
future transmissions to occur without holding the I2C bus lock, leading
to bus collisions and potential hardware hangs.

Move the mctp_i2c_get_tx_flow_state() call to after the length sanity
check to ensure we only transition the flow state if we are actually
going to proceed with the transmission and locking.

Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Signed-off-by: William A. Kennington III <william@wkennington.com>
Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>
Link: https://patch.msgid.link/20260423074741.201460-1-william@wkennington.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/mctp/mctp-i2c.c | 4 ++--
 net/sched/cls_flower.c      | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index f8f83fe424e51..a939bc084fe8d 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -497,8 +497,6 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 	u8 *pecp;
 	int rc;
 
-	fs = mctp_i2c_get_tx_flow_state(midev, skb);
-
 	hdr = (void *)skb_mac_header(skb);
 	/* Sanity check that packet contents matches skb length,
 	 * and can't exceed MCTP_I2C_BUFSZ
@@ -510,6 +508,8 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 		return;
 	}
 
+	fs = mctp_i2c_get_tx_flow_state(midev, skb);
+
 	if (skb_tailroom(skb) >= 1) {
 		/* Linear case with space, we can just append the PEC */
 		skb_put(skb, 1);
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 099ff6a3e1f51..f3af0ac892a86 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -560,6 +560,7 @@ static int __fl_delete(struct tcf_proto *tp, struct cls_fl_filter *f,
 		       struct netlink_ext_ack *extack)
 {
 	struct cls_fl_head *head = fl_head_dereference(tp);
+	struct fl_flow_mask *mask;
 
 	*last = false;
 
@@ -576,11 +577,12 @@ static int __fl_delete(struct tcf_proto *tp, struct cls_fl_filter *f,
 	list_del_rcu(&f->list);
 	spin_unlock(&tp->lock);
 
-	*last = fl_mask_put(head, f->mask);
+	mask = f->mask;
 	if (!tc_skip_hw(f->flags))
 		fl_hw_destroy_filter(tp, f, rtnl_held, extack);
 	tcf_unbind_filter(tp, &f->res);
 	__fl_put(f);
+	*last = fl_mask_put(head, mask);
 
 	return 0;
 }
-- 
2.53.0




