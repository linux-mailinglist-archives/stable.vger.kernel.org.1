Return-Path: <stable+bounces-220406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPU8OH1Io2mm/AQAu9opvQ
	(envelope-from <stable+bounces-220406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:56:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE191C7990
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EAFB31314E1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E173AE0F6;
	Sat, 28 Feb 2026 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhvssaVk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45E3AE0ED;
	Sat, 28 Feb 2026 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300297; cv=none; b=tHO4YbjqbtWSgvRTQM2smvp/nes3wUt78xU4BEi7GaMjbYo60eYx/hjJNzqF4avxx6XRGwq/zKBtu4ii9QGWViM6ZIvqFF2ADKN0vJirk9gCyhvI/LmKVLzqGW6JY+CmAUL17LY5a1IeQy4VffyBKH/Y877hIOjQt/I4P+vVXlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300297; c=relaxed/simple;
	bh=F8Ybvyi6GeD2bc1+/+CcnyLiv8/CjxRPhCgmqh0qwCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVlyBsdkMbwsxhwb2pz0u46D4gfy5XhxBAei3yURKMcKz/v357w44MRUDdZuwUZPkJEiSsNIJS5a7cQXXlz3g0v6AgnVknGX0eIqv5WEv6dWVlqs3d62HF8gxkH52LeoTm7BxmJZOlb4meclhy5+a13Fyh/L5LXedHlYNpkKNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhvssaVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41C7C2BC9E;
	Sat, 28 Feb 2026 17:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300297;
	bh=F8Ybvyi6GeD2bc1+/+CcnyLiv8/CjxRPhCgmqh0qwCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhvssaVkSq6cmcrVk5D/2JjJgdUSzVJhrx8MfS50PqTIMF0xxuKxnlZCQRzXn+7tT
	 PmubXykSLaq1ugU+8qXx30LyuCnpJHuouT9nuN8XFhsWeK5tiJhK4upLclqChdJj++
	 EimfOymextc33t1XtuMtWNu6Boon5ObNAgqpImav1/dr4g5tJGPSNgw0VOWVMo8dZx
	 p2eQbB7w58NZSzoy9biJH4mT/FVdkgQPDStXT0E+2sr/JUoYSmXsNopPmYHf1mLpqM
	 lOBpdWpse0VbJB/JdsMKfQ8n17SBMW9lYZNeHayAgPC4ow90vaBX9IH9UiCzyapckc
	 ezcFC1DBVSLlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
	Babis Chalios <bchalios@amazon.es>,
	Takahiro Itazuri <itazur@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 327/844] ptp: ptp_vmclock: add 'VMCLOCK' to ACPI device match
Date: Sat, 28 Feb 2026 12:24:00 -0500
Message-ID: <20260228173244.1509663-328-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220406-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amazon.es:email]
X-Rspamd-Queue-Id: 0EE191C7990
X-Rspamd-Action: no action

From: David Woodhouse <dwmw@amazon.co.uk>

[ Upstream commit ed4d23ed469ca14d47670c0384f6ae6c4ff060a5 ]

As we finalised the spec, we spotted that vmgenid actually says that the
_HID is supposed to be hypervisor-specific. Although in the 13 years
since the original vmgenid doc was published, nobody seems to have cared
about using _HID to distinguish between implementations on different
hypervisors, and we only ever use the _CID.

For consistency, match the _CID of "VMCLOCK" too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
Tested-by: Takahiro Itazuri <itazur@amazon.com>
Link: https://patch.msgid.link/20260130173704.12575-6-itazur@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_vmclock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index b3a83b03d9c14..cbbfc494680c7 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -591,6 +591,7 @@ static int vmclock_probe(struct platform_device *pdev)
 
 static const struct acpi_device_id vmclock_acpi_ids[] = {
 	{ "AMZNC10C", 0 },
+	{ "VMCLOCK", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, vmclock_acpi_ids);
-- 
2.51.0


