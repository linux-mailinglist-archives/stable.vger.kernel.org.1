Return-Path: <stable+bounces-235172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAaIEM2r1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:26:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 857D93C2F76
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CECAB30FBB7C
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6F537F01B;
	Wed,  8 Apr 2026 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TabUKy95"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A443537DF;
	Wed,  8 Apr 2026 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674754; cv=none; b=p/t+6tOOoiez1iEoeVgjjGAs5GavqOj/ADS5di7y00SRcrqUwZRl1tK9qcUKL6yi0E4x9s/POsF+zkVcxh2SvTYRdjjB1lsuaONBzY00V/6JZ0uJ6dRuLZ+Nl/Xh+B29eeRKq4akay134PwB0ZmU2pHxgOqKJmhAZE8Lwl39dVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674754; c=relaxed/simple;
	bh=HQ9lDhIPD7Qx9daQ3/fBAnOSIDv1rALpcNQ8r+aVUk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCRwdNij1dZQVhuK1DVGfR88+6UK2CQrhl3uW9TqEPv+mP01GeopT7E/VCwP+bqP3k+x7v7M2d3c2N/2gItRSj/U6q5j7eeUDmYQ9tDcddSTqKbihBcflfH6a2SPeYizZv5CxdYBHaEj3Jd2doLga5SsK+xn3i8byUxBxCKXheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TabUKy95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67235C19421;
	Wed,  8 Apr 2026 18:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674754;
	bh=HQ9lDhIPD7Qx9daQ3/fBAnOSIDv1rALpcNQ8r+aVUk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TabUKy95bhqR+rWsAaRTM/ora00NFKo/CmCpkVr+lKJVY/dhIEx2BMREvfga0nWoo
	 kOsBE5TF1PYNPVa1+llvC0f+Rd1c7as8DQdPdxDOZtLpVjAB3PbZtlEAf2iV8qTeTS
	 yVc/CTFDzK8hrVs8kVCOk8+smV8Cdng0Tcm9BQpE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Valek Andrej <andrej.v@skyrain.eu>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.19 221/311] iio: accel: fix ADXL355 temperature signature value
Date: Wed,  8 Apr 2026 20:03:41 +0200
Message-ID: <20260408175947.654370683@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235172-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 857D93C2F76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Valek Andrej <andrej.v@skyrain.eu>

commit 4f51e6c0baae80e52bd013092e82a55678be31fc upstream.

Temperature was wrongly represented as 12-bit signed, confirmed by checking
the datasheet. Even if the temperature is negative, the value in the
register stays unsigned.

Fixes: 12ed27863ea3 iio: accel: Add driver support for ADXL355
Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/adxl355_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -745,7 +745,7 @@ static const struct iio_chan_spec adxl35
 				      BIT(IIO_CHAN_INFO_OFFSET),
 		.scan_index = 3,
 		.scan_type = {
-			.sign = 's',
+			.sign = 'u',
 			.realbits = 12,
 			.storagebits = 16,
 			.endianness = IIO_BE,



