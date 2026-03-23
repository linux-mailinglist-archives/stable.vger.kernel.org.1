Return-Path: <stable+bounces-228663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAynIn1VwWlTSQQAu9opvQ
	(envelope-from <stable+bounces-228663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:00:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB862F59DC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91EFC31F2764
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291A61FFC48;
	Mon, 23 Mar 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewTqoA/Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E139E1F91F6;
	Mon, 23 Mar 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275756; cv=none; b=REWXn1aIVFJ0HW3DR5+evPeEJTNECBM+30ybTjpf1A1PgAGEdUXy+tvHIyU31I9xk7CmHe+Ynymtyp+cnJzAPXq54LTNDTjGa8Y/YAUaRV+jz2KhAh1XGK9+zBSXKJww/26KSvAGf/AnCon1ZG3BzlfjAEKsfIkQlcTnEKNr2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275756; c=relaxed/simple;
	bh=tedPrA1sfzn6+B7JZFUuTYlwc21ixOjM7WgXsq+9LkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjznTWgHRfa2GfY0mzPEvJLEOXWiZGrYuoG5K74K9WBE1fN+dYkrGcoJEmh5dGyWHGGkmiMm91+8qEDUbwhe3ON/SioGhOzkHhN5JhGS+iC/MPuQANhGPlQdnTHbB+CEDyGl64vMA+LWhXeax+qQ9MLTshQJKGyzMJxYtKBPJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewTqoA/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5342BC4CEF7;
	Mon, 23 Mar 2026 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275755;
	bh=tedPrA1sfzn6+B7JZFUuTYlwc21ixOjM7WgXsq+9LkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewTqoA/Q5cxJfL+lbJiIFs+TyMawFYNa5r3sum/Awy8KKwvlo09pSrwvbQKNcUaT2
	 7QM+BV5p0f8xlR/m5wd56HWyf+zNWP8Y6vAmI9EphJzTIYfOySYBmJk9TyVtc1+UBE
	 8LcSfYy6VYXqRQcaMchq7qnp/VKse25Qv8drWO5w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Spencer <spencercw@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 208/460] iio: chemical: bme680: Fix measurement wait duration calculation
Date: Mon, 23 Mar 2026 14:43:24 +0100
Message-ID: <20260323134531.634438427@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228663-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ECB862F59DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Spencer <spencercw@gmail.com>

commit f55b9510cd9437da3a0efa08b089caeb47595ff1 upstream.

This function refers to the Bosch BME680 API as the source of the
calculation, but one of the constants does not match the Bosch
implementation. This appears to be a simple transposition of two digits,
resulting in a wait time that is too short. This can cause the following
'device measurement cycle incomplete' check to occasionally fail, returning
EBUSY to user space.

Adjust the constant to match the Bosch implementation and resolve the EBUSY
errors.

Fixes: 4241665e6ea0 ("iio: chemical: bme680: Fix sensor data read operation")
Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L521
Signed-off-by: Chris Spencer <spencercw@gmail.com>
Acked-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/chemical/bme680_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -543,7 +543,7 @@ static int bme680_wait_for_eoc(struct bm
 	 * + heater duration
 	 */
 	int wait_eoc_us = ((data->oversampling_temp + data->oversampling_press +
-			   data->oversampling_humid) * 1936) + (477 * 4) +
+			   data->oversampling_humid) * 1963) + (477 * 4) +
 			   (477 * 5) + 1000 + (data->heater_dur * 1000);
 
 	usleep_range(wait_eoc_us, wait_eoc_us + 100);



