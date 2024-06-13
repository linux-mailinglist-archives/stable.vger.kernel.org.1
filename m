Return-Path: <stable+bounces-50766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D0F906C90
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD0EB22851
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B888B1448FD;
	Thu, 13 Jun 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AgtuHAdK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7645F143C7B;
	Thu, 13 Jun 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279322; cv=none; b=fKXYZzx02eePaZRZuExf+FgnSDCe3lcdBXK7W8yNJf/j8b75+Z9xSRnbs3Y9wgYz7r0RW5hhXCd4unUJZ6iu7nOU6Ak1GlaEfbLVfF3yVCEVRc3zr/e2E3XNHfZCDdkURr2RPUoI44Th10TSDRAmFAGQCLw8R2Wh/zbIeIZ3aDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279322; c=relaxed/simple;
	bh=7UaEi5iiUJIEJFcvVPj+wLNaHb+MKmln0uiB88flQVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0TlwOBidzl3suz9oVxvCj0jGEC5A/26SoyRFupzsspkWkjHZBlC1PLqBCZLSwPH5OCtk2zEYNqlw6Jq9IbPAUNBb1Qyht1KteSXisZuU9//V0OhITzbmBjjy15nLsSbQCLJkTjsgej2Y1uIgFdYvDRvshz3yCVvIn8dFbhp0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AgtuHAdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EECC2BBFC;
	Thu, 13 Jun 2024 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279322;
	bh=7UaEi5iiUJIEJFcvVPj+wLNaHb+MKmln0uiB88flQVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AgtuHAdKN0YeKv51upodQA+RruklUvWoHaYAc/REE26djzlLB8qYR88bvarHWMY/s
	 3SwIdBUpbJ8EoqDSZ/KJXa65aGp4UycRuMX0d1/k8yWgvUNK0FHbEtBvBLB1KKgC3u
	 3jItTzvMc+5U44H3ZzGYwu0NM9YRguyCML6ExypQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 6.9 037/157] media: mxl5xx: Move xpt structures off stack
Date: Thu, 13 Jun 2024 13:32:42 +0200
Message-ID: <20240613113228.855136187@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit 526f4527545b2d4ce0733733929fac7b6da09ac6 upstream.

When building for LoongArch with clang 18.0.0, the stack usage of
probe() is larger than the allowed 2048 bytes:

  drivers/media/dvb-frontends/mxl5xx.c:1698:12: warning: stack frame size (2368) exceeds limit (2048) in 'probe' [-Wframe-larger-than]
   1698 | static int probe(struct mxl *state, struct mxl5xx_cfg *cfg)
        |            ^
  1 warning generated.

This is the result of the linked LLVM commit, which changes how the
arrays of structures in config_ts() get handled with
CONFIG_INIT_STACK_ZERO and CONFIG_INIT_STACK_PATTERN, which causes the
above warning in combination with inlining, as config_ts() gets inlined
into probe().

This warning can be easily fixed by moving the array of structures off
of the stackvia 'static const', which is a better location for these
variables anyways because they are static data that is only ever read
from, never modified, so allocating the stack space is wasteful.

This drops the stack usage from 2368 bytes to 256 bytes with the same
compiler and configuration.

