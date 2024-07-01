Return-Path: <stable+bounces-56164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB6391D51A
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0608E281520
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E804F18635;
	Mon,  1 Jul 2024 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpiFQ/j8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E517BD9;
	Mon,  1 Jul 2024 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792825; cv=none; b=bZf9MFKUAg1hl+6UrwWcfg6m060K9FjozXYeR7KTlPT9K7XoS0xX3Wob0qwChflxOhLe9zeLBYVX8NLkP/UszEV1Wy/f4MmP8zHcRm3GhbDfGn5e2B7uwVtKPUOOOozc1LZuOf7BFrVAfWJcR9tSYr7l28to4SlvWEXVXui1QQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792825; c=relaxed/simple;
	bh=qclWDWQblk91dDA0GVzaDjjEZGFR4p3CRjmmwvtKyCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5hRx0W1PUtqILEXdgsQdMcfu92T4fTiXJpIW5dDkZnaCLJ4TRziSR98MvFa12p/mJQyVoOfQnFkenwufOQol1rYJs1+Qcb2m5gR6iiGjd5pi21G3NEceUEIJgCT3AGnzsWR9/or+UkoKYTGad26u7DFJML0AISronidUr1WSog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpiFQ/j8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180DAC2BD10;
	Mon,  1 Jul 2024 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792825;
	bh=qclWDWQblk91dDA0GVzaDjjEZGFR4p3CRjmmwvtKyCg=;
	h=From:To:Cc:Subject:Date:From;
	b=OpiFQ/j8apaTm0zVNkSx5Bon3n4xMcwWGuPxLoT1NAqzYW7S7ejWYEoPE34JNt6k+
	 ybL55QwGyFC22tEQnZWUD4iErZGZu/P5Jf8HEUMlbdHTII3PfPf5u7BiCQpG3DdMhO
	 IxNMiKjCaRJWo0yN4FegHoty5KWKK7bykmNeolw6iSHWH63W+zPhngLmQiB4+VhXeJ
	 9+iD9QE7zf8fDUbP3IbMwn1hmEjAVWVAv789Qozbfwh+8Y3keL3SFPyjO9kwL/84yg
	 jwyAASFs5HXglwk2AO43vQ+E2JuAJeOEGEGRb6rwT4XyOOcgRLx5UduK90UarkObs4
	 2Qj3XHu3HqeHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/12] ALSA: hda: cs35l56: Fix lifecycle of codec pointer
Date: Sun, 30 Jun 2024 20:13:20 -0400
Message-ID: <20240701001342.2920907-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.36
Content-Transfer-Encoding: 8bit

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit d339131bf02d4ed918415574082caf5e8af6e664 ]

The codec should be cleared when the amp driver is unbound and when
resuming it should be tested to prevent loading firmware into the device
and ALSA in a partially configured system state.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240531112716.25323-1-simont@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l56_hda.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 15e20d9261393..77e8da7dffc6a 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -702,6 +702,8 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 	if (comps[cs35l56->index].dev == dev)
 		memset(&comps[cs35l56->index], 0, sizeof(*comps));
 
+	cs35l56->codec = NULL;
+
 	dev_dbg(cs35l56->base.dev, "Unbound\n");
 }
 
@@ -807,6 +809,9 @@ static int cs35l56_hda_system_resume(struct device *dev)
 
 	cs35l56->suspended = false;
 
+	if (!cs35l56->codec)
+		return 0;
+
 	ret = cs35l56_is_fw_reload_needed(&cs35l56->base);
 	dev_dbg(cs35l56->base.dev, "fw_reload_needed: %d\n", ret);
 	if (ret > 0) {
-- 
2.43.0


