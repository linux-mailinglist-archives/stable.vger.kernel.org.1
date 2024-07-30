Return-Path: <stable+bounces-63710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16706941A40
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9465282EC8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946D8183CD5;
	Tue, 30 Jul 2024 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ihsDwMbc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544041A6192;
	Tue, 30 Jul 2024 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357706; cv=none; b=JgoQoc84fhRE/rd/QR8+4HkW6KQ+CSoM9MKO98CSLdZTj6y+E5B44+Um7R41JJNXt4YZi0t5VXYM/NXHIZxH8XgIi4UGynhHZ4bilyl38dr0ET4JYPh78SOTK3jt6nR1jS5dlcGvHlhaibyah5amKk+HhAjneyyo2487qoEfOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357706; c=relaxed/simple;
	bh=/voysrC3ku3HIsd0OC48C2DPTkqOPMhHhFxgAEhbhms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDjpfPgo1IWrhbWWpoPhCEFddpp4LXcfg4i/vL7vA3tUGVnFP3vqN3ZcHTL5rik40N62KfI8dwx8jHjkWaawk0T0jck3QPlhQLwhJ2GpFmgtcMvE6qsMncrgsHwPZkAEo09380bxjZsxkcAtnhuwJyvDEeNZh4V+iWCrVd/FZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ihsDwMbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA543C4AF0A;
	Tue, 30 Jul 2024 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357706;
	bh=/voysrC3ku3HIsd0OC48C2DPTkqOPMhHhFxgAEhbhms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihsDwMbcy83TeZ+0K62/hen5K/An5IriWlFci5wmqKGAWdUQY6USFM6vf+9Be0MqA
	 skANXBGOtrDJy7t7aQj5EXpyKcl2+zh2Lbyjh8Zi2fNScW/SAUSTX6Rn2f9d+X1MyJ
	 JOlur0PCiGY8e8NhNbp9GJ8NqS84YJto0LSKiuEA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 283/568] Input: elan_i2c - do not leave interrupt disabled on suspend failure
Date: Tue, 30 Jul 2024 17:46:30 +0200
Message-ID: <20240730151650.936157438@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 5f82c1e04721e7cd98e604eb4e58f0724d8e5a65 ]

Make sure interrupts are not left disabled when we fail to suspend the
touch controller.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Link: https://lore.kernel.org/r/ZmKiiL-1wzKrhqBj@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/elan_i2c_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 148a601396f92..dc80e407fb860 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1356,6 +1356,8 @@ static int elan_suspend(struct device *dev)
 	}
 
 err:
+	if (ret)
+		enable_irq(client->irq);
 	mutex_unlock(&data->sysfs_mutex);
 	return ret;
 }
-- 
2.43.0




