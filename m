Return-Path: <stable+bounces-137809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A4AA1552
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736263B48D5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B0824500A;
	Tue, 29 Apr 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SYOmvbeM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E47E245007;
	Tue, 29 Apr 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947194; cv=none; b=AqGXGN3LbCE55g9fKIQvhAIxo+qQD1Xc2LV+q3F5QSbmdg0G79p9J23IWjJmeIL2GaFLef6OXfmdb/QcwXvDNWQue6rXEOHTB+f65pgN9Aybi0knNGaRdSBrfl7xwkWJkP5Evoa555sDzpnNgObi/wySumcIHQ/Rp3+ASeZKuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947194; c=relaxed/simple;
	bh=laBr2ZV0T08QQYvwxTca22NXs4pzAk5beqMdry+jrRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OONOuRJcgUlFAUrp2r1bpwDs4u1+nGQ/nUtrKLOeyAusz9OjzvQZmJr7tBjjbHUtvfO/KUzEYvCJHy9cZ8Gp3keYK6hhRx+KskhfaD7HXmBmMS0K8JRU4g/fqZQbLgiTjQjO2Qbu5QyH24Q4LCDfALidIOAFP5+vaDOB4VJhkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SYOmvbeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4E4C4CEE3;
	Tue, 29 Apr 2025 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947194;
	bh=laBr2ZV0T08QQYvwxTca22NXs4pzAk5beqMdry+jrRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYOmvbeMbDlIfsHBICItDRUAxKqE1YI27pyYe6aVpTzXX9KABblqrjXuZpUhX8uWW
	 gpMcua63s3pKQOtoPeHp5SJzqQ6rWhFZifqUIpSGgykrqTno1Zl0OLw+mhOWLGAlVB
	 mSiozz52Qf/Tf4O96EEnza67Dsg/rrdwm0YmqfRE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fritz Koenig <frkoenig@chromium.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 203/286] media: venus: Limit HFI sessions to the maximum supported
Date: Tue, 29 Apr 2025 18:41:47 +0200
Message-ID: <20250429161116.312264089@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

[ Upstream commit 20891170f339a8754312a877f3d17f0e5dadd599 ]

Currently we rely on firmware to return error when we reach the maximum
supported number of sessions. But this errors are happened at reqbuf
time which is a bit later. The more reasonable way looks like is to
return the error on driver open.

To achieve that modify hfi_session_create to return error when we reach
maximum count of sessions and thus refuse open.

Tested-by: Fritz Koenig <frkoenig@chromium.org>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 9edaaa8e3e15 ("media: venus: hfi_parser: refactor hfi packet parsing logic")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/core.h       |  1 +
 drivers/media/platform/qcom/venus/hfi.c        | 16 +++++++++++++---
 drivers/media/platform/qcom/venus/hfi_parser.c |  3 +++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 75d0068033276..e56d7b8142152 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -96,6 +96,7 @@ struct venus_format {
 #define MAX_CAP_ENTRIES		32
 #define MAX_ALLOC_MODE_ENTRIES	16
 #define MAX_CODEC_NUM		32
+#define MAX_SESSIONS		16
 
 struct raw_formats {
 	u32 buftype;
diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index 966b4d9b57a97..17da555905e98 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -178,6 +178,8 @@ static int wait_session_msg(struct venus_inst *inst)
 int hfi_session_create(struct venus_inst *inst, const struct hfi_inst_ops *ops)
 {
 	struct venus_core *core = inst->core;
+	bool max;
+	int ret;
 
 	if (!ops)
 		return -EINVAL;
@@ -187,11 +189,19 @@ int hfi_session_create(struct venus_inst *inst, const struct hfi_inst_ops *ops)
 	inst->ops = ops;
 
 	mutex_lock(&core->lock);
-	list_add_tail(&inst->list, &core->instances);
-	atomic_inc(&core->insts_count);
+
+	max = atomic_add_unless(&core->insts_count, 1,
+				core->max_sessions_supported);
+	if (!max) {
+		ret = -EAGAIN;
+	} else {
+		list_add_tail(&inst->list, &core->instances);
+		ret = 0;
+	}
+
 	mutex_unlock(&core->lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hfi_session_create);
 
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 32d2a9ed44003..94981a5e8e9af 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -295,6 +295,9 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 		words_count--;
 	}
 
+	if (!core->max_sessions_supported)
+		core->max_sessions_supported = MAX_SESSIONS;
+
 	parser_fini(inst, codecs, domain);
 
 	return HFI_ERR_NONE;
-- 
2.39.5




