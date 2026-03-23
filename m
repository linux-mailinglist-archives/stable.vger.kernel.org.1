Return-Path: <stable+bounces-229978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJbkKwp+wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:53:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2062FA8C4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B324B301EF80
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E270A3C0622;
	Mon, 23 Mar 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6gMHxuI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57C3BF678
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285071; cv=none; b=qK7VApU1SsQ7f8ZOKRF5RwQAy1+5f3qfw+HtqJOBejmgWaS34Un8pSNKiotAs6UOLFT6FMqTchZU+Ib8p7eGBiNxX0IxeHHzcV7Q/GdQjHY2yE/tYF7WTFAUG+N/j5S6Fc+AnpEXIO0h7eaYNFbN1pQcJ94w86M6nm6IW9qZRio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285071; c=relaxed/simple;
	bh=HaKS3N/t/8+2h/Pc8TJ2Vb22p+n4if8KpkCVDIHQAXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4kz4qsGnrkXuEQdAQ7JT/+EEFB6omYLMKLi6LP9H1NbwA4PznG165S/1ECTcfQC2sujZlSq+EdJD5hsqYiQJQTe7tjU7K1bJzg76qvsq9tyR+VlYNhPhk0KKRUprs+7C3iFzgWqFw5K79mEl1jszHWHrGaD1BQij1KcZpE90b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6gMHxuI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-358ed696623so1437770a91.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774285070; x=1774889870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZEofwQC58MPpqn9prf+xK4zUFx1LJf9Y6fgKZotzZc=;
        b=W6gMHxuINpmkk1y+5VslwAOuEjlg+NwOK1UUVjsCllKPuEMXqzhUzVruKjme8dM2Yo
         rFgEl2mCNsCHA2Uu0Dvi61vuKaxQvI9GPgWi8LuCBIAZMcYlkHOdZPuSGXVlUkX3xgjp
         7qAwF0/jUACCQ98tU/HRb0UFLOtLxCIWg4M/0Ucxw5IqrJtXpniZB+fT/Ja/SssbIGRB
         b5RZF6Cay1HyKNELdvYQfR40MWxHwKzSAojPTAla6XvZBL0a3Ob7HFMJ0nRE688UF8T/
         s6uLlt8ccaK4fvxjGxBpRkcs2ILreI6mzv34nBNMNMUxKy7dATRVq2w8MsZsxr3f4gp0
         ShdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285070; x=1774889870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZEofwQC58MPpqn9prf+xK4zUFx1LJf9Y6fgKZotzZc=;
        b=sT6Y7XMFxZhoaWG+i9fr/df/BBEY6e09IY8d3y37qloo3WRTXmLrl34zfI6Mgaq1aK
         6hFvZIEPEG1sChYvY2jg5UkVg/mcxV4mDXJBQyMCAlEr8fPVfkjaWSdp7IfSSctNtjzp
         SGY3u4cWiRV7+aiRXOCyZrOC8kLyuPAXrHbrXlWL7Me3Rkzg4lXaTge8XSR3mKHnLttR
         /WVZTC6Z9Krs5bmSFcqUyKijxqm6Cxq8NJGpL7vWFKU7UUpi6U78Au/tD6+Wig0pSa0T
         mKj8ThCGpwc8kwlBjtssx1VPfPjwYYpXy9fFBkcB7hKLgluHYi394cixBTvwRm86ALfN
         P4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWWbIJ4UCq/k9f7osXzAMM/n9tYz7mgD5RiPJn6i7TecqdIP7pWb797FAosH/T30LqGbHrP698=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PDh2oDIBfhNTIPeWWKjomfc88CINnwJzslweUWkqYCeCl5jR
	92Mv9BeDFkdIKjit8BdKYQEFgm9rsaTvMr8wtu7Lesn3mgcybpc/YY7t
X-Gm-Gg: ATEYQzwf/b+GNSUd4BXEDcTyT1O/ZiR1l6GKCXI/nEgePxGtXw2xbgFnivHztIuKeRt
	gUjpDWkxId69fV+bwu9RX9euqgXdSfffZ0+6+xKvuSNBXCO3/plP7rdBj2jBXufEEL+GOIsY3Ao
	3CEqyc0uuFtzoIcZERlBJVK1sPvKaA+yLbIX9IrZT84F/mNlw/Q5DtqN5Jcl5iknw5i0lrhSFVx
	bUEcbKyIiTWYUjBhdft41ngdVOD7I0K3T5z7duu5HktNTbjkN8iK556vXy8/YByZ282LJ4gkSU7
	6jIt3eZaIZo59A3lL6CnfNY9dBqRlvJP3G5m4L+hhXUDa61bxV614+hLbJEPRFp3cunBaFJg8az
	f1EYlwNtdtS6/v78RmdeLl9cNmOO9PwGmsfMnq1brpFuQ1dg4yLkru4k4o2I80XrisW7qBZR/nP
	Q/zATd6VfycbnqIRE=
X-Received: by 2002:a17:90b:4a50:b0:359:fc88:fa99 with SMTP id 98e67ed59e1d1-35bd2d39c11mr10734530a91.26.1774285069752;
        Mon, 23 Mar 2026 09:57:49 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd4109c3bsm10185767a91.13.2026.03.23.09.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:57:49 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PPATCH net v3] net: mana: fix use-after-free in add_adev() error path
Date: Tue, 24 Mar 2026 00:57:30 +0800
Message-ID: <20260323165730.945365-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-229978-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA2062FA8C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If auxiliary_device_add() fails, add_adev() jumps to add_fail and calls
auxiliary_device_uninit(adev).

The auxiliary device has its release callback set to adev_release(),
which frees the containing struct mana_adev. Since adev is embedded in
struct mana_adev, the subsequent fall-through to init_fail and access
to adev->id may result in a use-after-free.

Fix this by saving the allocated auxiliary device id in a local
variable before calling auxiliary_device_add(), and use that saved id
in the cleanup path after auxiliary_device_uninit().

Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
Cc: stable@vger.kernel.org
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - explain the UAF in more detail
  - retarget to net
  - preserve reverse xmas tree order for local variables

v3:
  - rebase onto the current net tree

 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9017e806ecda..d03f42245ab8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3424,6 +3424,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 {
 	struct auxiliary_device *adev;
 	struct mana_adev *madev;
+	int id;
 	int ret;
 
 	madev = kzalloc_obj(*madev);
@@ -3434,7 +3435,8 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	ret = mana_adev_idx_alloc();
 	if (ret < 0)
 		goto idx_fail;
-	adev->id = ret;
+	id = ret;
+	adev->id = id;
 
 	adev->name = name;
 	adev->dev.parent = gd->gdma_context->dev;
@@ -3460,7 +3462,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	auxiliary_device_uninit(adev);
 
 init_fail:
-	mana_adev_idx_free(adev->id);
+	mana_adev_idx_free(id);
 
 idx_fail:
 	kfree(madev);
-- 
2.43.0


