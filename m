Return-Path: <stable+bounces-182833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EC7BADE40
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B2738075D
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D541EE02F;
	Tue, 30 Sep 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mDHNd7Yd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5E9FBF6;
	Tue, 30 Sep 2025 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246226; cv=none; b=mIdwtUiHa9qFP3G12U67zNDyJiVSmYykSp4U4JZhfAQr8S87ADS6lUcM94a81GBi0WuRhn5k0exkNhb/B+5nhO3ycWsAgWiR3TClT2c5kYLm3VFnLqAQDXDKPPe7x/vY9CnrCxqR1rxqf8VGC8AougrASZYB7YOV6SdFsaqpn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246226; c=relaxed/simple;
	bh=rZ3yiCnLqML2YCFmrxeoNhJNNDIvOhRrL7FFVrxEP4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZ+toKdFZZjJ0k51b+JXFfRDJmTI7zVYB7+TlVzNXwYR/gTgyIKESNEPo4PAyj+o+Ur3vE8RoaXhZQd64Z8K6ZFeDWqSr7BEppOR2NQgQh8H1h+ZQV0hbnIhknzbbhvwnXn5fquM3olVcZoHjdoLluYGQ8Nw2q6pOFqSre6EeKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mDHNd7Yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58416C4CEF0;
	Tue, 30 Sep 2025 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759246226;
	bh=rZ3yiCnLqML2YCFmrxeoNhJNNDIvOhRrL7FFVrxEP4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDHNd7YdaIcZbpDvQhH7fi4uT6xkivNCR2OC9L/qmmGi7HAMG76GaiY97FzcS/4pC
	 1yFD9sqO73eMVxgg3DFQewQF9HGgulSngTdZ4V6Ve/b3h+EeKP6TyNABiyF0ZRTSMF
	 5SRCSOZ0UgZCYNErlcvO6ogL2HsxILZNL2+9QHBc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH 6.12 70/89] i40e: fix input validation logic for action_meta
Date: Tue, 30 Sep 2025 16:48:24 +0200
Message-ID: <20250930143824.805568432@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
References: <20250930143821.852512002@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

commit 9739d5830497812b0bdeaee356ddefbe60830b88 upstream.

Fix condition to check 'greater or equal' to prevent OOB dereference.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3605,7 +3605,7 @@ static int i40e_validate_cloud_filter(st
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > vf->num_tc) {
+	    tc_filter->action_meta >= vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;



