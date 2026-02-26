Return-Path: <stable+bounces-219878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD7IBNzcoGmMngQAu9opvQ
	(envelope-from <stable+bounces-219878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:53:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A251B10D9
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 441CC304D147
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 23:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E00233439D;
	Thu, 26 Feb 2026 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vp8pI9rl"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA22332EA0
	for <Stable@vger.kernel.org>; Thu, 26 Feb 2026 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149969; cv=none; b=ia0J88FgXP/E0sS3kLscJqK0h+Dur6yPbTBjXwO8APvFVR5FkVGx312Pbg28XRshMe1x2ZLl5cfr8t1vQHlLhVvfJ6mHsdnaXfeFPwiLKGYD22Csi8eUTSh+vQrjCsxzoXckUsauhLEfe7zSQJospJcy5mtJqWggkZWuMo4QodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149969; c=relaxed/simple;
	bh=SanP2XuHsxfKFZIhlKlDTCWxGQWQx1BzZU/w3kVD80g=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=OocxX5Uy9lgUaNe7PjtHpcH8TyIr6a+lnblmEmso2YdOnmG310vfYpPbAkdBIgfRJGnTbVUVSs32mlGMU2okGCmdhWYgeHHVzl9uw6OVEhgLrpbxV4d1W35kldNPak2dgklUyP7fenlnBAtQLoINdv16pdu+Osty7u/siRJ6gtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vp8pI9rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F2CC116C6;
	Thu, 26 Feb 2026 23:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772149969;
	bh=SanP2XuHsxfKFZIhlKlDTCWxGQWQx1BzZU/w3kVD80g=;
	h=Subject:To:From:Date:From;
	b=Vp8pI9rl6UVrJLif3dE93XeFQODlNH1vl/ahHwQllH5xAZh3CjqdTBj9GhAYCadDD
	 yFuubH0H3BuJ+xtQDIiD2A029BuCqASFBsLDrNmS/D/VqWtJmjLVJSm4laMHrtMWeb
	 DOBZvBclFWwH1I9JOvnxmjlN4uOxT9EQa0aUb99s=
Subject: patch "iio: chemical: sps30_i2c: fix buffer size in sps30_i2c_read_meas()" added to char-misc-linus
To: antoniu.miclaus@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,tduszyns@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 26 Feb 2026 15:52:35 -0800
Message-ID: <2026022635-canon-engulf-ebca@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219878-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,huawei.com,vger.kernel.org,intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A2A251B10D9
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: chemical: sps30_i2c: fix buffer size in sps30_i2c_read_meas()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 216345f98cae7fcc84f49728c67478ac00321c87 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Thu, 12 Feb 2026 14:46:07 +0200
Subject: iio: chemical: sps30_i2c: fix buffer size in sps30_i2c_read_meas()

sizeof(num) evaluates to sizeof(size_t) (8 bytes on 64-bit) instead
of the intended __be32 element size (4 bytes). Use sizeof(*meas) to
correctly match the buffer element type.

Fixes: 8f3f13085278 ("iio: sps30: separate core and interface specific code")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Acked-by: Tomasz Duszynski <tduszyns@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/sps30_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30_i2c.c
index f692c089d17b..c92f04990c34 100644
--- a/drivers/iio/chemical/sps30_i2c.c
+++ b/drivers/iio/chemical/sps30_i2c.c
@@ -171,7 +171,7 @@ static int sps30_i2c_read_meas(struct sps30_state *state, __be32 *meas, size_t n
 	if (!sps30_i2c_meas_ready(state))
 		return -ETIMEDOUT;
 
-	return sps30_i2c_command(state, SPS30_I2C_READ_MEAS, NULL, 0, meas, sizeof(num) * num);
+	return sps30_i2c_command(state, SPS30_I2C_READ_MEAS, NULL, 0, meas, sizeof(*meas) * num);
 }
 
 static int sps30_i2c_clean_fan(struct sps30_state *state)
-- 
2.53.0



