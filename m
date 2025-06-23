Return-Path: <stable+bounces-155662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB64AE42B0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE0A07A387C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB49248191;
	Mon, 23 Jun 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T5DrZR+z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D349253B66;
	Mon, 23 Jun 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685009; cv=none; b=kW3mphEeUKa374OzrlOoMRqvqPhj3rvS42F+MQVn5ba49i4kgNAHTiKpETXLFeK2n8LHJ4qpFyDds0DgB77JjX73yTYBrrHSfi6uIi0UMQ8BHzr8065bxIcNBDP8TMr3CMmjDUf/VOAifUy7L/ec/iXOcrz8pBVVn82FxMe9A7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685009; c=relaxed/simple;
	bh=m5gTLrsJI1CWmHysaVqdiUnqVQt03M78TGVh/0ewZYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTspJaS+rG15l+qgZG9lSBP5PVw/wOSNs9r42SiIBmWsjwrTINS5JmzQKEbjeAVnG0jK2GKKsiQ3+p2Pr76vGdeOJ9ARH+UzccZ3ysGRgsDJWGsTvDOp/5KFE98082hx8ET9gcNCt5DR6vV6TOo6c7NEtlSFQUc68DjwevO3jxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T5DrZR+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407F5C4CEEA;
	Mon, 23 Jun 2025 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685008;
	bh=m5gTLrsJI1CWmHysaVqdiUnqVQt03M78TGVh/0ewZYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T5DrZR+zgyM5UqrW3f3AZP0GY7pITZkgx7XzCu5sjEvbCDCKeuhl5xFInCw55ePcw
	 H2xXJeoTBcN+lkBlwf+TROMZknoBsMs7/k7BDZmNgvbLPGvhQ8evjN/YueF3hPO+Zd
	 FStD1KkZIkMNvpFhAs1/1ldTn8chIHk1xnQPrLHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 057/222] rpmsg: qcom_smd: Fix uninitialized return variable in __qcom_smd_send()
Date: Mon, 23 Jun 2025 15:06:32 +0200
Message-ID: <20250623130613.826045330@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 5de775df3362090a6e90046d1f2d83fe62489aa0 ]

The "ret" variable isn't initialized if we don't enter the loop.  For
example,  if "channel->state" is not SMD_CHANNEL_OPENED.

Fixes: 33e3820dda88 ("rpmsg: smd: Use spinlock in tx path")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/aAkhvV0nSbrsef1P@stanley.mountain
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rpmsg/qcom_smd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index b5167ef93abf9..6facf1b31d463 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -746,7 +746,7 @@ static int __qcom_smd_send(struct qcom_smd_channel *channel, const void *data,
 	__le32 hdr[5] = { cpu_to_le32(len), };
 	int tlen = sizeof(hdr) + len;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	/* Word aligned channels only accept word size aligned data */
 	if (channel->info_word && len % 4)
-- 
2.39.5




