Return-Path: <stable+bounces-231445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDnqCermy2myMQYAu9opvQ
	(envelope-from <stable+bounces-231445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:23:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF1D36B96A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E0F730408CA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05118402432;
	Tue, 31 Mar 2026 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgBJOLE6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABED370D57
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970477; cv=none; b=UkBjvtpjTBANWQC75wIZ9stAs83OLRxnGGMxSVRk8Wq1nCjPSTb4Pp9HULsH9cuCb6PrZOkPhd+fFnUj+latDdOM6JcCBkr3qA0X6+e8qlWypcj4lI9mQps3LYZvMSSWsoph5/JwzahdgLqQa82SmxaaaqZ0YdU5+kF1peZVds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970477; c=relaxed/simple;
	bh=1PUddfYyThKphDIYWDEizD0bRwLsDKWCRVc4PTahABc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lii4aAmpY/03E+Yb5mh+yG6+0mMS8lQ0n6l+Krz7v3JQOMzzhKpkYH50pcTzFsNSsOvDthjNSlzNmVazurljyPlSjvAkv/NC8n9vpl/vLIB5HfXKYn2ZJoA1N0JnupgAx63NM1TssGwkuuGMR6zTpFDb93KZJJl8iARMArgG76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgBJOLE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBA1C19423;
	Tue, 31 Mar 2026 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774970477;
	bh=1PUddfYyThKphDIYWDEizD0bRwLsDKWCRVc4PTahABc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgBJOLE6e8AQntc1mj2+brj6gNkpR2VPLx3IzlIvxDWfcP5re7VQRrN4bUgAkZJQL
	 Vu7QTimc6eVqi7axA6SAthtyzy9YCG6b2cl5MAA7UpGSZexlgvg9xmI/R7/Asv4lm4
	 xsjHgNo99ORHfkVJJjWLCkIxeskzf9d2y4RWYlhQZF8PuUl4GO7WNQWoR2Gfzihuvv
	 Tl94WEmTkLZJr7f+wDR2MFX69cAh9SzzndRibLW9Xd9ew4PZknoAgixILfSecrl459
	 wPldDr3ZngJgJnfkNCy5HGervVCzWhiFR4Rd57loFakyOQrlyS8GX4vYGyP8XXW3aR
	 J3Uqo86oFIEsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y] scsi: target: file: Use kzalloc_flex for aio_cmd
Date: Tue, 31 Mar 2026 11:21:15 -0400
Message-ID: <20260331152115.2613463-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033001-vertigo-outsider-f713@gregkh>
References: <2026033001-vertigo-outsider-f713@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231445-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,synopsys.com:email]
X-Rspamd-Queue-Id: 9CF1D36B96A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[ Upstream commit 01f784fc9d0ab2a6dac45ee443620e517cb2a19b ]

The target_core_file doesn't initialize the aio_cmd->iocb for the
ki_write_stream. When a write command fd_execute_rw_aio() is executed,
we may get a bogus ki_write_stream value, causing unintended write
failure status when checking iocb->ki_write_stream > max_write_streams
in the block device.

Let's just use kzalloc_flex when allocating the aio_cmd and let
ki_write_stream=0 to fix this issue.

Fixes: 732f25a2895a ("fs: add a write stream field to the kiocb")
Fixes: c27683da6406 ("block: expose write streams for block device nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/f1a2f81c62f043e31f80bb92d5f29893400c8ee2.1773450782.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[ changed kmalloc() to kzalloc() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index b2610073e8cca..26d52f1f36df6 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -276,7 +276,7 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 	ssize_t len = 0;
 	int ret = 0, i;
 
-	aio_cmd = kmalloc(struct_size(aio_cmd, bvecs, sgl_nents), GFP_KERNEL);
+	aio_cmd = kzalloc(struct_size(aio_cmd, bvecs, sgl_nents), GFP_KERNEL);
 	if (!aio_cmd)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 
-- 
2.53.0


