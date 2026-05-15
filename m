Return-Path: <stable+bounces-247685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC5kJ5IJB2r5qwIAu9opvQ
	(envelope-from <stable+bounces-247685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:54:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F10654EDAB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 428F130901DC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B47646AEE0;
	Fri, 15 May 2026 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zGmYl/IW"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74743CEE9
	for <Stable@vger.kernel.org>; Fri, 15 May 2026 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845561; cv=none; b=Gq2Os+44CuznMslmubqwmGy8SPgN3LdRgZ9j+YVTUPewWlnqbYU69AjU1hOvXwnpo2b0Pr7ocRXX9WEu+JjlIxuhuv+xTIPaJhP4x1w+uiDm+aoZ66NyopUhl3by/T3AflG5yriQyAPcpehTsl5+kRaT3TDEsPKkumTp3Sxb6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845561; c=relaxed/simple;
	bh=orp8fQYkrMfIo9Vg5T8aVOCQl03OkiQ3j1aoIx/TPXA=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Hp2iDE6uxsK4LguHIEWhRQNJcjaX2xd+eScMonl1VgKxLLELxG3fBfBTJzFHl756xiVcYBzqvajDt7W+nItVEF9x97U+kJpEOtJQq/oPlb1VgXsH3ExyF+NbjzBdenAsJqpABmTH4cWN57PHnl5w+oG4nmYl76C8awnejhiCodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zGmYl/IW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96848C2BCB0;
	Fri, 15 May 2026 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845560;
	bh=orp8fQYkrMfIo9Vg5T8aVOCQl03OkiQ3j1aoIx/TPXA=;
	h=Subject:To:From:Date:From;
	b=zGmYl/IWhvAQAI7U6LboQQpfykifbzcf/cHTp7C1z8VJLrjINN0rJx2iaYlOSbbEl
	 NRaJx/78jCdopz13v8juqsxAv/FBOzHUohtpH2ZgJchRadjCfGAOsaQT+rHmHLi2z9
	 GTDbANjAqFagrXd0ELvYmo2iVqNQZSSIUJEifeMg=
Subject: patch "iio: Fix iio_multiply_value use in iio_read_channel_processed_scale" added to char-misc-linus
To: clamor95@gmail.com,Stable@vger.kernel.org,jic23@kernel.org,johannes.goede@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 13:45:55 +0200
Message-ID: <2026051555-childlike-reuse-580b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F10654EDAB
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
	TAGGED_FROM(0.00)[bounces-247685-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,oss.qualcomm.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: Fix iio_multiply_value use in iio_read_channel_processed_scale

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From bb21ee31f5753a7972148798fd7dfb841dd33bdb Mon Sep 17 00:00:00 2001
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 16 Apr 2026 14:14:42 +0300
Subject: iio: Fix iio_multiply_value use in iio_read_channel_processed_scale

The function iio_multiply_value returns IIO_VAL_INT (1) on success or a
negative error number on failure, while iio_read_channel_processed_scale
should return an error code or 0. This creates a situation where the
expected result is treated as an error. Fix this by checking the
iio_multiply_value result separately, instead of passing it as a return
value.

Fixes: 05f958d003c9 ("iio: Improve iio_read_channel_processed_scale() precision")
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/inkern.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 0df0ab3de270..9ce20cb05a9b 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -738,7 +738,11 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 		if (ret < 0)
 			return ret;
 
-		return iio_multiply_value(val, scale, ret, pval, pval2);
+		ret = iio_multiply_value(val, scale, ret, pval, pval2);
+		if (ret < 0)
+			return ret;
+
+		return 0;
 	} else {
 		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 		if (ret < 0)
-- 
2.54.0



