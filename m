Return-Path: <stable+bounces-251797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHlWJKYeDmro6AUAu9opvQ
	(envelope-from <stable+bounces-251797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:50:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E8559A2F8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0295C3764DB0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9083ED3A4;
	Wed, 20 May 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="neMv8xWl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848E36D9EA;
	Wed, 20 May 2026 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298915; cv=none; b=TDC2TwzqwYl6eq24OCru2gl9AXZlpCXPMhe4CWekm+3on+goGnqLWr266jw7XPM0070Cau9iz/OE8/O7Y5xAVUM1diz3y6U165XWDVJKa9IgCv0fAlZvgcXBzGTkQYyPKnjrNgQt7rdFa5NxKeNjnxEIcjAuW4uoRYB4vuW5ZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298915; c=relaxed/simple;
	bh=zDj+QGL2L1bsoWuF3bo/rW+59LImxsDb84d94NNSXZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DloNnlQ7xWlI+3gc2qXtavD1uVflNLVAV6VMEcLcuxSiBJiPAxWq1PQoWHnc45ICNfYeEnZ7SjeqUgVnBQw9Kp4ZSEpwMXjRXRok7D7nDTrcD/kDZl14T6IZGnRbNpR86lK7J1zi+5yQq6UnTuhj4Z79Y4Fhjc2n0YaJKMmytmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=neMv8xWl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0166F1F000E9;
	Wed, 20 May 2026 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298914;
	bh=gQ7BEp9TkisrUWuL/625XE/47YUd/BxkXw0OWg0HUHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=neMv8xWlnPkS3C3ImGu2mSVfwng883kyNYYnMigYOBptzDiruZh+7BSLZVfzCYTAQ
	 xmwOHpuSNX/mx3S0VNXnFhrhhsYpyAJH7XxScLEY5lt3EZYljF6QLEMZyJGv60Tbrj
	 37etkXFXng8HaDAfj9HDaZhzV0O2hFVqvggoY+w8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sami Mujawar <sami.mujawar@arm.com>,
	Jagdish Gediya <Jagdish.Gediya@arm.com>,
	Steven Price <steven.price@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 592/957] virt: arm-cca-guest: fix error check for RSI_INCOMPLETE
Date: Wed, 20 May 2026 18:17:55 +0200
Message-ID: <20260520162147.368417446@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251797-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E7E8559A2F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sami Mujawar <sami.mujawar@arm.com>

[ Upstream commit e534e9d13d0b7bdbb2cccdace7b96b769a10540e ]

The RSI interface can return RSI_INCOMPLETE when a report spans
multiple granules. This is an expected condition and should not be
treated as a fatal error.

Currently, arm_cca_report_new() checks for `info.result != RSI_SUCCESS`
and bails out, which incorrectly flags RSI_INCOMPLETE as a failure.
Fix the check to only break out on results other than RSI_SUCCESS or
RSI_INCOMPLETE.

This ensures partial reports are handled correctly and avoids spurious
-ENXIO errors when generating attestation reports.

Fixes: 7999edc484ca ("virt: arm-cca-guest: TSM_REPORT support for realms")
Signed-off-by: Sami Mujawar <sami.mujawar@arm.com>
Reported-by: Jagdish Gediya <Jagdish.Gediya@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
index 0c9ea24a200c9..66d00b6ceb789 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
@@ -157,7 +157,8 @@ static int arm_cca_report_new(struct tsm_report *report, void *data)
 		} while (info.result == RSI_INCOMPLETE &&
 			 info.offset < RSI_GRANULE_SIZE);
 
-		if (info.result != RSI_SUCCESS) {
+		/* Break out in case of failure */
+		if (info.result != RSI_SUCCESS && info.result != RSI_INCOMPLETE) {
 			ret = -ENXIO;
 			token_size = 0;
 			goto exit_free_granule_page;
-- 
2.53.0




