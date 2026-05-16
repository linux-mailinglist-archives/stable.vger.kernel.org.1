Return-Path: <stable+bounces-249049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEZ2Nmb7CGpgDgQAu9opvQ
	(envelope-from <stable+bounces-249049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 01:19:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3919955E39F
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 01:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E962C3015725
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 23:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0362637EFFE;
	Sat, 16 May 2026 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="Qv03CgDy"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079135E957
	for <stable@vger.kernel.org>; Sat, 16 May 2026 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778973537; cv=none; b=mTnwfNq9k7UQKxRpCIPyT4IWcfX1OM8He7kTC0SM8Hyp3oRG7wtqiNDlkg0Y6x3lhqid0jTn6TyyIqb643PUiKWTeVEmvAgBTuuNSovpbp8mqe5z7wR5HGK7GOeeCvQTUEU2TfnQs2oKGFcimTbrmEvPbkh8TWNhvd3cEH/Ksc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778973537; c=relaxed/simple;
	bh=wsfn1MbAM5mT+uBLpfkIk6VPVX8dfOOxOV1mjJK+BXo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gQOprUwFZhfKZYqnUQ/QuuHVS0ZgqMW5xsqCC7PUKGeAVK4xRjipXTCacqFQ4WIW17O1fiCukuds4qUQA3Z/PnG4E9GIPd1e/N4HOszpG9diXKiPEIc2zuvo0lCBtYewlpKisL4f3kGBXMxnpxzAsRF5vL1tC3wX5vbXdTsyBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=Qv03CgDy; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1329fc4bf77so1695340c88.1
        for <stable@vger.kernel.org>; Sat, 16 May 2026 16:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778973535; x=1779578335; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz3Z7xk7sYmHcnQNijrkJ53RnF0rGP8+OWF9DAgytjM=;
        b=Qv03CgDyvOtJ3yhwxBix4g1f2iG0VUI/rEfH7gsXqowJV2GtxEtLhWU7uwkbTKl49w
         QREC+Sp38okf9h8tRGbtzdRtMzH/UpJopsRTS5m2PHgtoVaagPbHP0Nu+gpWAaboYRHS
         FUpSAyFzYDawnv+31sZqcDUjSD9Jg13nIMlAa1lPjT+oovpheQKJI6TJ1u9Do2Qysc/Y
         h93ayIkuPwiTYc4Gj99ffCTlkjRAXefR4b/3nWxuftFyiv+xX1AditSExVNB9Y1LqQh2
         ks+yCj5d/iMyQOHgJpCS3tCBKkeFZXNQ2oVlCZXeZiwUj3PrwpSAG6YExfYKU7YUXIee
         oC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778973535; x=1779578335;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz3Z7xk7sYmHcnQNijrkJ53RnF0rGP8+OWF9DAgytjM=;
        b=KUzf7IKjiw+4dEm1u+ZGJB0jphcO+APkEYj/4lYO2EA6UZn/W/nHtNrboL8sYboSIB
         JfcjwRBrdzKXDMsdvZQCF4mumoY3Eh3elPvVNuWqsNGSOr3Rq5NY0UOabPFyXO0kDItk
         tUZpMgoPSH7ZagDXSUqeyxC0F9tr78obsHT+JZCAv8vjG4YJyk/YJylPqRRIklNW903w
         G1OW802XdyxS/EjY+ayeFcgI5gQQW9OjDoivpLeC/B6xbUt5Qee0rAdLuLWToO96UR0u
         VXBTNzeHusG/BEELBzZq7VZL5Pei2OtdpDjeX3OQNKzSouubpLs7/0NQxJOUUhyQZHDb
         az4w==
X-Forwarded-Encrypted: i=1; AFNElJ9ox+pEMSlJmDHwNqh8A2p0qsw4heu9mhGRcAaQJW3vyR224XXfrk0t6cGgwkxs65KSwyExr/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5CiwDh/FjJEWF39PjjKtmeA+ZLcvxcQnlewzKmo0Lem41Pu1J
	LUXPQgGiCceIq0DJN5pj2unW9g+mWRgyVTN2bFMrpRCe9xF3TNCC6iqtlGRvSS0iCe8=
X-Gm-Gg: Acq92OEwuaDzi7qgzkr0Vp1YzkAIjCixdXlywKKGPpQ/EjTFMc/gyEfcmDNnVVrdrPS
	q6rm6EZ9SfnOT/6GpuYcObHG+uXURHuQQCP/N2tAbZCzLmY49QtK3To/F8Gh/f2nfsLJs3OQkkh
	bvhVahuNOzyoq3LX1Etjyxp/l7d9CGfiJw5RWDzgfkwPAgeNkV/eT8I/VtPbZTEI2JaViI0xi6R
	8tizO1FxP0Y/kR7PXdvM446oRaS/iK8aiiivqY0qKAIHBW+VYpWum/7tgqRs+3DCKG2Nbr+0lXc
	FDPbG31DLvcVIJkjCLHgxJSg1Mo6kthxL2knd5ef/hMAr06XCPyVF1q27oA1VZicMxeaoKws5Bg
	i7YYX/EJQqZAod3ABc19Sg3mlGP0nyots5fFxmb5G50vKYBvvthRHr9PYtMfGYMI9P5TRrBqCGq
	Wn3Gn6TbJgqjsJWAAkQ6bcKBC+uw==
X-Received: by 2002:a05:7022:e984:b0:127:3915:76b2 with SMTP id a92af1059eb24-1350484e87amr4490067c88.27.1778973535255;
        Sat, 16 May 2026 16:18:55 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ef5sm14722254c88.2.2026.05.16.16.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 16:18:54 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v2 0/5] hwmon: (pmbus/adm1266) GPIO accessor fixes
