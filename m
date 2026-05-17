Return-Path: <stable+bounces-249056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL49FWYXCWo0IQQAu9opvQ
	(envelope-from <stable+bounces-249056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 03:18:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFA855EDD1
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 03:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4413300F9E4
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 01:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E2929D291;
	Sun, 17 May 2026 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="S6deXVSZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4151F282F12
	for <stable@vger.kernel.org>; Sun, 17 May 2026 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778980705; cv=none; b=psAMYUTqhBBD9fenw3VMy1QFCcn0uMbp9wSq5n95hSxp0Z1TXJBD/sfXr3lWBexB/Irq99GtZJF5arb/KFq86Xyew0ldNGx2Z7TH9uBB4IvI1hNRM1E5rkafJXZKxs90sLAuV6vr6n/my7s7PYAkJ7rEaEQGa/zC5PetXgdT3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778980705; c=relaxed/simple;
	bh=GQjtiAHaIEeCRfEDeKe738Onehgpu7DRDor1daydsuQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PlAeZwfPuPN99vMUoDr5uMwma04PXyMZWTjVYJepG+ny6KU6rngS6qsThFhn8zY3u3Kfn6Au3kTd6jmI4wAAvKIbi2JbTRzz7ZWU3x6QFN1p3f3Y46a/XXm+yJd1A11E+EVtiOC3qdxTb/c2y9czGnUN4S8AHFWm61Irz4T+5G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=S6deXVSZ; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ff5472f263so1042247eec.1
        for <stable@vger.kernel.org>; Sat, 16 May 2026 18:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778980703; x=1779585503; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zFk2wi9hJQ21WI9F1eIcI2hHlD/nbLPylZyn1rEwCjc=;
        b=S6deXVSZrT7VWqb+X6m3aDRojmRYCi8HJ1FrsqCMNbSD6IuWugRuZY0ZY5GAjtyTi7
         bw3IfR0wSm+YNOClhf7BXXIun/qgjWdWl+sQP0jMpVz3gsPu7iEVnv/cAsFI9BgJPBOo
         YDkGIECJApDUtOA62zAkKtVoutsFjXaSYihwM71np1NhRaxz7xh91KCyGcJNiV/2xW8s
         oL5Z2aN9VWR6rvRYl+M30pYTEHSbBoHmv5PwJ/tpZPLyh3TS/OTqYgBNDlz9LOKAUOOa
         c+0oBPQHaeTjLfBBVABVMQp0L5tYqwJHr6a3WO9mNlt5L4vpvdCMGJmCv1HaE9ryXOms
         J02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778980703; x=1779585503;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFk2wi9hJQ21WI9F1eIcI2hHlD/nbLPylZyn1rEwCjc=;
        b=f5F2HUiWTeFAhExDW9wolZAZXdnjhJzrQ7T1sy7vZ7MOPbgkJfNujo9J51PdeFHHu1
         tpWyoOkJRWWptyZGglEn3F7L+Dra33cGtdxjxVV8qXO8S5pD/7QUWRJwGnXSQX6/H3ea
         796Q4l8WvkCMfs9JXb65RFtdnZ8KVE9BoufPgc0Skme4FWlre+7G/fUcHLuMmsxclwup
         rfRBzgBrXNnPUXoQkzaUOCyvEq5zDOOo110THedv4LdafEHw880wL2zWzvjvUIONOZQm
         GDGaWhDXWVq3XB7JsH6H1sN73EQZaXCpApTZtjH3FvpvD7tt1dl1TiKIey9awukqWVON
         +zYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pNjVEKp6ugFCCDkvWwUSFQ5EbyLD/4mAl9HNsCsIsuU34XPqs1oodsc8y2MEgo40suOziqdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5L2ddx3tzWPwNssxL2uPaptSWtE3RCv8BQslQvGH/V9Fh/UU
	LOKf9vNuXbVLKc3zXdKYPIjHlGcTRLpgGS79DN6MSryknvm0Sk+obKCN6Gm2+vOMgzk=
X-Gm-Gg: Acq92OEf/0gE9I6EI9hrISf4HtMXQ0TU/xDsqm/JFFyQwMLK+Ontb3blsKXAxqrAG21
	+hhnxSOd+9MdU1r8hVsIbCN2uoVjFAgsgx5Kb1YfOYQ1vHtoL4vcXL/0HNW0qdkYW6wms4kCLif
	/WL8cPpIcKjaaegg6PVbONrVqmZm1sxDzrPGitHKtjLinqKI8QmX4h4mhpnzSGR4NerXZtyC+cO
	ebXlPGESprQjlozKSwRTDH7WmwvIsYazETfDPzHbuNE0qquZMMWb0sY2C5TpsnHASkxVirHx4X4
	5+I+OO+9zcECkh1KE6JGNdCZzjI0eiu82qpuoMIGvM4Cd0oAa/zRiBRchxZjGOMvqUuRvDC1Pkw
	l1fasBqzEoJ84EqTEwQf6aipHkK/ClvTmAdZ3MTdm5m2kJzX9s/o3Ny/09dKQjFPXoUi1skLU/p
	XWSQd3Dzo57FUiRxXM20sfhqMnbQ==
X-Received: by 2002:a05:7300:a505:b0:2c4:4363:3742 with SMTP id 5a478bee46e88-303982b79f9mr3671621eec.9.1778980703240;
        Sat, 16 May 2026 18:18:23 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bbd50sm10582179eec.20.2026.05.16.18.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 18:18:22 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH v4 0/3] hwmon: (pmbus/adm1266) add clear_blackbox and
 powerup_counter debugfs entries
