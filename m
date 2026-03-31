Return-Path: <stable+bounces-231523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPofMMr2y2kGNAYAu9opvQ
	(envelope-from <stable+bounces-231523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:31:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 249FE36CAEA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D99630E7671
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E123E3C40;
	Tue, 31 Mar 2026 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KR2xCMWt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5CE401A2C;
	Tue, 31 Mar 2026 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974389; cv=none; b=YKbkQ1jK098N3hUaR6xQsf8Pw8dsxxuQXxi2mPO/fPShwYKnROh2cWodJIK28zC4zrvDjYqxeQBDOjgpmbNZDSbsM6EVX0m/cGVxWszauMDKRg2y3oU5Z2TfA3EzCPGexjZayxoslf8R0Tjb8x+X0Syc3DQ1IE26k/DaD0/hU8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974389; c=relaxed/simple;
	bh=Gna5beid00FQYg4U/fsZZP0WXaaHLAcEcFjyCEqzFzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzEz2kuz47m4rcDDPHn+Y5TvSI6u/astS+cSxK+XWsCWzZP/lJp93/h16kZ7vcKSptuAemIP0u24X0ttr6yd6wprXct904dHXDrSRHvRYIZkkitWbSwkdTHTEYRc3/znxa0tz6h/Xdil5n9daTu2zLMLdHoW/plQ8IM1UkJurJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KR2xCMWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660C3C19424;
	Tue, 31 Mar 2026 16:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974389;
	bh=Gna5beid00FQYg4U/fsZZP0WXaaHLAcEcFjyCEqzFzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KR2xCMWtNXQ2+B0eHvMdYe+TifFFAIs6myYVd7tjZhJkyAwzOZbaAEatikrhdr7SQ
	 8Qj8I4YovAd0QKEkh+cfElIyOFRvLsZBdhaS9nxCRd3IKQN/WVenFA7iiXwiMhXMNr
	 vZTaBGTGLKg3VM9fOB9j+0ggnq1/tlGk/IBG/0pw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 066/175] Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop
Date: Tue, 31 Mar 2026 18:20:50 +0200
Message-ID: <20260331161732.206807852@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231523-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 249FE36CAEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 25f420a0d4cfd61d3d23ec4b9c56d9f443d91377 ]

l2cap_config_req() processes CONFIG_REQ for channels in BT_CONNECTED
state to support L2CAP reconfiguration (e.g. MTU changes). However,
since both CONF_INPUT_DONE and CONF_OUTPUT_DONE are already set from
the initial configuration, the reconfiguration path falls through to
l2cap_ertm_init(), which re-initializes tx_q, srej_q, srej_list, and
retrans_list without freeing the previous allocations and sets
chan->sdu to NULL without freeing the existing skb. This leaks all
previously allocated ERTM resources.

Additionally, l2cap_parse_conf_req() does not validate the minimum
value of remote_mps derived from the RFC max_pdu_size option. A zero
value propagates to l2cap_segment_sdu() where pdu_len becomes zero,
causing the while loop to never terminate since len is never
decremented, exhausting all available memory.

Fix the double-init by skipping l2cap_ertm_init() and
l2cap_chan_ready() when the channel is already in BT_CONNECTED state,
while still allowing the reconfiguration parameters to be updated
through l2cap_parse_conf_req(). Also add a pdu_len zero check in
l2cap_segment_sdu() as a safeguard.

Fixes: 96298f640104 ("Bluetooth: L2CAP: handle l2cap config request during open state")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 47625ea36106f..3da3e9fddd049 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2383,6 +2383,9 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 	/* Remote device may have requested smaller PDUs */
 	pdu_len = min_t(size_t, pdu_len, chan->remote_mps);
 
+	if (!pdu_len)
+		return -EINVAL;
+
 	if (len <= pdu_len) {
 		sar = L2CAP_SAR_UNSEGMENTED;
 		sdu_len = 0;
@@ -4281,14 +4284,16 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 	if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
-		if (chan->mode == L2CAP_MODE_ERTM ||
-		    chan->mode == L2CAP_MODE_STREAMING)
-			err = l2cap_ertm_init(chan);
+		if (chan->state != BT_CONNECTED) {
+			if (chan->mode == L2CAP_MODE_ERTM ||
+			    chan->mode == L2CAP_MODE_STREAMING)
+				err = l2cap_ertm_init(chan);
 
-		if (err < 0)
-			l2cap_send_disconn_req(chan, -err);
-		else
-			l2cap_chan_ready(chan);
+			if (err < 0)
+				l2cap_send_disconn_req(chan, -err);
+			else
+				l2cap_chan_ready(chan);
+		}
 
 		goto unlock;
 	}
-- 
2.51.0




