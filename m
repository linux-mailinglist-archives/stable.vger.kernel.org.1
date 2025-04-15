Return-Path: <stable+bounces-132722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F57A89AE9
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 12:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C7A1792D7
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4B5293B4E;
	Tue, 15 Apr 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeQXc44p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F482951DF;
	Tue, 15 Apr 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713905; cv=none; b=Rj1I5RxHP8ust3wo/HGP/l1cg6y2mo1KIN44I5L/Bvt4DGq9mJdvJAUozxyGPAJvkBqzEgKqNZG50emtQMrZMF3lNZRoGlDKjMSoEKFer+BRZfk9QaJXjv9zxp2ge5Yi1zZCt8QNog87cKsv0fFlUQLjOKYoNHWXF9sbB6axtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713905; c=relaxed/simple;
	bh=SzAtTYxauZXqLEN7iyAxb1gJsZE7OLBERKWDjqBjIAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lmVXIR8KIon97byhYVxgiB/wmKtW/4cg0HshbZ8W1zwe+uwNzP45r45hrBIUOCO9EX5VeOHpzOES6L8NNJOldlOmTk1UjRuuB1vVeiG5TwrZVBul/iFyuOgiktvqg2kMYk3YNgszG0c3HA8o/6MHRzypNaxm/8LqIlvnjerdwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeQXc44p; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223fd89d036so64246445ad.1;
        Tue, 15 Apr 2025 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744713903; x=1745318703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzAtTYxauZXqLEN7iyAxb1gJsZE7OLBERKWDjqBjIAk=;
        b=WeQXc44pIUfo2xNiMXBXmjRijOgtT0blJXMY47LfbfeSMFb4yoBo9xPy0H8QXXEGkM
         0GiIp5Dtc+yUta4nPEOvE7RsI/psIoiLdVhOIQQBzxRhQ4msu0Df6vWKKJXyQEj+hvh3
         xtg3aZsm2wBLcb5qNuYGq5tat77RfI7fLQAz444I+wIftL/K4yGGSgGDRqVpx77rO57h
         h1qnrurZ8RSmFJ4EATbRWHP6XGmHv5ZNe2xe8abvvrqLQ5YtwBr/xAavSl1plbUj80wm
         zzaiU5N2EvyGVpX2ACyBu6xYfkAmHyCrAA/0GuBgqlrE0doDJYfVeb2VcGrjnF5oC3q3
         3vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744713903; x=1745318703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzAtTYxauZXqLEN7iyAxb1gJsZE7OLBERKWDjqBjIAk=;
        b=JieV7XV/8Tua/9m17nPqbiHqt+O+CD0ztuqaeUUMZenAZieVKeWyV/X+F04chxdBX6
         FwAzD2vgvHdZoFg3eGqCkkVFCfw56GDeykts8djh3zhiDCNLHfTQ4R2vnqR+my/nLXxw
         TGUffEnheL/C9b+rwwND0rdCS630nwmhNgZihl9N0/1eI9tnvHjjsSq+P7dXNjQZU7sb
         ymZGxV5fFv5RzSdyWyxwExS3fL0z026D11PshLjtzNyuTzPkeQB+Ulsah4BgXIWnAmua
         vnlMafoZUC/ZT69UkVFQ7nMoY0JNtjYVNerufxkb5K722NFUGKqgqQzjxLIooBP7qEXO
         mWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/+4sisKkz8WvuaGzOUhdmAYFx7/pC5VcqqvapbpKfEEljjaOrmzQB7B5Olmjv0HBaRRBxLSMkjPvHJhk=@vger.kernel.org, AJvYcCW4c2KFjrjhsCZFj1ED47Eg08/Zok+qovFMjzcl/9agsVWQFb/gOvLES5Lipwt3Qx1LtYHDaOdx@vger.kernel.org, AJvYcCWOSQCTlCpkcdCd5jET0ifEHPKHauiVRikuzm9j9KxGuvFUDEj+gx9pJiYEE2mV6ZHWqimfKsZHOvnfsJF2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3voo3uDq5C7hRe12R+6tm/HjEBXbn2rvWm1byVlQU6w2j3OT
	OQT5evmwKaYEONgZCSDjzN8PetNu51ro5lziP6TD+FTejNtt4weT
X-Gm-Gg: ASbGncv/tSYfUT0RA3i4XXQXyWVSyoUh/N70089PKVLk301xtDSK8O24SFK52S1/tfx
	gAQZGg1ZMwtEH+gJQokSviATlOKNMdAwpE5Fj6+KUK2cR3HVv/nPYvdqSZ0BOJseUWYREt2dYQn
	wc873Vv1rxlZxHWPqDfJDoBmEe1fZCZFuZ8zzaxGDxmZRbzUau0TlyxB7fsm/yIr8oBN4g6J6p4
	6Ne/MFu5jrp/5CjaGBinFJsnl139tY0WY60dL6192VR1UFDtaU4s9BRazrRJP+8ik6+GYKZR+T2
	pAtvOwlDU+8UWGa8C7gKJo8R+LcbzyVXE8XS+Kyr7kUGXi0pFrcPFp2CLsFYWjZIAZVK4ojHP4z
	g0GDa4KxfEAxiCuMRS5+tnD1faeMGWcao7lVcXA==
X-Google-Smtp-Source: AGHT+IGbuiseGe6dO8ZaeyUMP0vE98HRa1rGWFspkK+5ZgKdbKp7kpHE7FLGo9TmBf7+WV4dwGP3pw==
X-Received: by 2002:a17:903:144f:b0:220:f151:b668 with SMTP id d9443c01a7336-22bea4b3d11mr202305075ad.20.1744713903453;
        Tue, 15 Apr 2025 03:45:03 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e305sm8461509b3a.140.2025.04.15.03.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 03:45:03 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: john.ogness@linutronix.de
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	ryotkkr98@gmail.com,
	samuel.holland@sifive.com,
	stable@vger.kernel.org,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v3] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Tue, 15 Apr 2025 19:44:53 +0900
Message-Id: <20250415104453.3690-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <84r01tooq9.fsf@jogness.linutronix.de>
References: <84r01tooq9.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Apr 2025 09:48:06 +0206, John Ogness wrote:
>On 2025-04-12, Ryo Takakura <ryotkkr98@gmail.com> wrote:
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
>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
>Reviewed-by: John Ogness <john.ogness@linutronix.de>

I'll add for v4, Thank you John!

Sincerely,
Ryo Takakura

