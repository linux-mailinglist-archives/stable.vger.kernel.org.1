Return-Path: <stable+bounces-241891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBjkHqEG8mkimwEAu9opvQ
	(envelope-from <stable+bounces-241891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:24:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A46494BEA
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6F0630D2EEB
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F7B3FCB13;
	Wed, 29 Apr 2026 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB1FcybH"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434063FCB14
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468817; cv=none; b=afhWWlB5MDhDnfAm0Vnaf0i/LZ0g1bAKnlvyNkgXqpib/TIFjm8ukrcGMKQl4G/98Ve9/QyLx8JCxhbN6axOnDT4Om6hoHunU9HA6xqPsLbqeQkeflEK6tYPMpNWFEV3c7s+nRUeCWR1yOUvc8Q/ghpbQWBqfmzU8mJoaRRYDdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468817; c=relaxed/simple;
	bh=V+z3lB4+pCRWf3agDWSa+KADY1fFSo/WBirj1hovzuM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qZCcT9z0KVpg78g6hpjkagALMvg3wa758rD/J+G8MPHj/7mc6lTGxBeNkkgPiqy6JMRmJ5dprzL7FlFHzZ/UHdoCf6mC2e/Ni6WcMcOkBflRgjEONaIia7FMygDJ3LCn39r7yOTPJ24YhcrG/GLJCyDK1nNeMY3d9KM4FlIWK8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB1FcybH; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c6df0b9bbso6392265c88.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777468814; x=1778073614; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=miTiWvSjRX28D9+/gaoocQinz9zlsPUu/gC8XD44ro8=;
        b=EB1FcybHBRKOF8TbvlMHJov0pXbugl6AHmTT0K3xDiSuEaeBlAZe5vm/QDUud+5kr1
         KsHPrE42R6Quey3Gm2P9JEMuMd33hw8GI5GTurZv2QqqQ2scbpowxapkd7rLatJGHwGa
         j2BOE0lc5Nmp2dG/xImqu3q5WyIhYyexVZ2R7QvXMAvEsZMIem//tSAV9IwDo9KPVqsN
         2o+chj3otlH4mxUDcobWzGpS92z6cWvqcaz5BvlfrVVWrf+qJhMWLW4yWPQJ1XAbVKOH
         wVCDEond4VHx4O/fWHaoWIXyVJdpY9i51Hjr/SWm3QFA/kh4kSF9eOZb3Mc+o8JhLnrr
         l61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468814; x=1778073614;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miTiWvSjRX28D9+/gaoocQinz9zlsPUu/gC8XD44ro8=;
        b=IM+xAdUM0WhdufBbnpqphuZXKJpq+bykw/uDEFN2kTwQXaq/KUl1x7iHBODDr8okJ+
         P1QKg1rdkgdF7QIPtM8YAcGFb3bvOLwFXzmghKg3Lerg75z4PBz+attfK31ANYxd2wtf
         lUL+pPg/o1z3VFvohLWNU0l20z78RwVk2HVyBK8uigbDQxeyAAV9P3b2vK3fNx794PhI
         NKpLNvp06iqg6q/Un4MnAcgk4vBkovhXLlwq0HpoH4A7uYKeOXwpxrJLTPPQuX6nZ7cY
         w6HGg/S17K+uUZhl0bixgP/qjqBy8PmPJ11K8q2nTfbeEmpjUB7ORPbIE1S/9d0gKtWh
         5xKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8t4guTulGcPt2XlHTY4YXWJ0NItSc6oXOsy6te/aUPuelkC0YteeLxa2c3jo4pCcaZhMkmPVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6tFQbFPBjCXizADBUSjO+VXmqRH+vY7Ew0K35thz/vjL+7zGt
	8bpIUPGIlxxJNzcMo61oTbRMI4SMrEOElKzgEF27fUkWtVvKxlIIt4bV
X-Gm-Gg: AeBDietzSTIzToObSanZtystEGd/qFy4z+t+IsddYAxXUSrNI4XFlI/2t5FYUMqRxDy
	SFixrxA7ThYHFchB4VgyrW3s8wxLYw6OW0vhmRmUdZ+UukIEGsrzI2RggQz/bn6cOKYjkROU6h+
	rozWEw9RwBtb92zWHe6dV9DQ4r0BdUNXlvu/nEGEw0+uYs3XBuglH9NS+qq2MjGrlB2yoWj8lmw
	ePBo7Dx08OImqgYee/U3YhbqLDycJIPEJu45HMl5wS021rBiFyih30vbAo1WQarH2DjEqLXe0Df
	YLzstPRc/QofLnUGEBOxjvIHkCzaMwLZq3srSBT1QD7S4mNfkwSk46/OLXPWlggPd2LCD4d9VH0
	UpKS4oI9neCUgXdVMwnKik61Fhz6DqwSUtSPhK/gCmflj2BYe7gq+TmRPoxkC83RL1JEQKJ2Pod
	bwxee6rcMtpfiPiu4+HoQi9OzPwQo09KJOZjX2zoA7fk7nEEvsDwWseNCI+DaBprppZZC5UR9Js
	mohobRis+5k
X-Received: by 2002:a05:701b:2908:b0:12d:de3e:52c7 with SMTP id a92af1059eb24-12dde3e5305mr1742619c88.43.1777468814248;
        Wed, 29 Apr 2026 06:20:14 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de321df36sm3336852c88.7.2026.04.29.06.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:20:13 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Subject: [PATCH 0/2] ALSA: usb-audio: Fix stale quirk control caches after
 write failures
Date: Wed, 29 Apr 2026 10:20:00 -0300
Message-Id: <20260429-alsa-usb-quirks-cache-rollback-v1-0-01b35c688b80@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNTQ6CQAxA4auQrm0yjPgTr2JcdEqRygRk6hgSw
 t0ddflt3lvBJKkYXKoVkrzVdBoL6l0F3NN4F9S2GLzzR9fUZ6RohNkCzlnTYMjEvWCaYgzEAzZ
 7cid38J33DCXyTNLp8htcb39bDg/h17cK2/YBE6Q4joIAAAA=
X-Change-ID: 20260418-alsa-usb-quirks-cache-rollback-43a07052f22c
To: Takashi Iwai <tiwai@suse.com>
Cc: Thomas Ebeling <penguins@bollie.de>, 
 Ian Douglas Scott <ian@iandouglasscott.com>, 
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=V+z3lB4+pCRWf3agDWSa+KADY1fFSo/WBirj1hovzuM=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJmfWLs0PcQW2ih92uabLqp6NUTi/tcfdbzmxzh3vjCc8
 nN/yNO/HaUsDGJcDLJiiiyrkxZZ7ul6cLU+boUHzBxWJpAhDFycAjCRtwEMfwUYklX2XOfZMTFb
 YV3+TIG6F9snhS+9fm65IfeTLY93lB5k+B8Zymu/nfGZD2tidXsz73+9y8pV9otW5oVPu3zY5Oe
 yL1wA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 07A46494BEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[bollie.de,iandouglasscott.com,perex.cz,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241891-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]

This series fixes stale software cache handling in several usb-audio
mixer quirks.

A number of quirk callbacks update kcontrol->private_value before
issuing vendor or class writes. When such a write fails, the driver can
keep reporting and later replaying a value the device never accepted,
because the corresponding get and resume paths consume the cached state.

- Patch 1 fixes the simple single-write quirk callbacks by restoring the
  previous cache on error.
- Patch 2 fixes the RME Babyface Pro packed-state callbacks by updating
  the cache only after a successful write, since those helpers already
  take explicit arguments and do not need private_value to be updated
  before the USB request.

The split keeps the generic quirk fixes separate from the Babyface Pro
packed-state logic and keeps each patch tied to its own introducing bug.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
Cássio Gabriel (2):
      ALSA: usb-audio: Roll back quirk control caches on write errors
      ALSA: usb-audio: Update Babyface Pro control caches only after successful writes

 sound/usb/mixer_quirks.c | 61 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 14 deletions(-)
---
base-commit: 7b04e87c2a10db9c65b3133949bbe1b738b6ed7e
change-id: 20260418-alsa-usb-quirks-cache-rollback-43a07052f22c

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


