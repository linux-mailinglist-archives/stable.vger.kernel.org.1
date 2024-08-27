Return-Path: <stable+bounces-70966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE7A9610EB
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF441C2357E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417731C688E;
	Tue, 27 Aug 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wDwX5rnS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F289D1A072D;
	Tue, 27 Aug 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771653; cv=none; b=sRG0jDpPGXt/yqzDMUnjoFqU4gROQkWP5nE5MzLfveibQbbgy85AoSlLSm/JqbYWb65FfDnJFtaztk5/dVbWnYLOzzEj7+xge/x1YLN1J8WpiN+nNVrhqkvkEytaI3PFiuYP7EmGYIeYltHyw+ew63V4godsIFWmazC/IY1nPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771653; c=relaxed/simple;
	bh=xiu6IaDLnOZ/tdJeNY+6aL1/QfY8JWphEz1CeRhIyuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaEPKOzkPglnE6SeZNH37saX3ojcPQ2WZMizCh9+VYe998zXpAk92FzEJzstK6dnjqhm0bxHvLfAl6Ogt5VDiFZrz1xRXlRKBkWWz9cIpWemSuGv2BYuyki5Ro6dvljOYA9ZVlkUUFSjzLqMTAX6wX0Y4WD4q/fcPKanukO0OjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wDwX5rnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E798C61064;
	Tue, 27 Aug 2024 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771652;
	bh=xiu6IaDLnOZ/tdJeNY+6aL1/QfY8JWphEz1CeRhIyuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wDwX5rnSeG1Fr6wmDsjnVhN3qObHdd/qtI77FNZlKDFJhWavFP8UskhvUURk6PNAf
	 5xXOvv+GwOgPHDM0+7yaB5MJWheIduar+0a9H+kHrBQuBFoKDuVwqKke40feNJCSnc
	 FOfoELdGWevWCV5+NjsjaTsBM89R11ZedzPHUnDU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.10 253/273] thermal: of: Fix OF node leak in thermal_of_zone_register()
Date: Tue, 27 Aug 2024 16:39:37 +0200
Message-ID: <20240827143843.029195747@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 662b52b761bfe0ba970e5823759798faf809b896 upstream.

thermal_of_zone_register() calls of_thermal_zone_find() which will
iterate over OF nodes with for_each_available_child_of_node() to find
matching thermal zone node.  When it finds such, it exits the loop and
returns the node.  Prematurely ending for_each_available_child_of_node()
loops requires dropping OF node reference, thus success of
of_thermal_zone_find() means that caller must drop the reference.

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20240814195823.437597-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/thermal_of.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -491,7 +491,8 @@ static struct thermal_zone_device *therm
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
 		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(trips);
+		ret = PTR_ERR(trips);
+		goto out_of_node_put;
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
@@ -519,6 +520,7 @@ static struct thermal_zone_device *therm
 		goto out_kfree_trips;
 	}
 
+	of_node_put(np);
 	kfree(trips);
 
 	ret = thermal_zone_device_enable(tz);
@@ -533,6 +535,8 @@ static struct thermal_zone_device *therm
 
 out_kfree_trips:
 	kfree(trips);
+out_of_node_put:
+	of_node_put(np);
 
 	return ERR_PTR(ret);
 }



