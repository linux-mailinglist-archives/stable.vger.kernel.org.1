Return-Path: <stable+bounces-65448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA112948145
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8517F283AEF
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C61817D34D;
	Mon,  5 Aug 2024 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7WsZGb0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB72B16D9A3;
	Mon,  5 Aug 2024 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880766; cv=none; b=kGbJM+4W/695+eyy0iE8DdfgCQjPqXlYKrp0q+kI6pKutHQv7kESjDBE6u5iLgo8zI/RpHKAflOaFrdqRYf/vxpMJVjqYKDjDIeM30z7gxdqI2RU40Cd0qRls2wiY/bf4vh9QQBXKMkXI79FC8xaepNTSQ/nRqHt5zSXt4har08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880766; c=relaxed/simple;
	bh=dIUgIsxZtTAjyI73A/0DtBkE80RKZ75VSWVeI1an7Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADpeNyBShgXFbrzbXd9I1SxnTlUXlmkK2xPW5Or8788HtYGZx+6izEiKmjOACWOp3XFV2dJfUae7c4z0Hbw3UVgs5eFLABsW+uerRwkDVcP3C5pWx5V06tmeO3CC145gc//KFYQ2iknqYn+r2WzeeysiuFk2Ixr8MPSO0kxBZ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7WsZGb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA82BC4AF0C;
	Mon,  5 Aug 2024 17:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880765;
	bh=dIUgIsxZtTAjyI73A/0DtBkE80RKZ75VSWVeI1an7Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7WsZGb0pcap0blMsoflyeMukI4Fbn7EYI4R4lmh28HBm6WRnyAl3NSL4byC9B180
	 sHwxN3PnKtDzgZYC9vloeXT7oI7BRTWUi9SHBo4PjCoeQXU3NajFC9ZgsRBa0Qly6b
	 kpQBomSZ81q7gtwpiVK3dpaykSw1OTXlY2rbjwRgYEAjiLSQ7wQIFUfvFx6XV/4gyn
	 T0IRdPqB4RQMUNkIZuFTsuQuUzNKNr355mn2yYVWxIus6TIaM6q0/WSdqI9i1g/DVe
	 wMfTapMJ/dy09hzk5iHBdYgW1kW/6v/5Z7SirN72AdA3YNt72+53m+zHPZn8QmhqwG
	 vsK60yzapkV3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	bo.liu@senarytech.com,
	songxiebing@kylinos.cn,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/4] ALSA: hda/conexant: Mute speakers at suspend / shutdown
Date: Mon,  5 Aug 2024 13:59:10 -0400
Message-ID: <20240805175916.3257027-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175916.3257027-1-sashal@kernel.org>
References: <20240805175916.3257027-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 4f61c8fe35202702426cfc0003e15116a01ba885 ]

Use the new helper to mute speakers at suspend / shutdown for avoiding
click noises.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1228269
Link: https://patch.msgid.link/20240726142625.2460-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_conexant.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5b37f5f14bc91..2d10c6e744ab2 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -181,6 +181,8 @@ static void cx_auto_reboot_notify(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
 
+	snd_hda_gen_shutup_speakers(codec);
+
 	/* Turn the problematic codec into D3 to avoid spurious noises
 	   from the internal speaker during (and after) reboot */
 	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, false);
-- 
2.43.0


