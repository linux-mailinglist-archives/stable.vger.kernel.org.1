Return-Path: <stable+bounces-247251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D6mCUH+BWrFdwIAu9opvQ
	(envelope-from <stable+bounces-247251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:54:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF0544F77
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D1CE307FDC3
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40654344D8C;
	Thu, 14 May 2026 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXAkRKMd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8033A007
	for <stable@vger.kernel.org>; Thu, 14 May 2026 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777531; cv=none; b=Wz2E/T0fmEccyHpDfECIgWuns2sp7pjifxI1vEmRGv3YkSbSjX0PmxJS0+eFKck//vdlRBmIzIyHeJ6xIKIm48rs1tD64l5DD2L2LR0oU3kwGg9kJG/QKzM+N075cGx98Sa1CbjjRCiN8hXH+UVfUCHWKbZdoYt5nhkcvGPI5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777531; c=relaxed/simple;
	bh=3EPvR1ScT1B0f5NL80yDzKu7nP5JRSuTf0PXBGwV2lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSTYDAQItb8T5N75vOwJCznIHpSn5EmD+EagLh7i2Zbd0jCT0rFw2M4bN4w5jZdcBWCBv7Ygi2/dpWOvLy1rhRTNO3eu/tNUU8BJRuwPSCg+3jnh33Hj753luv8rAvPmRRJGR1MaHIWp67dzjJC6qDv1LkaQIo6YF/m0OGZ5XLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXAkRKMd; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c802803ac17so3758998a12.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777528; x=1779382328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwRQjyq3ZOtr85xXuZw5Nv7geOh6ncaBN6Zn+7ncG30=;
        b=lXAkRKMdHAhoZ0VoElce6HoTabmLMhQ6cyZSgGmude2x4xovzRMmk8+BYDOsXuipBK
         oekH0NCebx6pFss8Ap0vV0LyWCQ/4YGrWtL/pKKAHWaBpepdxhYMVJBja/rxQMDfKNYe
         /xQkZ6ARfR/AfXG3z28OG1md0CLTySY9L2dWa+GTvBEuv5t1BRsc3b446KHRMmKXGr9D
         hhUvoqzN5Sz5PqIsjFObX756EyRQNuMTm9CxvAh52SWUZG1CdaedjlF931LUd8B/Z+Dw
         sLaWzjc5XTlAEw/ImEMm6K6wTBqVCQQGIlef65pjBIlI7NdSAJecEhp4GxRS+5l5mW+6
         Aaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777528; x=1779382328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwRQjyq3ZOtr85xXuZw5Nv7geOh6ncaBN6Zn+7ncG30=;
        b=lxzA0Z1k7+dGk6GSFaXPpXixS96pLZ0EzaZqcQr4IGEU4q+opIOhPZB3J2svoPFjMw
         xt95rOueyBVgpxUR2kFKL6k5ItWSRAoXKYNK+QTDAHH/48QNVEyMN1SPDDR5OySsCYZ3
         4wmemaC8FmC9VnYDziYKor7AZFfvwl2ncr5QCpU8gtZsdrG9E0jiJ4n0k5ES7a+dNaR7
         6S5JDtRYe5RxqslkTYGUeJW2Bh52L8vtxO0P0+Z0zRBSxoRjNLHFbYi1+Uka6buC7bO0
         WRaWPN0/EWHTKMZH72v/169mgtXhWmJ+P3N/MN/AUXGW8f9dq58x2fOBlAwEHQz5XUeq
         aEnw==
X-Forwarded-Encrypted: i=1; AFNElJ/M35t34YsX/r8v8alFJ2vYPpz6e1NChhN9z1SdUgGv6K/cbtpSN4m1lEAq8EfosI0AxC1NZbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGB0DmD8GXUFJrLKT3fgqKJlBe5zn60OMyaMT8cA14Ka2Lngv0
	dZPbVBhr/ZDWTzcB8wWoFULMHsVObv6zCR2wXscDfcVVsG2fk/lTSliv
X-Gm-Gg: Acq92OGO3JgLKs9/Nh1RHaNrG7gVS9gLTteMPjBIIjgAQuE9S/s8NlecLGGUW09mPUv
	TXuWKU098Z617vXla/WMUszqMTbTal1qU3O8Dgkf9h+SYXS2DEBf5bna35O+5+er0akPa85mW6e
	WVBcFi+/nRcdqv8XcbTfL3GGAcuTqgg/HWdZDkE4KcyWgNK1/Ve0IS9XUiTFFRnafoA697TG1ed
	xC1bqnOepuTHMdupOU52LvOS4TTzX+4fdnxwR+B12mFXqYGfP2igszxiJxln+LjpCHB1cRQoEYi
	lyRHxBO03pUNSN2DCv8ojiK3OnWFcz9aeXGQdSFBZXh5/6ZBKUGBIenRjjqn4nR59uKzRb3qWHX
	31aXKvPdem2F9xa4UWesXsYky7Mc18XXcnTK+ArBDoVcQvJQ1Y+mEw8+5cKxNyTcKJufW9XDWsp
	Tm3FNNg4vp+TEKuwZiaRHuWAOkshIpCQ==
X-Received: by 2002:a17:902:7d95:b0:2bd:3bfd:22c3 with SMTP id d9443c01a7336-2bd7e88ee80mr2444355ad.24.1778777528083;
        Thu, 14 May 2026 09:52:08 -0700 (PDT)
Received: from Tplus.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c2631basm27937825ad.34.2026.05.14.09.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:52:07 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Simon Horman <horms@kernel.org>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net 4/4] netlabel: validate CIPSO option against skb tail in netlbl_skbuff_getattr
Date: Fri, 15 May 2026 00:51:34 +0800
Message-ID: <20260514165139.436961-5-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BDDF0544F77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,paul-moore.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-247251-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

