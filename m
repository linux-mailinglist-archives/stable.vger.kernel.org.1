Return-Path: <stable+bounces-145681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41209ABDEC5
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 17:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447761BA6F04
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6399255E34;
	Tue, 20 May 2025 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QnFWicWR"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE36A18DB29
	for <stable@vger.kernel.org>; Tue, 20 May 2025 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754540; cv=none; b=MuUD9KfjkJ4AUV85QbSJjNjgBrnT8OG1tK7Kwo62Njnw75dp6W72SzQkUopkzIXxM5ZFobiFvQlxDYIPbIYFwIT8GCG2jAkEMiwz3WH2n3dqBi69nrOkrPje9g8BiD9kc3f8j2JLBLBTjzS1PcpeHuvCyHEp2pxMygmG8dJNbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754540; c=relaxed/simple;
	bh=drUTSEyk+wweBp8MzrvZkkg+cv1majfZDXRkJhg6S4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ynlth4EI2udCiXwgbny4hhc6EL66Vv+7mOi3AtVyvItQxly7MGOn49fK09VYWoDWl4OLnZTRfJ6O8Z8cANKQv0/gyVBqxw2C7jMfGceeiroaXcdUCFgbTJQz1VDETW1c3dMuQHuE9v2xOSyz4fQvRsoQah1okN2efNXZMlCbv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QnFWicWR; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86a464849c2so74294339f.1
        for <stable@vger.kernel.org>; Tue, 20 May 2025 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747754538; x=1748359338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28A77Cb9dd2oxcpPba2mZ0UcBg1frToBP1w7OoG6wpU=;
        b=QnFWicWRib2HDDlZmmy/CF8zTCOmFCvERg9HbSFwLtLS1+u3YwbWvW3pn/NpW8aMOJ
         WCfbiV1ufMgx4IORH5YzzZTUoF0MDnlmUI7vTL0YmaM5KdCVAsE3uiPztV8+s04h+Lny
         fjZIap2cJHqudFD2ybcqXe39mg4abHksSq7ZY7HArNpCq7P4HscSqa9JWcx79nBgagsl
         Q9z90oxUnX4zuELiYeQ3lZV+a/9RhbrH+DJ8qSeXFpLjmpBbHBR7i50x60ntzppapB3N
         HCbTdqJujP4U478HjBroA8gnjF0CAnLyAQf+3tRgwa018Dw8NJL3LQiAv5GpTuNadxWK
         A2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754538; x=1748359338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28A77Cb9dd2oxcpPba2mZ0UcBg1frToBP1w7OoG6wpU=;
        b=qyKqfgb38YZZ36GhsESXQSZjCiqOqQosiNdPZVGZmHh2EWpusE1pVjFCveZ/xFx0XT
         Q+MJ3nMH6TrM4cmMldcxxNf3wUB7ht+UIEPCq3cNslfrjpDYV3VYyDO3YYeR7vNKe63u
         GXvdSUPfvQOvL8bppb1IBzlKykfF3qQTOV8a3JpRMl0qVGCgWM6k4eWarEDJdcscrb4T
         uh1Ngi0ha+N2M3aA5nZbZ6Nblu6hw+pgmBy2Lx8KnhIqu6y3JTUdu4TNZcyxvcyJe4CJ
         nt0pZOxO4Ws/ZB5oYfhK/SeGSrtCp9yc1iizkCyyvZHqO8ZkuOan3dRRa7tiHmUrnR0y
         U0nQ==
X-Gm-Message-State: AOJu0YxD9jJ1+qCAtCxbSG7SmiIUL3UxBG9LUu+/rpvzb33nszeO4Xdv
	0U19xrfMWSgb/J20I94bMeWmFXvLMz6vhepzQRDRALjU/DnF4FfIMm9fEnncD8l/Tyo=
