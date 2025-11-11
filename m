Return-Path: <stable+bounces-193367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCDCC4A29B
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C033AD849
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8661F5F6;
	Tue, 11 Nov 2025 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iPHwvXb8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84017262A;
	Tue, 11 Nov 2025 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823014; cv=none; b=S7mfOGPTZYecLmo7P/wexgeKl5lP0WSIggMMs8w4HTmbqcU7wEeMLAaPpQXJS7zfZ2iilGvPvpdESdbvyiXCF3lQw9fPVOHuVfvV89oQM1HLm4bsL868rydlvHKksP31y12rBrmVbTOTsQzu9Y5J1Jq4YPikUk2VdvUjZcurSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823014; c=relaxed/simple;
	bh=f3RaFVc/+bVJY8ywjHF7bCzFSPFyQeqb8r1WkIKzNIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJV74fwjCaU0EDng4TQEMSMZQe+7b428KtseMtnNXsXU+0kL2x3dayzj45Y24XMCuUPtYm7W8xP3/rPTM+oy4vpSqwx+So/2zdNZiAAYyEeK9R21AZUjZlRlFsaYqeSdz99UjJgYWxINCLigP0TFkydgvQmS28fF+aqf8bYP1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iPHwvXb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048D3C4CEF5;
	Tue, 11 Nov 2025 01:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823014;
	bh=f3RaFVc/+bVJY8ywjHF7bCzFSPFyQeqb8r1WkIKzNIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPHwvXb8btINr3O5gRIZ4V4lO0s/hPe55P7wdfF7TGF1YCgd1HJXUSfK9bEUm81tc
	 b+wqjNHWzWMTVqFqnyD0OCtO1srVnnhPPFMg8gC5AXKmCREDuYy6pl7WwnZXPCLkvq
	 R6Ej7SccytqKCwS0I+30WbNEuBKHVrP4frbk6zng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 214/849] tools/power turbostat: Fix incorrect sorting of PMT telemetry
Date: Tue, 11 Nov 2025 09:36:24 +0900
Message-ID: <20251111004541.615777383@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit cafb47be3f38ad81306bf894e743bebc2ccf66ab ]

The pmt_telemdir_sort() comparison function was returning a boolean
value (0 or 1) instead of the required negative, zero, or positive
value for proper sorting. This caused unpredictable and incorrect
ordering of telemetry directories named telem0, telem1, ..., telemN.
Update the comparison logic to return -1, 0, or 1 based on the
numerical value extracted from the directory name, ensuring correct
numerical ordering when using scandir.

This change improves stability and correctness when iterating PMT
telemetry directories.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 72a280e7a9d59..931bad99277fe 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1890,7 +1890,7 @@ int pmt_telemdir_sort(const struct dirent **a, const struct dirent **b)
 	sscanf((*a)->d_name, "telem%u", &aidx);
 	sscanf((*b)->d_name, "telem%u", &bidx);
 
-	return aidx >= bidx;
+	return (aidx > bidx) ? 1 : (aidx < bidx) ? -1 : 0;
 }
 
 const struct dirent *pmt_diriter_next(struct pmt_diriter_t *iter)
-- 
2.51.0




