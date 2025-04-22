Return-Path: <stable+bounces-135165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB973A97412
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E918817F973
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 17:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158A1202F8F;
	Tue, 22 Apr 2025 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="yAH0KNvq"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C71DD9D3
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344750; cv=none; b=USUd+jcILu/8JocFdgq4zhAUz1Q/hTfatDuo77oiLEpYFtfSNN7xGa3EXlTM4Y82RpkuR73+suFL+PceivJg3iv2GMgdgtaq94FgE8WicAXYi2PEqVZysGF3Gff2vKSZ3ET+faMrCYq62VUt4IV2GlZb/BYw4vj5u0957HFCdXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344750; c=relaxed/simple;
	bh=jB3zfsq67XWxcW4kM0gA62i0ty1VkwMKa/fDHJYYgSM=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=Zv5Z4NdWh+oPmMKPkrT344aNgHOCrK71BJ07Ey1m3QfvtOkFwDLk4AwGmEr8hxAwRX8rfj9YAK/yrCqughikTFy4lK5ke7HPYU5WOuCyXsBPaXksoqpEr0nZAOcTrBJDsiJavtROBYc4mTaZKP3geWtfS2sNIZ3rAv4O07Xn3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=yAH0KNvq; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7040ac93c29so51765997b3.3
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745344747; x=1745949547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XawuDAChyZRGCCq+NWbwtoUH5PHJKpctSxAW0XcrOHI=;
        b=yAH0KNvqodw8vSlNxTugnYL8ueD683+sQy2zVw+FAx3Er0QNWAN5unvDgNDjTsQTih
         ySFFlDq4hFfQ2TFe1A7TI6ikESP7l8X01NXfGhYBeMth6n6u/ZoqqLd9aXfjXmVxMdiK
         /tBVX9MQYcrB7NGO8B9zqXqpdgxtuDOzD9ieoYVNfMX7ok6JfT82Ae5s2bj1pq0WqMDB
         fcy8TdcCe1Gye4xdAuW8OWp8wFTT+jJ6lWSmLJIOTf4AXYv2YMsmsMbx1+rGKTOw7CMt
         mQdcMewPKwFNHs3SI8BOMdhHOZmWPHjs7d0kmJ84hTGOxJ5rKbUG2NKNOvQk35pmEdRb
         A9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745344747; x=1745949547;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XawuDAChyZRGCCq+NWbwtoUH5PHJKpctSxAW0XcrOHI=;
        b=Itwe/3K5hkpsHNzY9T7hJgcVxkINrVPTSvVGcp/FUywgQhOZYwtAW4DIgDjUaF45c2
         ORxieP5nLMomarvLxVGDa+FxHMjjOmsmFJEHqMGEnKtSlZOA9wWXEWN6rTntMn9AAhE2
         zAfjMJh6xokBZt2Owo4ImkQcEYByAt+gUhEhmRHxEFuWF9/HCLgzO7l99SYghtXr3FgN
         chz7RjYs8UL6/wkJVL7jFxHXg9S73DVsQSB0tWDuwC538uq3OCCpD5y2pQRJfgyaLuOB
         bbHdUltku4ZGl3XeztkGZ7MiHA9H7GRmg+RMxjH0mNmfqwx27AxwX9IstJCoEgnGjiBk
         JgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFSsfQKbOzIOiiQI53Eqy6oYF5pfCyqa6WGivP1dI45aKDmELffcVFGqCiIS6mW9DBAJlsMmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17qEdlFm1YLKkFROWGBJXxog9wBMo7asvQoKlnGMYhLr/dM62
	IkoRJ06+zCBAO+xohrUHTGby+A9f6ZuAZu3KjGn7h1nL4FyLfOIjLeHJzk37O4sf14hlE9XS1oy
	+eF/IRDyIMpELkFoS5K2gPlgxI6Dmnw1HYm+BfQ==
X-Gm-Gg: ASbGncvrA4/EAI3qr113icPA/0jA3X9X8vd6r47qNL9RaecOY0/bsfXhR074uNnM9ZR
	ghY7bdVo9DXxQ6IZ6aprf/h/SUjTEYQXfpSoGL4frnwOCK0Rw9sGcY6jEoMdJatLbuU+yRR8vvj
	nhgkzkxeET9oDzkGsrY1Y1
