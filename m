Return-Path: <stable+bounces-84886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C3C99D2AD
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AE9283167
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F09F1BD00A;
	Mon, 14 Oct 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1/31Yw8U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC021AC8A2;
	Mon, 14 Oct 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919565; cv=none; b=TKCMkEUr8H9r98dGIINlEz2qjusHXueh+IrJy1yeIL6niqcQbFFWhPzo/abfWy1wgny5WSiZWeHnYDTUHmJXlmOYX/fXlfQrdGDHHSDpMWOSIgUkSw7xCaiGcTAL48MIcVv0lmr0Ypc3Xmw5Yu5jijPJxb6OP2CU2VEsJH1BL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919565; c=relaxed/simple;
	bh=Bhvoi/3X/NUdBWT/jGgqYoKt1J61o9AGgICy2JD3Nrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mH0ujvTPMfcqbeCwiQCv/1hI6jse73k+PId/fNC6TyhTUsJBiNLnaYxlRzpfuEjrfwzsq/DjYGUBWVw6GPdMj0/fM/IltYpGuot6AlqYt5tuYp7VxyrdpLJvpSKuwEna6ZyVuygm9Qy6OM7XIHhYixL7v0CixWOX8ml8Btn/swY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1/31Yw8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AEEC4CEC7;
	Mon, 14 Oct 2024 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728919564;
	bh=Bhvoi/3X/NUdBWT/jGgqYoKt1J61o9AGgICy2JD3Nrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1/31Yw8UltSwffCXekbMOaAPvHw9v86GHF2RlcCQkjSwnShg32s7Gbza9DsumlE6h
	 oj8jrRP2O0PFwC71V+AtH+2m7JYX34QpJFJs0P+t53d/sJRWtF92WHuyb74tzPxWyS
	 pnTm0I5m7y21/oLEfDtWAdmjMDegdMVUvMxaSHkM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Udit Kumar <u-kumar1@ti.com>,
	Beleswar Padhi <b-padhi@ti.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 643/798] remoteproc: k3-r5: Delay notification of wakeup event
Date: Mon, 14 Oct 2024 16:19:57 +0200
Message-ID: <20241014141243.301256696@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Udit Kumar <u-kumar1@ti.com>

[ Upstream commit 8fa052c29e509f3e47d56d7fc2ca28094d78c60a ]

Few times, core1 was scheduled to boot first before core0, which leads
to error:

'k3_r5_rproc_start: can not start core 1 before core 0'.

This was happening due to some scheduling between prepare and start
callback. The probe function waits for event, which is getting
triggered by prepare callback. To avoid above condition move event
trigger to start instead of prepare callback.

Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up before powering up core1")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
[ Applied wakeup event trigger only for Split-Mode booted rprocs ]
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240820105004.2788327-1-b-padhi@ti.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 75bfe62736ab1..580f86de654f2 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -464,8 +464,6 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
 			ret);
 		return ret;
 	}
-	core->released_from_reset = true;
-	wake_up_interruptible(&cluster->core_transition);
 
 	/*
 	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
@@ -582,6 +580,9 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 		ret = k3_r5_core_run(core);
 		if (ret)
 			return ret;
+
+		core->released_from_reset = true;
+		wake_up_interruptible(&cluster->core_transition);
 	}
 
 	return 0;
-- 
2.43.0




