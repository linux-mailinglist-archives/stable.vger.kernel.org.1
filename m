Return-Path: <stable+bounces-235128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNHoDlir1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:24:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7123C2E61
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62CC931AB4FF
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27DA3176E4;
	Wed,  8 Apr 2026 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VHIhTKK+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A614FB67E;
	Wed,  8 Apr 2026 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674641; cv=none; b=PxqfA4mYJ2wEEJkG8xeijaE1dXs+4Nd/YXxcnIRjpUoTWX+APqTqT7oE2AbIDhhSI1gyApy9rn+03JopEcYTEOEko1JryKRsIzPoEWMXqp1Mkphs6ujyHI80P/tslZRxmAOzXVKl/zm9nC0Rm0YAHa57Hn1tpS08d7Eoo6iBl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674641; c=relaxed/simple;
	bh=c0JIgcpjfF52Xg7ewndRTvyUU8UN3lIsFLoS6PQeTtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOOWDsmmGa4pO0hU2SWM0Khgw6QsTBAakYloLhgAkeDlPBsvyi5+W8Zot2SLDA4UNlpdPY8JBVUDknQfi7x29cZJaT+R9zX4er/ZkA7e4rdVqP5QQZsGs9yHrgwgSaYKwl7w+VhCksnfy3rdhRmh4z9w0vyL6yLtNDLJ1p/UYLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VHIhTKK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1E1C19421;
	Wed,  8 Apr 2026 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674641;
	bh=c0JIgcpjfF52Xg7ewndRTvyUU8UN3lIsFLoS6PQeTtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHIhTKK+Z+EFLbO6PVFfPmJQg71reMr9jo5T2qs82YSSqI6z2+KPQaBeD6rBDGC4U
	 +6z4B4RIcKeBR+5d+Qsx+ZYvs14LWecBmCOm9CNkAqVC4JxlTzf0SarBbP+72EzHOd
	 Flk7zzJEu8W5TjySScOIf6yfJNxzv8SxA1z4Y3hg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 143/311] spi: stm32-ospi: Fix reset control leak on probe error
Date: Wed,  8 Apr 2026 20:02:23 +0200
Message-ID: <20260408175944.752518925@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-235128-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,foss.st.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[st.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: BA7123C2E61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 5a570c8d6e55689253f6fcc4a198c56cca7e39d6 ]

When spi_register_controller() fails after reset_control_acquire()
succeeds, the reset control is never released. This causes a resource
leak in the error path.

Add the missing reset_control_release() call in the error path.

Fixes: cf2c3eceb757 ("spi: stm32-ospi: Make usage of reset_control_acquire/release() API")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Link: https://patch.msgid.link/20260329-stm32-ospi-v1-1-142122466412@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-stm32-ospi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 5fa27de89210a..2988ff288ff02 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -939,13 +939,15 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 	if (ret) {
 		/* Disable ospi */
 		writel_relaxed(0, ospi->regs_base + OSPI_CR);
-		goto err_pm_resume;
+		goto err_reset_control;
 	}
 
 	pm_runtime_put_autosuspend(ospi->dev);
 
 	return 0;
 
+err_reset_control:
+	reset_control_release(ospi->rstc);
 err_pm_resume:
 	pm_runtime_put_sync_suspend(ospi->dev);
 
-- 
2.53.0




