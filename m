Return-Path: <stable+bounces-237364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB5FJvQj3WkzaQkAu9opvQ
	(envelope-from <stable+bounces-237364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:12:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C97C3F0FA2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1005C309D5F3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B531619A;
	Mon, 13 Apr 2026 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hnhDjcOA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C39E31717C;
	Mon, 13 Apr 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099264; cv=none; b=UL+C6aMVuEWQRZtQEoDeBTki/U9HUOfsqaGWV7Om0BNEZfypoej5myTPWIvBjQWzIYjydBXF9lJRzVHbrYDmLqK0XGNCwdMRfH2+rRk2TxnrA9Fw31hz24Mf4aaRv/ze6mp+GsmFh/TP57R+o1iTbvSDA8+rcNvVJlqxjNLIc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099264; c=relaxed/simple;
	bh=Mwhn/X44jHCGjDpE2hFbs8DovvZZd3L3L0E9eHKFMrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U76a1b4ouJRVZpCZw0rP2JwAjLe15m8fKhDvak3dz4FolOglZJYozanVBhwvVlOIHPoxEYDN3cESivjtvrMtYNVKYnBlYkQecGBnX1bMDX1dnWcC+4U+5E360EUlSM5XKeDfssLZIAY5pomXAxNwOKE1DBTvuiI1pJFWnDS2v78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hnhDjcOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691ACC2BCAF;
	Mon, 13 Apr 2026 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099263;
	bh=Mwhn/X44jHCGjDpE2hFbs8DovvZZd3L3L0E9eHKFMrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hnhDjcOAxjZt6SlSjsKODXkku4IukVuwsqr/BBdCWpRLaBlO99W2Unp7rNlPtSw65
	 75CAo/PwJmOc0e+xmdmu2eSpCLQ8NzM9A/pFLpTUKduahn4onQ+VT4W+eTU1NPhwdP
	 v/8kheabCG3AEzcTSSKskw7uBSv9ox8zXyloXKWI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 273/491] netlink: hide validation union fields from kdoc
Date: Mon, 13 Apr 2026 17:58:38 +0200
Message-ID: <20260413155829.269147659@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-237364-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C97C3F0FA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 7354c9024f2835f6122ed9612e21ab379df050f9 ]

Mark the validation fields as private, users shouldn't set
them directly and they are too complicated to explain in
a more succinct way (there's already a long explanation
in the comment above).

The strict_start_type field is set directly and has a dedicated
comment so move that above the "private" section.

Link: https://lore.kernel.org/r/20221027212107.2639255-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8f15b5071b45 ("netfilter: ctnetlink: use netlink policy range checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netlink.h | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 45370f84d6442..9d5d6aa690c56 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -317,19 +317,10 @@ struct nla_policy {
 	u8		validation_type;
 	u16		len;
 	union {
-		const u32 bitfield32_valid;
-		const u32 mask;
-		const char *reject_message;
-		const struct nla_policy *nested_policy;
-		struct netlink_range_validation *range;
-		struct netlink_range_validation_signed *range_signed;
-		struct {
-			s16 min, max;
-			u8 network_byte_order:1;
-		};
-		int (*validate)(const struct nlattr *attr,
-				struct netlink_ext_ack *extack);
-		/* This entry is special, and used for the attribute at index 0
+		/**
+		 * @strict_start_type: first attribute to validate strictly
+		 *
+		 * This entry is special, and used for the attribute at index 0
 		 * only, and specifies special data about the policy, namely it
 		 * specifies the "boundary type" where strict length validation
 		 * starts for any attribute types >= this value, also, strict
@@ -348,6 +339,20 @@ struct nla_policy {
 		 * was added to enforce strict validation from thereon.
 		 */
 		u16 strict_start_type;
+
+		/* private: use NLA_POLICY_*() to set */
+		const u32 bitfield32_valid;
+		const u32 mask;
+		const char *reject_message;
+		const struct nla_policy *nested_policy;
+		struct netlink_range_validation *range;
+		struct netlink_range_validation_signed *range_signed;
+		struct {
+			s16 min, max;
+			u8 network_byte_order:1;
+		};
+		int (*validate)(const struct nlattr *attr,
+				struct netlink_ext_ack *extack);
 	};
 };
 
-- 
2.51.0




