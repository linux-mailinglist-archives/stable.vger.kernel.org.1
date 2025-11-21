Return-Path: <stable+bounces-196363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C868EC7A0E3
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id EB20438D94
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09835349B0F;
	Fri, 21 Nov 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qtl20rLm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9D258ECB;
	Fri, 21 Nov 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733292; cv=none; b=SMM24X3ytrj7ghJpIS735a7OcZISbq89r1F59yZDPW2iuIrrz2PaQdYP7d9uv1OGaXwHHS1rqYQmyvCreHhUysONSSZj6NRIpxf4teMx7WVPBaFB1PJNyQ6tQCvtVOJbSpjDI2Qq15iGr+k9arFexAWy3g4mS1kk3UVvsVgsH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733292; c=relaxed/simple;
	bh=qyENcVdlIPBUWWrAGGs+RgnnBL5aQkQkEiBnYU4BLfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OW0To/NQaVmGXZCBneccryHMR36OE+r0fptxRJrRaF6IjF0UG2c0ZUrw0FUT1BzMcHS4eRmBL39CDRWbdq9e8hZjYrTlQ/MFAoMIho9wMsOXEdFd1HaqQurCXWDszIDjzCLlbSXQJ7vkgj+07f4tGEOR3iLHBQOZCZv120r6PMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qtl20rLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3612AC116D0;
	Fri, 21 Nov 2025 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763733292;
	bh=qyENcVdlIPBUWWrAGGs+RgnnBL5aQkQkEiBnYU4BLfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qtl20rLmeYrwMcRy13s9IQ/7A+gpPJK/m3oi8WPmFhAPV9KVd1Iq8DZWYyhF0BXZM
	 cPpi2fxk9VS2yaC9VA7GoS8KrNJnGWeKLetshXh7CldVXE7OffAk5q3uqleSptUBAz
	 PLl+T2rHW6d4rcDNy5N3aYGnFT26DLCa6OQDeTR4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 417/529] hsr: Fix supervision frame sending on HSRv0
Date: Fri, 21 Nov 2025 14:11:56 +0100
Message-ID: <20251121130245.855197922@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130230.985163914@linuxfoundation.org>
References: <20251121130230.985163914@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Maurer <fmaurer@redhat.com>

[ Upstream commit 96a3a03abf3d8cc38cd9cb0d280235fbcf7c3f7f ]

On HSRv0, no supervision frames were sent. The supervison frames were
generated successfully, but failed the check for a sufficiently long mac
header, i.e., at least sizeof(struct hsr_ethhdr), in hsr_fill_frame_info()
because the mac header only contained the ethernet header.

Fix this by including the HSR header in the mac header when generating HSR
supervision frames. Note that the mac header now also includes the TLV
fields. This matches how we set the headers on rx and also the size of
struct hsrv0_ethhdr_sp.

Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Closes: https://lore.kernel.org/netdev/aMONxDXkzBZZRfE5@fedora/
Fixes: 9cfb5e7f0ded ("net: hsr: fix hsr_init_sk() vs network/transport headers.")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/4354114fea9a642fe71f49aeeb6c6159d1d61840.1762876095.git.fmaurer@redhat.com
Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5514b5bedc929..70e958caa956d 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -313,6 +313,9 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 	}
 
 	hsr_stag = skb_put(skb, sizeof(struct hsr_sup_tag));
+	skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
+	skb_reset_mac_len(skb);
+
 	set_hsr_stag_path(hsr_stag, (hsr->prot_version ? 0x0 : 0xf));
 	set_hsr_stag_HSR_ver(hsr_stag, hsr->prot_version);
 
-- 
2.51.0




