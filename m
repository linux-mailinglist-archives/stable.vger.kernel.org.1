Return-Path: <stable+bounces-256448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMdlMtDWGGoToAgAu9opvQ
	(envelope-from <stable+bounces-256448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:59:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 857355FB8F9
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51D4A3006699
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BE1369D55;
	Thu, 28 May 2026 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="BkOE0Eho"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217E34A78F
	for <stable@vger.kernel.org>; Thu, 28 May 2026 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012748; cv=none; b=V8NT/SO6o/FX8s9Qujnh5fyty9DvjgeUfsr+6KF7IKTINuQ53qlV93vvi+S+9lDkaXiLOIvDImkJL6NB+0ADpijaoiX5DDhUOBWIyAu5FkXVNlwuyTXW1RnOaO3uMlRowpGRikailbBd6fPvzpiMbG+5SWTN3BUaxbKpDUO6lQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012748; c=relaxed/simple;
	bh=uGQjvT1uytWGy+qCZjFAdgj8IEIqhJOqNK0HMviuDtY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=OtX+VvWw6xsBQg+Pa9AI6qoRyQtfbCAmB6dZNGjljQrq3/3oWD4ooYV/68/t44vdZBiAl4EYN41TZgHG2YI77Skm0MgLNioiMIz8xS3kLiicT950p/GSm3egJidzuGiIOLUVzWoD19/fxQKHeqeIfSPNOVeOUiPSzzagiDzTGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=BkOE0Eho; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f33ae12f97so7268038eec.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 16:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1780012745; x=1780617545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foXdPsSHd3rJyVTjKqKzbsgnQPk3g8MNhsC232Q+c04=;
        b=BkOE0Eho8XRvfFcIJTIiL1nX/KnV+4NlUEGk/Ys5Okzr4xn9DnYvblAsR32neBO2Rc
         +fXU3v6op2FP0+AL3ukStFLqPiiKEw04VOdGxl+sE9vzThD87IYLcfEXEEvV6FQxy1tf
         UmngA91nRcqzft0Opn/Cmo0jFALsO9VmCAeUdHlIhyQ1gYYGkVBFzS8sger+cZ3Bzsey
         x2cIg8DCD/qIbjSIlQtvdq8Ck6Uh+0pKPPQNhB+/RdgbZ8aVtV163VGvxK0gKLSF9NHf
         bovP/XergJiQOow6BhEEJomdEoJ/GmqF4v1wHaAwu+JO/ZybP8bKjokly2N1jDksyNd2
         4Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780012745; x=1780617545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foXdPsSHd3rJyVTjKqKzbsgnQPk3g8MNhsC232Q+c04=;
        b=NZ0KRbabNJKD5TWU9PZhtqBeD7RK72+bksCiLIhvXc3TL1SYVz6LRoO1nWqJIs/cIU
         mDFYOSRGXRyXnuOY/AU9Mj6CurswYmgmjfdPZ3pvZcvER94R/kvgdqKTuOIVywbJY0TX
         +lahf0Y20s/2KwcXZ18Zsobyy8ypy8yibVR/ZXxImAisVF6yHAVZeaaWoXyz2LG/tJ5T
         wxYYHSHahn7jkxiTBqYkKKEQNIoRaGmAm3HEEnrcweZdf9EbiIqZGYqs582ZX1UGgHBi
         qEmsHpiG7M/LIEjC1DIsNORE11SFdXiIu3+bOHTSlIRjdqgTctbxcsntS1zT+WPbKcCD
         Qcfg==
X-Forwarded-Encrypted: i=1; AFNElJ9JHVTt6v21eNUa+taYhIQuI3z0XPHwx4krMAPq3YBsLvskyGcC+GgByFW78ogRHLJUPUAiFPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQ01d9ru1Fw607i6XUqZtVILatv411Jhb8P9OQSXxyxNn8pW5
	vAOMFGvLZCWH/6QauWzstZmrydVjTODdknJsAtcGVD0sn0H522PKOHggqzXlYTiBPAk=
X-Gm-Gg: Acq92OHNyJTL5GUX5HmlGP3+jEjgBMknhKjgCK7xQKhp3cduFXSfAXIe9Zoxd7vnHUf
	c6pWtxMt/ObnmbYaXn5fIuJLAS2lHwxnuudUdVFY+5l7XL80AepNmUAMq1vKE8Uvv10Zgx7KpwW
	QAgNa5JKc8p8iN27jop4YugG5+OejGGkOH7iqp+a8lm9JLm81bkfCyW08YCZij5sZbiyNGyBSSZ
	3pq8TFeknIQw0iIg2CptsiWpzF3+N4PjVpzCexLVa06Nk+I4AvLxr11wyn67tlGAdpS8AY1Er7y
	1AgP+XaeA38koRtR+i0pUfw5iiXRkO4KW7MpmxQZHJmyf+KF67LGUMcTz7J5qKCTGzTTl0YeIqB
	A96rrLf1DvVeDKPL+t4TWy4D0Sd93B6ZWjTBJZDrotmXisBQBqCMg758V7Km+5vySIqmlpfLgN7
	qeElffeJ2PEQJMjp0Tc9ICtQNjMIs=
X-Received: by 2002:a05:7300:bc0b:b0:304:d4c0:82ea with SMTP id 5a478bee46e88-304eb1fbcf0mr340953eec.21.1780012745486;
        Thu, 28 May 2026 16:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c312csm112411eec.6.2026.05.28.16.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 16:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) incompatible pointer
 types
 passing 'u32 (*)[4]' (aka 'unsigned int...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 28 May 2026 23:59:04 -0000
Message-ID: <178001274428.7152.372661732178917650@330cfa3079ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-256448-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev]
X-Rspamd-Queue-Id: 857355FB8F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 incompatible pointer types passing 'u32 (*)[4]' (aka 'unsigned int (*)[4]') to parameter of type 'uuid_t *' [-Werror,-Wincompatible-pointer-types] in drivers/firmware/arm_ffa/driver.o (drivers/firmware/arm_ffa/driver.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:5469b396123e4618aadb3c2d0ad4d1811095c956
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  97928cc88900a9fb07a4dddbd1db19eb0ce55c56


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
/tmp/kci/linux/drivers/firmware/arm_ffa/driver.c:381:14: error: incompatible pointer types passing 'u32 (*)[4]' (aka 'unsigned int (*)[4]') to parameter of type 'uuid_t *' [-Werror,-Wincompatible-pointer-types]
  381 |                         uuid_copy(&buf->uuid, &uuid_regs.uuid);
      |                                   ^~~~~~~~~~
/tmp/kci/linux/include/linux/uuid.h:76:38: note: passing argument to parameter 'dst' here
   76 | static inline void uuid_copy(uuid_t *dst, const uuid_t *src)
      |                                      ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a189f30ee38c2a863e3d00f


#kernelci issue maestro:5469b396123e4618aadb3c2d0ad4d1811095c956

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

