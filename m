Return-Path: <stable+bounces-210909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEMFF5MjcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-210909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:05:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B757A5BCE0
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABB247CFE06
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC361366565;
	Wed, 21 Jan 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+P20u1v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD743A4AD4;
	Wed, 21 Jan 2026 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019793; cv=none; b=lOCCIoP2yByze7h4hS/JJjIJ1125uhoNhV0JeQgA3a5ricoS8iE3KLa44v2itXOYqIG7trYdAt4pPYwDo3hOs7ZRROOGHtLx2i2k/+sgRyf2QetCjyhI3cJhj4Eg35Yh5x2jWg29yXt3mtn/yNfPQZMDEWrwPy6QfwiUuM5Kclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019793; c=relaxed/simple;
	bh=5DGjm0B6Q3M7UqmlB+pNxDsFWUKxHEUgrngDOOhqMHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCWVFHBBZL5aeSqZxDcA5cjLPVqsRXmBn841TCtR5h8oy6P4Xn93cu/8Q3tCrx8thKqmZWEyktjP/tp56ag3AqJMBA7zztQpqiEFw3NM/QOBiCNdapnS0E5X3XSBGlH/e5PHvQOPYHWDhIKn0YgbuAMnWpxTEX97/RpTGXK+NtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+P20u1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52A9C4CEF1;
	Wed, 21 Jan 2026 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019792;
	bh=5DGjm0B6Q3M7UqmlB+pNxDsFWUKxHEUgrngDOOhqMHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+P20u1vWHRYf95avQ9TW3uhoHG+BqmxUbf7RHguYyrEGKstSRSvRaWIS7e4jrxrU
	 shbC3j8/mAOCynN3R6C9czO9UWoO+coF1afsppVSoC1J0O8RcnDvQAVBdWJ50QdwvX
	 1+/nPZNPI3ioFyzd8hegPRUFGyYN2dO5LpOPb4KY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.12 110/139] dmaengine: bcm-sba-raid: fix device leak on probe
Date: Wed, 21 Jan 2026 19:15:58 +0100
Message-ID: <20260121181415.406562802@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210909-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B757A5BCE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 7c3a46ebf15a9796b763a54272407fdbf945bed8 upstream.

Make sure to drop the reference taken when looking up the mailbox device
during probe on probe failures and on driver unbind.

Fixes: 743e1c8ffe4e ("dmaengine: Add Broadcom SBA RAID driver")
Cc: stable@vger.kernel.org	# 4.13
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251117161258.10679-4-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/bcm-sba-raid.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -1699,7 +1699,7 @@ static int sba_probe(struct platform_dev
 	/* Prealloc channel resource */
 	ret = sba_prealloc_channel_resources(sba);
 	if (ret)
-		goto fail_free_mchan;
+		goto fail_put_mbox;
 
 	/* Check availability of debugfs */
 	if (!debugfs_initialized())
@@ -1729,6 +1729,8 @@ skip_debugfs:
 fail_free_resources:
 	debugfs_remove_recursive(sba->root);
 	sba_freeup_channel_resources(sba);
+fail_put_mbox:
+	put_device(sba->mbox_dev);
 fail_free_mchan:
 	mbox_free_channel(sba->mchan);
 	return ret;
@@ -1744,6 +1746,8 @@ static void sba_remove(struct platform_d
 
 	sba_freeup_channel_resources(sba);
 
+	put_device(sba->mbox_dev);
+
 	mbox_free_channel(sba->mchan);
 }
 



