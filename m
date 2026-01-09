Return-Path: <stable+bounces-207852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B61BD0A5BB
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 14:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7FAC30A6E90
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31863596FC;
	Fri,  9 Jan 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="mqVdgxPE"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D532572F
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963546; cv=none; b=kH8yeHh3LCvf+AAzKn1aRLYLLy4qTxq0jgNtZgBbHEoh+57qgunA2QVG9FCb4nXnLEVY9C57Bk/hUT/sWDufcBuSNoLFh+TDdWr5us7BPcMDi8s0icAVHQaBomEtbM3ss4NIsD4pQrg+g9DregIQgu5kAWrJQ7xI8srsLDLk08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963546; c=relaxed/simple;
	bh=2p0fZ+vxtDXZ756nMH3luz2kVLMSgUsA/E8TSqHSa3k=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=etHnncuKQXjEkk7kp08CiUTvkG85hkhape9foyg6NuhrPY6Dp4zCIdYMu2/gT+EdeEOuA+7BCYH5jtf+VeWfgGBuitF3cERixBjieUJXnoRCIfDRqzNWuoABKNyJUdDY4oUbAh4w/sle2VsC9l97+7Y2ABo0Tbd2mXTWKV7py3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=mqVdgxPE; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-121b14efeb8so512120c88.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 04:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1767963544; x=1768568344; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEPP0XZfdDegFOsinn7iq1aDB3T8p4OeM8qL3I4XXgE=;
        b=mqVdgxPEai2MwgqRLk3cc47JAYZXHhIaCwloarkKa40BiMs0qCnDVJstHPpngIYo5M
         FtnaG5S2A8YXkmeZlJtQkIYzue5Bm7e4YqFxdVP3ka8cZvLe9fAuIA7RHJ79OiqRuub2
         3G39CaYxT9r4RKr8jZu6P90mPQMNvlHWIhjpG2wwZo1XgATGQg9b3zCjcsHv7Eo6wZPx
         DS5emTOAIvPKIFsRhz2BD5fGKCE+wEnhfjgnLjA5pb2B5lzTjh8hE/gAI+ythvV1qw9e
         1mmpx/4usZdyrWmkG69LSk+/ZiOOlSt8UcMEISeAJiqasbwguLLBuafEdJav3INY6h9W
         lEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963544; x=1768568344;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEPP0XZfdDegFOsinn7iq1aDB3T8p4OeM8qL3I4XXgE=;
        b=g3dlx/1OwarS/N7kY+UmyTd+6aUWPZ8lMj7aHTEEQHNzt4kCOD4W5w/JH4GHsvRuU9
         zTfuakevdyFVG8+z8+lP4jbMuF29S/C/UTuHvliAvpXThvlPtu5Nhh8clJfwKIkuKLG0
         Z/0wewzqqRl+wyQOENMK59+DqjYcqEki9zvhe/97P2yDatWty7x+p+gT+JQmkmqv2aa9
         rvo7dvlO54LMVUk6DGRGFEwNrQQ32gArXVJNbpYH0HzKqinaOC7woIjP16WXSYdyDaOp
         8ewvg/+svOG+CnKIyuWdbfSmGuZoHFOhKv/Bm78DvTWifhWNBAaxs3dTlrhU/gOEOYIN
         BfdA==
X-Forwarded-Encrypted: i=1; AJvYcCWpnPb9HtD8LX1qb3GSV0umqnsIwmZnvUqcoWndI8wUUDGO4JlrnhcsGL5RMoXemR7Jd5qwxHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTfNg/T0aEnb/uDKH2aKrrMjG/7bYjBaXbCVsXvtvfElkmkNJ7
	IkS686FoaNMr9hYJM2PjHi6CHF/mt2rvVvEEIlRqI7JEhbNI4eddJlVfMJ7AzvR2xZQ=
X-Gm-Gg: AY/fxX7OPzcjh7SLFQrSLSMDDYNJkvMnkNEQk4kpDqpWzJXVuhlBDWqtmPh+UjeQUYM
	pJ5W8pgX0Ackr8035YGOzAmhJIAoKeBFadoeMbzNyvtSYnar/jItUSmrRLxD/pFyCk/U9305w22
	lHp/rr5HqubKJQi6SN8r3NUvYa5RH3AYdFvcoPSFB+04KCp72sI5W9aafgBd2IcFyF+zXLMxLcx
	ot3y5eh1qnjgj1JSBhE8Lxq+ckjsqXhII7Tu3mM6zl6IP6nn6Z0Gr6rivRVGm2n8NrRyeAibobK
	2++1iwou32PFihQlcYpPeLN4LJqXRrFlVB3M8UcsK7IouK8XMMmoT98fFHiz7yPLS6tT14osXgi
	flNv6v9VYnLsXCQZfuDJHLAokbvrpJ0uEU74wqAPvsxExfoQGfuk7OU/zSqo6eAWHGb7vKzfkFR
	25KRNp
X-Google-Smtp-Source: AGHT+IF1A3F5YFEs1z/Mm+tCHCQnhryG2BB3jRWKBaiFOwlKOva4lx43fudS1D962HiVbvi9YbwSSg==
X-Received: by 2002:a05:7022:609a:b0:119:e56b:958a with SMTP id a92af1059eb24-121f8ae5f51mr7160609c88.15.1767963544075;
        Fri, 09 Jan 2026 04:59:04 -0800 (PST)
Received: from 1c5061884604 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24346b5sm17520236c88.3.2026.01.09.04.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 04:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) implicit declaration of
 function
 '__access_ok' [-Werror,-Wimplicit...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 09 Jan 2026 12:59:03 -0000
Message-ID: <176796354306.952.252889675745960973@1c5061884604>





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 implicit declaration of function '__access_ok' [-Werror,-Wimplicit-function-declaration] in mm/maccess.o (mm/maccess.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:87a3df1c8cb729c6fac33d91be47dcd67f9ee3ca
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  0d9534c7d771ce08f816b189a8634517e0ccdb07


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
mm/maccess.c:227:7: error: implicit declaration of function '__access_ok' [-Werror,-Wimplicit-function-declaration]
  227 |         if (!__access_ok(src, size))
      |              ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm64-allmodconfig-6960ef5ecbfd84c3cde53e57/.config
- dashboard: https://d.kernelci.org/build/maestro:6960ef5ecbfd84c3cde53e57


#kernelci issue maestro:87a3df1c8cb729c6fac33d91be47dcd67f9ee3ca

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

