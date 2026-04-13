Return-Path: <stable+bounces-236083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENuZIKTv3GmvYQkAu9opvQ
	(envelope-from <stable+bounces-236083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:29:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD03EC887
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A738301F9F7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAC23803F7;
	Mon, 13 Apr 2026 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="iSfp+wRo"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184153CCFAD
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776086700; cv=none; b=ZxJSHnIphdR0n8aceFNaLrQisb2JG31daUl8frpzQ4wjZTInjvdjgOgCixBXEu4vrPhGFaEncksD9CR8lRHXTXQbNkMg78W9f6sNCV8na0EgaougwzZJbDmwY5/vopg/BbZg3sQtkNP/ChXQZEyJCOSTgB40w4sllzWdzOe7cf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776086700; c=relaxed/simple;
	bh=SY4ppfGiqGuh2NpQcBn/3ZJLB9S4Z44h2yWQVxfJUy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QUbsrwKU8Wzsh3yaDGBoHCIvlCmKhmdHdg8S2QPh/YYseYLDevI4EDcFqBVaAC7PVxlXpuVLayVxgPHZyYPfvn44cdWGHId5l7+v7wrYNNDSBUOLpesEZG5T0+9u6uPRENaP58isV/U3xxj30WeBuZgmztEiTuUl3Y7x40XQtBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=iSfp+wRo; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-67e0d3f288aso2917681eaf.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1776086692; x=1776691492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ohiabhVJeZDvNot4kDpf/OTJgrLPoNGMxl2uIACRrAM=;
        b=iSfp+wRoumF5Dr+Fc8f4z0zXbILSm3lwtkgC1ewS/sagVSl9YFyADh8sR2nJQSzugQ
         IjagUqoecf+YPb1TRMveFL0Nv1eikIRbcgl7aQMgfXBX03q3Do7V+PPPRS8glVgKJyA8
         vVNq07Jf1AJlkPlSg/mRBql8JYXsgn4LJC6Gau4dyKUIiO8CcnTg58HR/3k2uvfwpCt0
         KPsS+pU0OVQcCaH6zKZJq2FCk0r+1RU67MO9PEKA+P+50j5p6t6qBMnQpZ+XQTdxO9jy
         KC2pnr47muSgViCneInPqdhbEpVXgeLFCMzPCNYRvJRWglACzQawYmxOUFXJtiQkHPTn
         v7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776086692; x=1776691492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohiabhVJeZDvNot4kDpf/OTJgrLPoNGMxl2uIACRrAM=;
        b=C/W8QA54CzPKrSx7apmuB9i1BMIewqyVlZzIwPwET3Fko0LoiaANcuBsWNfjOhgBS0
         Kfc/T+Nh8cxowwvVJwUwjD54p+ypujZge8QcNS30PK67vsHa2GXD2iZsscCY++ceoAqS
         e+93i1o04/N7kNEZHed7qBC4jUbO1dmoTePbg2tDHuCmAlTZL6ouiDBGdj7y8KLxiMNC
         2lKRZh1CQKYKV15g8DN52zKYJNZlqI8GYL9/nf+tOSCbE1QRxLIbcl/ZYb7M2zEcu7jy
         TE+CrHrqsp+a6jESvcQdcuAVzGeKsKfpX1kt1RwvUO9M5SpFMhwEVyNL/QLw4yQotMAO
         LeCg==
X-Forwarded-Encrypted: i=1; AFNElJ8xGE7fptE5quxy2MYf/CGZe0NIUh9bo1udKGxgOQcv+7B2HkRCRVZcJP27UJ8HfSiYd0Ux8XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmisMgPpDciEc9kxIU/6vBCsp6anbDttuAxvkgiKeFfrIbvDZS
	pehAzBwx/YtWntpQ/gYzZZZv7EzMMqxbi+4x5YGRmmTJ+KZq0QYFNCaMHygQYDH8WRbSJnN70HG
	5N3K3
X-Gm-Gg: AeBDietOdQ35QpVCUBoQvGv3kHdweGpXKKQbQBBTWUh9SbEsIA9NkmiOsHIeLx/Sgy8
	Wjmc5pkWR1w1KbFIBNW2lUNKxGW4Iq1+Oqy8uuiuZ2ys3irboRAb/XNfukZI+2bVVukgnGNfeeD
	zlGG7ImCHkF00ptYPnJ0b+lJXZf7DC39RwW2FC89J+Aik77IcQKsmgwR9TDArIkBENahDAo8gta
	jZsK3FJYibJn/3x7GyLf+zBD/sbx4diNIetevTWsz4BBa4gwkr2Wy89VlLROFBQlHwL2+IlFL11
	/kZggIVRKUfAa4D287zMxzpXOuX0QoTupUnt4/OTCXnCd/ZA2GJwxtguL7C+FA5iM74iBNKsJAB
	klEPvTEF+QVpLdMbNggv45GD/0/zdRGP/Jg1R18t3JyTBM8oQN7uIv1XSAkif/zBkpJj5Xulb6u
	DR4BFLKbjsCxJooo6PozKZssXtZXgXcfU+FAe3QTKk5w8gQlLXsm9FRoYHmuMGJEnTGbHuOiy91
	PsEJA==
X-Received: by 2002:a05:6820:168a:b0:685:d2b6:6df7 with SMTP id 006d021491bc7-68be5e52ec0mr6059370eaf.9.1776086692576;
        Mon, 13 Apr 2026 06:24:52 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:1408:155a:b1ef:795f])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-68bc7dfa196sm5969816eaf.2.2026.04.13.06.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 06:24:52 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Li Xiao <252270051@hdu.edu.cn>
Cc: Corey Minyard <corey@minyard.net>,
	stable@vger.kernel.org
Subject: [PATCH] ipmi:ssif: Clean up kthread on errors
Date: Mon, 13 Apr 2026 08:24:19 -0500
Message-ID: <20260413132448.1862411-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-236083-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBBD03EC887
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If an error occurs after the ssif kthread is created, but before the
main IPMI code starts the ssif interface, the ssif kthread will not
be stopped.

So make sure the kthread is stopped on an error condition if it is
running.

Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")
Reported-by: Li Xiao <<252270051@hdu.edu.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Corey Minyard <corey@minyard.net>
---
This should fix the issue, here for you to review and/or test.  I added
code to make the issue happen, and this fixes it.  I added:

        if (ssif_info->thread) {
                rv = -ENODEV;
                goto out_remove_attr;
        }

right before the call to ipmi_register_smi().

In some cases it's possible that ipmi_register_smi() will call
ssif_shutdown(), so I had to account for that case.  That was
the only subtle thing I found.

You reported this as a security defect, and I'm not 100% sure it's
really that big a deal.  It would be just about impossible to
exploit this.  But, stranger things have happened, I suppose.

Anyway, thanks again, I really appreciate reports like this.

 drivers/char/ipmi/ipmi_ssif.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index ce918fe987c6..b49500a1bd36 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1268,8 +1268,10 @@ static void shutdown_ssif(void *send_info)
 	ssif_info->stopping = true;
 	timer_delete_sync(&ssif_info->watch_timer);
 	timer_delete_sync(&ssif_info->retry_timer);
-	if (ssif_info->thread)
+	if (ssif_info->thread) {
 		kthread_stop(ssif_info->thread);
+		ssif_info->thread = NULL;
+	}
 }
 
 static void ssif_remove(struct i2c_client *client)
@@ -1912,6 +1914,15 @@ static int ssif_probe(struct i2c_client *client)
 
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


