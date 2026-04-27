Return-Path: <stable+bounces-241361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGvbARGE72kMCAEAu9opvQ
	(envelope-from <stable+bounces-241361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:43:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2574756A1
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60B26301D386
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A3351C3C;
	Mon, 27 Apr 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV5nh9+a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F7340A43
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304225; cv=none; b=iGfl8XqzareXp7c3LwLL28VLfXrEW7ISmrLBH/7u56IqZ7ZjW5y+WQ5/QDkYl4ya+tT0oBNyye4i1S1Nhh88YeZTGCpH9jZV0RMTtWWKcX+M14J5a7ILR5sdtncVYsJXtIM59cgk2lPJCvfEMkgyx0LQrp1USxQD2qRZqhfTcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304225; c=relaxed/simple;
	bh=k2eHeOh1ypEyik00unMmMsD3cRYTWKvd5TA7e2KeNHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2JDUIiNeLTyygVrBCyWdq4vUlgxXqqqW1f5VNbBlAu19JnRuUmlYg/ZsljU2kb19N/0/aSBAyYWrLrIoEMzhqbWADGRXzgFQqfSpfcL6j1YXW3oDOQnl2EfEh5WojLDdtP+MZONNydjV/L7UOx/W6V3cnSn8O3JIHAK7niKaX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV5nh9+a; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d90833cacso6470273a91.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777304223; x=1777909023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0hpvNH1EUa3cOnUyhzEEF6VXuaHHXz+8JvdcA+bX2rM=;
        b=lV5nh9+aI7CTiI2BJitPX84JGqexpETdo34LW164BUweNX9rd00KscHIfEPpIEnwwn
         lUuokwwr0ONpxQP5V+0AwLn+DO3co9hmmyLtfTko06c4RGrOqfN7rskZOoQMoSBQ7Gis
         EWcWrK4w5loTbuI/yFT0uhrzuFw2dvs6WiNdTwwUiopbMRsfwgszV6V8Zh1WMRRJK2FJ
         +0SO5T7vpd2CD3tGSXZeAe0umhbELe9BnN9XRFZPWSxsf4jb5sZxZvfYPs5x/4cS6Syv
         xS6My8cYM1e9B6GFpEa+tvIQIWzth2TXX9D3A2PsEPFREp7J1igWEcigN4mvgrx+TOLR
         R6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304223; x=1777909023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hpvNH1EUa3cOnUyhzEEF6VXuaHHXz+8JvdcA+bX2rM=;
        b=WvPZ3MaPLP00ZIk2qK8edwiPxbTvWVplzVBW0lHyepz2wznU/1RYKlo69wUlOjyXs4
         PMYfp1UcjScqT/u3L9R8/LtFEISA+Fu45vpNB1N/B/nwtHJlvEG1H9gTf3+KDsBSpYvg
         aEmFpiZw150YqOmzxkKvepcrsM84KS81KnBCm7+39X0pAOfsgjpaTiCSWKF4E1uvb6Iz
         xoxhftNwnmA+mqSMsPssoGQ9xU4m9ya88QewV4tS54AFi2/2Jg1WfsGhtF4gwPxgEDHK
         9jKvv83Ikw2jbnzLfqITDHlibEHWrpLkCmCokcgcixdxjCOj5v+CJXaJ0ka6/Oqoi9cF
         SeKg==
X-Gm-Message-State: AOJu0Yy/m2IOvLgBxpRCv5+zkUIDDUFzlArZvIKWpuDRV9/TEzpcb7qs
	xlbzKb7/yWz1NzMMJaa+7hbQzrGPMdS7rQR/IKAC+bKu7SPvdob4rhyP
X-Gm-Gg: AeBDiev+qWfmqSyyze2NnuWdQBKuKmE5N0wtx5Gxg43YrHsB/hY/XxBwwNNIcelXE7t
	ctXHLXYou/Dedtp5MGykbKe4me/Bb279fl0zPiKVLxbUBj3cvv5+6lBhAkKP7uI3ep2Cm98eEBx
	Lzbnc3yD9rodNObnWVV48xK9f9mzJb6vBzlkb9itUMsrqgN3MWS7C99kgSdzegNvpTOe4JhVbRR
	NjRkwypFhmil6kwnB5zmUMczFWj/d0EfE3n1vvEzUyntiTkPqMBlKbrIxyiS12wx6TAGtZY/t9p
	9qy1EEvKS8xm75jq/tk845Dao0ugqtp2p53g6hO+tM/NPKOe0ZqIUssyQkiWntGJFDNLR/bHkOE
	I1n9qEPug0wkLrBzRGMr1HodbRGOehOOTt/7adasK/VReF/GgPUngCV0ESu+wJ54vVqOoj8um+D
	kgy6zHPQtg3umGYjPcegG6HERMeGm2SwsV+1M=
X-Received: by 2002:a17:90a:f09:b0:361:4521:d311 with SMTP id 98e67ed59e1d1-362e8d70725mr10652817a91.18.1777304223057;
        Mon, 27 Apr 2026 08:37:03 -0700 (PDT)
Received: from lgs.. ([2408:8418:1110:2369:e656:cc2d:236e:9079])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36146ae9cd8sm30014315a91.11.2026.04.27.08.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:37:02 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Chen Ni <nichen@iscas.ac.cn>,
	Alan Stern <stern@rowland.harvard.edu>,
	Felipe Balbi <balbi@kernel.org>,
	Peter Chen <peter.chen@nxp.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: net2280: Fix double free in probe error path
Date: Mon, 27 Apr 2026 23:36:51 +0800
Message-ID: <20260427153651.337846-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B2574756A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-241361-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com,kernel.org,iscas.ac.cn,rowland.harvard.edu,nxp.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

usb_initialize_gadget() installs gadget_release() as the release
callback for the embedded gadget device.  The struct net2280 instance is
therefore released through gadget_release() when the gadget device's last
reference is dropped.

The probe error path calls net2280_remove(), which tears down the
partially initialized device and drops the gadget reference with
usb_put_gadget().  Calling kfree(dev) afterwards can free the same object
again.

Drop the explicit kfree() and let the gadget device release callback
handle the final free.  This issue was found by a static analysis tool
I am developing.

Fixes: f770fbec4165 ("USB: UDC: net2280: Fix memory leaks")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Remove the unnecessary braces around the single-statement if block.
  - Correct the Fixes tag to f770fbec4165.

 drivers/usb/gadget/udc/net2280.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index d02765bd49ce..7c5f30cfd24d 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -3790,10 +3790,8 @@ static int net2280_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 done:
-	if (dev) {
+	if (dev)
 		net2280_remove(pdev);
-		kfree(dev);
-	}
 	return retval;
 }
 
-- 
2.43.0


