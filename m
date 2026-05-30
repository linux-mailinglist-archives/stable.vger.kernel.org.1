Return-Path: <stable+bounces-257597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNxUOpIcG2qQ/QgAu9opvQ
	(envelope-from <stable+bounces-257597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:21:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A51B260F78C
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9EED301AFD7
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B0E3161A3;
	Sat, 30 May 2026 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="heeufks/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D21C5799;
	Sat, 30 May 2026 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161533; cv=none; b=DHshEA+BhjlAd1GYMO04iwDkRm05HHmNddHhZkVOEB59Gd2jzZ5i637SsZctYZwx5A6gu1z/Oq/0pD2kx89/VFheULn3CbjAOp1UTJ22n2rRG8qPHyE2V843c7vvPVGno02NiWVXjIfo3h22qyhOuzq2Nw9VvI5wt7pAkkiUBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161533; c=relaxed/simple;
	bh=rlCAgrTOLMVnzlK5JyPoiMVQPBg1ETvHCpqtRiOfAkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuiSA4n3AdUIk44pmpo3oZBFNYt7zOPmjjR71Cr8dlGH3HMU1UZkuBmpCT4oDwPhukrnmvrDLwa0cPT1xSHf+APsM6uJchdAXyxm75qlF8SY/RbP4PtwYBj04X/9PkBV3b6VE79hJDBodORe+j3o5AQGx1zWQPExrIZ4JySS8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=heeufks/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC241F00893;
	Sat, 30 May 2026 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161532;
	bh=q4HdxyPg2jWYE9SG7NJgZLAZvxr+KozCWpThF1+x2Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=heeufks/tcELNsmJiV5IQ5CJ/yDFfajUyWz1R0c4m30DJ+ouDR8e/5TZV5/jwG9ql
	 LoxGp/5ZErFOzlBIWuB6QhsTJKiK112AJrkzUUJ0/vvAVnQxq+V1mDgSNn8CjSroHO
	 xUHYiUmOS28O6CV2y9BiKjqfnNYZHXoIM/dM/Cn4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 651/969] scsi: target: core: Fix integer overflow in UNMAP bounds check
Date: Sat, 30 May 2026 18:02:55 +0200
Message-ID: <20260530160318.444423122@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-257597-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,oracle.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A51B260F78C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 1e3216de1e04d..7b08743c4f3ff 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -1133,7 +1133,8 @@ sbc_execute_unmap(struct se_cmd *cmd)
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




