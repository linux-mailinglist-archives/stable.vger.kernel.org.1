Return-Path: <stable+bounces-240985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J4WOr6A62lLNgAAu9opvQ
	(envelope-from <stable+bounces-240985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:39:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D03A460504
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 598FD306C377
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C103DD520;
	Fri, 24 Apr 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkYEtM2a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2714AD20
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041374; cv=none; b=iLucXOP2gGygo2FaiTMhtKel9XIx36ctwxbRFxFgTVwY0W4o37qIjhqu7muPyLOdQtVu5PPABiQmCjmVj/psbulzUdMqFe1OUZ4wV82XjM3jHFzPYkBalOSApjh+f9W6ZmHbZ9vk9lxgzEFIwbc+c6KX/GoQFRt5YKOkakeHVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041374; c=relaxed/simple;
	bh=qmCZG3NsgyNnx//Q3I0cBUENxgZbXGkZyQVfNZJYt74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qbeatc6JUY+Gy1SXsJyd5vGliP0uyeZzFiLpaRsEwjiFISqBKuvUNvub/FScrnD2mF8a9Q9YAtNPE+Xb3JsZXUnkSMwrZdKZsojnbfbrRZzwUvYnNJuZorkjkdpyB/k8bzmENFMIYyyWWsBpDn2AylOyRV2nOBZu3p40jD9HFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkYEtM2a; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-827270d50d4so7289150b3a.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777041373; x=1777646173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiYSxmjQt4BB8G17wfMVpfBYmyS+agHfH0aiwr6Qa6U=;
        b=MkYEtM2a7gBK98Dj4C2Ll/4viZRU0UwZPO+3sc95EqY/8zE6cUrPDrec0oyb9eE6Ns
         M9cw+MWGy0xbtZxmgCJaVswojnnX8dOotv3NDEqNrNjKGTkrtRRWG7JZf/xCy55p7am0
         8grjR6x06Blt8f6Q/zZ892nD07EuIlZHRObGQRYww2KIUHbnSHxCB5/sPNbmocUfSgqz
         kQkoFJ/II9vP5/cyXNY2kNT5CPfgMI0q26Vji9P58gRTYcnPMp6HlU6emUi40eUMHWp4
         YuycsCRof3TH5PZzTrbVDSatS1WfbRajST7iGdIJm0MV1iMt9eucbUz7JDI3ZaacAl1Z
         8TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777041373; x=1777646173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiYSxmjQt4BB8G17wfMVpfBYmyS+agHfH0aiwr6Qa6U=;
        b=EOEkjKcgBfdMfd7OIdizs4zBCeujUUuJLe6aueyZP5KkGblLQkhuU5EZwqyPlDnzYm
         0C0VArL2Bq0WEOvCyqJGPzvMo9KYGJdhiyM4EH5uzNiOoHBU55ZCHbONoVG4wC0egdkx
         5aBSJMVJXWDVW2e7W4YKbGRFriwShjLajQ9QMl4ygfcj2gQIeuh3p2R+xBlGFtWKUGPw
         8XyB+J4VLPoe+RdfOVSFqy5AxYqmDGTWrd+xusCxZUgedlbx/utA/RM8aShmNRkCbaiS
         AQgLN0nmRRod1U/hx91GZajHt5Wg1tkLHFChfBhimzopati1LkYpLC2OdzYHqor506gg
         ajAw==
X-Forwarded-Encrypted: i=1; AFNElJ+e6G62zPvD+05VM07BovBmQa49rs+A0RKw/3KYlKu4RajJZ8r0TZzhgHGHmhY/ju0Aw9cv1qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLBE/weUqllqlUZnukdf2sTQ8h0L1rL/py2Y40YK8o1mJgag0
	H34MhYaY63FkRooH8xmvoP1je+UAZRT7SjgCtlr+Sh/F2+uh6GHrvKU=
X-Gm-Gg: AeBDieunfFrkozRzQWCg7UoYgu7DvVipdQh8WmMuFpQxvT4wbzf0RAs1s380+F6MhK+
	emmYYSUBV9mTGlx9snVbrkrSTmdxkJX47UAQpL4SfJ0vr1jBPWiuATtQBiK1tftDWEb+VvEMXxi
	qC7eaqwi8mzjPogdlZ4aSzbj2NyZ4bKCwx88BVxLVkaJ9PGoSMFCe3OFIFuJ0t5RJXalwTJL9Is
	Y8zl6Q5Tue2BTcV0x3G/s2r4YIu48LsNFkMkYRicssQtEbzOFPmUhyJSPrp/Qqc1y6c/PWadYAd
	ci6SD3Xf+zztBPiDmdbEDsfWglghnytFcWfTUi+hdISjMeyXfcqyXpyCUfJ+g+pWvh7xuxM2L0u
	Nfuuh8oaqjrGvMJHBPEt/zNasSJ1+Qy4a2KcHTnO2+AyuWTQRpB+Sss9CPoiQEIhfIiqz0GcD9l
	MKV3herGnbtyvPalurGmnaAkxHy1VgTfbYs6XdGPxcXqWZsHWocaDzirO+aqkeqau5br0UEZA8J
	07JyK0hrw==
X-Received: by 2002:a05:6a00:4fcc:b0:82f:5034:77a4 with SMTP id d2e1a72fcca58-82f8c8409b4mr34482294b3a.21.1777041372626;
        Fri, 24 Apr 2026 07:36:12 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d35acsm24448401b3a.15.2026.04.24.07.36.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 07:36:12 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ettore Chimenti <ek5.chimenti@gmail.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-media@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: cec: seco: unregister adapter on IR probe failure
Date: Fri, 24 Apr 2026 23:36:01 +0900
Message-ID: <20260424143607.60807-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D03A460504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240985-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

If secocec_ir_probe() fails after cec_register_adapter() succeeds,
probe returns an error and the driver remove callback is not called.
The current unwind path unregisters the notifier and then falls through
to cec_delete_adapter(), which violates the CEC adapter lifetime rules
after a successful registration.

Add a registered-adapter unwind path that unregisters the notifier and
the adapter instead.

Fixes: daef95769b3a ("media: seco-cec: add Consumer-IR support")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/cec/platform/seco/seco-cec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/cec/platform/seco/seco-cec.c b/drivers/media/cec/platform/seco/seco-cec.c
index b7bb49f023..97ed9654c7 100644
--- a/drivers/media/cec/platform/seco/seco-cec.c
+++ b/drivers/media/cec/platform/seco/seco-cec.c
@@ -649,7 +649,7 @@ static int secocec_probe(struct platform_device *pdev)
 
 	ret = secocec_ir_probe(secocec);
 	if (ret)
-		goto err_notifier;
+		goto err_unregister_adapter;
 
 	platform_set_drvdata(pdev, secocec);
 
@@ -657,6 +657,10 @@ static int secocec_probe(struct platform_device *pdev)
 
 	return ret;
 
+err_unregister_adapter:
+	cec_notifier_cec_adap_unregister(secocec->notifier, secocec->cec_adap);
+	cec_unregister_adapter(secocec->cec_adap);
+	goto err;
 err_notifier:
 	cec_notifier_cec_adap_unregister(secocec->notifier, secocec->cec_adap);
 err_delete_adapter:

