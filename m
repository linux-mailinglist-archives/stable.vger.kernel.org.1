Return-Path: <stable+bounces-215627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMxoBHf7imlyPAAAu9opvQ
	(envelope-from <stable+bounces-215627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:33:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9D3118EC0
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 970D6301324E
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B97633F8B8;
	Tue, 10 Feb 2026 09:33:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A811302750
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716019; cv=none; b=b/cAFe9fpAqXMrQbC3n1Sr46fQx8vNM6CvHtDI0NvnA9Uis8Te0v1oxnw0R3GLEiyy28Cb9XxdcT07B+niF5zs7uE0JMMWB46nVU55uemWpgMqB13ru3WvgBW2WBW7FYzICtnVuM+BqT5bdXDirOBZH5SJGePkqHL2/s68A8vEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716019; c=relaxed/simple;
	bh=mVi5sqeEahWfP8LobGM570I5mXwxHlQpx5Lh3H4/eKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plTghcjwoyMInhZA1aTNwcd9LuWQ7iKufzmZ1bHri1kzUTFaR4ndmstIxMC+GB6weexbRt8ZA2DGCmkteHgs5f3HugnG5Mjx7nKhSo5uUlb1l8s3wXoK59P5YBMRh9QmhtisFVISvl+ivyXRuPOLZcTaRdQFofzrHNkhtTotwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so4381892b3a.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 01:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770716017; x=1771320817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgt1M+0Nqzhno9MO/yEbhyYUG6a5dM32C4hAJZUO8JY=;
        b=ggX2WpKgpbocB8kRTOtQLMn3rLU2V93QSk3YHfquZv/LLpE7S6DD8DPsRYgeS3nE3H
         WiyEz9oZQTIiwbfKdOv/bpXYP3sHvLcYfOWygx8jOTGrt6y5InSDFa+XAOKxUV+G4s2h
         Bg5kaJt0w6q+asoty2M0CbdF6GQ42Y//OFeLbsfn1a+GwCWrqOKOqre3fJB02kNhhemD
         7B+tzASnt9FoaTABbbrvmF9n5jEnc+8/yDbS2TdXEstB+uE/AbB6nndkDyHysvNl8ZkQ
         z0X00fELYKwx9YP94A9ZwHsczk0iDvvTE+kJqF7X/gUZJdczgQYD/iSOaRE8Py+v6mYe
         /8bA==
X-Forwarded-Encrypted: i=1; AJvYcCVgaYvruFKnno/Khc9PKOOabRa5frm2OLYeEdiDb3Pb+NNkGmeVg0ckQRwykQe4QCddkXlbKyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTXa0GdftrctcgWTkV9L/IUEYekz78HDR51c3WvhmJgWHw0mY
	A6M879UmDFOb04uo1bHhxYEsY9VschBiN4SVf/iu/W1VRSA98uPuKANR
X-Gm-Gg: AZuq6aLZUp/EsZsxHMKuCYz+m6oroY2+h6VbF0nEYuc5RRG8TrUC6QqG/hErRjLli+m
	O/s09YQMlMiT55UhcNp3hGOlXbZdI7yBsuIK6SbtUlap6gpSIomufiNYFbFcszv8t/ABjXCUtd1
	GQorDw/3hTK9awX6CFJ94IuYGqQpZKscIQYs4vRDJBUiK4WXeeL8IjfFuE9LyQ0wXA1nsFex16F
	iNDmjYMJBKS5B2uGQ9kJkayG4u9mD84cJd7rq++gN8rNKDaOnxjFyzL8PV5PvJU+moqUd374Wmg
	yWBpsZQQReuMKLxQMk9+QeMMp9sJPgpuuHCT/r0xKnfM2vvktAKCempQvbYcHe2I2SWKbr+nltb
	ubrjwzo46n7OB4sZHROChpx5P154S+h/y95jjfUO/e76aUI41N7Jry2byNvv3kJPkxSeVXuZcuC
	rwsD3TXZl4seth1PeJVoAiL3E3w7DDsxQmLyyCUHlUkgMKIw==
X-Received: by 2002:a05:6a00:aa06:b0:81b:14e1:a17b with SMTP id d2e1a72fcca58-82487b31f98mr1511555b3a.70.1770716017529;
        Tue, 10 Feb 2026 01:33:37 -0800 (PST)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418841eesm12966012b3a.40.2026.02.10.01.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:33:37 -0800 (PST)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: dsmythies@telus.net
Cc: christian.loehle@arm.com,
	daniel.lezcano@linaro.org,
	gregkh@linuxfoundation.org,
	harshvardhan.j.jha@oracle.com,
	linux-pm@vger.kernel.org,
	rafael@kernel.org,
	sashal@kernel.org,
	senozhatsky@chromium.org,
	stable@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Tue, 10 Feb 2026 17:33:21 +0800
Message-ID: <20260210093321.71876-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <006601dc965c$afe30280$0fa90780$@telus.net>
References: <006601dc965c$afe30280$0fa90780$@telus.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luoxueqin@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-215627-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D9D3118EC0
X-Rspamd-Action: no action

Hi Doug, Rafael, and all,

I would like to share an additional data point from a different
platform that also shows a power regression associated with commit
85975daeaa4d ("cpuidle: menu: Avoid discarding useful information").

The test platform is a ZHAOXIN KaiXian KX-7000 processor. The test
scenario is system idle power measurement.

Below are the cpuidle statistics for CPU1. Other CPU cores show the
same trend.

With commit 85975daeaa4d applied (base):

    State   Ratio    Avg(ms)     Count      Over-pred      Under-pred
    -----------------------------------------------------------------
    POLL    0.0%      0.10         68       0.0%  (0)      100.0% (68)
    C1      0.05%     0.82        187       0.0%  (0)       61.5% (115)
    C2      0.0%      0.50         23      30.4%  (7)       69.6%  (16)
    C3      0.01%     0.59         35      37.1% (13)       62.9%  (22)
    C4      0.24%     0.65       1092      46.9% (512)      50.0% (546)
    C5     81.88%     1.45     169745      52.7% (89450)     0.0%   (0)

After reverting the commit (revert):

    State   Ratio    Avg(ms)     Count      Over-pred      Under-pred
    -----------------------------------------------------------------
    POLL    0.0%      0.09         24       0.0%  (0)      100.0% (24)
    C1      0.03%     0.44        222       0.0%  (0)       57.2% (127)
    C2      0.01%     0.44         50      20.0% (10)       74.0%  (37)
    C3      0.01%     0.49         43      25.6% (11)       60.5%  (26)
    C4      0.15%     0.52        875      45.1% (395)      41.4% (362)
    C5     97.1%      5.30      55099      13.9% (7645)      0.0%   (0)

With commit 85975daeaa4d present:

* C5 entry count is very high
* C5 average residency is short (~1.45 ms)
* Over-prediction ratio for C5 is around 50%

After reverting the commit:

* C5 residency ratio exceeds 90%
* C5 average residency increases to ~5 ms
* Entry count drops significantly
* Over-prediction ratio is greatly reduced

This indicates that the commit makes idle residency more fragmented,
leading to more frequent C-state transitions.

In addition to the cpuidle statistics, measured system idle power is
about 2W higher when this commit is applied.

Thanks,
Xueqin Luo
-- 
2.43.0


