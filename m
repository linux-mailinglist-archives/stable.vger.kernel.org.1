Return-Path: <stable+bounces-252579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCDyADH8DWoK5QUAu9opvQ
	(envelope-from <stable+bounces-252579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:23:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79678596013
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1358F3156886
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D663368968;
	Wed, 20 May 2026 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ksgg1QYt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125E3C140F;
	Wed, 20 May 2026 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301044; cv=none; b=R/VHIMeoh6SftrQ0Az4qgTY2xCbEIH0D1q/acGLq0bKSO2UnIXDw2uZJx3o3/j+d2ZzobTgxIalGd1vfD3vImHxbETmDXEr3NXGv62Zy7MtSVX41Z2jN/D9h9iRLMXglhJpK6psHyzCJBV796yg2R1FJXdd17fCEZPVGLTXenYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301044; c=relaxed/simple;
	bh=D4sNK6DP9Gm577Kt7pRkT4T1S16a6JSqYi8VrLplYXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIpXLwr9I8P8T9cBTu/Gm3eTuJ7CCQ1JgepZqVKkEULPIq4OKl14yblnWrkwK1VVBjjo7I7bg4d0AyqUJyCsJIFq03GyloLBcFS7YtRb5T5sdz1Q3dNzivGnamZuxIxsxesRvV1gLn9scCu+K4zCFcN1+iOJL2RZVnypyhOklG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ksgg1QYt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CE61F000E9;
	Wed, 20 May 2026 18:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301043;
	bh=8u8laJqeGug8EsCjSjInXg4PmxtZPnBikfw91nY1U4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ksgg1QYtR2dzukeae93PVtjvnU7waJdKpxDpxzUnlrMLWI5tReP3PyzOLhxYh/Uw4
	 5bxwy3l8s25XDRw9x3Tyu0J/sy5VZKnq128pHm7gs40MXy9FGTbk8NQ7aDSza7FeGr
	 gqLjwdGa7bXUxuGotEfO3yR3iFlDGkqpNMTnZTEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 405/666] scsi: target: core: Fix integer overflow in UNMAP bounds check
Date: Wed, 20 May 2026 18:20:16 +0200
Message-ID: <20260520162120.039006559@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,oracle.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-252579-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 79678596013
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junrui Luo <moonafterrain@outlook.com>

[ Upstream commit 2bf2d65f76697820dbc4227d13866293576dd90a ]

sbc_execute_unmap() checks LBA + range does not exceed the device capacity,
but does not guard against LBA + range wrapping around on 64-bit overflow.

Add an overflow check matching the pattern already used for WRITE_SAME in
the same file.

Fixes: 86d7182985d2 ("target: Add sbc_execute_unmap() helper")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Link: https://patch.msgid.link/SYBPR01MB7881593C61AD52C69FBDB0BDAF7CA@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_sbc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index fe8beb7dbab12..4c828a3ac18c7 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -1136,7 +1136,8 @@ sbc_execute_unmap(struct se_cmd *cmd)
 			goto err;
 		}
 
-		if (lba + range > dev->transport->get_blocks(dev) + 1) {
+		if (lba + range < lba ||
+		    lba + range > dev->transport->get_blocks(dev) + 1) {
 			ret = TCM_ADDRESS_OUT_OF_RANGE;
 			goto err;
 		}
-- 
2.53.0




