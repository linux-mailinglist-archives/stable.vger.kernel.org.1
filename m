Return-Path: <stable+bounces-220191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MlyNE8zo2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:26:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3EB1C5C9E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E348931C5A49
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5354C77D7;
	Sat, 28 Feb 2026 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUSzzXcV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA14C77D0;
	Sat, 28 Feb 2026 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300097; cv=none; b=kMIlYXsOgvZhnIRRSpd+obPELXyIAVwbD6DvZiZtHFjqGiSAbrIcE/+kk+lgZWI/Nuv8XsKaGnsJC3YH25fo+R0QLawz+vEWWHSyWAgPdWFyEow5UeskTN+uTGKBpVoKYYWwoiKP9LeJxMVDPwfjd3Id4PYn6IdJSI6ZJTLqq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300097; c=relaxed/simple;
	bh=rbgw5izTleVxv+iMLaezDmiKBi4xS3WfjILjsEfjiqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTd79rfFA4+02+ZLrtoMvOAPcbG8hXNMcJSuDJ1yJVnaUJOZ+nsz+lF8kSDoukvMZocrIFDMcvvFr6/6r11COywJORAL8eu33DF8LQ5J9PZT+d+P5HXKQBWgpbe+uDUhGbwwBiYG8C7gvqtHBFQu9vnGfENZ0Ic2zaRWcpLSito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUSzzXcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BB3C116D0;
	Sat, 28 Feb 2026 17:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300097;
	bh=rbgw5izTleVxv+iMLaezDmiKBi4xS3WfjILjsEfjiqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUSzzXcVStM3Qq45TTrEbolAO5lY8C6GP6yEmMk+19h6yq/LvSXNThr+lfQVsjaOX
	 A7v4zVvuMnv+fSYZMTLxvAdO9z4RCMv19hEZ4Vd9vOUK10GV/j0zjkLJTPn+xVDBk5
	 vzRHjkESrLFPza49C0joVKmYE2REqLEu/5sWnBlnmYFgSLhJhV33yFMRhx39H1vBsD
	 n20qwIKGBlCrM6OWCcUzWaoJPcTJx9C03W1bH4WiLLOn5VM5BzUIbWEtolZW+QtsWs
	 q7hRjFj9M3vnIjqkRZMw9nE65H51OvwaJ62i29TSSZL2uxToHLcuJAfiii/Q+MF0ru
	 rCF6KbKqAKWkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 113/844] firmware: arm_ffa: Unmap Rx/Tx buffers on init failure
Date: Sat, 28 Feb 2026 12:20:26 -0500
Message-ID: <20260228173244.1509663-114-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220191-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA3EB1C5C9E
X-Rspamd-Action: no action

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

[ Upstream commit 9fda364cb78c8b9e1abe4029f877300c94655742 ]

ffa_init() maps the Rx/Tx buffers via ffa_rxtx_map() but on the
partition setup failure path it never unmaps them.

Add the missing ffa_rxtx_unmap() call in the error path so that
the Rx/Tx buffers are properly released before freeing the backing
pages.

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Message-Id: <20251210031656.56194-1-lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index c501c3104b3a4..11a702e7f641c 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -2093,6 +2093,7 @@ static int __init ffa_init(void)
 
 	pr_err("failed to setup partitions\n");
 	ffa_notifications_cleanup();
+	ffa_rxtx_unmap(drv_info->vm_id);
 free_pages:
 	if (drv_info->tx_buffer)
 		free_pages_exact(drv_info->tx_buffer, rxtx_bufsz);
-- 
2.51.0