Link: https://lore.kernel.org/linux-media/20240111-dvb-mxl5xx-move-structs-off-stack-v1-1-ca4230e67c11@kernel.org
Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/1977
Link: https://github.com/llvm/llvm-project/commit/afe8b93ffdfef5d8879e1894b9d7dda40dee2b8d
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/mxl5xx.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/media/dvb-frontends/mxl5xx.c
+++ b/drivers/media/dvb-frontends/mxl5xx.c
@@ -1381,57 +1381,57 @@ static int config_ts(struct mxl *state,
 	u32 nco_count_min = 0;
 	u32 clk_type = 0;
 
-	struct MXL_REG_FIELD_T xpt_sync_polarity[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_sync_polarity[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700010, 8, 1}, {0x90700010, 9, 1},
 		{0x90700010, 10, 1}, {0x90700010, 11, 1},
 		{0x90700010, 12, 1}, {0x90700010, 13, 1},
 		{0x90700010, 14, 1}, {0x90700010, 15, 1} };
-	struct MXL_REG_FIELD_T xpt_clock_polarity[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_clock_polarity[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700010, 16, 1}, {0x90700010, 17, 1},
 		{0x90700010, 18, 1}, {0x90700010, 19, 1},
 		{0x90700010, 20, 1}, {0x90700010, 21, 1},
 		{0x90700010, 22, 1}, {0x90700010, 23, 1} };
-	struct MXL_REG_FIELD_T xpt_valid_polarity[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_valid_polarity[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700014, 0, 1}, {0x90700014, 1, 1},
 		{0x90700014, 2, 1}, {0x90700014, 3, 1},
 		{0x90700014, 4, 1}, {0x90700014, 5, 1},
 		{0x90700014, 6, 1}, {0x90700014, 7, 1} };
-	struct MXL_REG_FIELD_T xpt_ts_clock_phase[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_ts_clock_phase[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700018, 0, 3}, {0x90700018, 4, 3},
 		{0x90700018, 8, 3}, {0x90700018, 12, 3},
 		{0x90700018, 16, 3}, {0x90700018, 20, 3},
 		{0x90700018, 24, 3}, {0x90700018, 28, 3} };
-	struct MXL_REG_FIELD_T xpt_lsb_first[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_lsb_first[MXL_HYDRA_DEMOD_MAX] = {
 		{0x9070000C, 16, 1}, {0x9070000C, 17, 1},
 		{0x9070000C, 18, 1}, {0x9070000C, 19, 1},
 		{0x9070000C, 20, 1}, {0x9070000C, 21, 1},
 		{0x9070000C, 22, 1}, {0x9070000C, 23, 1} };
-	struct MXL_REG_FIELD_T xpt_sync_byte[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_sync_byte[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700010, 0, 1}, {0x90700010, 1, 1},
 		{0x90700010, 2, 1}, {0x90700010, 3, 1},
 		{0x90700010, 4, 1}, {0x90700010, 5, 1},
 		{0x90700010, 6, 1}, {0x90700010, 7, 1} };
-	struct MXL_REG_FIELD_T xpt_enable_output[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_enable_output[MXL_HYDRA_DEMOD_MAX] = {
 		{0x9070000C, 0, 1}, {0x9070000C, 1, 1},
 		{0x9070000C, 2, 1}, {0x9070000C, 3, 1},
 		{0x9070000C, 4, 1}, {0x9070000C, 5, 1},
 		{0x9070000C, 6, 1}, {0x9070000C, 7, 1} };
-	struct MXL_REG_FIELD_T xpt_err_replace_sync[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_err_replace_sync[MXL_HYDRA_DEMOD_MAX] = {
 		{0x9070000C, 24, 1}, {0x9070000C, 25, 1},
 		{0x9070000C, 26, 1}, {0x9070000C, 27, 1},
 		{0x9070000C, 28, 1}, {0x9070000C, 29, 1},
 		{0x9070000C, 30, 1}, {0x9070000C, 31, 1} };
-	struct MXL_REG_FIELD_T xpt_err_replace_valid[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_err_replace_valid[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700014, 8, 1}, {0x90700014, 9, 1},
 		{0x90700014, 10, 1}, {0x90700014, 11, 1},
 		{0x90700014, 12, 1}, {0x90700014, 13, 1},
 		{0x90700014, 14, 1}, {0x90700014, 15, 1} };
-	struct MXL_REG_FIELD_T xpt_continuous_clock[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_continuous_clock[MXL_HYDRA_DEMOD_MAX] = {
 		{0x907001D4, 0, 1}, {0x907001D4, 1, 1},
 		{0x907001D4, 2, 1}, {0x907001D4, 3, 1},
 		{0x907001D4, 4, 1}, {0x907001D4, 5, 1},
 		{0x907001D4, 6, 1}, {0x907001D4, 7, 1} };
-	struct MXL_REG_FIELD_T xpt_nco_clock_rate[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_nco_clock_rate[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700044, 16, 80}, {0x90700044, 16, 81},
 		{0x90700044, 16, 82}, {0x90700044, 16, 83},
 		{0x90700044, 16, 84}, {0x90700044, 16, 85},



