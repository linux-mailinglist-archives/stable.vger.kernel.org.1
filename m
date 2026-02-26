Return-Path: <stable+bounces-219875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENSiN9TcoGmMngQAu9opvQ
	(envelope-from <stable+bounces-219875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:52:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BC91B10AC
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 359E53025F60
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 23:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A680332EC9;
	Thu, 26 Feb 2026 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j1xoFcti"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3922FA0DB
	for <Stable@vger.kernel.org>; Thu, 26 Feb 2026 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149968; cv=none; b=Ubm/3iVNtXPh/CHH56dgoJK338c2RGKkZhD3lqaJdrKJfT+IzEUqJh9F39GCVbRf2v45a9zYUWks/gyRPAkvbEO2KplIfxVVOP9o79qXUckQHN6JYVcZoggi8PjOyvfssg6Q5pHGYC7af/V2byNGMe8dK9eqS2V0ltaEwW02Dbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149968; c=relaxed/simple;
	bh=FbN3dHrVgEJN2czV1f14zMUWqaHPAAJuCFlmkm7qn+k=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=QeagvSaBxNmd47p+BcbKtknxpK7TgaFSu49UMHzk6k17uzPf7ZSENEtMpOmxoM56j5/gL0gMwndZmIL4bezZZR5X5/OJNEnJsMviAg/JkpY3ukBTDyefwvaWp0xG646E8ENAxlH3wwUkB3DoesmJ3oKAizROokJhJelaqyLvF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j1xoFcti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E25FC116C6;
	Thu, 26 Feb 2026 23:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772149967;
	bh=FbN3dHrVgEJN2czV1f14zMUWqaHPAAJuCFlmkm7qn+k=;
	h=Subject:To:From:Date:From;
	b=j1xoFctiFGnJTBkG4mtr9jT9vWoZs1awYl+6HHMdWkF5hED9X/yyavadsuwI/QdW2
	 TCVHs9jalvpEQkz46b+Mea2A0FJeIU3/uBG/83YBDIidxS5VgucablWuVPr5gszb11
	 JVba6P1NuLhDiAyn/6H6e+5+vEVVhmURPLN6gT7c=
Subject: patch "iio: proximity: hx9023s: fix assignment order for __counted_by" added to char-misc-linus
To: yasin.lee.x@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 26 Feb 2026 15:52:35 -0800
Message-ID: <2026022635-mumble-monkhood-5f15@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219875-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63BC91B10AC
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: proximity: hx9023s: fix assignment order for __counted_by

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 585b90c0161ab77416fe3acdbdc55b978e33e16c Mon Sep 17 00:00:00 2001
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Fri, 13 Feb 2026 23:14:43 +0800
Subject: iio: proximity: hx9023s: fix assignment order for __counted_by

Initialize fw_size before copying firmware data into the flexible
array member to match the __counted_by() annotation. This fixes the
incorrect assignment order that triggers runtime safety checks.

Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/hx9023s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 2918dfc0df54..ad839db6b326 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1034,9 +1034,8 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
 	if (!bin)
 		return -ENOMEM;
 
-	memcpy(bin->data, fw->data, fw->size);
-
 	bin->fw_size = fw->size;
+	memcpy(bin->data, fw->data, bin->fw_size);
 	bin->fw_ver = bin->data[FW_VER_OFFSET];
 	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
 
-- 
2.53.0



