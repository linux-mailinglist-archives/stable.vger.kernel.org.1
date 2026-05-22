Return-Path: <stable+bounces-253762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLhAAhU/EGrzVAYAu9opvQ
	(envelope-from <stable+bounces-253762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:33:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9985B30FD
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 545C83002921
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F523D47C3;
	Fri, 22 May 2026 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzyycdZ9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793922475D0
	for <stable@vger.kernel.org>; Fri, 22 May 2026 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779448922; cv=none; b=IT31I/celyBd1ZqiM4esp2gto5a0fNKn/9xJqcFgN5m/vp6i7i2Z1HWLcutOKjaK9p8kq8QAtxuBpU0FmIZnjBHX4g0Oj+1A5vEwCKDztA+3c16D0WQJTvRKY6ZRXt/80OE6DpVtW1yETl4R3VhRviaSwMNDylhDDDZmHtspAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779448922; c=relaxed/simple;
	bh=GoanP9Hnyr05fcNqi8yCVr7hIWjDoqR71YN0ZQppHNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eraWJh2ZkuC7pU2vPaCz039WQ8i0vkyeWZCPm1CHkLwwOD+JOyyOj9u2hlHRmF/t76GybfFAgikOv9FLc3a4s4aWpmOrfig/+pnD7q2KJDKXgA5zo9BHRd8ZDsoNYUQoV9zuOzFqjl/RqWEtvlzVtLlzUhlvhdFT79Z/zo6p7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzyycdZ9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903cbfad68so10977195e9.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 04:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779448920; x=1780053720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/7xC0xHYnkdI85KGaQDyVx6/ZrFWzU/L8MC75w3DKec=;
        b=MzyycdZ9eXaNANINNsRYEvZyYGuFOdbsHtoF2SUKiekAcHcYpCLPUZpARI5Kxvmoke
         36RSVVcSGmexBegCtMxKElYSJQd4WbSdsMTubtCpNtwpo0Pau0QPYpXJR/0UhchignHH
         qq4eBY6JEkg/encmKVZC+RAd75nvP7g0E5Fjve70ZZsNiAyZJzZ1oGdadg0Wy+uXbhdr
         3E934heCmbJ1xOGCyH/AmFGGXSGpETLSy3RdoygHlb1UOgzbTaq7ippVlPkpMOoaQslX
         0GrZbDuhcSBGRKXROrujCj+IJAr858B3FK7WZGG7J21NT3LOxx6wPOZN+rqiASVpptkI
         Q7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779448920; x=1780053720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7xC0xHYnkdI85KGaQDyVx6/ZrFWzU/L8MC75w3DKec=;
        b=R4FLUpMIxYlhExg97LlUq4/ZBztz3i9584NZ/BViI1AEJJQ0VnIcw78jVle9AWgr0d
         8BXshaIQHPd6x+ldMXP+l7Ed6+X6GRsofPg0b1EyNQ1GPx0DVmB9KzITh9yvxfa5WWjg
         3vYpK//9RNvwB4OA5liGscH/8NTwdZ9hJ2lfBgfVoF+DKK9GQkNtyM8rHi+vvg379jtQ
         q+HdVCMoED1loZpOzyq4XQ+m52P4sB55pgseEv6H6zBfhhwPtapk6VeDY62ttgmvEYDD
         6CEJrpExJOMu5k0Dmq9fkcpUZAp2nw6UL/gX4AvmzuurJGi2oGBw/xn6U5JyVv6y3ok9
         6tdw==
X-Forwarded-Encrypted: i=1; AFNElJ8uR7d6W2XK21oR1arQaUUZMrwDLp8ZM6SlkRMOnHf7qAx5W6SI5rWw3A58TIDNi0UM9VKYngA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOgy5N35VUW/jdTTJhDyeIPX27dOt9PPsZFQWvc/SiGP+KmHo
	NX7hPe8RC+Tun6QzaAbSh94/FXi9/gLn+gS4N/nmJZK9wBPfY/7GOGDKqZ5C35aT
X-Gm-Gg: Acq92OGHuBF6fJx7yYuXx28IgiObvfgGf/ssLEGsCKIHAitaM/XFkWQdiaGATYvVwPQ
	c1bv9DlwwZE9zv3me6WBa/e+AmRzuv3q0zyx/oLC1DLwnP/VoL5kaC1/1pw+3PxBP0EJn/YYi+7
	KRbMuFXi7wiUjpqxXA10gsy4l7UVM8Ry0px15wTY76E1ig3R+IzMbb+/Qs39G0TXsPqadQ8PcWL
	SmBeVpEpndpur6oL5l2gJ/XFh57tFZJOzUFSD9YYXclQZyx5fzFqr4U+/5uPR7AiKnb00QC0wR7
	YLqEiutgP6Y1EImU8gTmT0Ae+1yZC8iL4zS6iZHc0Qc8pMrtfCoy4fPi4EazRmLqgeQ5KWUts41
	cFCKbEyvAJhxH/yIw2OkKzyCmuZW/xpg+Zz4QXvXDJpr2zVpoIjYtApbShKNJLTTCO6JHxAIzBK
	UHsjw8ZCwYGDPq1vlQVAvCHytqSTNTtDVXQ90jTcoVNuQu
X-Received: by 2002:a05:600c:8599:b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490426ade02mr27020475e9.15.1779448919764;
        Fri, 22 May 2026 04:21:59 -0700 (PDT)
Received: from localhost.localdomain ([31.4.50.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904179826dsm21169875e9.2.2026.05.22.04.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:21:59 -0700 (PDT)
From: Justin Iurman <justin.iurman@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	idosch@nvidia.com,
	justin.iurman@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] ipv6: exthdrs: refresh nh pointer after ipv6_hop_jumbo()
Date: Fri, 22 May 2026 13:20:13 +0200
Message-Id: <20260522112013.12342-1-justin.iurman@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253762-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B9985B30FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipv6_hop_jumbo() calls pskb_trim_rcsum(), which can change skb pointers.
Let's recompute nh pointer to make sure any change won't mess things up.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
---
 net/ipv6/exthdrs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index cf90f933ca1a..11915b75ece0 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -184,6 +184,8 @@ static bool ip6_parse_tlv(bool hopbyhop,
 				case IPV6_TLV_JUMBO:
 					if (!ipv6_hop_jumbo(skb, off))
 						return false;
+
+					nh = skb_network_header(skb);
 					break;
 				case IPV6_TLV_CALIPSO:
 					if (!ipv6_hop_calipso(skb, off))
-- 
2.34.1


