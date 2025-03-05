Return-Path: <stable+bounces-121104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE8BA50BD5
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 20:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7063A788A
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8A9253353;
	Wed,  5 Mar 2025 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="hvct229f"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986582512D9
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203983; cv=none; b=fKYo1kg9+maC3T4teFiqIijohOIC3ZBZhyoOkMD74GGmRfuZgnCVZRcczaGHeht9cnUMnWW9z14Gkw0mSHe9oU6Azyt5S0Mr4mAuTOU+xPkgMW1Wghmhqu6Qm8X1h7C0VyNVvbW/0JKC9FcAb6H8382IoTfXPhUcUL3xAAeZ7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203983; c=relaxed/simple;
	bh=l13/SqgboJjJorbj8CHcCalccA5umSzD7yjYLAXBwmE=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=SWgZ757e7v6c4NYaqzLwWHIIIvS5n4m0KySTUSqP6VYqBUnOCtsVLgctSfOX70YAHGtfJ/I39p+pVoiCb+603dJm4EE5NLnPvG1OBfoeqeAMGFk4VauMy/vtQ9oVGr4oEAi6eDsR9NtUsmxPjjqaXpRSmbJZpYJdeXB6yL79S7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=hvct229f; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e549be93d5eso7694186276.1
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 11:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1741203980; x=1741808780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Em9CgQSt7+q2HGO2A0bmg2tb6kcqBtQd/5LnJubDwMs=;
        b=hvct229ft123M9iHPHycgobg90qjfBvH9XFloJDfoKJmOZ0tSEpnz76ZK0G/A9umtp
         uD9Y6fwjC8RyeIC49f+wlSEdf0Pi4bYWVFSrfNNw/VDDcC81Sw+L1gj7BT3rSD0mOMQF
         V9GOQ6ib+4vjCSlEEmSi4TMufCcX+LBuFsuZfwo75xmJlMpWdRjtDOYIYNpuZU6S4HfQ
         jap/LaVY3besmI0yrRrpkMLrfcGN4jkmjRyDOvK+x46ooyx3Vi90UU+4gkJlM1mnW8QC
         gAtwSYHV6ukFbBIjS+/QcXT5iPXgcXtJkUumcClB7ekV/4MAG1b8tn3AHkPT8DHTvS5t
         GUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203980; x=1741808780;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Em9CgQSt7+q2HGO2A0bmg2tb6kcqBtQd/5LnJubDwMs=;
        b=u9FMPVsVTpqOAZAOXjEfPd+UmExQRyqcuONnxizg4tlz5lFwIVS2eUQMtp+cQoFoPy
         1Lt/Gra4R8erAo2AeWVSEz+N5+h9UFJYo8qpSqqFzcVgBjVg7A4NKbLfIeo/3rSnhKA6
         xdhRS865IEl9GRJ1SG/6M0ycjBseKHdcxoX5X12FkKeQhyrUz1k57MXmUptTG4KophbJ
         EhDnTyyjzHEAvS/3/+x+NCjVIdMfPGgN8EMeHR2N3DUaPcnBO9A38XETxl0iX1Hn4vN4
         WU+5cFciwP93WNNgA90zlx6dDwmyiwv51/pGfB3er7rPNTWAEl1zArwko1P0byQXIVIR
         YX9A==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4IN0lkpe3NboPAyTK/4yGO2Ge3GOwcyP7ZEBfPwtJKyVz0MIN7tl+5cEdXKpjyMv8txNs/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMwjPlX3TyAKWqIs12RvaC/YFFliRbVia2YvLL3GykzRtW5Ngi
	cH2xyhBx4JDnXOdmNlZtzsU2/ehtwkYdxx/wDlbTf97bvmod1i/cC0chRTK9TTEfw+2zxc+yAso
	nKMnfx5lSUddrQh+WuzLg96MEh5CPKrJdMnfeoNXEOm/gW3ENX3M=
X-Gm-Gg: ASbGncvqE0c4XN+hfY8wQl4d7HMtrsiPenM1+8t8pQXvcSRyAQ6cBDARKuOqChScRBN
	dpdH0PZcFRe5bBJgj/JzNrmeVIcYbmrPOM4YbMZniBJXpiwabyRttceKfNGhZjbqaCNH8dRG7wU
	NftpidxTpQDeutl5YzgJ+wlhG1s+F7ycRLmo1gt8kFJGHbyLC7jZm5MDxnjFc=
X-Google-Smtp-Source: AGHT+IHnxwZAyNP8hlaBKopEJsHsTSZXC52ysAsg7PYLDVDp0vf79cMKLjtFE8/j/3iao19F14U/7CpbX4uN2SgZHhE=
X-Received: by 2002:a05:6902:90d:b0:e60:a3f1:b13c with SMTP id
 3f1490d57ef6-e611e30fb4fmr6471003276.39.1741203980556; Wed, 05 Mar 2025
 11:46:20 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Mar 2025 19:46:19 +0000
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Mar 2025 19:46:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Wed, 5 Mar 2025 19:46:19 +0000
X-Gm-Features: AQ5f1JrPFQvhOpVFe4pk2HQ19KSaZH6RGKW0HYrp0_ol8eWWGObBP7RT4IDbR6s
Message-ID: <CACo-S-3ESjq-1gji9tovx-=se94dAErczQLngz5-ZMJdEj5G3g@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) variable 'equiv_id' is
 used uninitialized whenever 'if' condition ...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 variable 'equiv_id' is used uninitialized whenever 'if' condition is
false [-Werror,-Wsometimes-uninitialized] in
arch/x86/kernel/cpu/microcode/amd.o
(arch/x86/kernel/cpu/microcode/amd.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/issue/maestro:b7c225f752a4128f41d922c0181dcbac4f66eb98
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  9f243f9dd2684b4b27f8be0cbed639052bc9b22e


Log excerpt:
=====================================================
arch/x86/kernel/cpu/microcode/amd.c:820:6: error: variable 'equiv_id'
is used uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
  820 |         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/kernel/cpu/microcode/amd.c:826:31: note: uninitialized use occurs here
  826 |         return cache_find_patch(uci, equiv_id);
      |                                      ^~~~~~~~
arch/x86/kernel/cpu/microcode/amd.c:820:2: note: remove the 'if' if
its condition is always true
  820 |         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/kernel/cpu/microcode/amd.c:816:14: note: initialize the
variable 'equiv_id' to silence this warning
  816 |         u16 equiv_id;
      |                     ^
      |                      = 0
1 error generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:67c89e7f18018371956c7fda

## x86_64_defconfig+allmodconfig on (x86_64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:67c89e8318018371956c7fe7


#kernelci issue maestro:b7c225f752a4128f41d922c0181dcbac4f66eb98

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

