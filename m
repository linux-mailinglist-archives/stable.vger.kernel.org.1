Return-Path: <stable+bounces-227977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHPBM6U7wWkZRwQAu9opvQ
	(envelope-from <stable+bounces-227977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:09:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEDE2F28CF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2D9830055E7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDA939DBED;
	Mon, 23 Mar 2026 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbFLUyv8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734937E31A
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271378; cv=none; b=eLQ6R1X+Yp3rK+7iUCc+xhR9vw/323rbM8TriSxoOJ6T1TF84ARwMZuGOkdhxhsNl1tKQ0UxTrpwHHDrlXiK2HR7t0tpyUMkOzK2pu9ua/PmkQliAQcGQ7UxQ8qzCwyAj4bNIDxzgVk9xT/CjnMWC4tqqZcPlKSBknvUF6j7ulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271378; c=relaxed/simple;
	bh=lTpldD4eL76NbvK555N/Xx2Kd24uIcQoPu7MsvhV6l0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DPAvH1m9fq+y2kbhtoi+q1Afej3XtivYl7npRikgGELpYGIjZRROLhKxd2jPGmmqLEehjjQAu/Inz4NsQSvSUJCcvvSmpZAWlzMNBAdtPr8oioNrU9L4nAcfqkyk3ShAUu4pe6/kPeMYsmEnZWpOhL/gFx6bt9dM3jxtnKukSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hbFLUyv8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b527ac5d0so1373242f8f.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774271375; x=1774876175; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfzC67OFUc9pr0Vnc62IO92SI4BJtFnpHt3IPGw5yvg=;
        b=hbFLUyv8amQlLvUybV20ua7naznupMz7vdzYZCPbd6fhL0rvE8hnxOJKdpS2XtNZbC
         cxqGTCjauO/k3i+rSGvs2WN1KXkKHZDM495b9iOBa7YTezelET6EVnZjE9tbpYdhre0L
         HApHxY6TeMFEGahx4NcE/5cs0RwgZmy/AFmLroEafh62HGKVLkySmMvSC/wwuTSlZT2v
         4iEBvHWe29prYkiolagEpB4xvtVLhhpogjEes3UEpxYFJMzIS4jxNZbRa5/TTcjUxBH2
         ZetGDIZLXTuYi324fyHXXYv6YzOy+2s0b1NABcII63Mq4Ov4dXUgh0lsl5gi7uSN/wyK
         M4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774271375; x=1774876175;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfzC67OFUc9pr0Vnc62IO92SI4BJtFnpHt3IPGw5yvg=;
        b=ZH3g6CBmKVLu5NGeobOWrgKc1OhJMjMzsnXaFrJVYhj6KwfJt7TSvmyhdvkVUZjWVi
         fLTewHA9tbDNYoz0HkLE/DCq728t2RrLTNRG1gEuXXSuQq1inxARzh2kDhrdtN/52wt8
         XRK2o0oTOAZEqhEJzqf3qSlEiFDdhaxn+6rJ9S+Zh6mygZM9e9EdpK7411LhrlPzNJEJ
         AIoiaQ8PTV3SREs7+ycWsIFXW6uuDaR9BpFAmgAV5KeCVkeI1KD9ZkgKlvH0XxYD+mHN
         nBm5LADB2g2ZvLX9p08Ssw0pgkvIoSuJ6DTifeuKrhgtrX4ss8u3a99pkN/51vZv/iUK
         R2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQP7wif9mIUvg9M1wWzBu0O/KOHrW7PjuX+Ql+h6vGJgp5quv8bvXFkArw8TlKSLuaYu9MinA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHQADraQzd44GHOjyqY/OraabUDHnT7nxLzPaZImeZ2yh6Jq5A
	NizLX/v2UEzNmTuTvnYs9/XHtTSkbEM6e10GLJZa49Vk8PwUi7CGAQcrDUx805JAIWw=
X-Gm-Gg: ATEYQzzeq89XCKu/CQjKAS5egCvB7wJSzeJwFfNabuE+2+Hdyxf9aldL7JwsErYB17K
	rOo8FNu7i2hd90ROMAVxnZ0rpb8cO51N4PjO4Nc/Wrluk2B4jSS0Pqol/9xHyCT4oUqYNDjhRZO
	7fkptmSNNKfT6Ty2FyL7vI0fnQQkBq82dzUDOX5I/NPqd4pv0gRUXIBBC2moNQHfnZDl18MzfYM
	lUiJMMp8s8887C1t/oMHdBcefWnDNiWWE0+p49Ukt+F1B7yxYk0aAvK07q1AVWgAp1UXqjojjP/
	VK+O/nvvwqesqJZmKICWz36HCLZ8bTc9szblKBR+IVObSwf74ecT+vw3uvPZx/IZgQdq5LdoYj6
	o20aeRXDzwCSt10rZ50yNZNM1ZNqN9y+H5lGUMX/cPMX3Cm1++UqlCuSlrLwQofRmJEVHy9OLGf
	Uo+NKSGUCkwC7wPxgU1nlhadiUSEpfbbhBXsO9l8R5Fn94zVRI1Fz23IAypYWgmbG0gyVEmQwgk
	Mp6RVZbRnq1eEqnog==
X-Received: by 2002:a05:6000:2203:b0:43b:46b6:87aa with SMTP id ffacd0b85a97d-43b64277e1amr18640357f8f.27.1774271375078;
        Mon, 23 Mar 2026 06:09:35 -0700 (PDT)
Received: from ta2.c.googlers.com (140.204.78.34.bc.googleusercontent.com. [34.78.204.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470c239sm29651241f8f.27.2026.03.23.06.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:09:34 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 23 Mar 2026 13:09:27 +0000
Subject: [PATCH] iommu: Fix bypass of IOMMU readiness check for multi-IOMMU
 devices
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIY7wWkC/x3MQQ5AMBBA0avIrE1SRamriIXUYCJU2hDS9O4ay
 7f4P4Anx+ShywI4utmzPRKKPAOzjsdCyFMySCGVKKVAtvt+oaNxetGsZDasdKNaVeq6MRJSdzq
 a+fmf/RDjBy7q+fRjAAAA
X-Change-ID: 20260320-iommu-ready-check-4976863957c2
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <bhelgaas@google.com>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 peter.griffin@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
 jyescas@google.com, kernel-team@android.com, stable@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774271374; l=2378;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=lTpldD4eL76NbvK555N/Xx2Kd24uIcQoPu7MsvhV6l0=;
 b=t55I53gjpaEnmHL4phC4I+QSAaGYecA0xntMB6DObcA3FXm8m3v3G7Z/pZ44CrPmDg4EYupY7
 2+TC4ZG5EZUAIYs/zpKafQyyyqzwRsarbQ0Rz4wCnYTwwXlEdzGE9DF
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-227977-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:dkim,linaro.org:email,linaro.org:mid]
X-Rspamd-Queue-Id: CDEDE2F28CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit da33e87bd2bf ("iommu: Handle yet another race around
registration") introduced a readiness check in `iommu_fwspec_init()` to
prevent client drivers from configuring their IOMMUs before
`bus_iommu_probe()` has completed.

To optimize the replay path, the readiness check was conditionally
gated behind `!dev->iommu`:
    if (!dev->iommu && !READ_ONCE(iommu->ready))
        return -EPROBE_DEFER;

However, this assumption breaks down for devices that map to multiple
IOMMU instances. During the initialization loop over multiple IOMMUs in
`of_iommu_configure_device()`, the first IOMMU successfully allocates
`dev->iommu`. When `iommu_fwspec_init()` is called for the second
IOMMU, `!dev->iommu` evaluates to false, short-circuiting the logic and
entirely bypassing the `iommu->ready` check.

If the second IOMMU is still executing its `bus_iommu_probe()`
concurrently, this allows the client driver to proceed prematurely,
resulting in a late IOMMU probe warning:
    dev: late IOMMU probe at driver bind, something fishy here!
    WARNING: drivers/iommu/iommu.c:645 at __iommu_probe_device

Fix this by making the `iommu->ready` check unconditional, ensuring
that a device will defer its probe until *all* of its required IOMMUs
are fully registered and ready.

Cc: stable@vger.kernel.org
Fixes: da33e87bd2bf ("iommu: Handle yet another race around registration")
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
The warning was observed using an Android 6.19 tree, using downstream
drivers (exynos-decon and samsung-sysmmu-v9).
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 78756c3f3c40..e61927b4d41f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3042,7 +3042,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 
 	if (!iommu)
 		return driver_deferred_probe_check_state(dev);
-	if (!dev->iommu && !READ_ONCE(iommu->ready))
+	if (!READ_ONCE(iommu->ready))
 		return -EPROBE_DEFER;
 
 	if (fwspec)

---
base-commit: ca3bbc9287400c1274d87ee57a16e3126ba2969a
change-id: 20260320-iommu-ready-check-4976863957c2

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


