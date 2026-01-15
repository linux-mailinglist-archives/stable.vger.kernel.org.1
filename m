Return-Path: <stable+bounces-209920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B61D2786C
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86C7230CDAE8
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBB53D348B;
	Thu, 15 Jan 2026 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WFtM/uu3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691203BF2FC;
	Thu, 15 Jan 2026 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500069; cv=none; b=KkBSgHhoyMw1VvzbI+vP1LjUU11zW2WTLbZtBh0Uh16xEsCTm+P219zbTPo6y/9/HOfmX+9ZfflueRsCN9OdSTnzCbW1lGnIL/xjXmtuwXU/pTCVG3Y6Q+Qag9MxK2RSo/K0ufdu+dw0BFVz6ASbNZLnI9d1O+B/FtxfnABmwXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500069; c=relaxed/simple;
	bh=zECb5k6D/MXOVIWqHSPjOmXWFKBAc3ngwqkbhUDw7P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxHwtBDbtsOCQAhQlW8UwUA24N74qRnIMq6gdL9otNZCDi7GHRw1x3fk6z/gien3WTKtfMQ4B9cEkd3Xe5kCo2j6QcYpG3ZVzvpr8NEyg31tfPTTld3ijV3qOkv5Q7o2+1oZ1TEQryUhYSE9gBnY9XTvWtfD7+gI7jOWHdUUmL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WFtM/uu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFE6C116D0;
	Thu, 15 Jan 2026 18:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768500069;
	bh=zECb5k6D/MXOVIWqHSPjOmXWFKBAc3ngwqkbhUDw7P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFtM/uu33qoiVsiyB8WW+OQzmq1jM8iNpJacmLXTnWGdCg3GPxMx8BpppHrkbzydU
	 iC+1aFb43rBOACFsqsRTMesCuRz/ZSUA0EuDZFVtRrpAiB4TAbQXDzmvtX0pZ9TFcM
	 MiAExVlhqUhqH3GI5I6oCl1aUZugZYCqGj891J8g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqian Lin <linmq006@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH 5.10 414/451] drm/pl111: Fix error handling in pl111_amba_probe
Date: Thu, 15 Jan 2026 17:50:15 +0100
Message-ID: <20260115164245.915686244@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
References: <20260115164230.864985076@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaoqian Lin <linmq006@gmail.com>

commit 0ddd3bb4b14c9102c0267b3fd916c81fe5ab89c1 upstream.

Jump to the existing dev_put label when devm_request_irq() fails
so drm_dev_put() and of_reserved_mem_device_release() run
instead of returning early and leaking resources.

Found via static analysis and code review.

Fixes: bed41005e617 ("drm/pl111: Initial drm/kms driver for pl111")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20251211123345.2392065-1-linmq006@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/pl111/pl111_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -302,7 +302,7 @@ static int pl111_amba_probe(struct amba_
 			       variant->name, priv);
 	if (ret != 0) {
 		dev_err(dev, "%s failed irq %d\n", __func__, ret);
-		return ret;
+		goto dev_put;
 	}
 
 	ret = pl111_modeset_init(drm);



