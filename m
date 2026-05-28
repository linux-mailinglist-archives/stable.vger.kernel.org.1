Return-Path: <stable+bounces-255203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMK0FlifGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:02:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBDA5F7B0D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FE50318B723
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55987344DAC;
	Thu, 28 May 2026 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lBMhZT2E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3426F3290B0;
	Thu, 28 May 2026 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998251; cv=none; b=HZmPv8XyI3sS8o383iofIhFu5oslZ0l5Du0uEJPwbgiivdmaqHqmV0vyeo6JCdYr6i4mg5A3fqlVHmaMpK0U/QWg1azFJdGRBIRpLjxhOWH4/qGQitReHuJRmJsXqkOZyp+GczTQdgx6c1PXRiG85r7cjNqpLwDrZ309Lsdobl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998251; c=relaxed/simple;
	bh=jPcmfHYfKwogiYEmYzcNpq9JHiWLWkilXsYFgWTon9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqVdXlue2nKjK50KLASPKP2M/Pc2FDzjTBzxfzyms0YYGDNNcPXzj1CPoozjLFx43fjHFlOMljas7YWenCU4CykEkOJrfVrNhnkbHHm3IiUAxo06eRguGYRtiFX7OoQOT42/IX2s0spZNAi4fjTddqaqO93YA2veLJDLfUFn0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lBMhZT2E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921421F000E9;
	Thu, 28 May 2026 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998250;
	bh=OlPFsHSYJ/yF4KzHCx5NDjb0gxeUwDVNZQAkQRyOYok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lBMhZT2E0dcw/D48DbcycS/If9tw4K7Ww52q/HPc2XdUOupfHdemjPSR44p7+soIM
	 7j9+e3jxIX01ez10Vta242+p30V9DTMe8OhIH1hOm9CqGkKkQn6LR2FwaBHU39kT1a
	 SalA25v7jjWrz4wEV5nM3FKgRLODJCASJJbINpmY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saurav Sachidanand <sauravsc@amazon.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 7.0 106/461] i2c: tegra: fix pm_runtime leak on mutex_lock failure
Date: Thu, 28 May 2026 21:43:55 +0200
Message-ID: <20260528194650.032369626@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255203-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CEBDA5F7B0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saurav Sachidanand <sauravsc@amazon.com>

commit 57cf4e8d6a57dc2ef5810f4852a23ba4c71b74bb upstream.

If tegra_i2c_mutex_lock() fails, the function returns without calling
pm_runtime_put(), leaking the runtime PM reference acquired by the
preceding pm_runtime_get_sync(). This prevents the device from ever
entering runtime suspend.

Add the missing pm_runtime_put() before returning on lock failure.

Fixes: 6077cfd716fb ("i2c: tegra: Add support for SW mutex register")
Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
Cc: <stable@vger.kernel.org> # v7.0+
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260507221145.62183-2-sauravsc@amazon.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-tegra.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1522,8 +1522,10 @@ static int tegra_i2c_xfer(struct i2c_ada
 	}
 
 	ret = tegra_i2c_mutex_lock(i2c_dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_put(i2c_dev->dev);
 		return ret;
+	}
 
 	for (i = 0; i < num; i++) {
 		enum msg_end_type end_type = MSG_END_STOP;



