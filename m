Return-Path: <stable+bounces-119650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D21A45A70
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 10:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E84A7A7F7B
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606F238169;
	Wed, 26 Feb 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rJdCG2KU"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C79238140
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562789; cv=none; b=NNOdn7Gn3oDyuf51WZa9kkEWcCbgxqzqGVKrJhtpFIUvjIKqI5TxNGRnTc9phKIpbS2X/k6YImD7l7x6CAG78Tb5G7QcnIQAmcLRt4c7wJ8LFg4PZjg8TV6mjZQs63moQAhsQd6vffLt6MD05HkczsHZhsBv/2WxX6iL3IxMRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562789; c=relaxed/simple;
	bh=6YPsw0PHRr+1Brne5rbZcoFybVsOWAbQoIlobJgdaDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlcCYV+GP0bwGH+75qkf2QvGsKl9SqKJtJQr8G/rcC2BYKhUGEnQTxni+hkYajsTKkGMH6CrihGIN83ueznP54dS5GvnUb1iaZGvE9Akhvk+6541YCcsOthyWeRHMJGH1e8b+9AvTNI9sPWxA2U1HAYuCpqwyN95HTuiPJBeZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rJdCG2KU; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RcW4yUFJVfuyzc0Bf6QmpM2zxcUxohNg/8XDyfLGdZo=; b=rJdCG2KUxOgSmA9lgCHrgn/h/7
	xPEnu72oeNYLnWF90n9I0OJQM0eBZ/Xvrc6YzfPqnbZwqPlgDI70yqnAJZ/mciQ8XnUBnSxNwb7g/
	6a1NUrtcZcpmOIoHraU84gAw6AcqubkYnkT2YuSupynpJNgzvHzLfDeHAzWvM67AuPgRIutBNgSST
	weWJ1HTfQ7k/+ZjqWPcKRZKd6amndc+CvW/wBLiTfJTzojA3lef6k/58bWIkoa9shYT5XU3epFp7j
	CrG7XjBe+bGpBV6z2J3eEs/Ww1uHwaM/uF58f0EHsTr/kECHr310sduPX6X/KMnP0/Jll2elV8K9Z
	h+4ynfpw==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnDt4-000seA-UD; Wed, 26 Feb 2025 10:39:36 +0100
From: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Date: Wed, 26 Feb 2025 10:39:07 +0100
Subject: [PATCH 6.6 v3 3/3] tun: Add missing bpf_net_ctx_clear() in
 do_xdp_generic()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-3-360efec441ba@igalia.com>
References: <20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-0-360efec441ba@igalia.com>
In-Reply-To: <20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-0-360efec441ba@igalia.com>
To: stable@vger.kernel.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: revest@google.com, kernel-dev@igalia.com, 
 Jeongjun Park <aha310510@gmail.com>, 
 syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com, 
 Jason Wang <jasowang@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 syzbot+3c2b6d5d4bec3b904933@syzkaller.appspotmail.com, 
 syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com, 
 syzbot+c226757eb784a9da3e8b@syzkaller.appspotmail.com, 
 syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com, 
 syzbot+709e4c85c904bcd62735@syzkaller.appspotmail.com, 
 "David S. Miller" <davem@davemloft.net>
X-Mailer: b4 0.14.2

From: Jeongjun Park <aha310510@gmail.com>

[ Upstream commit 9da49aa80d686582bc3a027112a30484c9be6b6e ]

There are cases where do_xdp_generic returns bpf_net_context without
clearing it. This causes various memory corruptions, so the missing
bpf_net_ctx_clear must be added.

Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reported-by: syzbot+3c2b6d5d4bec3b904933@syzkaller.appspotmail.com
Reported-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com
Reported-by: syzbot+c226757eb784a9da3e8b@syzkaller.appspotmail.com
Reported-by: syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com
Reported-by: syzbot+709e4c85c904bcd62735@syzkaller.appspotmail.com
Signed-off-by: David S. Miller <davem@davemloft.net>
[rcn: trivial backport edit to adapt the patch context.]
Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index a6a63f5b6b8364d2d24553180d4e2138b13614b9..3d1bf7be1ab1cc74f50a2e5b8bf05d21def3c5a2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5075,6 +5075,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
 			bpf_net_ctx_clear(bpf_net_ctx);
 			return XDP_DROP;
 		}
+		bpf_net_ctx_clear(bpf_net_ctx);
 	}
 	return XDP_PASS;
 out_redir:

-- 
2.48.1


