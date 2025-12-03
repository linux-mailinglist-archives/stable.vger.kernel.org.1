Return-Path: <stable+bounces-199448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8682ACA009F
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98A603021DF8
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254A35C184;
	Wed,  3 Dec 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RpX4zzdl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4335BDDB;
	Wed,  3 Dec 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779834; cv=none; b=UxnBKF1XGcISD9ZKWtuYQ/701LbSICnYKeA4vowhViNgJcdRpG1t6KFLw6vnGyTMUDa33iD6qDXhpzIYW7hNIUP/5qWMAIN9xdytYTIyIuqDN56ZseFAYfenmngvKiCxrKAsqcOsSATcxlTusoW0GgFLqg6Z56jct65TF/da+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779834; c=relaxed/simple;
	bh=D81D334A6Yc7JJ8+tXFnYxp2JPkqSbtXDi0aY+LBqVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVkuGY8iWWjlKun1oxBi0YeJqxYRaYi7zVvXbNEIqwQ1gsnUA/S+d0EUaBthoXGNlG4pD4hwnxWSP2siQG8W8B4E9ZMs0Vr17yG/j3WQQPQWm/A3vFoD1bhnn98FCuvx6Gt8kTzSftkKWIrWil/b2DalFRMto/A9JKV/bIvnPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RpX4zzdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A0AC4CEF5;
	Wed,  3 Dec 2025 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764779834;
	bh=D81D334A6Yc7JJ8+tXFnYxp2JPkqSbtXDi0aY+LBqVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpX4zzdlZe86DQYxYKb4Io7dot/lbkxlUTM3SxnTteLXEBgXHOzzzDAGI5nhSLZ3L
	 mZ1TH1kei0jsaJf3u1LkEyymtYVJX1X4wicov5YYEUNYAR6cjP2uyy5k4wYprG6B5e
	 301K4RiXyh77cAkgAvaclgsf18sFTgMEE3nh/mH4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 375/568] hsr: Fix supervision frame sending on HSRv0
Date: Wed,  3 Dec 2025 16:26:17 +0100
Message-ID: <20251203152454.432273941@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 0b23d52b8d87a..81eaae4c19da1 100644
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




