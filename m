Return-Path: <stable+bounces-248208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sANAFtZUB2pIygIAu9opvQ
	(envelope-from <stable+bounces-248208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:16:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2A5554B4D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6738831789C0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB57C3FD96F;
	Fri, 15 May 2026 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="hxXscrPb"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402BF3E7BC4
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861148; cv=none; b=Npj40vbxXjK4uGjRIcOf8yMhqrvK33ykGcTVEdcFNxtWDlRRAe2MV2ABmLacJw3nOWQVjsE2GGHpsOZZ+jyp11e6nPkAl/xVUV3TD/DmZKZdTtRaBRwR5NM7+3LSVU3902yLPD37nqmaAIdXDW3mY0zSuqthML3oTnxvhxhFE5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861148; c=relaxed/simple;
	bh=sFdj55WOeYNSM32Vx+1GHG9bjwb3ef94DQE+nruOOVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp3JG6qzspJToNR3UXr9oUIGL82lEXTWNq7NRNDrRPrmt2pF/aufORU5UL56Ez2i2ukFj/QvKpvGLLjECwvcKB9HTE3FGnWFw5hYGkQ/fTwxuCKctn6Lw+yD/fWOQyhaoWLX2/1u0ItQy90ogg3YijIuk5cGZ20pmkKboiFJiiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=hxXscrPb; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-47c7b282e21so3952448b6e.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 09:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778861146; x=1779465946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz9uxQaZJy3wzzqSIq97zJbBPUwMC8vJxGkYVJvy1wA=;
        b=hxXscrPbUI0raQDWZ5Yir0c1Rl8zPO+SGtGpw1AJ512FfTv125Z32BiqoQPw63sQ6r
         SLCMuCk8fe4xEyiJusQ7BQJCi8azw2PonyEJED9JQ50a/h0DezCB14poarwHPCY4zubH
         Mfc0ATzKn/0jE1PAaLPq7L3KaVkbEqncSDxJ/leczozcJyMP/rb3kZCPn2Fat7uo+oBM
         RqJ4zIE5KhltjjD8JSc5K7tTrL/HhOSmPl+Y8/ShoLojWHHdA2ZOqTMYwDWbk/LBJPfe
         npUn7O2CBqjC4t57sQ8MnDAMTq6z153yTkhOXgtTkh6sPLHgBWofogidVY5ne2gWTsSL
         Of2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861146; x=1779465946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bz9uxQaZJy3wzzqSIq97zJbBPUwMC8vJxGkYVJvy1wA=;
        b=kKupMbRt6KFLivpnoDgs7aIIJE9O9k2SQeZYJocXy6x4bAL6CPRbfLsFBixJJG9gVG
         1mZpPdvJkYZ76Yt+4saUQTHfxP7MOHNYHoo/qvrKt99X1/uZAt3lg+T2xgFdfsBSMxCD
         ZtvnHBSp+9KkRZ7oVop4f7oQlgVpmr+RKzUj6av2A1kc0n9qjAPcJ/XgQB1oMq0N7puR
         mf2OHcFamzZJtUEGeEId8KuVIo2ZaIGQrADLMJcbDstkXk4amQox20r6eDVyuFo4hVoA
         2jQyOVx3PT/6WaXJLX9t6wNyXRJ+qmpp5z7mq9aoovdt4jP/CYCQYoHE74XzTHEmyqML
         RqVQ==
X-Gm-Message-State: AOJu0Yxy8bRwnuM/E28jRKqXl0KotZVqARjKL+8SniykOc8ebCapFbGh
	Oos2pdT19dAgRF8XbI6FaBX6guC5QcvSopGhuTyAC42//z8gVQHH5dTjkAp7DmFhkJ6wdVntV7d
	DX57W
X-Gm-Gg: Acq92OEqNyVneyA/lFRCZeTG1R2fb3OOfEHR7MYkzHYs/vaDBWsnxR2gqvFQc5C8VH3
	m5V05UBOepJrJMOMqAHwl36fY+FAaLQz1IbMCw+BjeKnUMnE0/+Dj34itrTQMQiHH9rBwkI9k32
	/tOqXh5jUQushGUIHWR6QAtqO2BREYNwNhfpNAnitVhIwMpnD7joWHfnmFOcRnq6T7Mg7XbxEZh
	yazSkLX23opJIQPEDo/nmCPD5w2KgkuVjbCKL/q+iptM/uEWDw7k1ZPD7yf48KlPdC4Rz0ysDdh
	G3x7e/bR34vPNH+VyQMieDFPWAyYfvjzJAYZ1nJfFEPKLiNXu4NVmOUGnEZDcRMU117xOYYL5Tg
	ukrdBodj3pNE2oTYaFAiJaIeVo56QUzlNcdk9oL+SWF05ByM+9RZNeqDUHkzrUqJy/FB016Pfv2
	f6QD7cs+3Gp/TUCUqrNrKGkW51iOfCiu/GKMJSXy2/k476xJE8RWXBODfUFpPPi9kL8B/7fE6sN
	w49
X-Received: by 2002:a05:6808:6785:b0:47c:be93:9214 with SMTP id 5614622812f47-482e56c9a84mr3010201b6e.20.1778861146051;
        Fri, 15 May 2026 09:05:46 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:5de0:f9c5:a427:bb0])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-482ee389243sm1045948b6e.6.2026.05.15.09.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 09:05:44 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.6.y 2/2] ipmi:ssif: NULL thread on error
Date: Fri, 15 May 2026 11:04:21 -0500
Message-ID: <20260515160422.2057506-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515160422.2057506-1-corey@minyard.net>
References: <2026051540-path-mulled-0e19@gregkh>
 <20260515160422.2057506-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CB2A5554B4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248208-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,minyard.net:mid,minyard.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Cleanup code was checking the thread for NULL, but it was possibly
a PTR_ERR() in one spot.

Spotted with static analysis.

Link: https://sourceforge.net/p/openipmi/mailman/message/59324676/
Fixes: 75c486cb1bca ("ipmi:ssif: Clean up kthread on errors")
Cc: <stable@vger.kernel.org> # 91eb7ec72612: ipmi:ssif: Remove unnecessary indention
Cc: stable@vger.kernel.org
Signed-off-by: Corey Minyard <corey@minyard.net>
(cherry picked from commit a8aebe93a4938c0ca1941eeaae821738f869be3d)
---
 drivers/char/ipmi/ipmi_ssif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 6ded3e51ff8b..fcb20e9589db 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1866,6 +1866,7 @@ static int ssif_probe(struct i2c_client *client)
 					"kssif%4.4x", thread_num);
 	if (IS_ERR(ssif_info->thread)) {
 		rv = PTR_ERR(ssif_info->thread);
+		ssif_info->thread = NULL;
 		dev_notice(&ssif_info->client->dev,
 			   "Could not start kernel thread: error %d\n",
 			   rv);
-- 
2.43.0


