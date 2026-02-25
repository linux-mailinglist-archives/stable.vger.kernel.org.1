Return-Path: <stable+bounces-218035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNHjEVxJnmnXUQQAu9opvQ
	(envelope-from <stable+bounces-218035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:59:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C53B18E70D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E593033F93
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC88323D7CF;
	Wed, 25 Feb 2026 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ltyUyYX0"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE3323AB81
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981145; cv=none; b=iMi8V//vhCWn7TEiXWdDoTg1xYgmN0aI8uonBMySFF1F5sKpVL2T/3m5DMskpy2x3joEya0qqv9LigqpGkkOwhFrMMkdVq2R6PmyM+mQbgbOAmfYTkdbm9hsaWMmB4Uzka1WC0wI7LIefCQ3c6fd7KDI3d/scpVVFggWkoc9GlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981145; c=relaxed/simple;
	bh=11jQQswDgNMoKwGUbpAWL6gSmx2zBiQzUJ0BMY3f330=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=m/Uf7aXrRbmoayPY5nqIiu45HPzYvOeU+TQKbuVU0aXZdS4i+0NzIfjK8wrLo0h5o/x5eaU5VvMhhdOBIpjiFiaPTxxpT84SefmqVsdf9fuxTOJcrL7bOL41oHtgb59mXnNlDs/cWH/AHAWB1fky6r0m3jG0VoCPmVu1MJNYRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ltyUyYX0; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-124afd03fd1so8815652c88.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 16:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771981143; x=1772585943; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYBMU+7jfne/WhsH/k6Y6v9NVX2mX26yp1FDivWJk08=;
        b=ltyUyYX0rs0EF8WMnK5Dt4AMT+v84iPmfIm6LIuhVOS7alkwOOnBvDK9ZTi8OPWLgK
         nv1iiC5j4+vBWPukCXeuXvGb0jBUJ6cfeQ6UWZ4FXErjF9ki88iuyWllm/R99yRcmLKh
         LnoQn04/zeK56f0PQCnNAKE+tb45WDJf2hO6jBsAiNi1+fRi+8ODf7KK+FpZP07WpQzP
         XUryRyezuelSD3wTyX3Ut30KCQHlZc5BH9mJivNZHB3XTCY3r3wIyukS7JQFYzJdSAfd
         4ifzW0HGZnXksq0hWpB/4lFkAe15Ud3ObUEovC7KgtdmlGsDrTopMgD/nXrWvLqhxmLi
         V/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771981143; x=1772585943;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYBMU+7jfne/WhsH/k6Y6v9NVX2mX26yp1FDivWJk08=;
        b=nwKpfOdhcp1uhYjaXJ/4+ucVVaXa4O4ECRFzXrPV/eYlT9AtPpHPgQNbojQxXFVJtF
         ZlhY6TXwpok+gVAd/T1gmgdUS1OLljUNWWm1Va1FZdIXGzy/wkjyPk/MfA8xbXrPl+0g
         DCTzaRvMh7sBwXdPEdQjaatF9uW/JXHtoZqpdbcPxe+kztAa+V6vEPThD7HwWpo2UVBS
         MBmkHnaHEPBiYd4V4X21+yzeDW0PTzEGcvI7YkNTR7SycYmHxRwhGQYZNAs1BXXDK5Dr
         On1DeUgmbpiQY/kJCYxItVv0wdwBTZmXcFxNDXsxMwKrhJsCFD0efvazsCSgjckUtE3O
         74BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqBxdn7BbjMNn6B0vzOBOZEcOPxq/M0KfDI85gzTyssqgmf8/A3id3Ba49nSZcrlowVnCTlwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpALLmTJZwxj6W4HQDNUgbtgrgiJTRcQ7hsBlcmeNuyovOPVYB
	GNY54NTmr+fo2iHECytw09b3LRSEc3BIY/u5KpDOtk2/RE5TqlVk7x2IvOwKr68QpAVnTPvg3oS
	8Fmz+LfE=
X-Gm-Gg: ATEYQzzEuI8beLg2nT+dDMwkK0cLmSl0Y/zPW9RhBdjrlA8LOzjSHMQIcG8GRGN3wBI
	LW75HUdLv4TBIqkYObQKKKXMhKzYu38zQ45awaMB9rJtSCGZlKEROD72epK7mir24FqNjxo0CIk
	t9KP7NJ/ryLRW8NzJ4zMwisknZS3yqOY6jMVPHwDRQ6b01mpusBVXeDLTAaUszLMqxvJBRP1tBI
	OdhDL/FEhoAmmgBgUIlHAe839X742YqucAUtZrVtbWObL0yhq2argJY29h3SMFPkh7eA7ZtDem3
	PbqMJNo3K55zgFWLUBSzJUr2cnbWtIra/vzes2IcffFBhQ6zIPQNUK48b/xQvNF7wkofY1OrPoj
	Ntu2BMuLWF/T1XDrD5rzDRiCsr5//urJh5ApMziyLBPW06Ub+7Q4yEf4B0uwCVzaUpMKPvBFjSI
	GuI88pibuPo9Ycl23x
X-Received: by 2002:a05:7022:61a4:b0:11b:9386:8255 with SMTP id a92af1059eb24-12781ed0fa6mr272970c88.42.1771981143365;
        Tue, 24 Feb 2026 16:59:03 -0800 (PST)
Received: from d14e337afe00 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af20fc8sm13006374c88.6.2026.02.24.16.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:59:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) variable 'i2cdev' is
 uninitialized when used here [-Werror,-Wunini...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Feb 2026 00:59:02 -0000
Message-ID: <177198114226.2577.15577566399399369654@d14e337afe00>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-arm-allmodconfig-699e2e281f24bb6946377649/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218035-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernelci-org.20230601.gappssmtp.com:dkim,kernelci.org:url,kernelci.org:email,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 9C53B18E70D
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 variable 'i2cdev' is uninitialized when used here [-Werror,-Wuninitialized] in drivers/i3c/master.o (drivers/i3c/master.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:5094076fcbd58e00f45e150b4473740289489b80
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7613e80fc292f4de13de5b3f362452f450db6993


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/i3c/master.c:2203:3: error: variable 'i2cdev' is uninitialized when used here [-Werror,-Wuninitialized]
 2203 |                 i2cdev->dev = i2c_new_client_device(adap, &i2cboardinfo->base);
      |                 ^~~~~~
drivers/i3c/master.c:2181:29: note: initialize the variable 'i2cdev' to silence this warning
 2181 |         struct i2c_dev_desc *i2cdev;
      |                                    ^
      |                                     = NULL
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm64-allmodconfig-699e2e2d1f24bb694637764c/.config
- dashboard: https://d.kernelci.org/build/maestro:699e2e2d1f24bb694637764c

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-allmodconfig-699e2e281f24bb6946377649/.config
- dashboard: https://d.kernelci.org/build/maestro:699e2e281f24bb6946377649


#kernelci issue maestro:5094076fcbd58e00f45e150b4473740289489b80

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

