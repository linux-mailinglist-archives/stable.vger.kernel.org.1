Return-Path: <stable+bounces-26139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FAE870D45
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C1A1F20F18
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2677BB01;
	Mon,  4 Mar 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FSnmzceW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7F7BAFF;
	Mon,  4 Mar 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587943; cv=none; b=bHlIY0YJu6Ykq4++/DK0KzwQPCaZBjkg038rZsKUFHw/cj2KqpFu1OU1bPAlF//nmeZ1InwXUKXRWEO0cM5jbY8u30wr+RwCW8IJW7MBXG7CRzA0GQl3HSwmU75EQZUWhVKpYopG968ElQKMJHe43IuUuXm419c/XyX7mhC5jpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587943; c=relaxed/simple;
	bh=7ZehKQYTmUhTJxX+ZQtFcbNc3SoJuscgYt+lXjjDVTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3uubENqY6n/TMwtN6tCODUnt2GahV3TnGWCkQpNU2IjwvdyqalRliGwbOs4Jta+OeqWXqzwfX7Ejhru/tVFP2LXizmuTn6uOA0+RTwJbeeYKEfOkgWRi8kvuc4Rpv0Y3ltiMgdhspOQ7yar8KWWnNDvuldYw608KZx6sVxJXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FSnmzceW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1769FC43390;
	Mon,  4 Mar 2024 21:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587943;
	bh=7ZehKQYTmUhTJxX+ZQtFcbNc3SoJuscgYt+lXjjDVTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FSnmzceW2p2RgZgb25GdC6mtiem2qOW3VGzJkb8ZfeuHG8+u9FRO607YVOZ9kAQxy
	 p2N0eDrV6tmFW5ThuCrkkZSlvzrmxvVSb0PrI9sNaI4M/FJN/WphEOQ1PGNZQSAvqi
	 HjBN5WG5hZHqUK87itiSjkQyxwDqZuWlB0A1QPNg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.7 115/162] pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation
Date: Mon,  4 Mar 2024 21:23:00 +0000
Message-ID: <20240304211555.452673002@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
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

From: Bjorn Andersson <quic_bjorande@quicinc.com>

commit 2a93c6cbd5a703d44c414a3c3945a87ce11430ba upstream.

Commit 'e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable
the domain")' aimed to make sure that a power-domain that is being
enabled without any particular performance-state requested will at least
turn the rail on, to avoid filling DeviceTree with otherwise unnecessary
required-opps properties.

But in the event that aggregation happens on a disabled power-domain, with
an enabled peer without performance-state, both the local and peer
corner are 0. The peer's enabled_corner is not considered, with the
result that the underlying (shared) resource is disabled.

One case where this can be observed is when the display stack keeps mmcx
enabled (but without a particular performance-state vote) in order to
access registers and sync_state happens in the rpmhpd driver. As mmcx_ao
is flushed the state of the peer (mmcx) is not considered and mmcx_ao
ends up turning off "mmcx.lvl" underneath mmcx. This has been observed
several times, but has been painted over in DeviceTree by adding an
explicit vote for the lowest non-disabled performance-state.

Fixes: e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the domain")
Reported-by: Johan Hovold <johan@kernel.org>
Closes: https://lore.kernel.org/linux-arm-msm/ZdMwZa98L23mu3u6@hovoldconsulting.com/
Cc:  <stable@vger.kernel.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pmdomain/qcom/rpmhpd.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -692,6 +692,7 @@ static int rpmhpd_aggregate_corner(struc
 	unsigned int active_corner, sleep_corner;
 	unsigned int this_active_corner = 0, this_sleep_corner = 0;
 	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
+	unsigned int peer_enabled_corner;
 
 	if (pd->state_synced) {
 		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
@@ -701,9 +702,11 @@ static int rpmhpd_aggregate_corner(struc
 		this_sleep_corner = pd->level_count - 1;
 	}
 
-	if (peer && peer->enabled)
-		to_active_sleep(peer, peer->corner, &peer_active_corner,
+	if (peer && peer->enabled) {
+		peer_enabled_corner = max(peer->corner, peer->enable_corner);
+		to_active_sleep(peer, peer_enabled_corner, &peer_active_corner,
 				&peer_sleep_corner);
+	}
 
 	active_corner = max(this_active_corner, peer_active_corner);
 



