Return-Path: <stable+bounces-236942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Gr3HVwe3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-236942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:48:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8570B3EFDA2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 813763069A60
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC4A30BF4E;
	Mon, 13 Apr 2026 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JTZyT66d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856626CE32;
	Mon, 13 Apr 2026 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098187; cv=none; b=tFKWmXLvR+TnH87R8P+wAhCIlhDRhyv2M9yOnD6EIafozwdTCCLowe0lskkBLgCDZwSi8hozEDcAbapChjlQjOsfudWemouw7Hpd87dp7dGDDHBuw7RJBS/I5vt2/ux+QXRgBHD5fV+Ph4MzvgXEbZ82rUDyAsRlE8AtNCJCTcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098187; c=relaxed/simple;
	bh=EQLWq0BK/XDHvpUQzASXMdw0Ij/FQe/guOOOE7ccsew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etBocVdcYN/f+VpDp0VAaZtLe+isOE5dwvtBvXp78Y0ngQLnw0o0HBv9w8E/fhy02E+dOykxH35Un36jBpiUGj5aT2kSNqmcN4NJDmvPd4l08MLfr5JRAxacgyeN3b/+GX1kXlHOeQVtUULqJSuATwrtTRqVc9sdZsENgNinmxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JTZyT66d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29CAC2BCAF;
	Mon, 13 Apr 2026 16:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098187;
	bh=EQLWq0BK/XDHvpUQzASXMdw0Ij/FQe/guOOOE7ccsew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTZyT66d6pNrr0Og2KS3YlzbJinfyinOt6R3cpMzclKAPFqam9VSkXgRWb1CU63Ua
	 p3koZIcKE84byj7tClUYfYUxBut38zPP95f6nN0UMYH1CaDElHn2UwUv9umLRa6E2l
	 pCa9w1DzzmuuC2Za/QGkO+r21ujmnBc8iwsaFPX4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Keenan Dong <keenanat2000@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 427/570] Bluetooth: MGMT: validate LTK enc_size on load
Date: Mon, 13 Apr 2026 17:59:18 +0200
Message-ID: <20260413155846.468089525@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236942-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 8570B3EFDA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 1d04fb42f13f2..09232c424446b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6214,6 +6214,9 @@ static bool ltk_is_valid(struct mgmt_ltk_info *key)
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




