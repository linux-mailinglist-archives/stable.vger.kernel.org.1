Return-Path: <stable+bounces-235708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDseNo8g2mnEyggAu9opvQ
	(envelope-from <stable+bounces-235708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:21:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7463DF4B6
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 868E2302CD39
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7674033A6EB;
	Sat, 11 Apr 2026 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpAY4gLg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B925524C
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775902851; cv=none; b=AqyBi+TLkPbulM/N+fLDh69i+k343F9M2Ws8n/BfEKcxcyVW1b19FoKXHA8UKxTt9W1WHnshjCK7M4V9+WruVYGqKUIaUzlFAoBgyIbca1HHL037lawkFXHaKuXWFdpvM2i9/d+l7bksPfDsQW3uHnDS/UU+kvqcqAa9nd0bjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775902851; c=relaxed/simple;
	bh=ZmRm9kdYBDk7rz8ZbtmocwkWC5GPoFQcrzLsFOXz88I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKYzFBWJCOlLlOD1pAn4qi9WcjW0q4IVF9kSj20P0JjqTRGCfr6KU+VuI9/1XtlwmCGKVyqkji+URGQ2cLetYd0xF16mX/QDig4N/pTj66V3+YOIR3iOkltwnZUFTPogxdhjOaIJOMDu+43AdPrPAULr66aL9P8/kvglL8pQAC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpAY4gLg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so20189035e9.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775902848; x=1776507648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMe81/am5TvWiY3wr2sfayvId1Z3wpJTYL6BB0Qd3QA=;
        b=TpAY4gLgVsq+M00CdViaKjjpIzHJPtogr/Tgux03wC0ll6RpaA5gwtjWaUpKfCqRGJ
         U/1aLT7iSgDcajfMytHkc/hzwHeiO5gPdmX//WPpRXgnmR+1BJxob3dxZ4SFB7Gw91xa
         TR9ayG+Tkop1vhwvtEaFbw+F/XuvoheuRniktUQoRdsyNwmPXNikgx72WSRW+5faMOst
         UC0o5yX29p2XaKe54Z+BO5T8QPR7N0RCrshSQjLDxqPlq3w129OsfFFRg/FkhP//cm3K
         bZdhd6Xvga9lLyJxgrm+nnXBZJda/lo3zX5RFnawzMDo0/SDDAFdZgb4L80jorpphDl/
         Zp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775902848; x=1776507648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LMe81/am5TvWiY3wr2sfayvId1Z3wpJTYL6BB0Qd3QA=;
        b=eKqaMQ27gYt3zZJzmgv76d4TLIX1xdhpG/Q6IRquNgj2plNSEpDLp69WqxJutk3z7S
         lEnC9dRScV0hKmeALCHtVuBJPfAFPMBTFJ6SQkrGyS0apOFev4VjvpyYoayy7vJMVlo5
         04GSIEYQ+y1irm0DIL5IIae32MFug5sRarxiVLjrI/CgJSC/eSbk030l+et3i/8YDVnL
         h8FFTWxH3BssqcOT00XOw88UB2/w7AzzKB72ASg9UxBGaLBLymiWEQBrRAo/lkK1Z3hE
         xOzAW/TEr8rqCNbK2m+5EksDFKvvhQvC19Flp1yrA4xQHTeWMv58PB11X3iS7ARlrIiL
         tQbg==
X-Gm-Message-State: AOJu0YwA1gum3ZRdD20QL8uaTGzUxVI0N3esZKT+kfBe8P+ds3vwcpda
	ZYNHtOEAx7Vz38ooTvjPMfoJlohfz/g1pBBMHd9r/BdBwNPxhUm9imp7
X-Gm-Gg: AeBDietjRUB8ihh8d742uY+5iky8KyhNW8xwHwdvzYCR/I8Mkf6MJNbE9iUWx7CxcN6
	SQavLICKyOEMaJwbe+iBcvQi1r8ookIrLSjeQ1JTT1fxXzTTc4dScX5jP0ysj8WUH46/Pmyb5/m
	m5Ak6e4b3CbF9jL03sqIoFzbJa7O8N+zxjE8D04tuMqAlU/E45qpdKsrvdhMOXeY1JwxZR+bj19
	2XODRvhYIqIfukjTLWYR4psAEdGTSlNFnzQUs+IJNvsYO9WodMcDiHCV+b8QBH4eJfOWih/izpv
	pOwmaFwIn93prLurEIKh8/ZZLe1RtPONttl1Vy4lSAfeeErcsTlEkPUFaT72R4b8Kgs/tJsXvvI
	egoMlBaTy3UwYP+BT/5OEAXt/Yu2RWDqGjEtiMgaoW4wCEgVXkT1FujAGH2xCTLiG/EDJmpUI2m
	o87OIqaJgZI9wqMNN+XeW+6FKRQo4MpGqZXQMW65s=
X-Received: by 2002:a05:600c:8907:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-488d6ac1bafmr53484555e9.27.1775902848377;
        Sat, 11 Apr 2026 03:20:48 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681ec15sm41856945e9.20.2026.04.11.03.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 03:20:48 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 2/2] gpib: Fix inappropriate ioctl error return
Date: Sat, 11 Apr 2026 12:20:25 +0200
Message-ID: <20260411102025.2000-3-dpenkler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411102025.2000-1-dpenkler@gmail.com>
References: <20260411102025.2000-1-dpenkler@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235708-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpenkler@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D7463DF4B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver was returning -ENOTTY in the case the ioctl command
was not recognised. Change it to -EBADRQC.

Fixes: 9dde4559e939 ("staging: gpib: Add GPIB common core driver")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/gpib/common/gpib_os.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpib/common/gpib_os.c b/drivers/gpib/common/gpib_os.c
index fca181b8c749..aafc4439b2fa 100644
--- a/drivers/gpib/common/gpib_os.c
+++ b/drivers/gpib/common/gpib_os.c
@@ -606,7 +606,7 @@ long ibioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	unsigned int minor = iminor(file_inode(filep));
 	struct gpib_board *board;
 	struct gpib_file_private *file_priv = filep->private_data;
-	long retval = -ENOTTY;
+	long retval = -EBADRQC;
 
 	if (minor >= GPIB_MAX_NUM_BOARDS) {
 		pr_err("gpib: invalid minor number of device file\n");
@@ -799,7 +799,6 @@ long ibioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		mutex_unlock(&board->big_gpib_mutex);
 		return write_ioctl(file_priv, board, arg);
 	default:
-		retval = -ENOTTY;
 		goto done;
 	}
 
-- 
2.53.0


