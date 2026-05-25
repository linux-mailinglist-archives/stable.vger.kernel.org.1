Return-Path: <stable+bounces-254199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFFRLf+vFGqWPQcAu9opvQ
	(envelope-from <stable+bounces-254199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:24:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDC45CE510
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13CD630207FA
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A46A393DC0;
	Mon, 25 May 2026 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGzm+/DG"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C3335F5E3
	for <stable@vger.kernel.org>; Mon, 25 May 2026 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740660; cv=none; b=F7sBccbGWuxI/Lx8RC87QhbWxVs5zl/SCww0oMTrCkbNiM9oCvc1BaiN/GjBgo2XEIoGj8xxxP+aimeRSuj125MSjxCraolEY8oCxip9wYaMKVl5eioaIVxFgzC46S+a0ETPl4bCULQuz9htYVsES31uxr/+ydBAVeEc9pRJ38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740660; c=relaxed/simple;
	bh=grdFfHOkHxTLhLsS6j+FX41ur/btn/7guyqiP83xFg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKteUcHXeS21QwAhnk9a2MbJK1uyKXbBr+MyKo64xjePX0yIS3GeHx9NLMlFNjgxmQN366H/XlnIk8jHEX1YeiO7xbtP68sVv+7D+eC4OJrMTLZGYVP1Oa/Cx9KRFih6eYFK3mm1BympwH75YICxaAUYsnclcoLajIep7N4D5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGzm+/DG; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4855e69a4c0so2594505b6e.1
        for <stable@vger.kernel.org>; Mon, 25 May 2026 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779740658; x=1780345458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfK7e3u1o6Z9pLVZ7VLBuH4tZqriU9FnwEkSwlD5KZ8=;
        b=YGzm+/DGO+PYwS4sV2FDAq6Mh7yEELHU7OMvE/LUQBQvA0FtnrzqrvpfEeRwjrrQdY
         4eZhfV/K+JJ7cAVlA4gfLCejf0uDvgUfV9U4tuMx2J1r/9H9WYh5LvdHXIPrln01VPqO
         kOf5FtSRJgeCRd2CKUXLj4AcOs3gaBEBTMJPx9df8fIra7FD/dLzUE3EfpxfMagyQA07
         t5Z5GKNnCaPVzWki3cwBvyKMn7sluSfrTEe3IMXl/GRSIWpNuhYwgzme3ZA+jvEuS13q
         FSTMkdSraAs3lLz3+F7IQRR79ppBGnhrxfsYnJBVEHxytLjlDC83HEXaWdj5QS4c/Y4F
         hv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740658; x=1780345458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tfK7e3u1o6Z9pLVZ7VLBuH4tZqriU9FnwEkSwlD5KZ8=;
        b=Xu838Qbq+x/ERZl3wQ9Icz7+mjsCpkirKmR5THmHD1Ts1RXMLLDlkdao6hbc4KUXv1
         mABZUPmNIfFT/7m+vNsocf6J/CJPOOisUcjQs6vYWAT2KvPmdr1bsgmTwExJRZOfmZXo
         ty5ir0ZlZjdUvWmkQtJE2kBDx+cZUJ+zQXh8gN0xU+xEtrfm3kWj0ehnrRAH9aGouwtH
         Dd5rCgFxJjgqsnmnIAIH5b5aspJQCIy7ZRgj8gIAMM9QrEr7QhJUarNhXjv6dQmaCnB6
         j++Aj7PwLRquqB9jgUB3+qDFHzRv9AGektlldHFrPg+0okp7SS0o0/ARA/bxNKKz7BwE
         fvaA==
X-Forwarded-Encrypted: i=1; AFNElJ//v5DnWhe8OIl8obb3KdzFh7y/3FcZeGmSoCQCIwt+iT3L29LlDxxBCkTbuo4HDX9f5tuzESQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyShIrHeX1IdwOfqPKuwYpSQ9qKb+J61FxTXC/wqC8Z1mpqXRa0
	DSG9dmF+9iDGwFrpRdqJlqh0fEi32V/IQWc46t2jsESRc4AzRc6WEQhE
X-Gm-Gg: Acq92OGXYKMATCCtzJ/Z0TtNJlThn/0jDnHDEOS+qy7FF7M6JW39eB9JDuCLTjsalik
	6mbNpC/sO/ojbaSDcYoNrsqcfwxtfeZ2smoL/GGyLFwwhx//xH5rwr8xgrHCNsHXzLsskgtqy6z
	58ewXSfAtbzszBVwxBdHgQ0CbCxPPaFHe1hIxnNmwOBpprHKmFxdie+Rp0+6dZ+TKs8FtciVXI9
	Sc7H1Q+ffnOwDKvia0gV1Mj+4aGvh45jpD3IXDnPvmRyJ9xAaaLpA4jmdhiNqCmetCGvBTkZquV
	5AXfnQtY6xiVZbbbXvH68dqhoZeHlN7jIN5NgJrwVEdNkmXdaDTUadjWQCBe+cGGC/FLMBATeVE
	YkpgzvxJosS6gHFJKXMw7Z159WZ6SEJb/rWAAVUxn2bxuhYbbBsPKPYQKRS1ioZJDaSe0AGHLcc
	NYrgoIFPsXv5/fI/Vcc2fa2/1fWBbiIMmgPQ8flgf8WmtUUXuViw6M4X9bCbGA4+X5LP1fSUnj8
	9bkh6JG5m+V28mUFdhLWm5dBBDpzTqOS4bbdZWUI7UsAb8=
X-Received: by 2002:a05:6808:5387:b0:467:254:b90 with SMTP id 5614622812f47-48549d6e4cfmr8815138b6e.10.1779740658155;
        Mon, 25 May 2026 13:24:18 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554757d5dsm5204305b6e.15.2026.05.25.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:24:17 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH 1/4] usb: gadget: f_uac1_legacy: fix file handle leaks in gaudio_open_snd_dev()
