Return-Path: <stable+bounces-234651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F5lDGKk1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:54:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C76643C1E51
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D39316AB6A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D395C3B19A3;
	Wed,  8 Apr 2026 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u2d0Rwvh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975EC331A44;
	Wed,  8 Apr 2026 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673410; cv=none; b=S12Xe7jpIVze/jpA+OlPQKr2oPwltApiHyzRCxErdMMRUA5E17Slkocalxi9o3xYkuKhjPBTmGgLjbgxbju9iAC7RU2CxVJhDaVaJfHPFu+zohFX+olOHxFFLa3jrevomL0tSnyVzoGAG30yf2ba4fwtu9DdZtVCcMC0y0aXLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673410; c=relaxed/simple;
	bh=CAL6PHoSE3Kr2TnZHcszBhRiwuRWpoWR6BwAi5XzfiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNPnqGGi7D1zp9YK4NYEVRBAH9m9Sjc7b/YKFd4xR6J27py88m++ZHitXsyUUljRTQN5NZ3tw3uACIa6dqWZooxnOs08VtikHGb93eLKtlK77/PbFSeSydB5hACpxEuO8MFLzJr14jBmR/AjiWJtRxMrDLwb4CnYVCQDo6Rr2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u2d0Rwvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECD5C19421;
	Wed,  8 Apr 2026 18:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673410;
	bh=CAL6PHoSE3Kr2TnZHcszBhRiwuRWpoWR6BwAi5XzfiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2d0RwvhCe9lTgjff+15MWXDcGs2IUAeTRdys1DQInewDf8xUA3GXb8qVurznj1Er
	 mGpavicD0VJcMwcPuqIunjYm+QLZ1J79JFmllzbKwTiBoiZh/u3VLWcWZI3YPvt9cA
	 R53Tvna3YK20i1uPh7L2/tIMacIdGdmlWg1WdyIY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 179/277] iio: adc: ade9000: fix wrong register in CALIBBIAS case for active power
Date: Wed,  8 Apr 2026 20:02:44 +0200
Message-ID: <20260408175940.548938382@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,analog.com,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-234651-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,huawei.com:email,analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C76643C1E51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>

commit 86133fb1ec36b2f5cec29d71fbae84877c3a1358 upstream.

The switch statement in ade9000_write_raw() attempts to match
chan->address against ADE9000_REG_AWATTOS (0x00F) to dispatch
the calibration offset write for active power channels. However,
chan->address is set via ADE9000_ADDR_ADJUST(ADE9000_REG_AWATT,
num), so after masking the phase bits, tmp holds
ADE9000_REG_AWATT (0x210), which never matches 0x00F.

As a result, writing IIO_CHAN_INFO_CALIBBIAS for IIO_POWER always
falls through to the default case and returns -EINVAL, making
active power offset calibration silently broken.

Fix this by matching against ADE9000_REG_AWATT instead, which is
the actual base address stored in chan->address for watt channels.

Reference:ADE9000 datasheet (Rev. B), AWATTOS is the offset correction
register at 0x00F (p. 44), while AWATT is the total active power
register at 0x210 (p. 48).

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ade9000.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1123,7 +1123,7 @@ static int ade9000_write_raw(struct iio_
 			tmp &= ~ADE9000_PHASE_C_POS_BIT;
 
 			switch (tmp) {
-			case ADE9000_REG_AWATTOS:
+			case ADE9000_REG_AWATT:
 				return regmap_write(st->regmap,
 						    ADE9000_ADDR_ADJUST(ADE9000_REG_AWATTOS,
 									chan->channel), val);



