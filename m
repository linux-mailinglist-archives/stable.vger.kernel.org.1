Return-Path: <stable+bounces-54178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9FC90ED0A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B2B1F2120C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48109143C4E;
	Wed, 19 Jun 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SmjWYfHv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A81422B8;
	Wed, 19 Jun 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802813; cv=none; b=nxqSLA6Sh0tAxkW/Zb1MnEneACIHwMOyD52uS7vFZL3LVq91fsWh41oEtMOiw7XrXeLbXhTUh27JatFi/BOStekpBCuADGBsDyDItJghhh78Dt22WHSaGHkGE8HlAvJBPmJYlI104/235sb2SttSfdmVFjUmCXxec1KcEZs13ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802813; c=relaxed/simple;
	bh=AY1Hf1s1FZ7nEStZ6F/iTZcIFAo71VmRVXiPX8j79jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flIZXJKr45HaV6EjsYmecrhqLQK7z4z/gQsjWobwIf8FW9SNNKB2jrTjKF1iwzwhKeMKV7cprEHpTGAzlXDXmg9W1ORXH/QjmjyCdVBdZNwsIGBsdqFqi5rmY/KdCpCxMDSikxOy83KH/IrPjP5drlv2g3sHSG0rnuZ/7/O1pKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SmjWYfHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF0CC2BBFC;
	Wed, 19 Jun 2024 13:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802812;
	bh=AY1Hf1s1FZ7nEStZ6F/iTZcIFAo71VmRVXiPX8j79jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmjWYfHvu2XHPfqor5y5Glzv6rpG4onjcTxbAL+vfADjlnp8KhCLCqci7cZHpVew+
	 GLgfdrkJhctXoq0yBkiu89HeVkr5Vw9BtzpYm8d+/nKO8EAhrKhntygsPOWHTyO6BH
	 mgaHPOuhsds4PTmC3WwHeoLB5ZPZZcVTJjwfDru8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 056/281] net: wwan: iosm: Fix tainted pointer delete is case of region creation fail
Date: Wed, 19 Jun 2024 14:53:35 +0200
Message-ID: <20240619125612.006525434@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandr Mishin <amishin@t-argos.ru>

[ Upstream commit b0c9a26435413b81799047a7be53255640432547 ]

In case of region creation fail in ipc_devlink_create_region(), previously
created regions delete process starts from tainted pointer which actually
holds error code value.
Fix this bug by decreasing region index before delete.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4dcd183fbd67 ("net: wwan: iosm: devlink registration")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240604082500.20769-1-amishin@t-argos.ru
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wwan/iosm/iosm_ipc_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_devlink.c b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
index 2fe724d623c06..33c5a46f1b922 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_devlink.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
@@ -210,7 +210,7 @@ static int ipc_devlink_create_region(struct iosm_devlink *devlink)
 			rc = PTR_ERR(devlink->cd_regions[i]);
 			dev_err(devlink->dev, "Devlink region fail,err %d", rc);
 			/* Delete previously created regions */
-			for ( ; i >= 0; i--)
+			for (i--; i >= 0; i--)
 				devlink_region_destroy(devlink->cd_regions[i]);
 			goto region_create_fail;
 		}
-- 
2.43.0




