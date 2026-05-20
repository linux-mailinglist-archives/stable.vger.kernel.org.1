Return-Path: <stable+bounces-250336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPZpKD7mDWqm4gUAu9opvQ
	(envelope-from <stable+bounces-250336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E2759284B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7065230682D6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F84367B8D;
	Wed, 20 May 2026 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aK5VB5dc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CAF362139;
	Wed, 20 May 2026 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295147; cv=none; b=DWTbfsYbmdUU0ZgZL7lTxu8/aK9A/cmhXQAF9WJ6AK4V5smLS51pAGizGu4X3OKfcuNXb7cfRT2tf3opgTVKW0saO6S8kGDiQgZdn5WI4fUzWdHTZYsQid5xaxBusCUabmmo9njuTR75D7/IxW/T+clXKSgbNnAhU0ohsGT5d3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295147; c=relaxed/simple;
	bh=Yn3QM6vS4lhc5WE5FQHN6E+RB3cAIX9hLRPjGq92dAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrLQYLjJDUWahzG5zv5TITQ8Q+pgCgDUeknVP7Hi7KKcBpPilMxFHk6l4brBXhLuHMrYUTJknc1tUhPilbze/J7WvaFEzPLhSEXYqYTLVhv7vbrn9i+YzihcBOblzhbitNVgZmOYy76McXEHiHH+CfYDwWy0nqiKsQvpwH7nYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aK5VB5dc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8071F000E9;
	Wed, 20 May 2026 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295145;
	bh=KzpV77TXBhRIz60IffAQ90BFOw5gYMPGXQsikKr4P3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aK5VB5dcnCNH2pTxMMNyH59m8K0zwEgWFt49J1qZDz2DbRtfO4xO8IzvMDspcDqYz
	 NdgCHAS8xolI4IlO9Lgh0u9gCKK8Ls3vhFDisyQgo7QJXwaA3zqAxpVH6QOQrB2rgk
	 8G7GEdfD7gbRAL9dD1MC8ATtk5a7YNbVB1WZ1myQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"haoyu.lu" <hechushiguitu666@gmail.com>,
	"Lizhi.hou" <lizhi.hou@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0309/1146] accel/amdxdna: fix missing newline in pr_err message
Date: Wed, 20 May 2026 18:09:19 +0200
Message-ID: <20260520162155.197206873@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250336-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,haoyu.lu:url]
X-Rspamd-Queue-Id: 47E2759284B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: haoyu.lu <hechushiguitu666@gmail.com>

[ Upstream commit d1c73884858cb3ce2a0f761988a6f279bff32b91 ]

Add missing newline to pr_err message in amdxdna_mailbox.c.

Fixes: b87f920b9344 ("accel/amdxdna: Support hardware mailbox")
Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>
Reviewed-by: Lizhi.hou <lizhi.hou@amd.com>
Signed-off-by: Lizhi.hou <lizhi.hou@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260323034933.216-1-hechushiguitu666@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/amdxdna_mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 46d844a73a948..e681a090752df 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -499,7 +499,7 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
 	int ret;
 
 	if (!is_power_of_2(x2i->rb_size) || !is_power_of_2(i2x->rb_size)) {
-		pr_err("Ring buf size must be power of 2");
+		pr_err("Ring buf size must be power of 2\n");
 		return -EINVAL;
 	}
 
-- 
2.53.0




