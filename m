Return-Path: <stable+bounces-236853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHFBOI8i3WkYaQkAu9opvQ
	(envelope-from <stable+bounces-236853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:06:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 821BD3F0BDB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B858308C51D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4687523D297;
	Mon, 13 Apr 2026 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VSVs9o7P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8E27BF6C;
	Mon, 13 Apr 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097961; cv=none; b=bevvJD6i00yNN1NONnH/SJgrmf4N3RGLiF9Wo+1MmtGi8QqQPYLJQP6AmgafbvseorQrf7Z1spqJoEtbSlCoAuPe6mUSY6Wk4iN4IRx8JTBKnDbOKmZMCRpbBOZ7QNhheOVt36mGhS5aHfG9Id880zqX2avQAA7qvvCMiiWOinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097961; c=relaxed/simple;
	bh=wkngRYyQtuIo2Dtt4dpU3n01bXi6SPSE7Y18dNJ5t28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQdIZrUI/q0aIFJ+9NXtvV5r5nhGBUE5BMk029wVaSNot6sPeBNQxy89TekcWaUHbJhIgil/chRzwHF+Iw7J6JvieSbwKaFdMbkdPYMATuu8Ehxa1QpRyGydDl0CHjoYjxsDBg5P1grteUiOVgtFUT5YNYyEu/ZUsfkCNvPAve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VSVs9o7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79674C2BCAF;
	Mon, 13 Apr 2026 16:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097960;
	bh=wkngRYyQtuIo2Dtt4dpU3n01bXi6SPSE7Y18dNJ5t28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSVs9o7PvFAMBHccd8klVb3cFt4eFyMjsJW0DVwtwmNjO0jVA3rKjeZffDJxe7fdh
	 Sz2dTGqiXWtPwutovzGXjWfA8PKIlM5a4KUxAuL/xuETEYqUTwlFudLXTdcEjE03ju
	 6E1h/Ag9hVwgFWOQo5U4Dmr6I77Z98qWPmiSidHw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 340/570] netlink: hide validation union fields from kdoc
Date: Mon, 13 Apr 2026 17:57:51 +0200
Message-ID: <20260413155843.228800284@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-236853-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 821BD3F0BDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 6eb4593983319..8c67db47556e2 100644
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




