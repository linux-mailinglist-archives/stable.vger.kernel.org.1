Return-Path: <stable+bounces-114948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6163FA31376
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 18:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBC71888E72
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D5C1E1C36;
	Tue, 11 Feb 2025 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlwDclHu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590741C7F;
	Tue, 11 Feb 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296130; cv=none; b=KXZ+75y2FhEWoKKjJ2yTqsUhN4VYlRCMFxDyIzXxtZeaAgUP48J+f4ZXVpMUm3A1GLnkKVAUtveQ+KB70655TOl+8XoFbJrpcN1cqVN/+YUAndhqtJd05cr/+/pRPaSLKRXhqDcRPBEQ/dCKOohvwsLt07aY6N71ijOjqpEF90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296130; c=relaxed/simple;
	bh=ccY5BIjSEiY5JgWoG8f8RW4gkIN1Q7YjhgwwkVkhgKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SHvjiIVS5/cyFxKeUSqCxF/orz+23t8P9DyL344J5Y0rn+eRW8I7upiAru47fFctmi0Lr3f7KxmdtRozurMZ1Zrhk4Afkw/YvUEBUaSPs2vW+VSlx7Nn2yeKBJsoixb8+08i1zMEvAHGCtx5yqlAxclZfL8bz6CsJwV6JuaVpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlwDclHu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fa51743d80so4765390a91.2;
        Tue, 11 Feb 2025 09:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739296128; x=1739900928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQowQWiAJelJlI2iEmex+lOXVXcguom9gOW3fCrq5J0=;
        b=hlwDclHuApnJKPC/CrCag3/BflEKsDzxLmhCJjD2AQLLFjaer9Qog38mVJQzD0t8qW
         i6qly0vOWjve47RaecEq2K0/vH06oLFtEZyXuR5wez/wFWP/kA4zNEDeZe2hdrPlUKqu
         tLRe+ye+asBHIbxH58ZCs2VeNcKHXK29hr1h59VWamudgvrsbZrNLLU0Zw8xOL9UG25Z
         k6PUGlTHKYQ2J91qVbbDnsBby1qboGmb/XSe4Ge9joyZ0KOEr9v+BGTkB/Wk1WYCHIi9
         nSNdVdUQhMg8nWmakmrmJ1s5M0j0zCW8q7W88tLSfdigsURMIf+ukaZNaaasEj/36KIs
         Qx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739296128; x=1739900928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQowQWiAJelJlI2iEmex+lOXVXcguom9gOW3fCrq5J0=;
        b=mLyfJx9gPCueJjKEKoTAM19CrAkpu3vpPi3gGo73uV2Wx2c1JpM4/2ztUOY7O1wlAa
         tb11YSUKopfCNa2Bol+K0cccibVy9WP2sTTta8g8S6am34NpfMXv3uKKfjMP7c8Qpgif
         /zzWZIAVSegrmnilWa0ENoy2yComb6ciSLoY5T9w02IYLG38treBsmAjk/91pcSUeyhj
         q2WjQ475LOSITp5oQziAlTQXRZZlTDW6yhAxuWuANjCnnltWF94KVwsSTYs4aUbkkgVT
         pSHF1IPw+JjTS4nZOQ+UzBc4O3xH7Mz+cpkJpkJc87diTFFz7jgLZS1zeTvAXmvIUDBs
         AX4w==
X-Forwarded-Encrypted: i=1; AJvYcCUNH7/cz4UDc7BZSJO8oOjW+Bv42iGYPMBJd1PWAqsdHfVJ1WXCFZTNz8jF37lLK0asUUR+C1hF0ACc6kA=@vger.kernel.org, AJvYcCVebECQpz8nBctQhCfoODhqC7elaJRQ0PG5CXeb2bTZRU6n+qKu4RxpaKyyYolXorwKaVCYloja76Mo@vger.kernel.org, AJvYcCXMntBpy14UXqA895tIxXlXJObD+gQK72QkLsgcOS7OjOwBB4JF4qQhcdZkiTWqjzI6d9CMdCGL@vger.kernel.org
X-Gm-Message-State: AOJu0YybErHbNRLulOYqbe8dwaxGYKOjdXcQHosOvLDv08O1f1Af139C
	NISSzKAz7a2ql45F08lu5T4pW6lie8dxfEQ2bmGSIt0iEs8FOqsd8dDd956I
X-Gm-Gg: ASbGnctXXwQrxZhO04kyMbuDv8CVa72xeB2fdagqRsOLZGVxVAub06W0bS/HHyiIxds
	u2jUq8lIlNOn/udQPIUQv7hSK4O1MZOVKZFftKhG2JC1E+kPFPO9TBlIu6OqTXlYrehrEbhxtrn
	sxtYuYPEULeOeNDJ6m+GGu4kUIT3jHUjR25+6FGBGUm3x6Mr7IMAklQG4zh8y/tg8OUpSlaSDMs
	V/D+GkDQIZYtjRgjmz5F9Ft/T0HhvzJpmD56ZMqh+HG0kLp7W/aQnd+gp7opwF8RaZsZzkBkib0
	cJq5slJxYtXh0XTTdRpsRsNqd7vguPPSiOOXsTtfPjCKabvQXr0IEmeFyh02mV+E1z/FQqKjRIE
	f
X-Google-Smtp-Source: AGHT+IHWEcDUqeIjF2UczikL2kH+m/RHHuupuS5FDT9TP0QKfKb9Mvo6k4+5bwf7BlDl1BDFumVxqA==
X-Received: by 2002:a17:90b:3c0e:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2fa243ee52dmr31720249a91.33.1739296127959;
        Tue, 11 Feb 2025 09:48:47 -0800 (PST)
Received: from localhost.localdomain (c-73-98-126-133.hsd1.nm.comcast.net. [73.98.126.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa13d6a640sm10469385a91.1.2025.02.11.09.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 09:48:47 -0800 (PST)
From: Jill Donahue <jilliandonahue58@gmail.com>
X-Google-Original-From: Jill Donahue <jdonahue@fender.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jill Donahue <jilliandonahue58@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] f_midi_complete to call queue_work
Date: Tue, 11 Feb 2025 10:48:05 -0700
Message-Id: <20250211174805.1369265-1-jdonahue@fender.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jill Donahue <jilliandonahue58@gmail.com>

When using USB MIDI, a lock is attempted to be acquired twice through a
re-entrant call to f_midi_transmit, causing a deadlock.

Fix it by using queue_work() to schedule the inner f_midi_transmit() via
a high priority work queue from the completion handler.

Link: https://lore.kernel.org/all/CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com/
Fixes: d5daf49b58661 ("USB: gadget: midi: add midi function driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jill Donahue <jilliandonahue58@gmail.com>
---
V3 -> V4: Adjusted changes based on latest kernel tree

 drivers/usb/gadget/function/f_midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 837fcdfa3840..a188648d7528 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -283,7 +283,7 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
 			/* Our transmit completed. See if there's more to go.
 			 * f_midi_transmit eats req, don't queue it again. */
 			req->length = 0;
-			f_midi_transmit(midi);
+			queue_work(system_highpri_wq, &midi->work);
 			return;
 		}
 		break;
-- 
2.25.1


