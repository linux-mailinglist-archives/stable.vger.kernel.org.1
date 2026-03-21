Return-Path: <stable+bounces-227735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA2BAtFRvmnsMQMAu9opvQ
	(envelope-from <stable+bounces-227735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 09:07:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE2A2E41E7
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 09:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DF12301C174
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 08:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7092C11D1;
	Sat, 21 Mar 2026 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NGjinBq1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33245274FE8
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774080461; cv=none; b=jHHJKadnMy+1GGkUKu6md74Hus/mP2uUW5HfdfJGbFjl1UIudUM6L6xAkYjHdrkzj9IDBkKgXvls05ozi4UZxXlqx+c49f1bJN66R6bcXYeB3GBTM9A+tseflSWDsLLInrnQpISbNExGVuBp3sq4PmnYSZwSKSc4TaTRUxglTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774080461; c=relaxed/simple;
	bh=FBq3sG4wUG8dpFYOLEoOqTm92DntNTzMKdCD7j/cvMM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cAAjMqaRCg+ZsPH/knn1Ft+avwNcAPzGH6aRlsBDV2Bh4qvSK5BwCrytcZM9V1IhuFQMSeW1eytrfZJIKdr8vBTmctEjUXM+1Y2VmI3/koheHxRBhnjlVad9EVjf7UbgTx3FO5G9LcehXg70TTYN4v8oq/tS0Lr1jsBoKjpKkR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NGjinBq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6B1C19421;
	Sat, 21 Mar 2026 08:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774080460;
	bh=FBq3sG4wUG8dpFYOLEoOqTm92DntNTzMKdCD7j/cvMM=;
	h=Subject:To:Cc:From:Date:From;
	b=NGjinBq1MAYuXpxHQyfew+xSjbmGrLXDujmlZhjaFu65fgXs5/LtYZM4tQtpBroez
	 SFJlMSwLseb3TRyr8TLLcx0WUy53N8ful063SYvUypzIqBYVr5kl510e7zXX15i3rn
	 pRfGEL6I8d+leZT6+4QJdc5p6SK2TFFA3zMgabeo=
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ" failed to apply to 5.15-stable tree
To: luiz.von.dentz@intel.com,yimingqian591@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 21 Mar 2026 09:07:12 +0100
Message-ID: <2026032112-attain-reprocess-ab80@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227735-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,intel.com:email]
X-Rspamd-Queue-Id: 5BE2A2E41E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5b3e2052334f2ff6d5200e952f4aa66994d09899
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032112-attain-reprocess-ab80@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


