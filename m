Return-Path: <stable+bounces-118703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE64CA415C7
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 08:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163267A516B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 07:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB46240608;
	Mon, 24 Feb 2025 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SyEIklq2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036D2B9B7
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380641; cv=none; b=QdegR7rAQUJFSm2gB839QFUqMMq409xG0kvwVqe/HFGoj8A5EZM527AeaVRm9C5NkjyAYpXMnB/XNC0/6beXfvkj4SiEI0opz5GGZtmp79l84lDpSe2sLPbI+gGn8moCooXh1Q+oP4ncey0NXlHlvBTrmwq6mKJSkS/D0XDj3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380641; c=relaxed/simple;
	bh=RPkr2Yle/AQxgRyUW8B77AJqlobQFEDPL71xwQL/gG4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ox/DaMlJIFTdBrc4jx9QiQY+wWVeHuHrh+BQpMU0NAMC2ulP7PkzQrR4cnhjENazkuHwgGd1t8h3GxJfbhn7+Lz3TatqCxhDEK8ufL4ZvYqFPtZLmtR/AVzu+/hzZlbnZFamDvDYgqIGdozd1wiaw2IcgFfQBnBvjzzYjEP3H/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SyEIklq2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c2303a56d6so58043185a.3
        for <stable@vger.kernel.org>; Sun, 23 Feb 2025 23:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740380638; x=1740985438; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHRUOB722SP2pT9GOeb3cvEiqmLTG17HzDuBznymqOc=;
        b=SyEIklq2FmUI7LQzbzRtYZcbCHQO0ZXYX1kPQbZxOoejwxVIBSWwRT8UtJjDqsDSRd
         U4pTzLyIILWahG7P2cZa1RlQ/9Y5tx4klo8opq89SU/1Aw+VZwKdf2DI4vYzlhqpwmgY
         7w+B2ujxMhEIXu6ByiraLTS62V6eYuP9SyV9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380638; x=1740985438;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHRUOB722SP2pT9GOeb3cvEiqmLTG17HzDuBznymqOc=;
        b=lQ+1vyr4jOGNZ513nY+vOQq2tK27CzNlsLx3tb5YYE9jzuC/CQXPzah8MT9RlGxsj8
         LMq2L4DaZsSxwvl6R6+dZ8zCaXUWqup94yk1LaMUbP3JPUEK7mQ9uyGGRNh2l06XarQQ
         Zx1Ft97hGM/xxMuXOdS4J3OeWvz/sO7lW2yA/xLRog8mr1zbfCPJqFjMOttunzB/4hri
         MAkhY9BvYvLMLwKvGvRioFqJlB5Y5o/x3twBJjMb0bFs1ZP0nlbxvhQRABRYo8sR03h+
         Dwz2pttCXtYHuEET97ovced0DDWSgKT8qEmuLOfAr0Wr9NSo3KZ/5uNSJ31Gdc/gA5vL
         Rgsg==
X-Forwarded-Encrypted: i=1; AJvYcCXPaoFsDG0UmdNytQMRATKFmp8NH36hdnTNcy3fh451amH4Hk98Vfzyfar691B1iNna7k6Xm7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoaLGpQuGdNLscGDUmf1MQU5L91JQJ+MNKOoYjttUz+iyp5oy4
	JnRAnI4PNhykkvKS17WlIrlRhXj3gdZRveQbfj3KJ9k2ikLBT2hoog69MPOYaiA14yQpwyEb/ey
	c/A==
X-Gm-Gg: ASbGncuHYi+WXLjdpawsI5odbZJj9ZhnCG0oJbsEcQD/6Q9zuKWC3Ufe12daCo6AoLq
	OtSo1cmMwgAF06QkKg4GXBn+3iuwA8FQ6AWbL//xTUsbqs4OMeEswxsyKm6hg9rRLJ99r8RvU1j
	cG6TZgJqkP/kgudObxZ9lrInJ4/agv8mHdS8ApA6BTVGfXOi6mbUKjQG+l1cDSTB7gMwUolo92t
	h62BEBYBGlCalSzXuld9zpKX778jfST+Urkg32sEFXeDOgTbZquYsD+/L5sfW8UlwwjRP8fDHrh
	ArzuVH4Bi7yF4AmONpZ3XB61lPr8necEm2mRDI+V1YdLx3wSnm6t/o+W/lDnXvaAyAlJNmgubAH
	QMDA=
X-Google-Smtp-Source: AGHT+IFkIZyKy46tv3pPOrC7t02hlkGCHtN8wPMQx/td4toBFnJF7+sLcSy9HQrjuNm68CaBgRk5CA==
X-Received: by 2002:a05:620a:450c:b0:7c0:abe0:ce64 with SMTP id af79cd13be357-7c0cf8aec7emr1654304985a.9.1740380637686;
        Sun, 23 Feb 2025 23:03:57 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm977920485a.47.2025.02.23.23.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 23:03:56 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] media: nuvoton: Fix some reference handling issues
Date: Mon, 24 Feb 2025 07:03:53 +0000
Message-Id: <20250224-nuvoton-v2-0-8faaa606be01@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANkZvGcC/2XMyw7CIBCF4VdpZi0GiLe48j1MF1yGMosyBlqia
 Xh3sVuX/8nJt0HBTFjgPmyQsVIhTj30YQAXTZpQkO8NWuqzVFqJtFZeOImAt6t0FkOwF+jvV8Z
 A7116jr0jlYXzZ4er+q3/RlVCCoXmFKTz1hv9cDHzTOt85DzB2Fr7AoP7C4ehAAAA
To: Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marvin Lin <milkfafa@gmail.com>, linux-media@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1

When trying out 6.13 cocci, some bugs were found.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Squash fixes and port to cleanup.h.
- Link to v1: https://lore.kernel.org/r/20250121-nuvoton-v1-0-1ea4f0cdbda2@chromium.org

---
Ricardo Ribalda (2):
      media: nuvoton: Fix reference handling of ece_node
      media: nuvoton: Fix reference handling of ece_pdev

 drivers/media/platform/nuvoton/npcm-video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: c2b96a6818159fba8a3bcc38262da9e77f9b3ec7
change-id: 20250121-nuvoton-fe870cbeffb6

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


