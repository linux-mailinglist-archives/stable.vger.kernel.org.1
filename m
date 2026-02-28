Return-Path: <stable+bounces-220836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME+rKhdXo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:59:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1222B1C8AB0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA86C375C2D9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E5141561A;
	Sat, 28 Feb 2026 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtX0AZHA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA334170D9;
	Sat, 28 Feb 2026 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300721; cv=none; b=oplmDerof80ZJfuSl8JJ8WhY7sNv4XT2FSorI7IWnVu/bb23RcGTIpfv1cND3etsNeaVfZKtSAjm74uigdtGDNHLBbDw4QS3/M/uzIvdHtCHjOLSbm1W929EbGNAlV+z5JRjTMxm4c82H/fG232wkteGFUQYE6WhwRI9M1bsadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300721; c=relaxed/simple;
	bh=P43d+N4IGQbeLEG01p/BGme6501S6Qrro9wO6gciA7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QywR3fcu0SP6fUaMJb7x6d5seKBOPGu/jVz8tn/2LpZ1BMQx0Gl/mkLpNHlW+DkQgoPOnurrsQ2E6fvhcBMk56Ws0QXhkD8zohhpQz1ObCt2e4XVNKBFGI2t/hT9l98HnL6NUhp296CWDZXWUd9d+Evab3coe0AqtPYROYFF44M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtX0AZHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7185C116D0;
	Sat, 28 Feb 2026 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300721;
	bh=P43d+N4IGQbeLEG01p/BGme6501S6Qrro9wO6gciA7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtX0AZHAMCmVhihTiOCnQzvh/0rZF4YiTQ62HaFP1viWcjObiarOBlc3M5QBSmpM4
	 yPxlv6Iq0CsalOizq/9YmOMa/7haHjcyJZ+C/gVmaLij8ZK1RnzWiZTiq1mGjzWNt1
	 Fptuvy/lqE9dawo7//fZLrZh176+hIMZIj45cy3zkiSjbD8A6WiB4D7sgYQxJQ5svG
	 0rIleCjF7wfwNZRw1LVUkJBUt+EhSNxZ2zZYXe//FJMW80xjFyq+c8+yk6+TAhn63l
	 nnoFFuVEBy7h5mzfjxrPyfAOhx159oUwxBkLq8AYFzS1bPwGmDMWGK+LnUS7ivqvgl
	 I3HNe13OmNjmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 757/844] parisc: kernel: replace kfree() with put_device() in create_tree_node()
Date: Sat, 28 Feb 2026 12:31:10 -0500
Message-ID: <20260228173244.1509663-758-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[isrc.iscas.ac.cn,gmx.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220836-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 1222B1C8AB0
X-Rspamd-Action: no action

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

[ Upstream commit dcf69599c47f29ce0a99117eb3f9ddcd2c4e78b6 ]

If device_register() fails, put_device() is the correct way to
drop the device reference.

Found by code review.

Fixes: 1070c9655b90 ("[PA-RISC] Fix must_check warnings in drivers.c")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/drivers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index 8d23fe42b0cee..809e3c171ad54 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -435,7 +435,7 @@ static struct parisc_device * __init create_tree_node(char id,
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.coherent_dma_mask = dev->dma_mask;
 	if (device_register(&dev->dev)) {
-		kfree(dev);
+		put_device(&dev->dev);
 		return NULL;
 	}
 
-- 
2.51.0


