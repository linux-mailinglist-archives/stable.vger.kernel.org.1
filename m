Return-Path: <stable+bounces-238658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e052J6M75WmTfwEAu9opvQ
	(envelope-from <stable+bounces-238658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:31:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CCA425743
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FE9C300490D
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12E82DCF61;
	Sun, 19 Apr 2026 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpy3apJh"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814011D86DC
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776630687; cv=none; b=ZzyZlcYs0LbhhCYuVSOQ3aOgFWwyMoifiSVBEB43dIFDTr+SU9QnKrEpxOt7Fua2GRq3MscTUQ7w7E0p6RS2FQ5P/1c/jXz5l61otNKlaG5uM9Tu7CsvApSY8a4LEatZ7OY5xyCHoFgIubiYxmPoxRv2mlAb+g85qzSnCQZqsNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776630687; c=relaxed/simple;
	bh=fOysJetftFuDAfilt4YkPpmsqDf72fBKOBho/z6x7Ns=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=agcMM0ZMQT5Ovouth9mGAFnp77ZRSBWoFWPRQqBCiJUfqMRwXfr7yIuHHtNjwYPvNMhaqU/RYxXxw2ogdAQkfhbvlwCghijgtFU7fEGSC5wMae2Y1oKXaz8ZgRKM1vq4gYFi7WuJN/m6ebz+1rvHWzJTQ/U/eGr4Nd7qQMHzDrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpy3apJh; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so731861eec.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776630686; x=1777235486; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KM4l3haLMhwkG2gE+Q3bWokNzUlY9nmC6/W5mIqwYTY=;
        b=gpy3apJhW2NlLLJgqIPGUA0QQfKFcwgciVBsLQGtlH1xErD3HcJ/qU9xTuxmTr3Y55
         95rPB4Atc37uQp82y02zVUzIwtcEfsdhCnY1wTgwxoyVMudK8QFjp/QucN6TNN0fSJJb
         La6jTjvVzwpu795H1cWQIvunmoXz4X4U95xFZ9KhM1lmZ+HNnvu1DQKIYvF+2xVhp84p
         7QeYLUB24Ity1GCyPMxi34GxEr7f+2n0KuPVldDotTB/14iEPUvg2BWS+O7qTQIXtEww
         mZcerKv2Kd4ccRT6cFQo9PYBStm9c2ceME/nHRrQ3aeEZRhyEjksueEE3AbSY3MhhHGn
         liCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776630686; x=1777235486;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM4l3haLMhwkG2gE+Q3bWokNzUlY9nmC6/W5mIqwYTY=;
        b=omDGIKlTibotNbWzzV7tLmgqDRhKB7x00upeqzDwRHBvri41NrDyvEiUuswiY0pZlu
         HrIG+cDfdNtOiayuUSZxVQSs2ZBkCiPQivLvaLKu6A8ZPrHrMGVPJQaYDo0ObZqU1/s4
         0WoIWTLO54p2R4pxn+sAN4riKgsnKGB5ZCUp751fFQK7pvYlBzfwB7lz4o2Jx4RqSqrt
         ojrFHJMWUxM4wYhjCgVOWi5qzWET2cPV1DuuMAQV3Q/cQ5G83pE65tHcmZn8EscyoYOG
         +f7afvekHlosdc43T4OTOA254NTT3UKsGiaH7X83bwz05Lf9qOoZA+4We6jZK11zbyTa
         EQZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zWLzuW1Q9UHh+G5Lvq7qvE4o5Oq71EvGRVZMpRKWTxjoVqH0asvN3hHlZrV3mHhv+g2Bf/Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDo7HAAI8jA28VGR35QEV+mvimTmD9C+BZqRPbSVyP07XLyy9
	Tj4BfRxUPYhrmrT8uWlhYXrqc4AywnhPi7dkaN9ePQ18TdP1YXbqosTM
X-Gm-Gg: AeBDievrYjfBuVDxl6RYFP3+EXwm6jnNYE1gumDPP8Cl5UlAUmmtT5dXJX3Yxq6mqF0
	jXeesfFKii8I3VdyEpfMqvEFrn/9An02kdCgNFWuznFfYwAPczN2wzrxvJbSD94GIYJ4Llw5niR
	m9r6zHyRqEoT68yLuyswXbvIY30AXUUQV7UPOra39IBjI8Mt9dNLehvDoVHxYE8+femja3U+ac2
	TYMZ0WFcQ5nXkMggJxGqYjsGD73ukKM94zqNRsCJCnuwHhWnbjI4VYtWZKGH6sJpt6iRp23J+0z
	w4AVg6e6no/ppXCoLDBNMV6MTI9pNXiYtAXUPbFkmAd4oBEULdVPG2ChMyKZLfO53Q4AKl8flT4
	Jp81qt3f7WjivluCQOxnxw6k6xc+juUCJwfC1Qt03fICZ/fW3B7q0MEw1ij8x33nEbtla32shBs
	gldyrsQzJCptktdBylOgs544h7xWxTtuJncNZslyc0FV1P6yspaVVN2Ce1ZER9aojfLvU+wXKph
	Rrxzo6pmhenqMA=
X-Received: by 2002:a05:7300:f193:b0:2da:1874:f39c with SMTP id 5a478bee46e88-2e4657728eamr5493770eec.12.1776630685523;
        Sun, 19 Apr 2026 13:31:25 -0700 (PDT)
Received: from [192.168.1.18] (177-4-160-195.user3p.v-tal.net.br. [177.4.160.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ac84c38sm11419096eec.13.2026.04.19.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 13:31:25 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Subject: [PATCH 0/4] usb-audio: fix mixer write failure handling
Date: Sun, 19 Apr 2026 17:30:28 -0300
Message-Id: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ7CMAxA0atUnmspjSBSuQrqkBjTmqGJ7BSQq
 t6dAOMb/t/BWIUNLt0Oyk8xyWvD0HdAS1xnRrk1g3c+uNMQcLOEL5XKyKpZsWgucY61degdhZE
 9nSkmaIeifJf3736d/rYtPZjqdwnH8QF5hrAafwAAAA==
X-Change-ID: 20260416-usb-write-error-propagation-20c69e2c5cab
To: Takashi Iwai <tiwai@suse.com>, 
 Chris J Arges <chris.j.arges@canonical.com>, 
 Detlef Urban <onkel@paraair.de>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=fOysJetftFuDAfilt4YkPpmsqDf72fBKOBho/z6x7Ns=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJlPraeYuLdNjrNad5+jhvPkxoMx1w55LnbQt7u1Nf6LR
 zDn9cT7HaUsDGJcDLJiiiyrkxZZ7ul6cLU+boUHzBxWJpAhDFycAnCTuRn+55i3LcyacVLB6yPr
 ln+nSuL45Bms3WutmndncvaUOm8LZ/hf+27/t4XWtVtYuT5edn6atTP+xkLZKUZ3JwV7fks42PG
 fDQA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238658-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36CCA425743
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes usb-audio mixer put() paths that currently report
success even when the underlying device write fails.

The issue exists in the generic mixer core callbacks, the Scarlett
Gen1 enum path, and several Tascam US-16x08 put() callbacks.

The US-16x08 EQ and compressor callbacks have an additional bug: they
update their software shadow state before sending the USB write, so a
failed transfer can leave later get() results out of sync with the
hardware state.

The series is split into four patches:
- propagate write failures in the generic mixer core callbacks
- fix the Scarlett Gen1 enum callback
- propagate write failures in the simple US-16x08 put() callbacks
- commit the US-16x08 EQ and compressor shadow state only after a
successful write

Successful writes are unchanged. Failed writes are now reported
correctly, and the US-16x08 shadow state remains coherent with the
hardware after write errors.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
Cássio Gabriel (4):
      ALSA: usb-audio: Propagate write errors in generic mixer put callbacks
      ALSA: usb-audio: Propagate errors in scarlett_ctl_enum_put()
      ALSA: usb-audio: Propagate US-16x08 write errors in route/mix EQ-switch put callbacks
      ALSA: usb-audio: Update US-16x08 EQ/comp shadow state after successful writes

 sound/usb/mixer.c          |  17 ++++--
 sound/usb/mixer_scarlett.c |   4 +-
 sound/usb/mixer_us16x08.c  | 127 +++++++++++++++++++++++++++------------------
 3 files changed, 92 insertions(+), 56 deletions(-)
---
base-commit: 99c71f13f9841f8c67fa7595bf0834d3045f5d24
change-id: 20260416-usb-write-error-propagation-20c69e2c5cab

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


