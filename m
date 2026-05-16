Return-Path: <stable+bounces-249038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE4rG2XXCGqZ7gMAu9opvQ
	(envelope-from <stable+bounces-249038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 22:45:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1385E55DB6C
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 22:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82DB53011C4C
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0928E363C4B;
	Sat, 16 May 2026 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="Bu6GlWwK"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02E379EDA
	for <stable@vger.kernel.org>; Sat, 16 May 2026 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778964319; cv=none; b=d7o1bZTE2XKXKwcpODQHZV8FbQrQEBvAX7xnd0h4zXqUFSh9P7Gj9OobXw0Q7Z5FywFMEjlXXNKnF1zipttKuRWNp6Byl3sF3mZ/aOTlM9blyMZMTJXUJ+aUX7MEbeshIl+gxcsXQNBmJJjaY818Vpj5SgK2DYhLYe598+zGM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778964319; c=relaxed/simple;
	bh=ZA9YwSMOB2P20GluMrii2imNU6EYpgFSSMjGH9Xw3dg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VvUTRHqztcgrJMHmkJ5BYZqDpvJJ+uQdVm2S/+MOSVw417vcjvWokLcX5nz9pN3VWN/+ny+8OaYQCmZDGW+CAOaxW1kXun9xjTZGsP25XiEBIrp4g/LWJmy7K2nnnIkz1sPBlUwYV+PfP8MTGaYNhq02vqKRi34dbMKSWKw2SfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=Bu6GlWwK; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f7020a928eso1326349eec.1
        for <stable@vger.kernel.org>; Sat, 16 May 2026 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778964315; x=1779569115; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVEabIThyai3FEuPEZ337FSXUM+wr3XkJNz0zdLoyBg=;
        b=Bu6GlWwKbUbz6QdjrElJsr6PeCUjKBBhOR9St3e8Nooq8aYDsWly4zsFyFPTVopRBq
         5ThBFw5ofrpUGe4EASDGDMLcPZ+Y6IzkB8Jsv7yIXzmkkNjb5p8ZGbA6smDV1QvAYomn
         7rHPZNErTFzc/AvRtXg+8Mlv8K1hMpPo7PE5K5QgGG7mAqZasZChoV9FkR63ZCLt9ZeY
         sR/P1bxWsV9ELh/SRG8cwq6eaXE24QmlQuiZfH62YwmA2Cu8zAqfgBFQWO7LZaF9Yr4r
         /Q/mibS+VnA1DccwBEGLJu/JQHUz21lDy4Riu8xr2f+LVA/uB806tnuUqn/EUSZFX7nH
         HHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778964315; x=1779569115;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVEabIThyai3FEuPEZ337FSXUM+wr3XkJNz0zdLoyBg=;
        b=li1fXiSA9EKd+NcNP7cYTt4GERgCUEY5W79tOOqJKlTkjujr4IWUMGNGetJ1WA07WG
         K8G5jXm1cVFiObnFo9suIvXKv91qDLbWhb4WYNWWhDyGLYz1YC+JiKiWuXfMOp+Qsav8
         B3AOBKTjhGpvh4/H4lS+3YYoAQNh5RPXWLWXQfmChJcvvBQC7dWhirmYN1a/AgxtMD0G
         hxuycQHaGqVsXqIOcbyM2s/Xf6luJN0H0sBO19TcIm7enW4QgWx8w2VmykeXnXyhrXpI
         GVzXbkQnzEDgE1qEajlwUtmC99jKGA8ENavHgjucpUkANLy9Bv7F4Na2RWWsZjwtGuq/
         erJA==
X-Forwarded-Encrypted: i=1; AFNElJ+lwPXGyl9JvxTe/ASTghIVl1SDey2YGR0mRIGP1nt0S37z8wTWH9N1uYQBLZl5X/atNmfne/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3Zj2EQlPZWbilyjdf+qhjj4V67ExCUC8XC2BEKeBHzJy7oqN
	n/sIOzrnQoEuTDBJX2ijHr+69N41N4a6lNRW/DcWcDPBGWnu2zePq13HzFzpFbdo2j4=
X-Gm-Gg: Acq92OG9zy7AiQc0p3e1lEX5QI3yfL0QjCgYhedTiNZ8ge1KHQRVImLCS5ErnfghNP8
	Ftzg/++TCvqAYKJUbFFQqyFcMtvupYwrySmnNwV+fktEMSjDrHSzvd5n49OLe5yONHNGDToU8ia
	zriTkK5W8zDtygcsZvVFQ5Y8VN2svFoe3k91LTUK9zGLH72yV+0IG7tsW+dzH7e/pJUWTw3/YgJ
	E0I5ObZkrv8gqTxcu61Ds0TwErw+nZzsbGzih1NaIcDNUVZ8TGaRnGtd/uuj+g5AQdO0uaWwYjq
	Ysk09WN369m0sZPLO2WEFTVvfFrhQJctf2Eq7rpSnuOb0se1h6BRYD9RZpeeXeq+n45tnG3oQh6
	k8qeW+eAhCdlNTTeoktLCJMlVScMly9OJ3xGWUA0axTp/T+ljNubhR4OwEwBU8KmimvMST3PySU
	l7GqNdsKkVAZryqkrtZXYOEgWGEw==
X-Received: by 2002:a05:7300:7255:b0:2d0:239a:23c9 with SMTP id 5a478bee46e88-30398677161mr4329663eec.16.1778964315089;
        Sat, 16 May 2026 13:45:15 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm10181189eec.12.2026.05.16.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 13:45:14 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH 0/2] hwmon: (pmbus/adm1266) adm1266_gpio_get_multiple()
 fixes
