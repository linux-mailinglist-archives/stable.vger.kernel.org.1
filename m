Return-Path: <stable+bounces-231360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMDBBpaMy2kuIwYAu9opvQ
	(envelope-from <stable+bounces-231360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:57:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB33668F3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE18430AD596
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE573EBF1F;
	Tue, 31 Mar 2026 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WE75VddU"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E343EAC75;
	Tue, 31 Mar 2026 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947055; cv=none; b=Jj2VCKWdZSO+jk+4A6kIBs6vZrSBdwy902cBghLH35ZQzfOOYS3Zy511N44ypCUz+Z/jN7707biMU+pIpPGxk/4y2GAgh/MkPT0rxTOJAlai5KYiwR6tETmVex2qcgJbAX/eYwtwt+GWLpx9vB8m2HOOXf2Wvd0f55JVHNiBos0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947055; c=relaxed/simple;
	bh=hEvrg1VgBxZ83vGHPoZyelEcdFEP9n7WwNRrQgglhPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hAHich0UAinY7TSvNyNIlqMZIgyUBW/egfn/v6v5eIH8IU1SoiLyWk8drjJJuxe/r/2lE00cWo/WBEr1s+axwCsA5TVBhuO9ZV6qEztcAR8qEBADPy3HJcGtNUbebFMhAmF8cdPJUQNmO0QeLYuzlDAUb00B3nqfUfOnqQQtwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WE75VddU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 84B08C5994C;
	Tue, 31 Mar 2026 08:51:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D959B6029D;
	Tue, 31 Mar 2026 08:50:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92E3E1045049D;
	Tue, 31 Mar 2026 10:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774947043; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=g/R8nvIUjydE7o/OpG+ZQm7VsFlI0MLtO6nqskaGhjw=;
	b=WE75VddU4+vhxp15YnMHtJ2uohhTNkS/uJuJ76AXJ1k5PpOrGIi54sSPAbaUzPe5SwBCIK
	eO4tnHn2oS21KAeqStzhj1KFrSTStm/ycAxeWY175dELF6WkTucMNwKqEnEMPYqvrBBHyj
	h6M7c0rAiXExdJqwEppam+bz+5957gqa0Jw13xCoaXBYSqPbWc6nt+FctYx8WOLNemRg4G
	WQz+1avByt+94QSyKvnsUFnGGw82Cbk1dwgaFkYPcly8nB/gM447KS5gMw9d0iQuv0Nhui
	ySOgyUV5NvrYVVqBeESo5+cWojhvD9APFsmjAG7/OIVvYpvL3bkwo1XS20LHuw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 31 Mar 2026 10:49:59 +0200
Subject: [PATCH] iio: inkern: Avoid risky abs() usage in
 iio_multiply_value()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-iio-multiply-abs-usage-v1-1-2ae8063e80e4@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G2graPEr4qHVqAE3GhWl+HeLx
 4GZiSAUmATqLEKgi4W3NYHOM+gmt46E3CcGo0ypikIj84bLOR+8zw86L3iKS5apSqOtctarDlK
 8Bxr4/sdN+74fwwiP5WgAAAA=
X-Change-ID: 20260331-iio-multiply-abs-usage-2762180a8b0c
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-231360-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: 91EB33668F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iio_multiply_value() passes integers val and val2 directly to abs(). This
is problematic because if a signed argument to abs is the lowest value for
its type, then the result is undefined due to overflow.

Cast val and val2 to s64 before passing them to abs() to avoid this issue.

Fixes: 0f85406bf830 ("iio: consumers: Fix handling of negative channel scale in iio_convert_raw_to_processed()")
Cc: stable@vger.kernel.org
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/iio/inkern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 0df0ab3de2709..59e8c01457f72 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -618,8 +618,8 @@ int iio_multiply_value(int *result, s64 multiplier,
 			denominator = NANO;
 			break;
 		}
-		*result = multiplier * abs(val);
-		*result += div_s64(multiplier * abs(val2), denominator);
+		*result = multiplier * abs((s64)val);
+		*result += div_s64(multiplier * abs((s64)val2), denominator);
 		if (val < 0 || val2 < 0)
 			*result *= -1;
 		return IIO_VAL_INT;

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260331-iio-multiply-abs-usage-2762180a8b0c

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


