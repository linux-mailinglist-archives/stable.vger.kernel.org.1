Return-Path: <stable+bounces-242981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULrNJ95w+GkHvAIAu9opvQ
	(envelope-from <stable+bounces-242981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:11:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C09A4BB7E3
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FA3E304706F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D769C392C3D;
	Mon,  4 May 2026 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gawq11ah"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33A37D113
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889343; cv=none; b=hi0V8mc7rdhl/0EKdJN2AVQlBZUz1wshx3+oaYmQkeWtjvSVuYWNzDsxX1xZd7kcArLYCmxDTbTNlzSzTgd+Wx5OjV3SAesRs0qSMpit+KLiUK6MwXjrfaYwmyMa72jAsv0vvNuDapAHPdPucrUVfFD6ZBDNyye5BStfkMKO62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889343; c=relaxed/simple;
	bh=Zs9WNTC83oSjBnoN+C/Zgou1KF6Ibnz5FPkh61SSYcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFgmpLsBMY4+P8CtjGEj057st6cWnEN+mL5UidSs6BypgPb7QNA5kTNnwMNsORVjuuxbSdV0/m4EkNHWuPrdQE6hJYeUxn1v4LOuT5hu7n2i3PXUngUc1XrQEc8t1YBmwRb0cuOY4PPLUk3H4p2SNquLIRbVaVUleTbQy3QkjoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gawq11ah; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-393800586aeso14211681fa.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889337; x=1778494137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efcgj+nt9ZDETRdVUhLvA9ywV/eZR7SxjX6DhlexZWI=;
        b=Gawq11ahWxXiiP576uVGZqUD62NEN3CxSvw34/7mzMZ81o//CHVCzHhkVuDDjflxOE
         myr5Lz5C4Zl6MPh0XQczmfT7Pq67V757H8IgoLQZDHzww1KXd2sn/AJSzyJWSsMRNFjS
         v6+PMD5vtwGww6VcNNQ3cyPJ4ApvgVnkuHmHXMYM0qS/9yM/f3hmAnsgQX/mQd6R7grF
         T6mzwEl2piRy2hf81dcpu+JdsuYZQDYB6Cusn4oGOplf4v98+5RWMwVNYQhi1cDPX70q
         HQNSKL3KOmhb77EJskPo79rDH3nlc5x+R+Gr5TgjkNoSNSOCeT1unvEjDL3rHzBmhLFe
         6vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889337; x=1778494137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=efcgj+nt9ZDETRdVUhLvA9ywV/eZR7SxjX6DhlexZWI=;
        b=axEDWLbfrfbFF6NaQnEQA27gUDJRHvXikWJXCvzoRdlc/N9REyUs2I0ZIE6uv9ocC8
         BCxvD58Vvn4FvIGWsKpwv8KDSp9Y5vZp7JYPOzY/0Ha8oiezmsGXQjHO1HfgiB0O1SZC
         isQqcUyLSyqq13NgykafIgIZ6IFBeOu8yrXAJv3YCs0G96XRfkRNthdVQwj4zRgohfBv
         3Ttt4aF6zLa6cyoioErQi82ew8+XjOia4V4nYQd1oYJIce3bjAlWHVSEa/1i41GYF4H1
         SRnY9JSspfnAgXDcOyEh/4/qEgzLvee5nuXjFH+1d0EZ3QF3ex2tynJgpa/OaLuH8YP6
         M2hg==
X-Forwarded-Encrypted: i=1; AFNElJ+tGSPz3LKKHvsxkL1Q+r+ND5KpZ+aDOrWoYNCbkeenXO1b71jDIqjrHzHLZmlClvp5h4Aanl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGMA/9Z2gJILEOL/qypI5wKSdKsPkCLU/EBddNAlm1lJLk8nGA
	8qxCECMZ5aIVpygXirtWwckNZpfs3Iwc8w/Meqsv8FLXBSr43y3rjNCD
X-Gm-Gg: AeBDiet2cFOcHVbfBYOwXzdYOqkh9ujKokY4uLX87gBALzAAgdL10ancVd32EQjAnEq
	22ArebEfTlupOr/5LVUTjY8BxhPsitQni3QFzGTNj4EvBEKC3hoOIhh+xfOlgVh/DPxjQ67RGia
	T3qiT4+H3ZgZcgNSZfujwpdwuVr/gE4hNccjZjBaQ+TamK/K1G5n1RBvYbLQ6+0zHSaMSfsTsK+
	7j56JMIFabAyMkHvpfYLwx8Cn8ODmKJa5Xv1UOmO0ToSzzo0mjLUuNeVx1vCX56TW+Kn1s/xg/r
	F9GfgYMdry8cp2TTCSDIs0cxN8s2eFBKM3kHPbdWF160ru+AyN8iPY1eKzaR44fI9Lo2XYRmwmi
	aPDHmyJ8jYGGa9JfBi5m8Z06ElStfBEjbeQci+XkFH+WI3YgA0hz4Wl+LfrPCZsMxTboQmi4gaf
	OCj5URfMTPbRjmE7J7eEd6x5ESlC7X/eq+xwft13YOwLshLY4HXiOMX682rFHSKNyWK+MBM5A=
X-Received: by 2002:a05:6512:39c4:b0:5a4:5d0:2892 with SMTP id 2adb3069b0e04-5a852741d37mr5443285e87.19.1777889336425;
        Mon, 04 May 2026 03:08:56 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a86645ae7csm1979099e87.79.2026.05.04.03.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:08:56 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Vastargazing <vebohr@gmail.com>,
	stable@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Vincent Sanders <vince@arm.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben@fluff.org.uk>
Subject: [PATCH 5/5] mfd: sm501: fix reference leak on failed device registration
Date: Mon,  4 May 2026 13:08:47 +0300
Message-ID: <6b4a9f5ae8a316b6f07f72f2fe3f0b8fc5f18dff.1777889235.git.vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777889235.git.vebohr@gmail.com>
References: <cover.1777889235.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8C09A4BB7E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,arm.linux.org.uk,linux-foundation.org,fluff.org.uk];
	TAGGED_FROM(0.00)[bounces-242981-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When platform_device_register() fails in sm501_register_device(), the
platform device allocated by sm501_create_subdev() has its struct device
initialized by device_initialize() inside platform_device_register(). The
error path logs the error but returns without dropping the device reference,
leaking the memory allocated by sm501_create_subdev():

  sm501_register_device()
    -> platform_device_register(pdev)
       -> device_initialize(&pdev->dev)   /* kref = 1 */
       -> platform_device_add(pdev)       /* fails */
    <- dev_err() called, kref still 1, sm501_device_release never called

The device's release callback (sm501_device_release) calls kfree() on the
containing sm501_device structure. Without platform_device_put(), this
memory is never freed.

Per platform_device_register() kernel-doc:

  NOTE: _Never_ directly free @pdev after calling this function, even if
  it returned an error! Always use platform_device_put() to give up the
  reference initialised in this function instead.

Fix this by calling platform_device_put() in the error branch, which
triggers sm501_device_release() and frees the allocated memory.

Fixes: b6d6454fdb66 ("[PATCH] mfd: SM501 core driver")
Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot (Claude Sonnet 4.5)
Signed-off-by: Vastargazing <vebohr@gmail.com>
---
 drivers/mfd/sm501.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 0ee6d8940e69..8276456b142f 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -704,9 +704,11 @@ static int sm501_register_device(struct sm501_devdata *sm,
 	if (ret >= 0) {
 		dev_dbg(sm->dev, "registered %s\n", pdev->name);
 		list_add_tail(&smdev->list, &sm->devices);
-	} else
+	} else {
 		dev_err(sm->dev, "error registering %s (%d)\n",
 			pdev->name, ret);
+		platform_device_put(pdev);
+	}
 
 	return ret;
 }
-- 
2.51.0


