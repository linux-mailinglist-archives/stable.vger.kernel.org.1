Return-Path: <stable+bounces-165955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C570B19656
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 23:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C95E174A47
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 21:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4122DFB5;
	Sun,  3 Aug 2025 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV9Dsueq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB3207DE2;
	Sun,  3 Aug 2025 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256187; cv=none; b=PAwfDzVxHehS+hV+TebpkDd0TX9Z9LC1yN9Sn+Z2dn9HYyqBKJvZ8wiKtIOBrSXcpHYqeJAQP1cl3riZD6UOU38d4ZYdR7Y3qCl8VPzDW7Jcb5mcrkK/5CsiB4X3Zr3cDDLswg8y7GEMV6cSoTkeJIrocUz8I2C2bLxsORDmdj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256187; c=relaxed/simple;
	bh=vtP0ddkQY16bUWzQzHbOitoM8teSFYWwWy1rK0XM8Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCOHwU9priE51JyxGp6PccWbOSCndKeDvN+2+0vQ2I7r/0MdAM1PQvti3dva7UEGRde8AEPXgOSPALWWbACCCCUePy3ugLOR0bzXAKdHJgRLrc11uxcccisnByNq6Bc8GYPkhqH5eIeHnrCj3EtWLX6vGCSLC/+YGQ2LgDE4HOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV9Dsueq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A504C4CEF0;
	Sun,  3 Aug 2025 21:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256185;
	bh=vtP0ddkQY16bUWzQzHbOitoM8teSFYWwWy1rK0XM8Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RV9DsueqANkbXstSbNN91qbaz91E2nAsrMskbPCN06DV6fG3y9UyP3IRA4Glf0DC6
	 3Imm0euTAVex9hJ7m0IfkwwYPn8uYTlQeUn0O7HFEosCI6iV0lwZt8p/54dpJrtybG
	 zu8RDzFsT/K/mtrwF93JZG5RB7LGYnR6XfwnUMqcuPvBfW2VdwYRU84N4yZS8PMuHW
	 m1uG+yheZBNDKDD5hNwWqvrBmaiioKbjjzIC0jhFUlPhTpp1w9nj+TzfMtJt3yqwyX
	 whV2ZsTz3qfpVf6fw0fgQbVvY//qIvUluAs0bJABsGknxtVMpd6JVJDYp2TIGp7yGK
	 xklrxyK+InzOA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 10/11] ata: libata-sata: Disallow changing LPM state if not supported
Date: Sun,  3 Aug 2025 17:22:40 -0400
Message-Id: <20250803212242.3549318-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212242.3549318-1-sashal@kernel.org>
References: <20250803212242.3549318-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.240
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 413e800cadbf67550d76c77c230b2ecd96bce83a ]

Modify ata_scsi_lpm_store() to return an error if a user attempts to set
a link power management policy for a port that does not support LPM,
that is, ports flagged with ATA_FLAG_NO_LPM.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/r/20250701125321.69496-6-dlemoal@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis of the commit and the surrounding code context,
here's my determination:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a clear bug**: Without this check, users can attempt to
   change LPM policy on ports that don't support LPM (flagged with
   ATA_FLAG_NO_LPM), which could lead to undefined behavior or system
   issues. The code already prevents setting the policy but doesn't
   inform the user that the operation failed.

2. **User-visible issue**: The bug allows sysfs writes to succeed
   silently when they should fail with an error. This violates the
   principle of least surprise - users expect operations to either
   succeed or return an error, not silently fail.

3. **Small and contained fix**: The patch adds just 5 lines of code
   (lines 927-930) that perform a simple flag check and return
   -EOPNOTSUPP if the port doesn't support LPM. This is a minimal change
   with low risk of regression.

4. **Consistency with existing checks**: The function already has
   similar validation for device-level quirks (ATA_QUIRK_NOLPM at lines
   934-937). This patch adds the missing port-level validation, making
   the code more consistent and complete.

5. **Related to recent fixes**: Looking at recent commits (65b2c92f69d3,
   4edf1505b76d), there's been work to properly handle ports that don't
   support LPM. This patch completes that work by ensuring the sysfs
   interface properly rejects invalid operations.

6. **Prevents potential hardware issues**: Attempting to set LPM
   policies on hardware that doesn't support them could potentially
   cause hardware malfunctions or unexpected behavior. This fix prevents
   such attempts at the sysfs interface level.

The fix follows stable kernel rules: it's a clear bug fix, minimal in
scope, doesn't introduce new features, and addresses a real user-facing
issue where invalid operations appear to succeed when they should fail
with an appropriate error code.

 drivers/ata/libata-sata.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 45656067c547..d5c97dba2dd4 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -815,6 +815,11 @@ static ssize_t ata_scsi_lpm_store(struct device *device,
 
 	spin_lock_irqsave(ap->lock, flags);
 
+	if (ap->flags & ATA_FLAG_NO_LPM) {
+		count = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ata_for_each_link(link, ap, EDGE) {
 		ata_for_each_dev(dev, &ap->link, ENABLED) {
 			if (dev->horkage & ATA_HORKAGE_NOLPM) {
-- 
2.39.5


