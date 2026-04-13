Return-Path: <stable+bounces-236763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG2cAkkf3WmsaAkAu9opvQ
	(envelope-from <stable+bounces-236763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:52:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7622B3F0134
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BA9C312942D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DECA3093CF;
	Mon, 13 Apr 2026 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lHHZmRWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C249620;
	Mon, 13 Apr 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097731; cv=none; b=jXSrExQj3t5/UNLtwNh7RYfzh7iSt9vLa/agM70TUs3HfarHeR+Pt/KZhUwt6Ge2YczOMw8OgTEksi0tKNo+rJcfwJ3vYl/RQh3hcLBrvc+dHp/KwaNV+/4EsMUjaH10ZNSV4KBe9D3HBh6nEqfl1X8LJhGLeAJunbWt5yliXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097731; c=relaxed/simple;
	bh=kezZqFXvphmjuktTDoAuJk2U9Mp36O0c0I7CM8W23fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cV0klMiLvejS0/YSEiMbAMFnBORdMprgOJApolOMCEdGHcYWp6fW2xajneFaQFfvRxsMxrb7WEKsGeWhLqg8mdIaU5WnocAGwWGInjV8fDY7gzCaEqmHcMKhpbRXlVW3eyivKfDj+mEZrm90jboELHo6j8NzEuyVDSnUBvqKTYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lHHZmRWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89400C2BCAF;
	Mon, 13 Apr 2026 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097730;
	bh=kezZqFXvphmjuktTDoAuJk2U9Mp36O0c0I7CM8W23fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lHHZmRWHdfxM2Ga4oK3qNCIXKZ/fzdfvXrm3zH74IahMoff82OauXuywYdNniplI0
	 zI8GBiFztRaBO7FvfWexHJQdcYISRDxH2NRkGwzg54PuCNny7rbHOzpEych+5vrZeI
	 uHcFArpQl9zIL4fdCAWRhj/7ckQ8QKB1bxw2EVEc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Eggers <ceggers@arri.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 250/570] Bluetooth: SMP: make SM/PER/KDU/BI-04-C happy
Date: Mon, 13 Apr 2026 17:56:21 +0200
Message-ID: <20260413155839.832227562@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236763-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7622B3F0134
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index d1ba41153b66a..1621c24aebf88 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2737,7 +2737,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
 	    !crypto_memneq(key, smp->local_pk, 64)) {
 		bt_dev_err(hdev, "Remote and local public keys are identical");
-		return SMP_UNSPECIFIED;
+		return SMP_DHKEY_CHECK_FAILED;
 	}
 
 	memcpy(smp->remote_pk, key, 64);
-- 
2.51.0




