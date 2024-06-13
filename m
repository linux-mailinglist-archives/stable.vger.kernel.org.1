Return-Path: <stable+bounces-50931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37704906D7B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58E71F27BB4
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F114883C;
	Thu, 13 Jun 2024 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVfbvIAS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3039F1487E7;
	Thu, 13 Jun 2024 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279809; cv=none; b=PyEELhHGpiweSt54ZKjwffYXPYCOMGP/F6SNqSMdEXCQvcfzaBZFKRPIqupMWd5YPyQ4flFbp30JUQu+bxqSGA8MKqSV5qDtuk1NwfWWi3uPEK7f8XP4fqPFOmvNvn0usxXisd0PtuOUDbMVoHjkvPJYlTT0H9R5yzmYBf9mljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279809; c=relaxed/simple;
	bh=mO2TmSEhyAbspXCjPLwOsYNNHsamnSCUkVzTEh6v63Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRvnOsYx8GSKvbOqlWJkZ9iAtZqNuciKMvxpuTtVPQoZ75qgkAySVwEWXw/zSSzFuRF61az3O+0ctuly5LJvQBKnoM1GkBqKR1wlE7VeUiVtdVxedeSgUpdUnJdZBOfhj51nWfwLM9hDcXsnB61i8qhSb7DUL+kp0P8zNrrZ868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oVfbvIAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B95C2BBFC;
	Thu, 13 Jun 2024 11:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279808;
	bh=mO2TmSEhyAbspXCjPLwOsYNNHsamnSCUkVzTEh6v63Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVfbvIASegngtMnONS9z2sDq0gh6legyYKCoZDVDoxlkl8zDqXjMzSej04HXr8+Zw
	 weZ54xIGNaznb+nm4w2BVXpw6f1z/J0c+PbMRBroHhxrWC0BL5r+WTbrsOvdGWRssZ
	 c3rpHooG9biD5FH80oUTVVxVAP+ZUAnbKuEtBJwk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 043/202] wifi: ath10k: Fix an error code problem in ath10k_dbg_sta_write_peer_debug_trigger()
Date: Thu, 13 Jun 2024 13:32:21 +0200
Message-ID: <20240613113229.433564424@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

[ Upstream commit c511a9c12674d246916bb16c479d496b76983193 ]

Clang Static Checker (scan-build) warns:

drivers/net/wireless/ath/ath10k/debugfs_sta.c:line 429, column 3
Value stored to 'ret' is never read.

Return 'ret' rather than 'count' when 'ret' stores an error code.

Fixes: ee8b08a1be82 ("ath10k: add debugfs support to get per peer tids log via tracing")
Signed-off-by: Su Hui <suhui@nfschina.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240422034243.938962-1-suhui@nfschina.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/debugfs_sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index 42931a669b02f..17bc4255e2eac 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -438,7 +438,7 @@ ath10k_dbg_sta_write_peer_debug_trigger(struct file *file,
 	}
 out:
 	mutex_unlock(&ar->conf_mutex);
-	return count;
+	return ret ?: count;
 }
 
 static const struct file_operations fops_peer_debug_trigger = {
-- 
2.43.0




