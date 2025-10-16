Return-Path: <stable+bounces-186189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B090BBE51BD
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 20:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E2F4353F3B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 18:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4391D5178;
	Thu, 16 Oct 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="k/hiIz1x"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6E235362
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640675; cv=none; b=gDrtQvkRGss8LFl/YI2jrkqQAyUwU8/hhVCPd4vetWnnMsw+aIvnnyWX7RDM1LGRL56IMRa67X9r7u7klQWfF6wQ70L30JR45vNUGgfquNk/ZvF44n9uZ3Sq6x5Q1p0lTchovF1z7lsx/zZEVA5yGkEsCxPIPLVHMojqosdjHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640675; c=relaxed/simple;
	bh=/AgiMSpn+URV5Ye3Nl7rN8THQzzFT4uPuTaPHsWALII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq3IRWpEJrytH3T9hqkqFDk0lsyvPkj7B/BlgQxQedQM0V+vy+oSEghdlIFum62sJozLj2lRPWSKyaD3XSKI/jm0qeJcgk5pOYYPz3VZ6/ZNDOqKNkyvddGtMdk1v9ZnBBtP8JRwMSzZqPANlIdQkJqqb77ipPTTaVnzv3vMqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=k/hiIz1x; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-441ebf53e0bso306879b6e.2
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1760640672; x=1761245472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWt3FMbuNYY4LoP/SdGSB5kD4kfdEEsUuEvg84Tz12s=;
        b=k/hiIz1xa2ivSyWBnuZtTMUNka1MtdBwgarcuodn1xSvtcd8vuRJaF3NyE0S1yt/i5
         mWURJ20FkPBDVtyd42zCDEuyQx12p3R9DjYWM14UO7/7Fcer90mOwoWw+1vF08GsIW4o
         I6eg+Qz2ecQlEPtxgadanvC3/0BD7ehRIHtSR4utTqLGFTDgpQbErQJnFhYPxmlsyOVh
         zwwl5t47M5BeXd/HIyTC7/j/FvPtlOGWFy+Z8IJrHpVQwVUW1u2aLCAF9qV3UNNdzp29
         sPxyYscet9tnJrDxaLWhogMfV9W6irPC4TdqQ5mxNDYLcd2dPfvyidIPHIXVmjJHt4wr
         p0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640672; x=1761245472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWt3FMbuNYY4LoP/SdGSB5kD4kfdEEsUuEvg84Tz12s=;
        b=PM4WgHWh8jN1mZGrCgIVv/Vff3s1C6lKPZdQBsaFvDZb71osd/6+rGzQD8Mt9dwyDi
         CFvqujuIwrsX8y2xLyS6Yyi6BT341bE1qHCUte90Xv4FzuBv4zLRqKWG/i6OARrY0Dxa
         Pf/4L7Qf8sZaP+lrJb0FX79x1iSZanco1sLezmSNuKDTeKlB8ctC9e5TTFbFDkcT34CW
         RpYwUxMMm6jfyiFSllSXcss0gbc+mNeRqdJEW32TPe6OxrudQ/820/baAAkIYZOJ5T2J
         PKL/BXCYW1FylHVDQoGAnpgMlemkYhUVgELp8Jk79VPguso78iTBGadWpQC2gB2+q1il
         JTjw==
X-Gm-Message-State: AOJu0YxGHjkgVPSVvM9R4ERZ6Hmxw796QzMUb5/fcqc+fZ0WsGEFbV8e
	B+WOkWjqjvsW9bR7a96w8PRuc9NtBx/GIl3gR1JfcNVK+9SHa0nVc05RD7gCtnJmHWNQzmd/RGA
	TrYcd
X-Gm-Gg: ASbGnct6wxrG8GftWRfjS7VeHuC2y4WvDv/DV5lWrcdmx/UifzXrFjrUW8stqhVoqE1
	thansr5i1iSNA6nDuOklosD8G0IsAknvclfiplPXkn2E1OB4UXLv3+m+69Tpfapjz90ztLUtSa3
	EtzJ6kJDBoJ+Euuno/IaP8nUadoXu5ur1/y8tD1Qy2sEioyA9cOjAFruo5iVUSdtzK50o6+ijTn
	dJ/7OmaikKMRgDW/kmr8H0e8nFlZ+ddxjUtGJBWF1FvEmvqQss+W2RYdn5pTOBuNbxPrSH9c9qZ
	Tsz4C5YNXImgpmCUDq2FxvuXBf9yak4JOBQHKoTJTXK99c75ONvHLird6i0O/HV3Rdj/wgOAxUg
	TuuokpjuoFi4GioXn41l27mwslsiVbeWUY+BUvl2qH+8mEXxQ9+VEplFg/VEYJ8XCn58ZHQ==
X-Google-Smtp-Source: AGHT+IHL+I9uHLz826OnRpfIgoFv4CtbNkNshu53FHJqUXs18hOcb9brQ6Fgia4NulgrWyOkFFrZig==
X-Received: by 2002:a05:6808:1893:b0:43f:4f34:dd50 with SMTP id 5614622812f47-443a2ea7a37mr577992b6e.12.1760640671819;
        Thu, 16 Oct 2025 11:51:11 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:fbfe:2b7d:e6e9:975e])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7c0f90685f5sm6617279a34.13.2025.10.16.11.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 11:51:10 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.1.y 2/2] ipmi: Fix handling of messages with provided receive message pointer
Date: Thu, 16 Oct 2025 13:50:58 -0500
Message-ID: <20251016185058.1876213-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016185058.1876213-1-corey@minyard.net>
References: <2025101647-unsteady-antitrust-ef9e@gregkh>
 <20251016185058.1876213-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

commit e2c69490dda5d4c9f1bfbb2898989c8f3530e354 upstream

Prior to commit b52da4054ee0 ("ipmi: Rework user message limit handling"),
i_ipmi_request() used to increase the user reference counter if the receive
message is provided by the caller of IPMI API functions. This is no longer
the case. However, ipmi_free_recv_msg() is still called and decreases the
reference counter. This results in the reference counter reaching zero,
the user data pointer is released, and all kinds of interesting crashes are
seen.

Fix the problem by increasing user reference counter if the receive message
has been provided by the caller.

Fixes: b52da4054ee0 ("ipmi: Rework user message limit handling")
Reported-by: Eric Dumazet <edumazet@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Greg Thelen <gthelen@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20251006201857.3433837-1-linux@roeck-us.net>
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_msghandler.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 12db7d05c010..a475d0bd2685 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2311,8 +2311,11 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	if (supplied_recv) {
 		recv_msg = supplied_recv;
 		recv_msg->user = user;
-		if (user)
+		if (user) {
 			atomic_inc(&user->nr_msgs);
+			/* The put happens when the message is freed. */
+			kref_get(&user->refcount);
+		}
 	} else {
 		recv_msg = ipmi_alloc_recv_msg(user);
 		if (IS_ERR(recv_msg))
-- 
2.43.0


