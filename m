Return-Path: <stable+bounces-182140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A86BAD50C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81953C22E5
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E2F303A16;
	Tue, 30 Sep 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VxaCyNrV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C62264AB;
	Tue, 30 Sep 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243968; cv=none; b=TmaqUm0ETaRwtRJcwYXEAwxOpe++ezB13Fdo8Bf7P8AYtO1WTI+Jn1Ug+dQ7je/fgN7Al/SyrZziyH+PtT6zK7Ub5dxr19vI8nEfTTd+OxDsJ+PQ0/w95weMxKMewAQ0asND62bE0iaFuscj9VWb+4zS6yz2TfW0cwz0WWPPN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243968; c=relaxed/simple;
	bh=jxzfaln1UU9IcO+nlgXL3M3ubnt8Mn/+0NGpN1q9cBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozBjp7MjxRmBd+Qs6JTxYAMQFUS6kX72wDTHHLHQWx70ahFJYrZQDl+4g9ALDUENVdME32X7dMdOlV0BSFKxJajvURTzRu5z6LXGFsIkbpwMaThVoS9hu6h1fxDFJSbPYc1AP85KfZIc+cA8hJ9MCgRmFd+iQL+2Vi4Ae3kw0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VxaCyNrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A095C4CEF0;
	Tue, 30 Sep 2025 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759243968;
	bh=jxzfaln1UU9IcO+nlgXL3M3ubnt8Mn/+0NGpN1q9cBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VxaCyNrVaEDELDTNmkDgpPyXwo52U/kxoe5iT1RA2rFlesdQvKrmwQxlWl2zfVBB0
	 75fMxL+WTNW2Mt574de4GgXidN2koju8BkJePzpNowU1+zzeeMKpSIXVfW+a9+zOSH
	 Ti7Av47aUaJjQQJ7i5GEWLaE/LQVLNogwzkuBRIY=
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
Subject: [PATCH 5.4 71/81] i40e: fix input validation logic for action_meta
Date: Tue, 30 Sep 2025 16:47:13 +0200
Message-ID: <20250930143822.674991330@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143819.654157320@linuxfoundation.org>
References: <20250930143819.654157320@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3367,7 +3367,7 @@ static int i40e_validate_cloud_filter(st
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > vf->num_tc) {
+	    tc_filter->action_meta >= vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;



