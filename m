Return-Path: <stable+bounces-219030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEy5GJtYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-219030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:04:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCA7190791
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 138B0312C5B8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB15288C08;
	Wed, 25 Feb 2026 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ALFm9gO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9358023D7CF;
	Wed, 25 Feb 2026 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983944; cv=none; b=SoaOj1oD8ICXbPxxhz4xYUinWlfVgnb8RUOQYaqoPRuQHfpASIjlFLWfPAdjpSrwdHGQki5WKqDbIpkM6fm9x4Dt3MF7FtiOad2a09zRPmUFyFdLrzw5jDc4c2IUavifRGSeqJbkSars3rAhaSkFxjIyOIpB3S6w2xGX7NFCObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983944; c=relaxed/simple;
	bh=tgNAL18gPHSjc5cd0THcOqC8vviZXZLIGqG0x3WihiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEswuc5oBe9BnitWrhnI35ImLl7+6LaCp3SVX8hImK+GIrrC0yUtWnnvT42yEtg8zZqpTVQCn/lmdRyyYodhArIKz9p7zqpqA5cxTQzFQXWVVHj6/fcwiaGmt5AleyAKEREGgmNIyHlblxN56EzLTCxUGAVcuQD4SiDGtj7bNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ALFm9gO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531D8C116D0;
	Wed, 25 Feb 2026 01:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983944;
	bh=tgNAL18gPHSjc5cd0THcOqC8vviZXZLIGqG0x3WihiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ALFm9gO2UXgDgWIbC4/S80DXT0q4Y2VLzW07CsdlIh9hfWXcZc28ZbpCUejb4g27
	 ZvESTi8wVoynt7R+8mQR9Arz3tCF+gds9Nuo9djw+HjTUaOr+SS/dDfU3RF5PfywqB
	 5XMvM/bFyJYJGMO8lyKeUKxuyw8d1BydZH9kgT4s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baihan Li <libaihan@huawei.com>,
	Yongbang Shi <shiyongbang@huawei.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Tao Tian <tiantao6@hisilicon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 208/641] drm/hisilicon/hibmc: Adding reset colorbar cfg in dp init.
Date: Tue, 24 Feb 2026 17:18:54 -0800
Message-ID: <20260225012353.995376140@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219030-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hisilicon.com:email,msgid.link:url,qualcomm.com:email,huawei.com:email]
X-Rspamd-Queue-Id: AFCA7190791
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baihan Li <libaihan@huawei.com>

[ Upstream commit 6dad7fa8581e96321ec8a6a4f8160762466f539a ]

Add colorbar disable operation before reset chontroller, to make sure
colorbar status is clear in the DP init, so if rmmod the driver and the
previous colorbar configuration will not affect the next time insmod the
driver.

Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Tao Tian <tiantao6@hisilicon.com>
Link: https://patch.msgid.link/20251210023759.3944834-5-shiyongbang@huawei.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index 8f8ca940b6b26..d5bd3c45649b2 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
@@ -180,6 +180,8 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
 	/* int init */
 	writel(0, dp_dev->base + HIBMC_DP_INTR_ENABLE);
 	writel(HIBMC_DP_INT_RST, dp_dev->base + HIBMC_DP_INTR_ORIGINAL_STATUS);
+	/* clr colorbar */
+	writel(0, dp_dev->base + HIBMC_DP_COLOR_BAR_CTRL);
 	/* rst */
 	writel(0, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
 	usleep_range(30, 50);
-- 
2.51.0




