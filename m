Return-Path: <stable+bounces-212465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIXHGLszeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:05:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE97AA50A5
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D527B30CEE55
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7226530BBBC;
	Wed, 28 Jan 2026 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EYbQy8e2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B07303A15;
	Wed, 28 Jan 2026 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615611; cv=none; b=CcoOuc+8CqGZ5i/pggRej7W9qpQrhaPY1qJFexB6t27EP8Cov9bTz8uMdmeuUHjwmNHZSv+7RAupFaUGJxk/TctgwBRtO2EPZyJTGKdNa9mlnjouWkrv9V+ivH7XTUJiwNImBDus0DK+42hjDrNjVincNFVkh2sVG6NbKBELoUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615611; c=relaxed/simple;
	bh=2ezp42lwLGeFEmuU0GsVTFMqtnMQ97d2gafPKejhnbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYMn+jKYZoCy4MaD/h2O7jnRdnBcGvfnRfCBmCfBUi9A/9amJl9Ix+zvZ5jWCWI26pynGbMSIBKn979oZEAN8srETCch1EINlcvLelEorH+0QFAi/CJ9lusExc/ghw+BZhOUwyOEozQ/kc31qKaheDb2vnKTCuAS8yIhuGz1Hlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EYbQy8e2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C69C4CEF1;
	Wed, 28 Jan 2026 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615610;
	bh=2ezp42lwLGeFEmuU0GsVTFMqtnMQ97d2gafPKejhnbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYbQy8e2VQEJ6SRAhLBFYaP05EfG6tBpukQbaoYIlbOomhhprNuv0yH+ZdXikRgf5
	 tyI6HQxVshHtGy5WX3XwiGHZUtih0Lnr5VSYjDSDOuxP5GKAVIYWoEE4SPKvFy7/xE
	 L8ZwmAaR7utU0/i2kdRkeoS9lwrmFHstp0nORN0o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yixun Lan <dlan@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 6.18 059/227] i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request
Date: Wed, 28 Jan 2026 16:21:44 +0100
Message-ID: <20260128145346.463655433@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212465-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spacemit.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: CE97AA50A5
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yixun Lan <dlan@kernel.org>

commit e351836a54e3b0b4483f896abcd6a0dc71097693 upstream.

In commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT without a
threaded handler")[1], it will check IRQF_ONESHOT flag in IRQ request,
and gives a warning if there is no threaded handler. Drop this flag to
fix this warning.

Link: https://lore.kernel.org/r/20260112134013.eQWyReHR@linutronix.de/ [1]
Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
Signed-off-by: Yixun Lan <dlan@kernel.org>
Cc: <stable@vger.kernel.org> # v6.15+
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260122-05-k1-i2c-irq-v1-1-9b8d94bbcd22@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-k1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -566,7 +566,7 @@ static int spacemit_i2c_probe(struct pla
 		return dev_err_probe(dev, i2c->irq, "failed to get irq resource");
 
 	ret = devm_request_irq(i2c->dev, i2c->irq, spacemit_i2c_irq_handler,
-			       IRQF_NO_SUSPEND | IRQF_ONESHOT, dev_name(i2c->dev), i2c);
+			       IRQF_NO_SUSPEND, dev_name(i2c->dev), i2c);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request irq");
 



