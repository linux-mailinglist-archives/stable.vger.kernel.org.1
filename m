Return-Path: <stable+bounces-57272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A8925BDB
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E591F23A3D
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6A4194C8A;
	Wed,  3 Jul 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dj8WeNNr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1521891D3;
	Wed,  3 Jul 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004378; cv=none; b=KzCfk4j5aVanGkynZzPIILarv/t6Bz61O22Lj6SwB/M9ra/pjt4Q0yyyk+Kwe68EnCLwAWOHHZiPhzL2C1ZcCGs6grubtGwepqjxgI5+R+bzsiiL/+YKNw0PWpy4BHyuXeCO0dZoE7FR9lDkDEeD7xCzptoiNQxbwH7ue7u4eGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004378; c=relaxed/simple;
	bh=3Ge3pLzjUAVI4CQ6/Nyz2dRoNE0W7EC1xWWTj5poLK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFfoLvdNRxF8i8ze6WNF8p9E7JNkI7dMVpALy3KPbB+UExQAQK0vTXA98cjvM427e6VLhmuXXbEZgnhOwC88xJruMiG+YJZVQoixemTzdPmPIVNhm4nUPf08O9nsh/WjmGTK+80klGtrBbgi30Nnivno/RupMZrJgN5pPGqYRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dj8WeNNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C983EC2BD10;
	Wed,  3 Jul 2024 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004378;
	bh=3Ge3pLzjUAVI4CQ6/Nyz2dRoNE0W7EC1xWWTj5poLK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dj8WeNNrpD7l/s1YrRzw7o1NQiBUrhmdsLDAw6VGNYp4mcswaGKrCsaPz5n6TKS02
	 C1CnrVDHvxGFVbJE/qiU6izNwotn2gr7KJIniTGPGeQFvmfgUKaLbLuPqGWYOYK6Fk
	 joUVWUiedDX/bX4fALFtHiTn6eKqJOypmzOwEMpA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shahar S Matityahu <shahar.s.matityahu@intel.com>,
	Luciano Coelho <luciano.coelho@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 007/290] wifi: iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef
Date: Wed,  3 Jul 2024 12:36:28 +0200
Message-ID: <20240703102904.458109117@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

[ Upstream commit 87821b67dea87addbc4ab093ba752753b002176a ]

The driver should call iwl_dbg_tlv_free even if debugfs is not defined
since ini mode does not depend on debugfs ifdef.

Fixes: 68f6f492c4fa ("iwlwifi: trans: support loading ini TLVs from external file")
Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240510170500.c8e3723f55b0.I5e805732b0be31ee6b83c642ec652a34e974ff10@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index ab84ac3f8f03f..bf00c2fede746 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1699,8 +1699,8 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 err_fw:
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	debugfs_remove_recursive(drv->dbgfs_drv);
-	iwl_dbg_tlv_free(drv->trans);
 #endif
+	iwl_dbg_tlv_free(drv->trans);
 	kfree(drv);
 err:
 	return ERR_PTR(ret);
-- 
2.43.0