netlbl_skbuff_getattr() locates the CIPSO option in the IPv4 IP header
via cipso_v4_optptr() and hands the bare pointer to cipso_v4_getattr().
The consumer re-reads cipso[1] (option length), cipso[6] (tag type),
and then cipso_v4_parsetag_*() re-reads further bytes from the skb.

__ip_options_compile() validates these bytes only at parse time.  An
nftables LOCAL_IN payload write reachable from an unprivileged user
namespace can rewrite them after parse and before the SELinux/Smack
peer-label consume path (selinux_sock_rcv_skb_compat ->
selinux_netlbl_sock_rcv_skb -> netlbl_skbuff_getattr).  This is the
IPv4 analogue of the CALIPSO IPv6 trust-after-modification fixed in
the previous patch: the tag parsers walk the option using attacker-
controlled length bytes, producing slab-out-of-bounds reads whose
contents feed into the MLS access decision.

Validate the option fits within skb_tail_pointer(skb) before invoking
cipso_v4_getattr().

Runtime confirmation (Smack peer-label policy + nft LOCAL_IN
mutation of tag_len): UdpInDatagrams increments to 1 and recvfrom
returns the payload, showing netlbl_skbuff_getattr ->
cipso_v4_getattr -> cipso_v4_parsetag_rbm -> netlbl_bitmap_walk runs
end-to-end past the option's true bound; with this patch the
consume path short-circuits at the bounds check and the counter
stays 0.

Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 04f81f0154e4 ("cipso: don't use IPCB() to locate the CIPSO IP option")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/netlabel/netlabel_kapi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 4af8ab76964e0..ace561a2904a4 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1393,11 +1393,21 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
 	unsigned char *ptr;
 
 	switch (family) {
-	case AF_INET:
+	case AF_INET: {
+		const unsigned char *tail = skb_tail_pointer(skb);
+		u8 opt_len, tag_len;
+
 		ptr = cipso_v4_optptr(skb);
-		if (ptr && cipso_v4_getattr(ptr, secattr) == 0)
+		if (!ptr || ptr + 8 > tail)
+			break;
+		opt_len = ptr[1];	/* total CIPSO option length */
+		tag_len = ptr[7];	/* first tag length */
+		if (ptr + opt_len > tail || ptr + 6 + tag_len > tail)
+			break;
+		if (cipso_v4_getattr(ptr, secattr) == 0)
 			return 0;
 		break;
+	}
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6: {
 		const unsigned char *tail = skb_tail_pointer(skb);
-- 
2.47.3


