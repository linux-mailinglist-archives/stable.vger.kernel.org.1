Return-Path: <stable+bounces-158984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97150AEE5D9
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 19:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889C23AB703
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 17:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEBC19CC29;
	Mon, 30 Jun 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdyCeEJq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451901BC099;
	Mon, 30 Jun 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304712; cv=none; b=OZdk8G6R2iDdvw0JV7CMOHw1VU0088nvolIGXiTU433j2KIcU/JQoS1CG1HjwI7fhra4fOQwUKfrlWEQHGZ4mQ1x/yrzSAkE3vYkRro+fSXtPjIUXB5oM4s1Cah7Cou1dVIbrYPqmzKxMse/7DEkHH70yApuRWLDQgGPEcttRw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304712; c=relaxed/simple;
	bh=h5c6IBJbv78fE5ZeORO47Y2ZLDLghsSas52hLDJz8Vo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c++N55G9ixVtlamnrR3etvrQLK/IFA0kJPAOOMMZ1AKkAi3WqrdUFeO0tdRBO8zXf46XLWOTtetfbX2Td26LmB2hRFJoJvSVXJBSQdQ7vBv1HMFgVdYRsh6AeDr8F/ILkAS2y8x34B2+aRRM396W9yMlFHxMD0qZK739i1STR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdyCeEJq; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a4bb155edeso56494311cf.2;
        Mon, 30 Jun 2025 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751304710; x=1751909510; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awH8Fz1hjM1DBo3h7PP84BBK0d0aPmxgVTCni1QNExg=;
        b=TdyCeEJqeJ7Gc4+3HtxBm2DA2OZ72mb2byc9EWm3Od36TH03DU4GgO6PYQNXe81JTU
         kAKkvUSTuPd04aLpEKfqoW2eCJzI5+uqz7su0aioCUzKDy1H44ISChxKxUIf8J3f9nLu
         iCrgGZm/xU0WcQMDhp9WuJf0PN+M1UN2KkXP9dGTXLS69r8eiHxIg/LhqBBBRBs7qJvT
         MMGHZBJXZ1EKsOPzdtLSv+M3vepN6nHRHChYl3VupENfYCdh+Xs4p19TvkdXDcUwluAe
         Q5B9D4IJv5GGnKa+A+6hDOaPzo9uqr6bdui7eroMs7fNlzVYDQl0NqaAQxzjDqAizPWt
         slYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751304710; x=1751909510;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awH8Fz1hjM1DBo3h7PP84BBK0d0aPmxgVTCni1QNExg=;
        b=PZuuM4KG5oIiByIKwLmBWt4hFGBGP3PaMnj7vh0h6f0BCcHnSVZ9L08li8IutnI2H4
         WGP8jCzS45BimjZj5wzbGOzmqy6dmVA1AmeNQRp3oQq14T2ycL7ZgFuUDt9SEt+k/jUn
         WDppEsZFD8gEwDSk9ko65ZcIethrPJh7keiRzjLxRyzid0HJ3aBGWudH6vi2EkxROhEM
         n8nR5Wn9SSrCm2m91vWfWSSUM5j6FRUQTZN1rPSzMlva6N8JomPHaGju0hibBKCplCXT
         zu4xGAp1LiOdaCCwhUF7QTcKmbC622o/KRQtzumR8++k7Y4er+4L2g6eksqTKw1XU8y/
         U/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU7E3G1Y0pOD8o8AidxLyjMPyVpVkCoU70w54DmG5HSKZIoymJs9oSXktDaC/nGW6AM429sWArH@vger.kernel.org, AJvYcCXZ+nZzQ/8NsnBG4V/1OOW69UYlnVkydfKqC33iY9pTOpcQ00/QfxolLrn5kXih+LB7Y5UhYprs/cRVyvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9k+7u0KI/IdwR9XYXCBF3fswfivru+d62DAxpD5uOGYAuxen
	ZD9cZMYTNKvg9ZW8ny/VpKGdP7WkC5uqK4CXl+6oNDPL47U/IAM9xbQQZR6pWcMn
