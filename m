Return-Path: <stable+bounces-254501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIRFCs2kFmoOoAcAu9opvQ
	(envelope-from <stable+bounces-254501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:01:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F355E0C61
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5139D306518A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9714D3CE4A7;
	Wed, 27 May 2026 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LawSnM1f"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE83CE0B8
	for <stable@vger.kernel.org>; Wed, 27 May 2026 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868774; cv=none; b=e1CMiiXO0CQWbBkcGhojnekMD6vX98qRoc3t8JZJmlvCPUKutgRtw1L351qpge4cqgpOSnC7t8XrgXOVDW/0irPTR8A7UINXxcMIloQgYENmDxHVtda9cTP9wG9ss7ZXIqCZIdLSaecrAjKw83OxTK1dbqjDZOMZhgC9PmhdDcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868774; c=relaxed/simple;
	bh=oJWJrp+hfd9LJvMDqawW72LsBMSm3eITaNs27jH29x0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xa8a13CNfRyC8sDKPQFaIoxJglADATPWdrGmLozKfBoVbUI9UAxLG43prKSchdGmqfBkF08bPHYQOLoLR3jl5RJw3w2S0R+GUYNQPQnxcC8D7439PmHZ3gJopAjOE9edErCWNx9MervGD5IJTbFqjvZilkA9QSLtdy5KF9YDJWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LawSnM1f; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3697c35eab7so6946601a91.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779868771; x=1780473571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XASDqBX1HWl6sXU3qoflGCtvXLQG0oc8mDyz90ZpDuo=;
        b=LawSnM1f4MR2FClxmaMPApL+y134am5xo+3k0mA7hDkCSzlQJu6rX6cpC2MVYIXvND
         Ks0poI/nDvYKYVajwxaFlXbZLMQcMbIF8tVA4A+QBWJ7XSibzGhd2aUn54/cnbe6jSS3
         1hYHa+5/lV9CEKxP8hZX+dSpLNxqAEAJ5eTo08DXQj1rDfrvFUzAreGvEXEzbGYQu+74
         eEyTlARUu5dyd5+sytnMdfqOt2W5Zmrm8JzPSxdI/acUCvt+2SCd4U5QgSIxjO2zYsQD
         6rBVx12/hqDXN5SotOGomOHTNBsFAJPwlvehrOJJDYY0bleelW+t8xwHNHW83EMSZ9pP
         XcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779868771; x=1780473571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XASDqBX1HWl6sXU3qoflGCtvXLQG0oc8mDyz90ZpDuo=;
        b=KCmkSX4+iheo/JiV2coCvCAH5vcZ9/vWjoOwzxCsCwgGZlsMFzYJw8/oMatcNNMDsh
         EUiFUA4sMP9PUAAF5k/+hukT7Fqn7d19+ZSPBHvED9g4batM7Lphjj9fwpPUkqh5Qo2A
         zA3nlX73CilNYpzW2d+uDvX7ObEpM7wGYPh5vQv6evBjVFvbQVjSl0aBHlx8XjAiWZUv
         EwEuHg71d45CyVUu/29eHp9aBqPTZLQdE0OF+cNjGGlusPSn54bQUhEpr8j5yVgg8JsK
         5zj2qXCMWnaw2FjS2BePgWLdcWZRo7Q7Hlx0mShL/TvqVxRtE7mBUw+X98cqbDhQJ7Kb
         DS1g==
X-Forwarded-Encrypted: i=1; AFNElJ+PFzAHwvJXU3Xkg3xm/q8Us4MnjUYUpD/lVV3sj50m+XJjbZV3nPx4PAUUjnyC2vp+NGd7iE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQ89qVD/HUupxJBSjEUEBT2FXCPJJCLAAyFMQQCrR9TYn6QDC
	x+SuX+wsZKGDNGLLdTr0xrWiLUM5AL6UBZJfTTAjbAJ89MNbKzm1anm4
X-Gm-Gg: Acq92OHoRZswiVDLlHQSzEEFvmds+QBsr/lnUUvuSl2+2eCq1hfRcp8euPki7GJomq2
	XjX2AnuxcICwlWvxz3BITR+WhwAsVfvNpVQA2E3IKjboGfZ99eI9X7ndaPlxohAc3ezPzAXY4kF
	2tU0fhsjf0tHVjH4SBdCLQ/QWlvHNqQYpbUkhmo7eYXwPdSxFOQPFOyFbhh/Gfn2TFrj6LnVrPx
	kh0bHFXR0FMs6ovq168JBEMJ06pn5cQWHND6LGQBZpzwupZJV+6zC1TLCmP6hGjWH33yYEMSwt+
	7TpIthWtPF6DFb6jARH5lq5Yg6AtEbzSbXGzIVw698M1nBsyax4EjUS+oM+9hatDNyEem6NfYW5
	HfD33Xr07nW5gtQSFiSd8wXzMcMFaZnKWsrvRUjUvBK8Qjm+59Q0WCmN0TwZs64gyFOOCUzYXhn
	/tKFnJUsmLbk48s4NAqjnzuMZLZMnIXdnlOeUShpvuSafiB31m
X-Received: by 2002:a17:903:2b0e:b0:2bd:a403:4ab8 with SMTP id d9443c01a7336-2beb06319ffmr244207735ad.25.1779868770897;
        Wed, 27 May 2026 00:59:30 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f54sm149937405ad.10.2026.05.27.00.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:59:30 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	Jan Vaclav <jvaclav@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Taehee Yoo <ap420073@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] hsr: broadcast netlink notifications in the device's net namespace
