Return-Path: <stable+bounces-235092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNRyBx2q1mlKHAgAu9opvQ
	(envelope-from <stable+bounces-235092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:18:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D17E3C2BE7
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E19531B2B3B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4621A3A16A0;
	Wed,  8 Apr 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fVIoh7r4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7D28980F;
	Wed,  8 Apr 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674549; cv=none; b=NBm+fDLfH7HosTWbDz04+hIj91h/jB4560b2ykcWhFPWl9DsXaXd/rcUNWXX8T0tyk7Yz3f49UkA0nkGCY9ARedq2nVnjZGdZA0jf9T7h/GxgEvI9ceuYOd9t8+lq7YMCkfvp9uNdzwF/Ro+TKOHTu/L/hP5OdCCAuCQ+UBMHxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674549; c=relaxed/simple;
	bh=BJr7aUt3K60T7viFyr0qOGQtn2ilmnpfAmu2kSBRe8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uldZ9qbFDq5jZUzmmH6NwYE/Upp/rxx+lAVM1uYi4/DeyuM2OPh632dmr2L5QYl0xLymDlad9wiKs5ZEKYnex2a0P78OxCag48rMHucQ7j9BHvseT+tADlRfopnmRK6gpZChhRGMmo198MD4rFFelUwk4HoX5XFjeV98OkxxhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fVIoh7r4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96186C19421;
	Wed,  8 Apr 2026 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674548;
	bh=BJr7aUt3K60T7viFyr0qOGQtn2ilmnpfAmu2kSBRe8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fVIoh7r4jWpMjScFZHXNZKtMKbs+ayV6z6WvKjVzoe4vSShQLZRQZ7W2I1dLEybyw
	 8n0n5O3PFSIac5mMx/z3PNqxeHIeP+zsSBfnNUnGDhj+xptbnGcHhSNboETztHiM0M
	 GoHdpRmGQjqUEj8VP+iAk5wglOl1tPsDQm7ABwxQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <tanyuan98@outlook.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yuhang Zheng <z1652074432@gmail.com>,
	Yucheng Lu <kanolyc@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 108/311] net/sched: sch_netem: fix out-of-bounds access in packet corruption
Date: Wed,  8 Apr 2026 20:01:48 +0200
Message-ID: <20260408175943.446266667@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235092-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,lzu.edu.cn,networkplumber.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 9D17E3C2BE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yucheng Lu <kanolyc@gmail.com>

[ Upstream commit d64cb81dcbd54927515a7f65e5e24affdc73c14b ]

In netem_enqueue(), the packet corruption logic uses
get_random_u32_below(skb_headlen(skb)) to select an index for
modifying skb->data. When an AF_PACKET TX_RING sends fully non-linear
packets over an IPIP tunnel, skb_headlen(skb) evaluates to 0.

Passing 0 to get_random_u32_below() takes the variable-ceil slow path
which returns an unconstrained 32-bit random integer. Using this
unconstrained value as an offset into skb->data results in an
out-of-bounds memory access.

Fix this by verifying skb_headlen(skb) is non-zero before attempting
to corrupt the linear data area. Fully non-linear packets will silently
bypass the corruption logic.

Fixes: c865e5d99e25 ("[PKT_SCHED] netem: packet corruption option")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
Signed-off-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
Signed-off-by: Yucheng Lu <kanolyc@gmail.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Link: https://patch.msgid.link/45435c0935df877853a81e6d06205ac738ec65fa.1774941614.git.kanolyc@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_netem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 32a5f33040461..3356d62ad0548 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -519,8 +519,9 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			goto finish_segs;
 		}
 
-		skb->data[get_random_u32_below(skb_headlen(skb))] ^=
-			1<<get_random_u32_below(8);
+		if (skb_headlen(skb))
+			skb->data[get_random_u32_below(skb_headlen(skb))] ^=
+				1 << get_random_u32_below(8);
 	}
 
 	if (unlikely(q->t_len >= sch->limit)) {
-- 
2.53.0