X-Gm-Gg: ASbGncuaCzaHOcynbGVgEBkOWOoxzuYXrgCo8r1QwO0mXqw8nkM5jTrl/CZsz4Jth6M
	guT9aMyBvdq+zJfrEeP1ZVw5NsCB1keCPXIkgcHCjinFzadjDBJdhAZGYjjQxShP1XAS77iI4lK
	Z+LB6c2Sw4yRc1c11x++M5I9kU2sgnWL1/+9/o44XpMdCRr2L6qpOz/DdkDb1Wt51fK5KkYAWPW
	mJLTvKxnONZDan7bMXrvDE962oi0o5HJt/4WDrj9EaHH1JjInP2Ly0G2WYq0JG3xXuCZpR/4Zyl
	VX/rl6q82iXy2WJK3O7EAclAZWiM4abY8kvTo726Tfx38jVxFK1r8MtfbA==
X-Google-Smtp-Source: AGHT+IHybOxTZR7F/QJc0USNLXLQ5L6fwe2BKiXGfcHIJgPUA62KTSuwtc5Hgl89SiSjuXmhZG6uFw==
X-Received: by 2002:a6b:750d:0:b0:86a:441:25ca with SMTP id ca18e2360f4ac-86a175262a9mr2041757139f.6.1747754537676;
        Tue, 20 May 2025 08:22:17 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a5b2sm2282150173.9.2025.05.20.08.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:22:17 -0700 (PDT)
Message-ID: <e05dbb79-9769-4825-aa33-1ed82e9bff69@kernel.dk>
Date: Tue, 20 May 2025 09:22:16 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 162/197] loop: Add sanity check for read/write_iter
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Justin Forbes <jmforbes@linuxtx.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com,
 Lizhi Xu <lizhi.xu@windriver.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>
References: <20250512172044.326436266@linuxfoundation.org>
 <20250512172050.980575013@linuxfoundation.org>
 <CAFxkdAq+5ur__TPi6ZW9uoOBv037hgn1d_9906cBeXWE=X3Sgw@mail.gmail.com>
 <2025052059-unsteady-octagon-9321@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025052059-unsteady-octagon-9321@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/19/25 10:56 PM, Greg Kroah-Hartman wrote:
> On Mon, May 19, 2025 at 06:19:26PM -0600, Justin Forbes wrote:
>> On Mon, May 12, 2025 at 11:51 AM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> 6.14-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> ------------------
>>>
>>> From: Lizhi Xu <lizhi.xu@windriver.com>
>>>
>>> [ Upstream commit f5c84eff634ba003326aa034c414e2a9dcb7c6a7 ]
>>>
>>> Some file systems do not support read_iter/write_iter, such as selinuxfs
>>> in this issue.
>>> So before calling them, first confirm that the interface is supported and
>>> then call it.
>>>
>>> It is releavant in that vfs_iter_read/write have the check, and removal
>>> of their used caused szybot to be able to hit this issue.
>>>
>>> Fixes: f2fed441c69b ("loop: stop using vfs_iter__{read,write} for buffered I/O")
>>> Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=6af973a3b8dfd2faefdc
>>> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>> Link: https://lore.kernel.org/r/20250428143626.3318717-1-lizhi.xu@windriver.com
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>> ---
>>>  drivers/block/loop.c | 23 +++++++++++++++++++++++
>>>  1 file changed, 23 insertions(+)
>>
>> We have had an issue failing to set up loop devices with CI and Linus'
>> tree since rc6, and once this patch hit stable it proved to be the
>> culprit.  If I revert this patch, things work as they should. The
>> problem we are seeing is "
>>
>> More information can be found in:
>> https://github.com/coreos/fedora-coreos-tracker/issues/1948
>> and
>> https://openqa.fedoraproject.org/tests/3438220#step/_boot_to_anaconda/5
> 
> Sorry to hear that, please work with the developers to get this resolved
> in Linus's tree and then we will be glad to apply the needed fix from
> there.

Should be sorted and land before 6.15:

https://git.kernel.dk/cgit/linux/commit/?h=block-6.15&id=355341e4359b2d5edf0ed5e117f7e9e7a0a5dac0

-- 
Jens Axboe


