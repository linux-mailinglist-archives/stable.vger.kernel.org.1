Return-Path: <stable+bounces-246843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMslDtd0BGqdJwIAu9opvQ
	(envelope-from <stable+bounces-246843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:55:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA7853369A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC07318AFB9
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81573426EA3;
	Wed, 13 May 2026 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gak/LPfN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45360426699
	for <stable@vger.kernel.org>; Wed, 13 May 2026 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676524; cv=none; b=QGU3zb50m44i9y0BJ9pw2p56/x7OMExRJlibF3THbfD5BF8A4btRFJP7Ee4P03JIkjo9K7fwE5l2+krResJ/CnnKwuAkUe9n0MNTUE4vhDaxpYqKWoEUb2FAvBM1KJ93C7QX+SgyxJ9SsZaZbIEsAjS3RGUlfGLqNSvl1NTany8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676524; c=relaxed/simple;
	bh=nBTOImue/7Ox3okmnQuOqwPuv8DYIODfrumCVl5ZVOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCVsb8suHkGZFA8FikpC4PiS0cx74VFzf8LZf4UuidXU9MMNSKE8sWmVtNd3XN4wlzmJGgIERpEc1M8pw7VAdgmZwQTPQK782sNCuUWvZjv1hT+IVLgMk5zztFxQNddWqvgE1xEU7cCm8yuWxVr2UtnzI3VvV9EPhKa9nN9MF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gak/LPfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19140C2BCC7;
	Wed, 13 May 2026 12:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778676523;
	bh=nBTOImue/7Ox3okmnQuOqwPuv8DYIODfrumCVl5ZVOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gak/LPfNO5t7SvtyLnecZ0Eojd5dqjhf8JgaPAmPuBzu4cbVUlZUHOAYubDOUEnXG
	 MU8MV/tD95uBw8QRGeM+Wl/H1UzPWnFn/d/U27cLx567Iochoks/A1K2kb4fEFkCKi
	 wScuXyXPjSo2MqbpwNGS/RCYjUvqkXLuujybRJ9aC4Vzu/+ikFm4h2O3/dNemv4Aw6
	 A+sEtaeHmkRcnSn2MtOQHUWSk3nPaU6wStrlh9qfqAgxPiOrjED7W0aCvcJeGeVkWn
	 cm/SVCkt7RDVmtyV2I9RTAZ8PIa8HVzj0chKTplythFKEhkwRs0kVUeaXMfW7OahFk
	 BFMoXAT4+vxTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task
Date: Wed, 13 May 2026 08:48:41 -0400
Message-ID: <20260513124841.3712467-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051206-scalded-clone-94cb@gregkh>
References: <2026051206-scalded-clone-94cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8BA7853369A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246843-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,broadcom.com:email]
X-Rspamd-Action: no action

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit c623b63580880cc742255eaed3d79804c1b91143 ]

Watchdog task might end between send_sig() and kthread_stop() calls, what
results in the use-after-free issue. Fix this by increasing watchdog task
reference count before calling send_sig() and dropping it by switching to
kthread_stop_put().

Cc: stable@vger.kernel.org
Fixes: 373c83a801f1 ("brcmfmac: stop watchdog before detach and free everything")
Fixes: a9ffda88be74 ("brcm80211: fmac: abstract bus_stop interface function pointer")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260416093339.2066829-1-m.szyprowski@samsung.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ replaced kthread_stop_put() with open-coded kthread_stop() + put_task_struct() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index e265a2e411a09..5f6c0afe22d49 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -2477,8 +2477,10 @@ static void brcmf_sdio_bus_stop(struct device *dev)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	if (bus->watchdog_tsk) {
+		get_task_struct(bus->watchdog_tsk);
 		send_sig(SIGTERM, bus->watchdog_tsk, 1);
 		kthread_stop(bus->watchdog_tsk);
+		put_task_struct(bus->watchdog_tsk);
 		bus->watchdog_tsk = NULL;
 	}
 
@@ -4549,8 +4551,10 @@ void brcmf_sdio_remove(struct brcmf_sdio *bus)
 	if (bus) {
 		/* Stop watchdog task */
 		if (bus->watchdog_tsk) {
+			get_task_struct(bus->watchdog_tsk);
 			send_sig(SIGTERM, bus->watchdog_tsk, 1);
 			kthread_stop(bus->watchdog_tsk);
+			put_task_struct(bus->watchdog_tsk);
 			bus->watchdog_tsk = NULL;
 		}
 
-- 
2.53.0


