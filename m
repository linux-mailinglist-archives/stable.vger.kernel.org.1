Return-Path: <stable+bounces-46901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3EF8D0BBB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C791F229D8
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25256A039;
	Mon, 27 May 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zOwcfADN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F240200CD;
	Mon, 27 May 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837147; cv=none; b=IbwubBXYf3W0SS9K413uLixbAvfkbSNfHPduRurtuphP6hCZmP8PFG+a4om03B+ojaOa8mW66gm4TNjGAVLxh9zECVidWzvM7i1cDaTE9RNWJCyiNQcuIzb0mVXEufqlNG5pnYBfFLLSUDeW1p6baXrNXURAxIIZT+CMe9KjQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837147; c=relaxed/simple;
	bh=aqZHYBhBcDUTfPklbCmyaLvUyHWf9B31Xgx6ORbknAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psFYyK887ujeF4ov7c4D9orJsvgv9nTm85l5eSm9bz5LPiZ0euPi1Si8rTn8JA3hOR2fw38dtiJ8TRGqKpRDhelsJcfOuoEY5NaPLovNVKXagMF+wWYGYZYpxL9ZIQlSYDCtrJodnhto82UlVEkbuLXEEBONiphPgElGa5lRHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zOwcfADN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033EFC32782;
	Mon, 27 May 2024 19:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837147;
	bh=aqZHYBhBcDUTfPklbCmyaLvUyHWf9B31Xgx6ORbknAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zOwcfADNFc635jC0tHVmXvMURe/3khHIio7/VKi7jJFY8vJ9y8OobZgx0LTySdANj
	 78zqoQOGLotiCP1ZZlrCoVA7RxNANew18RYtjl/Po2ozJ+Yxx4XAWd1edWOp9g9d8J
	 91l7kI3JvsgH8++3FDtIn7MY1TGUHh93JQqvm3bw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 329/427] ASoC: tracing: Export SND_SOC_DAPM_DIR_OUT to its value
Date: Mon, 27 May 2024 20:56:16 +0200
Message-ID: <20240527185632.128295884@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 58300f8d6a48e58d1843199be743f819e2791ea3 ]

The string SND_SOC_DAPM_DIR_OUT is printed in the snd_soc_dapm_path trace
event instead of its value:

   (((REC->path_dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-")

User space cannot parse this, as it has no idea what SND_SOC_DAPM_DIR_OUT
is. Use TRACE_DEFINE_ENUM() to convert it to its value:

   (((REC->path_dir) == 1) ? "->" : "<-")

So that user space tools, such as perf and trace-cmd, can parse it
correctly.

Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Fixes: 6e588a0d839b5 ("ASoC: dapm: Consolidate path trace events")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20240416000303.04670cdf@rorschach.local.home
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/asoc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 4eed9028bb119..517015ef36a84 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -12,6 +12,8 @@
 #define DAPM_DIRECT "(direct)"
 #define DAPM_ARROW(dir) (((dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-")
 
+TRACE_DEFINE_ENUM(SND_SOC_DAPM_DIR_OUT);
+
 struct snd_soc_jack;
 struct snd_soc_card;
 struct snd_soc_dapm_widget;
-- 
2.43.0




