Return-Path: <stable+bounces-50865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A926F906D30
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11B71C226C5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D287143C51;
	Thu, 13 Jun 2024 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bVoC60VU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7E13D614;
	Thu, 13 Jun 2024 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279614; cv=none; b=n7i/F8/h7jA/vQcMfJjCJXVQFl6OA6jrsYc8BjFJX4PPstd/PtmVXTUdl66XDvNEyFjRiDpinE3KWajCaea1hazBjRXEsv4wW77Ie+9sPCOdClHH8yiziPm5Dtp5nXfHWIN8O27FdCAijQvPJo6PpIErkUcLd745O1ELdrnwacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279614; c=relaxed/simple;
	bh=UiGA+LhlOZNDdiq12ZxXOYhHIxs6ju5yig04oZs6alM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU59hlM+nPHw1Jj4ejdgYWM3LHPCvRlapTYeQ7JFWNTr/OxhZ22B/UcXm7W3dqhhZYRQI3+Q7ex1WU8brJ40l73+E3Kf8iEa+QzzxbihbWeutCyQKBbI66z1SKfC5vvgHwwbCnru/FRigq79DzNJtzG4tX5jVvHS14O/5p/WMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bVoC60VU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5075AC2BBFC;
	Thu, 13 Jun 2024 11:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279613;
	bh=UiGA+LhlOZNDdiq12ZxXOYhHIxs6ju5yig04oZs6alM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVoC60VUrNxTlbxKqVm6bWk6+hWMH0hjoAq2vcZKO28GGKTOH/Pk0oeVHREf0a+YU
	 SbZLvcQnHWfMTiOSkRhCklQ14dvvNO+YndU1mnxOhDg8NzhoUsNTe/e7/WVKITbTds
	 Vx4i6JD6o+e9tU23O/XCqrA38x0n/GLxAMtj6OCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.9 136/157] ALSA: ump: Dont accept an invalid UMP protocol number
Date: Thu, 13 Jun 2024 13:34:21 +0200
Message-ID: <20240613113232.666157967@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit ac0d71ee534e67c7e53439e8e9cb45ed40731660 upstream.

When a UMP Stream Configuration message is received, the driver tries
to switch the protocol, but there was no sanity check of the protocol,
hence it can pass an invalid value.  Add the check and bail out if a
wrong value is passed.

Fixes: a79807683781 ("ALSA: ump: Add helper to change MIDI protocol")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240529164723.18309-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/ump.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -685,10 +685,17 @@ static void seq_notify_protocol(struct s
  */
 int snd_ump_switch_protocol(struct snd_ump_endpoint *ump, unsigned int protocol)
 {
+	unsigned int type;
+
 	protocol &= ump->info.protocol_caps;
 	if (protocol == ump->info.protocol)
 		return 0;
 
+	type = protocol & SNDRV_UMP_EP_INFO_PROTO_MIDI_MASK;
+	if (type != SNDRV_UMP_EP_INFO_PROTO_MIDI1 &&
+	    type != SNDRV_UMP_EP_INFO_PROTO_MIDI2)
+		return 0;
+
 	ump->info.protocol = protocol;
 	ump_dbg(ump, "New protocol = %x (caps = %x)\n",
 		protocol, ump->info.protocol_caps);



