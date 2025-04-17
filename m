Return-Path: <stable+bounces-134305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E9A92A46
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EFA1B6444E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A23253324;
	Thu, 17 Apr 2025 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TuopsBPS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC9185920;
	Thu, 17 Apr 2025 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915724; cv=none; b=Kjf/oBbdJEgzTfPByM1hgzUqFuYl9grRJGHiu/KO3j6lnHY8kO502xSptZLFSxtngHXVr97RMrkg5x22H0ar8OLvi47YuPVhMvEvSQUhDWO+KSlZMDdiI7UtsOQrQV5TnLwkl+OmrRg35Xyf0K/L3ke/NPGBwylzylK+uRIFq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915724; c=relaxed/simple;
	bh=td73JABCtqTkudGwwXzdu0p0AJgkfLSnyjwDlWzQvm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7G2/P8pL6Bm/PE2nfueANwveeFGzCjyFF9gTtgTsyxvfhK7poV7qnUol0ZDfZnLikG0YQSCm5+FQQ8Ez5iddPv5q/RRhwDNyTOjcbIMdLzcOi7TqbZ+4jJdAKyXZZDeJaGt/h6oLHdwqyJa6jHUZbJZX6/kNHu200ToKozxrHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TuopsBPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBD3C4CEE4;
	Thu, 17 Apr 2025 18:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915724;
	bh=td73JABCtqTkudGwwXzdu0p0AJgkfLSnyjwDlWzQvm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuopsBPSfwU77shpVu45IC4FgkMLyzrEoLRPEp4ax14xb+xtLlKVf3XSClKUJR+IN
	 M6Qk6LOcTXLm9Ts0kq6X5VF+V0Ti2x95MHRAZaxmAJamGe+kqiun+nrjGTacd4aSD1
	 737vVWDbNvCze8yRY0IXQTsHvAuBtP3oWA7t8DDY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.12 218/393] media: i2c: ccs: Set the devices runtime PM status correctly in remove
Date: Thu, 17 Apr 2025 19:50:27 +0200
Message-ID: <20250417175116.353682893@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit e04604583095faf455b3490b004254a225fd60d4 upstream.

Set the device's runtime PM status to suspended in device removal only if
it wasn't suspended already.

Fixes: 9447082ae666 ("[media] smiapp: Implement power-on and power-off sequences without runtime PM")
Cc: stable@vger.kernel.org # for >= v5.15
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ccs/ccs-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3591,9 +3591,10 @@ static void ccs_remove(struct i2c_client
 	v4l2_async_unregister_subdev(subdev);
 
 	pm_runtime_disable(&client->dev);
-	if (!pm_runtime_status_suspended(&client->dev))
+	if (!pm_runtime_status_suspended(&client->dev)) {
 		ccs_power_off(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
+	}
 
 	for (i = 0; i < sensor->ssds_used; i++)
 		v4l2_device_unregister_subdev(&sensor->ssds[i].sd);



