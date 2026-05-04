Return-Path: <stable+bounces-242920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JseDjdd+GnatQIAu9opvQ
	(envelope-from <stable+bounces-242920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:47:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5594BA78F
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EA8930138A0
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD868342144;
	Mon,  4 May 2026 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnsNA/ma"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCEF289E13;
	Mon,  4 May 2026 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884463; cv=none; b=UyAYe2YZCK785Kqn3kuDJRKzV07uC4J/kKZiQRHcCyYW7rLetvW773ZZt2equZl/jADp4DYnydkGL08e65DJL+vqgUVhue2ysMFBXNPH7aJG0/qeScHbcsOia6P8dY2uW/JQ/4YABUG0zqVKuwFQx3A9AvM+0Mqzpl3/YmLNjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884463; c=relaxed/simple;
	bh=b3z35is89oPXeENyhLsF89vCn8J4SZIObLZfQ01bcQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TTlvadZaChKEjuiJpRKLudYcbZcX8XATQ1sCcaXqRmrlPJCVBr6RLpfudlP4/kiS3iL18TuSLUrJ5OVyefMZ0IkDJ30h298in3mBj0kx4/vFWSK25j34kjToBFm3+EdPVyzhn6STNKIIkOEyRX+G7vTlnLwGJyYOBYiXOgN1M68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnsNA/ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABCAC2BCB8;
	Mon,  4 May 2026 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777884463;
	bh=b3z35is89oPXeENyhLsF89vCn8J4SZIObLZfQ01bcQA=;
	h=From:Subject:Date:To:Cc:From;
	b=RnsNA/makSoQ3GKhXZ7RamY3KP4fb8iU5LMyDvdMQsxTKLLeDPRHlrZSrSPddgJHn
	 qnq1kwn9KqDwoQ3rotidKz4FMqAI6ZTRFhuT9XUZzFH4fxOChmXwsl4ApBLqUrXmck
	 6O2PLa1RUlnArZtLAU/ONFSlc7pFJExQ00y7JShaqYdjV/EgEK1I0cDG3b/jslwdHD
	 OsyJclo1/rt58u3Raq6zeWnDCZI0K/VleAQUmTFfYGf1zkwCvLpiI86wOHkRfSoWlW
	 j3C+UPWpyUysZ1gN8uaJWq/uZ4NKidN08hpHk2UnDS99U+PWH+5f/Q1FYsllbXKv/q
	 Xtrum7QyJyacg==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v3 0/4] HID: Proper fix for OOM in hid-core
Date: Mon, 04 May 2026 10:47:21 +0200
Message-Id: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMQQ7CIBBFr2JmLQamBaor72FcKIwt0ZRmMKhpe
 ndpV2ri8v2f90ZIxIES7FYjMOWQQuwLVOsVuO7UtySCLwwo0chaafEIg7iEp3CRSVjfaNdoZch
 LKMrAVL4ldzgW7kK6R34t9azm9U8oKyEF+crVrsFKWb2/Evd020RuYS5l/LTNj43FPtMWtZWkD
 dove5qmN9NKrg3nAAAA
X-Change-ID: 20260415-wip-fix-core-7d85c8516ed0
To: Jiri Kosina <jikos@kernel.org>, 
 =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Ping Cheng <ping.cheng@wacom.com>, 
 Jason Gerecke <jason.gerecke@wacom.com>, Viresh Kumar <vireshk@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: Icenowy Zheng <uwu@icenowy.me>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org, 
 linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777884459; l=3032;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=b3z35is89oPXeENyhLsF89vCn8J4SZIObLZfQ01bcQA=;
 b=TQu4P6b/RpFFvIMfL1ijYih/MvkNRh3fGMcO4Ui85Axyhiy6Mph0TvOIA5M5ZUHVq7eeGevLa
 ZMI+iRgeurEBZPCLqYX6YRidM81bx1IftPpaEpZ8G6P4UNKjQPfQCFz
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Rspamd-Queue-Id: EC5594BA78F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242920-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bentiss@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
bogus memset()") enforced the provided data to be at least the size of
the declared buffer in the report descriptor to prevent a buffer
overflow.

We only had corner cases of malicious devices exposing the OOM because
in most cases, the buffer provided by the transport layer needs to be
allocated at probe time and is large enough to handle all the possible
reports.

However, the patch from above, which enforces the spec a little bit more
introduced both regressions for devices not following the spec (not
necesserally malicious), but also a stream of errors for those devices.

Let's revert to the old behavior by giving more information to HID core
to be able to decide whether it can or not memset the rest of the buffer
to 0 and continue the processing.

Note that the first commit makes an API change, but the callers are
relatively limited, so it should be fine on its own. The second patch
can't really make the same kind of API change because we have too many
callers in various subsystems. We can switch them one by one to the safe
approach when needed.

The last 2 patches are small cleanups I initially put together with the
2 first patches, but they can be applied on their own and don't need to
be pulled in stable like the first 2.

Cheers,
Benjamin

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v3:
- fixed ghib -> ghid in greybus
- fixed i386 size_t debug size reported by kernel-bot
- Link to v2: https://lore.kernel.org/r/20260416-wip-fix-core-v2-0-be92570e5627@kernel.org

Changes in v2:
- added a small blurb explaining the difference between the safe and the
  non safe version of hid_safe_input_report
- Link to v1: https://lore.kernel.org/r/20260415-wip-fix-core-v1-0-ed3c4c823175@kernel.org

---
Benjamin Tissoires (4):
      HID: pass the buffer size to hid_report_raw_event
      HID: core: introduce hid_safe_input_report()
      HID: multitouch: use __free(kfree) to clean up temporary buffers
      HID: wacom: use __free(kfree) to clean up temporary buffers

 drivers/hid/bpf/hid_bpf_dispatch.c |  6 ++--
 drivers/hid/hid-core.c             | 67 ++++++++++++++++++++++++++++++--------
 drivers/hid/hid-gfrm.c             |  4 +--
 drivers/hid/hid-logitech-hidpp.c   |  2 +-
 drivers/hid/hid-multitouch.c       | 18 ++++------
 drivers/hid/hid-primax.c           |  2 +-
 drivers/hid/hid-vivaldi-common.c   |  2 +-
 drivers/hid/i2c-hid/i2c-hid-core.c |  7 ++--
 drivers/hid/usbhid/hid-core.c      | 11 ++++---
 drivers/hid/wacom_sys.c            | 46 +++++++++-----------------
 drivers/staging/greybus/hid.c      |  2 +-
 include/linux/hid.h                |  6 ++--
 include/linux/hid_bpf.h            | 14 +++++---
 13 files changed, 109 insertions(+), 78 deletions(-)
---
base-commit: 7df6572f1cb381d6b89ceed58e3b076c233c2cd0
change-id: 20260415-wip-fix-core-7d85c8516ed0

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


