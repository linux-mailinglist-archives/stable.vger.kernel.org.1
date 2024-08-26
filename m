Return-Path: <stable+bounces-70224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C1C95F256
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 15:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32937281C50
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 13:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ABD17BEBA;
	Mon, 26 Aug 2024 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jCInhV9E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790D1E519
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677503; cv=none; b=joEQiTmUGN2DdF7Mg0Red5RL08Noxr01+BmIFWqz3LFbj97HDGLssq9oPo3XZEJzJy/3LNB98YML6xrebDqPX/0TxjizZJz0c1zNPraNVe7YgRyI/2mLJl6S5ijDups8e94lU7GtAbG9qBqCIn2jH1I0MrCa0TwRpjbFNr5iwWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677503; c=relaxed/simple;
	bh=uJzLqz/RhsgSKMv+O/PrYkD7aDNsysfAQRLBoszX2oA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XAFTFNj5HTUpfA1AZS6mvDlmX0/o3bWH7vjcMzZFaLO7rDR8qT7ngBodsIgnGqJzL4OVYquqsZflobeyiKuTtNLbmsWu9+KVpwg1bckxdbLWdZRjRT7GwqWo+zor+H84vBpAP7304cZHn9Gh0BDS+lcJb/164gqIfX68a4RHHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jCInhV9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8336FC4FF79;
	Mon, 26 Aug 2024 13:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724677502;
	bh=uJzLqz/RhsgSKMv+O/PrYkD7aDNsysfAQRLBoszX2oA=;
	h=Subject:To:Cc:From:Date:From;
	b=jCInhV9ELrtIJuim1Q8R58fr6qUm7pP4ArOUURzz72aPSI1PNiJLT/ZFTWs8jPsC2
	 9YwTnOXFIUl/rt3Pa/pZt8mkXUSYVkECrQtb4bIG9fO7to9W+1dfawbq/U8Ad5WjYu
	 s/Mu1IRKlNw31cgc6oCjdLko3JCnPdM+ejvem5uI=
Subject: FAILED: patch "[PATCH] thermal: of: Fix OF node leak in of_thermal_zone_find() error" failed to apply to 6.1-stable tree
To: krzysztof.kozlowski@linaro.org,daniel.lezcano@linaro.org,rafael.j.wysocki@intel.com,stable@vger.kernel.org,wenst@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 15:04:59 +0200
Message-ID: <2024082659-veto-ladies-d1b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c0a1ef9c5be72ff28a5413deb1b3e1a066593c13
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082659-veto-ladies-d1b3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

c0a1ef9c5be7 ("thermal: of: Fix OF node leak in of_thermal_zone_find() error paths")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0a1ef9c5be72ff28a5413deb1b3e1a066593c13 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 21:58:23 +0200
Subject: [PATCH] thermal: of: Fix OF node leak in of_thermal_zone_find() error
 paths

Terminating for_each_available_child_of_node() loop requires dropping OF
node reference, so bailing out on errors misses this.  Solve the OF node
reference leak with scoped for_each_available_child_of_node_scoped().

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20240814195823.437597-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index b08a9b64718d..1f252692815a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -184,14 +184,14 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 	 * Search for each thermal zone, a defined sensor
 	 * corresponding to the one passed as parameter
 	 */
-	for_each_available_child_of_node(np, tz) {
+	for_each_available_child_of_node_scoped(np, child) {
 
 		int count, i;
 
-		count = of_count_phandle_with_args(tz, "thermal-sensors",
+		count = of_count_phandle_with_args(child, "thermal-sensors",
 						   "#thermal-sensor-cells");
 		if (count <= 0) {
-			pr_err("%pOFn: missing thermal sensor\n", tz);
+			pr_err("%pOFn: missing thermal sensor\n", child);
 			tz = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -200,18 +200,19 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 
 			int ret;
 
-			ret = of_parse_phandle_with_args(tz, "thermal-sensors",
+			ret = of_parse_phandle_with_args(child, "thermal-sensors",
 							 "#thermal-sensor-cells",
 							 i, &sensor_specs);
 			if (ret < 0) {
-				pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", tz, ret);
+				pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", child, ret);
 				tz = ERR_PTR(ret);
 				goto out;
 			}
 
 			if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
 								  sensor_specs.args[0] : 0)) {
-				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, tz);
+				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, child);
+				tz = no_free_ptr(child);
 				goto out;
 			}
 		}


