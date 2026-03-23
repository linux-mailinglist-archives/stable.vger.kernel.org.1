Return-Path: <stable+bounces-228776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFbhNPlowWmoSwQAu9opvQ
	(envelope-from <stable+bounces-228776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:23:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D22F7FD1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E77833123EEF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C353ACEED;
	Mon, 23 Mar 2026 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UIrPQm4e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1B3AF645;
	Mon, 23 Mar 2026 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277093; cv=none; b=anKps2rVM5Ve8epNvttgXFli9BDXLs75HjV4AgjnWWnwp0gHkotlOU36r5YQHHJJE90AhptzCvew2rb9kpkAQ1zG2ivsNNGFVaLLO+v9QsrahaPSLCRUJwDcAGYD006G63WGgnFWqWRnBlQFBXlLBpxHJ0aYgCXRIIquj+kxa/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277093; c=relaxed/simple;
	bh=KalMEQBT0+XzQkwuPepHhygWn8Ugy6K3q0B44WUY0eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmGSmR2nyMb9rbWRlnQU4hKGwSnFfnaZn4aqJyJm3T9N7mrPq4KrJXHPgN4r7F7uQU2xKxOm6ckjPNfr82iTT5hu4OaM3+Va78erZxFVCjozbzvgiFAjZ8gnaqDy+31Q0MbdV88GUXyoQy3193XE84y+6NZyvU2cU/ai7ZaicGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UIrPQm4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74808C4CEF7;
	Mon, 23 Mar 2026 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277092;
	bh=KalMEQBT0+XzQkwuPepHhygWn8Ugy6K3q0B44WUY0eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIrPQm4eH740FZXgLCFi7aBGzHKKNYhYOTcA72Lye5Q8ywcStbr5GrdDP6tnExYmM
	 eRkdwXM6+DtK3XsAmkLRcQSQz1NmvR+XgeR97efuXMi058GsqCLUWbyOHqyTk8hikF
	 Ijx0mLMcmof681y73T74X4D67KfNF3rTfOXd72CU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.12 317/460] Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
Date: Mon, 23 Mar 2026 14:45:13 +0100
Message-ID: <20260323134534.291929868@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228776-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,johannes-moeller.dev:email]
X-Rspamd-Queue-Id: 490D22F7FD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Johannes Möller <research@johannes-moeller.dev>

commit 15145675690cab2de1056e7ed68e59cbd0452529 upstream.

l2cap_ecred_reconf_rsp() casts the incoming data to struct
l2cap_ecred_conn_rsp (the ECRED *connection* response, 8 bytes with
result at offset 6) instead of struct l2cap_ecred_reconf_rsp (2 bytes
with result at offset 0).

This causes two problems:

 - The sizeof(*rsp) length check requires 8 bytes instead of the
   correct 2, so valid L2CAP_ECRED_RECONF_RSP packets are rejected
   with -EPROTO.

 - rsp->result reads from offset 6 instead of offset 0, returning
   wrong data when the packet is large enough to pass the check.

Fix by using the correct type.  Also pass the already byte-swapped
result variable to BT_DBG instead of the raw __le16 field.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: stable@vger.kernel.org
Signed-off-by: Lukas Johannes Möller <research@johannes-moeller.dev>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5373,7 +5373,7 @@ static inline int l2cap_ecred_reconf_rsp
 					 u8 *data)
 {
 	struct l2cap_chan *chan, *tmp;
-	struct l2cap_ecred_conn_rsp *rsp = (void *) data;
+	struct l2cap_ecred_reconf_rsp *rsp = (void *)data;
 	u16 result;
 
 	if (cmd_len < sizeof(*rsp))
@@ -5381,7 +5381,7 @@ static inline int l2cap_ecred_reconf_rsp
 
 	result = __le16_to_cpu(rsp->result);
 
-	BT_DBG("result 0x%4.4x", rsp->result);
+	BT_DBG("result 0x%4.4x", result);
 
 	if (!result)
 		return 0;



