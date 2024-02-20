Return-Path: <stable+bounces-21702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D277685C9FB
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62898B213BA
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B495C151CDC;
	Tue, 20 Feb 2024 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L3vGdp8J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259B612D7;
	Tue, 20 Feb 2024 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465243; cv=none; b=SX/5F/oHt4rjkof03Px8U7OzGc1wyQsaVIUA5LVWh2X8Eazz6DDOgk1lcG8cqyTmkhkLOYU7fQN2wbnhCsthqGjvfRzZoB1We+WN5ewVikW3IGfo3Z3m5RXCSE3437xkUyA9W4TesPQozHzAP40e6VqBWBZT/VIr3ThnCLTNoMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465243; c=relaxed/simple;
	bh=bnLbCi5+OTT/s1gliJf7v5VKmPYmY5iyDUyOyfBxhR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCkbt/y+ifDKF3uoewh4pvxNQKNbOpqCjo9Nxn9F65dX84kbCjHXa+7rlQZwiWyHZZn+A6o+6UrRPSFyuiFWGH44P2ulJdjDUS5JdblZ2IGANPx1reu0EdXF4cvIzcO/GIrwzYU1tlPdn9XXHA8ogwtAo6KKpqlVFKbvKTjXGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L3vGdp8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C41C433C7;
	Tue, 20 Feb 2024 21:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708465243;
	bh=bnLbCi5+OTT/s1gliJf7v5VKmPYmY5iyDUyOyfBxhR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3vGdp8JUlWhgw7jHJmXZ6yymuaVuA2quPnpdvdPIb+QWxTMZLdCEE0ywrB5zJepb
	 4ozgaKxcFJQZWz4tD5GbjqAKFOyEKDQ3ZKjOMhGj4uy3DgU36tB1DrFDoNPo3PjbaK
	 XRO/n5nS/fOBXk7zb+sLzdYe6RAKWBErGeKEKhZY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.7 281/309] mm/damon/sysfs-schemes: fix wrong DAMOS tried regions update timeout setup
Date: Tue, 20 Feb 2024 21:57:20 +0100
Message-ID: <20240220205641.916718395@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj@kernel.org>

commit b9e4bc1046d20e0623a80660ef8627448056f817 upstream.

DAMON sysfs interface's update_schemes_tried_regions command has a timeout
of two apply intervals of the DAMOS scheme.  Having zero value DAMOS
scheme apply interval means it will use the aggregation interval as the
value.  However, the timeout setup logic is mistakenly using the sampling
interval insted of the aggregartion interval for the case.  This could
cause earlier-than-expected timeout of the command.  Fix it.

Link: https://lkml.kernel.org/r/20240202191956.88791-1-sj@kernel.org
Fixes: 7d6fa31a2fd7 ("mm/damon/sysfs-schemes: add timeout for update_schemes_tried_regions")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.7.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/sysfs-schemes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1928,7 +1928,7 @@ static void damos_tried_regions_init_upd
 		sysfs_regions->upd_timeout_jiffies = jiffies +
 			2 * usecs_to_jiffies(scheme->apply_interval_us ?
 					scheme->apply_interval_us :
-					ctx->attrs.sample_interval);
+					ctx->attrs.aggr_interval);
 	}
 }
 



