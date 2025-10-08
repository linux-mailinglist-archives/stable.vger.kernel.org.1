Return-Path: <stable+bounces-183579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F25BC3565
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 06:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBEC64E94F2
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 04:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06D828A1D5;
	Wed,  8 Oct 2025 04:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TnaffeSL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D8334BA3C
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 04:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898740; cv=none; b=PzeC9QD+SnLY7r63B9pdYiNWTXsYFQYK5vivwG3PBolDKpCaWrWUV6uJmM2kIpyz2v3Xh022qA+hhKFic/HcF9Si1S9uUom56BAXNK3GknMN/CneyI3Kl3uMYRZbUAkbEzjJfiNwTgkeaf5ExzBD5UQ/u7gzv3wbf9L6qHYciVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898740; c=relaxed/simple;
	bh=wE/kdATIEfdP1bT5DFvn1f+TOEuk6V4ywi7jxxibmN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hnCJgTQzxPqesgqyAN1TSWLO47s8ShWiT9WD6jRMc67IAN+BCx/AIovhzrfjx+N3IKBgi8oN/yd2WIK4w+abyU/x58rQG3mvk7thM0wpGqBxuehSnwltOpvjXkJycZhb3vTdNyg5C1rDcYOtP4Z4y0L0grlpeI1MyiEAtqpPsTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TnaffeSL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78115430134so4313531b3a.1
        for <stable@vger.kernel.org>; Tue, 07 Oct 2025 21:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759898738; x=1760503538; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kr1L00wvOVr25j3yOIqLleOM/mW0MLWBZeaiqgZ8Wk=;
        b=TnaffeSL0lm+9MMBv4ErPvZ8StuIMT0Kbv/+8PCrPX64MBPjAOJntXUkKQg86sBT2F
         q3GAfUxTqQGpxR0Ii1CZtUAKqEdAnqC5ebIxUZDPouq9rEQQOdpmUPogXU7qLET+bsYP
         J/a4wYfIh7zY15imAJN8V0FLvsV6b72G1odjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759898738; x=1760503538;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kr1L00wvOVr25j3yOIqLleOM/mW0MLWBZeaiqgZ8Wk=;
        b=p4KhmWQKqWmTf/+v2oDclr84AlgyspFMlsloEzavcK3H/aerUdwI5tj9zTX4lmZSt4
         fmiILVIs+zS+OEFm0QzpwdjDrTvx15eX9GnE9LuZCg7281yKUxs/OBf3Q0z6H7Ktsley
         g94bqACZ46Gpya0sAcKzrw05jsxQXXthD7rL0O1D6KcgsT64rZHKrlNiQeEkpdX43om3
         UtqhN3FI8GAiTmibojmyVlvVVwae/qP9bZhVozfECJ44L4eeU20Kq6JxAurXGdZWhrdL
         DLqu4/Xy4mAmiwo9Be70AcXLxqbyW4lHT5Hs3kg7VypCQiB8gTYQcqhZv/PhgzmRGAYF
         UqtA==
X-Forwarded-Encrypted: i=1; AJvYcCWj4xHTb0HV4ysn6nqBL2q4+o2J/ExOWqeAbMjFSqC/hjVvOw+vtqWGICD5Y9rn+PlpItpPrWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOgHRUEN/IoyFvdbrO53SJcyiIRnhxsfDy51zMNtwyzq0Dy7tQ
	1r59F0zPvDXV5ulrSgj2E3gXsYwaAOKF8IVQ1psH79no6hF5zHH+7QFlxe9NtRCYVw==
X-Gm-Gg: ASbGncv0c0cJh+LQI+aN2W/UBAz47rfo0oMmiEF6QrJdITInP4iTWiF0uRAlF7UUhBM
	3R44bKx+VmAmimtn4QVxMEvV+fLz9vj3f5T0Y4A6c8fAyfitT2tHhMUNfod2kuUjZL2DhAihzWd
	U6/0sI5sgvVU4/O6jQqgwbcMkJ6/7QVTrOVN73NLz5mc8U/s/pDkQzYKOYga6Z414bcSnJtWO9S
	e2R4BsIOoAZlkl1EKPfvy3qBwWltG9iYJ/Ktg71Pgc2ZofuulB1uOes+SFJFvl9YIltrVyvauWH
	g3KFBMXnVjnoDZTHBQYrUN0wRmi/a8S/9fbTtA3FU4HpADZKTszwxn12jLBd/dpJS3ptx4/onJF
	39N6rTnDfEIXvx4mWRuL3EPx+tAT0KHnEebWPETPpGwti7vuiiQ==
X-Google-Smtp-Source: AGHT+IFLUr0j2WR9Nd0qMRsWsIHFOH6znggjE7lmgxCqD3Uq946in/DRyGXhdUAnZKPPI7qOtPJMtQ==
X-Received: by 2002:a05:6a00:2388:b0:772:3aa4:226e with SMTP id d2e1a72fcca58-79387242fa9mr2116159b3a.19.1759898738380;
        Tue, 07 Oct 2025 21:45:38 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:465a:c20b:6935:23d8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02053b77sm17347590b3a.43.2025.10.07.21.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:45:37 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:45:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Tomasz Figa <tfiga@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: kvm: arm64: stable commit "Fix kernel BUG() due to bad backport of
 FPSIMD/SVE/SME fix" deadlocks host kernel
Message-ID: <hjc7jwarhmwrvcswa7nax26vgvs2wl7256pf3ba3onoaj26s5x@qubtqvi3vy6u>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commits 8f4dc4e54eed4 (6.1.y) and 23249dade24e6 (5.15.y) (maybe other
stable kernels as well) deadlock the host kernel (presumably a
recursive spinlock):

 queued_spin_lock_slowpath+0x274/0x358
 raw_spin_rq_lock_nested+0x2c/0x48
 _raw_spin_rq_lock_irqsave+0x30/0x4c
 run_rebalance_domains+0x808/0x2e18
 __do_softirq+0x104/0x550
 irq_exit+0x88/0xe0
 handle_domain_irq+0x7c/0xb0
 gic_handle_irq+0x1cc/0x420
 call_on_irq_stack+0x20/0x48
 do_interrupt_handler+0x3c/0x50
 el1_interrupt+0x30/0x58
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x7c/0x80
 kvm_arch_vcpu_ioctl_run+0x24c/0x49c
 kvm_vcpu_ioctl+0xc4/0x614

We found out a similar report at [1], but it doesn't seem like a formal
patch was ever posted.  Will, can you please send a formal patch so that
stable kernels can run VMs again?

[1] https://lists.linaro.org/archives/list/linux-stable-mirror@lists.linaro.org/thread/3FQHC4GVN57SM2CNST3EMVEBUXMSFOGR/#AQB4LMHLGTUO73GVCVV5QLCEJT3MRTN4

