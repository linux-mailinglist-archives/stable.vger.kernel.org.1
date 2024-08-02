Return-Path: <stable+bounces-65292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FFB945A4E
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C3BDB21CBC
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 08:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED571C3794;
	Fri,  2 Aug 2024 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ewIh22yX"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f227.google.com (mail-lj1-f227.google.com [209.85.208.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699071C3792
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588817; cv=none; b=cadDzSn9/05W6UCrnfipXAltWxk+O8eISOQ9hd2i3pWClWOUlDcp9TKtnXsSOa1Y+H1ik3VG7xLPH0gLlQLtA3tQQbHPGWKeMNhV1/IJslUFWyuCeAUmBiwl/7UmlhT18oT6bD5wrioZ1Uf24KWYy8bBRHpL0vQ/3i8WIAEwhj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588817; c=relaxed/simple;
	bh=tWHM8UqA8fOOqKJV3Oti46yQCZVb0SN6G0bQQ7Klu3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtUY2z4okBGnS4ikOf8IVKCynAyeB88bPxkgzEMsZqbgHPaxoCf8HhFkAaBTu+2lJqZJs1E5I6r3HaRbBkJeV7xawSxxXVNGGmTkE6/FZR1Daeih22elerb5vaeuh5h2vdUuGlYHfNEB7IfDRfpjR7moC9nwF19g2svh3CiExvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ewIh22yX; arc=none smtp.client-ip=209.85.208.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f227.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so121754511fa.2
        for <stable@vger.kernel.org>; Fri, 02 Aug 2024 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1722588813; x=1723193613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUJMzKgWc5cVsFl3rSeeURN8tIrVCzljpOW4Gj9qGOg=;
        b=ewIh22yX0d4iZ+N3vEcJTyrBFVc34mlx/QLv8pXloMtLR2yspmfWxrjoDtnT7XlikF
         G6YtqMDaCdYuorzM5qusCAOi922j01AOfDYrpzXAZAImOVUHwU52hq3SAYf0/xRazVv+
         u2SSngWafZbClAyLrsNP6ZipnCa12ggepIaGPGCXDd+IVjP2Qqo69JhUJF8zqKlJuPBL
         Lnb+jSfzOiA93N3wJyPweyAGrKMTbkGZ2dB8beEGxp89vww07KyB+vnUGemdsXRr37Ju
         /yJY85Bv9hFy3graOwXymsIyD9V/aoe+1J9k6X/gio36jWNBdaLKj3FKrUXZ+4DplPc8
         NVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722588813; x=1723193613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUJMzKgWc5cVsFl3rSeeURN8tIrVCzljpOW4Gj9qGOg=;
        b=k9nuVe9X/LbRJfz8d9wZV/REfKIN2MFTUHpy20k4XvFm+6oVeHLpTxUtV7N9+voOjH
         kmnv2wvOdtCKWwV+gdAZxzzzi68sB103HluIqZ9WRJNAchthI1ysS/VjZ4/J1BVV0eZI
         x1P3SOQVspthFmGe1S5VJCkUG2J+E003wSEetOxoPmfXCiaFTjJsFfNmsn8wl6DvwVzQ
         MARL0zcz2xGMCfRcTrzXbzmC1nJ7Hf6IOG+FeTjFpSpbHB8HZlzC/4/d1j+7Wjl1JtP1
         i0NhI5LyuiTdPe42WVsFSgDFN58FNNwT7hSkoAfJSzVm6BAh1Li6Z6z+/uViKoodvv1S
         wsmg==
X-Gm-Message-State: AOJu0Ywpym00n6VJYG5mTUoCdYwVlN59RLBGfpnElWTQB4DqaWKslef1
	2dz0jivGTsi7aOg7XXgWe7V5y5YNA7FRzvvKVDPBts1bxQTatub8giZs2NYbL5zThQU36ah1aHz
	5iAzDY4nomasJbXQrFasEVFJCOfyKeSqf
X-Google-Smtp-Source: AGHT+IFGu2empkKdYoiABjGmlwAuNCxe3d39BHF4O8jwx3VNSO/aYZmVorpTS/WEbm4zXonR30kR7lCZKPzF
X-Received: by 2002:a2e:a403:0:b0:2ef:232c:6938 with SMTP id 38308e7fff4ca-2f15aa8500emr18735761fa.6.1722588813191;
        Fri, 02 Aug 2024 01:53:33 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-428e6eac356sm410825e9.50.2024.08.02.01.53.32;
        Fri, 02 Aug 2024 01:53:33 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id C890912C3A;
	Fri,  2 Aug 2024 10:53:32 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sZo2W-00BXLD-Ia; Fri, 02 Aug 2024 10:53:32 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: stable@vger.kernel.org
Cc: nicolas.dichtel@6wind.com,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] ipv4: fix source address selection with route leak
Date: Fri,  2 Aug 2024 10:53:05 +0200
Message-ID: <20240802085305.2749750-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <2024072916-pastrami-suction-5192@gregkh>
References: <2024072916-pastrami-suction-5192@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 6807352353561187a718e87204458999dbcbba1b upstream.

By default, an address assigned to the output interface is selected when
the source address is not specified. This is problematic when a route,
configured in a vrf, uses an interface from another vrf (aka route leak).
The original vrf does not own the selected source address.

Let's add a check against the output interface and call the appropriate
function to select the source address.

The flowi4_l3mdev field doesn't exist in the linux-5.15.y branch. The field
flowi4_oif is used instead to get the l3 master device.

CC: stable@vger.kernel.org
Fixes: 8cbb512c923d ("net: Add source address lookup op for VRF")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20240710081521.3809742-2-nicolas.dichtel@6wind.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/ipv4/fib_semantics.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 735901b8c9f6..188f87ffff69 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2286,6 +2286,15 @@ void fib_select_path(struct net *net, struct fib_result *res,
 		fib_select_default(fl4, res);
 
 check_saddr:
-	if (!fl4->saddr)
-		fl4->saddr = fib_result_prefsrc(net, res);
+	if (!fl4->saddr) {
+		struct net_device *l3mdev;
+
+		l3mdev = l3mdev_master_dev_rcu(dev_get_by_index_rcu(net, fl4->flowi4_oif));
+
+		if (!l3mdev ||
+		    l3mdev_master_dev_rcu(FIB_RES_DEV(*res)) == l3mdev)
+			fl4->saddr = fib_result_prefsrc(net, res);
+		else
+			fl4->saddr = inet_select_addr(l3mdev, 0, RT_SCOPE_LINK);
+	}
 }
-- 
2.43.1


