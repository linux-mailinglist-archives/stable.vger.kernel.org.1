Return-Path: <stable+bounces-231448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COVNOD7py2myMQYAu9opvQ
	(envelope-from <stable+bounces-231448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:33:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E01D36BC09
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16D553051C49
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D92E3E3DA8;
	Tue, 31 Mar 2026 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld+5Bw9Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EEE3D4120
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970952; cv=none; b=HVagY0t2AlydaDDsDnKpCypiwOmvEUDfPBONyLjH4Y+OdihF0Uo9bXApR3MxugjIpVnFfRgqlywnMfsq+SXR4VRIkykO61LpHzYXGwiP1mMq/OgjMojCgqSIQz0twJHACV22reSD+xaKseXrc5qmp5florQbcUVKd4uKwVrriww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970952; c=relaxed/simple;
	bh=VxwQevdy9D5PCV8yzTvaJ4PSLq05LNZx6F5AXUigaZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeWEuKqS4JY6yVSdF4ez8kTDuqaSeDhp6J7HYgokRpKfIHCXH28/FQdz8Br7U/ZG2dDIPNctz2lnAybFBu/Cm6OkC7bCEQd9p5jNCpIyEBgpafldkIvK0+KeM3NIXEBKnzry7hTZlkXTllRVL/NcbRSGHGXo1G4hAN9TN/vszK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld+5Bw9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2227C19423;
	Tue, 31 Mar 2026 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774970952;
	bh=VxwQevdy9D5PCV8yzTvaJ4PSLq05LNZx6F5AXUigaZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ld+5Bw9Yg4e3J/P6rIyqtjXqx5piUrz2B5ZjwFrPeqA6fjDiC25efkvwgsAaKFZUT
	 /Hr5Occn6AByG0Gcqn+18Dwx3V8V3kXYwHViRojJm8Z11AwkLkSASVVEFrRB18qYU0
	 d2CH5R5yHbqpcX0mdgEXZkNDP5qB5qJc8y+xP4gMC6wI0ek/Zu3zevym7hpLrvpEmt
	 6phZP5TJ51uAG8Fz2VtWYGtJ9X9K62q8GiHl73KMVONezUDZO1yuDFYq/aZSAxcCzz
	 kHoxcSSk500QH0I77briAqtTI9tiB5UklTOYWBRJ6GHSJlnsz8Dxg1d41BVojTZOdo
	 RPfp/qKVS3A9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] scsi: target: file: Use kzalloc_flex for aio_cmd
Date: Tue, 31 Mar 2026 11:29:10 -0400
Message-ID: <20260331152910.2628504-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033002-suave-karma-46c8@gregkh>
References: <2026033002-suave-karma-46c8@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231448-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,synopsys.com:email]
X-Rspamd-Queue-Id: 8E01D36BC09
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
index 2d78ef74633c8..80d0fc2a98067 100644
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


