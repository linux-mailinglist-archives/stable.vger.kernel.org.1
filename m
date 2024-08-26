Return-Path: <stable+bounces-70218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B2D95F158
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4621F227E4
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3FC13DDD9;
	Mon, 26 Aug 2024 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z6SkKtFP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D022071
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675587; cv=none; b=ZYCYplp9tlWVtOCuQa3r35BwlcrfkyrC0H3Oj3g2SLgOn0pjtnrZPBoM/T4jYb+US/1Au/YKsi4XXkfWzfBxewf/YVB+QG5ZfNy6fbsEx15hcD2NPLcquGQhFjw1BhXDTpBhKNL7Lul4em2PsFzOX9Kq56KcVsrJT6b+uMUHtaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675587; c=relaxed/simple;
	bh=Yu51GZO+t13g9eTeqyn9QnmZIw04VeWkER8tVmBjdZM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gQZ8y3MSjaoSmh/lESbeDpTbXP2Ol9mb5Hrxle2WKJG3HzQ/Ly0kysZ7JgkzjFqVkuvGW7vRfS0Jap4wANAI/np548MnB9pvs6qgc1EIRrXfDI5abGgH7HAXyQmxLqvVuokFF4Q/N6noHJOrAbPYHEJrciLygTJXjSLzeZUepRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z6SkKtFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9817EC5142D;
	Mon, 26 Aug 2024 12:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724675587;
	bh=Yu51GZO+t13g9eTeqyn9QnmZIw04VeWkER8tVmBjdZM=;
	h=Subject:To:Cc:From:Date:From;
	b=Z6SkKtFPH7x8omFmWhZ9UA0aeEi5FlXoUxcnw1wIZevbJwFhXVtypoB3TVD1KRVw4
	 09kIubB63XdjTIeIshHmSppnKBV2oqGMcTpp14hKKJ/b8T2UwVIRzs2JjgMUum3241
	 sr2ku/7/s59zRM+G0L2KE8VnMXA2EsJLCASib0u8=
Subject: FAILED: patch "[PATCH] thermal: of: Fix OF node leak in thermal_of_trips_init()" failed to apply to 6.6-stable tree
To: krzysztof.kozlowski@linaro.org,daniel.lezcano@linaro.org,rafael.j.wysocki@intel.com,stable@vger.kernel.org,wenst@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 14:32:55 +0200
Message-ID: <2024082655-virtuous-reggae-54f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x afc954fd223ded70b1fa000767e2531db55cce58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082655-virtuous-reggae-54f4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

afc954fd223d ("thermal: of: Fix OF node leak in thermal_of_trips_init() error path")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From afc954fd223ded70b1fa000767e2531db55cce58 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 21:58:21 +0200
Subject: [PATCH] thermal: of: Fix OF node leak in thermal_of_trips_init()
 error path

Terminating for_each_child_of_node() loop requires dropping OF node
reference, so bailing out after thermal_of_populate_trip() error misses
this.  Solve the OF node reference leak with scoped
for_each_child_of_node_scoped().

Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20240814195823.437597-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index aa34b6e82e26..30f8d6e70484 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -125,7 +125,7 @@ static int thermal_of_populate_trip(struct device_node *np,
 static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
 {
 	struct thermal_trip *tt;
-	struct device_node *trips, *trip;
+	struct device_node *trips;
 	int ret, count;
 
 	trips = of_get_child_by_name(np, "trips");
@@ -150,7 +150,7 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 	*ntrips = count;
 
 	count = 0;
-	for_each_child_of_node(trips, trip) {
+	for_each_child_of_node_scoped(trips, trip) {
 		ret = thermal_of_populate_trip(trip, &tt[count++]);
 		if (ret)
 			goto out_kfree;


