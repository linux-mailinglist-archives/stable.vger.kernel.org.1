Return-Path: <stable+bounces-50279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7B19055A3
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4041F2189F
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32BC16F0DC;
	Wed, 12 Jun 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJ0BDfUa"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C392B17E8F6
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203630; cv=none; b=qzxXmINejjRAOc8+bxPjJS5R6wl7S80IgjsSzt0IiWT3653b010SHj6IFSGrBaUjzVKBylBwt5ZiVaFbb9bF2lf9mEQuGvqIuyQOgj0cAv3C1oZIR4L/nojkII+EEvnfGykI+zLEBJm5cFx3ctldgk02r/J4tArW3UIoVVrpNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203630; c=relaxed/simple;
	bh=hZKRqwSK4ScR5k4QtzwlO9xq6X2JOi2CqiRtVa8dMpQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gmhxtUcLXzfByvy3e+AaeaJlIrma71ghxszx7TmS2BnfRbE38kO+WwiAMFRZl0ljgQxRFA+LpC60x4uEUt4Sahztm80mT2iF08aFLvLQH8VGYcHvc7oHFfQIRS7od/6FS4ehdTJxxnSVdv3uphGMBLFLefbIR8WjsGR97ccMlTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kJ0BDfUa; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4eb24694941so1856168e0c.0
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718203627; x=1718808427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=++Zx8ONfAby/2OtMVElgCEc8JDEMc6Y8wL+JtS/yQjQ=;
        b=kJ0BDfUasOKSLFopZTDEoSRTr4JnuJfP2sycoRZEP66Qba6vT5j+bXWlwXtfh6Bywk
         L0sdHIS4FdEEc8ogwFMJn4baeJtQMVXZZTorAS960wQQPVqV5zGR09w08eSyIUnDVIqt
         DoU3gdl5TuQrU5g2jK9deIaEbhWot3TigivgXnREZTUGGzxhJp8cBInksI5CoOmw1QFX
         f0AfFyn00YZ7zbSCUac5agjLxB9FH9i/VyBSxr0b7wbaj9YsbP/lp+GXn6noQLBcWsfw
         eEzlzpnhnqiEy1eQY+CB4eIZq7Y9weVIV5Rrle9FK5gsxBHjpwVPN3NL7sJnHVuOBqai
         O/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718203627; x=1718808427;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++Zx8ONfAby/2OtMVElgCEc8JDEMc6Y8wL+JtS/yQjQ=;
        b=qTiaFhrrPrhyBEy2932ypW7aBmXmWPWTyNwAAPsZy0MVra/sfM0uO1BWEb+Bj35ipI
         55pKouXf5f/b4Yb0jiQeirsYQF5ShxrDNhXRMWpLAn1NqlG160rEmR5b9aRPgBp2tbBz
         cGzDUa/HJaBeIHCvzST9LqjU0xVrM7ULhtsI0MY+NJBrnyP5iA0YHRoLKDs9xFSOVcJn
         tzQR80l6m1VEhX6rWzZ8nXDQqtDEPDZE9TdMg6hBAit8aJm1QAe8qRU1zgEyaltXuGtG
         K46/59BXDZsL4sugF/qAdw2XcLZYb5jgHrQ2aBlsEEhZfpXT5cU2pX3jW5Do0jk+fcsv
         UpDg==
X-Gm-Message-State: AOJu0YxAHnADzHRYlNRQAkOh+9Bvx5kOF3wj9bl19Q8t8erIjcdvEOKR
	5GmRLcoUQHL0CZARXcHbU6AJCQTtJAmT1m4N4xaWrBnbnEUGtKXxUwrs5UQVXUq7bUSlRQBMjmx
	rOLZ8tfRQiACuQyzyayiM9urqy2l2nTYKBJvcbqd1r/UZBPQgpmY=
X-Google-Smtp-Source: AGHT+IE5P3IQInC9wWtv70wSp8po3FWb69qqf+bxQ75emaTzlLqrY0LRHyhuBJIuANHnPI7mv7v1ThkTM9vYm3WEo4w=
X-Received: by 2002:a05:6122:2310:b0:4df:261c:fc0c with SMTP id
 71dfb90a1353d-4ed07c12bbcmr1905731e0c.13.1718203627121; Wed, 12 Jun 2024
 07:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Jun 2024 20:16:55 +0530
Message-ID: <CA+G9fYs7qh=9h5X1hp=7v3zcW9DovJ726x0Bf=8K4_QAOk=2EQ@mail.gmail.com>
Subject: stable-rc: queue_5.10: arch/powerpc/include/asm/uaccess.h:472:4:
 error: implicit declaration of function '__get_user_size' [-Werror,-Wimplicit-function-declaration]
To: linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The Powerpc tinyconfig builds started failing on stable-rc queues for
queue_5.10 branch from June 5, 2024.

Please find the build log and related links below.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

powerpc:

  * build/clang-18-tinyconfig
  * build/clang-nightly-tinyconfig
  * build/gcc-12-tinyconfig


Build error:
--------
arch/powerpc/include/asm/uaccess.h:472:4: error: implicit declaration
of function '__get_user_size'
[-Werror,-Wimplicit-function-declaration]
  472 |                         __get_user_size(*(u8 *)to, from, 1, ret);
      |

metadata:
--------
  git_describe: v5.10.218-265-g807add29e709
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc-queues
  git_short_log: 807add29e709 ("SUNRPC: Fix loop termination condition
in gss_free_in_token_pages()")

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.10/build/v5.10.218-265-g807add29e709/testrun/24294414/suite/build/test/clang-18-tinyconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.10/build/v5.10.218-265-g807add29e709/testrun/24294414/suite/build/test/clang-18-tinyconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_5.10/build/v5.10.218-265-g807add29e709/testrun/24294414/suite/build/test/gcc-12-tinyconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

