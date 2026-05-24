Return-Path: <stable+bounces-253994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KOVGIV7Emom0AYAu9opvQ
	(envelope-from <stable+bounces-253994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 06:16:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8505C15F8
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 06:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78915302418D
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA9A2F693B;
	Sun, 24 May 2026 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7RoGsNK"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DED146D53
	for <stable@vger.kernel.org>; Sun, 24 May 2026 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779596113; cv=none; b=rWdwZ2ib46RXcFwypymUOFj0Iwc8iVn4macOIu88V/Czzy02ObDIKFrWZGvnjNy5vrdOE9MiIy0Exd5Rqw3OXoM5Wb0Hvj90ioJxkvHQr6DLhoqu1PD6PyDFN7BlUrTXw8Fju9nVY+8CyPUpkls3BDhagJQolQyHoP+1iUFXEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779596113; c=relaxed/simple;
	bh=KH3T/whTjIb1nZ/b0yTDsfG9KkcuwAxRR09DzkU+xNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iz10lSaG6l+BPUct0bx4aHyIyNBNV91xHxPTnNNBYmG1k3aHBM0O9320ALj//CFPeSxey2PPHi+6TUJwt5Wv3/WVoreTM7kkgBCd2MgDo9WFjLJjShTKK4PqZ8JJIXWZ3mAkU0QvKhL+wigBNhtkKEeGVbcXeGykw8iq9qKLgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7RoGsNK; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3044857f09aso3540137eec.1
        for <stable@vger.kernel.org>; Sat, 23 May 2026 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779596111; x=1780200911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9LtOZi90LiMAb4rReSd7b/FTuCWT41FjVk4dArDYLo=;
        b=H7RoGsNKfHksixA8fGglZ21fsi0pPZayRJANuBU/FgXkN29yOahhFYOQCuUZYo6YMr
         1imFmsl++Jc+UgZnhOsg4qz4aBxJbWqJeIOAGtP9d+Ik4ELufuThbu6bU/1MR6gt4cJb
         ouSZMdF/HnFAfZH0PX2px+eb++y4cCzDtM9oQxK5JXUTH8QGgfgLmFlaURz2sU3ewyv2
         fD2O1sVsQfCVa3C6wKtqvC9ZiVxfZXCwl0LWcGOzMLNObiMA1BUERsqOVsSqsZBLuBhN
         vQt1p1uhprDRHwxxLHdLY0ZhBmksbiuCs3kKY2EMxaRK1jLpBaxD55TLjxzs1Xvq4SFI
         kVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779596111; x=1780200911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9LtOZi90LiMAb4rReSd7b/FTuCWT41FjVk4dArDYLo=;
        b=FJiQOEZAUhjYOA3yqVMV1BSPXjGoFaLsFhpwY8tv0z4zRnH62lrYwrTgQFs8FvALpm
         lYZyZEjY8p4XpNIADG0IGsNMD6fRKxDUhhY7mfWrGiLdE66vkSrCgaUqGB8/xQ5WNPDe
         Nsrb/hpSXjwUCDdhn6DBLxOFm+AJb2jeYacdw/Aq7TW5NblPdDEtUFyk/psPWfwaH5Kx
         /YcaowFSiLYb+B7oUD3oC03f7N+W8CAxv0sCVwPt2sV+aNH9QaRhYow72PCpQgG6zOF7
         SKzEWf9bHYjuXYWEY/dqMMUemL1ObZ+o86srS4UCc5MgFO9Syd0gF3jHnbQlyC5JxJzr
         7cGA==
X-Forwarded-Encrypted: i=1; AFNElJ8Lgc/CM5tg73b44287M4SgoibczPV0jtVzZJrrND6lyraxHRGWuPGKLWc1CE31rf+hR9DKk04=@vger.kernel.org
X-Gm-Message-State: AOJu0YycKHQNJgb+WSmQyNYmCusBVJs3fO3bFAbuH+zlimv9nW8WJ1TT
	isDbBXSGT684V4vKTyhaS327grVqlz+V1LQugw1nwLvDzjzDFApxMiVb
X-Gm-Gg: Acq92OEE0mZ6WjS2jwa49Iq4dc6ETmt90RWvRBC/JRL47zpndPKK9bknXhSshJlBDvV
	NA53gXdYjupviapMW+R7KXfD1YriQIAA9qZ3txJ2uRv4y4tZhFiw8F9OlqcOBZ/CBSFxQKf+S96
	0FarBfYsuf7pUi00qXWge/4p9WIyvvZMR7rXKtcvuGT+prV5VcHrqvXGKe6ZbdnFf4vqj93oF4Z
	eWwia/b5wVDM2xKD1JCDYw0DTbBsxEyUAqDqoY8HXB/TqgdsnBHO88AjG8d6AQydnH8/h8xtKZ+
	ggG1Apg5/oCg2OS6HUEAwv+0oEW5kpyXJK+MQpKUCq5anzxoUvRr3vCu2P0R2UWee30HPpJqHtF
	ZhuYnedsqaxini5f2byjh+ABpLJE91QLSGngDl/CgbzdBJCwcUxA+iNfPhpRgVutlclmYm0hQLd
	KbQKny0nP/kTRDe7WqHC0/g8hE1vdV1HhdsmG4ikCr0Bpk
X-Received: by 2002:a05:7301:608e:b0:2f2:b544:2fca with SMTP id 5a478bee46e88-304490e65femr4581119eec.33.1779596111441;
        Sat, 23 May 2026 21:15:11 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045245d6aesm4522133eec.26.2026.05.23.21.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 21:15:10 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	fw@strlen.de,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Simon Horman <horms@kernel.org>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net v2 4/4] netlabel: validate CIPSO option against skb tail in netlbl_skbuff_getattr
