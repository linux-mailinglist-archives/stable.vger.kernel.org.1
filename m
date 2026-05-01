Return-Path: <stable+bounces-242502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP8KObwA9WmZHAIAu9opvQ
	(envelope-from <stable+bounces-242502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:36:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4DB4AF2F5
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 572563005AAE
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE05421EE1;
	Fri,  1 May 2026 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDcA172B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAD421A0C;
	Fri,  1 May 2026 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664177; cv=none; b=hifro4sUK/m+ZyYVwhAMXjLYhsu6Jq9xmT4KjPBbYmX6617KSBn9sy/nakTQbSKc/QHkbE1TYsvFwkOfUFW8pkqbH9PKAopxvh+cIhv5jvrGT+pWVOxf811tFotXepvs3Mc30gC0LqJulY2MGLD2UiC1YhC/1h8rjtJe3s9Gykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664177; c=relaxed/simple;
	bh=iN/5ZWsd+G/llWYnMKfz9xNhUpeX3w53Wzqf1rHwPRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSqOxBt00+T4jYfYTYFtorRkVV4NbaT3lzChYHB+pvR13o6ouDI+etWKs7NJwT+t/kZZTfjPuzRm/YeHIdgdPvKruG6oN7ETqrb6y0YwbwCVpm3fGszmEfCorD2AP53j2u3s7d3fhK41UQAPaRQgCcNy6z6xrUVikPsk3lee080=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDcA172B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94083C2BCB4;
	Fri,  1 May 2026 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777664177;
	bh=iN/5ZWsd+G/llWYnMKfz9xNhUpeX3w53Wzqf1rHwPRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TDcA172B/JYXX9geY4/si/gC22N/nD5h8VNU+kxctS/fprkwk86GTivr2sTGzbyLJ
	 kyNtotaBJYeUzHN/+M1/QpdOWTrD4Egro56fL8dOPcjnLgei2DSVTiKILpy0uSOj3s
	 ND788sqtal+f2BpEKDJnZvLS9ZpOeMq12pfn7cSJgOrTowQfX+RBujdxnytBOiiZJx
	 tJbDU+ACW99tL3AoviBc//7ujVyeGdRBPREn6pws6mpEoHRmxK3OeSyNMrslaTyGMW
	 2AKD523ErLprSR70HzlFDZX+TnEGr/cENcgyrJ9PqRoKEB63yZziHuMxf9XZM37+vM
	 48LuCyiPnB+QQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 May 2026 21:35:35 +0200
Subject: [PATCH net 2/4] mptcp: use MPTCP_RST_EMPTCP for ACK HMAC
 validation failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-2-b70118df778e@kernel.org>
References: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-0-b70118df778e@kernel.org>
In-Reply-To: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-0-b70118df778e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Gang Yan <yangang@kylinos.cn>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DOYuhrAzltfrRlUqWb1toh/VN3K8I0dgYPEc5n8ev4w=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK/Mixz27Ri64T6hMVeVxc84KhdoxR7sDNXNfpHrDQf+
 5SFF7W3d5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEyE35Lhn6YpU2Qrr9mO2oyl
 4aL5py45xb99yha+/My7lVpl1vsbMxj+R37a4BGxrbJJ7GLVo9tejsIPuDZW2Uzc1FIuFSpz+xs
 vEwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: CC4DB4AF2F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242502-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

When HMAC validation fails on a received ACK + MP_JOIN in
subflow_syn_recv_sock(), the subflow is reset with reason
MPTCP_RST_EPROHIBIT ("Administratively prohibited"). This is
incorrect: HMAC validation failure is an MPTCP protocol-level
error, not an administrative policy denial.

The mirror site on the client, in subflow_finish_connect(), already
uses MPTCP_RST_EMPTCP ("MPTCP-specific error") for the same kind of
HMAC failure on the SYN/ACK + MP_JOIN. Use the same reason on the
server side for symmetry and accuracy.

Suggested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Fixes: 443041deb5ef ("mptcp: fix NULL pointer in can_accept_new_subflow")
Cc: stable@vger.kernel.org
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bda6862264ca..d562e149606f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -908,7 +908,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 			if (!subflow_hmac_valid(subflow_req, &mp_opt)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
-				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 				goto dispose_child;
 			}
 

-- 
2.53.0


