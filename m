Return-Path: <stable+bounces-23585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE3E8629DF
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 10:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CC51F2157F
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF22DEED4;
	Sun, 25 Feb 2024 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqUGw+17"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F2E55F;
	Sun, 25 Feb 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708854367; cv=none; b=cDnbE5Q5HsNE/7+hiEoV1rn53YNEqjiP2M6vGzh/eqLerAUzHzDBJSAUoxiayuMyfh0U12Dd+PvZKlcpYB0PT059cH7C8+3Aa5odudZ+lOqscWMHlAKb2luagI/5b0R9wl20g1Abnj/FI8KRyAvYq6KaLvUJf67gY/qqTJ+XByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708854367; c=relaxed/simple;
	bh=+J9dFU96sObiU1k7DpFEuhlVkOu9THDg+xzPF1EdpU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dUQIXxa/F9VPcsVkZzMq2deqH7qgUaG0vSFYXnl+DJeSh456A5jN/lNw56eJERepgcxZV3BVHGlFEfXaT8ViEEx+czWaV4u4ZuIj/CGohQqiGrNw10N/57ocndax4sEcbFWE2s2msUXBXItaQ7ltz/d3td5Zkhis+h2xfYajda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqUGw+17; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so1646411b6e.3;
        Sun, 25 Feb 2024 01:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708854365; x=1709459165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4PWLiUv2Ui5IM/yx8Jmqgxoc3szSjkoAxJcl+KBEwhs=;
        b=FqUGw+17/gUfzOdrj7aU5zWa6kVcpqBdqjTKx5dZ5hR+7rma5ADSfqdGYbXcNagVuw
         uMFoQzrUntxfrlD0DX5DVVZW0YUQynEe76Hrw+PJ2PsTlQHKDF4j8Y+CuyeSB986sTfJ
         bp/+Og+hVyPRQecln6QZrjvwpWABCGpCOek+8lVFzkewxoFFAvKNeYSEDxPhukAPQJb9
         ehf7KYX/DfiHiMkXP24JktwJr/ppoiFFcIh77RlGgYjNWLdn+XKce3ZzTbJnHdNfQphg
         w/HhMOdTiOTp8qXLaZ1QOqh0oXG7X7ObPToTd0Mwb/QxaH+YsgzVw4fYGEyGhDzDwkDX
         asNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708854365; x=1709459165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PWLiUv2Ui5IM/yx8Jmqgxoc3szSjkoAxJcl+KBEwhs=;
        b=kHq0ORhfkXkTiN3yGAq5xdHoVAaFOsREkUbkBnsXGemmMXIrzXFJFnxV1JYYjlvKFF
         FT7fdsv4XoZkXJQC19cAVXIE80w7uUGNEjIPrwhwqMPA2CmxJ/yipqa9FqRpvmFo9Y5R
         yR/+ofdp0uUsM8CjM3L2aJ/6LNUE+IPNTyfqr6+EY3Z4W/btDfqrSyQPC9RvfX489w2O
         IAiI4FZvck6Mv8xU3ZNh0xxpi8e5xxN5LjJFZazGtNBMvV0JqKp7AcCPdwFUeNo8OSvv
         IRiVz43iXRTb7oXNiKYIgvyAI6dVLsIS33ycitOZ3GzEZ4uJCfX45HjNZOvFUHht+iyJ
         uThg==
X-Forwarded-Encrypted: i=1; AJvYcCUUqxjCS8lycpvFYKGAbNupleddiixG1ErJugNCkNqD9i9eH2snPLF0UYVLYPmYlVvvghMv+reosnzhdcVz+p4hVvddX8MdoB6NB8BCBr5bIxDcPL/b/ZJ+X6POzATFBZPq
X-Gm-Message-State: AOJu0Yw/dDwJubiPef+TwRUExKtFoFRCWdbN0Js+3eN878zCJ4nZvcYb
	QD0XVAugPh7jIE0txPG9rNS2Zcno3g6DEW0T82OhlqfYgZpqZOAw
X-Google-Smtp-Source: AGHT+IGrH4ucGAxOXXJFCFXyI0PiHLXbYvKpYh1OsRavSlzn/T4L4qfLVBRmCuH1UuYT+H091x9ZVg==
X-Received: by 2002:a05:6808:a8f:b0:3c1:5c1d:f567 with SMTP id q15-20020a0568080a8f00b003c15c1df567mr3931711oij.37.1708854365010;
        Sun, 25 Feb 2024 01:46:05 -0800 (PST)
Received: from ubuntu-2204.. (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id v188-20020a6261c5000000b006e4c4c3d4cfsm2213344pfb.207.2024.02.25.01.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 01:46:04 -0800 (PST)
From: Akira Yokosawa <akiyks@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Akira Yokosawa <akiyks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] docs: Restore "smart quotes" for quotes
Date: Sun, 25 Feb 2024 18:46:00 +0900
Message-Id: <20240225094600.65628-1-akiyks@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit eaae75754d81 ("docs: turn off "smart quotes" in the HTML build")
disabled conversion of quote marks along with that of dashes.
Despite the short summary, the change affects not only HTML build
but also other build targets including PDF.

However, as "smart quotes" had been enabled for more than half a
decade already, quite a few readers of HTML pages are likely expecting
conversions of "foo" -> “foo” and 'bar' -> ‘bar’.

Furthermore, in LaTeX typesetting convention, it is common to use
distinct marks for opening and closing quote marks.

To satisfy such readers' expectation, restore conversion of quotes
only by setting smartquotes_action [1].

Link: [1] https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-smartquotes_action
Cc: stable@vger.kernel.org  # v6.4
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index da64c9fb7e07..d148f3e8dd57 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -346,9 +346,9 @@ sys.stderr.write("Using %s theme\n" % html_theme)
 html_static_path = ['sphinx-static']
 
 # If true, Docutils "smart quotes" will be used to convert quotes and dashes
-# to typographically correct entities.  This will convert "--" to "—",
-# which is not always what we want, so disable it.
-smartquotes = False
+# to typographically correct entities.  However, conversion of "--" to "—"
+# is not always what we want, so enable only quotes.
+smartquotes_action = 'q'
 
 # Custom sidebar templates, maps document names to template names.
 # Note that the RTD theme ignores this

base-commit: 32ed7930304ca7600a54c2e702098bd2ce7086af
-- 
2.34.1


