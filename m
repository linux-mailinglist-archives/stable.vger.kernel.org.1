Return-Path: <stable+bounces-249574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOXCDylaDGpxgAUAu9opvQ
	(envelope-from <stable+bounces-249574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:40:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD28E57EDDB
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79FA93059FF0
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B774DB561;
	Tue, 19 May 2026 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5Sk5Txk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8D14CA278
	for <stable@vger.kernel.org>; Tue, 19 May 2026 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194154; cv=none; b=b9zlkOcSbqNU6Aid87A3HQSIZdnP8Z6ZgCrKpSxV5rSNEWkvyZjuOS5OXCvXdZt62hJTdsJtOQTEsUpLpuiRhbFLSm0sN3rMhgbLPbkLb1fD8zAdTnL9h1zUiMghEDaG3f+aOCa9vGWccGp9MvWrOj7eFMuAV338ZE1eSIPiGs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194154; c=relaxed/simple;
	bh=D+2/EVKq9/7Xf+adkdI9jDdt1duhUByqR11WILXVobQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X7L7rpMW4wTRO569xcmlIojSTSHVhegVKxB8OPhhfBWD01mo/3fX0/zAVSTudIxNplqPKO/pgyPF///uwhl4oRgEaThkC6aL8n7LkkrGqk+tqQqeNhXbRYUokoBnHSI/F0VSjMJlyoeGR3gGrZmWin1KSOf7B9wgsYYB6Uh102w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5Sk5Txk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b9e9a6802aso13868275ad.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779194153; x=1779798953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+JHu2ds3R5KJ942QPjAKwmGWLPsVM/h7r8Q8dtsEwI=;
        b=H5Sk5TxkNt3iBrGJDbRHj56viezKoGWEt1Eh5WrodqRniAJ5U+8b5A3notzqQ3tJm/
         JeJLtRlL4xRIZjA3qzll++5BmtiDC5quE2V1ew7cg+dsynXOA42i76oaGUjyPMDjV2qs
         9r9iCROw+4ZAh5uMZZsjRJyZSpS4d44Z9xHiLgv80M7RDVUr0p53i5NOJm0AjAexVgc5
         Dpx+0RYfRy9b0lGbpB329S8wZFMGmWsdoA6u2EVbPTRoKqorEBvP2kiCuuO00PYwki6R
         2GohMRbkuWD6qPD/OWsPk4v0tOxqMahE4VplH/Pv08qZO3vzApi691Z58YB1AhzF7Ecp
         GQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194153; x=1779798953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+JHu2ds3R5KJ942QPjAKwmGWLPsVM/h7r8Q8dtsEwI=;
        b=lvLNUwkR0VgPgCNrkm335YyYAy/k7g9cawmiXEi+T6wCpeNWV00k4xtCV/bzAP1C6h
         jvYZacvB5yj6h95n0PhfibwHzVLoLtPNoizkwZ7DGkD1rSERo/McXi7B5GsUElcDDvB6
         Q/KLQmwWkKSjlMOfHOjmw+mF0UCV4++M6Y+y7oCNsMr9+K8kCg4T0PJ4173UzKZwe7zX
         ANs/I6aW+ij0/reknrl0TGDS2ow8MGDdgB4bitQNnzWZ8wuqwWcte/JgBnxAYIXvvUv6
         M32MbRqSYwL95U3r/LZjVyBbfJ8agnAuOe/1iJVk0vlAeEn+JT7YJo6nZqA80Ttu40kt
         VkPg==
X-Forwarded-Encrypted: i=1; AFNElJ8r5nvt43oIFIQNpi7yT0/i8vfI9/p4CnRInXRQqp0HG0pY1JXhAwhozbuiQI0BK3VN/vvnhjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIMym7lTf/R627BuiP5mg4VysP1Nh0RK6KR9iigFKpfQD3Nys
	gvz9T6BRuBLv4QvKNxcu0E72PpoKTBmTh2buu6BkdVu66XcPs9e028iw
X-Gm-Gg: Acq92OG46ekHWXHc7pCQ/BMOQs+S480o1R3S6XF/CZXig0D3cnHjvY1vCU96Zo8zOdy
	/5R1ghOAZa4+YPe6iJ8aSESGbVFdZDjoHkI4wkbuD1Z17GRzRekucVN/QTEpUU87Yawkt3/+3Xd
	QO7SrDUzw/1kBRPBg4YwSpsAkHu7L1SmMgMy2qITnQS2J11MoqoSBFM4z9aRLcDjFBAdM2euaGd
	FoIexZG0H2LYl0gOJINhN88dSSUb31KgnjkcOXyNapmd/j+XHlYEntfh7+w+CWC6sZBoNE6Pkxy
	mPvIuPn7z8kT1b5Szr2aVhF9aVwPxg9YGXLACCj52VEONj2Vn/HF1UVAQ4ExtufTbpjvjQgw7Nj
	h1Su6RbJoCX6g9jyfYPay4jZEzAIXzeO01U4PxNqbc7URzjpIWmsktnSQ0P7pFhcZr+ludTvNEn
	4Oj0A+rYl89bWABwy3irr6jXG+D7jcjjGG23mLvCuC0dYGereV
X-Received: by 2002:a17:902:db08:b0:2b9:ec37:2977 with SMTP id d9443c01a7336-2bd7e98f43dmr211656335ad.38.1779194152825;
        Tue, 19 May 2026 05:35:52 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc60sm193216245ad.9.2026.05.19.05.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:35:52 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Shaw Leon <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 0/2] ip6_vti: vti6_changelink and vti6_siocdevprivate netns fixes
Date: Tue, 19 May 2026 20:35:45 +0800
Message-Id: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-249574-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,secunet.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ip6_tnl.net:url]
X-Rspamd-Queue-Id: BD28E57EDDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v2 -> v3:
 - 1/2 unchanged (Reviewed-by: Eric Dumazet, carried).
 - 2/2 (vti6_siocdevprivate hijack fix) is new. It closes the
   regression Jakub flagged in the v2 1/2 review. PoC details
   posted in the v2 thread on 2026-05-04.
 - v2's 2/2 (ip6_gre: Use cached t->net in
   ip6erspan_changelink()) was applied independently as commit
   1d324c2f43f. It is not part of v3.

Kuniyuki Iwashima (1):
  ip6: vti: Use ip6_tnl.net in vti6_changelink().

Maoyi Xie (1):
  ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().

 net/ipv6/ip6_vti.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--
2.34.1

