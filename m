Return-Path: <stable+bounces-226828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NCMHuiVuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:56:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C8E2B0625
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DA21325E9CC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321B2F6160;
	Tue, 17 Mar 2026 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NhnRTat4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD62DECC6;
	Tue, 17 Mar 2026 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768369; cv=none; b=HBF+djsAAlYVj2u+1+qOuO+iWzHwy/DwTQ3ic932/v8eiOXB81oqXIP7caFHVKJVNnFSe287BV+qTcMIff4FFc82p7i6Fgd1B6Qng3ijhvpDS3BmEGrLpqog2a+JHiiWPplLK/qc9xevh8GQRaRxKucnpT5xUxTxbfjHqR/G2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768369; c=relaxed/simple;
	bh=ilp1VJKiO/bT+Y4KldB5LwnpDel3L+2YVcSbTJ0UQMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNLBzGgFSEoqNUQXvQfA0v3Kz7ooWWk8glzBFfsgSBxC1BQS27PvMaFgAMc222jFfdEepB6eeYqicTrfRgpyArBIs+S3pw8iH/4V7rt0HitHwmSEE9JWBinUlwpgbu91PsvLE3VkWmoLec3ZeA2IhKy/eezwWOSbPcx5Ex41N/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NhnRTat4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E69CC4CEF7;
	Tue, 17 Mar 2026 17:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768369;
	bh=ilp1VJKiO/bT+Y4KldB5LwnpDel3L+2YVcSbTJ0UQMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhnRTat4thj73M5sQdZ4DD2fPvBY+8obiH8yxAqGuFJNgeqQISLiLVyha/WATOw54
	 RuBDccCvM3ktUxHDA7Bk69Ktef6PwlW+TmnDlRK8OymWwdV/2ol4kr7A0WCqoq+YuV
	 qo4avDR3XK8U/nlSf/Jii7Qqmtx5q3eGMYbc3/9M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 294/333] iio: chemical: sps30_serial: fix buffer size in sps30_serial_read_meas()
Date: Tue, 17 Mar 2026 17:35:23 +0100
Message-ID: <20260317163010.296658509@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,analog.com,gmail.com,intel.com,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-226828-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,analog.com:email,intel.com:email]
X-Rspamd-Queue-Id: E8C8E2B0625
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit c3914ce1963c4db25e186112c90fa5d2361e9e0a upstream.

sizeof(num) evaluates to sizeof(size_t) which is 8 bytes on 64-bit,
but the buffer elements are only 4 bytes. The same function already
uses sizeof(*meas) on line 312, making the mismatch evident. Use
sizeof(*meas) consistently.

Fixes: b2e171f5a5c6 ("iio: sps30: add support for serial interface")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Acked-by: Tomasz Duszynski <tduszyns@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/chemical/sps30_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/chemical/sps30_serial.c
+++ b/drivers/iio/chemical/sps30_serial.c
@@ -303,7 +303,7 @@ static int sps30_serial_read_meas(struct
 	if (msleep_interruptible(1000))
 		return -EINTR;
 
-	ret = sps30_serial_command(state, SPS30_SERIAL_READ_MEAS, NULL, 0, meas, num * sizeof(num));
+	ret = sps30_serial_command(state, SPS30_SERIAL_READ_MEAS, NULL, 0, meas, num * sizeof(*meas));
 	if (ret < 0)
 		return ret;
 	/* if measurements aren't ready sensor returns empty frame */



