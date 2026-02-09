Return-Path: <stable+bounces-215301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNDAKF72iWmuFAAAu9opvQ
	(envelope-from <stable+bounces-215301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:59:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE95111560
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E46A93090B32
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F51A28725B;
	Mon,  9 Feb 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sjT1S/aV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD025DB1C;
	Mon,  9 Feb 2026 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648347; cv=none; b=ejZLt0Vfec28oV2zsabHbB20usbKDty0Bmn8OD9tpaDp98tedku7ENE7F1p7wEOl6aTcm9puPnWS+9wMtY4FMpP2IHwSRvKgb+B3Yxnt8LJB76JyDhO+5fZKWtupubnUCgoguSq1eP9fv6SEqyrariBABMTmb7V9Zj9NN1xIDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648347; c=relaxed/simple;
	bh=N7AIYL8m/UYxRVHagp1eMVn1+ebfFwHtS51+jLNgo3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gn4yK94NMbHi9JrBbwH3lKnOZ5tGIWqUDchyfeYgV6eGTUstCAL41RpuU+2mjks+r6IIf6snaPZuFXIC3+qAQWGjkIsvVa2fgMka74DBGcQrEeRHzRj4nvLpbiX4rteSiOc8lZQALMbgaaSNKfl5C6NS5ofupPtRY6LISd1Yb+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sjT1S/aV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7D1C116C6;
	Mon,  9 Feb 2026 14:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648347;
	bh=N7AIYL8m/UYxRVHagp1eMVn1+ebfFwHtS51+jLNgo3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjT1S/aVNiuEWgXsy6axrJTh72fcLxd7S4akOUCRIS6yByUSuPqwTWRzM6MTCSzVZ
	 A76uaBkAzg0oY9uyJt1xAovFSwKyEsKnh4Pi7Ps3nNkcY/9Coj3nfdS6traOZeqZIX
	 XtD+u9MpZaU2/Gpm7vKvgw4r5u8rDHMgSRHPNZNo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bert Karwatzki <spasswolf@web.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 11/86] Revert "drm/amd: Check if ASPM is enabled from PCIe subsystem"
Date: Mon,  9 Feb 2026 15:23:34 +0100
Message-ID: <20260209142305.185448517@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
References: <20260209142304.770150175@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215301-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,web.de,amd.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 0AE95111560
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bert Karwatzki <spasswolf@web.de>

commit 243b467dea1735fed904c2e54d248a46fa417a2d upstream.

This reverts commit 7294863a6f01248d72b61d38478978d638641bee.

This commit was erroneously applied again after commit 0ab5d711ec74
("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
removed it, leading to very hard to debug crashes, when used with a system with two
AMD GPUs of which only one supports ASPM.

Link: https://lore.kernel.org/linux-acpi/20251006120944.7880-1-spasswolf@web.de/
Link: https://github.com/acpica/acpica/issues/1060
Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
Signed-off-by: Bert Karwatzki <spasswolf@web.de>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 97a9689300eb2b393ba5efc17c8e5db835917080)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2058,9 +2058,6 @@ static int amdgpu_pci_probe(struct pci_d
 			return -ENODEV;
 	}
 
-	if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
-		amdgpu_aspm = 0;
-
 	if (amdgpu_virtual_display ||
 	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
 		supports_atomic = true;



