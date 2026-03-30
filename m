Return-Path: <stable+bounces-231275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLrmBcTiymloBAYAu9opvQ
	(envelope-from <stable+bounces-231275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:53:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181C3612D7
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 773713025C73
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 20:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAF3392814;
	Mon, 30 Mar 2026 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carlini.com header.i=@carlini.com header.b="UzZtFK7O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0o8EcK6n"
X-Original-To: stable@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E52175A87;
	Mon, 30 Mar 2026 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903998; cv=none; b=VvNyUNEW1lmab8Rk9DJVBNUTg4WtO19Bw50Y7/f25Ygp+qUgrHWKB/AVA35aRknj9S6sXyQ5yUjCRm6oUE9fyE+me5SBp3bIQ0rl5j3l8FGq6bP7TvZD5d3RMXyIAWYcGU/gBHK7zVl8F/dVDshxLvo23GvSqVb1pq9X4YJx/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903998; c=relaxed/simple;
	bh=NiQzYiiOwoLAZ5Iou/C0dGHA77SrL6i6KPllycb/NaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5xnq2swV/yEgVyHBiaNMaF1rS5NsCEgujhFkhdcLCP57jO/Cit6oahz5oBjW5Wj07Xffmx5uf+JsNaw2hRxoqYrENdGxkJnP0ySe99PxThhQAfTrgvgMile8GbKYKkRZLTy0/3xdmBQ9WLNxebBDF7PbPWmpB3aHSmGKHAtsQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=carlini.com; spf=pass smtp.mailfrom=carlini.com; dkim=pass (2048-bit key) header.d=carlini.com header.i=@carlini.com header.b=UzZtFK7O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0o8EcK6n; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=carlini.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carlini.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D777B1D001DB;
	Mon, 30 Mar 2026 16:53:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 30 Mar 2026 16:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=carlini.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1774903995; x=1774990395; bh=rz45OiZKHq5Ef9NoifujP
	Q8DROk1KvK7PVQnNG2NtgQ=; b=UzZtFK7OxEVqfCV+UOk+8GnFFjXG6ekoXXwKM
	FNF5aN3HQMu7mVVyyVV6yl3twsHcAS8cfUnvM7NyCTl5LuOZQ2A9D79FjTWriNLG
	GGr6IOBb8IQn7yHL/BDNz14i6yOaV/HK9vUSVJc86I2MAmLh1Q2bOY7HsGh2vApx
	UN/lax/dtcPPHiPXygqI23sZvsV2nZ/QJ2GKnZMHgtcCF+VNsm+Gm/THSrLSLKs8
	dhZDoeb6avTkD9v2Be3mHlUHai9fovkc1p9VFClZ04jQW4axvURCQJPUTlRHkj6e
	Ak7k37rsbpu4/OhXKB9z3uHEo+DT+IFKh/DQDbcV0HPSbLsSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774903995; x=1774990395; bh=rz45OiZKHq5Ef9NoifujPQ8DROk1KvK7PVQ
	nNG2NtgQ=; b=0o8EcK6nqstR5qKjafAfq+6wctrHIo8iKT84M+Hzjrc3fS2Bzur
	SpO4vOibkR8C4IkMePMB94w/o1pLMuOQHa6jbGoP2mfDogWGOWciKSB4C+innC7S
	Rha20Qu9W6amXpHltXW8VOB+cr7KxMXjs3H6HryZ8a1WGUZLqKcfBqWCSP2D5eCt
	z66dduiE0ZMWEerg7N3sU/KU6LjcdLIl8UdsA7+ZF2b2D9vLQVk82zhYO2by4iyC
	MyRYEKBAL5dCbTVmW+ojZYSZCSba8LxRkqJUGE8rVdxXim9V4b71qMQMF8lmjoeb
	MTnc/6Od3m+1Lp+nvW+LCg/B5jlh0FiWFYQ==
X-ME-Sender: <xms:u-LKaXPDyD27S_4EyPFQ5PlIt7PR54j3jWfShNyHp9j6QSRx-W5Png>
    <xme:u-LKafyXOG9D6WG6qLzxYp6AqXSgBFxIE5BkjVggLXY12iDQdB2mG-VXiUfGbqrRa
    4PkgtzmDC9on6uUrV9BoU7IRKCR-M409B19tLMyFAiYLEWeLRje8k8>
X-ME-Received: <xmr:u-LKaQtUNoUW0c17CG2WSePC6SJ3i006aAZq6vQfjWDYzWCoQsL8shUgT_NwwmQaQqt5OsQh3cAcyFW3yzMIMzuojnspsTgPqz8eiOH131DvAiJCcBFZ00-7Ys3bTBtc5XR50TlDC-C0h_gUm5bs0atpC_2LbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepnhhitghhohhlrghs
    segtrghrlhhinhhirdgtohhmnecuggftrfgrthhtvghrnhepjeelfeeuieduheehheefje
    ffvdetvdefuedttedvheefteffvdefveelheffgfejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghhohhlrghssegtrghrlhhinhhird
    gtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjmhgrlh
    hohiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhhitghhohhlrghssegtrghrlhhi
    nhhirdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:u-LKaY74XdrbS2-fS_fVQKxOgCjWXJ9LymLimPeg_wcnBQlTFBayGg>
    <xmx:u-LKafR7JTaeF6y7nILsKW6kF66q4UafUhzh0zdyT3krchgBcod51g>
    <xmx:u-LKaXrlb7Poda7hNbVlOEEaYCUr-0yGMqWolieP-sTuMlGtCGyfww>
    <xmx:u-LKadLjWuqiQ5QQbFh4ES7A2w5ZFvbzeSSLAAvdmUHz-UfSut0rxw>
    <xmx:u-LKaQNrlxGYouVc8ZMOTBLTQmQGZL3cIB0D1KwLMduBJwMkarm9n1fW>
Feedback-ID: i78b949e2:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 16:53:14 -0400 (EDT)
From: nicholas@carlini.com
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	Nicholas Carlini <nicholas@carlini.com>,
	stable@vger.kernel.org
Subject: [PATCH net] tipc: fix UAF in tipc_buf_append via tipc_msg_validate
Date: Mon, 30 Mar 2026 20:53:13 +0000
Message-ID: <20260330205313.2433372-1-nicholas@carlini.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[carlini.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[carlini.com:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231275-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[carlini.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicholas@carlini.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,carlini.com:dkim,carlini.com:email,carlini.com:mid]
X-Rspamd-Queue-Id: 8181C3612D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nicholas Carlini <nicholas@carlini.com>

tipc_buf_append() passes the address of a local variable `head` to
tipc_msg_validate(). When the flow-control ratio check in
tipc_msg_validate() fires, it frees the original skb and updates
*_skb to point to a new copy -- but this only updates the local
`head`, not *headbuf. If validation subsequently fails (e.g. the
reassembled message has an invalid TIPC version), the err path
calls kfree_skb(*headbuf) on the already-freed skb. The replacement
skb is also leaked.

A remote attacker with an established TIPC link over a UDP bearer
can trigger this by sending a sequence of MSG_FRAGMENTER packets
crafted to inflate the reassembled skb's truesize relative to its
length past the ratio threshold, with an invalid version field in
the inner message.

Fix by passing headbuf directly to tipc_msg_validate() so the
pointer update propagates correctly.

Fixes: d618d09a68e4 ("tipc: enforce valid ratio between skb truesize and contents")
Cc: stable@vger.kernel.org
Signed-off-by: Nicholas Carlini <nicholas@carlini.com>
---
 net/tipc/msg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 76284fc53..9f4f612ee 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -177,8 +177,9 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
 
 	if (fragid == LAST_FRAGMENT) {
 		TIPC_SKB_CB(head)->validated = 0;
-		if (unlikely(!tipc_msg_validate(&head)))
+		if (unlikely(!tipc_msg_validate(headbuf)))
 			goto err;
+		head = *headbuf;
 		*buf = head;
 		TIPC_SKB_CB(head)->tail = NULL;
 		*headbuf = NULL;
-- 
2.43.0


