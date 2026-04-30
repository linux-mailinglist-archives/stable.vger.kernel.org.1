Return-Path: <stable+bounces-242150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPy2Fj9782nH4QEAu9opvQ
	(envelope-from <stable+bounces-242150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:54:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DD64A5320
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC2F4303A69F
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F9D340DB8;
	Thu, 30 Apr 2026 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkmxXSXu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8734751B
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563711; cv=none; b=QSmaEsgNfLWCCgeTdg16UV5Bju75XE0c/pxKJnPaswjnszT3En6TKQnVABAl0nNCrw//xBorBmO6DjWEXE3DbS/pIYkq2EqmJSREiCpniQXpdx+UzDxjqNRm1NRf5Ut9U80VXl/lzqntocXtR9oc666JUp9rxvu4/od6SaLw8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563711; c=relaxed/simple;
	bh=z0DYBvb+LZUpxretZCjDv+k9yn01sF1apvq6+r/SDyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZwsxbp59DeBRXRmgdPfrpbG88ClZg3B/QrChcKoxakU7vAzoOQBrhq7cQzIqy8MLr6zEo6RVohIQvvs7t5O3ycU1SLZ+JWaNySpIiEvXfxyJKItfTz8PgcRM1EHHpHQoyz8sk91ElGbxf+k+0VDsCF6cdaxAsnU6yrAWhsKh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkmxXSXu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so760083f8f.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777563708; x=1778168508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1jOo4LrB4QdOIsyappS3L/Lh2AU+Kgh3i+w/0anQdk=;
        b=TkmxXSXu+XYTyV11z+SNTS4rOiC4ZBzszwaHLhyZoTCWBlZXex94X8gXqiQImNqbWp
         UQ1yCdi4Nxf0PZS2YOFhu/mnH9bs3IjkKHzhOCMeXkMqKlq3Ekuhl+l/QRZWRpf1IMGK
         baUYLi4FwlrQ48MF943hGL5w+B1SWsmrILJtfVMp94y/UFNbFjgETcDwvDex+D19qR4i
         Cdc7CfguGOtgvg7D8STowTlJsfRo26wnq5R4q7B5cS4LeJ0gBZSznd3Giz3rweZBp2hM
         FYoJahpMvPI0aIazx1127YRN733Z0ZIGvoXtpt+XGJp2y0NaCmrhlj+VxY60Vte/4ygg
         fNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563708; x=1778168508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1jOo4LrB4QdOIsyappS3L/Lh2AU+Kgh3i+w/0anQdk=;
        b=ppGxt6UD0ctqbdg571gM46HbBl+a4Hu6mMf6jOVzfAHZM2gwbaJzIqQP7XEPLNOprT
         V29Z/nlfs7Zwb1+bYn62e7SeOhnBe8AbWDfaex0eJcLDQuSWvF6R8BVPPCeq+NKieyd7
         CFevR+rXe748iNs+jO3fj0vuo+osy89vp1Zn2oZt02hT+RoE3l8AYSKw0pQZfomXTjut
         qCs+/j/O/l8C1aSxTedBsGbFrdCRQRPUtLncPOriY9uZ7X0793j6VKNJns7g2Hq4d3fb
         2iI4VlA+Ci/z3I2z7o1ZFcl+0t82++FvXlYfho/1fQwvJPHEVs+XMWBO8Ic8u6S0brmY
         P1Ow==
X-Gm-Message-State: AOJu0YwlUcthf9YS3OjEGlS10KrP+x+vHPPyVlRCDrTGx7yDkIp9DR/8
	OQWMcF9kSK89Aq89wogiLVCasaH70DtNVTB9JnBMR4kkiZYx58qiKMgX
X-Gm-Gg: AeBDieslwewBLgQSUPiBN2i8XtGzyP/nIFlJfucUDcHT2yoCCql6KAR/BaCv2UJi190
	uM7HNOftGe4XhzP7KhiIjaZFQFc6rwHQzeYON89gO8kNaE5XZjMgXqSm6qmwA2frdM8PTp2YYYO
	DIRABny1smfk1TFEACc2gLEzNspR/V3UgIB7dAonFlkD2ci2gppavc6LJ7Ku1l5zmTmwVgSMU8L
	KD9jjkJIEvTQ5OqQLVC7yW/3mkZW3u6CG0rQaWv+XRbekgFu8S537wxJCpjlEHHkCqT/d8EddV+
	td0fDGIdXVVnk1MzlmaQNSlFNIpVpBIlsVykyD3o+yGw/mnogbS4coaDhV7P+LLjAxmN+z7uCND
	YuooO5xyoFcUGXpdB6zymbv22hk0auEAsy46Vq3a0ByTboFoeMH8WE3AbyEWzDrlwTC1jrxR/Nl
	+3pHKnmLvt8VvDZi8H/IUHX50PZA1blq4+RKfA2Juq8T4VviQFySxX7m7FkhaLS7QcmHOGbpOAx
	r9PPgf5wXQebwJS5G8rhXwEAy2tb7jAZz0z2w==
X-Received: by 2002:a05:6000:184e:b0:43d:7d24:b510 with SMTP id ffacd0b85a97d-4493e5a7a64mr6025860f8f.22.1777563707827;
        Thu, 30 Apr 2026 08:41:47 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a0c9:1d35:8283:f96b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-449c576d0a2sm3596521f8f.31.2026.04.30.08.41.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 08:41:47 -0700 (PDT)
From: Kai Zen <kai.aizen.dev@gmail.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH net v3] net: rtnetlink: zero ifla_vf_broadcast to avoid stack infoleak in rtnl_fill_vfinfo
Date: Thu, 30 Apr 2026 18:41:35 +0300
Message-ID: <3c506e8f936e52b57620269b55c348af05d413a2.1777557228.git.kai.aizen.dev@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CALynFi54eQj7SOmF6QNG0eqhLw7AuURzo6tSYQavvM3ZP74ikw@mail.gmail.com>
References: <CALynFi54eQj7SOmF6QNG0eqhLw7AuURzo6tSYQavvM3ZP74ikw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A1DD64A5320
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-242150-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

