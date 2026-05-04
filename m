Return-Path: <stable+bounces-242978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFF6G0pw+GkYuwIAu9opvQ
	(envelope-from <stable+bounces-242978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:09:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D39D04BB74E
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62B9030157E0
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00F8392C5A;
	Mon,  4 May 2026 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feK+iruv"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC88392C4F
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889338; cv=none; b=MoJbCF6E5pQ9ulqXE8g9kpLJWjqeyloor+VGqcSPSK4Gxm49XQo469h9pi1/6pyJa0u6Pvz31qZIWUYAd7xxFE2XU46v5xPvd1frGLJZVOl47h24x4fp7gTpbIygFXnK74jBQxHy3JzaNRJhik4XPG/FkkNlGl+ybx12/34d43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889338; c=relaxed/simple;
	bh=uzVYR2oxORfswsKO5073AqMtFJIBGpVKkfVCVIKVeRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON3+7jCKfSIguoOy/S+IkKlmp3bXuNx6T24Em31x63D84Sl7AReHEAbGS8aw4QVEs3Zo33AARJq37o3SjO0IA/nfy0DMFZZnTXmMBX5nhEoujK4Y8jUijs3gYau1a8AVUJ44YF+d4vQ6XFbG5IBuwUH3Pe4yr3NyyfcVFvZUw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feK+iruv; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3878de20527so31286561fa.3
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889332; x=1778494132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ejlKc5ArUlrjZTG0qqBOiFFqj7qKQRkSb3mwVckWx0=;
        b=feK+iruvb0ALyN0MADYxSac4gGLl7iEq0HanQj2RruHck/yCuiTPXK283kX+4MgmTZ
         6zjO1Dmn+nyvuaFQ8XDxP2XMEMuLUnPBb4ZDhvyabmqr1JuGszN6AYw7ontpd/S+N7E7
         ce7tndGDrKu/89VbkIxc5/qpzzhmJ8tsN8yJ5zMFJ2V+m2BAqkKxC9Y9zPLsDQ79Okhs
         H3iIIRe1NRkiyjCXk4P+b2VUK4TZUNkdRAGOn66GHEA1yhp5Xe0TkMA/GIsJFe5qQx9M
         NLfwjRw1RaoAqadmgFdFOwj0JX23mvyG/E0jCgt95wHwO2swHFIoN0r6UVndWCLHlcf2
         Cb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889332; x=1778494132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ejlKc5ArUlrjZTG0qqBOiFFqj7qKQRkSb3mwVckWx0=;
        b=WIcqoA71BStFXO/VxgLZFrkWv8ZTs7wsyr+yyo4F1wnPE11S7/zmBouPmDp2mUF/eT
         9ECEwUkhJaVLItpgNdC5s5Tqv+yOP00Oeydv9rwnhGelTEKNn7DbbuvwVdmEARoAnqSN
         ltnHV0eRTPa7x23qdwDV11bDebxK56aW/YJ5xlGAF5rZ+KUMgBL+sVZkEQMXsbeDGdGE
         /wkS5ol4zaZ6WfRhj9HygOITyle2Fcpnt0SiskFdP0bM9sfrOIK9PO3pJZV7ibPqs+Uz
         8a4mvrkt1MmsO++Wt3DtWBNB7uPHV2gcYt+FcEacnd+29ecXqKFSVkL/BcrzdBJ74Kh7
         CE6g==
X-Forwarded-Encrypted: i=1; AFNElJ/iFnpTxSa4iBKLreRr1Pih0fN3nOBPS87mZcyAFCESYHv+5jnDCWjoKtpi0hJfvasqqjaFZTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsgs2mFmMAID0rFcfK8DvTa69cyrZ48Y1sQdptNmdZucBW0uqT
	3p+GoFUvrnTnPcK6pykFNIHDOsmnLU4yCTqebXCnQ7c1idxHcWHEQjHI
X-Gm-Gg: AeBDieuhEq1Jn2UIrhAOPpqHh7MAAB5qjo/R62/sDw2xjm2lorOB3N60gfDHsUDVp/i
	IDKBlMU336hkPLDRh+fkkV4Kto4I9WEscfKss/aVpoueNLEhLul5rCuuSlzqWyK8ho9mlKUca9Y
	v2sq5fOSfoFFie5xjnC5n+VKUJLkPkR6VDfkE+J3erCmXxMVru79+xj2a7YJOKhg1zyZVwKrmpq
	nWvovo43iMNfK0coeWRj8BEZzBlWvIA6eOqtCg76YZnquXyuXSLp/1yZIWmsMexaddfLP3g8QCs
	qETgifLOzP9oHi4dxPnEHhM4Ch8H8kcIcZ4PGyTPE04wL4Tg0C+Os0Mv7+E/PUjW4ZkIwu3EgAE
	VS5idiXRUD46ybLJz547+jzCxJ5J56Tkpuk0QgUJx05De5Dn7pzyHA2UQaBsS6G5nzOhxvMOi9i
	0NZD7PtOgl8ArT4gFlwBrt7rvZ6m1mr5e58Txh1YZuO43133ZPmVjpej6+iaT1mN6jynOX64s=
X-Received: by 2002:a05:6512:1250:b0:5a4:1198:5016 with SMTP id 2adb3069b0e04-5a862ec11a7mr2894531e87.11.1777889331651;
        Mon, 04 May 2026 03:08:51 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a86645ae7csm1979099e87.79.2026.05.04.03.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:08:51 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Vastargazing <vebohr@gmail.com>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Anatolij Gustschin <agust@denx.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/5] misc: eeprom: digsy_mtc: fix reference leak on failed device registration
Date: Mon,  4 May 2026 13:08:43 +0300
Message-ID: <a6778ce2d2e906e6f8a7c811e5faf4a8c56aff11.1777889235.git.vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777889235.git.vebohr@gmail.com>
References: <cover.1777889235.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D39D04BB74E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,arndb.de,linuxfoundation.org,denx.de,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-242978-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When platform_device_register() fails in digsy_mtc_eeprom_devices_init(),
the embedded struct device has already been initialized by
device_initialize() inside platform_device_register(). The failure path
cleans up the software node but returns the error without dropping the
device reference:

  digsy_mtc_eeprom_devices_init()
    -> platform_device_register(&digsy_mtc_eeprom)
       -> device_initialize(&digsy_mtc_eeprom.dev)   /* kref = 1 */
       -> platform_device_add(&digsy_mtc_eeprom)     /* fails */
    <- returns error, kref still 1, reference leaked

Per platform_device_register() kernel-doc:

  NOTE: _Never_ directly free @pdev after calling this function, even if
  it returned an error! Always use platform_device_put() to give up the
  reference initialised in this function instead.

Fix this by calling platform_device_put() in the error branch before
removing the software node.

Fixes: 469dded18391 ("misc/eeprom: add eeprom access driver for digsy_mtc board")
Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot (Claude Sonnet 4.5)
Signed-off-by: Vastargazing <vebohr@gmail.com>
---
 drivers/misc/eeprom/digsy_mtc_eeprom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/digsy_mtc_eeprom.c b/drivers/misc/eeprom/digsy_mtc_eeprom.c
index ee58f7ce5bfa..4ca3e567c49d 100644
--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -89,8 +89,10 @@ static int __init digsy_mtc_eeprom_devices_init(void)
 		return ret;
 
 	ret = platform_device_register(&digsy_mtc_eeprom);
-	if (ret)
+	if (ret) {
+		platform_device_put(&digsy_mtc_eeprom);
 		device_remove_software_node(&digsy_mtc_eeprom.dev);
+	}
 
 	return ret;
 }
-- 
2.51.0


