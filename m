Return-Path: <stable+bounces-227734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCYGIMhRvmnsMQMAu9opvQ
	(envelope-from <stable+bounces-227734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 09:07:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D398F2E41E0
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 09:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AB39301E6FE
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 08:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA53D2C11D1;
	Sat, 21 Mar 2026 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0V9U2DaS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1C274FE8
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774080453; cv=none; b=B3i5eHN9l3erewD7zuhgA3URkNywzWMYdKPE2J3Yek0DDHKxHBvbTVxj+f+TWQFw6L1e8MyOfYEiyZ2CKpgHjSYGdDzarNtC63fF8NJCk73R1DSV2OJcL7WyjSU5g6LsZnzGnkIfG5sJHPfamO21iNwnMoo09F/Np3ooTBiHNVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774080453; c=relaxed/simple;
	bh=w56i+bJsZawgHHeGikXezmvTlkRmHt5oy4eKYmumo4s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ia19hel663gXGCVuM8dwU3+vEDz+Rl5hepc0r7T4lfccKsL/8HH87MFhU8GwgA3p2Gc31uqzZNC5Xco+71U8jY8P0JvxkZxtiMMpp3kqbSm7AO9SmJaUYhm4/IaiObZtcqGz6W7QEj8cxIEHvDoFGbPRNR5oi3cBTZsI1ZfGChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0V9U2DaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B4FC19421;
	Sat, 21 Mar 2026 08:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774080453;
	bh=w56i+bJsZawgHHeGikXezmvTlkRmHt5oy4eKYmumo4s=;
	h=Subject:To:Cc:From:Date:From;
	b=0V9U2DaSI6wZVFEMNcd02NZD15Sh3l96mEIoY3rOWu0N9B4wR/cPd+olXaDchKF84
	 j/AbEKqbUfHTpRmxY2A+kjHcSEdxds2gI9Q4YWR1yXQvkDntz8AnwtpgsSt1aUK77P
	 TAPbpbVvJX9Y5fS4xpaneb03NvX025Nem/JodeAU=
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ" failed to apply to 6.6-stable tree
To: luiz.von.dentz@intel.com,yimingqian591@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 21 Mar 2026 09:07:11 +0100
Message-ID: <2026032111-catalyst-sanded-cf58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227734-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_WP_URI(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,intel.com:email,gregkh:email]
X-Rspamd-Queue-Id: D398F2E41E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5b3e2052334f2ff6d5200e952f4aa66994d09899
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032111-catalyst-sanded-cf58@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b3e2052334f2ff6d5200e952f4aa66994d09899 Mon Sep 17 00:00:00 2001
From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Tue, 3 Mar 2026 13:29:53 -0500
Subject: [PATCH] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ

Currently the code attempts to accept requests regardless of the
command identifier which may cause multiple requests to be marked
as pending (FLAG_DEFER_SETUP) which can cause more than
L2CAP_ECRED_MAX_CID(5) to be allocated in l2cap_ecred_rsp_defer
causing an overflow.

The spec is quite clear that the same identifier shall not be used on
subsequent requests:

'Within each signaling channel a different Identifier shall be used
for each successive request or indication.'
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/host/logical-link-control-and-adaptation-protocol-specification.html#UUID-32a25a06-4aa4-c6c7-77c5-dcfe3682355d

So this attempts to check if there are any channels pending with the
same identifier and rejects if any are found.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 780136e18aae..9d5b8d4d375a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5055,7 +5055,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	u16 mtu, mps;
 	__le16 psm;
 	u8 result, rsp_len = 0;
-	int i, num_scid;
+	int i, num_scid = 0;
 	bool defer = false;
 
 	if (!enable_ecred)
@@ -5068,6 +5068,14 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto response;
 	}
 
+	/* Check if there are no pending channels with the same ident */
+	__l2cap_chan_list_id(conn, cmd->ident, l2cap_ecred_list_defer,
+			     &num_scid);
+	if (num_scid) {
+		result = L2CAP_CR_LE_INVALID_PARAMS;
+		goto response;
+	}
+
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 


