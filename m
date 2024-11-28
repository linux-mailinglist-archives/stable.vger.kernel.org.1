Return-Path: <stable+bounces-95700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C6B9DB660
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 12:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D87B21AC8
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 11:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C94194A7C;
	Thu, 28 Nov 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DuA7I5Nc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71F84E1C
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792733; cv=none; b=i3oX0JFCiNcQ+Oj4kRW6It8zqnYN5ttzqqZc+Rm7gTxYKJxEIr7kjFVFPQezrbZXu3IPnatAWlVath7RTEEjKLQzcXLw0Ny1rF9x0ogo0tFlE8JxxpbvPEJZgtV9cewF8rNrv5AX/lqBoga5ZJeyGvLe0rCKJfHRb2BQS/Ze7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792733; c=relaxed/simple;
	bh=1Dr/9wK0GiPUXbwSM3pXd7ht9BNkBZhC+a1phGPu4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TbApRXgKLy/jp5K6FT9Yy1VuESp3/jPP6SDznH1H9UDReGaeTO1Ffb882pE+QsPql9MKx16GUbxAUTQtmvHdNFg8ZTfm0rKRne96ZdOgjXGYh+MytTZpCvqPKqYvWUb4tTmRiYp2UrZKwbM/s49mf3soZrHx2JyR3PriORrMOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DuA7I5Nc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ea8d322297so570503a91.1
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 03:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732792731; x=1733397531; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7g0EDzT90oSJRMdudNKevE+2bYFLsEd5Pd/+GTWI7E4=;
        b=DuA7I5Nc/yBWzCzpYtAGYexy6CLXEgr0dTpwIAWbZTU73W4Q63fju9fXqqVRZZj29s
         d3XJ972aZ9SLNRoq/EHZtdvrjZ0MDN41ydzxahJDvZSdrEJryUhagnLaWzx1/O9pWTWR
         unifArbhbMMpQZ2WZH1/ob09VE4jbF3hqGDxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732792731; x=1733397531;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g0EDzT90oSJRMdudNKevE+2bYFLsEd5Pd/+GTWI7E4=;
        b=VJBhp95XJf4QCcE7vyl4YNqTNF9vvj3Tycjy/Y2bB3WzrD2PPDm6gS7ZjuY1+SqB/x
         P125owzh50ogow/U7VREdYiS3Se/lwm42PXfcEi0nZ7Z9KgcOFx9J+vu+FH6cz/QZ43w
         9zxxGMBEv47sxezFsgEMbqiyjUaINjXET6F9W5ULmQN7eRgu4ah5Lz4V5cNqC6WBjxp3
         5LEjz4dJfMHQ0yfEbL/HA9swoVsA2DIr/foIQQvjkpqSm9Ay6xYTzab6Fiy697P6bZ3+
         tUBplIO4Ox41rgYT0pAw3rIOY6O5oIMCzyn00k4NkW67KpVBB6O7O25vhfzXkns5sxSz
         WqLA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Ga70YnkZvuYBpsAAaBWjY0SK488Z7W5ptkegkna+1LEa7aCO50AdbMjwqPBu4BvinidaPuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnanNB/IGxAmE/vJgZaCIxbWj5F6K4YSkVu6dM53Zs64FGROO
	X+oeTYx2DQhRXHKiJ/hO10NbV4PjCU9c1hWsCt3gjEsVRcaKs9o4VifuQWl+dw==
X-Gm-Gg: ASbGncuyNeJp67VpY50QtIEjNv3Q9QB4paP7axRsZS6g3UbJ4NzOK65QKVOapxFq2p4
	1QUCgVw4mDOjZkzHI5X4HOMPSshf/jj8FHn7Q5ygognpkHa+bP3v2lIt1Jal+lfQ9b0eD4A7UbM
	9tRKEK894lP86NnK9x5bGeOlH0n64YF7JA4KkKEAYwUujGrHoji+vJqv2HHZhjJURrqnG2uAItA
	GWnu2Sc2Jq4LAVgwHN6x5ZiNtmHLSNVrE03qOGgAaxUGUXDS/Ki6g==
X-Google-Smtp-Source: AGHT+IEUKIyiy9WVkqcupbZQIOcf/4lQH7Ewcmkw42yxvQRWkwZbjCYyNcNqjlql/El2bpIiD4PCIA==
X-Received: by 2002:a17:90b:4b88:b0:2ea:95ac:54d1 with SMTP id 98e67ed59e1d1-2ee08ec82c8mr8162430a91.19.1732792730979;
        Thu, 28 Nov 2024 03:18:50 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e87e:5233:193f:13e1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa30fcesm3222262a91.8.2024.11.28.03.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 03:18:50 -0800 (PST)
Date: Thu, 28 Nov 2024 20:18:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Zhang Rui <rui.zhang@intel.com>
Cc: hpa@zytor.com, peterz@infradead.org, thorsten.blum@toblux.com,
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com,
	rafael.j.wysocki@intel.com, x86@kernel.org,
	linux-pm@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: bisected: [PATCH V4] x86/apic: Always explicitly disarm TSC-deadline
 timer
Message-ID: <20241128111844.GE10431@google.com>
Reply-To: 20241015061522.25288-1-rui.zhang@intel.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,
sorry if messed something up, this email has never been in my inbox.

> Disable the TSC Deadline timer in lapic_timer_shutdown() by writing to
> MSR_IA32_TSC_DEADLINE when in TSC-deadline mode. Also avoid writing
> to the initial-count register (APIC_TMICT) which is ignored in
> TSC-deadline mode.

So this commit hit stable and we now see section mismatch errors:

// stripped

WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
The relocation at __ex_table+0x447c references
section ".irqentry.text" which is not in the list of
authorized sections.

WARNING: vmlinux.o(__ex_table+0x4480): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .irqentry.text:(unknown)
The relocation at __ex_table+0x4480 references
section ".irqentry.text" which is not in the list of
authorized sections.

FATAL: modpost: Section mismatches detected.


Specifically because of wrmsrl.

I'm aware of the section mismatch errors on linux-5.4 (I know), not
aware of any other stable versions (but I haven't checked).  Is this
something specific to linux-5.4?