Date: Sat, 16 May 2026 13:45:05 -0700
Message-Id: <20260516-adm1266-gpio-fixes-v1-0-38d9dd39b905@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHXCGoC/yXMSwqEMBBF0a1IjbsgCRqwt9I4yKfUEvyQakUQ9
 27U4eFx3wFCiUngWxyQaGPhecrQnwJC76aOkGM2GGWsqrRFF0dtrMVu4Rlb3kkw+ujroJUrg4E
 cLomeIXe/5rWsfqDwv5/gPC9EsrNWdgAAAA==
X-Change-ID: 20260516-adm1266-gpio-fixes-dbdb9c10a4c2
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778964314; l=1681;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=ZA9YwSMOB2P20GluMrii2imNU6EYpgFSSMjGH9Xw3dg=;
 b=z0KvGRAxXpGOxnVQJ8+lQLLDDEZfwJjhR9BPUurGOwkSyhYJbKkmLxtUr/8RYcMHV/DH4CI/f
 x1zOnDpQDRfBMFvH2tY91AtqKMe5KnIulhxqJZVaU6Z15l4sYF2D8aG
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: 1385E55DB6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249038-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Two pre-existing bugs in adm1266_gpio_get_multiple() that landed
together when GPIO support was first added (commit d98dfad35c38).
Both are reachable any time userspace queries multiple ADM1266 GPIO
or PDIO lines at once via the gpiolib char-dev or sysfs interfaces.

Patch 1 caps the PDIO scan loop at ADM1266_PDIO_NR (16) instead of
ADM1266_PDIO_STATUS (0xE9 = 233, a PMBus command code that ended up
in the bound by mistake).  As written, the scan walks
find_next_bit() up to bit 242 across a 25-bit caller mask, reading
out of bounds and -- if any of that incidental memory contains a
set bit -- driving a corresponding out-of-bounds write to the
caller's bits array.  Flagged by sashiko in review of an unrelated
fix series [1].

Patch 2 drops a redundant "*bits = 0" reset that sits between the
GPIO and PDIO halves of the function.  As written, the GPIO bits
the first loop populates are immediately discarded before the PDIO
loop runs, so any caller asking for a mix of GPIO and PDIO lines
sees the GPIO half always reported as 0.

[1] https://sashiko.dev/#/patchset/20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Abdurrahman Hussain (2):
      hwmon: (pmbus/adm1266) cap PDIO scan in get_multiple at ADM1266_PDIO_NR
      hwmon: (pmbus/adm1266) don't clobber GPIO bits before PDIO read in get_multiple

 drivers/hwmon/pmbus/adm1266.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
---
base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
change-id: 20260516-adm1266-gpio-fixes-dbdb9c10a4c2

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>


