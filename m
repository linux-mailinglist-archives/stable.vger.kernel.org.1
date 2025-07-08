Return-Path: <stable+bounces-161333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716A4AFD5D9
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCC93AE4DB
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7D82E6D08;
	Tue,  8 Jul 2025 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="dIqq1XRY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FACC1E521B
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997559; cv=none; b=TPslEV28eTpT2GvK5EWeu8LGDGC3EqrTI5kkseQDGTrIAyBpzySbk9PkPuIZHhhZ+i8Vj5IkQeO0lv0ufC5s69+J1m2fticDZDrKpzHn2UGr3x1uWH+CADVEvZxH7mLuxyyi4ZchwkCdkUvqqVMD9bzPLo827J3+lNfr74MBHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997559; c=relaxed/simple;
	bh=IkYL3nYzQWggt00fgwQzIQnzRCunYkAyGItmeLTD360=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=ijqYP7QvfmCtNYmuCYMs+KZBTgnbERSslBgl3oHBmAKN9SgKi/4ZaNlOS8+r/u6HZVwtM/oHqWs98C4i0nvhfSHAdhqUeEJbYp5qSEbHlcvSFWwYdZZGufyjxlSeCYyQfq3uaIUkmjFSLQeTmL4mHhhVp2AHY+7cLqxpdgRKfNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=dIqq1XRY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70e767ce72eso43492727b3.1
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1751997556; x=1752602356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVvKPdTxiFUUtAVvxXjReumXE5VRCUy2S/2JrgaZy0I=;
        b=dIqq1XRYoh3anjfwdQmX6ovVkQY+pc0mOqN2DDuqqNue28urVW/x6pwfK+k2lqi81o
         cVsQlvtit6KYo3GymDs2qc8J7FSK1AfwzJK8CqLAMhVPnAvOV1RK6Wn7EKGVfXGNCjxw
         FpOYDAZy9Ck6EaYSgj7ex/1sKc5gm7c9M+UBGgCvz80/Mpqr154eUAZX2ZeYyrR33Zhp
         UpYJPmHPoL2XuNll7OB1otsnn70B0V8U8a2F3drA/sO8rK8l0TNNGyqJcad2+lqwB37i
         6/GPFQJBdZRSWI+TeBJ8Sq6ilqjs8R35KZ2sK4Qbs03P4fj2NnBsb6irlzSuiVBKnXBT
         5yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997556; x=1752602356;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVvKPdTxiFUUtAVvxXjReumXE5VRCUy2S/2JrgaZy0I=;
        b=C0sPEQvA0KzRkIVfKMjikXBsFxCnK4AqbmUzsuMIKqQ1++FoxWeB0Eb/pinEv3Qaw0
         7VKC8VdhcF7VVQrATmSCSzqN52s2/gf2ZYw0GGlVwiahteDIPLnhgBIBe1Hl7nvC3O2W
         YUg20vFBABF7IqV8BrgHMLSBa92IhiEyVxCsn/REqQjeGBGWfZy7+Zc8PRzHjk16CVfJ
         kPR26D5sHVR8/IodqBl6rc0gQq3vf+klR2onKlKh1d8LKwF4GaviSySQnIeTcjbCq28K
         sBGvERgna9RmM7KmlaYw/lDWwxFYVWUNXD3g7/fHnRjY96OJswMox/Ab3l7AJm7Z3hJT
         9DfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFR619U8HbLheAoDO7enNy6agKLGSqBXLjaLU8YaYFzaQK4Tq8h6NH3u5ZJbTKi00BieMnBIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwelMJw98wkaGhrC5Ja10ifak/ZHxvaCoTmwuUO1UbG1FlWPncR
	tSuBnYxnJlfjVlFyy0zhp07Srcr39r8944kY1L/c80JyB1JUwnAZJwgTe8+BPzc85kk6e6ZskXP
	uc0tVwoGcQI0k36WO2XycMEufgjQsRvx7YkXl3TKnuwWJfFdUoWMcs0Vpcg==
X-Gm-Gg: ASbGncunrSKa5lLA2Xn6pnY3AjopbnxTvQ/uSg5S+h0Uxw7zSl2YHFyNxN8eQjb/rYF
	/6l94YWOc/4t4sSWODJtN5om3yS86DCjk/TMD460exNvz0sLk1Nfz6c/IQedqtZf9d4bagWtODM
	NfxsjAaBq3vBJpJaqIF3iEGC0MEiifK58d4NPT2nl9zA==
X-Google-Smtp-Source: AGHT+IEFFlfX+fsz9V8Pp87ET5udpohEgrCmSBsRZ9z+9gVmCCdF/k2a+5Z49qKLHJy7TbSFwspwR0QEIU6Bx3+I9xE=
X-Received: by 2002:a05:690c:9986:b0:70e:326:6ae8 with SMTP id
 00721157ae682-71668d02d18mr263892987b3.2.1751997555908; Tue, 08 Jul 2025
 10:59:15 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 13:59:12 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 13:59:12 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Jul 2025 13:59:12 -0400
X-Gm-Features: Ac12FXx4wIRZpLQLFytC5BOVf8lmHkLOhW6UxyhhkNqCMiSgwIZIWa1Vr3cn7S4
Message-ID: <CACo-S-3Jmah2i793FbXyRtYbeOA65y9S+sbq3ssJs3jmRZo1WQ@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) undefined reference to
 `cpu_show_tsa' in drivers/base/cpu (drivers...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 undefined reference to `cpu_show_tsa' in drivers/base/cpu
(drivers/base/cpu.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

- dashboard: https://d.kernelci.org/i/maestro:ed59ade8431fd2103ddcaa4aecf2bf1e5a305aa2
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  57a10c76a9922f216165558513b1e0f5a2eae559



Log excerpt:
=====================================================
arm-linux-gnueabihf-ld: drivers/base/cpu.o: in function `.LANCHOR2':
cpu.c:(.data+0xac): undefined reference to `cpu_show_tsa'

=====================================================


# Builds where the incident occurred:

## vexpress_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:686d532134612746bbb53941


#kernelci issue maestro:ed59ade8431fd2103ddcaa4aecf2bf1e5a305aa2

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

