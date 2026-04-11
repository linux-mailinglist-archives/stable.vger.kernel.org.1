Return-Path: <stable+bounces-235752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKjvH4uE2mnI3QgAu9opvQ
	(envelope-from <stable+bounces-235752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:27:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 195423E108C
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07E2D3070344
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 17:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D704223336;
	Sat, 11 Apr 2026 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS4TT3Uk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92D3B8BA5
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775928345; cv=none; b=Z8hxbmpWEHuKdxw30yKyKbeGZbxinAecNr9NHnnN91mhlXcThrF47dWu83YvaxO55CvXiBWseJPnZAX5Vl3RsGoAPjPcceDdUzxG1XnK0/VMvDeTAOE7/QJjksbhOrHZH7whcnJqpStkWp77yNM4xnSaT49voZvLOjRuYGa6Hyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775928345; c=relaxed/simple;
	bh=lZlp1JMVZTXR5hdKL2/OkTBeM3ZEyKP/FzTI6KBtSmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SitQuzZ4DU0r050QbGbR/ojdMvwIYeQsEXgvkct+3EH5DgG1CmWpdHxU0Yb6VZf20A+20Lc22eNK/KHIXKnTBZn/ixCAGuLGSRFaiA4pgBk/k9fnJbRFIGayl1tmoNWk3Mb47+8Zri3GY7E4YdASyso0c36lVOtO/b6HK9XB9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS4TT3Uk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48896199cbaso32931845e9.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775928339; x=1776533139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEyt4xEU8LCttHxyGWSxn1aqQc4skH+T73vHuVWVoQQ=;
        b=NS4TT3Uk+W6yV64I7oTEVwOklOq4oD+QbgVYvNZWIK6+00MKxTjEhEAmNtWSKr7pDq
         d9uIfIh7Dq7a0CrMOWNLxxZhQG5vBS1lBiDx3e8ahvg3FtICbpDOvq1/KJXYO0fZNwFW
         Wfe77WRd7Nzi0P+zWXYklTCQqtQAOObWtOIB4ry/vdxhhj1yIEsQPFI2m9cCuI9817Mz
         iuHnYqgwdYgDicdwDK+coetWEHbXHKaN88P7Eu3TNf818J9qGGdHYA3HLD8es5zQMFXt
         zyzjMeoIdNZZ54uxlzRYiZo09T8aVa88qGvh+mpZv5nEze/z7HxOWSlX75r/7PFDOcRE
         0J1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775928339; x=1776533139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GEyt4xEU8LCttHxyGWSxn1aqQc4skH+T73vHuVWVoQQ=;
        b=OZCuIQaOx6kqK8VJn65NE/Etww2BD5ZfzzjdGONIB2XHx72aDYVvmwthqlKa8sn+yc
         uyxh+EUsvYwF8ip1qNmdZYeemc/OghcIf0Tzt5yHNUU5DXazGPhxupjSSht3fXEzK0OM
         uchTw4vrHUV1WLcn5NE0Ri0Ceg0deK7GYE75141aqCIN18OpaKODZ0mo+L2HSqKtMVoc
         yQojssZ5lu0PsCqd8f0IFGN9TyxKnUqFNnycH2++F57dp+hJFCUrD8I2HBIRppyYaTm5
         p8Q2RHsDonn/lyYbrxSqXik7xav9y7gkQV0NgGe03Q1sHPD/gXGf43fFP4hVSsKVFUeZ
         U+sA==
X-Gm-Message-State: AOJu0Yxc9fcKDB5ciXDZJSJhcFHHwmNbJIXS+sRrLH/dKPFmv3YYf9zf
	00UBuuQnONULHG0sB1jBuYGNqi/eyhS1dmjLhGjCy3itoFu+UzxDjX1j
X-Gm-Gg: AeBDiev6IKUhOFZel/TofJ50tBAf/XPPtDh328V0j4k0yUTFr0BYhh9kwo69rI7RPSE
	uGjXCXEk2wg4QIclazavSsGKBTPMFZwaaZm6RvLm0wo8VSFT6XzGOzszSlBrAfBBBbBPCBn3CCD
	xhrk+WjzZ9qm+g/NyN2Lb0tos5CsS4U8ni0BI5xhI8DqB5tn+qjGU044649eK7KbtZxIE5i5ne7
	dXKaaCOIq7SSWlCxx2UfDTCp6je1fHpi19Lp6x5MPi1DKv6/MitImdrpRpwMY03pc93NUClPhS1
	8TcgwZ8jpFrDOoGBvfi81EItyX1O7d5R1funiH0AWqjHpYAofVcdMqBe03QYMkYvi4Mw2G8ICn8
	/FCWhoYelaa5Fg02HtwWEI7pyDeTX+ek0MvSiAjWzgcjWNV8JWtw4S+Vi2/SfVUluaIEmpKr1UA
	RxQdcm8AGUXF2bGhYJhxFnni+Sz5pU4rK+/AmnZRk=
X-Received: by 2002:a05:600c:64c4:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488d686c04fmr90195655e9.21.1775928339051;
        Sat, 11 Apr 2026 10:25:39 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4903sm64176515e9.5.2026.04.11.10.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 10:25:38 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 3/6] gpib: Don't use extended registers
Date: Sat, 11 Apr 2026 19:25:08 +0200
Message-ID: <20260411172511.26546-4-dpenkler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411172511.26546-1-dpenkler@gmail.com>
References: <20260411172511.26546-1-dpenkler@gmail.com>
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
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235752-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 195423E108C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the chip type is 72310 then avoid accessing extended registers
Apart from the BSR the 72310 supports only the standard NEC u7210
registers.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/gpib/ines/ines_gpib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpib/ines/ines_gpib.c b/drivers/gpib/ines/ines_gpib.c
index dd98cb261a4c..df299a9d7f4d 100644
--- a/drivers/gpib/ines/ines_gpib.c
+++ b/drivers/gpib/ines/ines_gpib.c
@@ -103,6 +103,9 @@ static int ines_t1_delay(struct gpib_board *board, unsigned int nano_sec)
 
 	retval = nec7210_t1_delay(board, nec_priv, nano_sec);
 
+	if (ines_priv->pci_chip_type == PCI_CHIP_INES_72130)
+		return retval;
+
 	if (nano_sec <= 250) {
 		write_byte(nec_priv, INES_AUXD | INES_FOLLOWING_T1_250ns |
 			   INES_INITIAL_T1_2000ns, AUXMR);
@@ -322,6 +325,8 @@ static irqreturn_t ines_interrupt(struct gpib_board *board)
 	spin_lock_irqsave(&board->spinlock, flags);
 
 	nec7210_interrupt(board, nec_priv);
+	if (priv->pci_chip_type == PCI_CHIP_INES_72130)
+		goto out;
 	isr3_bits = ines_inb(priv, ISR3);
 	isr4_bits = ines_inb(priv, ISR4);
 	if (isr3_bits & IFC_ACTIVE_BIT)	{
@@ -339,6 +344,7 @@ static irqreturn_t ines_interrupt(struct gpib_board *board)
 
 	if (wake)
 		wake_up_interruptible(&board->wait);
+out:
 	spin_unlock_irqrestore(&board->spinlock, flags);
 	return IRQ_HANDLED;
 }
-- 
2.53.0


