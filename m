Return-Path: <stable+bounces-208861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B09D26454
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7464314DD9B
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360A25228D;
	Thu, 15 Jan 2026 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Exs/P1jK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D562D781B;
	Thu, 15 Jan 2026 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497052; cv=none; b=PqNl+H8LEkexb4Si7PvjSGbCjBrr5Hpz8up2DwUDshK7gD0ZaaZSOldCS1DnEXuEKbmx4FMp1OiqD7ynLaAAzQ3EtKlzL0awlyEvQwAE/+Oq6g2Sj5Xrr8snJ/pX5QufcCY3nTwJ8/3S/CsB6Cc8xZ+tLEbOiY9oJn0RSvLj9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497052; c=relaxed/simple;
	bh=zpCmZmMwYUzU9DF6avncuHNEa4n6KXJ/zu3TmBaVO8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9Qq8j0AW2bHH1p5sX8xqOTac0gW8HAKWjN+VcCWRQLNmNrNuT3rM8ij9C5oePTKgSrLGpheq02RMRD7R324GuIOQGdjygZLSkQ//ohy3K8g91IBp1GK3MA0qxUvHxkj/qM0+sVsg3Z/GyeOh5zbn8I55HMfZtBPycKkfVlXE/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Exs/P1jK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F08C116D0;
	Thu, 15 Jan 2026 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768497051;
	bh=zpCmZmMwYUzU9DF6avncuHNEa4n6KXJ/zu3TmBaVO8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Exs/P1jKV+QsW53NiPPOPs3sdUnAFwuuj1N/kvytAmKZ210+4ZRWkKo49COyDYCUr
	 0Bs/axMwjO9lvear5Wrwfqp6GLRiDotaCnIYLOi8UQFaOk1Cmr5avtEerrSeVoiKAw
	 b/ufeicpqVDU/2MvE1kd/dCHQ3fWS08a1AAfy1Jg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqian Lin <linmq006@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH 6.1 07/72] drm/pl111: Fix error handling in pl111_amba_probe
Date: Thu, 15 Jan 2026 17:48:17 +0100
Message-ID: <20260115164143.757582067@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164143.482647486@linuxfoundation.org>
References: <20260115164143.482647486@linuxfoundation.org>
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
@@ -297,7 +297,7 @@ static int pl111_amba_probe(struct amba_
 			       variant->name, priv);
 	if (ret != 0) {
 		dev_err(dev, "%s failed irq %d\n", __func__, ret);
-		return ret;
+		goto dev_put;
 	}
 
 	ret = pl111_modeset_init(drm);



