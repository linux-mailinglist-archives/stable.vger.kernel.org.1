Return-Path: <stable+bounces-116615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B53A38C4C
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 20:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7365A16E8F0
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 19:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B6723645F;
	Mon, 17 Feb 2025 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzLTuFI4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515BF137C35
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820238; cv=none; b=OSiG5hRXBEf0yuo2ZU1NmTMEASHFqTCE1Oqyb66h3LTmElEU07zWaRdfuq500/hbOeASOlbXp5A5slwAGPf5LfH1uLLO1/cSbibTqrXvmOI0sd8H/rEygKCNaZZ9R+1NR1gR8UY+JXfDsjj/b8TZeM0BI2HqbGUg7JYCqpp64rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820238; c=relaxed/simple;
	bh=K5xbticayABbDNzQfkkZK+YCQtH3EDpoHVZLJoDGuz8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PIcwu5w0Ir3fw1tJl8vwZ/7xVp/PhUELHuiDAahf89PKSyBHMojo79LSV4Wwg09jSdWoAXnPbNY6Pqb5BN64OVb/PAiuOmlBduGdgkH7lFXCenTRgc9IMXjLljlk/5BEZbyQftbtNj7JK38WgNY7rVTY6Etpl/5vF2oTl316Bfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzLTuFI4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22101839807so53200635ad.3
        for <stable@vger.kernel.org>; Mon, 17 Feb 2025 11:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739820236; x=1740425036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Te+VKo7kwsLy07VLbZgsTk2pS8KaTJsF/aajK/gyheQ=;
        b=OzLTuFI4awrqQBv8YIYr2ndHcqFgnGw4bGaB6fQfTpcqtv9oNY5LiJcKlLXPH0Uc70
         gO+QDmsuyqhPtt/5WQbONUhNWNT1co1CmG/wWvvuRrN0LYWrhLLE6lKehzCwrV/6g4Xm
         88RYZO48QHbthYHNJdnrBe3kIH9yJAXMAKxDE9AOBVbC0tuznRaVw/LubKe5ZnpXtHUR
         WQ7kPQbS3dKxPlIlJIKMLGrLBhg660F6NDN0jZaoK7zj9q1Gazux4TLPyRe4dolXAfC9
         TcvGmA8+dAbEOr3xdKsSxzYpmXo4OARiw+2wJNg5yA1ML2tTQ2xTPfVpw/8TXktze2Lw
         RRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739820236; x=1740425036;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Te+VKo7kwsLy07VLbZgsTk2pS8KaTJsF/aajK/gyheQ=;
        b=F4xZHuF5QTmjBWShSTXdI8jstSTX6kEMWoktBXaC8HrosFEAy/ERg0HLQnwwFbTbEV
         9za2Mc0zTbbVCHlUgZRYhOZh55FggajRI1YIUWqS8R9aYatrQpzQE5loaZ9AE6ELmrsO
         vVQBzAn6ggWaAkpOi8yWjXJgeXp/H/Hvs/qf+ZbKYrWhiQU+d4KfZb2mZ28txzdfzsro
         t4sd5lq4psp0XtqDnx4Q/2UFK9IcsMsT8C7+44Al7PoNkilkGjYNuPI0ps9STzlKQFFo
         ai5krdXR5fWYIqsTct8c/+RXtFLJ/DVApxTzpB+Dm7dVjuiJAirMVAkmeDdBASnM8LiZ
         WgCw==
X-Forwarded-Encrypted: i=1; AJvYcCVPtR6/WH2JYOGUTpcpWh71J7OgKev+mpbZaPoj4ta3iMDG7zEZBrju0nPSwZ/RG4xwySAT/fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKBATUc5uFX4BBxbswoTUhz7N7aD3mpaOqgMYqqX12Hz0ZdWLv
	SAwGRZnY086M29yDS3dxjBkFc+QFGP0b920s4OUcM8T/SC/blZzT5tcniVBw9svdBTI6+5b1GrU
	eFIF6a5122/+d7E9xe9uvx1hZu2Ex8nH3+CQ=
X-Gm-Gg: ASbGnctJUoOvL0FFHyezDawbY6T0mhdANdiAz/JrPJz1b4nKSFD4b/eI0Hd5kboiKdG
	WlabHUCqB308XJWYJllSpSRch4z1tROF0qgdq0zi+wcI0ahvfz5I4wEFL2IweYiMSgapQJfvCVg
	==
X-Google-Smtp-Source: AGHT+IGM2MoJMv6lQCLsukaIhIVpBZostZCrYYfoO3bBd5Q1WnLPfwZdlh8ioZ3t2FVLgQ1BK7dICrUkaFrA9pViu14=
X-Received: by 2002:a05:6a21:6182:b0:1ee:7e68:6987 with SMTP id
 adf61e73a8af0-1ee8cad0f05mr20251813637.14.1739820235107; Mon, 17 Feb 2025
 11:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marc Smith <msmith626@gmail.com>
