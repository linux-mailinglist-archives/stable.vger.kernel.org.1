Return-Path: <stable+bounces-230927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPfkHrMpyWnTvQUAu9opvQ
	(envelope-from <stable+bounces-230927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:31:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FDD352409
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5256C3016C92
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4904C375F69;
	Sun, 29 Mar 2026 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Om2bCXwA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8E376469
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790943; cv=none; b=itnaqWLiWgT6IFyLem9oDXO19c21epQYzPXCPDXzS5YOPTgy4xkuPG6Eg6RhjFRIZIH0MixWfupZ5Cgc/LJdlXuVxLU9KoUBb3yOMXc++azOjtfobzYmLP/bDlnxiTvSVd+ZWJ1pM6d3k9NES8N6WHx1FTacpOZ9Qe+eT34LK3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790943; c=relaxed/simple;
	bh=4I3X/I1/pgY0PpqpgOm9SnmQJSqa2QqachmldiVbWWU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=uTrhzV5XhwGjmuk58h8zQOXa2W5mkbinyCdUAyEaZGUSFP+kyGU+Na/QdyJfzMJdt0cMidkVXmhETiuvhCNIK+9H3waoir/Ma03krEAsV5W6VURwC32FtFIs2gmRdUeZNuMZL/yGl0wY5O2ZUqRyITzOL3/1WfzpuZLiWe/C7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Om2bCXwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A54C116C6;
	Sun, 29 Mar 2026 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790942;
	bh=4I3X/I1/pgY0PpqpgOm9SnmQJSqa2QqachmldiVbWWU=;
	h=Subject:To:From:Date:From;
	b=Om2bCXwAgZPeH63NDkrBnPXFVxma/LfLlKH7uOg66BjkhiuhM0NGMBQzFoXOOY/HU
	 zOrQyCUU2cNDZ9gDtwifs3yI2+YnlwLKT9VHCMtHyQ9MRevUhtVQG99LTPvPe44ggx
	 qaqRPsT10SdxjpBk/a+hcuwtUxpA8Xw0a/HFW/NQ=
Subject: patch "iio: dac: ad5770r: fix error return in ad5770r_read_raw()" added to char-misc-linus
To: antoniu.miclaus@analog.com,Jonathan.Cameron@huawei.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 15:28:16 +0200
Message-ID: <2026032916-showing-salvaging-48f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-230927-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: 12FDD352409
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: dac: ad5770r: fix error return in ad5770r_read_raw()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From c354521708175d776d896f8bdae44b18711eccb6 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Thu, 12 Mar 2026 13:20:24 +0200
Subject: iio: dac: ad5770r: fix error return in ad5770r_read_raw()

Return the error code from regmap_bulk_read() instead of 0 so
that I/O failures are properly propagated.

Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad5770r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index cd47cb1c685c..6027e8d88b27 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -322,7 +322,7 @@ static int ad5770r_read_raw(struct iio_dev *indio_dev,
 				       chan->address,
 				       st->transf_buf, 2);
 		if (ret)
-			return 0;
+			return ret;
 
 		buf16 = get_unaligned_le16(st->transf_buf);
 		*val = buf16 >> 2;
-- 
2.53.0



