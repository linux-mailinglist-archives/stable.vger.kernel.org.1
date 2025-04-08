Return-Path: <stable+bounces-130035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C266A802BE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0346446AC5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74C227EBD;
	Tue,  8 Apr 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IazpNWoZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039C2288CB;
	Tue,  8 Apr 2025 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112640; cv=none; b=KOU6KPLFuktJL5jpdDLm/pqcasbXrNaaKiPudOaSdjqdwqFhGevWCoLTWY8fQ0LtJLlfF+scKGNyDZyurMTW4zl/+Jz3yuZMGKrExIA/n6MLdcEecJPPDgLPXqilzEB38tLLNPPg3hCdaMkIj7mbmWYI40UBjHKC++9A8EvQ/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112640; c=relaxed/simple;
	bh=ySeDzHixvBZXbKyRHKqYOvaKq0wjSYmXSngA/GiBxZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQdxpBEKI6Af77ERhq/GaphSH805ofCE1xFIOZLq+sTK7URSlJLaWzIqX+Qv7jJqE9I8pK9YJx4fSlk6fHrm0ZMgmKQFwVPiz2ObHOamADbX8+eLQAYphL4l1VjiT0tB+Irmu1LOpgfuBrKlOknUjaXB9gM7zSypedWIMiytPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IazpNWoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815FAC4CEE5;
	Tue,  8 Apr 2025 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112639;
	bh=ySeDzHixvBZXbKyRHKqYOvaKq0wjSYmXSngA/GiBxZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IazpNWoZ7IMU+1XHROFTwR0UE6TzshtTrcJleWqzNRZM66OJ82JUKIL84csutV680
	 ONt/3OFXZsJJrCnuWU54gmaeBxBjl0LLFkCO436EMpgcLCv76z4tEEVXjXHYrqnlS+
	 YbBfj+6bZIMvpVgJqWW3yCMNCvVPdeLQ7C61Q7A4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 143/279] media: platform: allgro-dvt: unregister v4l2_device on the error path
Date: Tue,  8 Apr 2025 12:48:46 +0200
Message-ID: <20250408104830.200953425@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit c2b96a6818159fba8a3bcc38262da9e77f9b3ec7 ]

In allegro_probe(), the v4l2 device is not unregistered in the error
path, which results in a memory leak. Fix it by calling
v4l2_device_unregister() before returning error.

Fixes: d74d4e2359ec ("media: allegro: move driver out of staging")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/allegro-dvt/allegro-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/allegro-dvt/allegro-core.c b/drivers/media/platform/allegro-dvt/allegro-core.c
index 881c5bbf61568..f472eb19cd92f 100644
--- a/drivers/media/platform/allegro-dvt/allegro-core.c
+++ b/drivers/media/platform/allegro-dvt/allegro-core.c
@@ -3740,6 +3740,7 @@ static int allegro_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		v4l2_err(&dev->v4l2_dev,
 			 "failed to request firmware: %d\n", ret);
+		v4l2_device_unregister(&dev->v4l2_dev);
 		return ret;
 	}
 
-- 
2.39.5




