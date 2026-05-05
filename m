Return-Path: <stable+bounces-244000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JvNNNSb+Wkn+QIAu9opvQ
	(envelope-from <stable+bounces-244000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:27:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF604C7E59
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD334300B9E8
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 07:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA2B3DD505;
	Tue,  5 May 2026 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffdKtkUw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044523C6A2B
	for <stable@vger.kernel.org>; Tue,  5 May 2026 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966032; cv=none; b=rr3++AxtOXC3R20v1GBhFEFdDSRu9tXLrPMQhKO88Ovw7Ay4jtjvlFV+PazxEy51ihEvaqOYBgujZmgI7uv98fdB3qz6z8lTdfk6F/qwev6OELyJIPji5SdVmXzja8c2rwb0KtuWcZ7u9giz2STw2yaEy1Apip/fKTkcuAgeUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966032; c=relaxed/simple;
	bh=oJ7i70NzDzG1+8kPbDifF5QyLpTTn6bjo+g4ZqXwXK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5P/cQtc7sVvPfkmwx//StUpin6NCi3UV5aMznKmv3KchKMkVa2N51JzG+znYP9DocSAeViB+RSqMGXpdOcEEFZ+0aODI1VgOfNzYH9iJ72YdcdYfEaHnCukSj1cxuEMR4TABDiJQuvOAHzHTLCccYYyd/wFqM7qGnU8BA0PwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffdKtkUw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba60d78aff3so697400866b.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 00:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777966029; x=1778570829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SijCf9pu+RbvD42v9n4+DJLBOaLCuGVTkAjrLhC796g=;
        b=ffdKtkUwCz4o6a9WlWfJU/h+GHDVzOcfDpYY7LfWF2jIHMVDJR9u8rggrS7OlK0ulH
         aaIo6C7juFU/10Ormu1yJVqsXH+gfzGvQBj+cZ5kDoe0pWF2VtF8xyXEzx+43Lb41i+R
         TtxQXZDnZaVW4Ko5ou4d9UskZXFpNAlOUBrd8beM3eSQZZa9B1N8qK5hB+/8hBU8Om8N
         IX/G5uBPRM9mfIDaedgYse0gHF00+U6GV4QxKpv95dC8zb7Dbl+pPiv3sabdnXMt3IG7
         QjufVb3W2xT/aedgJJBhRFuAa33z0zboYVq62UHhjXwKQKtB98gTj16TwukrSiYTjKiN
         V2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777966029; x=1778570829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SijCf9pu+RbvD42v9n4+DJLBOaLCuGVTkAjrLhC796g=;
        b=rs9LF74ML6V0A3H86zqF4jtmSxlTjd59Ha9c7Cs0DU2DKIlrjV5u1aHBdXdmsngrED
         gA6jbbGOdIQETfpx+U996yv4VccZ0zWcyp320n05ZL/61AJ++cMCF15SRF/Uqh1k3jhW
         Tw96RMNn7VlcSbAg2O40EzG/zWVh1xgKbbP/pIUH0RBBip5kgeyhz5OwDDetlOEpUFAo
         u5nbBJeq/PNUCxzs5bizibxGoXy+SL/NrNi/Rffbr8fiL/xprgXxyyTW2y4Vh3GNIiPQ
         SG65KsHlyAd6UPFYZoFxWgpCC8O5qQwAczx4jVC2tu9GVJ9HTKcMsRJ+eLzG1GhmxyBM
         BlGw==
X-Forwarded-Encrypted: i=1; AFNElJ9orTQh0L6dfi1RtmDCyKQ9NNxeZZipYzUifTD/DpzcrdsbhITXQ9JPDOWeUYe0lxoy5KwVUN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMGQHX4EASXNKTWH9DBGKJTiKgnNUio8lxa2ehFOd7pzHx4xx1
	e0aVOPGegflzNZ+GDdGpDY+h7vmdBYEPJJb01yVk1h4kUnb6bwgJ7tnI
X-Gm-Gg: AeBDievxae812pHkxir6tRu5bUY1oQ+zQX4VeEyUjT3jtTxmqwf2YBCHNieXxvrnF1G
	jTLW9nta8DiwUXd5y/W8iLKfBlAENQOMMyOKAB6x98JH2oJhe4t1qvsbfs2xWe6hTvqD/fDItad
	miTeb3Gxegsxeej+tQN+JXNbxE9QDDX549redEimw1/XH1TPFAJkgqHf5/q1v1h4V1gs8HLpEnj
	x8Zm72YmO9j4rPCo45gxG+Za0IIyolz+B7lD73OTRIpLSg7UFZzClq9RFeu8aldpFdQJW2rWPfn
	eA8e/xo0VAs/c2Cfkz76xk4XguY4qpfC+vTnG9FbnTwa4YcDBhUx5DEuI0peAwerWdgzc8J+x2O
	E3faxRCbR+Se+Z2xBU88nV+LyVqanYwmTi2NExQ2CyCayd7Dq42Fzcw/eAN2krOo0eqtVJQKdA0
	igT4HogBSfhX9its5q7b622FNVcQF9fdjN
X-Received: by 2002:a17:906:f049:b0:b9d:94e4:d35e with SMTP id a640c23a62f3a-bc40fa2f89cmr93636566b.29.1777966028971;
        Tue, 05 May 2026 00:27:08 -0700 (PDT)
Received: from avt74j0.. ([2a02:8109:8617:d700:a1d:902c:85c8:d272])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc1dd343108sm208493166b.63.2026.05.05.00.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:27:08 -0700 (PDT)
From: Martin Hecht <mhecht73@gmail.com>
To: 
Cc: sakari.ailus@linux.intel.com,
	martin.hecht@avnet.eu,
	michael.roeder@avnet.eu,
	stable@vger.kernel.org,
	Martin Hecht <mhecht73@gmail.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: i2c: alvium: Fix: correct typo in alvium_set_ctrl_auto_exposure
Date: Tue,  5 May 2026 09:26:52 +0200
Message-ID: <20260505072658.1228578-1-mhecht73@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7BF604C7E59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,avnet.eu,vger.kernel.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-244000-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhecht73@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

write value for auto-exposure into register REG_BCRM_EXPOSURE_AUTO_RW
instead of wrong register REG_BCRM_WHITE_BALANCE_AUTO_RW.

Fixes: 0a7af872915e ("media: i2c: Add support for alvium camera")
Signed-off-by: Martin Hecht <mhecht73@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index 955b7072a560..b62b45a4f2fc 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1290,7 +1290,7 @@ static int alvium_set_ctrl_auto_exposure(struct alvium_dev *alvium, bool on)
 	struct device *dev = &alvium->i2c_client->dev;
 	int ret;
 
-	ret = alvium_write_hshake(alvium, REG_BCRM_WHITE_BALANCE_AUTO_RW,
+	ret = alvium_write_hshake(alvium, REG_BCRM_EXPOSURE_AUTO_RW,
 				  on ? 0x02 : 0x00);
 	if (ret) {
 		dev_err(dev, "Fail to set autoexposure reg\n");
-- 
2.43.0


