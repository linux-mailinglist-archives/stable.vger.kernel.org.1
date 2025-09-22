Return-Path: <stable+bounces-180973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB4BB91D79
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386D23BC14B
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CEC2DD61E;
	Mon, 22 Sep 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtmW1BKG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79481263C8C
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553494; cv=none; b=FIiPlT0+Fob50DYeztHg5bGNjZOL5Dkblt80p9CFqBv4geZQMtu0DgJGMNKU2odhD+GnxupsgA6Lr+TFml88mxBrW0E/n7IwoFlXLoo9G3BuFJoKOdlonFPJh23xm5CMlaYfoCFxRLEA+Oyrr/ePF47knYFMU2Ei44eUdAoeKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553494; c=relaxed/simple;
	bh=F3TQtbkViaiam8gUJt5ndCncukrSdnsgNg2kTTZJSK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ay06KIMiEgHdiCJv7YMcef6YcllU7pdwHy9C2AfThrp5wgPhCPn05Hio8DmGUTkNZVuWiitY7oLyKpXHKAUNOcNb+foo7A+51DrN1xneYXHRgKJ70uj/ckM86zQ2cx01AHS+LJ6vPvC8kdhY49/b9YyXIHyJzxqU7dC3wKbWvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtmW1BKG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f454c57dbso558214b3a.2
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758553493; x=1759158293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0Wzhr2GBiLR9XupCOurqAE0qKgHtMmqWf9RdNsZ+l0=;
        b=NtmW1BKGGXMF4akKDR7W8Y3PfmjDMZtzHAxyMgSBdtVcQyd+6B5f+Nj+v7Xk4DvqhS
         QwZzU3bc/2wWI6zpVqCNUZyZamT81yzm5FEe863uLw+UoqSBC9BT23aeALwkgvefQChl
         PMoe59/atJf2iQg3NC53bNUuONEWjIgFc5VQqjRfy6YU/TApf9E5Nxtlcj/aP8Js60P7
         ZubE89DEB1fUrfabpCP8ZxBWdz8D9HRLHgrvUs6auqKvNQdVMZv/on65p0MXB+km4KSv
         PlUpv68WyNLitxpzGXrhZgpFc9ql7Od4ch2AqROWBeJbBf2ny6lrNAgyL4xzgwX/D3qs
         Y7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553493; x=1759158293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0Wzhr2GBiLR9XupCOurqAE0qKgHtMmqWf9RdNsZ+l0=;
        b=suLGt0h4bvenwziL6YN54q6hA2tKsfUyrdgKEeCk1ehjDWvAtx4TM7EMXuaoc8qSzm
         76/kWH/txWIgEvF6Ywee7Zplwh2+NDAafZDW0+KH6fGxAjakxBabLC3goSKeOhmko28y
         HUZWKxIOBypLnG1MvjYRUP4cmCx3ob4yjxMVpdix3BS7JiU3kN0ds3q9NFw6GJJvicJ4
         949MLWMLqgIww2PfHyadYmxbmMJ9q7RopyauHgaOKBk/2SlOqA8JDkznDgBAKEcbZeS5
         GO/PlliKgqJi0yQ0kh5YBUj3I6BK9r6D+W71ctckL9Utdke/PxCMMFmt4xPC+39prkKq
         zkPg==
X-Gm-Message-State: AOJu0YzAddjqPzM2zrW8XqrQSD88ghrQEQQgF29ZBDBckDlHgpePb8v7
	QJPYsaPVXBgdemrXui5iyrzLhJ3CX+YR/pQqBlS/XsGE8azM8uRughqm
X-Gm-Gg: ASbGncsz/gcWjyCw64wLV9WD2WAtqfvP3DxngAu4s9A6gXP2gLEfnFvTjT1nGjaKw5E
	tl9NZiBRS1bQCeRS18LyfehfQfJ0UgRuHr7zZmEG94HOYLC12kob5OtXABH8vByji1iBco4GG/s
	9qa329sBTaPko7jR34QVsl/Lzp9KM4vxuDhQELOd3A0O2dmknPzP+WC3knXZutGSedAor7aK6RX
	MEME1L7Sx8UGFUDGXt3rli00S/vfqZAk1s6uDVU9Ey4XC1QrR2s0xSrgI90gd6QOxDhNln5sSfL
	Y3lzSZGXI25Hr8tAAEnd8SLXgdBwYDDbmyfPlmfPyTnJMnWA1TG3QZq3MAoIjB9c6ewvA1i3tQT
	MMHvpOj6KnwOUXZteaOTEVQ==
X-Google-Smtp-Source: AGHT+IFeAHlS4iAJPoHh7ZOm/cwEens/eNTaBkhmdeLozkDog20ChhiRrPA5x5jaDTgoFT+gLSoGCw==
X-Received: by 2002:a05:6a00:9289:b0:77f:2ab3:32d0 with SMTP id d2e1a72fcca58-77f2ab33626mr6873061b3a.31.1758553492759;
        Mon, 22 Sep 2025 08:04:52 -0700 (PDT)
Received: from lgs.. ([101.76.246.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f315029c0sm4101850b3a.47.2025.09.22.08.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:04:52 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH] powerpc/smp: Add check for kcalloc() in parse_thread_groups()
Date: Mon, 22 Sep 2025 23:04:42 +0800
Message-ID: <20250922150442.1820675-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing it to of_property_read_u32_array().

Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 arch/powerpc/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5ac7084eebc0..2da064e00d0d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,6 +822,9 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
+	if (!thread_group_array)
+		return -ENOMEM;
+
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
 	if (ret)
-- 
2.43.0