rtnl_fill_vfinfo() declares struct ifla_vf_broadcast on the stack
without initialisation:

	struct ifla_vf_broadcast vf_broadcast;

The struct contains a single fixed 32-byte field:

	/* include/uapi/linux/if_link.h */
	struct ifla_vf_broadcast {
		__u8 broadcast[32];
	};

The function then copies dev->broadcast into it using dev->addr_len
as the length:

	memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);

On Ethernet devices (the overwhelming majority of SR-IOV NICs)
dev->addr_len is 6, so only the first 6 bytes of broadcast[] are
written. The remaining 26 bytes retain whatever was previously on
the kernel stack. The full struct is then handed to userspace via:

	nla_put(skb, IFLA_VF_BROADCAST,
		sizeof(vf_broadcast), &vf_broadcast)

leaking up to 26 bytes of uninitialised kernel stack per VF per
RTM_GETLINK request, repeatable.

The other vf_* structs in the same function are explicitly zeroed
for exactly this reason - see the memset() calls for ivi,
vf_vlan_info, node_guid and port_guid a few lines above.
vf_broadcast was simply missed when it was added.

Reachability: any unprivileged local process can open AF_NETLINK /
NETLINK_ROUTE without capabilities and send RTM_GETLINK with an
IFLA_EXT_MASK attribute carrying RTEXT_FILTER_VF. The kernel walks
each VF and emits IFLA_VF_BROADCAST, leaking 26 bytes of stack per
VF per request. Stack residue at this call site can include return
addresses and transient sensitive data; KASAN with stack
instrumentation, or KMSAN, will flag the nla_put() when reproduced.

Zero the on-stack struct before the partial memcpy, matching the
existing pattern used for the other vf_* structs in the same
function.

Fixes: 75345f888f70 ("ipoib: show VF broadcast address")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Zen <kai.aizen.dev@gmail.com>
---
 net/core/rtnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b613bb6e0..df042da42 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1572,6 +1572,7 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 		port_guid.vf = ivi.vf;
 
 	memcpy(vf_mac.mac, ivi.mac, sizeof(ivi.mac));
+	memset(&vf_broadcast, 0, sizeof(vf_broadcast));
 	memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);
 	vf_vlan.vlan = ivi.vlan;
 	vf_vlan.qos = ivi.qos;
-- 
2.43.0


