Return-Path: <stable+bounces-255042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INj+OmJZGGq9jQgAu9opvQ
	(envelope-from <stable+bounces-255042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:04:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE8E5F417E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E8E730ABCC0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7A12E737E;
	Thu, 28 May 2026 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="JlgKr+UR"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284EF2E7373
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980348; cv=none; b=ULEKsQxRM4oHMu3IXc8qn5rpzPaQmvevBvAsrosOjTYHkZwGarqWLcdDEonlzkxQeUuO7CVIBqMH+/poyLQQ8/i02hhQFOhoqv7rS9685+NeFAOumscSl9+blo1OYdDRWZl6B82U1mS5uQaa7UVlyDQG5+tYbx5S2qx8QsNdgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980348; c=relaxed/simple;
	bh=PjhsIqd26TKF/DUKspFSngGzl/tBIwbjCZlW6KlpINQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=caWYb996U64Z5bLUc3kVwKIAa/I8ILnS4ZlnYvIe0zDWlXsN4Kwsh7sRL/SYUg6N1frBSK8X6ebu1SZnm60PDkybN6+iy/pHVbsUjiMtF0vYOjGODazb5m9qIVGywIOavVVHqAPhTYclcpvn4ra3wmS2reQg7+cqyyNcZfzv1wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=JlgKr+UR; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1329fc4bf77so4097572c88.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1779980345; x=1780585145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0ANB4RvVADiLo+7igfCDW3H5yzLKDEj5vkrztXW7Do=;
        b=JlgKr+URFFxcZTvZt/C0ouoHRnhbhQ96nsA46AOa/gKCqdx6tfojjsZOVGZ3GnEb8t
         hO+sEDkiPAROkcgB/lP9Ac/OS/ZnJ9XGEMvs/CQLGdHnSUOMIsydIDOHcZJpo7iVwU+a
         +xTgcDIf2B5uV0x/ZD2Y6+af9/2a4MmVs7kpgAI0J3lS6VmwgGbft302U8PWwyZyX2YR
         ITljTp7tQY1d/YPSy7Ox5QARPqBJ6J/GqFizoBAvhF1fjN2gOOUFSv0QXPTenKnGXypM
         3teHChgd5pUaPfjggUuIvyGSD5wJJ+LWpQNdtLc/B76e2MLapkFz9+83HgZYR9cMp4/E
         P49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779980345; x=1780585145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0ANB4RvVADiLo+7igfCDW3H5yzLKDEj5vkrztXW7Do=;
        b=HeavSNypbWC7oEZREkiS+S6xSOjJPnOI4Cdhmwi8SRnuZUA6UDrgpfj7aqnZVyivH5
         KC41dQF7VvPW1pFbqbvdgO3kMeluub9gNV2h3nPeuvuwJo/8FLxTmjs4tW0yXgToc17n
         X1RZModYjiIUgQnI21rwHXKLoY+ueSVZYbiDll2C67E9QZUTc2bDWCy0Zm7JSA1YUHMO
         ITSWR1hI+d7F1PgVuLaHJCLLdBqkZATeWN9U/YVYCJKwjir1Dr9Ge3JQtvXx/jOmav53
         EDI7J/IKR8ojNzTxSxbLzV9yIMPTHhHtNUvOcf+VrcnnG6Nbsq7/W+nzF3VI5QT4lfMJ
         LKEw==
X-Forwarded-Encrypted: i=1; AFNElJ8YCbIqISghHSk9gJCgVrmdo6eooQ7YYXhSKeR14c+wiBl9+d8WPQGndMyG95UbYag6kulp3gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxuV1EBxBSFZmcodRS+vJUrf4MYZFBfwGCb6Ht72P5XWcEklP
	wkhEi2qJc5hjWC/fQ+Hb420ELZElp55IaR5vrZ0DEbH8XF41apwKzTlsfO2qLxKNUNY=
X-Gm-Gg: Acq92OH7s8x47VTqNKgQ4Q5Dl4QpeEFGzabljFjHJdZ1Y6rGZspTOTrDqsKx8UVdQzt
	zNkGDFM984y31dLiPOYSLeX/l/2ZM1/aXy4AfDZRwe1YCVsgQet/KmsdQu+NnwB9vr3K1lB3GW8
	WDK5wN6tsuP73L78mYsKah9Cm3oe7Qn852nyeMN4RDOf/7K4LiYz03yEKspmv82i4AkInSUtw0c
	SpPvXzmK0WPmmxY7ZKBpHKkcBIpr36oWtZuzGGz0dBs5kpWQ5MpDCOiNwu+iali8UAsNDrjx0q5
	yqBLokmtLUDJMdP+sqTaObvtlFjCUUrrkgmi1BLXr+4mUEluLKe4h9OgndmYJpixDNRL+KUXwi2
	o8ng0KftCp252ZEZyDRuTapLP50x0QfB4uZL1MQWPHnk9XSpyFVoxfdDnXzsew3+/uU4qj+vD8e
	m8PdWCogKTMiB8dmhpVL7tTVeTE0Q=
X-Received: by 2002:a05:7022:fa04:b0:135:d749:574f with SMTP id a92af1059eb24-1365f820df3mr10986228c88.13.1779980345030;
        Thu, 28 May 2026 07:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm11658901c88.7.2026.05.28.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) use of undeclared
 identifier
 'class_pmbus_lock_t' in drivers/hwmon...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 28 May 2026 14:59:04 -0000
