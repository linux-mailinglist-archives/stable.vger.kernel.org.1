Return-Path: <stable+bounces-40387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1DC8AD1F7
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 18:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAE41F2185C
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631551514CA;
	Mon, 22 Apr 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOYb5BBV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16D22097
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803873; cv=none; b=He2w8HXZ/lkl7wKQm5w1QbM9+NsRQaEoqqV8PkmKVXXCQxEZy+nWI7AqUpADFf8lZj2M7APGK8zhjSpURLdI9H2XLYvZw/nqlYEN6CG97u+RlEa37o/DoFBkRKfw30cPm2T+ORcjj5CXBsEj9R+5b/2ZhFs+yhUpMpHmjHgzMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803873; c=relaxed/simple;
	bh=H6lY9kh62C4YQstjcqSOklbN1ZNSivp/MHHRCWngx/g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kmiMIc1MO8ToVRxPaa+XoHiNLAW8emCwawtSTjMsgrafps9hmeOs+Wv7NxOglVLdMspeIOKFlFSxkiZvVJpGg1EPmdqvQl7uEDLmFoqrER85iAznN5h1t0Emhtpc1hjBrBatjG54CJ3hNpf99uAw0vvMRdcV0NiQnsWC2XMvkxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UOYb5BBV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41a5b68ed5cso11734225e9.2
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713803870; x=1714408670; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/RJrrrs8RwvpYrHG7SbHwPY/r0CKqLeGFzxu6oxqWA=;
        b=UOYb5BBVre+5E6nos39Uiao3CK2OxOG7MUlmz4HX7BqHBw1TSpDWuopt/sKarjM1kF
         rrCRifJI9Jd4XUemwN6KvHZ63evdivIEU5hnfeMAZjkmn4euqPBTldYEgRI/iipkG93+
         OXru28yYUvdUMfA5jOyV8HYKOz1Dq5lZonU4dzQKRJ8cBwBZAkZOWOKKRfkZ/EAtYk6O
         GdPsJOtUC2QtJwAh7+uf9Opfox4LyaWc+rXvebP0PAZhdA2eP1a0czsIqe1nLnYBY3GJ
         cNSYaqmUFEmbuK5GEi2S6cNNNKgB+bTUEUbVNBYQ9TqtfbpZeEu1gjxW3TlQ4c+7NKH0
         yL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713803870; x=1714408670;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/RJrrrs8RwvpYrHG7SbHwPY/r0CKqLeGFzxu6oxqWA=;
        b=v/D58V381CJS77FM3YahL2Wi+Q8u5xjM6FSEt/wGO9fFgd0lY3jb3BXtC3YXPo5kqA
         yF55WtN6osM9ZynNKhw3OSuYOwIBvRoPY5h4rAfTS5BiZZ7//Omt2jfTvZazj1rmZrky
         4MLjUZL8ZAi2dPR/GAXx4wM9NkNPMED9LXc3E/ZgMo1aVaTBA558yD+10Xtiv2VJV/ZD
         jYms7ln9+MRD+eM6qn2yTMAOIQSKQ81t5SVSg2sTlB8XK0xmHYAx4DE1Bd+FLYK9qORk
         m/VJS7VhlWuvc32yHIc7+3cN3Vb1P0/CBQ1zCqoMW+X96GiyF2VGW6+jGnK+wJusA4A9
         Tsig==
X-Forwarded-Encrypted: i=1; AJvYcCUvvaqmeFwsgKi0gUMBpgMpgEFCkya5dig05jKInHpse33AAy3jA8peERvra06mPT7JIovUDCswNi3kLFF1UKAnPBJeDa5L
X-Gm-Message-State: AOJu0YwRFl6yAjXBGakQbafGy4xvg+uyW9FoSZ94Sg5tee+KSPNRVmgR
	DSSor6PTzhmAFyu6dBtIh4VTACRLoXIYnXmb8xQSygFIX9RmFHScsP1GreJVnqI=
X-Google-Smtp-Source: AGHT+IEq1dPmWSDiW/s+JYEDdjB58eHF/R/VUvio1ax8A9B8QWPR1f0qHTZyqiH56s6nclUVAWVSJg==
X-Received: by 2002:a05:600c:4689:b0:418:f308:7fa2 with SMTP id p9-20020a05600c468900b00418f3087fa2mr9531927wmo.14.1713803869838;
        Mon, 22 Apr 2024 09:37:49 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jp13-20020a05600c558d00b0041a9a6a2bebsm433343wmb.1.2024.04.22.09.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:37:49 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v2 0/7] kdb: Refactor and fix bugs in kdb_read()