Date: Mon, 17 Feb 2025 14:23:43 -0500
X-Gm-Features: AWEUYZnaRdOkbEHkU8bGsBuPq-7dALt5qHPfjaaEwvX3X7FW67L0_2zSXsN-icQ
Message-ID: <CAH6h+hfg4RcwuNUDspMrEt+5Gk5hBhE-pfLTF29M9qJLiYtoAQ@mail.gmail.com>
Subject: Linux 5.4.x DLM Regression
To: jakobkoschel@gmail.com, stable@vger.kernel.org
Cc: aahringo@redhat.com, teigland@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I noticed there appears to be a regression in DLM (fs/dlm/) when
moving from Linux 5.4.229 to 5.4.288; I get a kernel panic when using
dlm_ls_lockx() (DLM user) with a timeout >0, and the panic occurs when
the timeout is reached (eg, attempting to take a lock on a resource
that is already locked); the host where the timeout occurs is the one
that panics:
...
[  187.976007]
               DLM:  Assertion failed on line 1239 of file fs/dlm/lock.c
               DLM:  assertion:  "!lkb->lkb_status"
               DLM:  time = 4294853632
[  187.976009] lkb: nodeid 2 id 1 remid 2 exflags 40000 flags 800001
sts 1 rq 5 gr -1 wait_type 4 wait_nodeid 2 seq 0
[  187.976009]
[  187.976010] Kernel panic - not syncing: DLM:  Record message above
and reboot.
[  187.976099] CPU: 9 PID: 7409 Comm: dlm_scand Kdump: loaded Tainted:
P           OE     5.4.288-esos.prod #1
[  187.976195] Hardware name: Quantum H2012/H12SSW-NT, BIOS
T20201009143356 10/09/2020
[  187.976282] Call Trace:
[  187.976356]  dump_stack+0x50/0x63
[  187.976429]  panic+0x10c/0x2e3
[  187.976501]  kill_lkb+0x51/0x52
[  187.976570]  kref_put+0x16/0x2f
[  187.976638]  __put_lkb+0x2f/0x95
[  187.976707]  dlm_scan_timeout+0x18b/0x19c
[  187.976779]  ? dlm_uevent+0x19/0x19
[  187.976848]  dlm_scand+0x94/0xd1
[  187.976920]  kthread+0xe4/0xe9
[  187.976988]  ? kthread_flush_worker+0x70/0x70
[  187.977062]  ret_from_fork+0x35/0x40
...

I examined the commits for fs/dlm/ between 5.4.229 and 5.4.288 and
this is the offender:
dlm: replace usage of found with dedicated list iterator variable
[ Upstream commit dc1acd5c94699389a9ed023e94dd860c846ea1f6 ]

Specifically, the change highlighted below in this hunk for
dlm_scan_timeout() in fs/dlm/lock.c:
@@ -1867,27 +1867,28 @@ void dlm_scan_timeout(struct dlm_ls *ls)
                do_cancel = 0;
                do_warn = 0;
                mutex_lock(&ls->ls_timeout_mutex);
-               list_for_each_entry(lkb, &ls->ls_timeout, lkb_time_list) {
+               list_for_each_entry(iter, &ls->ls_timeout, lkb_time_list) {

                        wait_us = ktime_to_us(ktime_sub(ktime_get(),
-                                                       lkb->lkb_timestamp));
+                                                       iter->lkb_timestamp));

-                       if ((lkb->lkb_exflags & DLM_LKF_TIMEOUT) &&
-                           wait_us >= (lkb->lkb_timeout_cs * 10000))
+                       if ((iter->lkb_exflags & DLM_LKF_TIMEOUT) &&
+                           wait_us >= (iter->lkb_timeout_cs * 10000))
                                do_cancel = 1;

-                       if ((lkb->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
+                       if ((iter->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
                            wait_us >= dlm_config.ci_timewarn_cs * 10000)
                                do_warn = 1;

                        if (!do_cancel && !do_warn)
                                continue;
-                       hold_lkb(lkb);
+                       hold_lkb(iter);
+                       lkb = iter;
                        break;
                }
                mutex_unlock(&ls->ls_timeout_mutex);

-               if (!do_cancel && !do_warn)
+               if (!lkb)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                        break;

                r = lkb->lkb_resource;

Reverting this single line change resolves the kernel panic:
$ diff -Naur fs/dlm/lock.c{.orig,}
--- fs/dlm/lock.c.orig  2024-12-19 12:05:05.000000000 -0500
+++ fs/dlm/lock.c       2025-02-16 21:21:42.544181390 -0500
@@ -1888,7 +1888,7 @@
                }
                mutex_unlock(&ls->ls_timeout_mutex);

-               if (!lkb)
+               if (!do_cancel && !do_warn)
                        break;

                r = lkb->lkb_resource;

It appears this same "dlm: replace usage of found with dedicated list
iterator variable" commit was pulled into other stable branches as
well, and I don't see any fix in the latest 5.4.x patch release
(5.4.290).


--Marc

