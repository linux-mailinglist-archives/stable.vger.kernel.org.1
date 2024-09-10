Return-Path: <stable+bounces-75166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D165F973330
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7121F22536
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D79D19ABC5;
	Tue, 10 Sep 2024 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2vP4jM/G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE181990B5;
	Tue, 10 Sep 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963940; cv=none; b=QAMkvkIYA95dEAO183ELm5XpEY/NYqMyuzG6Ec1AfFuwqJCbFqcGnNjYDQgzVR9GqJyr+cZy6JdLGWO0Mpdc86fE+PpWXUSbatYu1ic3VwefVzVf5urDYJl/Rz4l/DdZqnSHdg+ZCgMeSV2WOjJ97//g9MjzUVkw3RUEDE4Wmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963940; c=relaxed/simple;
	bh=l3z0Ci4llG2iY0Kdurkcz7gws4kNUnh/4rlLVPYkVsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjfROAI5sAjqzKyFhsahyKRB9N8if83wZPTTniweJGXAVSAXjHyGJipz9fzc0tGvIsGhShwhPoVqONKaVR/PikHsop2MbtsyIEkFsJQVEpNNuUq7fDCsTs16w6247oTqsaOLEHqYgXP8kFWUDEADgNXZaaEYynYa5P1+XG+TGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2vP4jM/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57390C4CEC3;
	Tue, 10 Sep 2024 10:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963940;
	bh=l3z0Ci4llG2iY0Kdurkcz7gws4kNUnh/4rlLVPYkVsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2vP4jM/GTWJRKIGpeSgA3Vm3aq/lCkDKscJcIRO0UVqGpNs38p+MKbqlJWXuNYzDE
	 xAW6aDvMAdmSUdGLx0kX2u/gWs7O9pYZabLl7QLfQI/A96zmj7Ej/XMIwUT6JS2MgL
	 kR/8xb3UGWnWl8tB9UjlVn1gSHM9c98OTCXjHNUU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zheng Qixing <zhengqixing@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 6.6 014/269] ata: libata: Fix memory leak for error path in ata_host_alloc()
Date: Tue, 10 Sep 2024 11:30:01 +0200
Message-ID: <20240910092608.768390021@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Qixing <zhengqixing@huawei.com>

commit 284b75a3d83c7631586d98f6dede1d90f128f0db upstream.

In ata_host_alloc(), if devres_alloc() fails to allocate the device host
resource data pointer, the already allocated ata_host structure is not
freed before returning from the function. This results in a potential
memory leak.

Call kfree(host) before jumping to the error handling path to ensure
that the ata_host structure is properly freed if devres_alloc() fails.

Fixes: 2623c7a5f279 ("libata: add refcounting to ata_host")
Cc: stable@vger.kernel.org
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5593,8 +5593,10 @@ struct ata_host *ata_host_alloc(struct d
 	}
 
 	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
-	if (!dr)
+	if (!dr) {
+		kfree(host);
 		goto err_out;
+	}
 
 	devres_add(dev, dr);
 	dev_set_drvdata(dev, host);



