Return-Path: <stable+bounces-141878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA7AACFA6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 23:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704564A8AAB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 21:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF1C221277;
	Tue,  6 May 2025 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug2quOKo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1022126E;
	Tue,  6 May 2025 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567355; cv=none; b=JbIQCPQdI8DdYZ2Nyb1H+CIRmXQZnJaU0SyN0RYbRJ9LDvBIJoOTLudhpQr5PQH9o/hin4+Sv6Ch4IQhkh+bjBFrtAuBH8PtOhej5vNAD1wZBkOgBexj2c6WL9iElCTHXbU3N/Mb9FQKlFoWV4wqMC8mEcNl6ToFLmJsHpek6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567355; c=relaxed/simple;
	bh=SyCbsSksxFRmZW0apmLnPJYYchzfA3iSIEsLMCoA+b4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P2C4paEOcdNh3fkQazLIiOv31guE9JtWw71eB8BbTXL/dUEOX36uZ7DJPpGZB9g54xyhz3wJdRfijqYY4HvvkCTPLMOU4Of4UjkYESCMZYrNHF8JyBDf5UIInY+dlvPd9w2WmqU7OZI/sxNY0j3BZBgM66NahjrtiVpC1DHpZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug2quOKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F32C4CEE4;
	Tue,  6 May 2025 21:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746567353;
	bh=SyCbsSksxFRmZW0apmLnPJYYchzfA3iSIEsLMCoA+b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ug2quOKo4L+HKYBUTMZBjXfgqbaSnZOhvAnBU85OYpfITKMxqaROY5H2Fzil+8F87
	 FQOKoBHBIXC0FfXYS59A24YDhZCr6iia+1Eqf/okxsV3DmMFkeiYwRzxi+MZqTSufD
	 gzjOs0/KQD5djtI0izdKUbC2OA2QpFLTQt2UY7o0qaKx5atO7FBtCw0FFocPNO2L1a
	 jqqICwHOjMdSn8mD0jbsArK/u2G2pZo5Bebi8RTEWF4wURY6wuhfnQFAC8uUcaup3i
	 bRC+6yb4qgiGhkSvTGrS7hSDwASgiGrXd4doVeis7C5vb01bMS8hGaiCj8HSiFTiK3
	 CnmZYze8tFOcg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Paul Davis <paul@linuxaudiosystems.com>,
	Sasha Levin <sashal@kernel.org>,
	clemens@ladisch.de,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 14/20] ALSA: usb-audio: Fix duplicated name in MIDI substream names
Date: Tue,  6 May 2025 17:35:17 -0400
Message-Id: <20250506213523.2982756-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506213523.2982756-1-sashal@kernel.org>
References: <20250506213523.2982756-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 0759e77a6d9bd34a874da73721ce4a7dc6665023 ]

The MIDI substream name string is constructed from the combination of
the card shortname (which is taken from USB iProduct) and the USB
iJack.  The problem is that some devices put the product name to the
iJack field, too.  For example, aplaymidi -l output on the Lanchkey MK
49 are like:

  % aplaymidi -l
  Port    Client name            Port name
  44:0    Launchkey MK4 49       Launchkey MK4 49 Launchkey MK4
  44:1    Launchkey MK4 49       Launchkey MK4 49 Launchkey MK4

where the actual iJack name can't be seen because it's truncated due
to the doubly words.

For resolving those situations, this patch compares the iJack string
with the card shortname, and drops if both start with the same words.
Then the result becomes like:

  % aplaymidi -l
  Port    Client name            Port name
  40:0    Launchkey MK4 49       Launchkey MK4 49 MIDI In
  40:1    Launchkey MK4 49       Launchkey MK4 49 DAW In

A caveat is that there are some pre-defined names for certain
devices in the driver code, and this workaround shouldn't be applied
to them.  Similarly, when the iJack isn't specified, we should skip
this check, too.  The patch added those checks in addition to the
string comparison.

Suggested-by: Paul Davis <paul@linuxaudiosystems.com>
Tested-by: Paul Davis <paul@linuxaudiosystems.com>
Link: https://lore.kernel.org/CAFa_cKmEDQWcJatbYWi6A58Zg4Ma9_6Nr3k5LhqwyxC-P_kXtw@mail.gmail.com
Link: https://patch.msgid.link/20250429183626.20773-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/midi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 826ac870f2469..a792ada18863a 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1885,10 +1885,18 @@ static void snd_usbmidi_init_substream(struct snd_usb_midi *umidi,
 	}
 
 	port_info = find_port_info(umidi, number);
-	name_format = port_info ? port_info->name :
-		(jack_name != default_jack_name  ? "%s %s" : "%s %s %d");
-	snprintf(substream->name, sizeof(substream->name),
-		 name_format, umidi->card->shortname, jack_name, number + 1);
+	if (port_info || jack_name == default_jack_name ||
+	    strncmp(umidi->card->shortname, jack_name, strlen(umidi->card->shortname)) != 0) {
+		name_format = port_info ? port_info->name :
+			(jack_name != default_jack_name  ? "%s %s" : "%s %s %d");
+		snprintf(substream->name, sizeof(substream->name),
+			 name_format, umidi->card->shortname, jack_name, number + 1);
+	} else {
+		/* The manufacturer included the iProduct name in the jack
+		 * name, do not use both
+		 */
+		strscpy(substream->name, jack_name);
+	}
 
 	*rsubstream = substream;
 }
-- 
2.39.5


