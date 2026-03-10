Return-Path: <stable+bounces-224027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLooMo3/r2mdeQIAu9opvQ
	(envelope-from <stable+bounces-224027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:25:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D0F24A9F3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52634314FBEC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E4D3859EA;
	Tue, 10 Mar 2026 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBeHqr/x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55769352C4F;
	Tue, 10 Mar 2026 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141160; cv=none; b=tafch/4MPxFMJAKamTEKR8xT8oECZ5dGsMXiMDBk6pldF7ZBc5ms83HF5mGWciUoMFtlraskhXUODPX1ogEZSK3ntvhkpXUYY50fPytcIBbZhtyvG5mwcPaVwp7Tr7ueEcW7jDgQnAHeAV+mYCZeioNUmUKeAr8rg/DNBCmwE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141160; c=relaxed/simple;
	bh=T05F+HlF1k16NcWkquhXy9FqnSOF24X4Ukrt1GzzRX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpM5UDdHeWkZGi4Pj2iLPoy4y9nWB2KhhxihheW1axFwDtBvmuCZUn+n6NlZFXOaQGAT8R+MA7/U0X3kvuS5lUGaR3Q2DxRwQH75upneBxtclivM3nHZUCXGibnl+89ruwbUIUItkXrhHCQPcI/HUmQTvH6xo+4uHwE1B7LAtCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBeHqr/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78083C19423;
	Tue, 10 Mar 2026 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141160;
	bh=T05F+HlF1k16NcWkquhXy9FqnSOF24X4Ukrt1GzzRX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBeHqr/xARQ7rVaB7PpM6z0bw7GvhUzsezgkjr7S0aYiC2nxgtSXTomMVS8zaUAMc
	 Ky3KmYuakJ3pcS13dUucU16Jw9pg3Ldrv7PNcP+CHhFxLpxND5dcjfyLDmUkk57IV0
	 IU7hV8WNpQIKtDj1xGqqf+Pr7mneNcMcoEAVM72zf8RBlRp2TaeYVHzFLeybX1lLKC
	 d/mTLmv7GRzeQF4G3yH/kuq9YP9LP7Pd69klygftUeYE/A0k+5UCfNIFm3CVqyxXFw
	 QUcAzPsQLApfGbHpDt3+A+0P4sHbMk1dUF8lcb1o05shSULb0fuFFoe70z2kpn2oyx
	 V05j9Tx7ktmmQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Frank Lorenz <lorenz-frank@web.de>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.19 162/311] mptcp: pm: avoid sending RM_ADDR over same subflow
Date: Tue, 10 Mar 2026 07:03:29 -0400
Message-ID: <9f10654157ace42c65d0da7a0ee0b4309711f53b.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58D0F24A9F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,web.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224027-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit fb8d0bccb221080630efcd9660c9f9349e53cc9e upstream.

RM_ADDR are sent over an active subflow, the first one in the subflows
list. There is then a high chance the initial subflow is picked. With
the in-kernel PM, when an endpoint is removed, a RM_ADDR is sent, then
linked subflows are closed. This is done for each active MPTCP
connection.

MPTCP endpoints are likely removed because the attached network is no
longer available or usable. In this case, it is better to avoid sending
this RM_ADDR over the subflow that is going to be removed, but prefer
sending it over another active and non stale subflow, if any.

This modification avoids situations where the other end is not notified
when a subflow is no longer usable: typically when the endpoint linked
to the initial subflow is removed, especially on the server side.

Fixes: 8dd5efb1f91b ("mptcp: send ack for rm_addr")
Cc: stable@vger.kernel.org
Reported-by: Frank Lorenz <lorenz-frank@web.de>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/612
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260303-net-mptcp-misc-fixes-7-0-rc2-v1-2-4b5462b6f016@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm.c | 55 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e2040c327af67..f5e1a204007aa 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -212,9 +212,24 @@ void mptcp_pm_send_ack(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 }
 
-void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
+static bool subflow_in_rm_list(const struct mptcp_subflow_context *subflow,
+			       const struct mptcp_rm_list *rm_list)
+{
+	u8 i, id = subflow_get_local_id(subflow);
+
+	for (i = 0; i < rm_list->nr; i++) {
+		if (rm_list->ids[i] == id)
+			return true;
+	}
+
+	return false;
+}
+
+static void
+mptcp_pm_addr_send_ack_avoid_list(struct mptcp_sock *msk,
+				  const struct mptcp_rm_list *rm_list)
 {
-	struct mptcp_subflow_context *subflow, *alt = NULL;
+	struct mptcp_subflow_context *subflow, *stale = NULL, *same_id = NULL;
 
 	msk_owned_by_me(msk);
 	lockdep_assert_held(&msk->pm.lock);
@@ -224,19 +239,35 @@ void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 		return;
 
 	mptcp_for_each_subflow(msk, subflow) {
-		if (__mptcp_subflow_active(subflow)) {
-			if (!subflow->stale) {
-				mptcp_pm_send_ack(msk, subflow, false, false);
-				return;
-			}
+		if (!__mptcp_subflow_active(subflow))
+			continue;
 
-			if (!alt)
-				alt = subflow;
+		if (unlikely(subflow->stale)) {
+			if (!stale)
+				stale = subflow;
+		} else if (unlikely(rm_list &&
+				    subflow_in_rm_list(subflow, rm_list))) {
+			if (!same_id)
+				same_id = subflow;
+		} else {
+			goto send_ack;
 		}
 	}
 
-	if (alt)
-		mptcp_pm_send_ack(msk, alt, false, false);
+	if (same_id)
+		subflow = same_id;
+	else if (stale)
+		subflow = stale;
+	else
+		return;
+
+send_ack:
+	mptcp_pm_send_ack(msk, subflow, false, false);
+}
+
+void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
+{
+	mptcp_pm_addr_send_ack_avoid_list(msk, NULL);
 }
 
 int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
@@ -470,7 +501,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx = *rm_list;
 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_addr_send_ack(msk);
+	mptcp_pm_addr_send_ack_avoid_list(msk, rm_list);
 	return 0;
 }
 
-- 
2.51.0


