Return-Path: <stable+bounces-234841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHhnM3ei1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:46:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 072DE3C178B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2E21300B536
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F633D564E;
	Wed,  8 Apr 2026 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zRF3hMFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA23624B0;
	Wed,  8 Apr 2026 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673902; cv=none; b=tux3Lhpdjzv32JZdyTsq6OAfqDn1GahT3ZuD29jSah5A6qRUuZvfVJKgmPdFHA9Aasfg6KhwU02Tv4fuRIPP2HWIc9nhXZxMv7KOmFrno0GiyyHsOgwXcgSLODTfWiMAcnV0gs0DpU2NsdtcBCMSLiJ9O3GFUcMCLrCuhHDX1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673902; c=relaxed/simple;
	bh=mazdgVNQfl+W8y9Y+p/tKW+3zis3WsRX/autgB31b8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjP0PTgtfirF1HA2287OqmlbeieLfex62F6NmkIKyA8SlCLDNrjf4cXjW+6epiWeMiGnNqTGLtdUDq0cyteyIBT5JvYA3c26StztI/RLvli7MmRsQOw6Tlux4YtOBgFZCumURiXYqPPi8AyVgQ/ivKp3QcMpgnKqG/DxXu325Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zRF3hMFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582CDC2BCB4;
	Wed,  8 Apr 2026 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673902;
	bh=mazdgVNQfl+W8y9Y+p/tKW+3zis3WsRX/autgB31b8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zRF3hMFRHqf4RiMWA07MnapzfbSxSGQs7IGyukZdJtuAI2pvrqbSIUkByYdYU1RJO
	 YU4LGoFjyg0o1P6o9hW58trUMH8su8x9JN7oZoZ0pYfO6ZZCtA88S1DKfT1Jzeq0ud
	 EF3G8ZlfQ67fIyY/MMmG+Dyb2aZJs1PiMlyxnUHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 133/242] iio: adc: ti-ads1119: Reinit completion before wait_for_completion_timeout()
Date: Wed,  8 Apr 2026 20:02:53 +0200
Message-ID: <20260408175932.067070754@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-234841-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,toradex.com,vger.kernel.org,huawei.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,toradex.com:email]
X-Rspamd-Queue-Id: 072DE3C178B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

commit 2f168094177f8553a36046afce139001801ca917 upstream.

The completion is not reinit before wait_for_completion_timeout(),
so wait_for_completion_timeout() will return immediately after
the first successful completion.

Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ti-ads1119.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -280,6 +280,9 @@ static int ads1119_single_conversion(str
 	if (ret)
 		goto pdown;
 
+	if (st->client->irq)
+		reinit_completion(&st->completion);
+
 	ret = i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
 	if (ret)
 		goto pdown;



