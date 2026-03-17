Return-Path: <stable+bounces-226244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IECDMNKGuWncJAIAu9opvQ
	(envelope-from <stable+bounces-226244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:52:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B92AE902
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0C7B3162EB2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD6A3ED5BD;
	Tue, 17 Mar 2026 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gji1QmpT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDD3E716B;
	Tue, 17 Mar 2026 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765876; cv=none; b=puIEZF0L9KQpcW1kO5zd7a2LlNxrq+SdS84bT6r2GfYvKc34DFNXqL168dzxzPW2ky8vLS41XTvqLXgPE5wAWHFRPrErdHJtQUwqhN9JGQyyUctZjpkhfmcPl0vt+xxuyRm40mKtcSE1kJI9W5wlLyncANoSgITTjK/2Er7OgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765876; c=relaxed/simple;
	bh=2sHMn0eqS6E0Ox7pbL9GsVNDDAN+5gu2R5dUwWSSnnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su1HTaUZkFwAKJolEOm49Zqxh26n7XBe14DzVni1LTCCWya1rxfZ8Pj/6Udu81YUhLDAAp4QiE9t0+PmDE4RjTbPPbJzdGy9aHnjXveIZPjTJHITbrYH34MVAaUHf2YxzDf0w0QKh49DSd+8b8N8aKtDWJGkoajXGrGXvFXcdYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gji1QmpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79335C4CEF7;
	Tue, 17 Mar 2026 16:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765876;
	bh=2sHMn0eqS6E0Ox7pbL9GsVNDDAN+5gu2R5dUwWSSnnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gji1QmpTWrL4mBVDhtPHP/m1wSzDc1L9X2aFdfiIt0tG060gZcnDLwvkxp2y0xv31
	 +EaqlrYuZJfvzcJFfkyqYZgA6KiBZL5I12CNnMgnFpwRlLZ4/l1m8f3AMCJivSv0mA
	 jWUeKqPWObKiE3AF+bNCovpn536feAo+Q0xAYYH0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Perry Yuan <perry.yuan@amd.com>,
	Yifan Zhang <yifan1.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Simon Liebold <simonlie@amazon.de>
Subject: [PATCH 6.19 114/378] drm/amdgpu: ensure no_hw_access is visible before MMIO
Date: Tue, 17 Mar 2026 17:31:11 +0100
Message-ID: <20260317163011.208625545@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226244-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,amd.com:email,amazon.de:email]
X-Rspamd-Queue-Id: 499B92AE902
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Perry Yuan <perry.yuan@amd.com>

commit 31b153315b8702d0249aa44d83d9fbf42c5c7a79 upstream.

Add a full memory barrier after clearing no_hw_access in
amdgpu_device_mode1_reset() so subsequent PCI state restore
access cannot observe stale state on other CPUs.

Fixes: 7edb503fe4b6 ("drm/amd/pm: Disable MMIO access during SMU Mode 1 reset")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Simon Liebold <simonlie@amazon.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5878,6 +5878,9 @@ int amdgpu_device_mode1_reset(struct amd
 	/* enable mmio access after mode 1 reset completed */
 	adev->no_hw_access = false;
 
+	/* ensure no_hw_access is updated before we access hw */
+	smp_mb();
+
 	amdgpu_device_load_pci_state(adev->pdev);
 	ret = amdgpu_psp_wait_for_bootloader(adev);
 	if (ret)



