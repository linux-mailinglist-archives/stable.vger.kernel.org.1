Return-Path: <stable+bounces-8209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AFC81AB86
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 01:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9783A1F24367
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 00:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E882918D;
	Thu, 21 Dec 2023 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QnUhll9O"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41C635
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28bcc273833so197024a91.1
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 16:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703117224; x=1703722024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCO4Pp9Hv1vq/Sea199yDKNS1oBm5R2ANtFp1asUthk=;
        b=QnUhll9OHcxZNjIh/ShJkMVrAQ/Pq7saK8iSguDcAFCdpkg4DPpHfBW6yN+J0xsTKc
         jW2f5DfALeZNTA2UhFyp/IXa/aD2LN6DhExHb5YchPda7/H4y/ovzXxjfdbXeGVljnaI
         YjOrH8AdM8bRHcc7QACl7nkx1EykkvvUgue0A+DwKYJZnyIdD0zm6ugggSi/3djtlYRy
         pDvIzRXz7wQi1eHJ6U6a6gLhg9om9cBuF9XrjLySUMfxIlr/YWqy7T1kDYq1FDK5FMRF
         j4lGxLkffH7MnxWTAQD0FgpGiM8l1OKwsU4/XOSw5Xxt2OgrHptnWY0H6q1KMr194PEu
         Ze7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703117224; x=1703722024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCO4Pp9Hv1vq/Sea199yDKNS1oBm5R2ANtFp1asUthk=;
        b=UlKgrvEaBZJOG+wLEP+tamRb1QOnrxxYsu/it5jJxBDogIs0sU//h//0Fyx338dK8s
         IXpl5cBU8rSEGPY6zo7votg2qyMLGfWwo3DE6Ka0Tobg5KGoet7PUCSvCTF+UVAfilJm
         aWpq7jdrfRMRBRYtlZEOf8lFfaR685wAyYblK90kL5I23+KIhVMLFAgC1TedvvxB9yAN
         QJKDmimlFiQmbcZQ1BKKQQ48l21u/pzEI7V4Pv0yMpgaxAYj1Z86GOASuBdKLmQLcVGM
         eHzknWbnnnJ2f+JyN32/zP32ODgyjr/SmEYe6ze1XMlTAJcl4gMn3ucdYGXg42crsOay
         lxHA==
X-Gm-Message-State: AOJu0YwIT5bkhzmty1QkiUaT5/9UNH5mw/S5MaRyuOGWrorcjm8NDXkJ
	5KCof1wQncCyBsV+JrKB6uehEZdK/Au/LIf74Ud+Zg==
X-Google-Smtp-Source: AGHT+IEF9JatrHcJU0i3PktIebldc4bkXVgmIXyCzxdZj/ms0x4sd99ap98mvw6cNJ7kyolz4sklZHuwCv/BZvWKoAg=
X-Received: by 2002:a17:90a:de87:b0:28b:c820:958a with SMTP id
 n7-20020a17090ade8700b0028bc820958amr2334850pjv.33.1703117224526; Wed, 20 Dec
 2023 16:07:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
 <ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk> <CA+G9fYsbwWpDVR9KJXx8UO5MXsYT81uAJbLLNDnLianr8jmXUA@mail.gmail.com>
 <63e92a6a-9cb7-4272-b524-ccaf997aceb3@sirena.org.uk>
In-Reply-To: <63e92a6a-9cb7-4272-b524-ccaf997aceb3@sirena.org.uk>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Wed, 20 Dec 2023 18:06:53 -0600
Message-ID: <CAEUSe7_9tE5K7NpsmaG_v_bTJaMGhVVSDRhMn1QYnr2z4vSg8w@mail.gmail.com>
Subject: Re: selftests: ftrace: Internal error: Oops: sve_save_state
To: Mark Brown <broonie@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	linux-stable <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Thu, 19 Oct 2023 at 11:26, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 19, 2023 at 09:07:02PM +0530, Naresh Kamboju wrote:
> > On Tue, 17 Oct 2023 at 17:52, Mark Brown <broonie@kernel.org> wrote:
[...]
> > > To confirm have you seen this on other stables as well or is this onl=
y
> > > v6.5?  For how long have you been seeing this?
>
> > This is only seen on 6.5.8-rc2 and seen only once.
> > I have checked on mainline / next and other stable branches and this cr=
ash
> > is not seen anywhere else.
>
> > However, I will keep checking them on other branches and next and mainl=
ine.
>
> I see.  If the bug has never been reproduced I don't think we can draw
> any conclusion about which branches are affected, I would be a bit
> surprised by something that affects v6.5 only.

