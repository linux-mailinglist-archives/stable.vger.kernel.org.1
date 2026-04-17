Return-Path: <stable+bounces-238503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AATHOaFX4mm25AAAu9opvQ
	(envelope-from <stable+bounces-238503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 17:54:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B46141CD57
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 17:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DED2306B129
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691E733CEB5;
	Fri, 17 Apr 2026 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZhzPPzE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251D233120C
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440829; cv=none; b=tuaFA6xEH5DLYcSzll7kPWQFch2+O2ESchbK7LxrEcGnGdmQ1O624hA4aXAKJgttPZNPrc0c/LScE7RRcrYHJtWFAbq71tpNXTecrVuuYIeRBpOmEEonsrG6xwitAj9zZOGf+jQy6SI7smBbWkIAE9KgZNA1goeoM3qeIwDItz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440829; c=relaxed/simple;
	bh=OOBXkL6e5lGReKsh2G2rUacRN5BRmdQ6UJPWCdKo7rQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OJRbyUcHXyrLRKhyOGLfWcpHJRjEu9cXqC7WneBS9HtZrJpRzDyCu+X+T9fHXIRhx7UZ0Ry9n8MPRXoTT6RNuYuV5Ii1IBHlhd9hKZlfC/XdbFJtdACBHPBwspdpE4egjoUP5wKI1JufRRM0dqwf+s0xA8xRbX9UGdPbofEsbGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZhzPPzE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35fbaada0caso842154a91.3
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776440827; x=1777045627; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sn0iymoZMFrhHdIio6IfCKaXrnb3ooLaXVVViF/0l44=;
        b=dZhzPPzEJ9NnvIqmSfPnPeqZ1ROxSUJ0azZID43OjFWVMqsWrTQwil1iH+rkmttPYD
         SMhJX0CXjrMAQvnlfXjD8rfjnPJJdytHGQIfFj7BmABJe4SLYJpAOEDS+9mrFN2L9XLA
         yDEEF45lKyb/GgY/hIrNl+BR+SowzPK8RmcDW4JgkabiFzcY9h4laxjbojrqLSU70GDo
         5KfjxCmlodMd7B15rMZrEDQ08NZDxxd46scO5BmJeLPC8krMLydV/rqXZ1lJwvMAk5t9
         G3mD0EEjCKmz8OcG9o1dTFMffhtpC9U80ejM0QuVGK7NZShlrANgl2ln4hQjq6z+5MN/
         4U+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776440827; x=1777045627;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sn0iymoZMFrhHdIio6IfCKaXrnb3ooLaXVVViF/0l44=;
        b=fW3lhvEWydNN4CMWaWnYMi/pydmARvxUm+k8C+4P0E9vr9hUxJ4WiQsmTGyZfzD0oo
         wOEZEpktIe8nUmCtzt7FMSgvt8Sgl6D2xQ96Rdv8ZkmMI6uBODgpoPaocPV76T4Xi7zG
         hvvLndNAi+h1Jh9cv2kFgXG2BUd7CIzSC64o0t9+LhD9sY3EFsnnMf/u9hTD/mOsxSR9
         tmiECVqYitbRzjlUN70FqfqGZv9jItCW05uX1uLd0jGa2BBEMTBYttCgf111p/Znm3gR
         7hnP3Q3u8jKUWig68K2NOsath4eDKMYgDjd4ZuOpxDWgAvgYZOCdMUpNN4yC+teicmHO
         +9gw==
X-Forwarded-Encrypted: i=1; AFNElJ/i8ZIpTqriZ/Y9+yFuxvLSeDyvjS2lLFhUUPauvTaIFtP0zosdPpwb65//hHV3hs985QWUIKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV0KQWfI7mFvs6cqG0YphUgZVKpv7o+Q5NUPX5TWrqVvfAEuU+
	fLhvp/QVEv+UGvulJytAFYsT30j8LFTsasWUZk/HYfYHY8XJ9YKIG3eLE9MduQwgZhyrDDV78FN
	aXopfdjddkeJh7569hA==
X-Received: from pjzi1.prod.google.com ([2002:a17:90a:ee81:b0:35e:5853:1ca2])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5543:b0:35f:bddd:3860 with SMTP id 98e67ed59e1d1-361403b18f5mr3679233a91.6.1776440827092;
 Fri, 17 Apr 2026 08:47:07 -0700 (PDT)
Date: Fri, 17 Apr 2026 08:47:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260417154704.1186803-1-tjmercier@google.com>
Subject: [PATCH] HID: playstation: Clamp num_touch_reports
From: "T.J. Mercier" <tjmercier@google.com>
To: roderick.colenbrander@sony.com, linux-input@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, stable@vger.kernel.org, 
	Xingyu Jin <xingyuj@google.com>, Roderick Colenbrander <roderick@gaikai.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238503-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B46141CD57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A device would never lie about the number of touch reports would it?

If it does the loop in dualshock4_parse_report will read off the end of
the touch_reports array, up to about 2 KiB for the maximum number of 256
loop iteraions. The data that is read is emitted via evdev if the
DS4_TOUCH_POINT_INACTIVE bit happens to be set. Protect against this by
clamping the num_touch_reports value provided by the device to the
maximum size of the touch_reports array.

Fixes: 752038248808 ("HID: playstation: add DualShock4 touchpad support.")
Cc: stable@vger.kernel.org
Reported-by: Xingyu Jin <xingyuj@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/hid/hid-playstation.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 3c0db8f93c82..8d06ddff356a 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -2378,7 +2378,8 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 			(struct dualshock4_input_report_usb *)data;
 
 		ds4_report = &usb->common;
-		num_touch_reports = usb->num_touch_reports;
+		num_touch_reports = min_t(u8, usb->num_touch_reports,
+					  ARRAY_SIZE(usb->touch_reports));
 		touch_reports = usb->touch_reports;
 	} else if (hdev->bus == BUS_BLUETOOTH && report->id == DS4_INPUT_REPORT_BT &&
 		   size == DS4_INPUT_REPORT_BT_SIZE) {
@@ -2392,7 +2393,8 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 		}
 
 		ds4_report = &bt->common;
-		num_touch_reports = bt->num_touch_reports;
+		num_touch_reports = min_t(u8, bt->num_touch_reports,
+					  ARRAY_SIZE(bt->touch_reports));
 		touch_reports = bt->touch_reports;
 	} else if (hdev->bus == BUS_BLUETOOTH &&
 		   report->id == DS4_INPUT_REPORT_BT_MINIMAL &&

base-commit: 3cd8b194bf3428dfa53120fee47e827a7c495815
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


