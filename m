Return-Path: <stable+bounces-234365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCjvBwWg1mkzGwgAu9opvQ
	(envelope-from <stable+bounces-234365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:35:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 866D93C108A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ABE2314F1B1
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272813ACF13;
	Wed,  8 Apr 2026 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mTWqxFaa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF55C3A16A0;
	Wed,  8 Apr 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672669; cv=none; b=Ht+i04M3RC16aTFTZUBEyHgf0XJ6vVgjJu+PR35u+bBMSppz9UMb/zwOZp/Ub2mmZhc0I7+43XhHYLtkCb+MHwv/YdPZeB4vlMWggDCOJQ4EX929w5nP63YZkmeIxnhdSFzluz2BmJq60eWg7usVnS+4K4uEnohXm8hKsOcbiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672669; c=relaxed/simple;
	bh=I8ZWbEf6g9Wu1mBIZ/jW1xYpZ8TRyJOspUWW4WSq7Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4EUZ+R3BRftR9MOBpG/B2LReTj/ktXfhjeXp0b6INOs53qJS3ryZsXXMSBgChlqONd4M9j/1MVpmV3tv51CPdmvZUXzDJTDCLu/swR8lWV9SUVUKPAypj9qPZuwR8M83cBVLdmb0c1cxIoSNuPtV8Kbzu0JXXwUlc9jDoyZeEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mTWqxFaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B72C19421;
	Wed,  8 Apr 2026 18:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672669;
	bh=I8ZWbEf6g9Wu1mBIZ/jW1xYpZ8TRyJOspUWW4WSq7Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTWqxFaagLsViZjETvYEJGa7dQVTAVYChjzh1s9sq0ZpjWOKznggj/NRE9k+BJtFK
	 KlYogXyrf1cCw3xPNhWy/aeDgvh8ZdDbT0AUxyZxiy+B7+2d/nLhVLLpWKhR5OPf+B
	 s8FOjYFFPTuDO0MR6UMDUNjqS0SI7FZbj4hgLSgE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Valek Andrej <andrej.v@skyrain.eu>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6 095/160] iio: accel: fix ADXL355 temperature signature value
Date: Wed,  8 Apr 2026 20:03:02 +0200
Message-ID: <20260408175916.737140489@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-234365-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 866D93C108A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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



