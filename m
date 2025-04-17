Return-Path: <stable+bounces-133902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F37A92887
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD97178F57
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F13C2571BA;
	Thu, 17 Apr 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tubiA3Qw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB642550C8;
	Thu, 17 Apr 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914493; cv=none; b=U0xvWC6sPdSpH2E+U8O7gHTjrQoS3nXFcJtRKO4wFT4DuIM2z3dpWzfQqnKYgS+t9b44mV543CHqxS/QgbAC1zpy1YGCszw3TjOivPg50zRZwEAtHJ4Iq4y0G13RNFQW9VnjWs0otOvi3HO9LGPuDXujt7Dw+RgDh75NsYpDPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914493; c=relaxed/simple;
	bh=ANCYi6eMwv3IQMNsIBsgWY25xOntJYG+rJTvPXpCwT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2XsU/bl7sUEuusU8UexppEuQDZ2KzXBRS9aT5rn6AasTF65DbZQ3e8c7M9hu5uaorxTAiQ8zMQ8Dn2ZtuzQV0xlw41rLya2wMgdqsl4ThuahMVheKm0LEE0oZes5tKbd2lRs6p7AU6X9Di43MEZHvkZW5lykv472Q9zz13MTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tubiA3Qw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9261C4CEE4;
	Thu, 17 Apr 2025 18:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914493;
	bh=ANCYi6eMwv3IQMNsIBsgWY25xOntJYG+rJTvPXpCwT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tubiA3Qwq7VR1QJvgjRZTn5ZXd4FDRbIo/q9ktbuwHvZ6FPJHMIboiOA1nu99UmNZ
	 Y2DOHMmlvjP+xfp0yMA2YSeA7PkJNW8UAree5NWLg/NdDMy7uxCmkEjUsZGWutSwW7
	 QYymceM+r1pxCQNE5Ppc4rxnp20oroBfLhx+XrwY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.13 233/414] media: i2c: ov7251: Introduce 1 ms delay between regulators and en GPIO
Date: Thu, 17 Apr 2025 19:49:51 +0200
Message-ID: <20250417175120.803622170@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 3d391292cdd53984ec1b9a1f6182a62a62751e03 upstream.

Lift the xshutdown (enable) GPIO 1 ms after enabling the regulators, as
required by the sensor's power-up sequence.

Fixes: d30bb512da3d ("media: Add a driver for the ov7251 camera sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ov7251.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -922,6 +922,8 @@ static int ov7251_set_power_on(struct de
 		return ret;
 	}
 
+	usleep_range(1000, 1100);
+
 	gpiod_set_value_cansleep(ov7251->enable_gpio, 1);
 
 	/* wait at least 65536 external clock cycles */



