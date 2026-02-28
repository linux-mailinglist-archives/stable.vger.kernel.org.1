Return-Path: <stable+bounces-220934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO7/Bp1Yo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:05:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D145B1C8C39
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D58CD3106EF3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85013321D8;
	Sat, 28 Feb 2026 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6x73Zz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA144B686;
	Sat, 28 Feb 2026 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301281; cv=none; b=Zw8E+nbSrshq8cFd1lrfKtAALERMBPPh7vDXtff5C64JlSQnVPEV44P99nsGqL6lvf3tt/BKqCGv2ttDWzYX4C3OMpy9js/qaTEOPkPG3qSbl3+vD1ocndIYaDHicxPPq2ynINkKZrT5wjSs9hl1MkXFuHV6oFwtMkoM04x0JOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301281; c=relaxed/simple;
	bh=gFiBiJN5gHtn8/5nUyXBJeb3LWUklhye6VF7SCOesm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8Rz69vmnczIXWe01/d2BzE9YKl1qnXJ2pkiJcWXETHJC5aFazSN6HVBPBbUVkUijy8Q1hva1cFLxo6CvN1WdkUGjNey/mnULdhsd9aVYGWRJGDfxqF9llpwXrYMatQHFuA+qsVnWTdl7hMIqY/WYCqzdrbYK1BbgTlQ4IYynic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6x73Zz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17F2C19424;
	Sat, 28 Feb 2026 17:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301281;
	bh=gFiBiJN5gHtn8/5nUyXBJeb3LWUklhye6VF7SCOesm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6x73Zz8MHMz5nKTRFVV2p/LixENzvb8lhwrMEbdgUexOp1+/WL3wrLQHTEgVthVW
	 +wWQSUZdSpixhvnLjtajfF/SxDiT9DQ4PtYRsmhTBrGo/4dl0zRw1O2Ct6zHvpGMwF
	 fFMx6o/s33WblxBPw4CdO47bAfRBqowQa8pbBCGhAxOZgOld/pF8hr/G4dGMRT71yi
	 Ei/KibbB8C5HXevt6iCCj6Ax5ErHcE4Re/nhHLcB1g9VUVBhvLvtZR7TXrqnTh3C/3
	 1KVAhEEEkpgdtS2ODv/pTCgpptijd6/nUwqecvd90BFKbesZbleTfEhPz9R2Uxd6cJ
	 QcmrHrwMAk0Ag==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	stable@vger.kernel.org,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 465/752] fpga: dfl: use subsys_initcall to allow built-in drivers to be added
Date: Sat, 28 Feb 2026 12:42:56 -0500
Message-ID: <20260228174750.1542406-465-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220934-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D145B1C8C39
X-Rspamd-Action: no action

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

[ Upstream commit 267f53140c9d0bf270bbe0148082e9b8e5011273 ]

The dfl code adds a bus. If it is built-in and there is a built-in driver
as well, the dfl module_init may be called after the driver module_init,
leading to a failure to register the driver as the bus has not been added
yet.

Use subsys_initcall, which guarantees it will be called before the drivers
init code.

Without the fix, we see failures like this:

[    0.479475] Driver 'intel-m10-bmc' was unable to register with bus_type 'dfl' because the bus was not initialized.

Cc: stable@vger.kernel.org
Fixes: 9ba3a0aa09fe ("fpga: dfl: create a dfl bus type to support DFL devices")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Link: https://lore.kernel.org/r/20251215-dfl_subsys-v1-1-21807bad6b10@igalia.com
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/dfl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 7022657243c0a..449c3a082e232 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -2018,7 +2018,7 @@ static void __exit dfl_fpga_exit(void)
 	bus_unregister(&dfl_bus_type);
 }
 
-module_init(dfl_fpga_init);
+subsys_initcall(dfl_fpga_init);
 module_exit(dfl_fpga_exit);
 
 MODULE_DESCRIPTION("FPGA Device Feature List (DFL) Support");
-- 
2.51.0


