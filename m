Return-Path: <stable+bounces-228870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMTcNx5UwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:54:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A00232F5662
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32877301AE43
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184653AEF4F;
	Mon, 23 Mar 2026 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lrsc3f9H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69F38CFE1;
	Mon, 23 Mar 2026 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277357; cv=none; b=WZPSaRP7bgCl0Nt2prM6dJyQyAtwjZmULrXvrAi6lO/qWuMftlfb77MGOgdweKHcOvExfxT8aFl9ZQQw1RJ0T5GBaEN7o5KGueB3ojblu2dGDmejzLlNG9Vdy7tA/561TOZjhoxItVUrF1ikOz2sFcCuaRv+K55yZBg5Xe3Pp3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277357; c=relaxed/simple;
	bh=Qad2mGiK7P/Fxt2pA8iDuyOwMOO949HpR+p9LZxy6tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgEOj0yZjNqupR/1el7gf5UqxFrvGSwjvLs5mrNyTXa1fmyIIGBnq03Te/Sr2vMDPjIQbMIiIfvBrtcmWg8dnen3Ac4z0ua4bgVq87k2pbhus6yzh4KhzYUXsFocte/PMMxp36JaKib1u41ot/Pd4mOyHG5ILsVAsKSiSSvL4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lrsc3f9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7E3C2BC9E;
	Mon, 23 Mar 2026 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277357;
	bh=Qad2mGiK7P/Fxt2pA8iDuyOwMOO949HpR+p9LZxy6tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrsc3f9HfRU13cztk/th2p2wumkcO/TX972z78wt3f+c768qPEtqwV6uy7BASgNuy
	 hPN6dPjBtz8gKKlY8cQokBGXoRlw8W6l3aVdaSIWAr7sXQVCiaog3Wh3OatKx3Ok5o
	 Z9ZsfGb8/O4W8j6gnTeXuXnQuszATUzyXGqkT7QY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Eggers <ceggers@arri.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 382/460] Bluetooth: SMP: make SM/PER/KDU/BI-04-C happy
Date: Mon, 23 Mar 2026 14:46:18 +0100
Message-ID: <20260323134535.957072043@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228870-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A00232F5662
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Eggers <ceggers@arri.de>

[ Upstream commit 0e4d4dcc1a6e82cc6f9abf32193558efa7e1613d ]

The last test step ("Test with Invalid public key X and Y, all set to
0") expects to get an "DHKEY check failed" instead of "unspecified".

Fixes: 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys are identical")
Signed-off-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3a33fd06e6a4c..204c5fe3a8d08 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2743,7 +2743,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
 	    !crypto_memneq(key, smp->local_pk, 64)) {
 		bt_dev_err(hdev, "Remote and local public keys are identical");
-		return SMP_UNSPECIFIED;
+		return SMP_DHKEY_CHECK_FAILED;
 	}
 
 	memcpy(smp->remote_pk, key, 64);
-- 
2.51.0




