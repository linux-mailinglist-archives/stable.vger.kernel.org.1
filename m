Return-Path: <stable+bounces-181597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874C9B996D2
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 12:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418863A481C
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 10:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA0F2DEA6E;
	Wed, 24 Sep 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp4sltb7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867D22DE710
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709610; cv=none; b=DJG2z4XQDS9mU/UzuOSj/aRpBXr4rXPLOs+EQZqqQtu8klEevk6ucUINvl7VFN+T7mfh0Ne/u/AHih7Q/Utlunm60xYTrMRjbx9Npv2jkxI7NPWj80G48FC7k1XPaCtBjboU4RLT08+AEEyiOMMfd3/tKpzpE5T/eroK8BXlDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709610; c=relaxed/simple;
	bh=rg52av5kFCUYkXZtU4DrP9/Y4/39PcGOd395Z3Mzk7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtlnTFJAU4uV2goW9E1vTGXZXICH0CAFbN32vjMj2RmZeI45RQsxl6rZ3MP897RV1gmUjcNzn4UgLavP8uot9Ce9Ojne0nTwB11mB6kcYoLOaSFllcDM6q3APgl2ZL0zU6D67BMvXS0uUUJA7lGd7HfaV1P0sweucBG0Lq8n6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp4sltb7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-279e2554c8fso33548035ad.2
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709608; x=1759314408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SViHo61tUbVEKZUPOiXibeEeLK3NjnTHx+4S6cKWr+E=;
        b=Qp4sltb7VBeChe4sp8+ixOorM/5zarvONK0h4xuOUUhWfttxldKQJMUMha+wF7764B
         zDUVuca2eJNS6HE1Iin0dXmLvDnSnkNzD0fMUAEJqBRjG25Cj2zdqNAbXrBi28psRYUI
         6U9ZbwUKXAk7JuEXRYqVBqgjk/pEJFDyPUyLFJo8W/BJarE149LnurAo15LLL+eviTIg
         KG3HlLIyR6w2Sav3O05bT0DA3WVZfuBumdOtXJ5EMOHt5HK8JZDEz+LU2nBf8v6CHClU
         CknNb7PKQdvYqb4GoTwbI6b2pxQIxiFXO7vxFid4I/Px4hp9jnl68gkEHgRLRwCXriG+
         vmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709608; x=1759314408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SViHo61tUbVEKZUPOiXibeEeLK3NjnTHx+4S6cKWr+E=;
        b=NJkMs5DYiQ+GmvVB+4NaNAnQDYPwB1SqLxlqT0L9FuLGXK8ULA71LSDL26ON48r/9O
         kNdv8uu6oDzWA+5oxGPhzZifWfhkm0pkjz+GZmCyr+35b/O82F3RT4OPXf0tzanMIbA3
         V97CHnCaowfcCnFOsIR48xljnff10XSrmhm8OuJDHrZ3NubyNXoZqh55bLZuCg4f4l4p
         oHbAmiLuJyJ7QbeiqMGWluIKu1ALotm+gbsp12BLbYM81uf0Uka+XoVlqLqaVOHA/YoO
         3/PFq5NjTBT1m/y6932OXOLJF6oT6IC8PCngyltAbgTjF3HYUPt5CyTE5ubbfwE3L57B
         oN8g==
X-Forwarded-Encrypted: i=1; AJvYcCUX6UsmqlOAZgRaFWdFRy5pcUBJsSomLsL0UlWHd41rKnzL4zUWzU4Nehpl/yHV8KI7MUucq0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKN/jLKj+DRi4wpg76wkUcNg/NTYApr3GG7fUHEnnaFs2KeY9s
	pcOyQjbBSKXxea5bgelGt2SvORUuVAGEzhSqe8V/6oax5C27PMlS68ip
X-Gm-Gg: ASbGncvAGmDVKt4+G3PF+OrNn+FLKbv1yqCmOiNyLKV4i8x8e6chFwoHLcZLdEDVzIz
	iHoOlDOlG8KDYYK6rp8iH9xd7G3ECDRcC7YEI9ar/qyogsQDv2ySgA8ip7kwDDiU+1+DpKhR8la
	TYKjGO6kzQiyBorU4hD8zh6wSyFzaiZF34oAd8gB3+01nDVNzYIQylRd/33EJU6YbhEpKrDZ6oi
	McZ/141ZfGiJMuuXB2EwGVfndIC+S8OEvNVqZ7tbXZ/2jZPJWnK/njq/hVb4iwc+fGyFEl+MKAN
	bvJk7Bgazps2N7x7EsKRg2FUirAP3vsFLS3kQTm/RXgzVEAJmTZ9afnfqAXNFn65oLO3FoZy60M
	M/48U75KOYrWXrJz5CvGZ5NLocr/JRVf5idobDb5mOoD4KqPxzri86YaO8CU0FqLt24bt4Y4ecm
	KSKn8=
X-Google-Smtp-Source: AGHT+IE2o5mDhsvuCmWLmP3D4Dz519WVJ+NTPBdX/XXRWo7SqZH8onvtPetftQxVDmOqLZZq0NMxmw==
X-Received: by 2002:a17:902:d50a:b0:276:76e1:2e84 with SMTP id d9443c01a7336-27cc2aa7dbamr63353465ad.3.1758709607690;
        Wed, 24 Sep 2025 03:26:47 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:ffb5:d3cb:7685:ecfe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bdb5f8bsm1888800a91.16.2025.09.24.03.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 03:26:47 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
Subject: [PATCH v2] comedi: fix divide-by-zero in comedi_buf_munge() 
Date: Wed, 24 Sep 2025 15:56:39 +0530
Message-ID: <20250924102639.1256191-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comedi_buf_munge() function performs a modulo operation 
`async->munge_chan %= async->cmd.chanlist_len` without first
checking if chanlist_len is zero. If a user program submits a command with
chanlist_len set to zero, this causes a divide-by-zero error when the device
processes data in the interrupt handler path.

Add a check for zero chanlist_len at the beginning of the
function, similar to the existing checks for !map and
CMDF_RAWDATA flag. When chanlist_len is zero, update
munge_count and return early, indicating the data was
handled without munging.

This prevents potential kernel panics from malformed user commands.

Reported-by: syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2: Merged the chanlist_len check with existing early return
    check as suggested by Ian Abbott

---
 drivers/comedi/comedi_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 002c0e76baff..c7c262a2d8ca 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -317,7 +317,7 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
 	unsigned int count = 0;
 	const unsigned int num_sample_bytes = comedi_bytes_per_sample(s);
 
-	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA)) {
+	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA) || async->cmd.chanlist_len == 0) {
 		async->munge_count += num_bytes;
 		return num_bytes;
 	}
-- 
2.43.0


