Return-Path: <stable+bounces-255757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKNZFcenGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:38:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D88735F92F8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09C063215764
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFB12E7377;
	Thu, 28 May 2026 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cXtTZfiL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20F02D9787;
	Thu, 28 May 2026 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999798; cv=none; b=QZhj0/xVRRDAnv9FA84T9NcBQguOkJi+x7IR5Oi18D5DNgjUKV2ZaLU8gNGgkrayE0V+RhJnMT5dHrGK3LQqDO5qZHuk99qsED8Mq9BWmL3njy1nm7mrotWoCgbamz9T2Xg5mfVc0sY31wS5AxJ/51SIQas1C9Gsah2uGrkv8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999798; c=relaxed/simple;
	bh=W6oGyOVN4E/V6qpITfsNPQqnTFKC6X0DEAIZ2CsQC3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgGsjY8o03TuSEpa5u12dblwiVv0YeSsPWkM7Fv7JIkFzbd5XGRfk4AwntbPTzH1wm8QqD47M3C2ygAC37nUKwXsK0wj4KINZ3nanGY98fs33rTTp+LZ9rAoXevJN5E9+GDhABn+1G2TNWzfC3Hzwu6amV0vOszvgdC6frx151M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cXtTZfiL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E571F000E9;
	Thu, 28 May 2026 20:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999797;
	bh=qhcn4KScvhDIDyZEFt/HVWwYDdnHHdJc1HgwEhWA1Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cXtTZfiLkvrEUkhZMvT6mAlMcROqSU9oUAZzsXsSokZ9WB3XvIbVInDn/Xy72POrR
	 0Tx3isATU6EnRVOdLbOhuPsqosZuqkA78O8bZSo4YHlpVYdMARHGsheegxA7Vo98xW
	 9zf8pmizf9KkChkJhfR63+L4UK0zHUEPzNZ5mSLo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18 159/377] batman-adv: tt: fix negative tt_buff_len
Date: Thu, 28 May 2026 21:46:37 +0200
Message-ID: <20260528194643.005995600@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255757-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D88735F92F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit b64963a2ceeb7529310b6cf253a1e540784422f4 upstream.

batadv_orig_node::tt_buff_len was declared as s16, but the field is never
intended to hold a negative value. When a value greater than 32767 is
assigned, it wraps to a negative signed integer.

In batadv_send_other_tt_response(), tt_buff_len is temporarily widened to
s32. The incorrectly negative s16 value propagates into the s32, causing
batadv_tt_prepare_tvlv_global_data() to allocate a full sized buffer but
populates only a small portion of it with the collected changeset. All
remaining bits are kept uninitialized.

Using an u16 avoids this type confusion and ensures that no (negative) sign
extension is performed in batadv_send_other_tt_response().

Cc: stable@kernel.org
Fixes: a73105b8d4c7 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/types.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -455,7 +455,7 @@ struct batadv_orig_node {
 	 * @tt_buff_len: length of the last tt changeset this node received
 	 *  from the orig node
 	 */
-	s16 tt_buff_len;
+	u16 tt_buff_len;
 
 	/** @tt_buff_lock: lock that protects tt_buff and tt_buff_len */
 	spinlock_t tt_buff_lock;



