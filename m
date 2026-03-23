Return-Path: <stable+bounces-228661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FT3EiZOwWm7SAQAu9opvQ
	(envelope-from <stable+bounces-228661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:28:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C902F493F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3208301FD9A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F831FC101;
	Mon, 23 Mar 2026 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1KLRGk0o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8931D63F3;
	Mon, 23 Mar 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275748; cv=none; b=QpIzX0Dwzv6hRngWkINLDlvbj9FgGrMhYAYBWaxiJBjwcnnq/N3zjfLcplBScUZjs7i63z6bWInpBi0Q9/bFm7nWNW/g45MMsi4S4XtZuOr7CC45xJ4h+X5JfTkr9NyLdaMieq+Qx09VGNoKEtwoLhTRDeJf5M+WIvXz+GVLjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275748; c=relaxed/simple;
	bh=nadLwXW4hogQ0T3t1Yzw7vJQp5ADXRx/p2HKaHBnV48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJYnpdWvnfyboIJEgPoNad11L2tNWjAwkJdL4HHwgDLOoLimTQDjPq8ky3f0JjOJpJAB+DYtHKGka4RnuiLPiJoxxbfSq8RG9X7wk6NlK4SJRAl5emhthnyk8YRIskk4pSnr8DbuoqTbZudM/4wKLRPcdeuYntQr0np20waIqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1KLRGk0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D534C4CEF7;
	Mon, 23 Mar 2026 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275748;
	bh=nadLwXW4hogQ0T3t1Yzw7vJQp5ADXRx/p2HKaHBnV48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1KLRGk0oIrgaL4BMeb/0pCO3gw2p7PCi+L4Zmy12MjpCOsxxJ0/xjcRm4XBEHq6xO
	 QOgfY1QhljIsiBI4lZVLpBmRP9s46XRBkbOCaWmVg4QI9nVK0H01FzJgCG89wP+RJ6
	 4Kq3cWz9U8g6eEuABkkB5aUW6fj9pYCQcU9lwU6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 206/460] iio: chemical: sps30_i2c: fix buffer size in sps30_i2c_read_meas()
Date: Mon, 23 Mar 2026 14:43:22 +0100
Message-ID: <20260323134531.590821706@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-228661-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 97C902F493F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit 216345f98cae7fcc84f49728c67478ac00321c87 upstream.

sizeof(num) evaluates to sizeof(size_t) (8 bytes on 64-bit) instead
of the intended __be32 element size (4 bytes). Use sizeof(*meas) to
correctly match the buffer element type.

Fixes: 8f3f13085278 ("iio: sps30: separate core and interface specific code")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Acked-by: Tomasz Duszynski <tduszyns@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/chemical/sps30_i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/chemical/sps30_i2c.c
+++ b/drivers/iio/chemical/sps30_i2c.c
@@ -171,7 +171,7 @@ static int sps30_i2c_read_meas(struct sp
 	if (!sps30_i2c_meas_ready(state))
 		return -ETIMEDOUT;
 
-	return sps30_i2c_command(state, SPS30_I2C_READ_MEAS, NULL, 0, meas, sizeof(num) * num);
+	return sps30_i2c_command(state, SPS30_I2C_READ_MEAS, NULL, 0, meas, sizeof(*meas) * num);
 }
 
 static int sps30_i2c_clean_fan(struct sps30_state *state)