Date: Sun, 24 May 2026 12:14:38 +0800
Message-ID: <20260524041442.2432071-5-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524041442.2432071-1-tpluszz77@gmail.com>
References: <20260524041442.2432071-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,strlen.de,gmail.com,paul-moore.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-253994-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AE8505C15F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
cipso_v4_getattr().  The pre-tag-walk guard "ptr + 8 > tail" covers
the CIPSO option header (type + length + DOI = 6 bytes) plus the
first tag header (type + length = 2 bytes), which are the bytes
cipso_v4_getattr() reads to dispatch on the tag.  When the bounds
check fails the packet has been mutated after parse, so return
-EINVAL rather than fall through to the unlabeled path.

Runtime confirmation (Smack peer-label policy + nft LOCAL_IN
mutation of tag_len): UdpInDatagrams increments to 1 and recvfrom
returns the payload, showing netlbl_skbuff_getattr ->
cipso_v4_getattr -> cipso_v4_parsetag_rbm -> netlbl_bitmap_walk runs
end-to-end past the option's true bound; with this patch the
consume path returns -EINVAL at the bounds check and the counter
stays 0.

Cc: stable@vger.kernel.org
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 04f81f0154e4 ("cipso: don't use IPCB() to locate the CIPSO IP option")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/netlabel/netlabel_kapi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index d0d6220b8d59d..c2d3ea751f4e1 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1393,11 +1393,24 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
 	unsigned char *ptr;
 
 	switch (family) {
-	case AF_INET:
+	case AF_INET: {
+		const unsigned char *tail = skb_tail_pointer(skb);
+		u8 opt_len, tag_len;
+
 		ptr = cipso_v4_optptr(skb);
-		if (ptr && cipso_v4_getattr(ptr, secattr) == 0)
+		if (!ptr)
+			break;
+		/* CIPSO header (type+len+DOI = 6) + first tag header (type+len = 2) */
+		if (ptr + 8 > tail)
+			return -EINVAL;
+		opt_len = ptr[1];	/* total CIPSO option length */
+		tag_len = ptr[7];	/* first tag length */
+		if (ptr + opt_len > tail || ptr + 6 + tag_len > tail)
+			return -EINVAL;
+		if (cipso_v4_getattr(ptr, secattr) == 0)
 			return 0;
 		break;
+	}
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6: {
 		const unsigned char *tail = skb_tail_pointer(skb);
-- 
2.47.3


