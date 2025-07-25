Return-Path: <stable+bounces-164725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D93B11C8F
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 12:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1495A35A3
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137B423C8AE;
	Fri, 25 Jul 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHNSmihA"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605472E040C
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439584; cv=none; b=Vi1goF583ySoBYJ6iqOhNXLZyJROARMmAmmnyXaCh9AjB18TX2rHnZh40GIfdVZbUqBdW8rhaX/PdGqOxR/9STdHAGhdnbmT6UWYZSC/2HfnZFqhxRe1ZiDy09jR8Fqps0ZQekGJfxHSy7Da+4Mpk7obWCQEa9wz6JtJEVeIh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439584; c=relaxed/simple;
	bh=ttxDiVJgkpWxN32Y+FJXK+oPpnYlAPMt0sBlFVsk7pI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MR5kq3l1FIMqdGTRAM1/kHsu4Y9850rw0eC6frRHs9LYcsq4tV+8g6LiK63yoHEE98EfzJun8uuJAiBX8z/DzKbKaa67BInxOyM2p/ca5WzYA1kH/ik61HKYSHlYcmn3X778ceKEuHZX9KyeABWuky8+JHuOt9z7py10hu6cmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHNSmihA; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4aaaf1a63c1so14787651cf.3
        for <stable@vger.kernel.org>; Fri, 25 Jul 2025 03:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753439582; x=1754044382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ttxDiVJgkpWxN32Y+FJXK+oPpnYlAPMt0sBlFVsk7pI=;
        b=FHNSmihABhvLRrzULKl0vDUfOoRLGQJZRBl2T6LNgri+RXq2IZ2xzNq0GjnXix09bc
         GyLCd36MXm8oLYKxIZDZoCffv0Ip6Bz+74394nDyOQpRez5cWP8+IWPTc8iOTAx2QUO+
         Z09WyeOTN2OREzLX8XSVGIubLiDgg+HIeWAlvAAMjoSMdSo2zm3tK7/xbC/hw2ELe+QF
         1Gh9arHRoGOXhpVtTwu/lYTizbVN2zejJWap29wR+qaUejoqAwI2WyXvt6BIfic01/da
         x3eL7YXdkL7rc/lUVQGJCff8F/02gzrk9Ya3E9Jv8zmz4WOXqOWQj4YkXN9kDuBv95TJ
         QKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753439582; x=1754044382;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttxDiVJgkpWxN32Y+FJXK+oPpnYlAPMt0sBlFVsk7pI=;
        b=n0akqRMTpFiTAtaPHlyrQ1+zESGqY+R5flIzZOlc+H6X0gzXuoVExzGW0Qi9PxYZBb
         Ng5kbOATpBDQk7mit7wyJH4Vbn3kuQN/9mYkyIXTbqWk6dtIUocYKgFiH84PXmrTFvHn
         huHa9UGX7C2z1UiIMpKM1XQzAYDHdK7vmRUo5XMvNmLjczYMBX3kz4nX5jhab4Cxk5sd
         I/Sbaq2ydxIHV0LvZKq7MTvrP+DRd6gNN42jTJPA9dyTVYxkaan4bNFMZ5nvW32ULnGy
         221CpF/l0zRkMG4BjDncBR7i2iP/1ww8/So7Z9kHCcqY+ez9JUhX8y8PF8QImlVsZBEg
         idhw==
X-Gm-Message-State: AOJu0Yzt3elWGsepjw6WKphIg4omxuwCi4Rf0bGZKU+2CT3r9qBSCiEK
	h/5HfOwqHiDhoBiiqHZMRzh+GomUiW6jw8yq0Icvel/vD1E8l/Vb6WYLMOeLuU188KDYy3/pBQ5
	EGodSRKDGCPD3dg5Bp7hvVN10QKecp873PO/lqh7pWA==
X-Gm-Gg: ASbGncun5E9elOga5j7OecyHhfIHBUH7lfoOyeRubS6AGYib8/vn7+qjso1+uEC7ZP3
	qPFn+zJ+CUDNFFU68M3J0ncNjGmhd3qCs8LyE69iRA9Ai9Mk6D61wPGdnIgRQ77uAgos1hBXOPx
	QyJ5KutGx8tRE4dRn6u2+LpcjfYWL9mD7PaS8Sz4FNqsaV76v3I2jrf+tJIep/XY2Pqnru1+EvR
	CBBoYDw
X-Google-Smtp-Source: AGHT+IEWqnY1Cy0B8jLR44yjyWvC/YZjDaGezT9lEGUivwq+ZmxSN8ijqiKTD0+yxTOeXJOuHnkUWHOF+EeWSXJ7PTY=
X-Received: by 2002:a05:622a:43:b0:4a8:1841:42ff with SMTP id
 d75a77b69052e-4ae8ef1b8a3mr11724461cf.8.1753439582120; Fri, 25 Jul 2025
 03:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arin Sun <sunxploree@gmail.com>
Date: Fri, 25 Jul 2025 18:32:50 +0800
X-Gm-Features: Ac12FXyMoKPR9g7iPtZ9V9HhsD0czxDaDHHrQv4fOScHXcNAbXKrym6H6_hQnCA
Message-ID: <CAGvw722wvDKxrmhm--3xu2Ck7fG0Z4PAOyeNaN27bwccbVLRGg@mail.gmail.com>
Subject: [stable backport request] x86/ioremap: Use is_ioremap_addr() in
 iounmap() for 5.15.y
To: stable@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Dear Stable Kernel Team and Maintainers,

I am writing to request a backport of the following commit from the
mainline kernel to the 5.15.y stable branch:

Commit: x86/ioremap: Use is_ioremap_addr() in iounmap()
ID: 50c6dbdfd16e312382842198a7919341ad480e05
Author: Max Ramanouski
Merged in: Linux 6.11-rc1 (approximately August 2024)

This commit fixes a bug in the iounmap() function for x86
architectures in kernel versions 5.x. Specifically, the original code
uses a check against high_memory:


if ((void __force *)addr <= high_memory)
return;

This can lead to memory leaks on certain x86 servers where ioremap()
returns addresses that are not guaranteed to be greater than
high_memory, causing the function to return early without properly
unmapping the memory.

The fix replaces this with is_ioremap_addr(), making the check more reliable:

if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
return;

I have checked the 5.15.y branch logs and did not find this backport.
This issue affects production environments, particularly on customer
machines where we cannot easily deploy custom kernels. Backporting
this to 5.15.y (and possibly other LTS branches like 5.10.y if
applicable) would help resolve the memory leak without requiring users
to upgrade to 6.x series.

Do you have plans to backport this commit? If not, could you please
consider it for inclusion in the stable releases?

Thank you for your time and efforts in maintaining the stable kernels.

Best regards,
xin.sun

