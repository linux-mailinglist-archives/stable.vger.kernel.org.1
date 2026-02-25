Return-Path: <stable+bounces-218758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHb/DtZYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:05:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 918521907EA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60CD331FB845
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8102701B8;
	Wed, 25 Feb 2026 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QOjG3uW5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439111E2834;
	Wed, 25 Feb 2026 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983628; cv=none; b=fq2SZCNScHgQjxw0Hvai3wWUKqPCeNCj2Mj1ApzUiLkX6usGgkgZiwDlPohKEao+DzooSoSykTeIX7KIu0sZHShebvkLNxBf8aYManYeKMFD22U0zNiuWIvoEAhfYhdSIbe8zJNFn8UwDO5/6K8b6594LyaM+HUlg6wVtBX5/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983628; c=relaxed/simple;
	bh=kCpYVnMSvS0ChSctCjXD7sGjCrb+QlA/7K+q9bBHaiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kasNhYoorouzN+AW22gNQFrEVphYsdzMNakcX/r+cvMfWWHcGr0Yz5JNgtKeB3p+oL4wuVkZeG2T2dlmdAfp2Yoi+a5kis8GsghQcdZS+/fbTh1pn+BgJLzT/Nl6DblNmIGd7ChtPXa31nt5n+fq3mCE5jO/ytVH26od2WyN4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QOjG3uW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE2FC116D0;
	Wed, 25 Feb 2026 01:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983628;
	bh=kCpYVnMSvS0ChSctCjXD7sGjCrb+QlA/7K+q9bBHaiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOjG3uW5YUEr0wrU5RHEULSNmYs/UAd6zda7Pe/U9AAb4TuWgzmN7cg/yH0ZQiked
	 L4wJ8O06Fk58XqwLkZj95IyKFq9WSA514el5uVe6fJ0hy0PIOCqFTnOBOHPBcFhlhO
	 palrgmu5bonxpM4MauMB30eQWTFzx9Nv+NOlUsJc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Mario Limonciello <superm1@kernel.org>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	ChiaHsuan Chung <chiahsuan.chung@amd.com>,
	Roman Li <roman.li@amd.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 719/781] drm/amd/display: Fix dc_link NULL handling in HPD init
Date: Tue, 24 Feb 2026 17:23:48 -0800
Message-ID: <20260225012417.373885962@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218758-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,kernel.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 918521907EA
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 226a40c06a183abaeb7529a4f54d6c203bd14407 ]

amdgpu_dm_hpd_init() may see connectors without a valid dc_link.

The code already checks dc_link for the polling decision, but later
unconditionally dereferences it when setting up HPD interrupts.

Assign dc_link early and skip connectors where it is NULL.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c:940 amdgpu_dm_hpd_init()
error: we previously assumed 'dc_link' could be null (see line 931)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c
    923                 /*
    924                  * Analog connectors may be hot-plugged unlike other connector
    925                  * types that don't support HPD. Only poll analog connectors.
    926                  */
    927                 use_polling |=
    928                         amdgpu_dm_connector->dc_link &&
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The patch adds this NULL check but hopefully it can be removed

    929                         dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id);
    930
    931                 dc_link = amdgpu_dm_connector->dc_link;

dc_link assigned here.

    932
    933                 /*
    934                  * Get a base driver irq reference for hpd ints for the lifetime
    935                  * of dm. Note that only hpd interrupt types are registered with
    936                  * base driver; hpd_rx types aren't. IOW, amdgpu_irq_get/put on
    937                  * hpd_rx isn't available. DM currently controls hpd_rx
    938                  * explicitly with dc_interrupt_set()
    939                  */
--> 940                 if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
                            ^^^^^^^^^^^^^^^^^^^^^^^ If it's NULL then we are trouble because we dereference it here.

    941                         irq_type = dc_link->irq_source_hpd - DC_IRQ_SOURCE_HPD1;
    942                         /*
    943                          * TODO: There's a mismatch between mode_info.num_hpd
    944                          * and what bios reports as the # of connectors with hpd

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index e7b0928bd3db7..5948e2a6219e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -919,16 +919,15 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 			continue;
 
 		amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
+		dc_link = amdgpu_dm_connector->dc_link;
+		if (!dc_link)
+			continue;
 
 		/*
 		 * Analog connectors may be hot-plugged unlike other connector
 		 * types that don't support HPD. Only poll analog connectors.
 		 */
-		use_polling |=
-			amdgpu_dm_connector->dc_link &&
-			dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id);
-
-		dc_link = amdgpu_dm_connector->dc_link;
+		use_polling |= dc_connector_supports_analog(dc_link->link_id.id);
 
 		/*
 		 * Get a base driver irq reference for hpd ints for the lifetime
-- 
2.51.0




