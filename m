Return-Path: <stable+bounces-122287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417EDA59EC8
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164BF16966C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D10231A51;
	Mon, 10 Mar 2025 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dgWiYtxe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138822ACDC;
	Mon, 10 Mar 2025 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628066; cv=none; b=IxvgIYv7Ec4poc+9HvyzULw/IxLH2m2qiOcACo0sUd9pAWyM9ao4dNbnTWULbaWsiv6YWQlhwxSypCaKVSr+WPqMkeR6ScP6X10LJRuewpNPwKZXL+/qkuv/4hJaP8ihnVk1kHIvgRRXVqz/tq9u33vJt236NNAkV6JIXx98NO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628066; c=relaxed/simple;
	bh=YlWWE5WGsLRXXLbV02smAgjPt7sAqHd9kwWYPNQ5WLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGguNm0ED/MivIUKxWRg8weqireHUddEM3V3iDaPqLkafIDPRXMB2otwGFRCe6DZrckmWUNKTTwDMwbl2MXSUJP4lz7ozH9dGDzBSlnvWIwqm1JO9RUfcS9Y2OYjSZqL2N3bum2WYJitR0fFsGfsfx7TGrnNISpfzWOVgQkbOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dgWiYtxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D50C4CEEC;
	Mon, 10 Mar 2025 17:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628065;
	bh=YlWWE5WGsLRXXLbV02smAgjPt7sAqHd9kwWYPNQ5WLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgWiYtxe7vScghm7+cU2XTR/RNes6w9ym4WgHLiksLyX8aCMIYtT2G7pNvQBU8vj+
	 EIs+sTMCFpyFALeu/HFbcLaAv6j/0BEfM9Pz3zIg9DTS3yEG/T7GrwtvdJ/50WtThU
	 etguDne+fmrd5a6CzT6RSSTvKY3n0qOXsDvvv5Eg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peiyang Wang <wangpeiyang1@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 076/145] net: hns3: make sure ptp clock is unregister and freed if hclge_ptp_get_cycle returns an error
Date: Mon, 10 Mar 2025 18:06:10 +0100
Message-ID: <20250310170437.820833797@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
References: <20250310170434.733307314@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peiyang Wang <wangpeiyang1@huawei.com>

[ Upstream commit b7365eab39831487a84e63a9638209b68dc54008 ]

During the initialization of ptp, hclge_ptp_get_cycle might return an error
and returned directly without unregister clock and free it. To avoid that,
call hclge_ptp_destroy_clock to unregist and free clock if
hclge_ptp_get_cycle failed.

Fixes: 8373cd38a888 ("net: hns3: change the method of obtaining default ptp cycle")
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250228105258.1243461-1-shaojijie@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index 507d7ce26d831..ddc691424c816 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -484,7 +484,7 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 
 		ret = hclge_ptp_get_cycle(hdev);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = hclge_ptp_int_en(hdev, true);
-- 
2.39.5




