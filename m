Return-Path: <stable+bounces-230106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIp5JJ5owmmecAQAu9opvQ
	(envelope-from <stable+bounces-230106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:34:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2463067CE
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC00A3013FE9
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966583AEF37;
	Tue, 24 Mar 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nonF8wNc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9653E2774
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 10:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348157; cv=none; b=XL7Yuxnpd26HK4k+Bwy3PyU5dHeH4sHTXTKQt4vtqnrX9hrvvK3UtFEhPyPQUM0U/D5mO0QJoZJIj5KXt7jhlGAOTgX1wMlC1A9Av7xiNuVESOidXdmKhv5b+17z9tkTtqWgeOFn4KB5uBk+E7foezocFdy4ynn2HQdwpDzD8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348157; c=relaxed/simple;
	bh=i5EI1moGymL06UGxUyHFrUJcTR0LqBMbRoOOYGvAgAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7hn9COOXTHzvG56QC0911SqNi4PPpVzlV98PKZQF70e8R2V/vBtowydvOQJkpiVIYtPZYGqJsXKq9JMZOoNdxFSwNbvtCDEbjWqAT5qP6h+BimwKhkXGBBoyxbwR+UdyteHhbj3vfv0j1B2vah0IhePVaJ9JqHSMTpBgiZFtRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nonF8wNc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b976536806cso790517566b.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774348151; x=1774952951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRMqYkzH2ATFPczINkjP7Gb8RPcC4sgJ7rhsMNlJdGU=;
        b=nonF8wNcSzbhAdrGjDSpHWvz90fBdE4A61pfCFXNzNqK8IupaWr9JpfdpNONNI7H70
         ked3K6QM+m+7sih8kf1eusyqFEHsd+/EnuHW8udR+GL205/zQMsljxa9Iu2uQtPXRWdo
         DRqdj3B2LcyVtlsWQ7iuTbN1hiiLP4wMenCMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774348151; x=1774952951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRMqYkzH2ATFPczINkjP7Gb8RPcC4sgJ7rhsMNlJdGU=;
        b=jcGqqFDItSiFkUWDSWP9Hzz4o0wqo1c3cZAVhRzTpQ/a5mNJBSKE6jypL+kBunhqWZ
         gXQ90D2+LgxZbT5zOyo/hlhwMZ3XgCSEnTZcK7alPFXTwf8nSUyK1SvxLzErSEkdy/vy
         AMQQ0LLW1NfQqP65pXmAHdsoWbiCYLEuaWdLHJsdUuw1iRi2DvPf/3Il8RGC/zBUdqfI
         ifXwChZATd8muu25F4VHVsTFs5kD2LUx0X3rOmyU4JVILuNVsh25Evhfi9yln9jjVc1B
         SEb9EMOKTumbjNXCp51tqwUcmMlUQ2jjNNJ1+oPwagpd4ZmN2iCa/pvO3fyGz0IvOh8L
         DFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxsnzpR2lAIN5piC5d6k0CXfBBhmwScuPffIrWHSAk/mLlIFFuzMK7IPtk8xEBmpETq97n72c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxr/cjtDIr8nOgWlCHAZcSTyuz1LW+XHhKz+kJp/Uzm0mMOn4
	csknTEsVnVg91iVD3pHKBDwZHv9Y91+HZRQm7LBfiZ4kGxZSEcJQUOKhytpI6EBKCw==
X-Gm-Gg: ATEYQzzEge77dRFuKNX/8SBefA+ojeAo16RAf7ig0tz66szf3MfeVVf3MiuMVyq627/
	7EalYKieRFuy+zpurNMaDPikYP3qO6n18fOqAHprZqIyx1fh6Tn+BeEXY4yUtLlwlDDbGifFrOz
	2ES/eLl9t/4OwW5m2qKjWc7sd0wxEy/vTzA508I7VT+8FmEp9n53lXOroxjM1UfctSfXQK0mClv
	1IYEbTuyKipWuwvD2IMd+q7mM1jp3PQwWAwBnk4HBB4xJ/WTaJvpe5b1jxKIjue5WtlM1fb451a
	Bj+jaWG4lZSF2XQDPMOS6taL6IqzbD1SDb2wTt59kobjTLrzqdycxwpk1cR4rOivubRKrc1KEnk
	OvzI27o4QxwcHtqc7E121A3NGILEevBR2VHmv7kwdGZJ1snlLLlQH2hHbqJXUijUbT2tcerkBb8
	FNXdeImOHByQgjDH4Cn1WB59q9hB0G4vcgKXGaXd3FTcct3xI9D3RIU6Dao1hVGruVyAl01w5Zw
	jq1+5l3ixe4F6W8P70qs2oIEF9GxumbQQ==
X-Received: by 2002:a17:907:60d6:b0:b98:4a7a:d5f8 with SMTP id a640c23a62f3a-b984a7ae58cmr861028866b.46.1774348151375;
        Tue, 24 Mar 2026 03:29:11 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (218.127.147.34.bc.googleusercontent.com. [34.147.127.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f43a65sm613162366b.7.2026.03.24.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 03:29:10 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org,
	Madhu M <madhu.m@intel.corp-partner.google.com>
Subject: [PATCH v2] usb: typec: Remove alt->adev.dev.class assignment
Date: Tue, 24 Mar 2026 10:29:03 +0000
Message-ID: <20260324102903.1416210-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230106-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akuchynski@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email,chromium.org:mid]
X-Rspamd-Queue-Id: AF2463067CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The typec plug alternate mode is already registered as part of the bus.
When both class and bus are set for a device, device_add() attempts to
create the "subsystem" symlink in the device's sysfs directory twice, once
for the bus and once for the class.
This results in a duplicate filename error during registration,
causing the alternate mode registration to fail with warnings:

cannot create duplicate filename '/devices/pci0000:00/0000:00:1f.0/
  PNP0C09:00/GOOG0004:00/cros-ec-dev.1.auto/cros_ec_ucsi.3.auto/typec/
  port1/port1-cable/port1-plug0/port1-plug0.0/subsystem'
typec port0-plug0: failed to register alternate mode (-17)
cros_ec_ucsi.3.auto: failed to registers svid 0x8087 mode 1

Cc: stable@vger.kernel.org
Fixes: 67ab45426215 ("usb: typec: Set the bus also for the port and plug altmodes")
Tested-by: Madhu M <madhu.m@intel.corp-partner.google.com>
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
Changes in V2:
- Marked as a Fix

 drivers/usb/typec/class.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 8314309094719..0977581ad1b6e 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -686,10 +686,6 @@ typec_register_altmode(struct device *parent,
 
 	alt->adev.dev.bus = &typec_bus;
 
-	/* Plug alt modes need a class to generate udev events. */
-	if (is_typec_plug(parent))
-		alt->adev.dev.class = &typec_class;
-
 	ret = device_register(&alt->adev.dev);
 	if (ret) {
 		dev_err(parent, "failed to register alternate mode (%d)\n",
-- 
2.53.0.983.g0bb29b3bc5-goog