X-Gm-Gg: ASbGncvKXWYe52VaB7DUnq0nb3Al3ww54UnI+8mbQL0MMsvbmF5E2859GuAU1NoDEkW
	h0ab99DO4XG7kui7e0kHfh9jP0HoZ0jbZ5e4mgNPLJ4Iw7ZW3iHhTX1MqyFU9Bizz3+Ev4OJZ7C
	aHMLkO+tLZwqX++Al530a3shPWCFflSpvyEodCY/GFbptzW7EU3NN4gJerXO7SOzam2aUvn2t+Y
	YqeEVAPsDD7JEaGdKG48Lh0vynQ7wozDVQDVbYO6jqskHycosPeGbQXO1yTSqWRyYhY6UZw7pU1
	FabRPVtGtNUqOo4OWEWHcuMj3o296YjBvUVghg7eCOhnrHDDEJ+wRfl3VaS+6g==
X-Google-Smtp-Source: AGHT+IHZ4buoJHnWhZ6S3ZkMqcQoDpG2ZYTNt8Xb/GVgOKbOC/G5iCpPL2tq18S0hY6EsH9TWBa18g==
X-Received: by 2002:a05:622a:1886:b0:476:7e6b:d297 with SMTP id d75a77b69052e-4a7fcde992fmr256784921cf.41.1751304709760;
        Mon, 30 Jun 2025 10:31:49 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fdadb11bsm59784521cf.17.2025.06.30.10.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:31:49 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v3 0/3] platform/x86: think-lmi: Fix resource cleanup flaws
Date: Mon, 30 Jun 2025 14:31:18 -0300
Message-Id: <20250630-lmi-fix-v3-0-ce4f81c9c481@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAObJYmgC/3WMywrCMBBFf6XM2kgepjau/A9xEZNpO9AXiQSl9
 N9NuhNxeS73nBUiBsIIl2qFgIkizVMGdajA9XbqkJHPDJJLzWvZsGEk1tKLmUac1ENwb1oP+b0
 EzPNeut0z9xSfc3jv4STK+ttIgnHmakRnrFXOnq/daGk4unmE0kjyjyeLpxVH4Yw2/svbtu0DM
 NAqndYAAAA=
X-Change-ID: 20250628-lmi-fix-98143b10d9fd
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=h5c6IBJbv78fE5ZeORO47Y2ZLDLghsSas52hLDJz8Vo=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBlJJz8qPaua118peG2Z8d7KXedmXvvN8F7nQ5DvxLALr
 i1aBiY8HaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjCRJE1Ghn9p25RO+y+aYHmF
 PyOd4WOLcKud+dnzmg/k/+4xW7kptIDhf3XL0pwI3gVJF7qn3vom2i6pFMXlKm29+tr86oOzF81
 I4AQA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

First patch is a prerequisite in order to avoid NULL pointer
dereferences in error paths. Then two fixes follow.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Changes in v3:
- Add Cc stable tags to all patches
- Rebase on top of the 'fixes' branch
- Link to v2: https://lore.kernel.org/r/20250628-lmi-fix-v2-0-c530e1c959d7@gmail.com

Changes in v2:

[PATCH 02]
  - Remove kobject_del() and commit message remark. It turns out it's
    optional to call this (my bad)
  - Leave only one fixes tag. The other two are not necessary.

- Link to v1: https://lore.kernel.org/r/20250628-lmi-fix-v1-0-c6eec9aa3ca7@gmail.com

---
Kurt Borja (3):
      platform/x86: think-lmi: Create ksets consecutively
      platform/x86: think-lmi: Fix kobject cleanup
      platform/x86: think-lmi: Fix sysfs group cleanup

 drivers/platform/x86/think-lmi.c | 90 ++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 60 deletions(-)
---
base-commit: 173bbec6693f3f3f00dac144f3aa0cd62fb60d33
change-id: 20250628-lmi-fix-98143b10d9fd
-- 
 ~ Kurt


