Return-Path: <stable+bounces-152557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E741AD737C
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 16:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403363AD982
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E9022157F;
	Thu, 12 Jun 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="rLQ63c4K"
X-Original-To: stable@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E10B19049B;
	Thu, 12 Jun 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737660; cv=none; b=Z15qZcI30I6AqjuewkBCU6KvYIhUo4RK8ydzygFTl5e/GmtbjN71I1SASUqLtFu1k9qg33BmjsGvEnXCL8qNm5bNi6RLnxpXBqnUnp8kC1lQAL435EQYWKTU4y/UiScvQtQN6i1yisHin1Kj0b3O8G0oEV6QCcJtfqvgw7qxZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737660; c=relaxed/simple;
	bh=/ZJkPhEibj3MRPgMngwUIY78iCtXynAw21Rdt2Ce18w=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=D5ch5qsvmNjGVkjCM6XPpSVlyy5HtZQQl6efmKaaMTAkb7izqme3vYOs+GXPzmb/CLa76qDPI0fZzAnmg/Qe5Yl6K69BomHS0WtYz/i4HHUNp948JQCLLXAUDp7H+qE9reCxVGKnIVAo7/E5fg3tvYOPi55k+z9gFD1BY7Hl9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=rLQ63c4K; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.178.76] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 9E63E2FC01A4;
	Thu, 12 Jun 2025 16:08:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1749737336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s5RIfBjLWs/xgjxHgpqZTRDMhe9rCAFWtvXm/cCwe04=;
	b=rLQ63c4KFwKsdCLhObDXXmCpVSmdMv9txk1MrlfTzroHr2j2j7QInvwdgbM3YAbgBRZW9C
	cF1KyBivKbPYLLbqxJXEFszUJPKhq3fLaa0zR0IdBSgw/QUD09JGN4iKYyYYraCQl/QpM1
	H4Uu1ols9PKB7cq1dLE0CVo77Gw1LtU=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=ggo@tuxedocomputers.com
Message-ID: <fd10cda4-cd9b-487e-b7c6-83c98c9db3f8@tuxedocomputers.com>
Date: Thu, 12 Jun 2025 16:08:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org, regressions@lists.linux.dev,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: ggo@tuxedocomputers.com
Cc: amd-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Werner Sembach <wse@tuxedocomputers.com>,
 Christoffer Sandberg <cs@tuxedocomputers.com>
Subject: [REGRESSION] drm/amd/display: Radeon 840M/860M: bisected suspend
 crash
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I have discovered that two small form factor desktops with Ryzen AI 7
350 and Ryzen AI 5 340 crash when woken up from suspend. I can see how
the LED on the USB mouse is switched on when I trigger a resume via
keyboard button, but the display remains black. The kernel also no
longer responds to Magic SysRq keys in this state.

The problem affects all kernels after merge b50753547453 (v6.11.0). But
this merge only adds PCI_DEVICE_ID_AMD_1AH_M60H_ROOT with commit
59c34008d (necessary to trigger this bug with Ryzen AI CPU).
I cherry-picked this commit and continued searching. Which finally led
me to commit f6098641d3e - drm/amd/display: fix s2idle entry for DCN3.5+

If I remove the code, which has changed somewhat in the meantime, then
the suspend works without any problems. See the following patch.

Regards,
Georg


diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d3100f641ac6..76204ae70acc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3121,9 +3121,6 @@ static int dm_suspend(struct amdgpu_ip_block
*ip_block)

 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);

-	if (dm->dc->caps.ips_support && adev->in_s0ix)
-		dc_allow_idle_optimizations(dm->dc, true);
-
 	dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv,
DC_ACPI_CM_POWER_STATE_D3);

 	return 0;


