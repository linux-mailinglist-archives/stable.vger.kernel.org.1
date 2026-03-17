Return-Path: <stable+bounces-226126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPcZOaiCuWmxHAIAu9opvQ
	(envelope-from <stable+bounces-226126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:34:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6D2AE123
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E3E230FCCBC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171E136C5AB;
	Tue, 17 Mar 2026 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="ktc0yVAZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BB364032
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765022; cv=none; b=u6RymhFa0BnAMLXr8fsdc35uW58DziUi35myp/0yy+5GIYLlvAZqo+3KfYgwH1IpCaTQgp0pwwL99WPNtGjChjVJlRNsMq9tKfCQkqUNNu5JGx05KQoI+mlAavjEK+jnsJTUoK4yN37TADQ5I4licb75vzGrfWsl5vsJT9bBqTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765022; c=relaxed/simple;
	bh=Z2aWRPXkpx5ekMjctDdvr6UjzEasOAIPeaUcWrJN5NE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tVdzxX+Ai5lk7vo67c54EQtq1lYXnfmRj6Ag4PvyIZn2dujAplXfWJHSj1WI6crZb0zXUI+03XhutCTDERupFX+DN4QNP+AIDex6kpevhUo1hRFEcb5QNnZoAP8vEev+JnJkp0JK7i0rOdKk9Aqx/J4j8LPNXBAvqUhsTJFsemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=ktc0yVAZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b6d9c981so38238f8f.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773765019; x=1774369819; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WmHFmvkb2jv5zXCrgScZkvhMZRgK+EweiMKeOhatkmU=;
        b=ktc0yVAZB5YLYllfX8Ti5ytlItzFZH3MHNZp6lkagFJSJURFueeQYA960+klEt2GHH
         w201DToJBEINWirkK3kflSzHAZ6f2OdfUnbEibcoP+FoZJNP7ciwrLNeLRp3S98noRzz
         4rwNg8ar19moiQBTlvfsbp7Dv4DdtA+VWfs0SR/OISbMgVNrNtqio4O4Y2a9MzfgjRzQ
         Z/ymN16tccgfTWJYcomcExhtUYZAnxeITiW0pyInO5g1EXLIpJEQJ/PufM/G5rpCUR9q
         4oqyzkAiwXnWNSZqchymy2ayCoieTAPORXUnV70nYVKVKSB/Z8Z7lzk39Ybp2LwdhniU
         KPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773765019; x=1774369819;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmHFmvkb2jv5zXCrgScZkvhMZRgK+EweiMKeOhatkmU=;
        b=fjrLyBsmuc+KReXGHa7IvzoLxrUP1TNg+o9SPG+9AG3KsysrpHKpnvart9JkVCQzYl
         O5KVkTAn5Z0IkXbS6CKSmSa8xNu/vheb5xOk6wqYkXXKgx9llc0oDnOewJYORy2qehpw
         Uw7EuL/0u1YLDlqx9GdYk/xne5EncOw+ZrhsIkmH+19nx11ANPJWGk6rqj7Iw9zzAlh4
         YQ0fhGcuEPoJXdVvM2cqkPj5PpjakQ+IJ0ZWlP0SVBJIqLvcCi2kNDgxwAWxQ8qfx+ga
         C4Nw5KRBvugGhxUJxsPbmYiftYX+ft2eDJIG/RcG2wl1l+eaC/B98XtYA0f0BOwRbCJs
         nXew==
X-Forwarded-Encrypted: i=1; AJvYcCUqjnck1Gjqp3dJ6UrrSEGGlWNI8ho/787Gz1FbH4ksV/thPc6Us1sfnmQkGqGzCZvBEltUWmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJL6YR1HUSGcI4yBXXC56jQFN88NSgjFhbV8txhtysLp3MoFf
	AkLn8wlNxTi+NL14dBu1iB3FiEBFSnOKf4C82X4lQmH/O9y3NVgyHuz/l8E29IduVwU=
X-Gm-Gg: ATEYQzzei418JPQa5vgo9PZrgRVP9xnesXoU+nJ6Iym44wgjHFsCwQycKjwT2nDldUB
	vBTIbjQ9liXOfl92kTHRJ9V1Wf3Bg9ldUB/tvRh7N9H10L3ko1lqR2XzMjVq1stx5ZGwSiMxFmf
	aqC9FK1OjjiMGFMaLgLsantRAph7veu7sbslxdrdizHt0repOJH4u86zLn1fVj4AKFIKa5LFuRl
	20oTd8wAFX30yT32Ton6NfL11kkTZaWoBE9GafDCOeefBRqWcCjPz5kir181Lv45tWhT8Q3nlLj
	jC7gzuGYcnmOgFyrp7fbK47EzKohnT7hF2ptbGzU8mVPX5VOISWpmo4CLTcJ9N5xjnHEzyxOMek
	CK07Yh4tvCl1mqZZShhXMB4e5XDPUZVZFjrUGEGD2dngGU+PsfqL6ICjM2z0PWIAd0e65BXNOka
	fUYHK1JgL4Evvr7zNd1UMIWTc5mfUjwtcvJ90eoqaJV1INxvZlKs1bnQ0RRjIR7DgNoFCZlpu2l
	XVCnw==
X-Received: by 2002:a05:6000:2c05:b0:435:96a1:ee4d with SMTP id ffacd0b85a97d-43b51956ccbmr485274f8f.14.1773765019140;
        Tue, 17 Mar 2026 09:30:19 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852a64sm552772f8f.14.2026.03.17.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 09:30:18 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 17 Mar 2026 20:30:15 +0400
Subject: [PATCH v2] usb: typec: fusb302: Switch to threaded IRQ handler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-fusb302-irq-v2-1-dbabd5c5c961@flipper.net>
X-B4-Tracking: v=1; b=H4sIAJaBuWkC/23Myw7CIBCF4VdpZu0YBixUV76H6cLLYCcxLUIlm
 oZ3F7t2+Z/kfAskjsIJDs0CkbMkmcYaetPAdTiPd0a51QattFWGCP0rXYzSKPGJhmxnds62nSO
 ojxDZy3vVTn3tQdI8xc+KZ/qt/51MSOjYkWqdslbvj/4hIXDcjjxDX0r5Atr+PNuoAAAA
X-Change-ID: 20260311-fusb302-irq-316834765871
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Hans de Goede <hansg@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Z2aWRPXkpx5ekMjctDdvr6UjzEasOAIPeaUcWrJN5NE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTubJxZzZxZ+fqA8fb1nmd8EkROvp32ZsXEW18/ObOYu
 X0S/hbxs2MiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTUMdYxYuDiFICpFjNh+Gc+5cnEVScSDc5P/RHmEJDg9FyiVuZ0U83K4PrtDcus6mwZ/tm3aeb
 Z+fVEzTRl3rK+oexb8pxLiX96UsrkziUU/t4QxAAA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[flipper.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226126-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FE6D2AE123
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

FUSB302 fails to probe with -EINVAL if its interrupt line is connected via
an I2C GPIO expander, such as TI TCA6416.

Switch the interrupt handler to a threaded one, which also works behind
such GPIO expanders.

Cc: stable@vger.kernel.org
Fixes: 309b6341d557 ("usb: typec: fusb302: Revert incorrect threaded irq fix")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Re-added the IRQF_ONESHOT flag to the request_threaded_irq() call
  (thanks Hans de Goede and Sebastian Andrzej Siewior)
- Link to v1: https://lore.kernel.org/r/20260311-fusb302-irq-v1-1-7e7105706629@flipper.net
---
 drivers/usb/typec/tcpm/fusb302.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index ce7069fb4be6..889c4c29c1b8 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1764,8 +1764,9 @@ static int fusb302_probe(struct i2c_client *client)
 		goto destroy_workqueue;
 	}
 
-	ret = request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
-			  IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
+	ret = request_threaded_irq(chip->gpio_int_n_irq, NULL, fusb302_irq_intn,
+				   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+				   "fsc_interrupt_int_n", chip);
 	if (ret < 0) {
 		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
 		goto tcpm_unregister_port;

---
base-commit: 95c541ddfb0815a0ea8477af778bb13bb075079a
change-id: 20260311-fusb302-irq-316834765871

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>


