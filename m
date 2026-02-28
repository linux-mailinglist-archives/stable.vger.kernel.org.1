Return-Path: <stable+bounces-220528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLi5CP46o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:59:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7B61C67BE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0014230991F0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC853CEB04;
	Sat, 28 Feb 2026 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM/tx2LT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D23CEAFC;
	Sat, 28 Feb 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300411; cv=none; b=Okogn+HynCrnpx5jKBxyzLZAX85HWqH5mqQ67h9gffQIaj2h3PGTQ7lrgwNyyvHtOgoHlhYuSrja9j2AJxQEYWj7Y4koixzycDjAMtbykvUSSk23UL2yt+9NYeX3ghpd4qhnfHrUR3AbbrO+cbkUfgX5a7X0xpT/3w6uiMQQLhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300411; c=relaxed/simple;
	bh=f+9w+xIfsNKQxYYkTRobj6+SBwpLWJTstDUHok5rPqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpbhCpZdXWOLLKcD2NUyNDTa4GIc1AHLos6QZwXWmS/1HmTy6g5wwylcfcSWvs7EH3AiHLG4kMamcr8Gp2OHgxx07jWek7zFqvFDRPO18jxwB/NR7CZT7MHxS2YIkishD2JLb5TccCDb/gYltn3Es24DbXj+BMYyISFjQGFcufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM/tx2LT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5E7C19423;
	Sat, 28 Feb 2026 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300411;
	bh=f+9w+xIfsNKQxYYkTRobj6+SBwpLWJTstDUHok5rPqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GM/tx2LT9fgAV2sudR7/Vze15lqiJK/qgRpzHA0k8RPCvCLEKaAq8ytMs5UNDBvTm
	 c5+feLtVZ+vNL1KWJ37x4hdbLFolOrwLAk144G4OOIs7OuCb2/QrpwkziDTVNMDNGL
	 MNCKCHT6j0D2m10Q3cX3Vnh2xr0tySZm4za+6B6oGc5PlIGBs3jxAO1a92xWGgz5Eu
	 OozckL7GYM1oEukJjkT0hat8fJCEs5xYXy9Z5CYD2ehFFC9Eh2Kej56z/kKR+nrCE8
	 PK31YutYbaFM3q11OutsIN+2LEvlwrnbT+8xwyXK8FlK8ly4CD3WNJT4MQxS0fETrP
	 laTQFsVxAehbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Corey Minyard <corey@minyard.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 449/844] ipmi: ipmb: initialise event handler read bytes
Date: Sat, 28 Feb 2026 12:26:02 -0500
Message-ID: <20260228173244.1509663-450-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220528-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,codeconstruct.com.au:email]
X-Rspamd-Queue-Id: 8D7B61C67BE
X-Rspamd-Action: no action

From: Matt Johnston <matt@codeconstruct.com.au>

[ Upstream commit 9f235ccecd03c436cb1683eac16b12f119e54aa9 ]

IPMB doesn't use i2c reads, but the handler needs to set a value.
Otherwise an i2c read will return an uninitialised value from the bus
driver.

Fixes: 63c4eb347164 ("ipmi:ipmb: Add initial support for IPMI over IPMB")
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Message-ID: <20260113-ipmb-read-init-v1-1-a9cbce7b94e3@codeconstruct.com.au>
Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_ipmb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
index 3a51e58b24875..28818952a7a4b 100644
--- a/drivers/char/ipmi/ipmi_ipmb.c
+++ b/drivers/char/ipmi/ipmi_ipmb.c
@@ -202,11 +202,16 @@ static int ipmi_ipmb_slave_cb(struct i2c_client *client,
 		break;
 
 	case I2C_SLAVE_READ_REQUESTED:
+		*val = 0xff;
+		ipmi_ipmb_check_msg_done(iidev);
+		break;
+
 	case I2C_SLAVE_STOP:
 		ipmi_ipmb_check_msg_done(iidev);
 		break;
 
 	case I2C_SLAVE_READ_PROCESSED:
+		*val = 0xff;
 		break;
 	}
 
-- 
2.51.0


