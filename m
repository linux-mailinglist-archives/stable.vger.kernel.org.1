Return-Path: <stable+bounces-242449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH8cHkG/9GkDEQIAu9opvQ
	(envelope-from <stable+bounces-242449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:57:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A794AD6F5
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD453010C29
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0766F3BED76;
	Fri,  1 May 2026 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="bJ6/FFzE"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEDD3CAE69
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647276; cv=none; b=OxBLC0GiWWCm86LcszPRWOKKMjlegustEdEz2xPzH8I4hTiB2mpm8674nDJ8ypKWQtSW6MYlTwlNyNPaIgRvjWfXdT/LiX9OAXtsPbuVSP27POkK3/YOWEFsV7asYNmC1gwrHOIaY1W8WhHutui0QXGVpD/nkhuUuxlLqfpD318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647276; c=relaxed/simple;
	bh=qFyrCnZAzSJQd0E4FJymUTI7vBnHnCzvYBPLXbpVbws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6+sB60MT8Jn/cRM86pmL8k0AiJH/SRtc5I3FYTuwQ9jPN+EU2ixDb2wo09T6EisMvlr/huXAXku4/wyl9+6Xe86v1QmOenTVYJFyqYsKu4G0XAka493aIv3KhX23ri+kCJEzTn/9odnLKONDT+F0MPZLrQmpNXN3Rx/ebtJIN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=bJ6/FFzE; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-47c35be02fdso812790b6e.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777647274; x=1778252074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xee2uFjHb0bHsfIB4ny/0BgT+KquqxxQ3AdhM4LqHw0=;
        b=bJ6/FFzEAJ/7uHZUTVatYIA/TWa7Ct41cFuV0UpRZDa7494TOueLLvkmAJrxiyr152
         VFuqg/xx9/HQwkCcEtY/CPbySILy8d33/49LH35i4NtGDyngh2XvDR6BeVv4fQ8djSmf
         zE3ySafvUq1G+bBwKVYpXgvW4IOvGsOicfke0ihkZMFVixXUFJKDRX9/VImzjm1vCJMW
         dmewrG7mww/MmK90Cf98Oib2fTAnYBSF4NVXAbGtMDLY3IHhMsgbn+I4Pc1yO8WCiGi8
         UUUH4crWyVzeP5beINfjhoWJ3NEaB8V0DoTQUV1X54dzzi7nvEjF0TFCPgoQ9eip5R6U
         /DfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777647274; x=1778252074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xee2uFjHb0bHsfIB4ny/0BgT+KquqxxQ3AdhM4LqHw0=;
        b=o+tem1+OtdYb6tIrbRUA0hofbjEk2u3XRYSdATqQOcoUQO9ey9s63a3xGY5A+f33Mp
         ApzKkk8wyL2DbkTETfTIsEc0fzbTb3W2rQjMMT35zod0xgZyUv17B5yfYEqmEBfccy0j
         +4DstN2vrkoKnriB8nd400/bLOw1Dh1sLnSl9ENAczjZbCa8g+FE//oumr2i0qgB/+ns
         oESZ7ll+9XmrsS9w9A5oeMEZ/DX2M69/RBuKWIrlk62MM0Wg/xxJGIi4vBFnwdr65LaI
         K7DNls3F0B6cFqX/8vX1yo2bsVqT/F37K/72044zdjyi/FHa7mlqdJzYodn7yv3tkzAW
         HlxQ==
X-Gm-Message-State: AOJu0Yw1CRcXSBT8zhu21tQH34awTyHFL7J42w570/LoXRxYn84fEF+W
	z+rgKaBqoQfihATy7BDE3XiJizf9oC3uDPAFgukzOtUFVRu5ICbxJr/g6iu869aGgwojYIU2LVI
	nmFNv
X-Gm-Gg: AeBDietUBDf50PYvkHMfc7/9bouZukM3eD0YaqU5l9TlqO4K9SD1HoSqsVVxZ1x6w8X
	AeBLf4Sbbiqa5YG9z9oDVv22H1d+g2LpMwTgU+etwWxzkrxQoeNFk9/Fi4LcHDdjp+5MO/jqeD9
	xtGujWw2guqb8NMr+IOBhtJ2nnUwAi5Y7hCwUaeUQO1upJKfE1wowT+LRt87DU3JtueK/xF5Om/
	j/9uAGpmZqNLgqIwTk7Uwqe2zjs8FSu2IZib0Stjt99fSZoSwYcLlbV8sfYbNpvBp67uFIZ9IeT
	3w+mbcr9SjjB2ne+s0D/u9QKiQwZev4XhUaASNUpHBMrUPFsQ1d4IoGeekE2hvDv0OWIIsznx38
	DOFFI+07Ar03Be768ataym0uf/LOgfQHt5scDD7GWkVF7YN4iZH2YSzHygJv+Kj21YLdsZlR9ba
	KNyU3avaymLnze/xSrzrGg+y+9+GdoPHa3XuMlEcVsp7xgJcRkRTHejNriJmokP01gl1OZ5tiB+
	z+Xi+TeD5ue2YGQ
X-Received: by 2002:a05:6808:1510:b0:45f:8be:d983 with SMTP id 5614622812f47-47c7549be1amr1482165b6e.12.1777647274435;
        Fri, 01 May 2026 07:54:34 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:4129:1360:1c90:7857])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-47c763b33c1sm1464717b6e.1.2026.05.01.07.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 07:54:34 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Li Xiao <252270051@hdu.edu.cn>
Subject: [PATCH 5.10.y 2/2] ipmi:ssif: Clean up kthread on errors
Date: Fri,  1 May 2026 09:54:27 -0500
Message-ID: <20260501145427.900030-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501145427.900030-1-corey@minyard.net>
References: <2026050148-irregular-kite-7f24@gregkh>
 <20260501145427.900030-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4A794AD6F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242449-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

If an error occurs after the ssif kthread is created, but before the
main IPMI code starts the ssif interface, the ssif kthread will not
be stopped.

So make sure the kthread is stopped on an error condition if it is
running.

Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")
Reported-by: Li Xiao <<252270051@hdu.edu.cn>
Cc: stable@vger.kernel.org
Reviewed-by: Li Xiao <252270051@hdu.edu.cn>
Signed-off-by: Corey Minyard <corey@minyard.net>
(cherry picked from commit 75c486cb1bcaa1a3ec3a6438498176a3a4998ae4)
---
 drivers/char/ipmi/ipmi_ssif.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 22074f23c06a..ce0f20cac88d 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1277,8 +1277,10 @@ static void shutdown_ssif(void *send_info)
 	ssif_info->stopping = true;
 	del_timer_sync(&ssif_info->watch_timer);
 	del_timer_sync(&ssif_info->retry_timer);
-	if (ssif_info->thread)
+	if (ssif_info->thread) {
 		kthread_stop(ssif_info->thread);
+		ssif_info->thread = NULL;
+	}
 }
 
 static int ssif_remove(struct i2c_client *client)
@@ -1908,6 +1910,15 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
  out:
 	if (rv) {
+		/*
+		 * If ipmi_register_smi() starts the interface, it will
+		 * call shutdown and that will free the thread and set
+		 * it to NULL.  Otherwise it must be freed here.
+		 */
+		if (ssif_info->thread) {
+			kthread_stop(ssif_info->thread);
+			ssif_info->thread = NULL;
+		}
 		if (addr_info)
 			addr_info->client = NULL;
 
-- 
2.43.0


