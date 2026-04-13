Return-Path: <stable+bounces-237565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ISgNF4j3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-237565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:09:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C8F3F0DD7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 804FB30B5F9D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0D33F5B4;
	Mon, 13 Apr 2026 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QPdqaOIv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA413161AB;
	Mon, 13 Apr 2026 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099783; cv=none; b=OXR6qbOOW8Dzx24+DL/WanxJT55BmpjF9iZP2H5bT0SdByEkvOJFHO3k1Gp33ThdBOQ7Jky8OsI4lS+p6K4WQQoA9985XmcYmA0+VgmwGq0pC5SXT2U8oOlV0YNdBozoXuzc736l78xF4fF5v9mB6E8N1UGDzgoeX//rCTNPVts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099783; c=relaxed/simple;
	bh=SCMUQtNqrWPlVjE0XaLY9SKvB5a9gKxDUk/WkEdImaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFP/CbTDc/csD4vN97zYQFhJ18H/f7W99M7LhLN3jb8tmiQ7h88Q79NZfenSDBzxfvmBmc1VzgqUVw5KccLJCl6SmTqT1aueCjkYH4ArcMlHKwzteRTZzZAtCQLicDa8PSG9vkVgyGyU+k1gPg5T+PYyELsk4XwWdoDQ86sQjUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QPdqaOIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AB6C2BCAF;
	Mon, 13 Apr 2026 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099782;
	bh=SCMUQtNqrWPlVjE0XaLY9SKvB5a9gKxDUk/WkEdImaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPdqaOIvg0EGcWm/TNz5J0+70SPZGMy641YhcHmFZihWQhTVrXYzvsKhj2Svv7SpH
	 yd9/4g/sDf2zoAZDhdaaPwPNsBbxhjzIbL5h/4I8yhvajeuYE1YZM9D8U9r1dqcouf
	 LZbrogxyjhCoRRVSRSIH3k1JXLrf1UwZ4ztT1smQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jon Hunter <jonathanh@nvidia.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.10 455/491] ASoC: tegra: Fix Master Volume Control
Date: Mon, 13 Apr 2026 18:01:40 +0200
Message-ID: <20260413155836.070169376@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237565-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73C8F3F0DD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Hunter <jonathanh@nvidia.com>

commit f9fd804aa0a36f15a35ca070ec4c52650876cc29 upstream.

Commit 3ed2b549b39f ("ALSA: pcm: fix wait_time calculations") corrected
the PCM wait_time calculations and in doing so reduced the calculated
wait_time. This exposed an issue with the Tegra Master Volume Control
(MVC) device where the reduced wait_time caused the MVC to fail. For now
fix this by setting the default wait_time for Tegra to be 500ms.

Fixes: 3ed2b549b39f ("ALSA: pcm: fix wait_time calculations")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20230613093453.13927-1-jonathanh@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/tegra/tegra_pcm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -111,6 +111,9 @@ int tegra_pcm_open(struct snd_soc_compon
 		return ret;
 	}
 
+	/* Set wait time to 500ms by default */
+	substream->wait_time = 500;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tegra_pcm_open);