We have been seeing this problem in other instances, specifically on
the following kernels:
* 5.15.132, 5.15.134-rc1, 5.15.135, 5.15.136-rc1, 5.15.142, 5.15.145-rc1
* 6.1.42, 6.1.43, 6.1.51-rc1, 6.1.56-rc1, 6.1.59-rc1, 6.1.63
* 6.3.10, 6.3.11
* 6.4.7
* 6.5.2, 6.5.10-rc2

Most recent case is for the current 5.15 RC. Decoded stack trace is here:
-----8<-----
  <4>[   29.297166] ------------[ cut here ]------------
  <4>[ 29.298039] WARNING: CPU: 1 PID: 220 at
arch/arm64/kernel/fpsimd.c:950 do_sve_acc
(/builds/linux/arch/arm64/kernel/fpsimd.c:950 (discriminator 1))
  <4>[   29.300418] Modules linked in: fuse drm dm_mod ip_tables x_tables
  <4>[   29.302720] CPU: 1 PID: 220 Comm: systemd-udevd Not tainted
5.15.145-rc1 #1
  <4>[   29.303601] Hardware name: linux,dummy-virt (DT)
  <4>[   29.304804] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT
-SSBS BTYPE=3D--)
  <4>[ 29.305615] pc : do_sve_acc
(/builds/linux/arch/arm64/kernel/fpsimd.c:950 (discriminator 1))
  <4>[ 29.306499] lr : do_sve_acc
(/builds/linux/arch/arm64/include/asm/jump_label.h:38
/builds/linux/arch/arm64/include/asm/lse.h:24
/builds/linux/arch/arm64/include/asm/atomic.h:86
/builds/linux/include/linux/atomic/atomic-long.h:335
/builds/linux/include/asm-generic/bitops/atomic.h:42
/builds/linux/include/asm-generic/bitops/instrumented-atomic.h:71
/builds/linux/include/linux/thread_info.h:108
/builds/linux/arch/arm64/kernel/fpsimd.c:949)
  <4>[   29.307466] sp : ffff8000083b3e60
  <4>[   29.308447] x29: ffff8000083b3e60 x28: ffff0000c2f42000 x27:
0000000000000000
  <4>[   29.310500] x26: 0000000000000000 x25: 0000000000000000 x24:
0000000000000000
  <4>[   29.312034] x23: 0000000080001000 x22: 0000ffffb3c8a454 x21:
00000000ffffffff
  <4>[   29.313338] x20: 0000000064000000 x19: ffff0000c2f42000 x18:
0000000000000000
  <4>[   29.314636] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
  <4>[   29.316090] x14: 0000000000000000 x13: 0000000000000000 x12:
0000000000000000
  <4>[   29.317096] x11: 0000000000000000 x10: 0000000000000000 x9 :
ffffb047a36178f4
  <4>[   29.318131] x8 : ffff0000c2c4d888 x7 : 0000000000000000 x6 :
0000000000000200
  <4>[   29.319171] x5 : ffffb047a5c6f260 x4 : 0000000000000200 x3 :
0000000000000001
  <4>[   29.320180] x2 : 0000000000000000 x1 : ffff4fb95a329000 x0 :
0000000000800800
  <4>[   29.321599] Call trace:
  <4>[ 29.321996] do_sve_acc
(/builds/linux/arch/arm64/kernel/fpsimd.c:950 (discriminator 1))
  <4>[ 29.322674] el0_sve_acc
(/builds/linux/arch/arm64/include/asm/daifflags.h:28
/builds/linux/arch/arm64/kernel/entry-common.c:129
/builds/linux/arch/arm64/kernel/entry-common.c:138
/builds/linux/arch/arm64/kernel/entry-common.c:529)
  <4>[ 29.323273] el0t_64_sync_handler
(/builds/linux/arch/arm64/kernel/entry-common.c:639)
  <4>[ 29.323951] el0t_64_sync (/builds/linux/arch/arm64/kernel/entry.S:584=
)
  <4>[   29.324598] ---[ end trace b31d3b95f436e1b5 ]---
----->8-----

Complete log (and reproducer) here:
  https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2ZoYpOR7=
9EjlFiAuFHeOWN2rwC3

Artifacts (including vmlinux and System.map) can be found here:
  https://storage.tuxsuite.com/public/linaro/lkft/builds/2ZoYoIewSKk26jISEo=
4QlNaOvVR/

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

