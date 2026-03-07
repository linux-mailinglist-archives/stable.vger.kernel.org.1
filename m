Return-Path: <stable+bounces-223407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI37NL2Vq2k5egEAu9opvQ
	(envelope-from <stable+bounces-223407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 04:04:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B7D229B9B
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 04:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A2BD301DD1F
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 03:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34232FFDEA;
	Sat,  7 Mar 2026 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H77Upqk2"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24331244694
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772852659; cv=none; b=IVXOyiV+OrhPw/ijz/idysj1yll6OZEbIyyWKXVWm2TOHHpj4HGKrfOPiY0gWqE0XT6PaOG4yF+sXU0pqW4aFXpu+1N5ILOhg+1GTsI0kECA7QbiKap53r6WJ5AA6TatMH5NV8KCZ/awlu+eoydI3Zvlc9lO4Sj9wgtn20ogacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772852659; c=relaxed/simple;
	bh=soc1nQwzOytP0zUgbCWxwApYixb4ALgKCcM8lxOFp2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCiLoTywHkZG91bdV/2n2phhkf1RUC132V4QxYHUNlPCqMgMUhttldcQemGz2hftwe54S00GPxiZSywUCQE8BQfj4Y4uWrBH1Aa7X7vYcZ6LCAhD1bzQu3pCSgQSOKldwiFPbEbYKVbLVo0B6bTpCEk1o6UOjxRULJFEEk4HV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H77Upqk2; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79800183233so137395977b3.1
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 19:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772852656; x=1773457456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TW4paroosegqJh0pxZU5dIW8jzge/McujMzL3aZu1UI=;
        b=H77Upqk2cOqNk2kkF7tDWt+96za+yRB0u44K9oEBoMiH5tl/OHFHKCROrkGcJiyd+k
         rNAd9IM+xtmLv4GFqNtBndgqbKIYelm4oGQBuFBAEzxGRRG8D8rQsFW1NnTbP/ZpGYYj
         UQyzkrSVbl7Kk1XjjbVBUxsErnvePATrsb+j4Ii27bOlRTfG4pat89VitspOgpkjpapj
         dYuM8h8jhimxjgzlGqsnOCeeKCHOGD03+QWB6z0dqxbKyts5hfltgfCfvubZTjnLbZrQ
         xgeJcUT7YyedKiV1jZ9vpRTZixs+df1qh4od2k8BiGlRH2BNl83XUvoeZrnJEo1I9nE1
         J1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772852656; x=1773457456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW4paroosegqJh0pxZU5dIW8jzge/McujMzL3aZu1UI=;
        b=j801LIzzFc3BfPsC7RrWR75b1euDjd3F+a2siYaifaKHDh2fcINQbumXhYGBDvpI3c
         p5sD1TTa2wOQTIoYHNxZfSkYYeKdXf/uxlvP2nlxpycz9xlv1p8hsRupqhHakjMZdn2k
         Gh8swXhjKKGMhXZpkPAcCHqoCHjF4JuzmTst7kAmDPMiVRX/LHRd4XtMSuaGPMTrU6x+
         leC5BNtqfvTDnqP4B2dqkf7/PWeBNQ2uI5KYWhBMKDjHyL516ErxeqTJ7Nl35/Nb8w9M
         +FlDa2D8srX41fhKyFypzZGFy6NV/kLsRf5o8HdUjRRO1XvK6q55WJ4zVXiwLKctDyji
         AbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVUcvdFz8M+LLwN7sGtYMHF0jiCQdDz3EbmlpbYD9HVsCUl2+QNLDvc8eon64Dq7SJ0yP1dQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCt7Gzlwgg/Uc7WI6DIQSpfPmFNV4ImVbiAXyNK985PgL1Ywr
	7JucRWUcbz2bNKZYjrhUF08ChBnTXVE5AvVINAOAQyF64h1IWP6zMW2B
X-Gm-Gg: ATEYQzwGfUug/5ydeB9zNeud7g6GOSWTRIFNQ85Vnz5GiA89IqCx6f1ZteNS4Pgqo7P
	om5BLMmhtP1JxqK6FySWHH0jJhTpSk9HV83HAvet5se8QRd7pCqtKL2hIr11Bv/4r77gWE4/DdD
	hf/qUwPYSH+ya2rSDPuFwDyFefMB6MNQnDOVw8CMHUJgdTU8gYzqa0BRMKMIEPRaE/jiGKFpUaW
	I+osEjxaGDPjbLkBZQKaBbV3EHAYK3/de+w20S5loKQLOwz2XCllQ/Q34QjaNku67RztUAa5yoa
	m40Bect+iBO7F3l6/Go5hrNs4GPsWxJKLhHvbcRZOpGn8LzJA4LjkWJFwlHJ7AQ8NIY8KeYD9HR
	VX7pnyYvk6GXnC/iM7GFCxdhN5x24wFrtyev9XvHTjJ2+D+/wzR4VjFHpPsMoNX44mfxKeHW2sq
	aeNrnHq2A37rBWczA6sqXK5FgjxkzlNnAo9ABZfD0aWssebnmko78XBSZsUUnypzGCxquaXZgzQ
	jGXC21zBd0NE0qVOkET0y1o
X-Received: by 2002:a05:690c:c50f:b0:796:4486:b7d0 with SMTP id 00721157ae682-798dd6a9c02mr41536297b3.4.1772852656158;
        Fri, 06 Mar 2026 19:04:16 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5585])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dee66c5asm15100607b3.36.2026.03.06.19.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 19:04:15 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Cc: Tianshu Qiu <tian.shu.qiu@intel.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: intel/ipu6: fix error pointer dereference
Date: Fri,  6 Mar 2026 21:03:55 -0600
Message-ID: <20260307030355.26840-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D6B7D229B9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-223407-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.982];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

In a error path isp->psys is confirmed to be an error pointer not NULL
so this condition is true and the error pointer is dereferenced. So
isp-psys should be set to NULL beforegoing to out_ipu6_bus_del_devices.

Detected by Smatch:
drivers/media/pci/intel/ipu6/ipu6.c:690 ipu6_pci_probe() error:
'isp->psys' dereferencing possible ERR_PTR()

Fixes: 25fedc021985a ("media: intel/ipu6: add Intel IPU6 PCI device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v2:
- Add stable tag.
- Add check for null instead of setting isp->psys to NULL.
- Add Smatch warning.

 drivers/media/pci/intel/ipu6/ipu6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6.c b/drivers/media/pci/intel/ipu6/ipu6.c
index 34f67f4f1bb5..d033d4618169 100644
--- a/drivers/media/pci/intel/ipu6/ipu6.c
+++ b/drivers/media/pci/intel/ipu6/ipu6.c
@@ -686,7 +686,7 @@ static int ipu6_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_ipu6_rpm_put:
 	pm_runtime_put_sync(&isp->psys->auxdev.dev);
 out_ipu6_bus_del_devices:
-	if (isp->psys) {
+	if (!IS_ERR_OR_NULL(isp->psys)) {
 		ipu6_cpd_free_pkg_dir(isp->psys);
 		ipu6_buttress_unmap_fw_image(isp->psys, &isp->psys->fw_sgt);
 	}
-- 
2.53.0


