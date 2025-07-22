Return-Path: <stable+bounces-164270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C22B0E11E
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 18:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B57AAC1EE8
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3115E27A47F;
	Tue, 22 Jul 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="paXIAdS4"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19B27A10F
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200014; cv=none; b=tllke9V4eNGD7sXvKqfXn1JQrfNVSDknzoI0+xVY/Fy2tVjvQt3/Hv4jMcETUeTdXVUxA9ZRobt4b9FNj1LkccHoyGJtOEnvtLCk/xDOdnRK/6Iu73UUFomn+znXVudK1PU600PdWH+faIM2gWA7+nwNpb3i9qucKrGPFuCgPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200014; c=relaxed/simple;
	bh=WsBdtMBoj90iQrQ03XPwqb6NRyogIO1bWG+l+t48EYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwyyF5sLmH1Crk0GFBi3n+gt7Zp4wweVBntqksfkzUHbbskhlC1UdiL34WN+xtczTiuGOmei4wFSdRJ5CK72zZdp2WTVF3cEhasGO3WA+GLKP29PghBu1suEkbFovkk09z6+IrfsVMiFH75SOIM/NRkwBAV0XE1NwArfCKvb6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=paXIAdS4; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e2c44be5abso4859445ab.0
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753200009; x=1753804809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMWmh8ZJz4RNGTpOucEqzMgM2GUTJ0q3JCmyXuVkkBU=;
        b=paXIAdS4yEQEeoOz+1Qx4mXFmRogL/wgNcERpdDBj4Y9LuHBMAZvKmHVA9GzcMK3AZ
         EM9ArHIxTg6JirsClaQnyhgwrnywRr6VXQrRxwrrIZL1tCU1y1pXd6ob1F5UmC/q3xC6
         wTlHXYpV9pPMwHx2rc0JTFDodekXPEo1nFM1y7dC7xrVjOLDf+EFAsOJUm/OI6jHNuFc
         fa8EyTbTyCPdbhoIgou7vyXf21DsK0JqjeJHKBnkLXhxvYY5B/v/MmJbu4NWK0JYErf4
         X9/UNo8NKCGvC5+doafJ18S21slnblOCEQWTt2QsU5Miz4JjpXiPW5qFo5x/UCuRVHcb
         7HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200009; x=1753804809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMWmh8ZJz4RNGTpOucEqzMgM2GUTJ0q3JCmyXuVkkBU=;
        b=JWOJlR4a6Dmh5AVLKKyCwcwvwrqbn0g5rjN+aIZbNqZYTtzhQoDOAIeLadeexeYqj4
         O8K5xgU/7uXy1jOy0MOQznfLvKa1WHRfWZo5910BkUTqwHqhBx8vkVfgMywOUlV5tE3o
         2UPTExx3BpUig5IiLUq0RJkmuHC4mFufE7kBZeFREDh7NkuWnu/EqIwYmMkpe57Pfcrr
         zAzcn65LR9RA/HNXSxIIcmw38FlbTXeKusNIPa/HzCu4uWSq79OXzMYxMW2IoXg0Ga4V
         qZOwY9hds6PfHUBl0BA5Tsoo62nc+e5My6DPi3fJ2vAHUG/uKMADZtJRTL4OHh4avhw6
         FlJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhUy9lqjxK8YVR8RQ/KBaL83JlupqqKiVIlaC1Ro/Lmg2E8gYSiaMSVs/Emfd+nlq7sIqD5rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTD1EVXoGZRR2UqnSs892Nfd8k9yhxsq+Y+0ZeCvoDq8RsGevw
	3OZl0m9rtqVWlX6TID+Lmpkz7GiXARIbT9dt0bOMMdJMegC5w8X1X1NtIKEpPfpNadE=
X-Gm-Gg: ASbGncvilPjCFmSHwAn2EwnC9Ewl9KWnntTJGlBlBcoomWOhtS2VBfOPYJOzJ88GPDZ
	3FEk08JlY6676TdAZwOHcLv9hCw42CAB+Da8KVcIOBzKa6Xbwr769J0rdkvx5N6XIQdJw5DCFcG
	tq5G/wprK8plFu6bPgBHioLnXHRQB1G4E64C0BTlSwpnJ1kXUEZ2hZdIwd0g1sAZVdMkMm4nYJO
	O2ClBe5oZBVtNnyThIDTRYPTGsvoqn9FyFN9iFy1s0tXiZ6gkzPEzV94/ebbjNAqUYkzr1ZXJq3
	V8Nssx3coyTt+fT60uRaVJU7pcbKFVmQL/TwW+UaffjA+PVuC35lieuFuN55XsgnXXOsMBiNjAZ
	RfBJDMoLid1JBiludkg==
X-Google-Smtp-Source: AGHT+IG1W0AUZPbeKYtFg/1aC8vr5dH/lfI/B/kWb/+3OVUMQfy9fizHB+LNH9J+P2Mnz+t7jVQSdA==
X-Received: by 2002:a05:6e02:1a89:b0:3e2:c215:138a with SMTP id e9e14a558f8ab-3e2c2151564mr46618355ab.12.1753200008339;
        Tue, 22 Jul 2025 09:00:08 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c8042f4sm2578678173.57.2025.07.22.09.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:00:07 -0700 (PDT)
Message-ID: <ef2ee915-a74f-4fe8-80f7-dc940827b302@kernel.dk>
Date: Tue, 22 Jul 2025 10:00:07 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: fix race between polling and detaching
To: Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 H Hartley Sweeten <hsweeten@visionengravers.com>, stable@vger.kernel.org,
 syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
References: <20250722155316.27432-1-abbotti@mev.co.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250722155316.27432-1-abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 9:53 AM, Ian Abbott wrote:
> syzbot reports a use-after-free in comedi in the below link, which is
> due to comedi gladly removing the allocated async area even though poll
> requests are still active on the wait_queue_head inside of it. This can
> cause a use-after-free when the poll entries are later triggered or
> removed, as the memory for the wait_queue_head has been freed.  We need
> to check there are no tasks queued on any of the subdevices' wait queues
> before allowing the device to be detached by the `COMEDI_DEVCONFIG`
> ioctl.
> 
> Tasks will read-lock `dev->attach_lock` before adding themselves to the
> subdevice wait queue, so fix the problem in the `COMEDI_DEVCONFIG` ioctl
> handler by write-locking `dev->attach_lock` before checking that all of
> the subdevices are safe to be deleted.  This includes testing for any
> sleepers on the subdevices' wait queues.  It remains locked until the
> device has been detached.  This requires the `comedi_device_detach()`
> function to be refactored slightly, moving the bulk of it into new
> function `comedi_device_detach_locked()`.
> 
> Note that the refactor of `comedi_device_detach()` results in
> `comedi_device_cancel_all()` now being called while `dev->attach_lock`
> is write-locked, which wasn't the case previously, but that does not
> matter.
> 
> Thanks to Jens Axboe for diagnosing the problem and co-developing this
> patch.

Thanks for taking care of this!

Tested-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


