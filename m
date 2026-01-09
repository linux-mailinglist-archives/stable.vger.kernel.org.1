Return-Path: <stable+bounces-207851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C57D0A51E
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 14:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 484F73192F89
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8C633B6ED;
	Fri,  9 Jan 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Smk5mFMV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FBC35A94D;
	Fri,  9 Jan 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963229; cv=none; b=JjtiZjd1W9+EwtayGhIKvhnalOfhJb7cIc3nPzq5jtIT13KU5xC2bYTlKfeeRC8c/kcu6/uyP/Ti9yeygQo9Akx04kckt9aqzzV8fcsOgXvug+UsIXiMr0ydofVMOlhArWd6jqSLVPXCx2UI8zcZlLAol2lVP6F+FzGYKwB0npE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963229; c=relaxed/simple;
	bh=VwhX+w6X6XUAykPQbp6xZs3844nOS0mk4kS7zFUrHJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jc64t/ia5ShDMwCGeffVgApfmaB9niMmJR8URFUiefUGNnq8gZIFhPtNkWuXoLvxWlCFVzwNkhMLFwOgE1976hrHu4cisErxNHYDXBnXxUqnFD2XOuQDQ+kuMONrJoz1QdflFfSrAV25DH3VuiKhmh3ofFLNAGHWm6EW+3SjcYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Smk5mFMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4646C4AF09;
	Fri,  9 Jan 2026 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767963229;
	bh=VwhX+w6X6XUAykPQbp6xZs3844nOS0mk4kS7zFUrHJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Smk5mFMVPwKa1XySassnlZ6LQAAsPhbMUNX4JPfkLA3SXg1zDPpL7G5xhdLaZCQwR
	 jyyLLEPnA7wQ98+iJmCMKcHGlkRY12aBc0qI3ACzOaElUjVurGmLRsLRM0JHYGVV7O
	 ZwmtlUdKPaBgt7HX1btIPTXaF0fcYlVkFPW+pL3E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1 626/634] net: ethtool: fix the error condition in ethtool_get_phy_stats_ethtool()
Date: Fri,  9 Jan 2026 12:45:04 +0100
Message-ID: <20260109112141.192661761@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

commit 0dcc53abf58d572d34c5313de85f607cd33fc691 upstream.

Clang static checker (scan-build) warning:
net/ethtool/ioctl.c:line 2233, column 2
Called function pointer is null (null dereference).

Return '-EOPNOTSUPP' when 'ops->get_ethtool_phy_stats' is NULL to fix
this typo error.

Fixes: 201ed315f967 ("net/ethtool/ioctl: split ethtool_get_phy_stats into multiple helpers")
Signed-off-by: Su Hui <suhui@nfschina.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
Link: https://lore.kernel.org/r/20240605034742.921751-1-suhui@nfschina.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ethtool/ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2132,7 +2132,7 @@ static int ethtool_get_phy_stats_ethtool
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int n_stats, ret;
 
-	if (!ops || !ops->get_sset_count || ops->get_ethtool_phy_stats)
+	if (!ops || !ops->get_sset_count || !ops->get_ethtool_phy_stats)
 		return -EOPNOTSUPP;
 
 	n_stats = ops->get_sset_count(dev, ETH_SS_PHY_STATS);



