Return-Path: <stable+bounces-227803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D9nNGgtBv2md0QMAu9opvQ
	(envelope-from <stable+bounces-227803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 02:08:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B71B02E7D73
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 02:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 498E130086F7
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 01:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B38C372681;
	Sun, 22 Mar 2026 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzfsEGEr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D0364EA4
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774141702; cv=none; b=tfnfsgk+W5UMUcBHGWobgDGbtRLiemFqQd5ZaEvYPTtbug1ullHhtTzsUOKhd2faG5U/BrNb/3SKriX9kMkYmA45CgqXQM2YBtnxcN6zQSI5DByzUW6QB44WAx2GfyPsjp9ZvarmEBYYh34TDvwen3SPabJAMGlCr0a8bOCQ0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774141702; c=relaxed/simple;
	bh=quWxLoKr/9bNEohB0JgorfKpK0OyKcmrydVwaLOBD5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDXqvUcysR8cEUfuW8THEbBPHLeRiTF2x7l4xUsvRAKSJd408WtgE6zPTj3HitmlbiDB5QFaACzSiOZLPLSYraEZ7bB8UBBI4uZsxJUJ3KzMxg4yacYX5dhmuU0I/Xlqbs7oFja6QvGpoj8jY45sZOTqkFOotUwzkC9ddvTFcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzfsEGEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326E8C19421;
	Sun, 22 Mar 2026 01:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774141701;
	bh=quWxLoKr/9bNEohB0JgorfKpK0OyKcmrydVwaLOBD5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fzfsEGErgcJ5EpkChdYrwtuhiSp4d4PXz05+Qg2057GAkKT4RvB6lOyKAM+F3u8pb
	 ToPATDV634ZbyVu/FY7g3bi5SsRSikL4uofrah7o82t4SK5ed3op9BY/XtL1iLYNGF
	 HE7yqIhmu595PnpyDnUvi3IGRKRLXqb/VKyBAlmeM0kbYkng5sPWGmku/l/YAxzvXH
	 pJkh6rBaH26ONB0X+H1G2O5DEIaViXs1VxMPstB3etmUtwvDbqLd1MZmhKteiVaAHQ
	 GUbSVYoBvlTlnmb2cVSKfkUTq9YIuVvCqBl6OtWcbgS2UiUY93mAPLo9rWYXNlr48j
	 BxGbUUYWJDssA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
Date: Sat, 21 Mar 2026 21:08:19 -0400
Message-ID: <20260322010819.636183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032112-bakery-province-fb96@gregkh>
References: <2026032112-bakery-province-fb96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227803-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	HAS_WP_URI(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: B71B02E7D73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 5b3e2052334f2ff6d5200e952f4aa66994d09899 ]

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
[ adapted variable names ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7cb438c4ed0d0..c85357f4e4de3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6060,7 +6060,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	u16 mtu, mps;
 	__le16 psm;
 	u8 result, len = 0;
-	int i, num_scid;
+	int i, num_scid = 0;
 	bool defer = false;
 
 	if (!enable_ecred)
@@ -6071,6 +6071,14 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
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
 
-- 
2.51.0


