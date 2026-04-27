Return-Path: <stable+bounces-241331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPSVKApm72kIBAEAu9opvQ
	(envelope-from <stable+bounces-241331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:35:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14897473846
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 457F63047BC9
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066F73CCA1E;
	Mon, 27 Apr 2026 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kctUcvnO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3520E3C6608
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296686; cv=none; b=FOQheQmnGjbQMH9x1h3t8kbmF217Wvr1rTxWW1BI0bJoLSnOgnBKYEZ+PcZdLFAXZTM2GTXp75D8rDUVmpN++8Sgffwe7rR2suIIa4sok66kh1p4CNgauTXj6l/fIvg+iLKIjYsyrpBBlcYjgW3GdZ4zM8/M+J9L58Mhfj2Zsf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296686; c=relaxed/simple;
	bh=iC4+ZkY03M5gg8goq8d1wfEoqcLzW2wBz06MOjrRHdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DP3nKHgXicfSFF6xkfoE2OKMN1SGxXOjl6CYMe3FeFe4TwCiPPidrKz1OH0n8RoQmM0b1hLAsei66Ws//EoR4eCrNLuQl7syzhoJviVVcdsaVhg8cvehK//sYfSHN5TbxQFUXFzmybp6/tpwI+rfD0Miud7RaqqQ1iEK1cakxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kctUcvnO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d965648a2so9037876a91.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 06:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777296683; x=1777901483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ItUvJaUZi7auBuoRsMIotXuMOJtpxcTrtyLZSnWiKzo=;
        b=kctUcvnOCPZp7aI++oF2ayXJIbptkk0TShr/fWoxPBdXHKZn79HVtY8/dG3h44IiMH
         Yjp29r0sI9CgguawegfLkwUTy1OxPz1kUmW3p0ys22bauTWU3vxrNAGWmW/WpnykR39n
         Ld0BgG35N7rkiwpSAamcQre+zPhD2CBrNooTGJ0TdSw7iRbynpDM8Sy6biBI6a7pnNeC
         55aeo+rRbCTQfns/Ht1Ir4ktxHYg9HXirJYZQ/iryn0tLIApLmsO0s4npShetSNIs6+n
         5Rgd1v5RuAA+GliCwf9TPu9pl2vlXq7NsUvZU2a+ywJnBJd8R/QhKfYqf3WLeaAX4Lpj
         8rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777296683; x=1777901483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItUvJaUZi7auBuoRsMIotXuMOJtpxcTrtyLZSnWiKzo=;
        b=rNXKgLQlAyBwX0zCuWn8M1XJa1Mo3p4dZ0ej/6ELEqHduH2tS3HkKMPng7AJHgy/p3
         d1BXm/JLvZJj6gVbAvE8kkcDw+ZYU4WMf+AjoJOcXWcQfpK48N2U5RpIoY4WHYmWVeeS
         QWYFklg6i8pe//yzR0qD8KhbTs3eZt88xSgXSfolT+eWudHdZG3KtlCQwdLbNhYaXPPV
         L5zaUoJhHMipozPeLQR34rKYAiAtTA0qPx04JM1ohBMYNdxzg+Bx3DaKkVLLTRvx4BE1
         4+FocsGd6lLtujfAI4XuryC/2JuxcTLB+NFXjucYCT9/XfkmQOffCnQg/EwmqPS4BFi8
         diEg==
X-Gm-Message-State: AOJu0YzidD/TappBTYAAFi6IXclTb3EIAY1Sa2z+ippVTGgoDDc2iw5g
	UIdC8Zz5bLrG7RFKQCHHnFvcpzpBqFdb3Kfo/c/qdsmphOFBfZJahSql
X-Gm-Gg: AeBDiesa4kxKJ2n6w3JxZS1TUFpV1nhbghRoaYQ3gKyhkzNHcSBL5VkIO4kZs+ZlNHm
	adeuPKhlfB3V3MlI6EkKinhlV7cUWKALjyO69v0/mc2YGTDCM8LYiLUSILpYNIi2I/gTdbklMw0
	yjOP86+HaiPFizf0h9oR0gAOpo44QfPHoDUL+xIYdYTwSAsSZH5Ms+eZ4D7V3/bFiZ4mo3C8qQp
	5tsBAF5uetEhq5wzN6azdZoICNuiwtzxaD3zWo9mE0TJ2qQ981tW5vheSU5ZF9Ka5a53IKs21j3
	ipeW1BF0Jfv4tqKxN2mQjwCa+mcjj+kzQHSRaerTVJLLehDkE4+gZIE3IiG+QY5W01eRo/V6ITc
	JVO2BgEm5shJaCePPult6EYqy4Ze8yw1CI0tEy3hIGEr0XXR3TcpO1GRdoew9KXYkPQqpwJl6GC
	/fLld7lzNlgeL3yN+9wFMM5GU5yQrxWDdDC3U=
X-Received: by 2002:a17:90b:3f4d:b0:35d:8f3d:c554 with SMTP id 98e67ed59e1d1-36140468b12mr45769609a91.13.1777296683517;
        Mon, 27 Apr 2026 06:31:23 -0700 (PDT)
Received: from lgs.. ([2408:8418:1110:2369:396b:2f7b:1535:e7cf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1bc9sm11812298a91.10.2026.04.27.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:31:23 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Evgeny Novikov <novikov@ispras.ru>,
	Felipe Balbi <balbi@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] usb: gadget: net2280: Fix double free in probe error path
Date: Mon, 27 Apr 2026 21:31:07 +0800
Message-ID: <20260427133107.334429-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 14897473846
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-241331-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmail.com,iscas.ac.cn,ispras.ru,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

usb_initialize_gadget() installs gadget_release() as the release
callback for the embedded gadget device.  The struct net2280 instance is
therefore released through gadget_release() when the gadget device's last
reference is dropped.

The probe error path calls net2280_remove(), which tears down the
partially initialized device and drops the gadget reference with
usb_put_gadget().  Calling kfree(dev) afterwards can free the same object
again.

Drop the explicit kfree() and let the gadget device release callback
handle the final free. This issue was found by a static analysis tool
I am developing.

Fixes: 2468c877da42 ("usb: gadget: net2280: fix memory leak on probe error handling paths")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/usb/gadget/udc/net2280.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index d02765bd49ce..90d678e6714f 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -3792,7 +3792,6 @@ static int net2280_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 done:
 	if (dev) {
 		net2280_remove(pdev);
-		kfree(dev);
 	}
 	return retval;
 }
-- 
2.43.0


