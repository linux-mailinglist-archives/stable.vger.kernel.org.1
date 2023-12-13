Return-Path: <stable+bounces-6246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65F280D993
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9194828201C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F651C50;
	Mon, 11 Dec 2023 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GZn7rETp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58AF321B8;
	Mon, 11 Dec 2023 18:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7A3C433C9;
	Mon, 11 Dec 2023 18:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320907;
	bh=2/jMo8Uz6PPb99etoqvP0FtPAiip3yy5prma95TSPHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZn7rETpB/mXXUYM28CpiTOb3fcuedAJ6RQk8cYHVs9Z/JBAM0Jo6GTctwDjD5rVB
	 K6rMrJzP8KOk86mgblwaYmUSTC3jkbnHLKPOgmWNp+oKXwANc12s2CrKAAo2MxMLXJ
	 9JY0VqI7YQZFhsueEs6eg2F4e527FEXTWfdQAki4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Vecera <ivecera@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 032/141] i40e: Fix unexpected MFS warning message
Date: Mon, 11 Dec 2023 19:21:31 +0100
Message-ID: <20231211182027.938040171@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit 7d9f22b3d3ef379ed05bd3f3e2de83dfa8da8258 ]

Commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set") added
a warning message that reports unexpected size of port's MFS (max
frame size) value. This message use for the port number local
variable 'i' that is wrong.
In i40e_probe() this 'i' variable is used only to iterate VSIs
to find FDIR VSI:

<code>
...
/* if FDIR VSI was set up, start it now */
        for (i = 0; i < pf->num_alloc_vsi; i++) {
                if (pf->vsi[i] && pf->vsi[i]->type == I40E_VSI_FDIR) {
                        i40e_vsi_open(pf->vsi[i]);
                        break;
                }
        }
...
</code>

So the warning message use for the port number index of FDIR VSI
if this exists or pf->num_alloc_vsi if not.

Fix the message by using 'pf->hw.port' for the port number.

Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 20e26aa5b81c8..cf085bd8d790f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16132,7 +16132,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
 	if (val < MAX_FRAME_SIZE_DEFAULT)
 		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
-			 i, val);
+			 pf->hw.port, val);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
-- 
2.42.0




