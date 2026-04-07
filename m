Return-Path: <stable+bounces-233522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KPcE1TD1GmWwwcAu9opvQ
	(envelope-from <stable+bounces-233522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:41:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D193AB778
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C1D73005333
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 08:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9D4397E76;
	Tue,  7 Apr 2026 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlGkZPT3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2B2E54B6;
	Tue,  7 Apr 2026 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551310; cv=none; b=ee19sgs5+dNkQrFGZK8OjhzEY/Y2QovkyRrEbgIPR06Bd87yI5ReApUqJPTl1l2ShOtt2NIrnAqWbdxNbcDHmVXCLVSYeuLvi58guCdHc5NByjD54UuBJVJ5xwpa2FYw3c56BdnNHSEVd8nmVdEp5VKaXvRLrZjCfposLfE8ME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551310; c=relaxed/simple;
	bh=OkmnU4nlM29hsuno8u3eVrPXqnKmdcFgOmY3skpbYp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RKOGbeDCKVz20ILMYHBjVVTCKFibd+gpSq4D84MbkFJasy51dyAMjGAH0Q++/B14RU2C4/1LxkquleUrLA6TENTq6liU97lwBwsNn/5+kWSDlAu0AikfCD0OGsFnhfSoK6qbkdZsyJ0QuQnYAb+1+f7MOWQ/2I8AaRqHx4yskI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlGkZPT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E883C116C6;
	Tue,  7 Apr 2026 08:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775551310;
	bh=OkmnU4nlM29hsuno8u3eVrPXqnKmdcFgOmY3skpbYp0=;
	h=From:Date:Subject:To:Cc:From;
	b=RlGkZPT3MOvOTwIDArNY9EsdDfm4DUvjh+g3w2k1ABoYFsVrGfq7nVCHps1c427jO
	 zcvZwstUzO1Xq13CPSG/nqBjhlkDVOcq6mahd3UQXU1ziv+3FbFhZre7mSTi/uj6Bh
	 FvccoVO1gJf9altTaxrkx6wBuiyK2haLYvCuqUD7dU+D1UX6bBmPHi8W5njQmcpATm
	 WkAyinWXkF/hwh3+CJqk6kuF0Ux7Oprnt5yNyxfFjchcMf8dVALUW3SYV8TIIrG7H3
	 s3Yij1JuHKkzSG4S3xJSXHnGhT462CI91wHqi7DhtWMB3VB5qfnVPd/lB4x/rKkDaR
	 lBU6denhPZmLg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 Apr 2026 10:41:41 +0200
Subject: [PATCH net v2] Revert "mptcp: add needs_id for netlink appending
 addr"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-net-mptcp-revert-pm-needs-id-v2-1-7a25cbc324f8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMBAEf6XcswdpkIr+ivhg0o2e0BhyqQil/
 +7VPs6wOwspqkDp0i1U8RGVdzbwh47i854fYBmNyTs/uKMbOKPxVFosbHPUxmUyh1FtyKmPIZy
 c79MZZIlSkeT7z1/JnnTbpc7hhdi2MK3rD0DTB7iFAAAA
X-Change-ID: 20260406-net-mptcp-revert-pm-needs-id-f1cbb7021f9e
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3890; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OkmnU4nlM29hsuno8u3eVrPXqnKmdcFgOmY3skpbYp0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKvHPZ2eaH2Z06zMZ/qMRf2BRtYU1n+cD0ISnTTMz+lW
 cYQXarXUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBGLMIbfbPHlbkVzPER3MzxZ
 Lia2PDHy99XlUWoW4l67M1pzrmRWM/xmd76mwfw6d3f3p5XT5Vn4HAKFHrvKOPRtfXJ2ww8D7QW
 cAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233522-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 57D193AB778
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This commit was originally adding the ability to add MPTCP endpoints
with ID 0 by accident. The in-kernel PM, handling MPTCP endpoints at the
net namespace level, is not supposed to handle endpoints with such ID,
because this ID 0 is reserved to the initial subflow, as mentioned in
the MPTCPv1 protocol [1], a per-connection setting.

Note that 'ip mptcp endpoint add id 0' stops early with an error, but
other tools might still request the in-kernel PM to create MPTCP
endpoints with this restricted ID 0.

In other words, it was wrong to call the mptcp_pm_has_addr_attr_id
helper to check whether the address ID attribute is set: if it was set
to 0, a new MPTCP endpoint would be created with ID 0, which is not
expected, and might cause various issues later.

Fixes: 584f38942626 ("mptcp: add needs_id for netlink appending addr")
Cc: stable@vger.kernel.org
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.2-9 [1]
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 - The v1 has been sent to net-next with a different commit message:
   https://lore.kernel.org/20260403-net-next-mptcp-msg_eor-misc-v1-4-b0b33bea3fed@kernel.org
---
 net/mptcp/pm_kernel.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 82e59f9c6dd9..0ebf43be9939 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -720,7 +720,7 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry,
-					     bool needs_id, bool replace)
+					     bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	int ret = -EINVAL;
@@ -779,7 +779,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id && needs_id) {
+	if (!entry->addr.id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -790,7 +790,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id && needs_id)
+	if (!entry->addr.id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -923,7 +923,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 		return -ENOMEM;
 
 	entry->addr.port = 0;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -977,18 +977,6 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
 	return 0;
 }
 
-static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
-				      struct genl_info *info)
-{
-	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
-
-	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
-					 mptcp_pm_address_nl_policy, info->extack) &&
-	    tb[MPTCP_PM_ADDR_ATTR_ID])
-		return true;
-	return false;
-}
-
 /* Add an MPTCP endpoint */
 int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
@@ -1037,9 +1025,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_free;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
-						!mptcp_pm_has_addr_attr_id(attr, info),
-						true);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;

---
base-commit: a9d4f4f6e65e0bf9bbddedecc84d67249991979c
change-id: 20260406-net-mptcp-revert-pm-needs-id-f1cbb7021f9e

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


