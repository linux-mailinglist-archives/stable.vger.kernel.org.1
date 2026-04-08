Return-Path: <stable+bounces-235148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL30Nnul1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:59:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE633C21E0
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B50EF3014A12
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207473AEF5F;
	Wed,  8 Apr 2026 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Go21+Ykk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83EE32A3FD;
	Wed,  8 Apr 2026 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674692; cv=none; b=OrBBbAQajPmZQM66qG0EiR86oDdPbOYtLv5pGEf+gUFhVQhnWe3u6e0WQoWJctS8/+p+xVxS0LJ3akAhY0twSGPqvywPxJzb1k8WX9tMrqNd4mKDzjUnyKU9lZDMwQVRgxggp90YIylWrZes93pLJ/xDIMQ9cWEdtmpFdAuk4YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674692; c=relaxed/simple;
	bh=AZeQ7LeH9VvXwat9tpi8UxHLvXrCxa2X4a5Iav3qj2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdaqTz7Ioun9viLT4RMv2j7iDZ6Ms4B3OU/2tqetStx6xh6mZkPSKs/IgRW7jbp440LyZ9DquTkq7TXs+B+jM/sKO4rey6h7wwTnzr9X5xGKoeRlglA1ErVDuL8e0iotpFfT3eDOH0+BJNlP0xNEfeR+O4uEAYQV2bvJsieTB3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Go21+Ykk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E964C19421;
	Wed,  8 Apr 2026 18:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674692;
	bh=AZeQ7LeH9VvXwat9tpi8UxHLvXrCxa2X4a5Iav3qj2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Go21+Ykknqv16XMTVGvdsvrtQQpeKluxiy1B60aOzHfnhNhjRTT2LCpJy5xLErUtg
	 Nkckc4lTF3QQ8LejH1dNYYRRSQzHEGhoqcJq5mCfLcedFk5/VFbPRemBgGhMtaNhU1
	 wDLTi6IAJH5St1f2q3magbBzCPBj+FhGuCpj8I+s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.19 196/311] iio: adc: ti-ads1119: Fix unbalanced pm reference count in ds1119_single_conversion()
Date: Wed,  8 Apr 2026 20:03:16 +0200
Message-ID: <20260408175946.732059008@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-235148-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,huawei.com:email]
X-Rspamd-Queue-Id: 2CE633C21E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

commit 48a5c36577ebe0144f8ede70e59b59ea18b75089 upstream.

In ads1119_single_conversion(), if pm_runtime_resume_and_get() fails,
the code jumps to the pdown label, which calls
pm_runtime_put_autosuspend().

Since pm_runtime_resume_and_get() automatically decrements the usage
counter on failure, the subsequent call to pm_runtime_put_autosuspend()
causes an unbalanced reference counter.

Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ti-ads1119.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -274,7 +274,7 @@ static int ads1119_single_conversion(str
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
-		goto pdown;
+		return ret;
 
 	ret = ads1119_configure_channel(st, mux, gain, datarate);
 	if (ret)



