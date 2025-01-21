Return-Path: <stable+bounces-109639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7029A1822E
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDE61883F34
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCCD1F3FFD;
	Tue, 21 Jan 2025 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="j9r8Y6xe";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Ucq7MIk9"
X-Original-To: stable@vger.kernel.org
Received: from mx2.ucr.edu (mx.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47741F03D8
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477842; cv=none; b=nPllAkeoGqD4U0w+77890LYgs0UFoOT1BbBe0RgqusJ9Y2ZeMXr+gGGZ3MCXHuI37tFOnqvUSmE3pi9TgO4i539wNkpBX4EkJRdRJVRgdovimAWH2OtHcDFnypE/h7Mxsw841R7veNUn6rTECJSCjd4ERVhyuPS/hvScyeioEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477842; c=relaxed/simple;
	bh=Fzf2K696pyBqanBzNJulaHToZihctk5Orgyt0KiGdc0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FIZj4JmEMWFjLvjpO3gyJGfrIn2aJOpeDSnHjbyprTKk29eEArkmZFh72EaIZhLQl+jbK0lPAQht1QFCfiPB2ykFSUpEq9C0zqyVIQeLEal2+gu5m6iwR2lGOzsJDmPojjxYYZ8jUXbzAd2H62v//RI24q0HAhL0rGnCYxFFM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=j9r8Y6xe; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Ucq7MIk9; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1737477842; x=1769013842;
  h=dkim-signature:x-google-dkim-signature:
   x-gm-message-state:x-gm-gg:x-google-smtp-source:
   mime-version:from:date:x-gm-features:message-id:subject:
   to:cc:content-type:x-cse-connectionguid:x-cse-msgguid;
  bh=Fzf2K696pyBqanBzNJulaHToZihctk5Orgyt0KiGdc0=;
  b=j9r8Y6xeNEbQU4K9hYpofAukA4a5mr+KoSwrpWldY5Y8R47FxxUMrNe3
   1oLl13qiR4yPCFo3GSuygCYz07n/3o0GAZ+avFGnE0ECE55OqTB1r9sUj
   tT/2H2NT/WzgbfkBWAFdPIRmgFeqTdaVuzrhy6Qb9WBGdgplLMHVbHqVm
   rMTPW80gAuqwpSGnM/EFSWhg72tiQ+gB6cvndYlB1BJK8fURwXBAfizVT
   LffmiIW8G5iWAsbLrdt1psMvKqVlL3/P13x82LX3Rm4rOrEkZyCQpXJbb
   VvGsAkI5C5t5HxMIkjobB6lkqkzN6bApprfRPUf6wUFQI+uM80j9+41Gz
   Q==;
X-CSE-ConnectionGUID: V2Cnj249T5SpcAtvgrb5Hg==
X-CSE-MsgGUID: xadsaScwTFGaoTQq65jzEw==
Received: from mail-pj1-f69.google.com ([209.85.216.69])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Jan 2025 08:44:01 -0800
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee5616e986so16804349a91.2
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 08:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1737477839; x=1738082639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jTeLCo9KDm0FEAKDRB0703yvK4pkIJchsFN1LN57IDw=;
        b=Ucq7MIk9wjsqWDWae89SurfpR6m+28PZJaxYaSdDqtu19Od2JHzTZXbrYNXn++D2/S
         ytDaC+2APlBqjWcTx2OmszTWag/vhLeMp6GkG8O1mcuZnClf/J5po2xZ0fFjVXSBlpFE
         mEhTw98sDfNDxv7kcQlsVrPVykHANGVBLlD0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737477839; x=1738082639;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jTeLCo9KDm0FEAKDRB0703yvK4pkIJchsFN1LN57IDw=;
        b=dpEJQCW9kgjYJVc0JtmjSk91EyPFmgy3Kju36T/G87PPXJg4paUtBJ/M0glOdxLg94
         LHMpvVd08I2wD8WWT9hyOYq7EU9T1jn3C/gPkfjlU1gbqcvf3QjFS5E/UF4y6JF1vfC7
         wlDiO9XcxJ1UfwYBHPpqc4xt1itCq0B9piYdObFKIzLOzbAPhe9zUzX0CqpJANEkOALh
         4AqjC95dhmNZiGT6tMgbOVhJTq51OsbHaw4CtriU3mZBT/esc6UPuudc9VmLXXZq8mvo
         dOeWnebMlv+nb0jbvCHlW2uw68tEYU5Y+FqVyQUOXCUSDvN96zKx4yuHM/kHHN0evMO0
         lZdQ==
X-Gm-Message-State: AOJu0YxeBdwjHB+/D7UpgfsJD0RjKffRlySdOqLpWx4Jo1cnybGsjZmq
	kbTufp43/dAHIYX49PfjNDzmkPuRt557w4IQV7qR1M3G4IVAa+joBFlgQ2ZaLrjv6mBb7sfPWTv
	IJ3z/Un41nVc25l0n3+8rqANydCvDvlBebYjFASpb253nyr7VyaYpqz1B45OW5oC5Sheg2ib3P+
	H7IlTMH7DNriozu39ISfwI6uL6k9QYTHX68K0W8MJ+
X-Gm-Gg: ASbGncv7DOKzmhXR000DSA3VjwpDQGFPsmg1NHOIkTpBLZRQlk6cot6/v4LlFi47bfz
	F3GqdSYVIuq4f5ayvPyhsGiaVKvAeLbXi92zAg6gTxNRSoIfJZpDDVnOWXgW+H78Eu8h/31+Bpp
	cWy2J12bF2cw==
X-Received: by 2002:a17:90b:2703:b0:2f4:f7f8:f70c with SMTP id 98e67ed59e1d1-2f782d4f17emr27468761a91.28.1737477839221;
        Tue, 21 Jan 2025 08:43:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKNhvsx66biDq41ZdVkbP8DnxDDlRIKA9Md/ennZMZjj9OpaUozSkI0ta4HHpKhGH4mFscEg2hgD0M5nCr2Yw=
X-Received: by 2002:a17:90b:2703:b0:2f4:f7f8:f70c with SMTP id
 98e67ed59e1d1-2f782d4f17emr27468724a91.28.1737477838857; Tue, 21 Jan 2025
 08:43:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Tue, 21 Jan 2025 08:43:47 -0800
X-Gm-Features: AbW1kvZ2l4t6CGgPAQF3wzwIeV55XqwfTkNahsdfDj42hfHla_SKPfY4n6-SsL0
Message-ID: <CALAgD-7jDpY12ytTr3sho3Z_BoAkw14m8Pxqq8Zqgx-YAq7Lgg@mail.gmail.com>
Subject: Patch "fs: Block writes to mounted block devices" should probably be
 ported to 6.6 LTS.
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, jack@suse.cz, brauner@kernel.org, 
	Zheng Zhang <zzhan173@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We noticed that patch 6f861765464f should be probably ported to Linux
6.6 LTS.  Its bug introducing commit is probably 05bdb9965305. So the
vulnerability exists in Linux 6.6 LTS, but the patch is not ported
into 6.6 LTS.  According to our manual analysis, the  commit
(05bdb9965305) introduced a vulnerability by replacing `fmode_t` with
`blk_mode_t` without preserving the write restrictions on mounted
block devices. Specifically, the `sb_open_mode(flags)` macro was
changed from using `FMODE_READ` and `FMODE_WRITE` to `BLK_OPEN_READ`
and `BLK_OPEN_WRITE`:
```diff
#define sb_open_mode(flags) \
-   (FMODE_READ | (((flags) & SB_RDONLY) ? 0 : FMODE_WRITE))
+   (BLK_OPEN_READ | (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
```

However, unlike `FMODE_WRITE`, the `BLK_OPEN_WRITE` flag does not
inherently prevent unsafe writes to block devices that are mounted by
filesystems. This oversight allowed for the possibility of writes
directly to the mounted block device, bypassing filesystem controls
and potentially leading to data corruption or security breaches.

The later patch (commit 6f861765464f43a71462d52026fbddfc858239a5)
addressed this vulnerability by introducing the
`BLK_OPEN_RESTRICT_WRITES` flag to the `sb_open_mode(flags)` macro:

```diff
#define sb_open_mode(flags) \
+   (BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES | \
+   (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
```

By adding `BLK_OPEN_RESTRICT_WRITES`, the block layer is instructed to
block unsafe writes to block devices that are in use by filesystems,
restoring the necessary protection that was inadvertently removed in
the previous commit.

At the same time, we noticed that this patch fixes a bug reported on
syzkaller https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439,
the crash list of this bug contains one report in cbf3a2cb156a(between
6.6-rc4 and 6.6-rc5), so it confirms again that this bug is introduced
in 6.6 LTS

-- 
Yours sincerely,
Xingyu