Date: Mon, 25 May 2026 15:24:08 -0500
Message-ID: <20260525202414.602-2-adriank20047@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525202414.602-1-adriank20047@gmail.com>
References: <2026052517-undergrad-reformat-44bc@gregkh>
 <20260525202414.602-1-adriank20047@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,linux.intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254199-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1EDC45CE510
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

gaudio_open_snd_dev() opens the ALSA control device file first, then
opens the PCM playback device. On two error paths the control file
handle is leaked:

When filp_open() for the playback device fails, the function returns
immediately without closing the already-opened control file handle.

When playback_default_hw_params() fails, its return value was ignored
and both the playback and control file handles were leaked.

Both leaks result in gaudio_cleanup() calling filp_close() on already
freed file objects, causing a use-after-free.

Fix by closing previously opened file handles before returning on
each error path, and by checking the return value of
playback_default_hw_params().

Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1 implementation legacy")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/gadget/function/u_uac1_legacy.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_uac1_legacy.c b/drivers/usb/gadget/function/u_uac1_legacy.c
index 01016102fa17..5bcd3afd6366 100644
--- a/drivers/usb/gadget/function/u_uac1_legacy.c
+++ b/drivers/usb/gadget/function/u_uac1_legacy.c
@@ -226,12 +226,20 @@ static int gaudio_open_snd_dev(struct gaudio *card)
 
 		ERROR(card, "No such PCM playback device: %s\n", fn_play);
 		snd->filp = NULL;
+		filp_close(card->control.filp, NULL);
+		card->control.filp = NULL;
 		return ret;
 	}
 	pcm_file = snd->filp->private_data;
 	snd->substream = pcm_file->substream;
 	snd->card = card;
-	playback_default_hw_params(snd);
+	if (playback_default_hw_params(snd) < 0) {
+		filp_close(snd->filp, NULL);
+		snd->filp = NULL;
+		filp_close(card->control.filp, NULL);
+		card->control.filp = NULL;
+		return -EINVAL;
+	}
 
 	/* Open PCM capture device and setup substream */
 	snd = &card->capture;
-- 
2.43.0


