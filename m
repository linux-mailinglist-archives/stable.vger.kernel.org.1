Return-Path: <stable+bounces-233820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJmhAq8V1mnwAwgAu9opvQ
	(envelope-from <stable+bounces-233820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:45:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0576C3B9481
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4AF743009E3C
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 08:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64B53A7855;
	Wed,  8 Apr 2026 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeDllXmk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053F385502
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637900; cv=none; b=tjp/j2Mn4wWUIRN+3T5magdj3VmuQeTaTseo8kCdQqwf0sjKoDjDFuLl9Ub5Zy2V9gCV7gAmj8a/1J2r2uxKZZKPnzW4bwpzkWGvTZZ35VHaNPrKNLts6R233bv9TcQ+LcGNbpUMmtzXwJV9kSNUxWvauUaiD3Ron5pVlffplBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637900; c=relaxed/simple;
	bh=um2bnzTgo3+eXGPY4aECayD9ZkbhnNPNE7ddZzBwz/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwqhP/rN2/7+ECEU86TyVqKQ0FOseINBudEa85qci04GfeNy4koHB1Qs2lUSd205cmKx3dJVUNgrXY/5bMIXaxC3qObnwgqYNR9jPoeEf/D4CvWVCD0U7O01jFFrTB58ef0ohmbhrsB5sW7HcF8idcZtMOeB3uSN84tVN7UIkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeDllXmk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so5343475e9.0
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 01:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775637892; x=1776242692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVUH1FeY+jiNpvmyxeeiM/1wZCRQ7L54SbDhRLtgK1g=;
        b=FeDllXmkgLV5C1jjNYIzxwE+MhXayeylzPrk+W8YfhbNWVwqvwj+Vi1+y0ZIQImtUA
         oKZm3a0LmKUL80XBycSKc+m/heN+K35fB8tU7qaHeQRDj2k4elYVlSearMyzdYrgX1We
         hQDC6qPVV3iZwlZ8D3OCP3cYJQ/xpQVp2iUBLAfJb+I5awLQgneT9ZyC/UjH/7gmHLLg
         Sn+G1tiRdB3Q30ajoxkN2lWgekDvWL0wO5ZRsEowsZjJtmaVa2j2Y8e20V7IRV5gjg9+
         7BsU9UbUyogxsT5eX6Rkdxeg4ED1Cgrz4mEecnGEMep53/1yy8MJ+txvoktSrGXdE2WA
         lHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775637892; x=1776242692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uVUH1FeY+jiNpvmyxeeiM/1wZCRQ7L54SbDhRLtgK1g=;
        b=pZLzCh0YxmEIzf7Uk/TjuYJ2Y1GU0I4OJTbyOR3tkpmZT00uVoFoS0m21jnQgkyZ2v
         LixTQ3utWOqZJJ9jsOf9Lv9YbSiEIgOyyTOTcsuA2LqE8rGnXpAtyXlRMgzP0W6Tnmc0
         eK96NW7ntL6r0xjE6pcHHHXtazyUI6O+6mHCe189Il/0DTN3n1SDxqpv+Ys20buydI8p
         L5iN2ayr+929TB5yjGkZNznng4rhXNj5AfDQbGjxlPJu0r6gWmxFkOThQkWUSTp05cUu
         AFJC5SkpvYE6yJSN3TnS3oU0utOjwkke2R2cte7n6bBNaEtjCY7prI/59wuB6t9VV0tl
         RiOw==
X-Gm-Message-State: AOJu0Yyx7khgGS3qaz3vMANlS8dxjdlM8I4ZkPdTMA5A6iizofZEL5jG
	kuVO5VOYS5+p47IB2h1J5CtDKQjyo2iaEv5bD21sxZI3tCNrVdkweWtAEaIosvUe
X-Gm-Gg: AeBDieufWSpr2O+X/gg+30hUCrBqyFYG+ef8Wi2lK9dEnsdaNC+GbOYj6nST5ZMokLK
	Frvgqk7pE/kazaeYWCxlxhmyNb2ZuhBU+BmKK+IaEaurNCfPSpzcEegnF9chgGYfg29spZNp2yA
	HcO/xFMcs8K+Q1b4v71e6DwU5rcY1xLr08LXdRX1OdnKtyzKwI8xtNG/XW9IxBzx7fMa1mX+kAv
	eyrGomBGNZqL/m2+1CjQgjoBTVUeWx9MotGl6XV2dQPR8qSHAQPeuzM6g0dMy8FYdIiZfHPQak1
	PK8pIKVg1uR58gMVZ8nJ9J+rcJX1gugOsSL+tCr3uW0SJxoAADs6STaWxe+KOhmvnSyJUM34DPG
	6q/0bzwddhmEhckMxh2jJAfMhlC7yF7urpYzUaHAbFtttwLayQ2s6NrI9j3mn/qdbugj0nr7jiK
	OY8a263jBBcslfoAE8TwIIUZLBB+HVP6Dwsd+GYKwWzqZ1PyeGyInRhV9WlL0DAiSN53NTRM6cY
	N0+8nQMMIECkjkzGPpMO5/PrAfra18vH9Am2eSjiwQ1
X-Received: by 2002:a05:600c:a30a:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-4889949bd2dmr190697805e9.11.1775637891594;
        Wed, 08 Apr 2026 01:44:51 -0700 (PDT)
Received: from emanueleg-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b739e00bsm219420635e9.10.2026.04.08.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:44:51 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12.y] spi: cadence-qspi: Fix exec_mem_op error handling
Date: Wed,  8 Apr 2026 10:44:43 +0200
Message-ID: <20260408084443.132748-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026040818-grandpa-wheat-d0cc@gregkh>
References: <2026040818-grandpa-wheat-d0cc@gregkh>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233820-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghidoliemanuele@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0576C3B9481
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

cqspi_exec_mem_op() increments the runtime PM usage counter before all
refcount checks are performed. If one of these checks fails, the function
returns without dropping the PM reference.

Move the pm_runtime_resume_and_get() call after the refcount checks so
that runtime PM is only acquired when the operation can proceed and
drop the inflight_ops refcount if the PM resume fails.

Cc: stable@vger.kernel.org
Fixes: 7446284023e8 ("spi: cadence-quadspi: Implement refcount to handle unbind during busy")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Link: https://patch.msgid.link/20260313135236.46642-1-ghidoliemanuele@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit 59e1be1278f064d7172b00473b7e0c453cb1ec52)
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/spi/spi-cadence-quadspi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 288a0467c937..72262b6fb62b 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1461,12 +1461,6 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (refcount_read(&cqspi->inflight_ops) == 0)
 		return -ENODEV;
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret) {
-		dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
-		return ret;
-	}
-
 	if (!refcount_read(&cqspi->refcount))
 		return -EBUSY;
 
@@ -1478,6 +1472,12 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		return -EBUSY;
 	}
 
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
+		goto dec_inflight_refcount;
+	}
+
 	ret = cqspi_mem_process(mem, op);
 
 	pm_runtime_mark_last_busy(dev);
@@ -1486,6 +1486,7 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
 
+dec_inflight_refcount:
 	if (refcount_read(&cqspi->inflight_ops) > 1)
 		refcount_dec(&cqspi->inflight_ops);
 
-- 
2.43.0