Date: Sat, 16 May 2026 18:18:18 -0700
Message-Id: <20260516-adm1266-v4-0-1f8df4797258@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFoXCWoC/2XNzQ6CMBAE4FchPVuz3SI/nnwP46EtW6mJQCgSD
 OHdLRgF43GS+WZG5ql15NkxGllLvfOurkKIdxEzpaquxF0RMkPABA6QclXcBSYJN1YqG2NhZIE
 stJuWrBuWpfPlnf1D38h0M58bpfNd3T6Xq17Mvc9q9l3tBQdOBjJtMScwdKpo6Mq62SvH5tkeN
 1DACjFAqRB1DtKgFX9QbiGuUAaoMqHiNNegNfzAaZpebAWvBCMBAAA=
X-Change-ID: 20260507-adm1266-cf3af42dc3d2
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778980702; l=5769;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=GQjtiAHaIEeCRfEDeKe738Onehgpu7DRDor1daydsuQ=;
 b=UpQ+6FB2D4xrE98dUIszJvd3JFEKhaQIHKLbDy2buSvmUETNdcpeRqXaFVoZypH97TDZsUDtI
 LtZv41VaTvcAx/oMuzYy0R8L64czlSklncT907DisvCnpCu8rkc0HVZ
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: ADFA855EDD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-249056-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,msgid.link:url,nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is what remains of the v3 series after Guenter applied patches
1/5 (firmware_revision) and 5/5 (GPIO line label) to hwmon-next, and
asked for patch 4/5 (rtc_class) to be dropped.

Patch 1 adds a write-only clear_blackbox debugfs file. Devices
configured for single-recording mode (BLACKBOX_CONFIG[0] = 0) need
an explicit clear once the 32-record buffer fills; the documented
sub-command ({0xFE, 0x00} block-write to 0xDE) wasn't reachable
from userspace. The patch also acquires pmbus_lock at the
adm1266_nvmem_read() callback boundary so the memset of
data->dev_mem, the blackbox refill, and the memcpy to userspace run
as a single critical section -- the nvmem core does not serialize
concurrent reg_read calls.

Patch 2 exposes the non-volatile POWERUP_COUNTER (0xE4) via debugfs.
The same value is embedded in every blackbox record, so the live
value lets userspace match a captured record back to the boot it
came from when correlating logs. The block-read is taken under
pmbus_lock to serialise against any pmbus_core PAGE+register
sequence on the device.

Patch 3 takes pmbus_lock in adm1266_state_read() (the pre-existing
sequencer_state debugfs handler) for the same defensive-locking
reason that motivates the new debugfs files in patches 1 and 2:
any direct device access from outside pmbus_core should be ordered
with respect to pmbus_core's own PAGE+register sequences.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Changes in v4:
- Drop former patches 1 (firmware_revision) and 5 (GPIO line label):
  applied to hwmon-next by Guenter.
