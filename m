Return-Path: <stable+bounces-106434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735A9FE84E
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A7E188301B
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9BC537E9;
	Mon, 30 Dec 2024 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zWThMiUS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2CD15E8B;
	Mon, 30 Dec 2024 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573962; cv=none; b=qSXsu/59THtP8hyXqmKa7KgjuykSAXxzcxog+uz93dXmkM9p5n3KeX6QKJTJ+eLEzxpqP8SRoAXGHA9hb0HWhBWkeS2oRaDvYnqisb6rCX6Ih59bWk4MK4aEOZ+aSpkC1FglkZUStj/mClHuG6TpkbfOWDbuAv1ou5JiBZH6jjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573962; c=relaxed/simple;
	bh=ah+/RFh2cuDhX/QOvBSfyGF64A6kAvR2yRjYvxzK040=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kf0tyvVJ9nIPRyIEKDYn8nGsacDm6sc22aZnL1KSY2NP2xMWDCbJaBZzlkDwK1LTSCN6ByMe5OOjZ8qUFefziPGW0TqTlxf583h46yJ3W3SXDuIpVXOPOHCWu4cD5fuyBNijy+N3M9pNKrt52RopHAqoLa0S/Bj63riKPBhd2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zWThMiUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8F4C4CED0;
	Mon, 30 Dec 2024 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735573962;
	bh=ah+/RFh2cuDhX/QOvBSfyGF64A6kAvR2yRjYvxzK040=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zWThMiUS2x9R9q0tE6JqN3Eak5zf6r2RRRxBMXLfT978JztqvUagfXrIfA0wl0X94
	 XixXTXA0HVV4Aef/dUXHS+K/5AvD82vnEf/2muzJr5HAx6WFMbPKqJGDhnqJKGVa6C
	 MShkEqfYGDiN/i27Ua0KPJP9zwyPAI2FiiRP3B9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Colin Ian King <colin.i.king@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 85/86] ALSA: hda/realtek: Fix spelling mistake "Firelfy" -> "Firefly"
Date: Mon, 30 Dec 2024 16:43:33 +0100
Message-ID: <20241230154214.938877536@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154211.711515682@linuxfoundation.org>
References: <20241230154211.711515682@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.i.king@gmail.com>

commit 20c3b3e5f2641eff3d85f33e6a468ac052b169bd upstream.

There is a spelling mistake in a literal string in the alc269_fixup_tbl
quirk table. Fix it.

Fixes: 0d08f0eec961 ("ALSA: hda/realtek: fix micmute LEDs don't work on HP Laptops")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Link: https://patch.msgid.link/20241205102833.476190-1-colin.i.king@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10059,7 +10059,7 @@ static const struct hda_quirk alc269_fix
 	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firelfy 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),



