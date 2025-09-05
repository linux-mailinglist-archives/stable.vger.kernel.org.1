Return-Path: <stable+bounces-177813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D168B4561B
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F3BA068B8
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F1934A321;
	Fri,  5 Sep 2025 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv2g7wgi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579E34A338
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070899; cv=none; b=p9SqJqKSd89aa4isfdXO3bHr0M6FHNxkDlnzlYfNQkhCshL8mcHoOhNWb3h+oILMztRxEGWIe4JWpZmqcRdD9yaUvcYwMFarCkT/EjosxHxq4KFPTBqLU2jIu2Exr7JbTcoGfPFCiQvqrrcTj1pYAusjrA+WU4H6knWvM5nhK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070899; c=relaxed/simple;
	bh=NaVHl/13ZFFUbS6iFl4KuWLc5nNhn8qPsLiExBLqwr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtNmQV/iupytOZXLTezitcCmxbSUfSqiWTwOVioNhQ+Hn0Ayt50qvV0T4SWgnRVrpt4I9Loo6xtx7L6nueoktIlJVtxmMKnFcl2azf3RIBorm+XOpeQvyiDffx36fYMpyCuuZxuMxuYdFhATssgBCBnvB0Yi8JjBvte20by2gwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv2g7wgi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ae31caso324547666b.3
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757070896; x=1757675696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/yq6sUXqwBCAkA8/hy1fWE77QQwTIePE4ZZ5+RcOkiI=;
        b=Nv2g7wgiZRN5vpC4vvV5xbYevmJ9xnke4p4+So4esX9usd/+9zEzJF4dGMStxMZ1w7
         +LzoA79iQ72MHOBFefpzNIQq4OOxfg2YDVXFUXP+2LkzqhB7G1HULPHa6cCfIzf994ri
         zhiLxQGEJqF3w6EDpl8G/QNJB/8x8rwFIseGH96xaqcHrKP+UvQB8Puo6fK673d7iC3a
         9jVBlgTcBovfjlGRwgnpAUwNQUGKW7XXh04VPKKTZwtAFqfyhpXmYxdVwXgP7oYygGs1
         Bo2K3TF/dI0CyykRMrp37o9680X42ximJ/taVlYBuCIPceyr4u3A8XvIJ8vH7vlUnh5i
         OQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757070896; x=1757675696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yq6sUXqwBCAkA8/hy1fWE77QQwTIePE4ZZ5+RcOkiI=;
        b=FfGJrsoaZjAPkNhG0fh7LK4WGMkpDXKmlyskUmTlPsdzEXjfMxtuAhT0LpTVqutqjm
         Iy7fx8DeEvicPxtsNIBer3Bf2JG2sSx2tm5J38LwDTZNNRwzg6G7QiTiWrOX0BoTRvvp
         IZvxReWvPBB6Ym9gGtD2yrP9l7Q2siy5yPT/Ey2WULfSI8q88YGu+9icaCTB1hdw9AY/
         sF0fm/Fg1A7AioHt0A7yo7b+1IzlaY0M7di5AJPGdcilSmSzES4FlN7wwLHrOOxpb89U
         GiLVvfKxNBQGfiaI58zQR/+Q/69jYfLkX6zO2Lq4nMawJgS6bgV1kmUscSQ4oMc+7A29
         fysg==
X-Gm-Message-State: AOJu0YyBKyPFNEZuXcGkeXcc9SeBgM4I26TZt1N0PxzBqao5Z/dKv+yj
	oqlhss8rIA8e7VOf3y9AbFKQzUb3M7ORO1keEAnzbl/48tpEq24xrXI85R6NVt38
X-Gm-Gg: ASbGncvLPk0rFTLc0snuvjKlfw1T7MkkPx7xOS6px/3YNjAmj2i8wZFfg+ADfWkNjuP
	zNas8sioQNGtC99sMokKfyMTO/d+ezOrac9Nhrlw7NjjUPz5Ywjm+LIdXvSY1fxUsBg4lBcofo3
	VE9jHZI3OI8qnooiI1zgQjyE8mL8yYWk3BFojarxyb5xNPR7L/8s5VFcjrMJ8G4FkgH4gbJgz+i
	npli1FM4ttmXYYlqS8ABQtupY21C7QDkLQgJCNXdwgDYYsQmKl7ki4JF8mJgSHFt54Ks/VDJ9Ts
	qKlQX5PCA1HqfdCqmO4HH3ablCcft89Zu+C5o+K/MS4em8hV5X+/VikvRjrQAN31IZLE/6oiedf
	So+gscX/NJFMeAuwm1NIkLLZQ0IH4TlEPPhNX9ylOQu5TwdbGN+9V8x8=
X-Google-Smtp-Source: AGHT+IHUYR7ncupJQiFO0JDhvuML+q1hA0wpxFZoXuXAj8TJS0+VTSMGIEz8YMXFIBKjc5Oc3MGZ9A==
X-Received: by 2002:a17:907:3c89:b0:b00:aa4d:a394 with SMTP id a640c23a62f3a-b01d8b7f96emr2344027766b.24.1757070895576;
        Fri, 05 Sep 2025 04:14:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:d0c3:9f59:659d:5459])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046f888b95sm557231766b.34.2025.09.05.04.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:14:55 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Keita Aihara <keita.aihara@sony.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 0/1] mmc: core: apply SD quirks earlier during probe on 5.15 stable kernel 
Date: Fri,  5 Sep 2025 13:14:28 +0200
Message-ID: <20250905111431.1914549-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Hello,

I noticed that commit 1728e17762b9 ("mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier") 
introduces a regression because since it depends on the backport of 
commit 5c4f3e1f0a2a ("mmc: core: apply SD quirks earlier during probe").
Without this patch the quirk is not applied at all.

I backported the latter commit to 5.15 stable kernel to fix the regression.

Best regards,
Emanuele Ghidoli

Jonathan Bell (1):
  mmc: core: apply SD quirks earlier during probe

 drivers/mmc/core/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.43.0


