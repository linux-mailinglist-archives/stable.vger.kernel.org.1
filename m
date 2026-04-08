Return-Path: <stable+bounces-234133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNZWOHWb1mnDGggAu9opvQ
	(envelope-from <stable+bounces-234133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:16:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCFF3C0508
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFEAA302BB9F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402973D4134;
	Wed,  8 Apr 2026 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w3Vr5VCu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB7347503;
	Wed,  8 Apr 2026 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672070; cv=none; b=GN08p8J8CBP2DjuO+vGSH9BgY/2RoDpbVXAOwK24OlHNld0pFiGKF0NR1cE2QbQsCvt5wvY5Vw5coUqPCRtPbbjekQR9YSq+16oNnzVyRtGxhIa1oiIgvv9ZFcYrVFFzwBKq3INLN/BXKUuxPJFKJDGzluldnvtKuXOEQysY4QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672070; c=relaxed/simple;
	bh=H2+cFTmVF9m29Eobu9Vm16G1OfEaivWGMyRwnZ+XR2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dI24F7lSrUZm2I+7AwfV7Hb0g7+6Vd6yYUGqEhb3Z1rlLX/YoH1Ow776SpY7aQFVaZETGpPiz5kw2bTYaLTCl2K+M1lAV0Nn6TMXq/g1y/XgAjVzgq1hxlxY3XzG2mb6t1qolMTGb4enRP3pVo4Te93S8K9V1X4YUgzutuhEVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w3Vr5VCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A67DC19421;
	Wed,  8 Apr 2026 18:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672069;
	bh=H2+cFTmVF9m29Eobu9Vm16G1OfEaivWGMyRwnZ+XR2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w3Vr5VCu40l+57+4miT3ce48MZdu7I4wGLo/FuK0WbRENAUNoWrRP2p57KISICLUZ
	 8aHo+xbQ93UMC/PrYO2OlOcmZyW3W92Lql77KsDjbCaEKG9Jt3cyireBX8YyWvZLrp
	 ES/fNtnH3Xzh7l3FDAwly+lQ3YgQgRQ/r50h2NS8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Keenan Dong <keenanat2000@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 177/312] Bluetooth: MGMT: validate LTK enc_size on load
Date: Wed,  8 Apr 2026 20:01:34 +0200
Message-ID: <20260408175940.375386858@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234133-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 6FCFF3C0508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keenan Dong <keenanat2000@gmail.com>

[ Upstream commit b8dbe9648d69059cfe3a28917bfbf7e61efd7f15 ]

Load Long Term Keys stores the user-provided enc_size and later uses
it to size fixed-size stack operations when replying to LE LTK
requests. An enc_size larger than the 16-byte key buffer can therefore
overflow the reply stack buffer.

Reject oversized enc_size values while validating the management LTK
record so invalid keys never reach the stored key state.

Fixes: 346af67b8d11 ("Bluetooth: Add MGMT handlers for dealing with SMP LTK's")
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b89c3fc364b83..abbb17f1a025f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7224,6 +7224,9 @@ static bool ltk_is_valid(struct mgmt_ltk_info *key)
 	if (key->initiator != 0x00 && key->initiator != 0x01)
 		return false;
 
+	if (key->enc_size > sizeof(key->val))
+		return false;
+
 	switch (key->addr.type) {
 	case BDADDR_LE_PUBLIC:
 		return true;
-- 
2.53.0




