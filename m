Return-Path: <stable+bounces-41360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36DA8B0BE4
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 16:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64081C21D5A
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB47D15DBDD;
	Wed, 24 Apr 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKiMb8UC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7815B986
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967553; cv=none; b=uRgBnicRdpT4wXe56r8+JFkbeTVcn2hcoBIqjyyNsRNh/oRB7h0n3yFlv/qDonITavEyOxYvIBpg3PsicC+63EEF38IPCO9/+KL8T7W8cBBsjOb05cdnkCUaBlxB/fRuLJ/Pb7A+V/JnVs+Dsu02mukjMrkcWc280sG9Wd6VaPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967553; c=relaxed/simple;
	bh=VQpU3J8REVi32pKGrBL39GnkkEpNRc/YcEXuNzhQ7S8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UkSSV7Q1SinxKYjGl21bdBAyy5gNtdGLumMrQWZ7ySmN7IbkOLNKKRRc3umOapXVyQHvJmwK22xli/9SoLaipOBl5AYs2CP3u4k84jYAu9ytZskmTKbTxzbVNm0iuxQcZBG2KskzgmqIn+Qft4Bma/Z48LiVhMhFHUHzLrdUDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KKiMb8UC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b0bc4ce39so6211945e9.3
        for <stable@vger.kernel.org>; Wed, 24 Apr 2024 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967550; x=1714572350; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOW6A3oiYgpr232UrDpTzT4iOIowEWVRq6fTiYcPrAY=;
        b=KKiMb8UCwGgnVpKI5dmZGmnwUMT6ep1fgMizEXTbZMFzjrvLXJtbVcIchCqFJDldJe
         t8pOvzFhom9w1yZ/Sgn9hse+gAMZj5qS8bAzjO3HTjYouIJQnnQUaaX8kseLiu7ayiqN
         wyji5K6NPX9imoEVbwIvXa+1revXNJm3blHt5RVUdqO7j8KPJS9NfPobqmHSQAxOzUrM
         bUKv41bblqXOTSew8SNGpWKgg6PhiIAw7QMRrg6vhBWOvUb4Alx1eE/kJzhvZWUag8DO
         u640JYCYqouvRj0P4jVcSmNLvp5jxdJNcAZP6of36Sd71kgWkm478JD/1337IVulXkLk
         Ks4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967550; x=1714572350;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOW6A3oiYgpr232UrDpTzT4iOIowEWVRq6fTiYcPrAY=;
        b=UfU5H8uyQYSozwBIxJrxgPcoqe3b0RbZ+afdsJIybvgegfqiNXEX90pLAq6+nYdKIC
         //wWZWuajzzF+RmfXfAkYeWFcQ0JzEa+o39so1NSflrqpE90N3u/7wNcMr9+ZLJT0qNU
         BTIZpAZqGijcoQ3KwHcYzKVmXzpjc4MQ0RtmjUnLoIdJzSJ4Z6eU9xAaXU1aKqe2guuI
         I3VRL25wANMXzIVKdlhlxs5KiRvIOUAh5R54QBrc9FPid0e3hYUA4heeevnRxG14R3bK
         vSLu6ZhhFcoWXgdmntH6J5+iZ/m7k1LH8MbqYLsErvbGgoCWGekqrLf1XrZdJ+jeG+rY
         8miQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTahJp4wb6vO0h5UbDO7JC6TMldHE4tghJ/SLp+//ruzG1uH/XTCurQFfsuuUtSunjJT+mAJ/DqmjXlZW8qmd4zoh06usE
X-Gm-Message-State: AOJu0YyeBhkOIE/6fjxgS0OhJkDn6784W6IHYj7JSJ5NiefZ7OEKBnWg
	zq0HLrnrGNqWFLmgcfpCulxs/8bXXpvx5J36UGEetGtpVWTQNmZWDl4qjYVkd1w=
X-Google-Smtp-Source: AGHT+IH5ZR/K91tZ5wMMCx9SFvn1/tZovp+japncGiIcosbRMA1+HnVP0IkzAAq/JNjIKwqR1fh5Jg==
X-Received: by 2002:adf:f852:0:b0:349:92b7:c248 with SMTP id d18-20020adff852000000b0034992b7c248mr2527970wrq.29.1713967549288;
        Wed, 24 Apr 2024 07:05:49 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm9105325wrs.108.2024.04.24.07.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:05:48 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v3 0/7] kdb: Refactor and fix bugs in kdb_read()
Date: Wed, 24 Apr 2024 15:03:33 +0100
Message-Id: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADURKWYC/23N2wrCMAwG4FeRXltp4rqJV76HiLRNthVllVaKM
 vbudgNBYTeBP4cvo0gcPSdx3IwicvbJh6GE/XYjXG+GjqWnkgUqrFQFWt46stfIhkppjXuGKJE
 NUutAk7WiHD7KxL8W9HwpufeprL2XHxnm7per17gMUkkLB4ekQDU1ne5+MDHsQuzE7GX8MRBXD
 SwGk4a2Iah0y3/GNE0fFOAO1fkAAAA=
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=VQpU3J8REVi32pKGrBL39GnkkEpNRc/YcEXuNzhQ7S8=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmKRFQ+4om7JFZ5/EK9HqNC93TVLDNHWXLVlKqI
 N6SlLkUuAaJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZikRUAAKCRB84yVdOfeI
 obpUD/4/S76jZAwd8OokxxtwLhkWuqSLZOblWBwwa1YS/Vr8EogcBxq07lkcO5Qj+XDF6/vrxC+
 H5MjHqmyhShW9raMeZTi6VwYNKh6eFtMa0du4MyTbt9LfDY2EPuePdiZfULwEwhUD14ux1tJlQB
 YIPeK7Vwd10vnJ6bpS8VeONRmHWcrYax864C187IHI4TfoNyFjIi8HttyDIj4oOK43vsYvB5gXG
 ExYEvtVpwCzJRlbV/GaPhSS9wPg2Pthdp/6UhXjGssTv6GWbQbZzCzs0GyMxb/4wHPFyAcAa0Um
 RiMowggoPHC80GsBXfZV6lQchI5l8FtmgC4KFiiZfDSkK6i8slwxYf6ZOdk98pIgHFMaGU1nwM3
 176+voUW/Z4E7vZZJiRbQZlZFeuq3UXQ3PPURa/aJfY+MoYSaQ6KQ0hKDRvUaDxnVJIY9jfM9Bv
 oqHAPtTOPfE1p7ceVWc+MuFgEKPXe9r2HvEhYp9i20HgbImXX0RlmV56ojnfrgzdFpCSmuJmkx4
 +bnti2LiMNhug0bJROEF4iFFRtfIvE95E7qsfNN5lE2h8m994rXZAN7OFrj9A5T14jdzQDwUOTw
 IGf1EPbVO+IFCboN5BHeGnjvL+4vtyWUEkcsFs5r5RywpTOegCKUEtfX7KChIy5fJcfiLsZ0ejN
 gsgmyNOPEKh5zLQ==
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
Changes in v3:
- Collected tags from v2
- Added comment to describe the hidden depths of kdb_position_cursor()
  (thanks Doug)
- Fixed a couple of typos in the patch descriptions (thanks Doug)
- Link to v2: https://lore.kernel.org/r/20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org

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

 kernel/debug/kdb/kdb_io.c | 153 +++++++++++++++++++++++-----------------------
 1 file changed, 78 insertions(+), 75 deletions(-)
---
base-commit: dccce9b8780618986962ba37c373668bcf426866
change-id: 20240415-kgdb_read_refactor-2ea2dfc15dbb

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>


