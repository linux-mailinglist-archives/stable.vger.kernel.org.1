Return-Path: <stable+bounces-237348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN9RMG0i3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-237348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:05:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 913C23F0B52
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CC913097404
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC6F31714F;
	Mon, 13 Apr 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bSHEOHYE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D1A313298;
	Mon, 13 Apr 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099222; cv=none; b=hZeoRnVGcif0gy2dTCRSsQLQPz8dP9+BVZmXq1fLywtnuuLBa2C5QDZcw31m7zLmurd2nuBUFvRUrbWm25vFHGfiRJdS7uy8H7pph0oGlbE6Zj6TyE4XxjXbpjfgbvV5fQDvueA5A6xoL6v5giMCUmB9+VfwVbUcG9Omx3HKPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099222; c=relaxed/simple;
	bh=dbU+xGdv+TUsdE+g5YDefCa4XdCApJ/MCWw7CgH9+ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQZ0HnJaP3LB+vmcPbR7dr1LvNK6Tjj0YAy+DGaqj5hHcLsOrEPsXLSgTReIyqMGmikfTWS3lQsYxliDTHEGpO4JyFFrHj1LUhD2LLanNhiNvJLnw6yxflVCST/85fR0hzIkbZWUfHZPZRd668uuM6p5aZv0sZr7F1cQBWiHCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bSHEOHYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FDCC2BCB0;
	Mon, 13 Apr 2026 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099222;
	bh=dbU+xGdv+TUsdE+g5YDefCa4XdCApJ/MCWw7CgH9+ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSHEOHYE4NG1k57hj89i+2npRjXIHh3SDYQWBSLTDqnBWPgOQBq3RdLJrp1NsX4bN
	 w6Et1Eyn8z3N0LlSs3ZhapAZSc0l28d7wujidkzAr1HNspZ3HsfQvh5xSj5ehcT2Il
	 unHJt2VeCqLPkyAOb+ZTz+lrIsjowO2p7q7Fn3zo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Ao Zhou <n05ec@lzu.edu.cn>,
	Yuan Tan <tanyuan98@outlook.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 258/491] openvswitch: validate MPLS set/set_masked payload length
Date: Mon, 13 Apr 2026 17:58:23 +0200
Message-ID: <20260413155828.711636005@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,outlook.com,ovn.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-237348-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,outlook.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ovn.org:email]
X-Rspamd-Queue-Id: 913C23F0B52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Yang <n05ec@lzu.edu.cn>

[ Upstream commit 546b68ac893595877ffbd7751e5c55fd1c43ede6 ]

validate_set() accepted OVS_KEY_ATTR_MPLS as variable-sized payload for
SET/SET_MASKED actions. In action handling, OVS expects fixed-size
MPLS key data (struct ovs_key_mpls).

Use the already normalized key_len (masked case included) and reject
non-matching MPLS action key sizes.

Reject invalid MPLS action payload lengths early.

Fixes: fbdcdd78da7c ("Change in Openvswitch to support MPLS label depth of 3 in ingress direction")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Link: https://patch.msgid.link/20260319080228.3423307-1-n05ec@lzu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/flow_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 54f952620b214..2185fd5596fc7 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2911,6 +2911,8 @@ static int validate_set(const struct nlattr *a,
 	case OVS_KEY_ATTR_MPLS:
 		if (!eth_p_mpls(eth_type))
 			return -EINVAL;
+		if (key_len != sizeof(struct ovs_key_mpls))
+			return -EINVAL;
 		break;
 
 	case OVS_KEY_ATTR_SCTP:
-- 
2.51.0




