Return-Path: <stable+bounces-48271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D728FDF00
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 08:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3119128D65C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 06:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E99A77A03;
	Thu,  6 Jun 2024 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JbJg1HQC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB0613AA47
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 06:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656211; cv=none; b=pfUDZv2LoWU4rLjVq1lsmvBDFSqyrqdWI/7SffE4RH4glZG0RLPs/wncXW4Y8uCT1v/j/J82zsmPf/4foHRQvV+RdqKk5tVMED5nJbBgSbASgZSvnvttGbXX5vSHeYeHOoyEqJuMXmegpqqpzCfNWamvqmmLmDz5eVjBKwrRPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656211; c=relaxed/simple;
	bh=lUTwQmTkXSAak3oROEANOq70038+HQrsZbNaSYQ2QYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umF+K/g2KauddTkztp51VU9/qoxT3LN1R/JnBTueSXdAHNXmk0LAndId/LAGjIrVEZOLw9UoT128kQXoUtFe+xmBSMKvGE3obJxeSTAp1LhFt1HF3EL4X7OQ4InkS3iVEKzS/qS0Lx6bJLuR+H/clz8vC9X/c0fGa/6KOutZNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JbJg1HQC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so6843991fa.1
        for <stable@vger.kernel.org>; Wed, 05 Jun 2024 23:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717656207; x=1718261007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omfvRqkaBys+keRVcCwWZsFLAUvdCTBnb4DeOzbHfX4=;
        b=JbJg1HQCh2aIquqEsg6HggZcyaY22fGmRrHencI4b9o9Ft6B6I/LpPumOX7WJWaShV
         90raB0HlZnb3aQIZWTtHLxrP16Yt3w4UgrHlEFdvvO4xbLRBI1q487B67h1xsnp0QeGX
         WX6Pd8szP/g3kaUjl9PcxbTNkVEI3HaFz6u/hcUDJ099VLAD75aSuhaxIemkmYxN+FyS
         PIiDKhjP6Mw0exWrhoBvOtv9bQWgONMJgqKxUnFEbDgh6uhAip4GqRmRB3nEG46JvfLM
         9eyvOeC9d6lZCp381zSQquyUkgzKJ4tnaowfzf8euWMTCAW6OhTgCHkNuF4iCCt5XX5c
         ZxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717656207; x=1718261007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omfvRqkaBys+keRVcCwWZsFLAUvdCTBnb4DeOzbHfX4=;
        b=Xw9NgHREVWu5cYuVbG5tAuO1hOKwBTMd0kcPUnC3X8Rz1MM5lzG/zJmOTNuy8G9pCO
         z8jxQIgY20qi3eOkgsradfs1ArmkFJVtdoX6KNvFjJ0qSsD2PfN0pJPMB8y7UQbsnK4R
         WzWzVEGrondRxEZ59pYHJ1YpequwIvTcS2ACvvOsGnk78GzXux7coyC7S28Gu8WlgiLo
         rzL5r8ZtjfGnDNk6lJWKb7lK97oZfyPdzIRypaz897c1GpZpw/lNxkFD8HreUBKcUXBa
         77N9C/oRRFJG0D1rcH9VcDKk9MPmF4DmSwBd3OlsT6bcdehIkTRVPA5NkzGpJmgLAWBG
         RXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsBRG+A3ZroPMGnF7bhgabGxJ2MmWWrWLMc8OImKOufLXuBNP8s1AFstp/C/aTJekmYsfFe5J37CCoVQR3uL7MDNAOAcTK
X-Gm-Message-State: AOJu0Yz6Yz4jFpfdjJsuwkxFWR1AtKyfk7Qz/GBWOL2Se7WMJy4kuw0A
	Ucpej6eNH3vSJviIk2SiCecc1WsD9FE0XKwt8PnjD8EPCVI1yFmQD6i3dJXclME=
X-Google-Smtp-Source: AGHT+IEGA59Ld7fxgXUJDzsTcNIscMWvDgsppmsiO4nhCip7lnZ+ctEKacwPIC1ddr/EL9VC/D6TNw==
X-Received: by 2002:a2e:9888:0:b0:2ea:cd94:60f9 with SMTP id 38308e7fff4ca-2eacd9461edmr14568641fa.51.1717656207292;
        Wed, 05 Jun 2024 23:43:27 -0700 (PDT)
Received: from localhost ([2401:e180:8882:8af3:26fa:edbd:5679:640c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de28957153sm499471a12.91.2024.06.05.23.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 23:43:26 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH 2/2] docs: stable-kernel-rules: remind reader about DCO
Date: Thu,  6 Jun 2024 14:43:09 +0800
Message-ID: <20240606064311.18678-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606064311.18678-1-shung-hsi.yu@suse.com>
References: <20240606064311.18678-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sending patch authored by someone else to stable, it is quite easy for
the sender to forget adding the Developer's Certification of Origin (DCO,
i.e. Signed-off-by). Mention DCO explicilty so senders are less likely to
forget to do so and cause another round-trip.

Add a label in submitting-patches.rst so we can directly link to the DCO
section.

Link: https://lore.kernel.org/stable/2024051500-underage-unfixed-5d28@gregkh/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 Documentation/process/stable-kernel-rules.rst | 4 ++++
 Documentation/process/submitting-patches.rst  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index daa542988095..a8fecc5f681c 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -168,6 +168,10 @@ If the submitted patch deviates from the original upstream patch (for example
 because it had to be adjusted for the older API), this must be very clearly
 documented and justified in the patch description.
 
+Be sure to also include a :ref:`Developer's Certificate of Origin
+<sign_your_work>` (i.e. ``Signed-off-by``) when sending patches that you did
+not author yourself.
+
 
 Following the submission
 ------------------------
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 66029999b587..98f1c8d8b429 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -394,6 +394,7 @@ e-mail discussions.
 
 ``git send-email`` will do this for you automatically.
 
+.. _sign_your_work:
 
 Sign your work - the Developer's Certificate of Origin
 ------------------------------------------------------
-- 
2.45.1


