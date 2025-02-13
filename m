Return-Path: <stable+bounces-116084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80794A3470A
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF67188C01D
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2072143736;
	Thu, 13 Feb 2025 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LeTJn1xq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9431526B0BD;
	Thu, 13 Feb 2025 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460266; cv=none; b=KdopVttBzJ6rBg/OIfIHnvUd9USNJBmN61fQwR2GNimA5EiKvQhbO+cq7wgBZ3FctI9AOMubmpq3y8HsD+gBtCBMUrzBtLqIvxuOeoiK785BfaEGT2HPKCO9jBuJcQkyjTWutyiix06KyWyNtCXg0JRahtxeCqxka/Kpo26/k/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460266; c=relaxed/simple;
	bh=ijDEKDfkLStkRYobX1f8BMmEKFZQ5DIqu0f2OVza8+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQmrG6a001mCKZ0RvkwWMTyNQT79cocAQPwE3vLX36Y6dfqMb4fY7Jj6tfM2AMk3OWJfTFnfNxhOZ8/seEt6tmnOTMB8A1p8wd6PAHSd+a1a/r53TvTdadDMBTAJXfoO7GLcCBVTSV6IqRUFPaKDW1Qm2WzaQ7I4RCR0RVU/5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LeTJn1xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0848FC4CED1;
	Thu, 13 Feb 2025 15:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739460266;
	bh=ijDEKDfkLStkRYobX1f8BMmEKFZQ5DIqu0f2OVza8+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LeTJn1xqSq7a2RZu+2jHNEvtlG5Acifh2wfpnetelgXjOt41a0f/K66mZ4dF3vmOn
	 HjR/afxk/bhkFRAxgVkenyZUf6DsOCDAyNqOlfLJCMv2kwGJVuJeT7x2lYqVqjTGhe
	 tKbDHQ2YSM/0YcfukrQ9OjvszNl0Z4lurxvaxgps=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prasad Pandit <pjp@fedoraproject.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 061/273] firmware: iscsi_ibft: fix ISCSI_IBFT Kconfig entry
Date: Thu, 13 Feb 2025 15:27:13 +0100
Message-ID: <20250213142409.766068035@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142407.354217048@linuxfoundation.org>
References: <20250213142407.354217048@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prasad Pandit <pjp@fedoraproject.org>

[ Upstream commit e1e17a1715982201034024863efbf238bee2bdf9 ]

Fix ISCSI_IBFT Kconfig entry, replace tab with a space character.

Fixes: 138fe4e0697 ("Firmware: add iSCSI iBFT Support")
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index f0e9f250669e2..3f2f22e47bfa1 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -139,7 +139,7 @@ config ISCSI_IBFT
 	select ISCSI_BOOT_SYSFS
 	select ISCSI_IBFT_FIND if X86
 	depends on ACPI && SCSI && SCSI_LOWLEVEL
-	default	n
+	default n
 	help
 	  This option enables support for detection and exposing of iSCSI
 	  Boot Firmware Table (iBFT) via sysfs to userspace. If you wish to
-- 
2.39.5




