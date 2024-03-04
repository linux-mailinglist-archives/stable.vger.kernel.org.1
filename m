Return-Path: <stable+bounces-26341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11215870E21
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438861C23BC9
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F7911193;
	Mon,  4 Mar 2024 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KRJTxsWk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F7D8F58;
	Mon,  4 Mar 2024 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588471; cv=none; b=MBExqAYe50i6bXI9dD6G5zotB9XeQQsdkGoPHuZlXlkGW/Vm/JCxjI7EINCPLZ2UevOyYhOLQBivkNlnP1X/Ut93hiehIa3uHZoTRrMYe6Tsh8CgcuWGfgLlYdz3QHPbDwNo37ejoCeFcJAezSfsHsw79JSn09f5nnTQkmhv5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588471; c=relaxed/simple;
	bh=14bUIRdi/Qq2sUaPn9kSpgdRxX3tAiYSwRpqByu+raY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPMoL/0yaImDbn31warB3nDJfloxRpC/l2qBlEbNg/2cd1SjrorDyBQ0n7ktgwrsPIGzQkeDcTsNZe3yfE36m9ofWqadX3ZIcUaWrjasdxFf01uIaRM2ji3YdoiwYilvLA6AHyJbfdiDfRIriZSYo+bV7zqxUTeDwaUO1lFD9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KRJTxsWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BECC433C7;
	Mon,  4 Mar 2024 21:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588471;
	bh=14bUIRdi/Qq2sUaPn9kSpgdRxX3tAiYSwRpqByu+raY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRJTxsWkjPdK2sfHVnV5UJkwEoGdXmKaK4kbOOV4tfEDHYsd4H1Fy/mRJFC8Z3IVj
	 gN8+01f+pMNYg2kIVspiVqNq25jNCf+fj0QLb6iVgfLS8RvDwRkBYh33gwdgR+Q/64
	 3mNpvjEs0FiZu2CiiIcPt5KwVvSzLgZfbGDJSk1E=
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
Subject: [PATCH 6.6 102/143] pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation
Date: Mon,  4 Mar 2024 21:23:42 +0000
Message-ID: <20240304211553.170703531@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
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
@@ -616,6 +616,7 @@ static int rpmhpd_aggregate_corner(struc
 	unsigned int active_corner, sleep_corner;
 	unsigned int this_active_corner = 0, this_sleep_corner = 0;
 	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
+	unsigned int peer_enabled_corner;
 
 	if (pd->state_synced) {
 		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
@@ -625,9 +626,11 @@ static int rpmhpd_aggregate_corner(struc
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
 



