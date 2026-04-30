Return-Path: <stable+bounces-242141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEDlJEx182mt4AEAu9opvQ
	(envelope-from <stable+bounces-242141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:29:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0F04A4C28
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4757B300100E
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BFF2F3C1F;
	Thu, 30 Apr 2026 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAHGY0ZM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2D242D84
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562815; cv=none; b=oBV2vnnBDBhcWTiDq8fx6Bb1NpqAvHoP3RirDlYV78U90ndsmy+OHKQXs0PadHSl1eke+QEXO2yLMlgt77xPkzm1zsOuGDHGUhk8JoGjiqyCv/4izqJ7Ma9T1p6YW88Yzou+wF/zHOQNzRHzUBvzSOp5JhZVbGdmlokAKfbkYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562815; c=relaxed/simple;
	bh=z0DYBvb+LZUpxretZCjDv+k9yn01sF1apvq6+r/SDyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7DLlQ6Sg3R2ixPwLicRmpS6z/7lyhrBNCyqqXfbrjdAr0W35QnBtt+DKZjjPF1nlEwQOLILqGRgu+Mexc8A9rETTu5lKO7gXjHHral/y3hezp2wTsICAUVWeQwylN7tpbdikF+KXXm/JkNunOITDv4p6OT/s2ZbKoHFJvpv97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAHGY0ZM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso13149325e9.3
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777562812; x=1778167612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1jOo4LrB4QdOIsyappS3L/Lh2AU+Kgh3i+w/0anQdk=;
        b=oAHGY0ZMUcPi/iwy915tcI2O60jUooipymzZNyQ1WS+f5D6udHxif9elFZhpd/pP64
         kYbsbjD9mde6LUYomaTn/kx4k5LP26s4x2/mgEalWGXtVaQNZRv3SERQcL38TtcGwdG3
         Kt8jS9sOh3bB1jyeSfmSvWupssjJhTaEr1m2plnW0JaCx8Mj/Jo+uuMF4nJatUE3IRCl
         F6L+ne2+M97Yu7XdaSkQ7i7vtdSkOO4CzP0vxWg9e97d1stUmGSXAJ8syq6Bk/H9Ki9z
         knpFUrv70+Bf6HwnuNardnq4TVzJZbG0sc0WGhua8Ic16GOYokNw8puGMpDoXDAvcDPn
         VAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562812; x=1778167612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1jOo4LrB4QdOIsyappS3L/Lh2AU+Kgh3i+w/0anQdk=;
        b=jcoDTtiAFBTzijSzG/zfTn4EWtInfWLI9iM8c8x6WiGuEVtYfGQQ9yPuH86em9dKBz
         /kbUjjIsw5DNx3lgI7Dy9OuOpViS0RkL/wSIrpJodvpJ5em9cR2Gp+czFxLzLNRic0Zs
         nhqnpD2n49HzQS/OVWFHnpVtM78lk4UzR1812CAteZXFIy/lwJHKs6W/wT77fOb5+M41
         nrZqssNMxsG8HjwPZaYiroH0Un9wDTEhw88YfgvitiHgy7maYr27mN6sByb3vphFeXjj
         210qFucQcyKDWy3JWuvuNYmQ+1zF3wJoPpFhEwhEfy4dxy/OmdqAbYB04/xTzX1IwvHz
         NEpQ==
X-Gm-Message-State: AOJu0Yx2VcTTMU4r3yhTby1yz0t02BqegPfpfJxmt+S6FSVlZ6toAFhb
	J1oDHV4kMaq6o96xAA6G3fSKismaChLEXskX2F0g8eYb+zrhIFpopgzn
X-Gm-Gg: AeBDiet1M5gbHyDBpUTKw2iYlqANzX7xTIurGAz6H0+iygbXVT3JgPA1MoDBOXNPDWN
	LI8dZ4qmXdYyL6WUJMyyzAYNsnVeYxmU7HeUDrK49ODK40bh2tb2I06iWxQG2RftAi/tL3naxar
	MXhNJQuWFBHX7pfVC8We6LFQXCs86bE3DtsGFF2RYkpMx+WDmyFLFgWwrVgOo+7uFyOvw1t2rn1
	fDyvwLcphnRobs3isDMg/HqH0+mhqT2LnU/NaFj9GbVqulwWtk4ok+IpTLN6Rao4pwZceqIc4vm
	Ky9cyHTlRO16O/wjUSNa7yFn1FVVOFZYnKOmxgazQzZPJrCoBHUSy9XSj3x1V8w3JptPM9vep3T
	OXEdkwmghKLtd+zwnJko+QUosC8GFjpOzfi8mTehNqKGbMVGBAkY+/KqeSqsIGwrlWtFUQOrpyO
	UuGTHE1qjlXfynsH8CpFrkF6iC/azKgo6vCVA0vMo8DJVWvWc3pduOXucOIK0driQwNsInk6a4A
	wfhPsNvpGyTFwucE4bc7x5fL6wEpXXjEd03cw==
X-Received: by 2002:a05:600c:a408:b0:48a:58ae:992f with SMTP id 5b1f17b1804b1-48a84446302mr43617965e9.16.1777562811753;
        Thu, 30 Apr 2026 08:26:51 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:f9d2:9c9e:9a42:5d91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301ad1sm119212485e9.9.2026.04.30.08.26.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 08:26:51 -0700 (PDT)
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
Date: Thu, 30 Apr 2026 18:26:48 +0300
Message-ID: <3c506e8f936e52b57620269b55c348af05d413a2.1777557228.git.kai.aizen.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CALynFi54eQj7SOmF6QNG0eqhLw7AuURzo6tSYQavvM3ZP74ikw@mail.gmail.com>
References: <CALynFi54eQj7SOmF6QNG0eqhLw7AuURzo6tSYQavvM3ZP74ikw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C0F04A4C28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-242141-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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


