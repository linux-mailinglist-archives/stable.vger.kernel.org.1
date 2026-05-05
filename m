Return-Path: <stable+bounces-244188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAZmO5sH+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:07:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1204CFEF5
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D246B30AA032
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A442648A2A8;
	Tue,  5 May 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx0o0gwQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64024480DE9;
	Tue,  5 May 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993308; cv=none; b=m/fwWY4FFDaDjt0hazlmDgN8AAqqe+W5r5ANXAqp7T4ykWAwWLSndmxwPFCl2bhE3Rq+Kp9LSIfjWw+jrkUSrUfzl3bfTmDxEJZJbP9URcw7wFoFYCyF9PVfPk+zstxDRmo80yiQ1SSf5WE2rKK4xIlkBJtPd38Fnpxz2FSvyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993308; c=relaxed/simple;
	bh=px53/60EaBdUVwTZLQJAP1uTkFQrxetJqg6JPD78aBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+b6JFJRAXSNljYpghs2eRrX0MNGE394PUrz++T8eKzP/89rSxpZkch4dViMNLBgg0GQR7tQ0pMTOXGx8S2igRHICH7DABgBCubY6JIfmDhaVJZo0PUvad2akcddkOLt+MIUwwwJTBTqnzl1C9hMYPNqEe5zIOcE3eiEH66uD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx0o0gwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B985C4AF0B;
	Tue,  5 May 2026 15:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777993308;
	bh=px53/60EaBdUVwTZLQJAP1uTkFQrxetJqg6JPD78aBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rx0o0gwQWhG/4fQfrr3xTjnf8pUAEvGrIsunHN+Txz0ZsKz2yqDWzU54YQsWyKswN
	 kGTNSEoiVm4E4cSIfbQQc67KiE+FHG17HeS9RaCR8+YsmFQkGgZafMbBC+Fc1aSfzp
	 5QKz9AgBscRPiQquM8hO3N+R8ordcpKwNCSCLFmNiFH5VXWG1R7pUJ84eGGvOkrEf3
	 63FB7UZElge0IYYx8U7JnEQ8xGOQ4n2jx8/mLgxrHlM8jJiNwp7dqXBXga+Ktm4kku
	 GjcXsvByybD8kjDHdVlUIpUvF53eTvZ8LGU2fPDvaj39EwUvC9sMiJ+H+W73nppQd+
	 I+whIBKbFhAqw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 May 2026 17:00:57 +0200
Subject: [PATCH net 09/11] mptcp: pm: prio: skip closed subflows
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-9-fca8091060a4@kernel.org>
References: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
In-Reply-To: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=px53/60EaBdUVwTZLQJAP1uTkFQrxetJqg6JPD78aBU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ/sTmpzs87HKlj/4FjVcu0RTWfwyevUpy//beGibbum
 wntmZqXOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbyh4uR4Z9PRtmZXLk5Zofn
 lK6c+22/h/KcSUU86/c6blvEUBT2qJyR4WYSy6tVcuW/nx9p2/VX3sj1whK7lPW81cfauw1eWTp
 NYwAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 7F1204CFEF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244188-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When sending an MP_PRIO, closed subflows need to be skipped.

This fixes the case where the initial subflow got closed, re-opened
later, then an MP_PRIO is needed for the same local address.

Note that explicit MP_PRIO cannot be sent during the 3WHS, so it is fine
to use __mptcp_subflow_active().

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Cc: stable@vger.kernel.org
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4a6e5ab30d80..3c152bf66cd5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -284,6 +284,9 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_addr_info local, remote;
 
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
 		mptcp_local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;

-- 
2.53.0


