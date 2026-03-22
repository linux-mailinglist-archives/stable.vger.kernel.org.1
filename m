Return-Path: <stable+bounces-227849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEZQHM8jwGmgEAQAu9opvQ
	(envelope-from <stable+bounces-227849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 18:15:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B342EA252
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 18:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C0353014BC8
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651E936AB7C;
	Sun, 22 Mar 2026 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJsPnn7W"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ECC1B7F4
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774199741; cv=none; b=qILs4k2YGsyf2v8Wm6qMQwLyz+cgTnVQKVCCBY2zv4EEXBypVQ4ziq9Cxg2Czm1lb/AmrM7NBm2wWCfsYU1k1w9scmFpPc3yLF1dvuWWyV4ao7zKXIW+4IPJ6/lvbTFa58CR9X26mt3NJxuG9IYNN3leUohVk1yjiV1EB+s20J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774199741; c=relaxed/simple;
	bh=fFSlrcEVQawiYuoqQ6PivLQ+WfvKiPRgnAp5zV8TqjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEH61CKk4vPp2Ce2dTxMSrkSTe6Qy5Ctcv1gn8igl7y0JiZ/ELwPtN7EHHfxctc0UjsJ5/LHSgr8xvydfliQlbyErby8keYhYwxL6TRsZYJGDuR0YgkC9GrZ9l3FiuNCNhwQqZBe69lrHEfMmh6SWfxDBid+af6BzWKTaIOka4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJsPnn7W; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89cab686a9bso263786d6.2
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774199738; x=1774804538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0AJDTQx4Fo0qs6sgUSUPoNfGP6EMtKuFzwsXYq6U9jE=;
        b=TJsPnn7WQAjkzssR8hFid5FTCYu/IKbGqmRdliR/lxqPNmPCaMWedQZS7HEfvY1unA
         t7GcKuJAUcpo5+lMbfLKczzROQ32h6bgwyTTsa9GDEW00T7rK0Wk4Qe+wKpMCaXmlQXG
         9oIEKl+3mtK4ptkRBFMfLV5oWgymZ+UdSOYjn4z84iAqZvxvVvbIXnKVrjtYWz9rbVaG
         zthgC2tYdjsQljheoLXWXlj33/0WIHh05G50t3oIA5x5Frgt4TVZBrm3zsr1OTCSoCsP
         7XWkd7Jrr4zknpm857yzvtENg9sQuJftqm3vwrE7HdUf25xNemOmeX2ywxu6dKd8hv0E
         g/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774199738; x=1774804538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AJDTQx4Fo0qs6sgUSUPoNfGP6EMtKuFzwsXYq6U9jE=;
        b=pY2BXhOsfTGMUq/dP64JK/tQdDi+qLL1oIrcECXpXgaOGUaYbgiuuFLxXs50Q9D/tt
         152rZ1IcD+x+Zv4kDNnY7WwHHQKWHCRUjhCNCyPnRW+i5fjFmMaNkqZ4PieUW606Xlze
         X+GD/83+LpqaVZnmCifmE5dVaCoTjb88TvrmebQGSDT595ndb9u4skE1pc5tudeDi13r
         97q+DS1kWIAZYUPavqO9dWSKJxrbikbFEVV0rrEb0eTZIJ0UZbPLVwBSvGia00j1J6r5
         2TyPlizI2lEXUqg4q6CnFrArVwz0uwO8YHwoyZiN5A3fA/QaWhAWcefsnhh8wbIoOqk9
         hMkw==
X-Forwarded-Encrypted: i=1; AJvYcCUmKCMluS1X5ji9qSFLKq8gEoOhNtk5/Boki2c/cuhYFYipa4xki7lzq+142aNzTevnemtn0x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPGWctgogwAoK3AINJQWmuYfTA3FF3Rsy3H6WFz/p8Rs5XHGJ1
	UtZIoaWD5XCcxW2FVj2zmIZgzp6j8SYw9RhHoOn12QAiEFFZu60330UR
X-Gm-Gg: ATEYQzzUp4SQsFxD43F4qh7usfEgzBTV3oq9COjIO7LCt2LcHwx2Bd15IabHgZvZMMs
	j1+/yjJf7kdfirdpEAGdSkup6PRoQb8KGP7636JC12F+7XCXesiSgIEWRX2bo5bvaOMoHbciS//
	sDUJLjakazwGJe/VVeAxfHdLfBdJycM3HwotQFvnYYPHiRO+KYX/4LlY22Ll8SuZAHAwhspNAZo
	pkwzxRJufLGEheSR6nZByOMBds2sqXWaTQLHwfnC4mVWSDNnw/ghSmAhROxkI2TncpYTHHErJBS
	8P7FZ0+i8b2cXxrB+W6k8VJPLmo/6GwRN3gtBdPu82b9m9z4Hji8qCjCTQFZLHVsNbkmUynGDWL
	2rplmSkanT6S7YF+0HSpIOcnn0/JhM+S2LpqzWxZvWFhJKSIOv6yiWB2+iugIvnkmHwtKn6s2EE
	QYXVKHd/fJAaOaZr2LOdR4t+zoUebpnqbeldFVIVg/j4oQHRa9WyUbKokMaQxkcqLutxTwd0OFn
	yoc4YsT2WMcPw==
X-Received: by 2002:a05:6214:d87:b0:899:f1c1:dda8 with SMTP id 6a1803df08f44-89c859fa4damr166241696d6.13.1774199737628;
        Sun, 22 Mar 2026 10:15:37 -0700 (PDT)
Received: from Desktop-PC.. (wnpgmb0311w-ds01-161-217-39.dynamic.bellmts.net. [142.161.217.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85335464sm67001966d6.31.2026.03.22.10.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 10:15:36 -0700 (PDT)
From: jassisinghbrar@gmail.com
To: tglx@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: dianders@chromium.org,
	shawn.guo@linaro.org,
	maz@kernel.org,
	stable@vger.kernel.org,
	andersson@kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCHv2] irqchip/qcom-mpm: Fix missing mailbox TX done acknowledgment
Date: Sun, 22 Mar 2026 12:15:33 -0500
Message-ID: <20260322171533.608436-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[chromium.org,linaro.org,kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227849-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8B342EA252
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jassi Brar <jassisinghbrar@gmail.com>

The mbox_client for qcom-mpm sends NULL doorbell messages via
mbox_send_message() but never signals TX completion.
Set knows_txdone=true and call mbox_client_txdone() after a
successful send, matching the pattern used by other Qualcomm
mailbox clients (smp2p, smsm, qcom_aoss etc).

Fixes: a6199bb514d8a6 "irqchip: Add Qualcomm MPM controller driver"
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
---
 drivers/irqchip/irq-qcom-mpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index 83f31ea657b7..181320528a47 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -306,6 +306,8 @@ static int mpm_pd_power_off(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		return ret;
 
+	mbox_client_txdone(priv->mbox_chan, 0);
+
 	return 0;
 }
 
@@ -434,6 +436,7 @@ static int qcom_mpm_probe(struct platform_device *pdev, struct device_node *pare
 	}
 
 	priv->mbox_client.dev = dev;
+	priv->mbox_client.knows_txdone = true;
 	priv->mbox_chan = mbox_request_channel(&priv->mbox_client, 0);
 	if (IS_ERR(priv->mbox_chan)) {
 		ret = PTR_ERR(priv->mbox_chan);
-- 
2.43.0


