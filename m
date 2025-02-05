Return-Path: <stable+bounces-113627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE99A2934B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C083AFAE1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FFA189905;
	Wed,  5 Feb 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FtFTnHQn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BCC1519A9;
	Wed,  5 Feb 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767613; cv=none; b=WIBuzWhK1708Da7vcWh45V6f8S3+7qtd7mg+O0cSeg1e+WUPIJDJ1U345ls1X6d8F/N2CV2AQ7+vomcjoiEtPk+Iu5zmcQnDW0tGGlQ3dnnl22zhix8XhKk7/zdBq6D8EEYLL0JSqUic1CFPyp7n3OFdajwIkLGD9OqN3kCK3Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767613; c=relaxed/simple;
	bh=vs43NCl8e1XSi7UXAvaPCsIXbYPiptmhEy8ogMUGLak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXvvv+nSXoqGDV3EaI5m0A8AY5f5561mmsosjrn4VTr4E1FAjYuzEKmUOySf5F6T3o0KIDZrxO92CvGuKmVdqcDWJQ3eCmAQlKGbAieoZPCgQ7wwQkFV8rqyqv6gffWDiQbNB1lyQ1w8sUuRdRJ5MWB3RpeQVN/YiyTqrcJCWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FtFTnHQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED993C4CED1;
	Wed,  5 Feb 2025 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767613;
	bh=vs43NCl8e1XSi7UXAvaPCsIXbYPiptmhEy8ogMUGLak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtFTnHQnioNUCIYZK+Yb9/bAD71HJOAcB5Gf03TgjBWw1e64sAKx0euI8g8LJj/l1
	 pimCDC5n6g0uvPuWD66UClaDTSxn4jZJKOf5h7ztKolGct90jpAeXv6R7dLKgjFWDP
	 c0GPqD4VohAx23tYBQ4GwGoICX++CdgrAxZFfOcM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Lance Richardson <rlance@google.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 482/590] idpf: add read memory barrier when checking descriptor done bit
Date: Wed,  5 Feb 2025 14:43:57 +0100
Message-ID: <20250205134513.702332122@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

From: Emil Tantilov <emil.s.tantilov@intel.com>

[ Upstream commit 396f0165672c6a74d7379027d344b83b5f05948c ]

Add read memory barrier to ensure the order of operations when accessing
control queue descriptors. Specifically, we want to avoid cases where loads
can be reordered:

1. Load #1 is dispatched to read descriptor flags.
2. Load #2 is dispatched to read some other field from the descriptor.
3. Load #2 completes, accessing memory/cache at a point in time when the DD
   flag is zero.
4. NIC DMA overwrites the descriptor, now the DD flag is one.
5. Any fields loaded before step 4 are now inconsistent with the actual
   descriptor state.

Add read memory barrier between steps 1 and 2, so that load #2 is not
executed until load #1 has completed.

Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Suggested-by: Lance Richardson <rlance@google.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/idpf/idpf_controlq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.c b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
index 4849590a5591f..b28991dd18703 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
@@ -376,6 +376,9 @@ int idpf_ctlq_clean_sq(struct idpf_ctlq_info *cq, u16 *clean_count,
 		if (!(le16_to_cpu(desc->flags) & IDPF_CTLQ_FLAG_DD))
 			break;
 
+		/* Ensure no other fields are read until DD flag is checked */
+		dma_rmb();
+
 		/* strip off FW internal code */
 		desc_err = le16_to_cpu(desc->ret_val) & 0xff;
 
@@ -563,6 +566,9 @@ int idpf_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 		if (!(flags & IDPF_CTLQ_FLAG_DD))
 			break;
 
+		/* Ensure no other fields are read until DD flag is checked */
+		dma_rmb();
+
 		q_msg[i].vmvf_type = (flags &
 				      (IDPF_CTLQ_FLAG_FTYPE_VM |
 				       IDPF_CTLQ_FLAG_FTYPE_PF)) >>
-- 
2.39.5




