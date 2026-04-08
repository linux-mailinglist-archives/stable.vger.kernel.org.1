Return-Path: <stable+bounces-234616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGHCBaKg1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:38:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2F53C122B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B61613031F0B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD8D35C1B2;
	Wed,  8 Apr 2026 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="io0dJ/TE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E568928C87C;
	Wed,  8 Apr 2026 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673321; cv=none; b=Q8nRBXq+XCAISALdwI/IXaAFyaYiPbCCzXSVCeff2X7q6kYi2cIHsFh1ALoFQp/UpQRRBu6xvF52u29Tpv2xuyMgGKKzpYu0KDuDmyGK7h4Q0YaWTbOp6DRJwPk2I+w/7uCiYEoQ300Y8zChu4hPzheSNNX7TK/fake/MGh1igA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673321; c=relaxed/simple;
	bh=rQtpjtTJjGsJd29kjcByeePU5a7xaE5QCNznk0rrf+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvbPCX9Wyf57LSc5JTv9v4W6AM7dxkKptTrpWP0Wn05NVkkCpqoCl7eSxF04kiSNGhpdekRhSGv3WsEMXJGUX8j2Ox8deIUARW1SLqIiNoVFbhzyHfDUDqwk7xE+nabFYAbTmhSRMlIbjQJgVHuJ9XMrlJBoIrUfwgT+az9IwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=io0dJ/TE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F30C19421;
	Wed,  8 Apr 2026 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673320;
	bh=rQtpjtTJjGsJd29kjcByeePU5a7xaE5QCNznk0rrf+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=io0dJ/TExfw0IpvmLy6GQfRj9bbSbcqNPMVC1Uy5xRnkFZPieCoB71gpvi69FgxRy
	 LVFXidMWvJ5If7nZ20NvPuMfBs/cjG+mI31dSY5rmyeMfWgjbTsVnLAhAi35K8sYeD
	 WTLFUFYA7fbrSTvDnCnBiqSYYfL/x2Q3BLZfYx1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	hkbinbin <hkbinbinbin@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.18 144/277] Bluetooth: hci_sync: fix stack buffer overflow in hci_le_big_create_sync
Date: Wed,  8 Apr 2026 20:02:09 +0200
Message-ID: <20260408175939.250261107@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234616-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,molgen.mpg.de,intel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,mpg.de:email]
X-Rspamd-Queue-Id: 2D2F53C122B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: hkbinbin <hkbinbinbin@gmail.com>

commit bc39a094730ce062fa034a529c93147c096cb488 upstream.

hci_le_big_create_sync() uses DEFINE_FLEX to allocate a
struct hci_cp_le_big_create_sync on the stack with room for 0x11 (17)
BIS entries.  However, conn->num_bis can hold up to HCI_MAX_ISO_BIS (31)
entries — validated against ISO_MAX_NUM_BIS (0x1f) in the caller
hci_conn_big_create_sync().  When conn->num_bis is between 18 and 31,
the memcpy that copies conn->bis into cp->bis writes up to 14 bytes
past the stack buffer, corrupting adjacent stack memory.

This is trivially reproducible: binding an ISO socket with
bc_num_bis = ISO_MAX_NUM_BIS (31) and calling listen() will
eventually trigger hci_le_big_create_sync() from the HCI command
sync worker, causing a KASAN-detectable stack-out-of-bounds write:

  BUG: KASAN: stack-out-of-bounds in hci_le_big_create_sync+0x256/0x3b0
  Write of size 31 at addr ffffc90000487b48 by task kworker/u9:0/71

Fix this by changing the DEFINE_FLEX count from the incorrect 0x11 to
HCI_MAX_ISO_BIS, which matches the maximum number of BIS entries that
conn->bis can actually carry.

Fixes: 42ecf1947135 ("Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending")
Cc: stable@vger.kernel.org
Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_sync.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7131,7 +7131,8 @@ static void create_big_complete(struct h
 
 static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
 {
-	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis, 0x11);
+	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis,
+		    HCI_MAX_ISO_BIS);
 	struct hci_conn *conn = data;
 	struct bt_iso_qos *qos = &conn->iso_qos;
 	int err;



