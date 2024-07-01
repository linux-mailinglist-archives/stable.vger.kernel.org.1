Return-Path: <stable+bounces-56144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB391D4D5
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6E91F2116A
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEDE10F1;
	Mon,  1 Jul 2024 00:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUUxROcL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279D2C80;
	Mon,  1 Jul 2024 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792732; cv=none; b=gC8ATZPuVuGZ2hrhRV0Jn/8VTQbB8ZzUI9CPA2+SycmlC6RlTD4GwcRF3Jve9mvHh4JvKgegwKCPiitBgT7Lfcs6bPrKBnsdgWyo0lKToXBRxMoJQGLo8D3XR0yvIVIHxwyq0ccjl3YOKPagGEj6vlzb81lBUsE09w9cKU4VHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792732; c=relaxed/simple;
	bh=VSZj8vRMujLB5UOFE2+NyN8F5a9YuB+XhvEijdmZaUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6KdShUHWw4BePz3bbOqDg3t5PozRkdStc6Ia1wrEQC8JMHkuIyX4HAjYWLDve37x8auTdIH81FxhJYpMHUnpxeg8ofgR2U/NjO4mEmc4kWZXC0zLmeKnrC8tE8TFaV168EDMF+bu9hstlPzupSzFGt61CqrcdmqZjE4ACtH+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUUxROcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1D3C2BD10;
	Mon,  1 Jul 2024 00:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792732;
	bh=VSZj8vRMujLB5UOFE2+NyN8F5a9YuB+XhvEijdmZaUA=;
	h=From:To:Cc:Subject:Date:From;
	b=ZUUxROcLlUabgTprCn6rXEdHV8l5OIwL8OsV0kXyeyGsbMiWshwwi9w7HJ7dT0xoN
	 hxmK+EilVS6/Mca8ltbhu8/7igeCDL/K4+//Q+HUl3Vn1jeAhCMJuMeNv1SB+R04nq
	 9kAv4Nszxuh//Z+VPcO+1abQrXrYSrsuZyOZ0TVm2qRPD5NjlaMN6Iu5Si8t0lZzwX
	 fyCPXX7eiRwuozZWHr0EOGwk40DDfKl6FuWxPEnxLAj13c0fG3lEv8DwbZ+S+eW464
	 o2prpmwTfPA7w/GP8AeyT4FtcMWxi1U2rN5LVExgFA2TtqUFws9BpN6fiala03YfVP
	 RBeeFdWdnmAuA==
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
Subject: [PATCH AUTOSEL 6.9 01/20] ALSA: hda: cs35l56: Fix lifecycle of codec pointer
Date: Sun, 30 Jun 2024 20:11:06 -0400
Message-ID: <20240701001209.2920293-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
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
index 11b0570ff56d4..0923e2589f5f7 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -735,6 +735,8 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 	if (comps[cs35l56->index].dev == dev)
 		memset(&comps[cs35l56->index], 0, sizeof(*comps));
 
+	cs35l56->codec = NULL;
+
 	dev_dbg(cs35l56->base.dev, "Unbound\n");
 }
 
@@ -840,6 +842,9 @@ static int cs35l56_hda_system_resume(struct device *dev)
 
 	cs35l56->suspended = false;
 
+	if (!cs35l56->codec)
+		return 0;
+
 	ret = cs35l56_is_fw_reload_needed(&cs35l56->base);
 	dev_dbg(cs35l56->base.dev, "fw_reload_needed: %d\n", ret);
 	if (ret > 0) {
-- 
2.43.0


