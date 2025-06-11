Return-Path: <stable+bounces-152390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0CEAD4A3A
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBF3189C91A
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBB91D7999;
	Wed, 11 Jun 2025 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IFxzvHrb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B042AB4
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618359; cv=none; b=ofFysaucQC2XNodmfkC2Bp23Ly4z/pTKYwwVN5oIHS98XJcCYcV/oIHZFWfkjqwMJxoG0ENPgZsB1hxN7fpjLwWM+Xy5k6rHIH5cOA8/GSAhgcH1De+h3v6xpj2ozxqb1NbfukRJzNJx/K8wTSm7xBUSIr4ro+XOw1CE+snDFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618359; c=relaxed/simple;
	bh=Whqqa2EWBdzSbYYkRGrP7lma+tDLq2xR463Mf4YDgHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BoN84QQnWgymePuESxstw3JsgRQpOi8PuKFcAkn5yepzCKv3uNkV7fEfQcgrYBjPe/ppOTe6D2TmUFbd+zazNg40d2pmnuZyYpL2gb0OSjvMyiGEUlXBPoY5xucGja9Tdq6LK8g6GXk3+qIkSKjqlh06iwjp9s32WFeUVdyDhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IFxzvHrb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad891bb0957so1026435266b.3
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618354; x=1750223154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1f03ROxeZphOXBKxuAI6l0O88kO4ah1ZzyK9PREybpk=;
        b=IFxzvHrbHGy+498nAQXm608vZCkJ9HdY3PqEeTCBvKdVRlF5KNr0sytzh1FkM7551F
         LTmvdLQToYNVJpWl0cWCaJlule9HCr2JdeZ8KriTQz+BZg7h0ogIUlkHRl21cuA0KOr8
         CgTk21PFhiPIL1hzrcajzAy7HN5MgGZIPTHEG7M1jNCKa/Hc2+6jXbMthvDqI88MDN2O
         Ewf7qDvyr1pioGtZDiYXBzc1g5ODLkA8JtzqHqilIxdSz6wMnuEy2nHrHw1scaAbMFcu
         K75oL/tCWN2S2fZfjFN1VPXoQ0pNH9WyJQ3KPbqgKHUXQT4m/la4D1HMRd/oPPHixWQD
         wzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618354; x=1750223154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1f03ROxeZphOXBKxuAI6l0O88kO4ah1ZzyK9PREybpk=;
        b=TlVM/0oBp0iHcCAA8NWkxNZFlm+j9PpR+K5q5tD4i77pJ4h52Nc8jyp4K2MeOCe1+q
         jc8m+0s1JxG8BfTkVwQcLnqjbem+7ZWZdKwZxdJ9XwSJgdfzn/Z96oWZx2NtLHKnyTR4
         iPkuX3zhCa+V0lJ6cHearC1UtfYA9UCvb+C3Sutd3qEwkBTEfRCTh+zFm+d274sGFsYm
         Ly747S3vofr/KUv2VmL3DclkpxVtT3R1xdrlYQ2rYwX6Ok0HXR7cPycIZ1+2yTjLo8jc
         QFi2drQ04yytBRxH+qN5Cp1wy2VZE9SPPpro7LK+How3yKhg1djo3M5Qv87YfjRmfMsN
         De+Q==
X-Gm-Message-State: AOJu0YyKsRRAHf0YzVDvPjdS+0oNsVjh8PwcgTWtXwq3+f2SWw6o2bKD
	KdlMl61t2/Tqrc8K5o4JRRYhEt6O+PDy8uqKM2CXXvwwJb8t0D9xmabCIdDZK1UwQDfwHScxQtP
	gEOw7
X-Gm-Gg: ASbGncuMM6NyomT2W/A76J4MOFQqfZsIltCw2QOMz0TccYbP9xHBhnclG6YY9O3WgSg
	6JMK8CP+CickCiT9lTqUlrEadF74cEKp6wbF37FZGmzrKXtt9QzdP+Fxr2ng4Iqb88oPMhZEKGx
	kfm6aaGva+tLrZj4bmVMwgMix+xKyTrDSVno1RitQnIoQ9mjtYlbErc06rrvDY0thnRzTPLXue6
	lVCWtPE0SMb+Ru3N5PlbeSdEuRDnoq6sGxZeZHMfzcLQy6s0EWrgKV5PX7Jr43CA0Lful1qE5yp
	7bbvXDdxMOPcXbKJ2gw3jllRGTdjQujyFOoQjNhl8PocdSKlah9leiI1T1TMtX9MP1BWPNnkdax
	p5AvewyDiYlELCQOr
X-Google-Smtp-Source: AGHT+IG+i0R/phYzIjCSqBypU5c15GZu7UHGnaXd9wmoifgpo3xhG9SfwBsLDTKqQNwciMiQt6GefQ==
X-Received: by 2002:a17:907:94ce:b0:ad2:2569:696d with SMTP id a640c23a62f3a-ade8945f2ebmr187350766b.15.1749618354174;
        Tue, 10 Jun 2025 22:05:54 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade3c427cafsm675513866b.75.2025.06.10.22.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:05:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 6.6.y 0/4] serial: sh-sci: Backport fixes
Date: Wed, 11 Jun 2025 08:05:48 +0300
Message-ID: <20250611050552.597806-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Commit 653143ed73ec ("serial: sh-sci: Check if TX data was written
to device in .tx_empty()") doesn't apply cleanly on top of v6.6.y
stable tree. This series adjust it. Along with it, propose for
backporting other sh-sci fixes.

Please provide your feedback.

Thank you,
Claudiu Beznea

Claudiu Beznea (4):
  serial: sh-sci: Check if TX data was written to device in .tx_empty()
  serial: sh-sci: Move runtime PM enable to sci_probe_single()
  serial: sh-sci: Clean sci_ports[0] after at earlycon exit
  serial: sh-sci: Increment the runtime usage counter for the earlycon
    device

 drivers/tty/serial/sh-sci.c | 97 ++++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 18 deletions(-)

-- 
2.43.0


