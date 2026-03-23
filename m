Return-Path: <stable+bounces-228660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMQ1BiROwWm7SAQAu9opvQ
	(envelope-from <stable+bounces-228660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:28:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E013D2F4932
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96013304545B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E7D38F630;
	Mon, 23 Mar 2026 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tebfytEa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A211F91F6;
	Mon, 23 Mar 2026 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275745; cv=none; b=CWAtlBxNIx/+LpirS0iySbuAHikz2lXNvxPdECuH/wjrFC/M5lVltCm/BtCdAVAROUDiWHWpKkpaToeCB4HcFKMJexttbuvVq+I4pIfUkY36oPyCfCQEx9JgVXYxpFfwDI6JY1axjXKjdhtPvnJ6klfDsgTJ18Utb66xBUf2wJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275745; c=relaxed/simple;
	bh=hlqscGFKnPw5oiloxWoTTdBSLU/AN2qRT52kp+bQpSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCp++YE5SF7qPwo5IljzMC8K0hRCLswrqekPVlsrBHodd9G1VstNnBaj5aymtocUCFv0pURIXHNDoB2IPoJiV2KKIXkK1Xx1+qGWu8BK7LNNAYJrD95lFyRUWS0DXcJ3cc2yPI/lthaSJ+zz8mpJngD/4aGF6yDy6fiw66S/RYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tebfytEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D771C4CEF7;
	Mon, 23 Mar 2026 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275745;
	bh=hlqscGFKnPw5oiloxWoTTdBSLU/AN2qRT52kp+bQpSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tebfytEaDaxW3es79zNpcjNRWY+F4EmLn5ga8zjAqRMx1L0ALk0E9BVpZdDwy8f9Y
	 vaaWZ1fYjL9pqD55emIAvnjWj+U69TVBvCSwhCL87qTnb97NaVkDni5sbU0HWPLApl
	 SqhFiaH+VJpvK/AjvWCkT18bhy/y+Vu/H2wJAY3c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 205/460] iio: chemical: sps30_serial: fix buffer size in sps30_serial_read_meas()
Date: Mon, 23 Mar 2026 14:43:21 +0100
Message-ID: <20260323134531.568005326@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228660-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,analog.com,gmail.com,intel.com,vger.kernel.org,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E013D2F4932
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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



