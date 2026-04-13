Return-Path: <stable+bounces-236855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCcDNJUi3WkYaQkAu9opvQ
	(envelope-from <stable+bounces-236855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:06:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F173F0BF7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 983DF308E41A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBCD2874F8;
	Mon, 13 Apr 2026 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XU1TKWeX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E023D297;
	Mon, 13 Apr 2026 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097966; cv=none; b=GdszkeE9R7c0/72/LRngHunnGa81ZHo3HB0lOPktbZZWFUh7MzFF+eaJzXyqHwxfR3sM35nCkLa43A18cKhAzIpZgFnTIq9c2cvbcyfq/HZwEEmiUOkKkykPTxuFfKTYGR+lRRiJOxx6UzDvnP+JOwFZP3zBsliiINfa98kW46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097966; c=relaxed/simple;
	bh=hsOBzBSMokj/NbwruWvGi7TXsIoaPOrNo0TNdG5NUhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKBXKEb4W/KZ6H54ditTmmxZCMd3Xk6VxPShW4qBC4M2Qd2r3UhLf0lmbbDE3+i/t6p9loSXF38dUen22v6Ao0XqAvZaeAAoyX3WVTC4uC878fEg9K36Dwft74ztWwwXI6hBeV3u0XRO5/NF4ADUH+xS1XohHwHzmfmm5/I8CdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XU1TKWeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999DBC2BCAF;
	Mon, 13 Apr 2026 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097965;
	bh=hsOBzBSMokj/NbwruWvGi7TXsIoaPOrNo0TNdG5NUhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XU1TKWeXMWRgGjBU29gY1EO6vDWjD7EtzG87EL8n1LZyowJeDz7LBZwOdXSYQwQXM
	 tk9BCl7oZB7dQeafbqlye0ThMotw1iXzlRMRCe8SWDVy6FzsylCLIGkkQV3TqIsuiI
	 7RgRihw4/CbwUIXMUbZc84j17muvTGtazwyJz0TU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 342/570] netlink: allow be16 and be32 types in all uint policy checks
Date: Mon, 13 Apr 2026 17:57:53 +0200
Message-ID: <20260413155843.303072092@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236855-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,strlen.de:email]
X-Rspamd-Queue-Id: 26F173F0BF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 5fac9b7c16c50c6c7699517f582b56e3743f453a ]

__NLA_IS_BEINT_TYPE(tp) isn't useful.  NLA_BE16/32 are identical to
NLA_U16/32, the only difference is that it tells the netlink validation
functions that byteorder conversion might be needed before comparing
the value to the policy min/max ones.

After this change all policy macros that can be used with UINT types,
such as NLA_POLICY_MASK() can also be used with NLA_BE16/32.

This will be used to validate nf_tables flag attributes which
are in bigendian byte order.

Signed-off-by: Florian Westphal <fw@strlen.de>
Stable-dep-of: 8f15b5071b45 ("netfilter: ctnetlink: use netlink policy range checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netlink.h | 10 +++-------
 lib/nlattr.c          |  6 ++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 356b805f50151..8536301842c97 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -374,12 +374,11 @@ struct nla_policy {
 #define NLA_POLICY_BITFIELD32(valid) \
 	{ .type = NLA_BITFIELD32, .bitfield32_valid = valid }
 
-#define __NLA_IS_UINT_TYPE(tp)						\
-	(tp == NLA_U8 || tp == NLA_U16 || tp == NLA_U32 || tp == NLA_U64)
+#define __NLA_IS_UINT_TYPE(tp)					\
+	(tp == NLA_U8 || tp == NLA_U16 || tp == NLA_U32 ||	\
+	 tp == NLA_U64 || tp == NLA_BE16 || tp == NLA_BE32)
 #define __NLA_IS_SINT_TYPE(tp)						\
 	(tp == NLA_S8 || tp == NLA_S16 || tp == NLA_S32 || tp == NLA_S64)
-#define __NLA_IS_BEINT_TYPE(tp)						\
-	(tp == NLA_BE16 || tp == NLA_BE32)
 
 #define __NLA_ENSURE(condition) BUILD_BUG_ON_ZERO(!(condition))
 #define NLA_ENSURE_UINT_TYPE(tp)			\
@@ -393,7 +392,6 @@ struct nla_policy {
 #define NLA_ENSURE_INT_OR_BINARY_TYPE(tp)		\
 	(__NLA_ENSURE(__NLA_IS_UINT_TYPE(tp) ||		\
 		      __NLA_IS_SINT_TYPE(tp) ||		\
-		      __NLA_IS_BEINT_TYPE(tp) ||	\
 		      tp == NLA_MSECS ||		\
 		      tp == NLA_BINARY) + tp)
 #define NLA_ENSURE_NO_VALIDATION_PTR(tp)		\
@@ -401,8 +399,6 @@ struct nla_policy {
 		      tp != NLA_REJECT &&		\
 		      tp != NLA_NESTED &&		\
 		      tp != NLA_NESTED_ARRAY) + tp)
-#define NLA_ENSURE_BEINT_TYPE(tp)			\
-	(__NLA_ENSURE(__NLA_IS_BEINT_TYPE(tp)) + tp)
 
 #define NLA_POLICY_RANGE(tp, _min, _max) {		\
 	.type = NLA_ENSURE_INT_OR_BINARY_TYPE(tp),	\
diff --git a/lib/nlattr.c b/lib/nlattr.c
index dffd60e4065fd..a98e7191adaf6 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -355,6 +355,12 @@ static int nla_validate_mask(const struct nla_policy *pt,
 	case NLA_U64:
 		value = nla_get_u64(nla);
 		break;
+	case NLA_BE16:
+		value = ntohs(nla_get_be16(nla));
+		break;
+	case NLA_BE32:
+		value = ntohl(nla_get_be32(nla));
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.51.0




