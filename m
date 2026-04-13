Return-Path: <stable+bounces-237667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO+yD0Vq3Wn5dwkAu9opvQ
	(envelope-from <stable+bounces-237667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:12:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7D13F3BAA
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE85B3028010
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DBE39B48D;
	Mon, 13 Apr 2026 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oxe2D+39"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53723EAAD
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118338; cv=none; b=haKFXPM7GtXO09hchff81UTqd6jPleggDV3vB1TXDki/9TKlT+ds7a4Vu7mCfnma1H6p8eUfkgAPSqjq3UedHOCE1Txj3b6DRzg5v2jMqKQacXCXXX5AbZ5QtFclnTPLJ0u8nSba9kM6SsXACPF6FGlHEBYg9bRHKCx/Xrfo/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118338; c=relaxed/simple;
	bh=i83J6RHjScHiuGpWIBrdFTYkPLZJfWNhwvkmhebaYbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVV4b0pJRU4RpTEQKSKzRySX1umJbasnrES6bR8+oj5GVzQ/XPrXqdtdA9vQs6aTHPWQkgVxJZRz17MP8+a8fVWigX6y/DGwgMUqRNQM0cU7V0fAEe1anR6kEstDeQSdfAI0ghVBMr8XSkrBIlc1Bpzyc8aESrUL7F6cciAlX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oxe2D+39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F55C2BCAF;
	Mon, 13 Apr 2026 22:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776118338;
	bh=i83J6RHjScHiuGpWIBrdFTYkPLZJfWNhwvkmhebaYbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oxe2D+39jzwdnBFWS7a7Q6EDgmQ23l+slpXVI0VvJ4sbKUvidLpTLIMjKulWOH990
	 aypZKW7e+MXGn7jn5AZO0xxZRtD3oxGgAWWPfIKHm/1wLoLzeAxvwaNoQLWclar1VI
	 /IL2RPfj5sA9CBOgTrouDba+/RPoIQei9ed6cokgh2jg3CbG5bBmk8U7bVzLvMps3B
	 PjMk/zLMKQ29ZAmKxZE5OAPeRLDZBLwIoKoOtPGGgxoxUNXUAXHHLcFdYqThI6yzym
	 9FNMcfwar5hpe4nsfnpNCuHvyNp5F8ekZeNv0Ci0/M4DPv9KJKkwrC/cUuM8SeajkS
	 WyHR5PGw6ewAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yasuaki Torimaru <yasuakitorimaru@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfrm: clear trailing padding in build_polexpire()
Date: Mon, 13 Apr 2026 18:12:15 -0400
Message-ID: <20260413221215.3744762-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041332-delivery-deplete-1461@gregkh>
References: <2026041332-delivery-deplete-1461@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,debian.org,secunet.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237667-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:email]
X-Rspamd-Queue-Id: 8D7D13F3BAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>

[ Upstream commit 71a98248c63c535eaa4d4c22f099b68d902006d0 ]

build_expire() clears the trailing padding bytes of struct
xfrm_user_expire after setting the hard field via memset_after(),
but the analogous function build_polexpire() does not do this for
struct xfrm_user_polexpire.

The padding bytes after the __u8 hard field are left
uninitialized from the heap allocation, and are then sent to
userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
leaking kernel heap memory contents.

Add the missing memset_after() call, matching build_expire().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[ replaced `memset_after()` macro with equivalent manual `memset()` call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 480da22b7ef85..03ebea3485234 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3290,6 +3290,8 @@ static int build_polexpire(struct sk_buff *skb, struct xfrm_policy *xp,
 		return err;
 	}
 	upe->hard = !!hard;
+	/* clear the padding bytes */
+	memset(&upe->hard + 1, 0, sizeof(*upe) - offsetofend(typeof(*upe), hard));
 
 	nlmsg_end(skb, nlh);
 	return 0;
-- 
2.53.0


