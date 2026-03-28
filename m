Return-Path: <stable+bounces-230808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOsKMNYkyGkyhQUAu9opvQ
	(envelope-from <stable+bounces-230808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 19:58:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B9F34FB55
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 19:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20F15301AA97
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E068133BBC8;
	Sat, 28 Mar 2026 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q277r79J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C333E358
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774724300; cv=none; b=JToGPGxDxswsEopQ/76Kmt1Wu4f1qkNxDTQsmi0EXwiuLZxvMxN9j42EG9N2mSahuLq45KVW3IKeDElVlxiv8Fir93q+lWqeZlOq5MUq8zqqgd1iVv1LLrfDU60fWoZUZ+rF6hvlOxcjv1Vi/f3sDEVJMYedAzbP5M59SvD0b+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774724300; c=relaxed/simple;
	bh=TY2hsxKzRdg6cVTU5tH32Ru8fM1l3UVUUf+AIaD3Bug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7+WrDVZ4Ih/Je+ktB4BtqYZkpwV3QYouoOTTs+yDwy4S7BZyZERRxjvKyf/3fgrN5yNnDGxecSuTUxUlML9h+WeF7xqdYp9sggAnlmth+jl3NQia478JKovSknoBrdL7zun8BRtd0sFYmhoIU4CLNcSUDYCCbbQvJiJN6s46cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q277r79J; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c742824e1d3so1078298a12.1
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774724298; x=1775329098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWZCRNA7sq5TKfV/GxwqqTIp6ycx6O3DA7KXt4hfRiQ=;
        b=Q277r79J2yZ72Kx3XeYpKwiAmpKOu5ZxmDkdQHGCpWeB/U4KM9bFEacDl3NhhJedP9
         cSv74bT9JjdVkMhYsD4siNtHJIqKbH+OLQ3USw7O6ZzuFOLBfnGH5wcOG2q50FkXUNSv
         cHu22HlJkUYGk0tkhu9AxKgAaFI24r6G4Y/86QtdwY8taK4rwiNSo9Jb+JTZ91WpY5J+
         g2CdF0qlzb6hWuYqZ8JvZy3X2fQmLJTy4z5PF66grPDOMx4LFM23I9IfIoNJ0U+8JWvZ
         ZVnjBmL9pQ/DJlG8UOvN50VyJHjKZ+FUsDMC91XX2wBrLbaJs4qUD03INcODD1lBKeX8
         /r3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774724298; x=1775329098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PWZCRNA7sq5TKfV/GxwqqTIp6ycx6O3DA7KXt4hfRiQ=;
        b=j3pNZ5p07OLvIm/KeC5DeBqsM0Cm8+HtBk7GaC8D7vIH+AayngR15UPbZowk3IC2mr
         ZVOjR1+Q2Dy/plKAi4ul2fZfs9wYZj1AFVdgjO8lGZwtOxhqrWpnPqTautvgaLaw4Wf2
         h5Gfhst6cpKKLx8nXOd6czw6wm+ph121CjFf4zkiLUQkgKtnRphkRDf0jLx64Ocv0+3n
         C6zkBFW7nec6rzrsh/z5yD7ppMF+aQuGb6/oDHX4mPKDxDGdqHxRBY3LBKQijrp97X5o
         co/XF8cbnoaJcsipHWQBt1L+RyB9+Rx9FX4NxcNU2twRGaRpn58uKJzblZ8Va8T6y5Og
         1Dyg==
X-Forwarded-Encrypted: i=1; AJvYcCV78etgzVw3jk/23HnTw9VBL6DWSHQJuclz0uNKgy4bA6YK59Xel9cRU+/dgudWkwFV5Ts57Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhn2KKUziBrpp3Ykaz1K37a5WoT3Ke7dUQGpLTqyaTD4z1TjCM
	u65ZYOpfIffzihEuYM93rnQzuxkcfKqVZOcrt/4xeObejroAFkgDVBiN
X-Gm-Gg: ATEYQzyFH6ggtqzpD72+E6DYQbn0Hh975FOpg5nBJuDZUSlz0ejYyXTzT+O2f79JK5Q
	HlDeks9Kgdf3rvGJ5lefhRRsoMxO7nIr+YuKIQoSmaO26ThgI64oQsmZTRt3b+BCURJlLqAqh6a
	D5zqW9/HJrQK6dIVeZV5anHDE8Vg2Z5HljHPjeJ6EcXjyUx777I37o+1np8B4EHSmrd0UR9VCLG
	WST3lVb0/6zKx6z9ygLhUD6NxOF12JURECBhglEnjC9tRbx8eKzXvw7axSW5Az0LeYaSHJYHs54
	7kEvBo7AYsMtPIWW2bUtvWQ5w5hV9VQ3oTeEFPWz6SLge6EC0RKTPIBebQar3r7qGtA9geGYpok
	V3r/aFSGzfkp6fc2CwlRn8SQrZAYCO6asfJbMK0b2U4l1jQuYbnZAFdYkXHovVcocn3jatyNOtl
	f6WFbVt8AzhHmVVDJ9/Q==
X-Received: by 2002:a17:902:ef45:b0:2b0:4eeb:f807 with SMTP id d9443c01a7336-2b0cdc3e969mr68503115ad.13.1774724297746;
        Sat, 28 Mar 2026 11:58:17 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427b1ef0sm37793225ad.74.2026.03.28.11.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:58:17 -0700 (PDT)
From: Kangzheng Gu <xiaoguai0992@gmail.com>
To: gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org,
	p@1g4.org,
	xiaoguai0992@gmail.com
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net-shapers: free rollback entries using kfree_rcu
Date: Sat, 28 Mar 2026 18:58:04 +0000
Message-ID: <20260328185804.41325-1-xiaoguai0992@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAKvcANOzRwFk0jm4xBfMGVNJrgGhBT8zvb6r49qc=WdB5zP_fg@mail.gmail.com>
References: <CAKvcANOzRwFk0jm4xBfMGVNJrgGhBT8zvb6r49qc=WdB5zP_fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-230808-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,davemloft.net,google.com,kernel.org,redhat.com,1g4.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84B9F34FB55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net_shaper_rollback() removes NET_SHAPER_NOT_VALID entries and frees
them using kfree(), which can race with net_shaper_nl_get_dumpit() and
lead to a use-after-free in net_shaper_fill_one().

Use kfree_rcu() instead of kfree() to free rollback entries, since
net_shaper_nl_get_dumpit() protects shaper access with rcu_read_lock().

Cc: stable@vger.kernel.org
Fixes: 93954b40f6a4 ("net-shapers: implement NL set and delete operations")
Signed-off-by: Kangzheng Gu <xiaoguai0992@gmail.com>
---
 net/shaper/shaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 94bc9c7382ea..8922f7f64768 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -434,7 +434,7 @@ static void net_shaper_rollback(struct net_shaper_binding *binding)
 	xa_for_each_marked(&hierarchy->shapers, index, cur,
 			   NET_SHAPER_NOT_VALID) {
 		__xa_erase(&hierarchy->shapers, index);
-		kfree(cur);
+		kfree_rcu(cur, rcu);
 	}
 	xa_unlock(&hierarchy->shapers);
 }
-- 
2.50.1