Date: Wed, 27 May 2026 15:59:24 +0800
Message-Id: <20260527075924.2707856-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHPEe=GO=2qqWZPwBB4rrXc3mkD0dznp2K78nCsKwF=c-QwxEw@mail.gmail.com>
References: <CAHPEe=GO=2qqWZPwBB4rrXc3mkD0dznp2K78nCsKwF=c-QwxEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[suse.de,redhat.com,lunn.ch,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254501-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 77F355E0C61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The HSR generic netlink family sets .netnsok = true. HSR devices can
live in network namespaces other than init_net.

Two async notifiers broadcast events with genlmsg_multicast(). They
are hsr_nl_ringerror() and hsr_nl_nodedown(). That helper delivers
only on the default genl socket in init_net. So the events always land
in init_net. The network namespace of the device does not matter.

This has two effects. A listener in the device's own namespace never
sees its own ring error and node down events. A privileged listener in
init_net receives events from HSR devices in other namespaces. The
payload carries the peer node MAC (HSR_A_NODE_ADDR) and the slave port
ifindex (HSR_A_IFINDEX). It leaks information across network
namespaces.

Switch both callers to genlmsg_multicast_netns(). Other families with
.netnsok = true already do this. Examples are gtp, ovpn, team,
batman-adv, netdev-genl, ethtool and handshake.

hsr_nl_ringerror() already has the slave port. It uses
dev_net(port->dev). hsr_nl_nodedown() takes the namespace from the
master port via hsr_port_get_hsr().

Fixes: 09e91dbea0aa ("hsr: set .netnsok flag")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
This is the fix for the problem I reported on netdev on 2026-05-18 [1].
That thread had no reply, so I am sending the patch and adding the HSR
maintainers to Cc. The proof of concept and the test numbers are in
that message.

[1] https://lore.kernel.org/netdev/CAHPEe=GO=2qqWZPwBB4rrXc3mkD0dznp2K78nCsKwF=c-QwxEw@mail.gmail.com/

 net/hsr/hsr_netlink.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index db0b0af7a692..067ceaf7304b 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -247,7 +247,8 @@ void hsr_nl_ringerror(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN],
 		goto nla_put_failure;
 
 	genlmsg_end(skb, msg_head);
-	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
+	genlmsg_multicast_netns(&hsr_genl_family, dev_net(port->dev),
+				skb, 0, 0, GFP_ATOMIC);
 
 	return;
 
@@ -283,8 +284,17 @@ void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN])
 	if (res < 0)
 		goto nla_put_failure;
 
+	rcu_read_lock();
+	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
+	if (!master) {
+		rcu_read_unlock();
+		goto nla_put_failure;
+	}
+
 	genlmsg_end(skb, msg_head);
-	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
+	genlmsg_multicast_netns(&hsr_genl_family, dev_net(master->dev),
+				skb, 0, 0, GFP_ATOMIC);
+	rcu_read_unlock();
 
 	return;
 
-- 
2.34.1