- Drop former patch 4 (rtc_class) per Guenter's review: turning the
  chip into a pseudo rtc_class device and making the driver depend
  on the RTC subsystem was rejected. The underlying CLOCK_MONOTONIC
  -vs- wall-clock bug in the original probe-time seed is fixed
  independently in the "hwmon: (pmbus/adm1266) buffer-bound and
  timestamp fixes" series sent in parallel, so the seed-at-probe
  behaviour becomes correct without this driver needing to depend
  on RTC_CLASS.
- Patch 1 (clear_blackbox, was 2/5): take pmbus_lock at the outer
  adm1266_nvmem_read() callback rather than inside
  adm1266_nvmem_read_blackbox() so it covers the memset of
  data->dev_mem, the refill, and the memcpy to userspace as a
  single critical section. The nvmem core does not serialize
  concurrent reg_read invocations, so the v3 placement still let
  the memset race with another reader's memcpy to userspace
  (Sashiko review of v3).
- Patch 2 (powerup_counter, was 3/5): take pmbus_lock around the
  block-read so the access serialises with any pmbus_core sequence
  that sets PAGE on the device (Sashiko review of v3).
- New patch 3: take pmbus_lock in adm1266_state_read() (the
  sequencer_state debugfs handler).  Same defensive-locking
  argument as patches 1 and 2; surfaced while folding similar
  fixes into the parallel "hwmon: (pmbus/adm1266) GPIO accessor
  fixes" series.
- Link to v3: https://patch.msgid.link/20260512-adm1266-v3-0-a81a479b0bb0@nexthop.ai

Changes in v3:
- Patch 2: take guard(pmbus_lock)(client) in
  adm1266_clear_blackbox_write() and adm1266_nvmem_read_blackbox()
  to serialise the clear against the multi-record nvmem read loop
  (both share command 0xDE). Also move adm1266_config_nvmem() to
  after pmbus_do_probe() so the blackbox nvmem entry isn't exposed
  to userspace before the PMBus mutex is initialised (Sashiko
  review).
- Patch 4: take guard(pmbus_lock)(client) in the RTC
  read_time/set_time callbacks to serialise against the PMBus
  core's PAGE+register sequences. Move adm1266_register_rtc() to
  after pmbus_do_probe() for the same reason as the config_nvmem
  move; /dev/rtcN being opened by userspace (systemd-timesyncd,
  udev) before probe completed would otherwise hit an
  uninitialised mutex (observed on hardware, also flagged by
  Sashiko).
- Link to v2: https://patch.msgid.link/20260510-adm1266-v2-0-3a22b903c2f1@nexthop.ai

Changes in v2:
- Drop the v1 "use wall-clock seconds for SET_RTC" and "write
  fractional-seconds field of SET_RTC" patches. v1 patch 6 already
  added an rtc_class device, so userspace now owns the time-set
  policy and the probe-time seed is no longer needed - removing it
  also fixes the cross-reboot blackbox-correlation regression the
  seed introduced.
- In the rtc_class patch, write the SET_RTC fractional-seconds
  bytes as zero rather than computing them from a timespec64. The
  rtc_class API is second-precision, so the divide that v1 patch 2
  was adding never produced a non-zero result anyway. This also
  drops the 64-bit divide that would have failed to link on 32-bit
  builds (Sashiko review).
- Use %d (decimal) for the I2C adapter number in GPIO line labels,
  matching the i2c-N convention used elsewhere in Linux. v1 used
  %x, which rendered bus numbers >= 10 in hexadecimal (Sashiko
  review).
- Link to v1: https://patch.msgid.link/20260508-adm1266-v1-0-ec08bf29e0ce@nexthop.ai

To: Guenter Roeck <linux@roeck-us.net>
To: Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Abdurrahman Hussain (3):
      hwmon: (pmbus/adm1266) add clear_blackbox debugfs entry
      hwmon: (pmbus/adm1266) add powerup_counter debugfs entry
      hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock

 drivers/hwmon/pmbus/adm1266.c | 77 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 6 deletions(-)
---
base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
change-id: 20260507-adm1266-cf3af42dc3d2

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>


