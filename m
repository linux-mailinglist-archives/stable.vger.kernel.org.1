Return-Path: <stable+bounces-184760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D560FBD443B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA15C4FCFF0
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470CE3093DB;
	Mon, 13 Oct 2025 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FtqKxENj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E6306B3C;
	Mon, 13 Oct 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368355; cv=none; b=J/l+6PkBP1CoO8OxT3N8HiRwUiTmOnxAPyt1hlDc9alUZW4bNdvwA8bXqrrXb0vZPAdfXna9ov7dLlC3SX+gs+ZCiapYCgXX4gCsB0fAlomvTNFNw7aUPVevVet05nZPfPiYUrXIzOCbvvra2MT7t7+BZ6yZIpBV3JdBcCL0MbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368355; c=relaxed/simple;
	bh=1HGtm1Nim5g+htlCLbH8ZbvM6cD29SolrDMQGqQBczc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDcbbXytmYjgnefHOD4p4yhBgpRGIIvrSJYOEnqrJtLhgxbD6zwed9viVNFbaFjht1WI97CzdFxyeJO6XiJrj67w1H8NsO+CtXpmMSEoRjGPTkedFB0xJPT+7No+UqL3t3WEZiYTvrVDyP+jYiEVoLb6yi68JHq7lRwwUDLcrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FtqKxENj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839DCC4CEFE;
	Mon, 13 Oct 2025 15:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368354;
	bh=1HGtm1Nim5g+htlCLbH8ZbvM6cD29SolrDMQGqQBczc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtqKxENj6Uyjh70OwT/g4AtirmnM21Eev4u2Oe/rSAzJRWhAfqI1AdV1EHcQumOZk
	 k9hcvnBvN8CiWlBH9XhNGV8LJURvHiNBElTRWEJJjXA6BqHcILaHVYKud/pPME+4zV
	 /A/TvlNsZ9wqSvdLXXM3ApEdB16e8bwwK3CTtr6Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liao Yuanhong <liaoyuanhong@vivo.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 132/262] wifi: iwlwifi: Remove redundant header files
Date: Mon, 13 Oct 2025 16:44:34 +0200
Message-ID: <20251013144330.876971816@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
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

From: Liao Yuanhong <liaoyuanhong@vivo.com>

[ Upstream commit b4b34ba66443696cc5f3e95493f9d7597259b728 ]

The header file "fw/img.h" is already included on line 9. Remove the
redundant include.

Fixes: 2594e4d9e1a2d ("wifi: iwlwifi: prepare for reading SAR tables from UEFI")
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Link: https://patch.msgid.link/20250819121201.608770-2-liaoyuanhong@vivo.com
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 81787501d4a4f..11704163876b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -12,7 +12,6 @@
 #include "fw/api/phy.h"
 #include "fw/api/config.h"
 #include "fw/api/nvm-reg.h"
-#include "fw/img.h"
 #include "iwl-trans.h"
 
 #define BIOS_SAR_MAX_PROFILE_NUM	4
-- 
2.51.0




