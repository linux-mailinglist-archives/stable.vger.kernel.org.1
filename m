Return-Path: <stable+bounces-245452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AWMNYQbA2pD0gEAu9opvQ
	(envelope-from <stable+bounces-245452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:22:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC915200B8
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DDBB3024AB2
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F83F38D417;
	Tue, 12 May 2026 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fN/74jED"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9038D404
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588537; cv=none; b=gcEnb74/oyHWHmvbCVwZIntewP5bACia1FyRhQ/McuvgoeDg/xjCVXE3lL+3ulSTsH+YGCzPrvfMAO8qvuhqZoTh/bG1Xx+q/ts5rmFKoiN7kOJsCpWGJBt8hxV5xSkAmm9J4psGTQoC559S5UdQU3oWsJvGg1lvRPPZQEvyd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588537; c=relaxed/simple;
	bh=l5jde6KD7XzMgWpkSCuGk1s7rfgH/9SXAuzS6HOBPPA=;
	h=Subject:To:Cc:From:Date:Message-ID; b=mSNs4N+dnaQR41lqlVyG6lLVLeRF64bRlM+x0c1VYI0A4UwDQH5snfQVwgdoSeptEwISiLCtY0W0N4nkEehdHM7HktrR8rB9PWW8JF76EcLG68GTz0yfixaBpGIcdrQJX/pm4Ldnk6iBG0kUMyuv5jjaOPS1uimz1dguJBUKa7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fN/74jED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3583C2BCB0;
	Tue, 12 May 2026 12:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778588536;
	bh=l5jde6KD7XzMgWpkSCuGk1s7rfgH/9SXAuzS6HOBPPA=;
	h=Subject:To:Cc:From:Date:From;
	b=fN/74jEDyXc+FtENd6C1Zi+C8hsRZLMk+z8aKYej8MOKdqKz+xlXLQym7QhroOijy
	 mYBGRn84Kc4Uxb5kghyScDy1d3L0aZNRF2iSBODIyF81XEMYFy1XBXvK/OIGUriKEx
	 8xQd2SXoUO/I4K1kCu6BTJnNDl1jGdJWvAZzvNZs=
Subject: FAILED: patch "[PATCH] wifi: brcmfmac: Fix potential use-after-free issue when" failed to apply to 5.15-stable tree
To: m.szyprowski@samsung.com,arend.vanspriel@broadcom.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:22:07 +0200
Message-ID: <2026051207-posing-gauze-27af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 7BC915200B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245452-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,samsung.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c623b63580880cc742255eaed3d79804c1b91143
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051207-posing-gauze-27af@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c623b63580880cc742255eaed3d79804c1b91143 Mon Sep 17 00:00:00 2001
From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Thu, 16 Apr 2026 11:33:39 +0200
Subject: [PATCH] wifi: brcmfmac: Fix potential use-after-free issue when
 stopping watchdog task

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

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 30f6fcb68632..8fb595733b9c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -2476,8 +2476,9 @@ static void brcmf_sdio_bus_stop(struct device *dev)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	if (bus->watchdog_tsk) {
+		get_task_struct(bus->watchdog_tsk);
 		send_sig(SIGTERM, bus->watchdog_tsk, 1);
-		kthread_stop(bus->watchdog_tsk);
+		kthread_stop_put(bus->watchdog_tsk);
 		bus->watchdog_tsk = NULL;
 	}
 
@@ -4567,8 +4568,9 @@ void brcmf_sdio_remove(struct brcmf_sdio *bus)
 	if (bus) {
 		/* Stop watchdog task */
 		if (bus->watchdog_tsk) {
+			get_task_struct(bus->watchdog_tsk);
 			send_sig(SIGTERM, bus->watchdog_tsk, 1);
-			kthread_stop(bus->watchdog_tsk);
+			kthread_stop_put(bus->watchdog_tsk);
 			bus->watchdog_tsk = NULL;
 		}
 


