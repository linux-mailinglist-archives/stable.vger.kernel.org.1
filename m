Return-Path: <stable+bounces-102221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E99EF1D4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EE61896F94
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1837D22541E;
	Thu, 12 Dec 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZS9RgyN2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB72253EB;
	Thu, 12 Dec 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020428; cv=none; b=qJ3tDEsS/VjvmYlCuOChFKWA+3lx96oHlheyvpTSchYoJznF7avxilNbyWxdtZ0HUA+zsr9xjgakWEgtz0Rzt4dG/fdRQylqVJL1JfBMHo00bH7t4zGJUcwJ9Or8Lm+IGc+13ftUCJJx7AW6uHQVFeyQ9YqpA9HSVcJULK79hnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020428; c=relaxed/simple;
	bh=0xw5eWLD5r9Dtlt2Uq9j3J10sWxuk/ztys0+7ReyCvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iB/hduSbPzWNDM42hPYogLeBFfVibhjk6rV8A7vMjUx4lKFILhhJ1EJqjpHxRYx0UNEMOZavb3elUkdruoIkzyYWvgc0brjzgtb630f1eKbTXPyOjpmASqeOAadKT+GsYAR8fjkBilkhiJomqiBYrFy883KV0srehvZtKESvEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZS9RgyN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3439DC4CED3;
	Thu, 12 Dec 2024 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020428;
	bh=0xw5eWLD5r9Dtlt2Uq9j3J10sWxuk/ztys0+7ReyCvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZS9RgyN2HVOmZsPPZbqJEkT4GCSd5mDK+2oDKrNdjKD4DT3LVlmG62b6/V0xdGlvO
	 75HWcVCvGy5bod8iWpQ9lptAYXV6qw53Z9y7m7LxUTCBlCJsgWwWja1GorcRNS8g9I
	 ZqAlSqo6cp1dqtd41rYN5Hqly59g2+XyosUF6hwM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.1 466/772] media: venus: Fix pm_runtime_set_suspended() with runtime pm enabled
Date: Thu, 12 Dec 2024 15:56:51 +0100
Message-ID: <20241212144409.187646245@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 2a20869f7d798aa2b69e45b863eaf1b1ecf98278 upstream.

It is not valid to call pm_runtime_set_suspended() for devices
with runtime PM enabled because it returns -EAGAIN if it is enabled
already and working. So, call pm_runtime_disable() before to fix it.

Cc: stable@vger.kernel.org
Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/venus/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -405,8 +405,8 @@ err_of_depopulate:
 	of_platform_depopulate(dev);
 err_runtime_disable:
 	pm_runtime_put_noidle(dev);
-	pm_runtime_set_suspended(dev);
 	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 	hfi_destroy(core);
 err_core_deinit:
 	hfi_core_deinit(core, false);



