Return-Path: <stable+bounces-245203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEGZNH/XAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:19:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06450EC1F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19725305EAB9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3C23DDDAB;
	Mon, 11 May 2026 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="e4TMI/Qq"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616013DC4CD
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505074; cv=none; b=DUpLR9ahb/2bDPgEXM8upQy6xDopr4tAGQVugtIgLRTgdmqNAbG8qNpaozWsQz8WUFUOvt1c+WVjZqcYAGk0w2kc0APAeSARFgs+5EcSIhHsbRlOosIDB0k83+m+C7uioYJ1jJE89ruCxfmKGFGxzor8jXJfwbWXYPG8pvgXSxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505074; c=relaxed/simple;
	bh=fM2wVHThmyuvqdDAm3xbAIhTgUeL9+8366+hSxDnPxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBOmuva1FGeO8XJmuIX1qa1TBAtDbfJPvPfYht5hXHUM5LY1rUYv7fm8mCGLunijnG0hdkfV7l7f31iv8d3ZwJXpcW97taPJ+PZtJ+vZb2j/ql2Nlu7QrBYoW+a3QpfMLPJHDyfTg05L7aKpsm26t6cAkHQsAlzcZFLR+TlsN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=e4TMI/Qq; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-47cbd445021so2562092b6e.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778505070; x=1779109870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZBPksVpoGJR/FPIbZEpOehFd1sUWXIinRBJVoArRm8=;
        b=e4TMI/QqGPYCWp+MI2f6qkKvgobNNXB+BJ2ZAImkMdRPQ85dT0GhcchtIqCToQ+cJg
         +oNfaruzWAZUc20dC/w9hMLrCDGaZrdFPMOWgWgF7WNRfQlewb/YEB5q9V9a5TsJptyT
         yowvrYaxOgpMlSp2PFtLtFourrLqvGxwr+cliDviuLkWOJYXL3BeCnvmjsxxalUtvwyQ
         xv8KiVgsZQIHpMjOzy8aHSo+RX7mm3b4KB0JYeWC4ElAeZo9z7Zq0KgsyJfO5eyod+0J
         hXSmsdfo/Hmap/UlzR+rJ3/QadW2sgBjNiIxKjo1ypQEmRH3dDw2eJe0Ht0FrqXdzoTC
         RWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505070; x=1779109870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZBPksVpoGJR/FPIbZEpOehFd1sUWXIinRBJVoArRm8=;
        b=UB0+35AQphjFQa/QQBGTaI30r0SkMxA5BjoWPtFGrEF1tIHlr3ZzSzsMAOWWDCbHj0
         bbUCO33+0l2uRnF/OQkv7vhggOLrmbfsX3jFAndYxbAoXgOcJoEJdq7x9ItxSVX1BGtm
         zoKE5dT1ero2EfGeJphkkp3Ybt0d6Wq8LIJZ1zgnTrHCSWVRaHYzNeukyJiiJt5wWJA5
         tuEBAWjr6VwXeefiYxery4JJ9pFHgskWJAd+jFLVc+NkUBPmyuZuKxJevvzKGzU7/xZU
         aAxTWxe3U0luXh5fvxUsyazaMvErlfCz5/5b1LGKLj5BSsS+7QZQqBZX1mB3qd5byp9k
         T1gQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rNlH4v9J18MR1xAsH7lEkm6klhRCHU2tFti8ZGRP5BJFVHIAB9LXVehuxFFrxo26N8k77FK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfborqA6LdFsEZGQDHD0TnAH4ucZgch/uVK1PzRfURlRUDcVgo
	j2hXECzZOLQOhl7/NB08V1mbs3IIHusPT5QjkTe/cMFQZyeVj8gzjqwZvS+53+0EaBLu05I6g+r
	JMjhq
X-Gm-Gg: Acq92OHVKS3AdWRiZxu/vUoyDejwBEQPxLapS4yVDLARu5SqCGIFl9IUAMkNsEx7ORu
	OnzIE53MseU39ztowqIaBN64B8WpWTPjqFoSq8GOw4Jo/m1upJAGrxWiPUGp8ebn2FblXlXmMme
	RrgrswlHbTVPtOLEMoWlqfJ6lDWuQQ2XC4gkjU+YcslCGTAE2rxkwR3jeckbVqyWWZBAJEg3QdN
	k26C8Wtwdn0UygCFKav2jKKb6DbyAQAf9845h4ntrbmUmkqSYkcGsQocGdDWr3gN/X3E/8bO8BR
	KgC5to6oLvvW7W13KC0VIwADebOP8VH0RdLpK/cweyhE5uWqqccsumeqftRcEWE9aYX4Ac2toSO
	VJxUuyL7ewZKfADlQ/kPY0z9T5kzGNf/54r14GzG2aSwERMmCO9UQdC2duxb471YHO3VSdjE2k1
	c8SYsPBUXoQjh2SkPsfgumgdwnp0oDgp5AmVk/k0+UTHSLn0m4rAGxFu7iNoYB5Be7tJwxRwKuQ
	LI=
X-Received: by 2002:a05:6809:158:20b0:479:db65:8dbc with SMTP id 5614622812f47-4807fd3987fmr5024336b6e.30.1778505070199;
        Mon, 11 May 2026 06:11:10 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8478:44:4948:b0d3])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-47c763ffe6csm20341021b6e.6.2026.05.11.06.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:11:09 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Li Xiao <252270051@hdu.edu.cn>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 5.15.y v3 2/4] ipmi:ssif: Clean up kthread on errors
Date: Mon, 11 May 2026 08:09:24 -0500
Message-ID: <20260511131100.1772190-3-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511131100.1772190-1-corey@minyard.net>
References: <20260509122858.ae87f8133ecd.re-ipmi-ssif-cleanup-5.15@kernel.org>
 <20260511131100.1772190-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DB06450EC1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245203-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,minyard.net:mid,minyard.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

If an error occurs after the ssif kthread is created, but before the
main IPMI code starts the ssif interface, the ssif kthread will not
be stopped.

So make sure the kthread is stopped on an error condition if it is
running.

Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")
Reported-by: Li Xiao <<252270051@hdu.edu.cn>
Cc: stable@vger.kernel.org
Reviewed-by: Li Xiao <252270051@hdu.edu.cn>
[Adjusted for stopping flag and complete operation still being present.]
Signed-off-by: Corey Minyard <corey@minyard.net>
(cherry picked from commit 75c486cb1bcaa1a3ec3a6438498176a3a4998ae4)
---
 drivers/char/ipmi/ipmi_ssif.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 430302d2da6e..b884bfae7fa6 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1292,6 +1292,7 @@ static void shutdown_ssif(void *send_info)
 	if (ssif_info->thread) {
 		complete(&ssif_info->wake_thread);
 		kthread_stop(ssif_info->thread);
+		ssif_info->thread = NULL;
 	}
 }
 
@@ -1922,6 +1923,17 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
  out:
 	if (rv) {
+		/*
+		 * If ipmi_register_smi() starts the interface, it will
+		 * call shutdown and that will free the thread and set
+		 * it to NULL.  Otherwise it must be freed here.
+		 */
+		if (ssif_info->thread) {
+			ssif_info->stopping = true;
+			complete(&ssif_info->wake_thread);
+			kthread_stop(ssif_info->thread);
+			ssif_info->thread = NULL;
+		}
 		if (addr_info)
 			addr_info->client = NULL;
 
-- 
2.43.0