X-Google-Smtp-Source: AGHT+IHeazHHiZzWEqgP1SzmlOtl3xjD+jf5sKbFpYuXK7qnWY6neTOu5bP7Hg7VvsjQqd57cxG1r9CH3amv8kkxBqw=
X-Received: by 2002:a05:690c:4906:b0:6fd:2062:c8a2 with SMTP id
 00721157ae682-706ccd139ebmr252532277b3.11.1745344747316; Tue, 22 Apr 2025
 10:59:07 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 10:59:05 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 10:59:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 22 Apr 2025 10:59:05 -0700
X-Gm-Features: ATxdqUGAdx_70QuebLp5ODzl222AO48bil39OCUNG9IZnEUlDFgUqWtI0wOIumA
Message-ID: <CACo-S-0UCozXcgj9Y6RW-pceN16wPb_fsbA9uai2QkVyUKmKLw@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) variable 'is_redirect' is
 used uninitialized whenever 'if' conditi...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 variable 'is_redirect' is used uninitialized whenever 'if' condition
is true [-Werror,-Wsometimes-uninitialized] in net/sched/act_mirred.o
(net/sched/act_mirred.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:596e739df5636c4348e4b5c1e97cb3db2187b60e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  75ae2fb1c96adec2e5c35ad91b692a4e940c9edc


Log excerpt:
=====================================================
net/sched/act_mirred.c:265:6: error: variable 'is_redirect' is used
uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
  265 |         if (unlikely(!(dev->flags & IFF_UP)) ||
!netif_carrier_ok(dev)) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:78:22: note: expanded from macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                         ^
net/sched/act_mirred.c:331:6: note: uninitialized use occurs here
  331 |         if (is_redirect)
      |             ^~~~~~~~~~~
net/sched/act_mirred.c:265:2: note: remove the 'if' if its condition
is always false
  265 |         if (unlikely(!(dev->flags & IFF_UP)) ||
!netif_carrier_ok(dev)) {
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  266 |                 net_notice_ratelimited("tc mirred to Houston:
device %s is down\n",
      |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  267 |                                        dev->name);
      |                                        ~~~~~~~~~~~
  268 |                 goto err_cant_do;
      |                 ~~~~~~~~~~~~~~~~~
  269 |         }
      |         ~
net/sched/act_mirred.c:265:6: error: variable 'is_redirect' is used
uninitialized whenever '||' condition is true
[-Werror,-Wsometimes-uninitialized]
  265 |         if (unlikely(!(dev->flags & IFF_UP)) ||
!netif_carrier_ok(dev)) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:78:22: note: expanded from macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
net/sched/act_mirred.c:331:6: note: uninitialized use occurs here
  331 |         if (is_redirect)
      |             ^~~~~~~~~~~
net/sched/act_mirred.c:265:6: note: remove the '||' if its condition
is always false
  265 |         if (unlikely(!(dev->flags & IFF_UP)) ||
!netif_carrier_ok(dev)) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:78:22: note: expanded from macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                         ^
net/sched/act_mirred.c:260:6: error: variable 'is_redirect' is used
uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
  260 |         if (unlikely(!dev)) {
      |             ^~~~~~~~~~~~~~
./include/linux/compiler.h:78:22: note: expanded from macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
net/sched/act_mirred.c:331:6: note: uninitialized use occurs here
  331 |         if (is_redirect)
      |             ^~~~~~~~~~~
net/sched/act_mirred.c:260:2: note: remove the 'if' if its condition
is always false
  260 |         if (unlikely(!dev)) {
      |         ^~~~~~~~~~~~~~~~~~~~~
  261 |                 pr_notice_once("tc mirred: target device is gone\n");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  262 |                 goto err_cant_do;
      |                 ~~~~~~~~~~~~~~~~~
  263 |         }
      |         ~
net/sched/act_mirred.c:238:18: note: initialize the variable
'is_redirect' to silence this warning
  238 |         bool is_redirect;
      |                         ^
      |                          = 0
3 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:6807ae9243948caad94dcfbb

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:6807ae8e43948caad94dcfb8

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:6807aed943948caad94dcfee


#kernelci issue maestro:596e739df5636c4348e4b5c1e97cb3db2187b60e

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

