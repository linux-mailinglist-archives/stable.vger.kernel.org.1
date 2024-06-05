Return-Path: <stable+bounces-48078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7C28FCC19
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D742B22DC8
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6E1974E0;
	Wed,  5 Jun 2024 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJyO1eFw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD088196C9A;
	Wed,  5 Jun 2024 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588446; cv=none; b=FfdgXBWvYj564nw16zccpfJIx9WvOYiWTWKdVh8Vqp7TCKwhvp2JkTjAAYNwwxyuOX/d5VEW2ZXE7bCWgWdxPnTNuePTgYVhJCr61rhBZk4RL2RVFbDOaj6lknU3r8vrKvxtnFK/xxa4JG83zjLvGNxW07NRbIpQqmMzlD/4fnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588446; c=relaxed/simple;
	bh=kiI/Lw2TK9Xytq4SD7omgBRD9aRnbSVuuUnrkQXDmf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5W/DffwO3Zt3DCpgqhUOt2/Dzy3kWd3cgINv2EB5p3qooDfUCbn2PDmGL7cr68vW3uCoye/9xyrmV1XTg8m+s4pc8YbkOal1EjOwr6KMSyj7fxfLd6uNaT3XerF//QLxa2MXt603q/9r+5Nqe72GQymzCEQoiX0MLT4/OedV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJyO1eFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E47C32786;
	Wed,  5 Jun 2024 11:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588446;
	bh=kiI/Lw2TK9Xytq4SD7omgBRD9aRnbSVuuUnrkQXDmf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJyO1eFwRmdFWdWSuTAeHp3tP1NPl6lcIciiTOT4dUbrmD5+QNRcsdHoCow6dENHj
	 OdV7irkqRA+RzFkcxPzYyx1MUFpjbpyUs1ZnRrkUKXC1Ux0QaPhs+RwRfdgvLUHQRY
	 /dSksl+xCjaGzkpU9IDHClr/K6oHGXm5eQpyq0lPApJQtJvzbDR+27HOXrPM869gy9
	 M0ptnwRX/pkIiFXT7HkeW//gYqhiJ77tl6TJfERy1lgKUz73+Agv58nOOeVFBcq/NN
	 jqy07aMuGbCbXlUH0pbpwWxxBWhRJ6XM3o9XS43yBsx4cLuXckaXfFu5tj8LfAtTKi
	 o1fN1FLWwM+Cg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sicong Huang <congei42@163.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	johan@kernel.org,
	greybus-dev@lists.linaro.org
Subject: [PATCH AUTOSEL 6.1 12/12] greybus: Fix use-after-free bug in gb_interface_release due to race condition.
Date: Wed,  5 Jun 2024 07:53:17 -0400
Message-ID: <20240605115334.2963803-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115334.2963803-1-sashal@kernel.org>
References: <20240605115334.2963803-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Sicong Huang <congei42@163.com>

[ Upstream commit 5c9c5d7f26acc2c669c1dcf57d1bb43ee99220ce ]

In gb_interface_create, &intf->mode_switch_completion is bound with
gb_interface_mode_switch_work. Then it will be started by
gb_interface_request_mode_switch. Here is the relevant code.
if (!queue_work(system_long_wq, &intf->mode_switch_work)) {
	...
}

If we call gb_interface_release to make cleanup, there may be an
unfinished work. This function will call kfree to free the object
"intf". However, if gb_interface_mode_switch_work is scheduled to
run after kfree, it may cause use-after-free error as
gb_interface_mode_switch_work will use the object "intf".
The possible execution flow that may lead to the issue is as follows:

CPU0                            CPU1

                            |   gb_interface_create
                            |   gb_interface_request_mode_switch
gb_interface_release        |
kfree(intf) (free)          |
                            |   gb_interface_mode_switch_work
                            |   mutex_lock(&intf->mutex) (use)

Fix it by canceling the work before kfree.

Signed-off-by: Sicong Huang <congei42@163.com>
Link: https://lore.kernel.org/r/20240416080313.92306-1-congei42@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/greybus/interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
index 9ec949a438ef6..52ef6be9d4499 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -694,6 +694,7 @@ static void gb_interface_release(struct device *dev)
 
 	trace_gb_interface_release(intf);
 
+	cancel_work_sync(&intf->mode_switch_work);
 	kfree(intf);
 }
 
-- 
2.43.0


