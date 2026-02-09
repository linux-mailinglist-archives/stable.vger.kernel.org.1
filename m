Return-Path: <stable+bounces-215466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A2rDYv4iWn5FAAAu9opvQ
	(envelope-from <stable+bounces-215466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:08:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 989931119C1
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36443305AA93
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE69037BE7F;
	Mon,  9 Feb 2026 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="urF+MjdP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346428312F;
	Mon,  9 Feb 2026 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648886; cv=none; b=pE+3pRgEP7jHED82/IZFPrzWILvgK9UfGfu5jkn7fOn4oZT462kawbNngTdVg/vwmey0LRcz8of/Jbj2ds5TUoA16TCgrnI0PB1aQ7w49u4ScWXSkgIT4nupihSG8yzmdi2fbEOxGmrg9TLNHQMMUPx/hQspKso/Tc5pbS+8Ey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648886; c=relaxed/simple;
	bh=X0qpP40U0Ahb1+kTxIbYuD8P5mRh34l8TYmUJnHLfVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9xi7yXw3LoEcvnnHE0sspU2jvKwdrraRGboAQ2rqy4vOlsT9UsOt1LChxH9uhvpmh2wlOrxCDcxhQXMapAAnT6jp705vZ63eiT0M39Z9oYrpgJAdKZfDQhXDeTttSV4gFp7PIQ+PhnR2FgpFUVOL2cOLAhSOsSJDmrt+Wh9Koo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=urF+MjdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028FAC116C6;
	Mon,  9 Feb 2026 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648886;
	bh=X0qpP40U0Ahb1+kTxIbYuD8P5mRh34l8TYmUJnHLfVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urF+MjdPo5vevtQmRZl2zIrB+oNlUaUzH+0PaMD+VPElSZlngBmiE72H2IEPa10MC
	 ldh4z6wIgg/jFyZN87qvp9pj8bBiYKjp6neOUVMGUgvCCgsbzxiPWgw1SqkBj1+KAq
	 +jD4ZzUVMLdMfYM0sB8EL/5fHpI5MzsuLjFUECck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 44/75] platform/x86: toshiba_haps: Fix memory leaks in add/remove routines
Date: Mon,  9 Feb 2026 15:24:41 +0100
Message-ID: <20260209142303.431977231@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215466-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 989931119C1
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 128497456756e1b952bd5a912cd073836465109d ]

toshiba_haps_add() leaks the haps object allocated by it if it returns
an error after allocating that object successfully.

toshiba_haps_remove() does not free the object pointed to by
toshiba_haps before clearing that pointer, so it becomes unreachable
allocated memory.

Address these memory leaks by using devm_kzalloc() for allocating
the memory in question.

Fixes: 23d0ba0c908a ("platform/x86: Toshiba HDD Active Protection Sensor")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/toshiba_haps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_haps.c b/drivers/platform/x86/toshiba_haps.c
index 49e84095bb010..8a53f6119fed1 100644
--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -185,7 +185,7 @@ static int toshiba_haps_add(struct acpi_device *acpi_dev)
 
 	pr_info("Toshiba HDD Active Protection Sensor device\n");
 
-	haps = kzalloc(sizeof(struct toshiba_haps_dev), GFP_KERNEL);
+	haps = devm_kzalloc(&acpi_dev->dev, sizeof(*haps), GFP_KERNEL);
 	if (!haps)
 		return -ENOMEM;
 
-- 
2.51.0




