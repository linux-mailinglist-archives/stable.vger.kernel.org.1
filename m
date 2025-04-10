Return-Path: <stable+bounces-132121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84540A8462E
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 16:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A710A7A7047
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0190728A41F;
	Thu, 10 Apr 2025 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBZQN0EC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601BA281529;
	Thu, 10 Apr 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294992; cv=none; b=YjpDBFln5Iwy0c9cxknEFRYVlp30unNCyXkkYyBgAD4BHsNRp0rf0E7tm8zB+x0LwWSShmnKYQBnA8WHOPUklXp2WSqUl4OR+1ZKGAOwdPErn51+cmTMr5dhvikVq57Nig55ph9/pnkXYEkneeu7kKGWXwwAZ5zmw0A19sVnWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294992; c=relaxed/simple;
	bh=Cwh6grY8wxhGhDJNXlFA0QmEG6C//znuti9h9BtRBOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXFf4d85YJfxBFwgPBKagU293w5jKG4i8JypB+rhyorcphUFjs8estghMjQETo0vDU3URw5SyKfeOEESddgO4QQt0VD8B5dxRR4nl/hDkArjKZVsSgKhbSjxiE0AkBOhs5NScrdq+YBhmIfxG1zKwmfBudRdfrP2Iom5yFEWjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBZQN0EC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7396f13b750so802096b3a.1;
        Thu, 10 Apr 2025 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744294990; x=1744899790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1KzVOT+eZwRVkPvH/8cwKh4uQYPRiQGRGZVOEfjMOc=;
        b=UBZQN0ECSg7/bra/zC8SloCdnRNkOFcmeCVtd2Fw2OJs00PlueO2YN+BT59yycmHwf
         pA5hH/lfXXcmT0rtsPQq6+i+SPbG29amoTFFUEGA7+X9WVZYPVjrqbQO2tG+2KJadlSE
         ZsoEvnKKGXn066hn75SnX9oyKaopXrleXkHKM/1YQ5UIPw+S7FiOT4ag+6DF3u6ST0vO
         XGyK/QHPX6kprCp7N0i5wFnIicNoLOkjLXYDA8QZVV4OuBpd+XnTKv9vkfI0fl75C96m
         rddP9JUtoqeblei2bTj24zW8p+64xXW88srI9xIAfASHv4PLqS8OcvtZHULGpz41u8ZX
         eOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744294990; x=1744899790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1KzVOT+eZwRVkPvH/8cwKh4uQYPRiQGRGZVOEfjMOc=;
        b=Lg0qmAAKWX/q3EnTtZq9Kp1ztl2O185zLYkCKNzuWgl8TM/VinEeNxnIwosPILFGQc
         Svb1yBOqZMS4sG3jKPwA9pRPqgr1ETzrNr9KpAZGkO1DzhZPyI9bO+yMkG4YVWVyvrL/
         SKP5bPmuB32G3R6VHwu2vYb2l+H+EP0FqrcI1QrpmDWu2I833yEl8YY0Hq1eDrD9yxGN
         0J0Ez2doeSodAgElsPHNJUGflg7VkXk420SHJGCjIA2QQZBOo005ptE9b99lBRAQIw2T
         KZtF2jyQLyF7Ds7UAdM1g5rD+iB9ld8YfdGfw7/EW2ANFUolYu4Reb0U9UpfYJRkdfW8
         ddYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWSN9ZDvLjfuQz2TP6iKDntOhOHR/zhHHCHHzBwAC8V20d7iJinAvBOZ873UW1+/lx+TMDfe01@vger.kernel.org, AJvYcCWsPaBHgA3G776/YhSG0tCWYRFDAgFSWUKkXZlgWLx8odMTGhyvxkpTWvxsIwFhStvape9uN6L3wcuyCol+@vger.kernel.org, AJvYcCWw2j2cJytXgRd0BXmKsRsKfu8QZAI+MtDSfmMS7kRcMzyTJU8x2I6bSQ/ddoSgImFVEwJyDcyz70VXHs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqFOj9m9D7A+hQ++rNr4OfM/O1ZpsFTurCLpEKIaIIbyQvvXYF
	ByRUFghLwW9PPK6O/fr7OKBSK6Qr2LFABztTaxZKLTZLhQ7yyq24
X-Gm-Gg: ASbGnctxOG/ri/H+hiOvyW7tOI2bUvb5aDjVyGow7BTPEnIomaPLZBN5jtEvRrYyBUc
	AxrdetVAxDMq4AAmAQkHL3pweV6LyPxUeELbT2RaC1+96GyfNAX/BH5Mcd6gLZPSU7BzRi5Qcqt
	V4CocyAoaqd4Ej1Q4YsmPebSzpxWom5eZVQHQBq1UW6b7fE0WIvD1mv/xgnGWSWxcbBf8i0hj6Q
	a3U3yAyTohl3AhFgMWF+UYinWRJp/O/vX+h/EM/Ig6tbJSsabys99x4EownXYR7Z10WJ4NLY0eg
	e5lapkBCvT2bJfqOiNIKPgggqPPnI+32OuwbGHKEWddxp2r1fOS70KoOGG2H8rDToRdg09Vtb/R
	tVQ1k6ZAxMbTY0a06ynnSeAmolgJW82iqZhySKg==
X-Google-Smtp-Source: AGHT+IHYvKz4BNpqFgjqtK4NeKugSkNVTSb75ZAm5QQA7B1M0d8K2TV39Qrya9RbCeBmRX2vLXlgMA==
X-Received: by 2002:a05:6a21:3298:b0:1f5:709d:e0cb with SMTP id adf61e73a8af0-20169603e52mr4577828637.39.1744294990477;
        Thu, 10 Apr 2025 07:23:10 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a331b481sm3042268a12.75.2025.04.10.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 07:23:10 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: pmladek@suse.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	ryotkkr98@gmail.com,
	samuel.holland@sifive.com,
	stable@vger.kernel.org,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v2] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Thu, 10 Apr 2025 23:23:03 +0900
Message-Id: <20250410142303.5978-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z_erp2nLRKzLXuwF@pathway.suse.cz>
References: <Z_erp2nLRKzLXuwF@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 10 Apr 2025 13:29:43 +0200, Petr Mladek wrote:
>On Sat 2025-04-05 23:53:54, Ryo Takakura wrote:
>> startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
>> The register is also accessed from write() callback.
>> 
>> If console were printing and startup()/shutdown() callback
>> gets called, its access to the register could be overwritten.
>> 
>> Add port->lock to startup()/shutdown() callbacks to make sure
>> their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
>> write() callback.
>> 
>> Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>> Cc: stable@vger.kernel.org
>
>I do not have the hardware around so I could not test it.
>But the change make sense. It fixes a real race.
>And the code looks reasonable:
>
>Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks for reviewing this one as well!
I'll send v3 with your Reviewed-by.

Sincerely,
Ryo Takakura

>Best Regards,
>Petr