Message-ID: <177998034399.6981.4184961464784113279@330cfa3079ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-255042-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: EBE8E5F417E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 use of undeclared identifier 'class_pmbus_lock_t' in drivers/hwmon/pmbus/adm1266.o (drivers/hwmon/pmbus/adm1266.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:6b1d329039d2c41ae22b07421d5ab18bf0e195d5
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  99fb050c8b9077f8b09d4272318b23bdeb2d7251


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
/tmp/kci/linux/drivers/hwmon/pmbus/adm1266.c:176:2: error: use of undeclared identifier 'class_pmbus_lock_t'
  176 |         guard(pmbus_lock)(data->client);
      |         ^~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:137:2: note: expanded from macro 'guard'
  137 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:86:2: note: expanded from macro 'CLASS'
   86 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |         ^~~~~~~~~~~~~~~~~
<scratch space>:60:1: note: expanded from here
   60 | class_pmbus_lock_t
      | ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/hwmon/pmbus/adm1266.c:200:2: error: use of undeclared identifier 'class_pmbus_lock_t'
  200 |         guard(pmbus_lock)(data->client);
      |         ^~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:137:2: note: expanded from macro 'guard'
  137 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:86:2: note: expanded from macro 'CLASS'
   86 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |         ^~~~~~~~~~~~~~~~~
<scratch space>:71:1: note: expanded from here
   71 | class_pmbus_lock_t
      | ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/hwmon/pmbus/adm1266.c:243:2: error: use of undeclared identifier 'class_pmbus_lock_t'
  243 |         guard(pmbus_lock)(data->client);
      |         ^~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:137:2: note: expanded from macro 'guard'
  137 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:86:2: note: expanded from macro 'CLASS'
   86 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |         ^~~~~~~~~~~~~~~~~
<scratch space>:82:1: note: expanded from here
   82 | class_pmbus_lock_t
      | ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/hwmon/pmbus/adm1266.c:337:2: error: use of undeclared identifier 'class_pmbus_lock_t'
  337 |         guard(pmbus_lock)(client);
      |         ^~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:137:2: note: expanded from macro 'guard'
  137 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:86:2: note: expanded from macro 'CLASS'
   86 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |         ^~~~~~~~~~~~~~~~~
<scratch space>:68:1: note: expanded from here
   68 | class_pmbus_lock_t
      | ^~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/hwmon/pmbus/adm1266.c:403:2: error: use of undeclared identifier 'class_pmbus_lock_t'
  403 |         guard(pmbus_lock)(data->client);
      |         ^~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:137:2: note: expanded from macro 'guard'
  137 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/include/linux/cleanup.h:86:2: note: expanded from macro 'CLASS'
   86 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
      |         ^~~~~~~~~~~~~~~~~
<scratch space>:87:1: note: expanded from here
   87 | class_pmbus_lock_t
      | ^~~~~~~~~~~~~~~~~~
5 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a183892ee38c2a863e11dc9

## x86_64_defconfig+allmodconfig on (x86_64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a18389cee38c2a863e11dd9


#kernelci issue maestro:6b1d329039d2c41ae22b07421d5ab18bf0e195d5

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

