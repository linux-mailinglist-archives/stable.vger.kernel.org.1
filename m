Return-Path: <stable+bounces-256436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOM7ITrKGGrcnQgAu9opvQ
	(envelope-from <stable+bounces-256436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:05:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AAE5FB2D0
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0076C301CFE1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD9133BBD0;
	Thu, 28 May 2026 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbeXmoEK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57DA1AF4E9
	for <stable@vger.kernel.org>; Thu, 28 May 2026 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009527; cv=none; b=O1x12sd+BAHiRr7cvq0oMN1L5VF52AAQPyZ/d+uTC6g0KMNfNH1vFMekrLIZT8iQO0WFkZFPvY8ogb27zdZii7DFdl3ve4kyZnTsu3RL+4HKEoKbQ6LVpfr60QTpjAKtXHqytev0kpdLKB+zTbfjiRJ8O+QZOhZcXxZVglXxSr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009527; c=relaxed/simple;
	bh=FThXBuMZQp8l6oss+V4cuLh46PxufVFHFzAn6yH6F2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKUGTs+j1GJqLqNvztJF/Vhpv7FYTto4ic9Sv+O6uidgeQoqzSm8Q/o4Qr/iXCHM5tR90NTVZpFwMikMkuOnjyRBUlGX2NAtCpMHPKvRouw23hbS1itTkyeCQI09bTBlVRGwtUteY9m8/B2knwJ9rJQfoKKOo4BjPMhYSlC1VRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbeXmoEK; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6563f83ae9fso12968213d50.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 16:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780009526; x=1780614326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOlQJ1NgwFkmwieEj91ogwoRE1brqm+EKk5o69Mvzzo=;
        b=pbeXmoEKv79Q50ybJrNgAORsI4Xhraer+zpdBxTmsAK2U66CfkBP4NNaRpbWa+lUt6
         LafpqQw2sM9ub46cPoROykBaXvhyoNBDsmlNBw49wjanZks64Umjo4ZqdsOx4uIwmTYL
         JCEEAAHhmGUBSo63/McfrUjJML6FdpAh0kEmL+Yx7BcYz85OpC+7TYJdwp0mA9rCLmAb
         2Dqb/nZktSYfqC7dx51/gEikxX8jnp8L7mgOiJZTj0dRQUR8TfO3ElYm3c8m0EdgRx/+
         f2OeT41g5NCy3jf3vIzAdMR4Q1E7OaAuxJVzt1pSGHw5oOrhZK8xbZ4I711FSX/4lhSO
         67Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009526; x=1780614326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOlQJ1NgwFkmwieEj91ogwoRE1brqm+EKk5o69Mvzzo=;
        b=ev0DItyBgYZUDPr3tAa9ACW9oJ8VFM/h8QABmYNzSGiBvIITjKIohnoGeo8Rr0wuhn
         /TabXSqAT4b0bcuZAyJQVseMIweVAAju+ZKlYW9VLzXUe48ZSiGq6ieP1Hc/v5tMfnWG
         BppiZlJm3sxaC7PfYHD6VL/2N+lvTqsSiNk14MPLsJv4BjYuEwMeG/dcH6OdZ2LZxUiB
         WGHx4bG0Xvpim+FRqdlE/WCj21+RqgAvXgvmz5bsCmQ2kYewtmFIivt/LAKi8QMtgyLK
         blmQ8V7bRO60SfaDj5K0jrkjEFWTSLZoaFw/+cMoBFD/SwLMuApZmZ3lpFgoy+/+pAGF
         mrcA==
X-Forwarded-Encrypted: i=1; AFNElJ8Ke+mAmqqvCO9DtbEnCuaTlbVXi0p/TimZXZo4X+Wd+W+aliTdIcF7TFinyom223kLv2sehp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF5AV9Kk0lEjeIKnRTozVp7fytFov6oG16QCFP7ynaxKry5Yr5
	MjIOxUjW6isVX9aS7lmefjQ0eEqR3Ce2z4yj6+CZQDOJ3p4k9uf2lZhq
X-Gm-Gg: Acq92OH+oEqQZpImw6qX42eWDQ2k7OiN0+P49J4qBUehvKQ40QX8CKjjAX9R0i6DQhf
	fw3GuPu46OseSndvByu/xkOeMwNzl+fjs/HqO2Ez2UXV3hsREcFNQcaxxj5vufmyV3YBYIsWXOC
	YmiwRb37vyeG83Fs3JUGJ69pPV57Y60GMxSwjEpgYt+SNFoiYqSFwouMoyeQLlgAz+us8i+D/NZ
	vGV7oZUnUHVBEEtSDFp5xDJ22hKnhHrqY4nHzbpzhO/QFhI7dX+k2QhNoKFpR2afCXPoVjoeqYt
	GE/x1XeVsthZQMRtaj1szXzdpvGJdp8TgZXTbdFqTUHxwAH9I4pdBR3c0bLjNj2M2Yn2FHmOre1
	yiLcn8S1YGW9Dddlb59HS0ksk2oQgM7qNpKMAHt6695OBRnkZHqZAXMSu0bKcXCQZgqmgBlinlB
	pMB6kHYz8mZwr4ur2HkxO+3Q0KZICsU6/1Wcc6ICqrF9TJaSPfOZXIEKEqS6FxG6rr3Z7ULdmRk
	WEQAvabAKQyUQ==
X-Received: by 2002:a05:690e:1908:b0:65d:f5e7:72bc with SMTP id 956f58d0204a3-66052e33bc1mr114761d50.22.1780009525620;
        Thu, 28 May 2026 16:05:25 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6605362df73sm1535d50.3.2026.05.28.16.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 16:05:24 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] alpha: marvel: Fix irq_set_status_flags to use correct IRQ number
Date: Thu, 28 May 2026 19:05:15 -0400
Message-ID: <20260528230516.1839694-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linaro.org,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256436-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mattst88@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 05AAE5FB2D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pass base + i to irq_set_status_flags() to match the IRQ number
used in irq_set_chip_and_handler(). Previously, IRQ_LEVEL was set
on the wrong (low-numbered) IRQ descriptors rather than the IO7
IRQs at base + i.

Cc: stable@vger.kernel.org
Fixes: 08876fe8519c ("alpha: marvel: Convert irq_chip functions")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/sys_marvel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git ./arch/alpha/kernel/sys_marvel.c ./arch/alpha/kernel/sys_marvel.c
index 1f99b03effc2..bebeea3c286d 100644
--- ./arch/alpha/kernel/sys_marvel.c
+++ ./arch/alpha/kernel/sys_marvel.c
@@ -275,7 +275,7 @@ init_io7_irqs(struct io7 *io7,
 	/* Set up the lsi irqs.  */
 	for (i = 0; i < 128; ++i) {
 		irq_set_chip_and_handler(base + i, lsi_ops, handle_level_irq);
-		irq_set_status_flags(i, IRQ_LEVEL);
+		irq_set_status_flags(base + i, IRQ_LEVEL);
 	}
 
 	/* Disable the implemented irqs in hardware.  */
@@ -289,7 +289,7 @@ init_io7_irqs(struct io7 *io7,
 	/* Set up the msi irqs.  */
 	for (i = 128; i < (128 + 512); ++i) {
 		irq_set_chip_and_handler(base + i, msi_ops, handle_level_irq);
-		irq_set_status_flags(i, IRQ_LEVEL);
+		irq_set_status_flags(base + i, IRQ_LEVEL);
 	}
 
 	for (i = 0; i < 16; ++i)
-- 
2.53.0


