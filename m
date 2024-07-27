Return-Path: <stable+bounces-61977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B8C93E038
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 18:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D35B1C20E35
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010441741D5;
	Sat, 27 Jul 2024 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQco6WfN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D381DA4C
	for <stable@vger.kernel.org>; Sat, 27 Jul 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722099151; cv=none; b=s9O/DSbsyMIk/JAkZmqnJ77f6zGSjxHDTnS6cDUPN6QnfjdHfpDgLc9Z+UCwu8ZRzzIievW66as05s7j9ycxv6f3TsuTKhzjtwv+Z/PXahZu7PQzciY6PRRJCEEmgF0mlVWthZjDCmTwbJfPKCc8MNJjGJbzsEzA+wTwpiS96iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722099151; c=relaxed/simple;
	bh=Kt3UTHXY6pUS1uNOKixy1D9DX1Rs2NDL7dotc9CQrko=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type; b=i5LPeL2E9dEZfYq8uXhi7Bp0fKHlDoCxaukfkcTvc/9GvEghvCNhR3WxxOjzVBed8xRnFLzByZsZdVbrf6bdHjzP3tKqxeqNfDnwWRKRRHbMAm/GxAdz0MbuMy1w/VKnZAv53mZIGYJkZdPWmhqq7RR3XvE+9j3/ARquJjRa8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQco6WfN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so34160041fa.2
        for <stable@vger.kernel.org>; Sat, 27 Jul 2024 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722099148; x=1722703948; darn=vger.kernel.org;
        h=mime-version:message-id:cc:to:subject:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=32TR7SGEwzQNHi8BSEjhZCZbMRgIoVZcq32HmZiwQ2g=;
        b=ZQco6WfNYI1NT5C3iSrT+DZeykz5P9FwMxqyk9V/toN7MchnDb/xv6oJ4cZk5RpGIO
         W8vMbnNXiMS9cxuzvyetnAsWFTK4mvkfxLsNPv3/OHVsusjM/Z07XXkSQtzSoKX33ysX
         SIDaTkVLY51I180J39gk3b/LQunPY+Cvas/K8v5XdyBkEYY6I7VElswJHBLDsQ2LAHfp
         i834nCKMNkTHrI69yHuRj7wJOQOmWx30LuFCGDlA5Qf458ltd7DBXrGbxxNdD4Y4n7wW
         /sGriavu6OjJkvlTFBihm85eiqyAfWMSwGtLTTgKTD7xYb2ajdMnS+HbFgnWiRRih0SU
         oLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722099148; x=1722703948;
        h=mime-version:message-id:cc:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32TR7SGEwzQNHi8BSEjhZCZbMRgIoVZcq32HmZiwQ2g=;
        b=jOn+cfZfDjmJVmfAhawz2vg/or9RS38lAvylJNAZVlVNK+DkGnY8dMyrq/rMnb7daL
         hRKdnUOOH82Oy0nzX+K+oFGRSt08X1e5L9k+RDkvkjq7w1ydf/qyyjKcTvH1yDmv7A99
         5uBrLzMeBSvmr/KqDMy0iMkQr3UbTrA1psUANo055UCAhCd1XzW2x6onwRjdbEm4InLa
         CsWDcsA0A5R9phox8zscxkBHH9v3mnUYswiZ1tqUCV+ZaxfnBWkNYFtduz5dDgAAfezK
         LhOBX59DZpH8lREVSYTVYdRlHlkUTguU5ZsBe9usb1zdCXK8JFeCqrCBWLShZJsma3pk
         CO6Q==
X-Gm-Message-State: AOJu0YxciCWTyE19LRjbh4YKoigj+x+ibUN7T7U35dKpvlEfgWEWHEKg
	3O0UmNMYRsV+TUaXxBUhLl4GlduTQQ9yUEx/e+PseOJORysR4TXu1PAzxBlI
X-Google-Smtp-Source: AGHT+IGuAop1O4/gAYTT5gL+X62ar7kjLB5+Ie9wR9wU6dXF9aYRZO7tFMq0G/kr9w7fDqsKQUzmGg==
X-Received: by 2002:a05:6512:451:b0:52f:d128:bd13 with SMTP id 2adb3069b0e04-5309b2c39d0mr1685683e87.39.1722099147651;
        Sat, 27 Jul 2024 09:52:27 -0700 (PDT)
Received: from [192.168.1.69] ([93.170.44.26])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc42ecsm808811e87.49.2024.07.27.09.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 09:52:27 -0700 (PDT)
Date: Sat, 27 Jul 2024 19:52:19 +0300
From: serg.partizan@gmail.com
Subject: [REGRESSION] Brightness at max level after waking up from sleep on
 AMD Laptop
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, mario.limonciello@amd.com,
	hamza.mahfooz@amd.com, alexander.deucher@amd.com
Message-Id: <77KAHS.13UUH2XVHQQF1@gmail.com>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hello,

After updating from 6.8.9 to 6.9.1 I noticed a bug on my HP Envy x360 
with AMD Ryzen 5 4500U.

#regzbot introduced: v6.8.9..v6.9.1

After waking up from sleep brightness is set to max level, ignoring 
previous value.

With the help of Arch Linux team, we was able to track bad commit to 
this: 
https://gitlab.freedesktop.org/agd5f/linux/-/commit/63d0b87213a0ba241b3fcfba3fe7b0aed0cd1cc5

I have tested this on latest mainline kernel:

Results after waking up:

 > cat /sys/class/backlight/amdgpu_bl1/{brightness,actual_brightness}
12
252

Then, on exact this commit (63d0b87213a0ba241b3fcfba3fe7b0aed0cd1cc5), 
result is the same.

Then, on commit just before this one (aeaf3e6cf842):

 > cat /sys/class/backlight/amdgpu_bl1/{brightness,actual_brightness}
12
12

I hope I included all relevant information, more info can be found here:

https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/52