Date: Mon, 22 Apr 2024 17:35:53 +0100
Message-Id: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOmRJmYC/22N0QrCMAxFf2Xk2Upbtik++R8ypG26LiittFKU0
 X83DnzzJXBuck9WKD6TL3DqVsi+UqEUGfSuA7eYGLwgZAYtdS97NYhbQHvN3iCP2bhnykJ7o3F
 2akBrgYsP3tBrk14m5oUKn723H1V9059u/KerSkhh1dFplEoeRjzfKZqc9ikHmFprHxZbklS1A
 AAA
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=H6lY9kh62C4YQstjcqSOklbN1ZNSivp/MHHRCWngx/g=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmJpHtkKsfkSXNmY9hGFqe83qhrZ53UoPZO663u
 6hQPnNvMfWJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZiaR7QAKCRB84yVdOfeI
 oeekEACbufg6Gh/VvIIcYb0alGNjOAr7Mt/Xh2T+vBP1rKQ59CIlF6jekwGOWqZrLQWxvngMN7r
 +1H7M9HRBfuW8EHdOtLkncBL+Zc9sO9XlAVbp0tEZA93WzyFrqZuFUqZVGcVP+RKn76blnYgCLE
 gkJpCWKRBW+N8amQNP6rmLhZjjVpTuv/0QpPKbkNXbxhUZBrFnrsH+8FkSpx8xwmt6MyTqjKZVJ
 KUynxaIMBXMyjMv81FgnTojX2NAB8NynwrsxCnhfc/LX5KzKIjCDijYP2wfWpT37VBE4rpiI0rZ
 qrDgjhRPg0DeHPiKdtjIEOgbD+n5HlWU/iKzNFWpytkKyfFES/3O2Vx2RkkwgXQlUOcBlUJ3HkC
 gUF217AgffkBRamyjOqPYZszjG4BUibaJTbNmeNK3Oz8p4sSI8y3bW+mgg/t0d/bvSt94f3VUQ/
 R/7k40vyL2vrEMSks/kE9e3jUSMWtKe/yWKUueWEi9ILZkSYTrPZhO5H5PdMG0EsJ/Fp914tDgf
 oGRPWvoUXinJrvLaMgbFYVoGoig80vjilbwmvbYlq/qypUMCUFOnreglL3HSexrsHxykbrEDM82
 3JzFHDOlReG7Tcn/GMLAzhQ+o19Akf1JEgaGExm6F6Ce5lH8TLcBpmcbTaQSXpdH25RMZ6FLB52
 3Kf8+wJ5FwwDsaw==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Inspired by a patch from [Justin][1] I took a closer look at kdb_read().

Despite Justin's patch being a (correct) one-line manipulation it was a
tough patch to review because the surrounding code was hard to read and
it looked like there were unfixed problems.

This series isn't enough to make kdb_read() beautiful but it does make
it shorter, easier to reason about and fixes two buffer overflows and a
screen redraw problem!

[1]: https://lore.kernel.org/all/20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com/

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v2:
- No code changes!
- I belatedly realized that one of the cleanups actually fixed a buffer
  overflow so there are changes to Cc: (to add stable@...) and to one
  of the patch descriptions.
- Link to v1: https://lore.kernel.org/r/20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org

---
Daniel Thompson (7):
      kdb: Fix buffer overflow during tab-complete
      kdb: Use format-strings rather than '\0' injection in kdb_read()
      kdb: Fix console handling when editing and tab-completing commands
      kdb: Merge identical case statements in kdb_read()
      kdb: Use format-specifiers rather than memset() for padding in kdb_read()
      kdb: Replace double memcpy() with memmove() in kdb_read()
      kdb: Simplify management of tmpbuffer in kdb_read()

 kernel/debug/kdb/kdb_io.c | 133 ++++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 75 deletions(-)
---
base-commit: dccce9b8780618986962ba37c373668bcf426866
change-id: 20240415-kgdb_read_refactor-2ea2dfc15dbb

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>


