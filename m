Return-Path: <stable+bounces-75375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB097343D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECA728D879
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB7E1990B5;
	Tue, 10 Sep 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L9wsF0Oa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2CA198A3F;
	Tue, 10 Sep 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964549; cv=none; b=FJlTQqfA5PBrgbcDgBHguHTXmEIzQsgwVyL899UWhXDC2HcusFQ0Edsy1zvHMoQFOgn/CFEt+grUcIk3+AKJQoa+zooo3ZvnVyG/pSY7AAcKq5M4Q8kVkD3WWpPriUIOEL8RpeTjQddKmyXb7Uk608BpujY9zaEX5/IlBCdvKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964549; c=relaxed/simple;
	bh=xqkGa2xM++KXSmtjWEKJmqODhPy+QQk3SyMeVugVH8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQqIGhgNuJnNC4PxfE4km6ETzuOKqvU67pItY5Q4hi2aUkUEqBkFU61ax79N5HH1NbA6TwZUBvOnO99TG/xc/TB8eMR7cp1+WH0N1TArraFt//kwwNxJOLjZGHsKJXvbtHjWLv4i7ZBJnhKj+8g0SQyVCoTiiNgZ+kIF+46ZJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L9wsF0Oa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5929C4CEC3;
	Tue, 10 Sep 2024 10:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964549;
	bh=xqkGa2xM++KXSmtjWEKJmqODhPy+QQk3SyMeVugVH8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9wsF0OaFIgY5R5c+DRPvh3tu5PEGEHoEaiSnn9p+qClM6ndjv9ABqcxfAGtVHj90
	 tLzJ66aBzD5TjLT6QN5nUOdZy33N2oVDq6zZNLueO4T9MO320M1h5VmXJbE92A+pl7
	 DdrA3gl6KWet8qgSSrvc209Qdm9rdEefxkjUWah0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacky Bai <ping.bai@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Ye Li <ye.li@nxp.com>,
	Jason Liu <jason.hui.liu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6.6 221/269] clocksource/drivers/imx-tpm: Fix next event not taking effect sometime
Date: Tue, 10 Sep 2024 11:33:28 +0200
Message-ID: <20240910092615.843854367@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

From: Jacky Bai <ping.bai@nxp.com>

commit 3d5c2f8e75a55cfb11a85086c71996af0354a1fb upstream.

The value written into the TPM CnV can only be updated into the hardware
when the counter increases. Additional writes to the CnV write buffer are
ignored until the register has been updated. Therefore, we need to check
if the CnV has been updated before continuing. This may require waiting for
1 counter cycle in the worst case.

Cc: stable@vger.kernel.org
Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20240725193355.1436005-2-Frank.Li@nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clocksource/timer-imx-tpm.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -91,6 +91,14 @@ static int tpm_set_next_event(unsigned l
 	now = tpm_read_counter();
 
 	/*
+	 * Need to wait CNT increase at least 1 cycle to make sure
+	 * the C0V has been updated into HW.
+	 */
+	if ((next & 0xffffffff) != readl(timer_base + TPM_C0V))
+		while (now == tpm_read_counter())
+			;
+
+	/*
 	 * NOTE: We observed in a very small probability, the bus fabric
 	 * contention between GPU and A7 may results a few cycles delay
 	 * of writing CNT registers which may cause the min_delta event got



