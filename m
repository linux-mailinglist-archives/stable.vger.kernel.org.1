Return-Path: <stable+bounces-220554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDl+KXc+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:13:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 956421C6B72
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF0ED3178AEA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE4F3D74E7;
	Sat, 28 Feb 2026 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV/kM9Pt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0A3D5677;
	Sat, 28 Feb 2026 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300435; cv=none; b=GAquBvjXKcJCxUg6bk42AeQk3/cHL4sUFshNShcTFlSaABgp7k5kji5BAZSZLZmfPt2cknbTfn1PRjIZoQbX4xkcxq+faBxoJdBfSjuYk5lrF74gzdS3EwtuchkUqFh6hKwisqjP3E4KiYGOhaIjK+bnUt/eM8g0xStkYv7NjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300435; c=relaxed/simple;
	bh=dJMssyz69qshYFj1P0Z+P9H6EwkDVsF3N1ezNEZ4jGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=can86C15LzUH2oEZWNqezU5C5eO5TLAE0rpX4hyg31lDA2Gm+ayaVstm/IzqulLfOvjBMXjIVQOJfe4GGZA9eNvpnSo2YmEEivuy3xUkJGn2cdnRCwsVdgDN90thTbJ/tG3feUKurb4RM8Qg+WXvDdPgeSjGdpVbibQI8zr6umo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV/kM9Pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9133C19425;
	Sat, 28 Feb 2026 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300435;
	bh=dJMssyz69qshYFj1P0Z+P9H6EwkDVsF3N1ezNEZ4jGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bV/kM9PtVTa42jNcYGlZA84iAkSnnqiQqdgUYEkAy+4EvexUczTz5xzgYgmKFlccW
	 b8mSgzbZXU7gAv1BCnTKe6Dpoc3skgYF8scUR/iDrSzOQPK54lYRqbfu6+XCMvnQG/
	 0erXhwBSr1x0FMiXDjeyH6uYpMvw1qrId+zvQm/WyG+kVVoe07LxY8L6q/YdxXoE3R
	 x6fmpHAVMjAmPx6VVX9H1YTKtfSVD4Tl4L+5X3Y1ygcW1Zd4AbJrtu9hLC0D1ESNgr
	 QpAKDn+CmRQ8lqB6gAOi8U0MgRLaCj4xPrFaxkQqsS/COlCXegfL7b1cuNyTx4OhX4
	 pbNN8SRvVkyJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Christian Eggers <ceggers@arri.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 475/844] Bluetooth: L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ
Date: Sat, 28 Feb 2026 12:26:28 -0500
Message-ID: <20260228173244.1509663-476-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220554-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arri.de:email]
X-Rspamd-Queue-Id: 956421C6B72
X-Rspamd-Action: no action

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 138d7eca445ef37a0333425d269ee59900ca1104 ]

This adds a check for encryption key size upon receiving
L2CAP_LE_CONN_REQ which is required by L2CAP/LE/CFC/BV-15-C which
expects L2CAP_CR_LE_BAD_KEY_SIZE.

Link: https://lore.kernel.org/linux-bluetooth/5782243.rdbgypaU67@n9w6sw14/
Fixes: 27e2d4c8d28b ("Bluetooth: Add basic LE L2CAP connect request receiving support")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Tested-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 29af3f63e89ce..72a4bb1fee46a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4900,6 +4900,13 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
+	/* Check if Key Size is sufficient for the security level */
+	if (!l2cap_check_enc_key_size(conn->hcon, pchan)) {
+		result = L2CAP_CR_LE_BAD_KEY_SIZE;
+		chan = NULL;
+		goto response_unlock;
+	}
+
 	/* Check for valid dynamic CID range */
 	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
 		result = L2CAP_CR_LE_INVALID_SCID;
-- 
2.51.0


