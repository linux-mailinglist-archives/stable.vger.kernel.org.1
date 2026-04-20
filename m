Return-Path: <stable+bounces-239357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sq4/E6pj5mkuvwEAu9opvQ
	(envelope-from <stable+bounces-239357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:34:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A184317CC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9A9F34A2914
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D1133F5A9;
	Mon, 20 Apr 2026 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MmYQG3EL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7033AD9C;
	Mon, 20 Apr 2026 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700040; cv=none; b=e5me0N078vHg8+2RU/lN5LmnZ9nHP0NeYK2aSEa5rq6gN3hx/+LiypZjZ3WYCZmAMpT65wzukuOxiQsA6rTWyuIwwsZOFC65Zr2SjLuCbmeV5ci2hoZf1bviwDSZiH+L3fd5lz+KatIoquXMOMN7EVVFNj5kJT9g1D1JFG2hMZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700040; c=relaxed/simple;
	bh=zF/FrvpLYRsx6Yt8ec0jcS8srlpV9oh5jE3o/oL7hn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6YU06sRvNo0q5Q5kO4Z7fZxQIqgKBm/ItIgNnRPo72xRe/lktCK4Vw2u3j6PIPr5c6nuuP7hrfnuPRaoUwszUVn+NCiqR4Fwa1D6nZlPJa508s8VKrMdGZvsVN97Vd2OioNIRy1BQfrWQ6MpTrnp9Svl10qXd3Qy3BIr4uLnNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MmYQG3EL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5483C2BCB6;
	Mon, 20 Apr 2026 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700040;
	bh=zF/FrvpLYRsx6Yt8ec0jcS8srlpV9oh5jE3o/oL7hn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MmYQG3EL1PAfrJcvfiIVCmRSN3i+ZEvMMdPSpjRKgUo9DoTqDHqwjKejvErOXCbWw
	 wnA8t1CfN7a9/lDhR4KAyzmTW8IIyhbQCayfLb7RsDsDMQgx09RY61tXbU/sr5en4E
	 kHJIgyFnMdXhEqtn8/dlSNBKG4p5WZ+tec3sZxIw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A9sar=20Montoya?= <sprit152009@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 019/220] ALSA: hda/realtek: Add mute LED quirk for HP Pavilion 15-eg0xxx
Date: Mon, 20 Apr 2026 17:39:20 +0200
Message-ID: <20260420153934.719099077@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239357-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D2A184317CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: César Montoya <sprit152009@gmail.com>

[ Upstream commit 2f388b4e8fdd6b0f27cafd281658daacfd85807e ]

The HP Pavilion 15-eg0xxx with subsystem ID 0x103c87cb uses a Realtek
ALC287 codec with a mute LED wired to GPIO pin 4 (mask 0x10). The
existing ALC287_FIXUP_HP_GPIO_LED fixup already handles this correctly,
but the subsystem ID was missing from the quirk table.

GPIO pin confirmed via manual hda-verb testing:
  hda-verb SET_GPIO_MASK 0x10
  hda-verb SET_GPIO_DIRECTION 0x10
  hda-verb SET_GPIO_DATA 0x10

Signed-off-by: César Montoya <sprit152009@gmail.com>
Link: https://patch.msgid.link/20260321153603.12771-1-sprit152009@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 26e2e7befd60d..504edaf14d39a 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6902,6 +6902,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87cb, "HP Pavilion 15-eg0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87cc, "HP Pavilion 15-eg0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87df, "HP ProBook 430 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.53.0




