Return-Path: <stable+bounces-236885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHx1MPkd3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-236885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:46:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C50D93EFC3D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 634B6302FF90
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C8D2D2483;
	Mon, 13 Apr 2026 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MaGIq0sS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488042D5A19;
	Mon, 13 Apr 2026 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098043; cv=none; b=omsMCP8EFL+Gx+4z9OZ5wfOqWiRscq5g+kB1eagMMwrUJk4i+00stKhvpAHooX1rWrq4sVKBKiR6xawTz/F+N76zrRzd3/gLKSbd6cJSpVCKiGvpcFSKVvHtjMQ5HwQ6ICEsBIIvbUJMm3sDRcVr53lcOm4ftwzwd3GK6nXyntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098043; c=relaxed/simple;
	bh=PcuEFqVC5nzhBidBan6+z0Wm0aIt1BK5F0k9FYhQs0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XB9UGQ+WZB4zz7fVZbmB7T9HgI44TGm7v7mDbQGMV9r8tb0t6Q1xILv8Wt3F57gAk0rTFZIW8G5x3/YmfblRUHmBEbTZ2/hCUFxmg6dVj7FoJMLTS9DVhErzCucstp+IKJB0uGuj2Vl1S/kO1kW+95+GkmrtCPvme3HtMo2OTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MaGIq0sS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DBFC2BCAF;
	Mon, 13 Apr 2026 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098043;
	bh=PcuEFqVC5nzhBidBan6+z0Wm0aIt1BK5F0k9FYhQs0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MaGIq0sSVyihiWsGx9n4gbbXSyOiAXsJIrcem0jKhx0rF6Qyr6AcE+FYAFj8Bvpj5
	 qugtHLJ3+TPV2dhe9/ZrXSZ8hiW5ANjQdirA7CbKzAQCv1fthUxdbRwAuOa6p8Ur6g
	 jqLZLZejLqu2B48LIraYWdH724G99z/q2740qRvM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 338/570] netlink: introduce NLA_POLICY_MAX_BE
Date: Mon, 13 Apr 2026 17:57:49 +0200
Message-ID: <20260413155843.155932457@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236885-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,davemloft.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C50D93EFC3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 08724ef69907214ce622344fe4945412e38368f0 ]

netlink allows to specify allowed ranges for integer types.
Unfortunately, nfnetlink passes integers in big endian, so the existing
NLA_POLICY_MAX() cannot be used.

At the moment, nfnetlink users, such as nf_tables, need to resort to
programmatic checking via helpers such as nft_parse_u32_check().

This is both cumbersome and error prone.  This adds NLA_POLICY_MAX_BE
which adds range check support for BE16, BE32 and BE64 integers.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 8f15b5071b45 ("netfilter: ctnetlink: use netlink policy range checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netlink.h |  9 +++++++++
 lib/nlattr.c          | 31 +++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 7a2a9d3144ba6..6eb4593983319 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -325,6 +325,7 @@ struct nla_policy {
 		struct netlink_range_validation_signed *range_signed;
 		struct {
 			s16 min, max;
+			u8 network_byte_order:1;
 		};
 		int (*validate)(const struct nlattr *attr,
 				struct netlink_ext_ack *extack);
@@ -418,6 +419,14 @@ struct nla_policy {
 	.type = NLA_ENSURE_INT_OR_BINARY_TYPE(tp),	\
 	.validation_type = NLA_VALIDATE_MAX,		\
 	.max = _max,					\
+	.network_byte_order = 0,			\
+}
+
+#define NLA_POLICY_MAX_BE(tp, _max) {			\
+	.type = NLA_ENSURE_UINT_TYPE(tp),		\
+	.validation_type = NLA_VALIDATE_MAX,		\
+	.max = _max,					\
+	.network_byte_order = 1,			\
 }
 
 #define NLA_POLICY_MASK(tp, _mask) {			\
diff --git a/lib/nlattr.c b/lib/nlattr.c
index 73635bdb00620..a0c80fbf71895 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -160,6 +160,31 @@ void nla_get_range_unsigned(const struct nla_policy *pt,
 	}
 }
 
+static u64 nla_get_attr_bo(const struct nla_policy *pt,
+			   const struct nlattr *nla)
+{
+	switch (pt->type) {
+	case NLA_U16:
+		if (pt->network_byte_order)
+			return ntohs(nla_get_be16(nla));
+
+		return nla_get_u16(nla);
+	case NLA_U32:
+		if (pt->network_byte_order)
+			return ntohl(nla_get_be32(nla));
+
+		return nla_get_u32(nla);
+	case NLA_U64:
+		if (pt->network_byte_order)
+			return be64_to_cpu(nla_get_be64(nla));
+
+		return nla_get_u64(nla);
+	}
+
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
 static int nla_validate_range_unsigned(const struct nla_policy *pt,
 				       const struct nlattr *nla,
 				       struct netlink_ext_ack *extack,
@@ -173,12 +198,10 @@ static int nla_validate_range_unsigned(const struct nla_policy *pt,
 		value = nla_get_u8(nla);
 		break;
 	case NLA_U16:
-		value = nla_get_u16(nla);
-		break;
 	case NLA_U32:
-		value = nla_get_u32(nla);
-		break;
 	case NLA_U64:
+		value = nla_get_attr_bo(pt, nla);
+		break;
 	case NLA_MSECS:
 		value = nla_get_u64(nla);
 		break;
-- 
2.51.0




