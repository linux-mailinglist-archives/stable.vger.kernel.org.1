Return-Path: <stable+bounces-76730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AEF97C573
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 09:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D0E1C230DD
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 07:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460C81990C3;
	Thu, 19 Sep 2024 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjYmtvcS"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850B9199247
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732701; cv=none; b=YL9WawEH0EPTgoMNCvcKY/oqayrPDf5hzDURyNd8W/60LUWBlmRpPoL1xUSOioT48BHE/H33gl2OXOZy7ow4DJmTNkCV4ovjM6r02B2N9/gIL8ONBC3CQQiIJyyNS9Mb6s6MRpyKC0dr8Qa2uUtMqorATJ71jmYX8XIYEtzeCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732701; c=relaxed/simple;
	bh=WciClgTHJkLxD4j92bv2MUEd3DG3FNExk2qmnPfm9+U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h61I7xEI9NH8kcYaw2zDCjg3YnfnqE1fL4VgP/XJ/CjORYqhwSd9m3mPni/dGZMTxNbjV7MpNa/oRhy6xDIc9heFzD1tXbIF2kPjg8SR8ocZInWOeHbuk73nQXexhFK7DLvcgP8IeUuQxrJ8UtYv/IqVMvh7EAysBzwVe3/w/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjYmtvcS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so9744067b3.3
        for <stable@vger.kernel.org>; Thu, 19 Sep 2024 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726732698; x=1727337498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=69+vMPB39Nce2muEw4aTqVSjlA0uEHJjncDbiLtv5gU=;
        b=vjYmtvcS+9zGKi0YapGU/7rQlCN04LZ+3KvYpclw8MtzEsMfR9uwH8sFjmZSiSj7hp
         Fs+2DTLavIwQsUK8O7LjWP+qRgADPz2IV1kjp4xaXTLL+pi/o2ZKzoHGqQVDKGkYJrwv
         tZxK5r2LtMahQp3EiM0pUh9vjNOSrh4gn0F8BflWLtvZjY2RLuHj0rtQ6tQX6vclG+G/
         JqvJjMFK00daSZ+zb0I/j/K09l66wFdGtIeZs4eyuWnod2NlLBUUjX3Au2mPqraoQsz1
         G+dTs7RfKryVSUnBTwEDX+X3ckpvPua97vTRrK2eUymVPcODGGCcnTU3XT32S2d7Sw6P
         d7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726732698; x=1727337498;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69+vMPB39Nce2muEw4aTqVSjlA0uEHJjncDbiLtv5gU=;
        b=KHW2nNUCgUN4jW/J8enIczg5iSZGhRLNt1S3WTjFuZLLk+02Vpd/SPalnb2awKNxsV
         z1/vJYE9rc+dW9KJ18B02zknDX/lA3EdzDHX56uGGD+b7xkoAQLhtVjEtAaBfcwIgDdb
         y4z8RQtWvdcF8YnsVot7MaHy82Of/c03gSOq9eRyXOX12oYl6Pf+XNhYs8PYvGcqmjLQ
         Kw8VjX2ySfFooOUCoZcHWPfCNjZE3g9aWYnQph7iN9tZqR3tTzimgggiVKIV236cFeJq
         7aG0Pmgv1Xdrxp6Bh+C5BaSv9u5a209egtEYQWTCVvcJjPwxmRm8fceXSkvNSNESCQb9
         z1ng==
X-Forwarded-Encrypted: i=1; AJvYcCWFHmeoHyQ3H+R1UiOeCaBhwsPMR27lc96KWONyW+Y+qw1Wm+xjGs6BcPwDFNeGoYQsM1MaN6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqkk8GwT6cAir9tW5rwNKbK2WCkgtgv4SFrbiMljDpISYggLFM
	vDAh6IqVpyOM17iwfCPK6LIjMSFqErKtSfu+Rn16W17YOeSDnTD/bgUgqM+xt3+BHsP3WvjWmcd
	E0g==
X-Google-Smtp-Source: AGHT+IFz4w5/l29GVVe3xj63AjJzWeR5yG9Sn8t/5B2QJ8WqvAQ1J6BUi7WySrK69nuf790coN5CeJTLSs4=
X-Received: from amitsd-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:827])
 (user=amitsd job=sendgmr) by 2002:a05:690c:6e88:b0:6de:19f:34d7 with SMTP id
 00721157ae682-6de019f7ae7mr534007b3.2.1726732698562; Thu, 19 Sep 2024
 00:58:18 -0700 (PDT)
Date: Thu, 19 Sep 2024 00:58:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240919075815.332017-1-amitsd@google.com>
Subject: [PATCH v1] usb: typec: Fix arg check for usb_power_delivery_unregister_capabilities
From: Amit Sunil Dhamne <amitsd@google.com>
To: gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc: badhri@google.com, kyletso@google.com, rdbabiera@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Amit Sunil Dhamne <amitsd@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

usb_power_delivery_register_capabilities() returns ERR_PTR in case of
failure. usb_power_delivery_unregister_capabilities() we only check
argument ("cap") for NULL. A more robust check would be checking for
ERR_PTR as well.

Cc: stable@vger.kernel.org
Fixes: 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB Type-C")
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/pd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
index d78c04a421bc..761fe4dddf1b 100644
--- a/drivers/usb/typec/pd.c
+++ b/drivers/usb/typec/pd.c
@@ -519,7 +519,7 @@ EXPORT_SYMBOL_GPL(usb_power_delivery_register_capabilities);
  */
 void usb_power_delivery_unregister_capabilities(struct usb_power_delivery_capabilities *cap)
 {
-	if (!cap)
+	if (IS_ERR_OR_NULL(cap))
 		return;
 
 	device_for_each_child(&cap->dev, NULL, remove_pdo);

base-commit: 68d4209158f43a558c5553ea95ab0c8975eab18c
-- 
2.46.0.792.g87dc391469-goog


