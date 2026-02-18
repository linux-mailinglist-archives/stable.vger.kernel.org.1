Return-Path: <stable+bounces-217320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMuuLVYflmldagIAu9opvQ
	(envelope-from <stable+bounces-217320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 21:21:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242AE159669
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 21:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 573DE302EE8E
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 20:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B13348477;
	Wed, 18 Feb 2026 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATEfDOCQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD332DF6F6
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771446083; cv=none; b=GVVPQvbgiL01h5aBQuHRI9tojXsnPQYXelrfBG4Idbr8SiwP4rrlOfdrj0uZic+GWRdmSvqBenUmSRd41A5CuCqrxRK28T0D2Y0bFoIoEZJFhlYatGZLdIsfQzDFEPjh/X4FTP6hL6sONtusIUh+yfPbuuAT0hIFJ9/uFIjs478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771446083; c=relaxed/simple;
	bh=stUEdsfxtc4bnSAii8le9q2fiTOR/peX46/VHKirbPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pqar4ipq54jamGqTzy+ozswUvkpslxKjii/RzCrNW/3ag1PY1W7KEuTL8dB/1WVBJRN14fG748tvdojBvC4BSDkVrcvRYNzyiX3nA/1VGUeh6Bko+RCsOZNgrln4AzrfY9oYRWBCnwFO72wkjpmdIILsMDpwub+AD7LOUZd9CrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATEfDOCQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48374014a77so2300195e9.3
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 12:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771446080; x=1772050880; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WkBH3Pq8yF91vpQwDAd3nKXebRuZ5X1TEOAqkn6IWvw=;
        b=ATEfDOCQKyHY2Ckd+ikF6BFAXA7476mJOXiwv+Xgb4fDW0AU0eBSoJEWgxT+dci7+f
         oMAPj8Blosr4c06Ez9SIr7SloAVHnUe3ilxWYs5NFP9wZbnvAlrZDIlBq2jVAOci9zp5
         Cvknbu5rZs7C58YAMwD+hs7dEgbU7lkQgP1QsDkrqPv7abbIChiEMvH+tD7HcOt1hh17
         cXGV0Q8PmphfHoN1POLOiL/9+d8VXxDiwTcSR0kYH8S82vrq1gnJ3EcWQperbYc7KJKp
         g7GeKRgbFhWsSRwB6SBXB4cMQVmCZOHZsUVQHcAWRXK5YO+caSnzZN0jBi0gXMHY9Mdp
         ZaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771446080; x=1772050880;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkBH3Pq8yF91vpQwDAd3nKXebRuZ5X1TEOAqkn6IWvw=;
        b=nUHOBDqbRv0qS6PzhxenU1yPoIvFU1JOU3YhdaWdwlOOEFm/Y130aHX75QFYlABRNy
         GHd9MIgf7Uk9cq48AQrdrj7u89Axd5Cc8A+zI1cb3L2uWL4IPkrX5YXxKri8uT9JuMss
         d6PjYU0tgy+Qm1yAOl9FOTXk02a3P3cf9aSrF9AxYXaS8CjCk/4ReI0ZKjt5LSq3M7tv
         0Ld8L63DjJWxR+W4ruM8m9Sz1F5meoh8Eu0I2SmDRiJ4evqRXj9XsCrb7uuIGGtjOjsz
         jMRW7TFrLtLsNTm/xr7CLkyQNBpnqTp7rRh5JmQEYFasGwlIRZdOmpaU/XzCLLQjIArP
         ANdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6fzB4LhcG8T5kBW8nBeohg8bI4dfP0tr2KOpbH1rq6Bh4I8fr7TBsMB95OyLQ4553DXSuNx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Egli6bTkTDiI8Z+l2KH+ayDonBcZKd9CX0MT6TpH3R4Kt/Pf
	/Ti6nW4VelcSuGuruWldjYef4gHCqWQuL0EM1AkiFGDbdgl+c4ldGX7pxmmlGg==
X-Gm-Gg: AZuq6aIHk59Bt99idNqqNT+Q4rMhxjYwRC8pbHaEFtkoKd18oAuGUtBFelAYhO55jfO
	CPnAsl3UtVrI//lth14f0x4Lw+Ykbd/VZOBLElTL48iLOSGW1ZQoEInrA4rIwpHooOfeyR9f6cp
	qnF3mnOXQ4NQ6sA/3PaWnWOqKcbHVGPKGcdSVaFQX1ttbJys78aRUzVunbrSn6moawBz93+h9eB
	0VcV7ckw7iHFYgcj1+N5gqXfiXCS17qWGyKF7AjJ0+1fRbZpHuypRw+RDV1z5zeZqyw01XwFvQl
	5B7RtLSQQrVvQydWWNn7+a6R2ubOPY8ZVIbF04gjFI+cYtbqbboWjhJi/b8MeF4GqYMNu/5Xsf2
	F4mPkgxyq5c9PU4SW7Fb07NdbppQ13q5LvCtZFYK/jpVg8pwE4awJ2LUZKmjlQalfn+Ygq+Zxm3
	+YWzrZytQ1zonMwa8ChU7aUz3WtE0jqbWe3Jji9v6IVlp1219jngLH
X-Received: by 2002:a05:600c:1986:b0:483:71f9:37ef with SMTP id 5b1f17b1804b1-483739ff8f5mr330227005e9.8.1771446079805;
        Wed, 18 Feb 2026 12:21:19 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-439567aad3csm9911973f8f.36.2026.02.18.12.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:21:19 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 18 Feb 2026 21:21:07 +0100
Subject: [PATCH] usb: core: don't power off roothub PHYs if phy_set_mode()
 fails
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-usb-phy-poweroff-fix-v1-1-66e6831e860e@gmail.com>
X-B4-Tracking: v=1; b=H4sIADIflmkC/x2MywqAIBAAfyX23EJaSfQr0UFtzb2kKL2I/j3pO
 AMzD2RKTBnG6oFEB2cOWwFRV2C93lZCXgqDbKRqpBhwzwajvzGGk1JwDh1faNu+M8po0UkLJY2
 Jiv630/y+H+tA0KBmAAAA
X-Change-ID: 20260218-usb-phy-poweroff-fix-c354b6ba142c
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-217320-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j4g8y7@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 242AE159669
X-Rspamd-Action: no action

Remove the error path from the usb_phy_roothub_set_mode() function.
The code is clearly wrong, because phy_set_mode() calls can't be
balanced with phy_power_off() calls.

Additionally, the usb_phy_roothub_set_mode() function is called only
from usb_add_hcd() before it powers on the PHYs, so powering off those
makes no sense anyway.

Presumably, the code is copy-pasted from the phy_power_on() function
without adjusting the error handling.

Cc: stable@vger.kernel.org # v5.1+
Fixes: b97a31348379 ("usb: core: comply to PHY framework")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/usb/core/phy.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index faa20054ad5a1c3f704cb9f70b5049cefdab804e..4bba1c2757406a35bf19eb7984a2807212374d18 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -200,16 +200,10 @@ int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
 	list_for_each_entry(roothub_entry, head, list) {
 		err = phy_set_mode(roothub_entry->phy, mode);
 		if (err)
-			goto err_out;
+			return err;
 	}
 
 	return 0;
-
-err_out:
-	list_for_each_entry_continue_reverse(roothub_entry, head, list)
-		phy_power_off(roothub_entry->phy);
-
-	return err;
 }
 EXPORT_SYMBOL_GPL(usb_phy_roothub_set_mode);
 

---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260218-usb-phy-poweroff-fix-c354b6ba142c

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


