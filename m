Return-Path: <stable+bounces-201067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6ACBEEEB
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 17:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 529EC30166DC
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F3D2E6CCD;
	Mon, 15 Dec 2025 16:36:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DEA30FC27
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816605; cv=none; b=SGJixARhbiqJVwUbcnA+dChvtFL8N4EeUgn+UYjZeBpMq4WdFKwFx6eyDb3sb/Yq2US/5O3sX03WI2wsZypCn238h9YhrLkpPV7bghrKI8kj7JaCUsT8HA+LdvoAUInszQIQL+IocDCnCTOBTjF7QU33ndJPG+GrLaPAJbgIszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816605; c=relaxed/simple;
	bh=aCcOgMK6m3bJ6wWFFEg3ONUHuPWUvNETNYKfKJwmgbw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hX5traUPgFoo+s2cu1e9TwL2RsTmHo0ZZ7x5zgO0hYBvUPMoiNDIMhYbbgtM7iV9Vj+e4dZy+oKNvltG7cy9d1lu9wVs6fHB3JKRdPvt+kKBOz0A6w0MS0v41TGgnxz+KWnGbK1MdiwH4051YlveQiOiy0wWKlOLhnAwyt6L2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dVQgP6vGkz7BQ;
	Mon, 15 Dec 2025 17:36:33 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dVQgM0sMnzD5S;
	Mon, 15 Dec 2025 17:36:31 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 0/2] accel/rocket: fix unwinding in error paths of two
 functions
Date: Mon, 15 Dec 2025 17:36:13 +0100
Message-Id: <20251215-rocket-error-path-v1-0-eec3bf29dc3b@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBtI0/6uEi3EphqCjFEiiO6et
 PwW7z0QSZgiDMUDQhdHDkeGKgvwmztWQp6zQVfaKq00SvA7JSSRIHi6tOHSt53xpnG2qiF3p9D
 C9/8cp/f9ABGdXABjAAAA
X-Change-ID: 20251212-rocket-error-path-f9784c46a503
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha

As reported[1], in the current state of master (that is, *without*
that[2] patch, yet unmerged), it is possible to trigger
Oops/out-of-bounds errors/unbalanced runtime PM by simply compiling
DRM_ACCEL_ROCKET built-in (=y) instead of as a module (=m).

This fixes points 1 and 2 reported here[1] by fixing the unwinding in
two functions to properly undo everything done in the same function
prior to the error.

Note that this doesn't mean the Rocket device is usable if one core is
missing. In fact, it seems it doesn't as I'm hit with many
rocket fdac0000.npu: NPU job timed out
followed by one
rocket fdad0000.npu: NPU job timed out
(and that, five times) whenever core0 (fdab0000.npu) fails to probe and
I'm running the example from
https://docs.mesa3d.org/teflon.html#do-some-inference-with-mobilenetv1
so something else probably needs some additional love.

[1] https://lore.kernel.org/linux-rockchip/0b20d760-ad4f-41c0-b733-39db10d6cc41@cherry.de/
[2] https://lore.kernel.org/linux-rockchip/20251205064739.20270-1-rmxpzlb@gmail.com/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      accel/rocket: fix unwinding in error path in rocket_core_init
      accel/rocket: fix unwinding in error path in rocket_probe

 drivers/accel/rocket/rocket_core.c |  7 +++++--
 drivers/accel/rocket/rocket_drv.c  | 15 ++++++++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)
---
base-commit: a619746d25c8adafe294777cc98c47a09759b3ed
change-id: 20251212-rocket-error-path-f9784c46a503

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


