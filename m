Return-Path: <stable+bounces-101439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2CA9EEC69
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F1C16528A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5E22153DF;
	Thu, 12 Dec 2024 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mjaShrht"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D99212F9E;
	Thu, 12 Dec 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017556; cv=none; b=GD+VG2mMjc4UiyvjpR/LHPw2cs2yakQcdkCjgvB7IhjcDSuVlh7r4eEXl2C1KjU04Y2/+wjyq0Ua7wD3TVtRl6zKFqPnY3hr0QN6004j8PU+RGZtjdDrOH8JlldBZY9ElIOPSM4hOY5BV1oZWxXSHu9B/990j0SKw3FUffbQD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017556; c=relaxed/simple;
	bh=J3bfeoNSGKvhgMKWv/p8kzrtUweXW+VDdXUMNYNv7+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bo6kuF5dsLg8XsKvnT2ZmyTSACgeF63/f3XOVgWMm1y9LdLAfijC8sWUrg3E3KrMMtDTJoV34WZwbvo16kxLujDhxA7fgm5/HkXZGW/xYyqYYb28oOxCzNc4AcixsCM3zxlaftD/Lf4FYnbQjEe240BDE8v40G9jQE0BqnaLY84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mjaShrht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59DCC4CECE;
	Thu, 12 Dec 2024 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017555;
	bh=J3bfeoNSGKvhgMKWv/p8kzrtUweXW+VDdXUMNYNv7+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjaShrhtGXgWlIwh4YGt/BuRSigXBO9FU5/YBt7vbu5J5wTWvPcL211b3b0/NwIRt
	 H6SNbI4A7EbKcjgaoKWTr/s8nolvL9zFOOxbNKceAWpT7ROtHg0lDBU18lL0MzKC4+
	 2xpivfm9BmYhpBuv/2p20NERsed3S2kfIWK4azJU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 046/356] ixgbevf: stop attempting IPSEC offload on Mailbox API 1.5
Date: Thu, 12 Dec 2024 15:56:05 +0100
Message-ID: <20241212144246.452976527@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit d0725312adf5a803de8f621bd1b12ba7a6464a29 ]

Commit 339f28964147 ("ixgbevf: Add support for new mailbox communication
between PF and VF") added support for v1.5 of the PF to VF mailbox
communication API. This commit mistakenly enabled IPSEC offload for API
v1.5.

No implementation of the v1.5 API has support for IPSEC offload. This
offload is only supported by the Linux PF as mailbox API v1.4. In fact, the
v1.5 API is not implemented in any Linux PF.

Attempting to enable IPSEC offload on a PF which supports v1.5 API will not
work. Only the Linux upstream ixgbe and ixgbevf support IPSEC offload, and
only as part of the v1.4 API.

Fix the ixgbevf Linux driver to stop attempting IPSEC offload when
the mailbox API does not support it.

The existing API design choice makes it difficult to support future API
versions, as other non-Linux hosts do not implement IPSEC offload. If we
add support for v1.5 to the Linux PF, then we lose support for IPSEC
offload.

A full solution likely requires a new mailbox API with a proper negotiation
to check that IPSEC is actually supported by the host.

Fixes: 339f28964147 ("ixgbevf: Add support for new mailbox communication between PF and VF")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbevf/ipsec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index 66cf17f194082..f804b35d79c72 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -629,7 +629,6 @@ void ixgbevf_init_ipsec_offload(struct ixgbevf_adapter *adapter)
 
 	switch (adapter->hw.api_version) {
 	case ixgbe_mbox_api_14:
-	case ixgbe_mbox_api_15:
 		break;
 	default:
 		return;
-- 
2.43.0




