Return-Path: <stable+bounces-74246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779C8972E43
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E07287CFD
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96618C00C;
	Tue, 10 Sep 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x/OgFaCK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE681885A6;
	Tue, 10 Sep 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961243; cv=none; b=Lm0rNKqEotxKAbJK9BRyQsNEYfUHIwgN0I5KKRQjlEXmEJoH7ag/D76j6rzUIWYMzMWh3FNPwAu0z1vhsyt1kUJFPcyDBwuuLR79DHXr8XMvdQ11Pey6FsrK5Tw4Ck8wxZ79S9L4PVW40tNV+tGf3exYiGtNhMu1uS7vKW9vdds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961243; c=relaxed/simple;
	bh=S7u2mu5HwsBA4b8I8NHZD+v10sGMYZJxVtyCfjFGP18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPjalPPflkwHQ4Ge6E4QFmEbACFRz0yktwVZcnEDM7KPnAs7XJhM4vcmDmNN0mDflcvW+McEwIyrmLnzC1sHsm3Yrn9jqy6A3bhlKvSdzT2zjWKfEjxxA5GmdYL8aOxjP8alqNNc3UTiZo9aXt21tEwZzddppqRRjO/gFVI6pMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x/OgFaCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6109C4CEC3;
	Tue, 10 Sep 2024 09:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961243;
	bh=S7u2mu5HwsBA4b8I8NHZD+v10sGMYZJxVtyCfjFGP18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x/OgFaCK2yaYzD+Dey/7YLOho5Ybhdnz3pu/CqByJSCyHirtxLEy2FCZa+mjgfoLN
	 YpaBR+XpX7yaUNeL+epvcd5hw2c431Z7WbBHwPvo6X1Kj9EO7XI8RkjNQW2vNlqNB9
	 LVlpIRf9eabbMYcUXLvZuYeScy4PTF/lC7e5gnKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hulk Robot <hulkci@huawei.com>,
	Zhang Changzhong <zhangchangzhong@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 94/96] cx82310_eth: fix error return code in cx82310_bind()
Date: Tue, 10 Sep 2024 11:32:36 +0200
Message-ID: <20240910092545.670090078@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092541.383432924@linuxfoundation.org>
References: <20240910092541.383432924@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Changzhong <zhangchangzhong@huawei.com>

commit cfbaa8b33e022aca62a3f2815ffbc02874d4cb8b upstream.

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: ca139d76b0d9 ("cx82310_eth: re-enable ethernet mode after router reboot")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
Link: https://lore.kernel.org/r/1605247627-15385-1-git-send-email-zhangchangzhong@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cx82310_eth.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -213,7 +213,8 @@ static int cx82310_bind(struct usbnet *d
 	}
 
 	/* enable ethernet mode (?) */
-	if (cx82310_enable_ethernet(dev))
+	ret = cx82310_enable_ethernet(dev);
+	if (ret)
 		goto err;
 
 	/* get the MAC address */



