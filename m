Return-Path: <stable+bounces-137974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBCDAA15F2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA03A4E0143
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F3624C098;
	Tue, 29 Apr 2025 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wIWb4eFK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6778F58;
	Tue, 29 Apr 2025 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947703; cv=none; b=Ig8uZog0woR+Tim+wG/CMiAgN3tHcUXdC0Zxs2sruvL5eOwlBnlZAI9xfFRWSaaxBjFFcf0uSlW5/013KO2JpyDbZe29gBRBu3tkw80fD5yOt5c41d17WP7+4AiKyGe92exwYASXpN5In8SZpdAVpCAGsf7y16Duag6/EtAIppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947703; c=relaxed/simple;
	bh=ovl2HkLwWdU+3rTxRjq3MlC5qIl+84QJe7DCYkz9PFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHnY/dHbff+6ioozJGdBCKBi60FSsQPysr2oqYB/PuYb6eHl+AyXJJ+wGzjZSUpKz17PmRkT18xy5t8RgHiP62EeLD+BLFETr0G5zcSOmL2kogRJh5sIzJoOGaYU6QNy+dWD2rECInYpYZWOVEJMtMHPo0tyHn7ajt+igrU//zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wIWb4eFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB28DC4CEE9;
	Tue, 29 Apr 2025 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947703;
	bh=ovl2HkLwWdU+3rTxRjq3MlC5qIl+84QJe7DCYkz9PFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wIWb4eFK2x3LnIBetC49CypjPu53Wyk2Pyzc7Dv2P42CfZEkbQ7LE6k9D4x2th1Lv
	 qdbtrbJETuB3QwVYjZT7aeaNliWOAKTHfx3k9rH7tqOShkPZ5HQ3MYpFLqqXcoTe8f
	 TKSkCfmNmnhMYLcT7e7Tphqg2U85d1mCTHHybTPw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Brett Creeley <brett.creeley@amd.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 080/280] pds_core: Remove unnecessary check in pds_client_adminq_cmd()
Date: Tue, 29 Apr 2025 18:40:21 +0200
Message-ID: <20250429161118.388539393@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brett Creeley <brett.creeley@amd.com>

[ Upstream commit f9559d818205a4a0b9cd87181ef46e101ea11157 ]

When the pds_core driver was first created there were some race
conditions around using the adminq, especially for client drivers.
To reduce the possibility of a race condition there's a check
against pf->state in pds_client_adminq_cmd(). This is problematic
for a couple of reasons:

1. The PDSC_S_INITING_DRIVER bit is set during probe, but not
   cleared until after everything in probe is complete, which
   includes creating the auxiliary devices. For pds_fwctl this
   means it can't make any adminq commands until after pds_core's
   probe is complete even though the adminq is fully up by the
   time pds_fwctl's auxiliary device is created.

2. The race conditions around using the adminq have been fixed
   and this path is already protected against client drivers
   calling pds_client_adminq_cmd() if the adminq isn't ready,
   i.e. see pdsc_adminq_post() -> pdsc_adminq_inc_if_up().

Fix this by removing the pf->state check in pds_client_adminq_cmd()
because invalid accesses to pds_core's adminq is already handled by
pdsc_adminq_post()->pdsc_adminq_inc_if_up().

Fixes: 10659034c622 ("pds_core: add the aux client API")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20250421174606.3892-4-shannon.nelson@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 2babea1109917..b76a9b7e0aed6 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -107,9 +107,6 @@ int pds_client_adminq_cmd(struct pds_auxiliary_dev *padev,
 	dev_dbg(pf->dev, "%s: %s opcode %d\n",
 		__func__, dev_name(&padev->aux_dev.dev), req->opcode);
 
-	if (pf->state)
-		return -ENXIO;
-
 	/* Wrap the client's request */
 	cmd.client_request.opcode = PDS_AQ_CMD_CLIENT_CMD;
 	cmd.client_request.client_id = cpu_to_le16(padev->client_id);
-- 
2.39.5




