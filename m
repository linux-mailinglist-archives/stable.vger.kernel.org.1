Return-Path: <stable+bounces-247704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLdwBZgNB2p0rAIAu9opvQ
	(envelope-from <stable+bounces-247704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:12:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3E54F39F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81BE930E0331
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4B347DD6F;
	Fri, 15 May 2026 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v11xNnNS"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5563947DD5E
	for <Stable@vger.kernel.org>; Fri, 15 May 2026 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845629; cv=none; b=QCuhKaU6gfvvwtpnuFXNPt5RznopOQI4E76qcxBn9vodqQ0QYGzMzKEMIO5lxZbUkITvkjtduKW/hGVMluw2hGqOdh0pMop5qTHGTrTCIGSjFW0X6hyxLXoWX5buTxxB+0kxUrGoFxk57IeBjXLnvqJOBVyiRBagnp7tR79Mx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845629; c=relaxed/simple;
	bh=E5/SHtOrSkZuvflSvoJHDUQoeDjgkBGyGj5uzkPWbzY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=pQbIl2084VtH5HMqyj2kE+FZBbvMQOEtXaEMD2uEVhfV/UpVtSlJIDW57dJBRGv+5ers7FNLIWHzFrn5Xi7d2ytitfhRub8oIZfMGaGa5tJrpzzVagRYI6vzLa+hO1bzgrOnhU6MDNOwI4X1fQM2Bky5pNndT74WJ2E8b7IdW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v11xNnNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43584C2BCB0;
	Fri, 15 May 2026 11:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845628;
	bh=E5/SHtOrSkZuvflSvoJHDUQoeDjgkBGyGj5uzkPWbzY=;
	h=Subject:To:From:Date:From;
	b=v11xNnNSWfcRDj84V0IQIdv1T6oPrDvtsKojjDxrB5sHbNgxYL9LfWfK8/IYNu3du
	 /BsyxPe/fRlerrC0DDMbZsD9YzgHgBmyEArldPmW9V1kVJj5/d4h/IohGVCXUICtEo
	 z1Q2xFKvRYh7aw7f9fLVazT+LKGi1SlE/8X772u0=
Subject: patch "iio: adc: viperboard: Fix error handling in vprbrd_iio_read_raw" added to char-misc-linus
To: salah.triki@gmail.com,Stable@vger.kernel.org,jic23@kernel.org,joshua.crofts1@gmail.com,m32285159@gmail.com,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 13:46:02 +0200
Message-ID: <2026051502-busload-paramedic-5369@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E0D3E54F39F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247704-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,analog.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: adc: viperboard: Fix error handling in vprbrd_iio_read_raw

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 422b5bbf333f75fb486855ad0eedc23cf21f3277 Mon Sep 17 00:00:00 2001
From: Salah Triki <salah.triki@gmail.com>
Date: Thu, 7 May 2026 20:07:51 +0100
Subject: iio: adc: viperboard: Fix error handling in vprbrd_iio_read_raw
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver proceeds to the reception phase even if the preceding
transmission fails.

This uses a goto error label for an early bail out and ensures the mutex is
properly unlocked in case of failure.

Fixes: ffd8a6e7a778 ("iio: adc: Add viperboard adc driver")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/viperboard_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index 9bb0b83c8f67..6efe1c618ef7 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -70,8 +70,10 @@ static int vprbrd_iio_read_raw(struct iio_dev *iio_dev,
 			VPRBRD_USB_TYPE_OUT, 0x0000, 0x0000, admsg,
 			sizeof(struct vprbrd_adc_msg), VPRBRD_USB_TIMEOUT_MS);
 		if (ret != sizeof(struct vprbrd_adc_msg)) {
-			dev_err(&iio_dev->dev, "usb send error on adc read\n");
+			mutex_unlock(&vb->lock);
 			error = -EREMOTEIO;
+			dev_err(&iio_dev->dev, "usb send error on adc read\n");
+			goto error;
 		}
 
 		ret = usb_control_msg(vb->usb_dev,
-- 
2.54.0



