Return-Path: <stable+bounces-213082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CMUKjvTgGmFBwMAu9opvQ
	(envelope-from <stable+bounces-213082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:39:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A18BCF129
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85EA630C038F
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4037F0EA;
	Mon,  2 Feb 2026 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mG2ZBSUs"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE6937E2F9
	for <Stable@vger.kernel.org>; Mon,  2 Feb 2026 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049904; cv=none; b=Bw2EivRZwyWGbKUc8QqxByjF9ZPOgAkeH5vAhKsh5mIFVakNWGZKEiyqHr38lXiw59IiFRwAosmueJSUWm72N28u+vaH9+1peHsC02b3ZpzicT+ytejzMUBZRJWzOo8H7nPG53gMCdXI74Z4Nopk5yUTz41tXKcRtKwtYOFETEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049904; c=relaxed/simple;
	bh=vdu5ff6Vg0MKKvJ5TQi6seENDmXyyQ2krfOWlpRPQ0A=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=L3HpwwPRkmM3y8HpTEy0EffmC6umi/b+CTyfuYnupYeyg3htmcUCWoz0yvsEHcADMxZXUB//vneyQ6xZqh4aCWTpaVnyU86TvLR1+iuDh6sZG25C5PD4+jMqcaaS6xAaIJqN05r+LvY236l2PG1eXUVhGUTRii0v1fa9votN7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mG2ZBSUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B5FC116C6;
	Mon,  2 Feb 2026 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770049904;
	bh=vdu5ff6Vg0MKKvJ5TQi6seENDmXyyQ2krfOWlpRPQ0A=;
	h=Subject:To:From:Date:From;
	b=mG2ZBSUsybMybMaFObS3u7u/11R1j7U1VFGr62PFUvnBNWXoM43Z9mYewH5vcBZAj
	 h99Y+zXfgofyXfSs2penNube0I+15UeKPI6iAbaxeYY3aonwhcdfH36zCPknhQVsCx
	 7uGr4KnzucBVybCS7rZZoel3n7BgdJZo+QNc3DR4=
Subject: patch "iio: gyro: itg3200: Fix unchecked return value in read_raw" added to char-misc-next
To: antoniu.miclaus@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Feb 2026 17:15:00 +0100
Message-ID: <2026020200-hull-joyride-fd71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213082-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,analog.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 1A18BCF129
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: gyro: itg3200: Fix unchecked return value in read_raw

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From b79b24f578cdb2d657db23e5fafe82c7e6a36b72 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Thu, 29 Jan 2026 17:01:45 +0200
Subject: iio: gyro: itg3200: Fix unchecked return value in read_raw

The return value from itg3200_read_reg_s16() is stored in ret but
never checked. The function unconditionally returns IIO_VAL_INT,
ignoring potential I2C read failures. This causes garbage data to
be returned to userspace when the read fails, with no error reported.

Add proper error checking to propagate the failure to callers.

Fixes: 9dbf091da080 ("iio: gyro: Add itg3200")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/gyro/itg3200_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index cd8a2dae56cd..bfe95ec1abda 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -93,6 +93,8 @@ static int itg3200_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		reg = (u8)chan->address;
 		ret = itg3200_read_reg_s16(indio_dev, reg, val);
+		if (ret)
+			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-- 
2.52.0



