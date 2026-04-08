Return-Path: <stable+bounces-234984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP5uLl+p1mlKHAgAu9opvQ
	(envelope-from <stable+bounces-234984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:15:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DED3C2A68
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C3B830F7F38
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2460838736D;
	Wed,  8 Apr 2026 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j5CY2tRn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB29C34B19F;
	Wed,  8 Apr 2026 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674270; cv=none; b=NsilKwxTsAf/kRe7P5pLfcb7Pr9LXWHV76/X/g0OHtA4bbU7m5Gsp9MTyNDXpoD3s1isP/4XIlN1FaaWOUa/nJRVtxqUdF4bAl62fCAscRVy78ua0gGuwvxNqYr66UOPM9uaNUhh1q3/2zBjLDj4ZnWQVNUjN7vA7kxBRIaZbyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674270; c=relaxed/simple;
	bh=nH0XVTqeSA57cor7xfy10mY6wsMko0aqPQNESwqDQyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHG2NWjj644Nnfi1cHUq4YbDe8tvmLr5neIyiejKXzui+dLD9g9vhzbfKPjAnR15mmvYKG4VQQBmjp4iwVXj6xWlHbqv+L6nziv2l+00a3iQgb0hKWJTjRiSQjI6gaQbJqzhx1xrd0bwIyQphTkvpJzw5LqpCFU7qK8m1jrpgv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j5CY2tRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1920CC19421;
	Wed,  8 Apr 2026 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674270;
	bh=nH0XVTqeSA57cor7xfy10mY6wsMko0aqPQNESwqDQyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5CY2tRnU852yX+9O1Lh20N16rACRk6s5T4yQII5t7yfkzps3Za4f12EZ6uWhNF7n
	 sUqMDGQQeYJAk3v8Z7DAPYyiULTDGzwZEPc72h6EcRYiKElddP7o2bfKV2PWFG7Nu2
	 1eY3d/WShMQ5ub9cgzFaZscj/yDyGcvCwRAYyOTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 004/311] scsi: target: file: Use kzalloc_flex for aio_cmd
Date: Wed,  8 Apr 2026 20:00:04 +0200
Message-ID: <20260408175939.567077822@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234984-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,oracle.com:email]
X-Rspamd-Queue-Id: 11DED3C2A68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/target_core_file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -276,7 +276,7 @@ fd_execute_rw_aio(struct se_cmd *cmd, st
 	ssize_t len = 0;
 	int ret = 0, i;
 
-	aio_cmd = kmalloc(struct_size(aio_cmd, bvecs, sgl_nents), GFP_KERNEL);
+	aio_cmd = kzalloc(struct_size(aio_cmd, bvecs, sgl_nents), GFP_KERNEL);
 	if (!aio_cmd)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 