Date: Sat, 16 May 2026 16:18:46 -0700
Message-Id: <20260516-adm1266-gpio-fixes-v2-0-801f13debcb2@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFb7CGoC/32NzQ6CMBCEX8Xs2TVtkcZ68j0Mh/6ssCZS0iLBE
 N7dgnePX2a+mQUyJaYM18MCiSbOHPsC6ngA39m+JeRQGJRQWtRSow0vqbTGduCID54pY3DBGS+
 FPXsFRRwS7UHx7s2P89s9yY/b0tboOI8xffbXSW69vweTRIHVJZgQKuOMqG89zWMXh5NlaNZ1/
 QJeHLXjxwAAAA==
X-Change-ID: 20260516-adm1266-gpio-fixes-dbdb9c10a4c2
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778973534; l=3922;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=wsfn1MbAM5mT+uBLpfkIk6VPVX8dfOOxOV1mjJK+BXo=;
 b=za08h5g4ZpshHcx+Wg3asjfc48fBSz7c/93TL0dYoERmUOOCNValX69QCzPvKeDUMLaJF8vOn
 o1MSwKepTH+D+e5GUx4i9YPVftkcjnnecfZSpXDwcw/Q5HhCrj2dIX8
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: 3919955E39F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249049-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim,roeck-us.net:email]
X-Rspamd-Action: no action

Five pre-existing bugs in the adm1266 GPIO path that all landed when
GPIO support was first added (commit d98dfad35c38).  Each is
reachable any time userspace queries an ADM1266 GPIO/PDIO line via
the gpiolib char-dev or sysfs interfaces, or reads
debugfs/gpio-<chip>.

Patch 1 caps the PDIO scan loop in adm1266_gpio_get_multiple() at
ADM1266_PDIO_NR (16) instead of ADM1266_PDIO_STATUS (0xE9 = 233, a
PMBus command code that ended up in the bound by mistake).  As
written, the scan walks find_next_bit() up to bit 242 across a
25-bit caller mask, reading out of bounds and -- if any of that
incidental memory contains a set bit -- driving a corresponding
out-of-bounds write to the caller's bits array.

Patch 2 drops a redundant "*bits = 0" reset that sits between the
GPIO and PDIO halves of adm1266_gpio_get_multiple().  As written,
the GPIO bits the first loop populates are immediately discarded
before the PDIO loop runs, so any caller asking for a mix of GPIO
and PDIO lines sees the GPIO half always reported as 0.

Patch 3 adds the missing "ret < 2" length check after the three
i2c_smbus_read_block_data() calls in adm1266_gpio_get() and
adm1266_gpio_get_multiple().  A device returning a 0- or 1-byte
response would otherwise compose pin status from uninitialised
stack memory and leak it to userspace via gpiolib.

Patch 4 moves adm1266_config_gpio() past pmbus_do_probe() in
adm1266_probe() so the gpio_chip isn't registered (and reachable
from userspace) until the PMBus state the GPIO accessors depend
on is initialised.  This is a prerequisite for patch 5.

Patch 5 takes pmbus_lock at the top of adm1266_gpio_get(),
adm1266_gpio_get_multiple(), and adm1266_gpio_dbg_show() so the
GPIO PMBus reads can't land between a PAGE write and the paged
read pmbus_core does in another thread.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Changes in v2:
- New patch 3: reject short block-read responses in adm1266_gpio_get()
  and adm1266_gpio_get_multiple(), so a 0- or 1-byte response from
  the device cannot leak uninitialised stack memory to userspace
  through the gpiolib interfaces (Sashiko review of v1).
- New patch 4: move adm1266_config_gpio() down past pmbus_do_probe()
  in adm1266_probe() so the gpio_chip isn't reachable from userspace
  before the PMBus state the GPIO accessors depend on is initialised.
  Prerequisite for the new patch 5; without it the lock acquired by
  the GPIO accessors would race adm1266_config_gpio() / pmbus_do_probe()
  setup.
- New patch 5: take pmbus_lock in adm1266_gpio_get(),
  adm1266_gpio_get_multiple(), and adm1266_gpio_dbg_show() so the
  GPIO PMBus reads serialise against pmbus_core's PAGE+register
  sequences (Sashiko review of v1).
- Patches 1 and 2 are unchanged from v1.
- Link to v1: https://patch.msgid.link/20260516-adm1266-gpio-fixes-v1-0-38d9dd39b905@nexthop.ai

To: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linusw@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
To: Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-gpio@vger.kernel.org

---
Abdurrahman Hussain (5):
      hwmon: (pmbus/adm1266) cap PDIO scan in get_multiple at ADM1266_PDIO_NR
      hwmon: (pmbus/adm1266) don't clobber GPIO bits before PDIO read in get_multiple
      hwmon: (pmbus/adm1266) reject short block-read responses in the GPIO accessors
      hwmon: (pmbus/adm1266) register the gpio_chip after pmbus_do_probe()
      hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock

 drivers/hwmon/pmbus/adm1266.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)
---
base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
change-id: 20260516-adm1266-gpio-fixes-dbdb9c10a4c2

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>


