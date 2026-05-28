Return-Path: <stable+bounces-255707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DOgF7ilGGrClggAu9opvQ
	(envelope-from <stable+bounces-255707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:29:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A035F8D16
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2920C317BAFD
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F38282F17;
	Thu, 28 May 2026 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZTU8fBtc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD3D2D9787;
	Thu, 28 May 2026 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999662; cv=none; b=AtpBjpFerXB/BqqWKCpMs8KUQH98uzvgyYS/LgTa5VxKLKdftDHwjfsokch/fCfyBsyqQNcG2E1bMSCjLidTFULslDA6GLx21JqpUkJe6hIiUuowF9P+IM9x6gkBejKYD4m4GC/BIepRltF8Ru+harGrFtr2eybiWWfoR9sJGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999662; c=relaxed/simple;
	bh=dJODmvuPfePY8VRvvWtYO75L0neDeS0TVXu4Hnrh0sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8ajN4NvP5QzZ4/ex8So6ky0o7bVvh031cMzUhm8WH283efxA86Ho3hAqUYQBJPNfT+DFRZyUGbWldCRoUgUC3OtXES7YuCQOPDfcsfjoOWeKhE8iWotfcvevyRK2x6Kg6a0T2Kc7/g0hOEuEA6+4WVKSWPUsV4oKmKwWhckpzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZTU8fBtc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A921F000E9;
	Thu, 28 May 2026 20:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999661;
	bh=fC5L5umEJrfbb3dCqgzg4NwlP3JjyvYMiVMRRBdHQ04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZTU8fBtc3F5tpU6whCzkdaV4d6rhwlYspvC7Bv26XAY7ofEoiiiJmUISPGhT6yB6M
	 3fkldg8tE4ecPvuUZrPTkd7I5YD/hwpBn8rML24WvvffoRvoCNuzCcxpGCsdHpnI+I
	 SdQW8YgpYDmxUHhXR6BWuTFJac/lMHJeDbrAjwkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Luxiao Xu <rakukuip@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18 145/377] batman-adv: fix tp_meter counter underflow during shutdown
Date: Thu, 28 May 2026 21:46:23 +0200
Message-ID: <20260528194642.571794562@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,narfation.org];
	TAGGED_FROM(0.00)[bounces-255707-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lzu.edu.cn:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B5A035F8D16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luxiao Xu <rakukuip@gmail.com>

commit 94f3b133168d1c49895e7cc6afbcf1cc0b354602 upstream.

batadv_tp_sender_shutdown() unconditionally decrements the "sending"
atomic counter. If multiple paths (e.g. timeout, user cancel, and
normal finish) call this function, the counter can underflow to -1.

Since the sender logic treats any non-zero value as "still sending",
a negative value causes the sender kthread to loop indefinitely.
This leads to a use-after-free when the interface is removed while
the zombie thread is still active.

Fix this by using atomic_xchg() to ensure the counter only transitions
from 1 to 0 once.

Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
[sven: added missing change in batadv_tp_send]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/tp_meter.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -451,7 +451,7 @@ static void batadv_tp_sender_end(struct
 static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
 				      enum batadv_tp_meter_reason reason)
 {
-	if (!atomic_dec_and_test(&tp_vars->sending))
+	if (atomic_xchg(&tp_vars->sending, 0) != 1)
 		return;
 
 	tp_vars->reason = reason;
@@ -885,7 +885,7 @@ static int batadv_tp_send(void *arg)
 				   "Meter: %s() cannot send packets (%d)\n",
 				   __func__, err);
 			/* ensure nobody else tries to stop the thread now */
-			if (atomic_dec_and_test(&tp_vars->sending))
+			if (atomic_xchg(&tp_vars->sending, 0) == 1)
 				tp_vars->reason = err;
 			break;
 		}



