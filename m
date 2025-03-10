Return-Path: <stable+bounces-121815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2FFA59C74
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E972016E869
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD9D231A2A;
	Mon, 10 Mar 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NnndaZmA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA0322D4D0;
	Mon, 10 Mar 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626709; cv=none; b=MQeJVCwAzpFHB2oNzmNrydKTmVweMhtIYhlkXRQAmCpCX10IKoTrI4QmRQSoGmS9fPkf3VOuJuI6PBopgaHT2U6zgpNROScdMEM0UO9X7jD+qAIyyhsPuo59kDG3ssOK8lKMPAvtDoQwv5bh4h9PyQNRzP0XI1v70HHjOYoUvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626709; c=relaxed/simple;
	bh=Uaky2OeujrR2+EYSttA4yBYcsXqoHJmmtU/dFpACItg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DK5s0iiQvmGf2W63BBzRHjAIiSQK+hbGCbES81HRxSHNYbGZgDlqluKjy/ciJY+MLbvpQnabyMJUp1fzRNwwH1Xi5078tg3/Q8kzz/AiTz9TLcJACy/ipe0v0Yij196wFYjqonPUg10p8nzobTAp8LKJamwtjBxiPofNEbKWMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NnndaZmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6136C4CEED;
	Mon, 10 Mar 2025 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626709;
	bh=Uaky2OeujrR2+EYSttA4yBYcsXqoHJmmtU/dFpACItg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnndaZmAq8DZXgks2/fO0+RoiaUlWo+teIFQQ6s+30k3xke0j8rMR9zFWtD3e7PGd
	 tIw+/4xkcmO2JI9S6gKBf2Ssav1xhG8oXQSNQ595KrDI5gbTLqgo+P/xWkEdufENPE
	 +lJ0b+CsaqGnByvXpHnHHSPDN3u8RJ58LGRy/4s8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 086/207] wifi: iwlwifi: limit printed string from FW file
Date: Mon, 10 Mar 2025 18:04:39 +0100
Message-ID: <20250310170451.181414482@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit e0dc2c1bef722cbf16ae557690861e5f91208129 ]

There's no guarantee here that the file is always with a
NUL-termination, so reading the string may read beyond the
end of the TLV. If that's the last TLV in the file, it can
perhaps even read beyond the end of the file buffer.

Fix that by limiting the print format to the size of the
buffer we have.

Fixes: aee1b6385e29 ("iwlwifi: support fseq tlv and print fseq version")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250209143303.cb5f9d0c2f5d.Idec695d53c6c2234aade306f7647b576c7e3d928@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index c620911a11933..754e01688900d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1197,7 +1197,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*fseq_ver))
 				goto invalid_tlv_len;
-			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %s\n",
+			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %.32s\n",
 				 fseq_ver->version);
 			}
 			break;
-- 
2.39.5




