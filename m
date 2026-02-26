Return-Path: <stable+bounces-219876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBbaENXcoGmMngQAu9opvQ
	(envelope-from <stable+bounces-219876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:52:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ABF1B10AD
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EB5F301689C
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 23:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33E02FA0DB;
	Thu, 26 Feb 2026 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bB1JJ63w"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E78332ECB
	for <Stable@vger.kernel.org>; Thu, 26 Feb 2026 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149968; cv=none; b=bJbIZw3QD36nK2Xhdy62op9aJXnMTGj49y5hIv59vELIlxZGQOag7/HziucGNb7ZLgWE+iyMUWdmZKn9ANPVu69IlCBo07zOH7Sow/a/htr/+SJ7R0K0Rp0CqmREfUNhgCX7e5b7D5iL1WV+7/h9MKNltQuGfDQOgOCz/Lg3OPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149968; c=relaxed/simple;
	bh=WKntww0wwnoI2XInjmQA1Sb1kmI6MeQiOAoJx6QdzsU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Q/X7oAPdIMK2BT8YND4FMgoIkikJ0hmMFjxswceMKrjBQ9MqOmnFgFqn/TwJ5X+reUd5XVwUjT4Y2SVEMh1OXYdhNr+BPuiibbDv4XbPLDr1cKr4AQ7xXFgVWq4V4yjhOw8KIS9wZ5Py/l5bnRiZgm92JtQSQ7ijQQIXlj4wVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bB1JJ63w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AD3C19423;
	Thu, 26 Feb 2026 23:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772149968;
	bh=WKntww0wwnoI2XInjmQA1Sb1kmI6MeQiOAoJx6QdzsU=;
	h=Subject:To:From:Date:From;
	b=bB1JJ63w1riPs6gHUBYcaaakEmZg+fckfpi4WKWUOihBT2jEpX+rcwFXM1Q34+MvZ
	 RrLPnTIAuqI+hc/zqLKIxeVLXfDO0xyFY3fXNcvMlVoXVnWsAPb/FfXOEcCzlnaJdP
	 OMEJNfQyNvFF1U+Ls5nvQSGC4eDhE7QgNj4IjZNQ=
Subject: patch "iio: proximity: hx9023s: Protect against division by zero in" added to char-misc-linus
To: yasin.lee.x@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 26 Feb 2026 15:52:35 -0800
Message-ID: <2026022635-scrap-scouts-52e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219876-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D3ABF1B10AD
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: proximity: hx9023s: Protect against division by zero in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From a318cfc0853706f1d6ce682dba660bc455d674ef Mon Sep 17 00:00:00 2001
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Fri, 13 Feb 2026 23:14:44 +0800
Subject: iio: proximity: hx9023s: Protect against division by zero in
 set_samp_freq

Avoid division by zero when sampling frequency is unspecified.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/hx9023s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index ad839db6b326..17e00ee2b6f8 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -719,6 +719,9 @@ static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int val2)
 	struct device *dev = regmap_get_device(data->regmap);
 	unsigned int i, period_ms;
 
+	if (!val && !val2)
+		return -EINVAL;
+
 	period_ms = div_u64(NANO, (val * MEGA + val2));
 
 	for (i = 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
-- 
2.53.0



