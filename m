Return-Path: <stable+bounces-224418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLlqFv4DsGlAegIAu9opvQ
	(envelope-from <stable+bounces-224418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:43:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C0A24B701
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFE243162855
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFDF33A9C6;
	Tue, 10 Mar 2026 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcVTP0yg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AF2FFDF7;
	Tue, 10 Mar 2026 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142151; cv=none; b=SGSWS1BvmknPUbUPhqpiwMGM1dMeDe/uDOYjUqUDL17QV1742FqW7yUjNl4oGcZDcpwmIYL6rk21eLmA+ehL1044Gtd3ow+7PbgA61DCIwvNn7MzaqJFPI/CcBfVfAzM85qoiqGaucGqwz8D16pcdpXm2EQspKzhnqvzYygQ1wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142151; c=relaxed/simple;
	bh=ahSBGcr7K28Zh6xOe2WTsZijfDYtRbBzgdvARh/uVcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IU/bCi4+cY7QaN/jXIvFf/87MOUjxwcCe/pEbVxcdpotEsn1TcthbY8Rn7eIZmlxOh8rvGoO2fn8JGl62/DIfoPbOkaj+aQPqTGqog5eiGPNGTKfCAlS27GBTPa8cC8+u2+CsqDi2rx1ov979azDChYWth8IWpTKex5xQuzLIC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcVTP0yg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12916C2BCAF;
	Tue, 10 Mar 2026 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142151;
	bh=ahSBGcr7K28Zh6xOe2WTsZijfDYtRbBzgdvARh/uVcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcVTP0ygBCS0IzFn5EkgZPrMkcRepF4xxrHUSjaqFzfSv4QvU4fRkMGebui9nAeCn
	 ZBzF8eQfz1/M7IRl+xdL7QovojZ0oCUVvSIrkjH3yGc88JZvSOVN5iBxMCJ2ByAnxq
	 Jci/3gFzWMbAl8BYK2UXgcDqWnaNnfMT8tAwPZYRfdIA9f97QE1Jiax65zObSJQydL
	 dlBbrEuepCNoPsQQOKRtodcuQSmh8bM9jgfjfN84XunQqtIuWHO2pvKDK4ms774dBY
	 Afme6Vw4r2k1YttyikrxXJEH8Py0ukj+RK9lrAmkGgTLVaE8Qiw1ryQQ4vyylzm1AD
	 o1X2JYghVsfyw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 239/314] can: bcm: fix locking for bcm_op runtime updates
Date: Tue, 10 Mar 2026 07:18:18 -0400
Message-ID: <ee4627bdebaac2179b809478ff8a710df26b8dde.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D1C0A24B701
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-224418-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,5b11eccc403dd1cea9f8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,pengutronix.de:email,hartkopp.net:email]
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

[ Upstream commit c35636e91e392e1540949bbc67932167cb48bc3a ]

Commit c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
added a locking for some variables that can be modified at runtime when
updating the sending bcm_op with a new TX_SETUP command in bcm_tx_setup().

Usually the RX_SETUP only handles and filters incoming traffic with one
exception: When the RX_RTR_FRAME flag is set a predefined CAN frame is
sent when a specific RTR frame is received. Therefore the rx bcm_op uses
bcm_can_tx() which uses the bcm_tx_lock that was only initialized in
bcm_tx_setup(). Add the missing spin_lock_init() when allocating the
bcm_op in bcm_rx_setup() to handle the RTR case properly.

Fixes: c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
Reported-by: syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/699466e4.a70a0220.2c38d7.00ff.GAE@google.com/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260218-bcm_spin_lock_init-v1-1-592634c8a5b5@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 5e690a2377e48..756acfd20c6c2 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1170,6 +1170,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (!op)
 			return -ENOMEM;
 
+		spin_lock_init(&op->bcm_tx_lock);
 		op->can_id = msg_head->can_id;
 		op->nframes = msg_head->nframes;
 		op->cfsiz = CFSIZ(msg_head->flags);
-- 
2.51.0


