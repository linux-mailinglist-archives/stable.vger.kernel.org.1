Return-Path: <stable+bounces-243574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HEDAbys+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:27:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AD04BF738
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82FFD30F05F0
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BAF21C173;
	Mon,  4 May 2026 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="15SdnXQu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708E315785;
	Mon,  4 May 2026 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904234; cv=none; b=LYYpgsi8x1yyA1OYjfHcPtZAk6ql4n/Numk3uAod1Ouv0KuPjp4ydEE+uAFU9BbVYXBA/Y6eu6KX0QaVMBBNyCjFM+RJwcT0GSD8Db0RLXT4iC/M4NEJMqC+GHNhdhA8tmAefdQ8hfobGbHU+1YpuMxR1VPV2BcgPU7w9Od+xXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904234; c=relaxed/simple;
	bh=p3ea+28DrWIs5IIvhBPPw3Jum0/4H5FqiPf1frCUE+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkFD4+8Ex4xzVEQk/Pejp94gr9Nc+1DmvtwyqCpEQUKMPwnwyxyitM1jsKRdL7+F/BdPN1slXTWEGOQ3QHnflAkSgJOr4kv9dnjLumQa4VHBtQ7oEJkeVDGmDe092oIWl4Ud75CC4SEjHc/uTZMqAeF/bo55KBljLAlVe733+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=15SdnXQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEBFC2BCB8;
	Mon,  4 May 2026 14:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904234;
	bh=p3ea+28DrWIs5IIvhBPPw3Jum0/4H5FqiPf1frCUE+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=15SdnXQu/wGcV3kFYD6G6v1XnihmWeg1B0iuvHJj8Uvl4zXqZGh88Rc7oN90teEN0
	 6IuayYomZpLKXpLqgX/n3mHRLxd0tnOa42Dec7F9x/CFnGsHq16SoSTyaypdikDFW6
	 iVUz5rPr0iS3FgwKknLA44+M1dEU/cgWbCCSclcA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai@fnnas.com>
Subject: [PATCH 6.18 202/275] md/md-llbitmap: skip reading rdevs that are not in_sync
Date: Mon,  4 May 2026 15:52:22 +0200
Message-ID: <20260504135150.578091680@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 79AD04BF738
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243574-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fnnas.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai@fnnas.com>

commit 7701e68b5072faa03a8f30b4081dc16df9092381 upstream.

When reading bitmap pages from member disks, the code iterates through
all rdevs and attempts to read from the first available one. However,
it only checks for raid_disk assignment and Faulty flag, missing the
In_sync flag check.

This can cause bitmap data to be read from spare disks that are still
being rebuilt and don't have valid bitmap information yet. Reading
stale or uninitialized bitmap data from such disks can lead to
incorrect dirty bit tracking, potentially causing data corruption
during recovery or normal operation.

Add the In_sync flag check to ensure bitmap pages are only read from
fully synchronized member disks that have valid bitmap data.

Cc: stable@vger.kernel.org
Fixes: 5ab829f1971d ("md/md-llbitmap: introduce new lockless bitmap")
Link: https://lore.kernel.org/linux-raid/20260223024038.3084853-2-yukuai@fnnas.com
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md-llbitmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md-llbitmap.c b/drivers/md/md-llbitmap.c
index bf398d7476b3..6b2d27de1528 100644
--- a/drivers/md/md-llbitmap.c
+++ b/drivers/md/md-llbitmap.c
@@ -459,7 +459,8 @@ static struct page *llbitmap_read_page(struct llbitmap *llbitmap, int idx)
 	rdev_for_each(rdev, mddev) {
 		sector_t sector;
 
-		if (rdev->raid_disk < 0 || test_bit(Faulty, &rdev->flags))
+		if (rdev->raid_disk < 0 || test_bit(Faulty, &rdev->flags) ||
+		    !test_bit(In_sync, &rdev->flags))
 			continue;
 
 		sector = mddev->bitmap_info.offset +
-- 
2.54.0




