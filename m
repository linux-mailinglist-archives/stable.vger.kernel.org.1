Return-Path: <stable+bounces-135902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1324BA9912C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F89D1B67B74
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605EA28E61A;
	Wed, 23 Apr 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wxsMh+zU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBFF2820C2;
	Wed, 23 Apr 2025 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421142; cv=none; b=Ta+DMPQDCC+CF9Kt2yBOpq6hRp2ib1Lczd/3Q3XbJSE7ed3atu2GR1ANQvD3NMtvLxUwggKJEsc0NbTDS/K2wOCr0p1kDjjvTKXsAtCNJZMgv+fVdZ0goOaFDy/grT/Qs/J2O4CgEHneBltYziLcP+9V4AvghbJ6wlEHDbWEJig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421142; c=relaxed/simple;
	bh=Mhdq/0WRAIpj69J76ojodh9UgaOgAtqz6QdHzJBVoD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5B55A+RG57iI9MhkofoZGGQ+t3G02BeFwhQlVUaK6B9mHDjkdTFX2iXtrYIgcqSDclrf1zWtt1qzFHEVFteXqvcg9cP3N3BtoY2AqEOKL83MGkjyV7fnyTt0sYXd83hYdHCYMhYVM1YShpYmab2QP9TB0unsMHNt8DMnlA5vAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wxsMh+zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FDFC4CEE2;
	Wed, 23 Apr 2025 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421142;
	bh=Mhdq/0WRAIpj69J76ojodh9UgaOgAtqz6QdHzJBVoD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wxsMh+zUprAt1de0dAU3ZF9ER5DAPdqmgfLJUJwtbJ/EyF+1K5/7LcKLiQKdDqqvk
	 41/+crECqEBpduopZfzdwcbk0hEDXdRPtsicWUnPhdpVqxGYL70AaSHe4r1MNeWTuX
	 YFX1RDEn4GalS75smSszP7aUS71b2DM0onCn9ZzQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.6 141/393] media: i2c: ccs: Set the devices runtime PM status correctly in probe
Date: Wed, 23 Apr 2025 16:40:37 +0200
Message-ID: <20250423142649.199773876@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 80704d14f1bd3628f578510e0a88b66824990ef6 upstream.

Set the device's runtime PM status to suspended in probe error paths where
it was previously set to active.

Fixes: 9447082ae666 ("[media] smiapp: Implement power-on and power-off sequences without runtime PM")
Cc: stable@vger.kernel.org # for >= v5.15
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ccs/ccs-core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3651,6 +3651,7 @@ static int ccs_probe(struct i2c_client *
 out_disable_runtime_pm:
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 
 out_media_entity_cleanup:
 	media_entity_cleanup(&sensor->src->sd.entity);



