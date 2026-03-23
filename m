Return-Path: <stable+bounces-228110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB7FMcpIwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:06:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 619572F3CFF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6521A303E4BE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073B13AE1B8;
	Mon, 23 Mar 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JIh8hbkW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA53AE18C;
	Mon, 23 Mar 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274155; cv=none; b=QjwPNRshVTYhTOJdz/McFMDlO9OIPpu5vBcOT+ltp/KEXQn4R113jXbs8DGKtXKyWhwJadyHCSH89n37du9MH2ETgWImqlHRZ0VLC2EB0S8wWhtBApkiy2Ic/rZT97slku5+v+YKMaxusRDvdX7FW9RUEExNWx0Wcxifd4R6wYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274155; c=relaxed/simple;
	bh=gglKwFHzSi34rMYGrOqRQjhFVInUuNTH4/NAZfh449Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoDANc9cjcopXquC/CbGPUiEfO0ELPeOcXwN8j7SXs5wDVtwydlkuoQmIEIoCiNHZhMxaZcmRjYIZkoaXeIGchgbXd8EI3GJK38wSzGDZgpefb9COa/UXwxps/gM8Ji/+LcVDBSvCcqsdL+RIhg3yDCuZra1nT6Z2Xa+HvMje7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JIh8hbkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44550C4CEF7;
	Mon, 23 Mar 2026 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274155;
	bh=gglKwFHzSi34rMYGrOqRQjhFVInUuNTH4/NAZfh449Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JIh8hbkWc1ZAkhYQS7sJ40IMeq+UKi2UnGF6wW3qxxlSs2JF5bKmmvAa6djjhstyZ
	 QKnxft88+HWW7AcFLc3UM1usHOmt5oLk0tkjLZhVUAaliAppMcVhnGHixG74ti5N2a
	 peeTtSaQEKAABMzrbWFWiWp1FojloInLnPUS6KUM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Eggers <ceggers@arri.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 120/220] Bluetooth: SMP: make SM/PER/KDU/BI-04-C happy
Date: Mon, 23 Mar 2026 14:44:57 +0100
Message-ID: <20260323134508.391210570@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228110-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,arri.de:email]
X-Rspamd-Queue-Id: 619572F3CFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
index 3a1ce04a7a536..9d96040745897 100644
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




