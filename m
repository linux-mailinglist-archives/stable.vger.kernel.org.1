Return-Path: <stable+bounces-213818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGlLKWNlg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:27:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAFCE89AE
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C240300E38B
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92537426D19;
	Wed,  4 Feb 2026 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2q2BplZZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F44426D06;
	Wed,  4 Feb 2026 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217613; cv=none; b=GairdApBkUpANkNVL5ueZpQPHGxR7VNzdifzZKxX9MjHH6UINR6wHplayOzeJqqkZhhOzCm3RmNe9K0iysGVlDMrEf86v2zMc5Rt8HWnyAyyD6GUYhen4LJtt9cYKh7wuaHT+55FMT5YMSK9j6wwkbOVV6TckrkVponnkUqGEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217613; c=relaxed/simple;
	bh=IjfQHoHAi27OTaUE3XW5arnsAj3qBF0RFFPmqcZ4/3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcgKHhZR/1+aykhuWr5gaIq18NaDPoYZgY/MrYvLdJi73R+nnFbrS68UHI5wumSCk8S5anicnrIwSZ8r1FEjpqPqvB//BlJtshyot8hp4VLTRtNFzL6j/LfZ85o9pA6Uba9mSB87hEw4tBaplleElizhF0M0NQyWNh5C6xlkBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2q2BplZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A00C4CEF7;
	Wed,  4 Feb 2026 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217613;
	bh=IjfQHoHAi27OTaUE3XW5arnsAj3qBF0RFFPmqcZ4/3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2q2BplZZbpKrywepVOnuki8SuoWt81fLKU1+6R7/fk4DAj0XlfTEcun3x0rHkvFiW
	 NsndkICj43w3dILsi2CnC3Ts4z5NW2tQeo2NCUeEJKNuLkTFAClZertvfELTC8Z7fr
	 5hBkhCESyQZE0i7Kds2aVpt+F/FLavAR99/C5Gak=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.1 068/280] dmaengine: bcm-sba-raid: fix device leak on probe
Date: Wed,  4 Feb 2026 15:37:22 +0100
Message-ID: <20260204143912.102189395@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-213818-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 3BAFCE89AE
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1697,7 +1697,7 @@ static int sba_probe(struct platform_dev
 	/* Prealloc channel resource */
 	ret = sba_prealloc_channel_resources(sba);
 	if (ret)
-		goto fail_free_mchan;
+		goto fail_put_mbox;
 
 	/* Check availability of debugfs */
 	if (!debugfs_initialized())
@@ -1727,6 +1727,8 @@ skip_debugfs:
 fail_free_resources:
 	debugfs_remove_recursive(sba->root);
 	sba_freeup_channel_resources(sba);
+fail_put_mbox:
+	put_device(sba->mbox_dev);
 fail_free_mchan:
 	mbox_free_channel(sba->mchan);
 	return ret;
@@ -1742,6 +1744,8 @@ static int sba_remove(struct platform_de
 
 	sba_freeup_channel_resources(sba);
 
+	put_device(sba->mbox_dev);
+
 	mbox_free_channel(sba->mchan);
 
 	return 0;



