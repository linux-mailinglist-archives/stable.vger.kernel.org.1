Return-Path: <stable+bounces-116804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C56FA3A1FE
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 17:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DEE3A41C4
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C289F243376;
	Tue, 18 Feb 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgJYm3Ym"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A817A5BE
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894504; cv=none; b=FBsi33/2CoFZUKMnJKpR7AGIgGE3idNvdlq4tomgAnq59mEW3F55dtpRkBdHwWNYTM3ZxgYN6zKlbVqQa1ZRa7t7EP1+cHygrMq0wMku0C5O62naYSI6FstPOTQwwJTo3wKKj1C8+BedsqkKmnPw6FhdLbt7TfrzVMtGxW4Vnz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894504; c=relaxed/simple;
	bh=oCVv1bIDLK1VDNcQIKTCywwdQIO9OM3mn9CHt4SbKPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwI7ndfqRMTQS+r5R9WBjF1xPIAPzz0z6psbyH0Tecemn+5U0/Nuy7fg2dh/kQdh3wi0ywrFGPyFVlPXbP5bktvQJr1AB4OKGg53m6AGmJZu81H9Tcgl4EkEAnCH2OlZy7izaZuogpFHbMiZ+PGO0l49Pqoez3ryPnV1Gzfdl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgJYm3Ym; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739894501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGLdSoyLAWE8Cjx6pSyApZY2a0Ne8XagCPC6aOvMXMg=;
	b=LgJYm3Ym/jHN06/jISqyZwjxhM6x4v+wWLIA/MreeTbYxc/fxF+QTm5hKH4rFKaZHsnu3z
	VQAT0tHvPRdm2kCYoYSoOBWSo+hnjDflLbTkJXA4EuRLLa197ZmfnacHFzPvb1U9ksXcZ4
	vDD9h0apesSXpij//mKGzsUHcXR4hpY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-BJwg7LMaPsO2dnn-hiqYaA-1; Tue, 18 Feb 2025 11:01:39 -0500
X-MC-Unique: BJwg7LMaPsO2dnn-hiqYaA-1
X-Mimecast-MFC-AGG-ID: BJwg7LMaPsO2dnn-hiqYaA_1739894498
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-438e180821aso31244345e9.1
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 08:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894498; x=1740499298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGLdSoyLAWE8Cjx6pSyApZY2a0Ne8XagCPC6aOvMXMg=;
        b=wl5r3Kqosg0oajvQ4jQOs7ruaua48NAo8qxEFO53iTBj3OS7+apMToBfzsQflQUIzj
         rw3IEvjcoe7sQTrovqEb6WtvoygpB99WJQTJyRbg+Wryujw7ZIJEohd2MpzOWGCCTEWJ
         n++IG3nEtdcV52k3ljrvE2i5lBDN+gSLbeQ4MP3PSFG2l06OirFN+8rkJZmk5YwuHsk+
         d7G4EmkJayC2W550OBH7ay4oWt4o926jCbLf1nhNxTM3OzAhCX2s+4v9cvqoGiRKm96i
         lTFSbx/+KKQLZ/g5m0j5YehXAxzNa3sKxwidobe9AuDrx25R4345s50kIBqR4vd0RduI
         W7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWjJGtVbJHtVd3rWB/sEZjn0lU0gTTj3qh1lwVb5UC3j2Nrm5MjSWFYfVwMMMgbOGmWyMfiafs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIoTOK7IloHFiJ9KIYymU+TxfMfhv8sSd37SiCChnP0CJDvjP6
	cMbSMOpkVOeeEzyy0Ab8b+KCFPFTNhF5Ys7VWYYxJcGNmv3hTyuk2+uIV2FPhZCR4uXtxKr7UuF
	hCYI3DFc3JbQJS8kkIb3ZldQaZe+IW7RvO22ju+WZdYbpieFoLQ9m6g==
X-Gm-Gg: ASbGncuAJT38IbdMg0KIFWXU8nVXxw83IfrGTZ+WEj/jmm52Vkf6hgyk6O0TozHVx2K
	rmpB7r5GRJ5hXEJF9JX+ivC/h581a/tgpeI1ImwQC8aKF9TkK5GkYFgVYmOvgjthESNoU8wRDj9
	07T/ZEPLwTE4Y1nAnFuW0j+P4AsxV/8KEb6/qtuGI0BnpCq8RO7Ep0fe4ZozzH4/g1qwA7939/8
	cHKil4H17d8O2aoMy7UhEMeXGVepjkTZvD7Alyy9+TT9sUYAnX+1PDQyF2nuIEggcLmA8EhEn8F
	B3kOsfaas7pSeHsfDkPnCrGanI2tr9pXciKyGM6tB/e9ExrmmnDz3w==
X-Received: by 2002:a05:600c:4750:b0:439:9828:c425 with SMTP id 5b1f17b1804b1-4399828c633mr15497875e9.7.1739894497864;
        Tue, 18 Feb 2025 08:01:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1bR3ZvNKuqGUd+uzd0tQMuTD2XWrKyBbOEYQkEGLim6HWazF/iSib7juZXyqkT85bQxC/QA==
X-Received: by 2002:a05:600c:4750:b0:439:9828:c425 with SMTP id 5b1f17b1804b1-4399828c633mr15496465e9.7.1739894496875;
        Tue, 18 Feb 2025 08:01:36 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8602sm15771631f8f.94.2025.02.18.08.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:01:36 -0800 (PST)
Date: Tue, 18 Feb 2025 17:01:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Luigi Leonardi <leonardi@redhat.com>, stable@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] vsock: fix use-after free and null-ptr-deref
Message-ID: <ah4qm66q5q7we7ykhl3uywgrexi7izdxrmfyn2zm3jhswitebt@cz2ipkdgr6yf>
References: <20250214-linux-rolling-stable-v1-0-d39dc6251d2f@redhat.com>
 <f7lr3ftzo66sl6phlcygh4xx4spga4b6je37fhawjrsjtexzne@xhhwaqrjznlp>
 <cf0ef7bc-4da9-492a-bc43-0c3e83c48d02@rbox.co>
 <ez2wnwdos73pxbbxanbs5pe2nawvgablvjvrpqldcpbuwy7jz4@y6vnlty435un>
 <a6c77d41-4203-4aa7-8d4c-ed513bb6929d@rbox.co>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a6c77d41-4203-4aa7-8d4c-ed513bb6929d@rbox.co>

On Tue, Feb 18, 2025 at 03:05:15PM +0100, Michal Luczaj wrote:
>On 2/18/25 09:35, Stefano Garzarella wrote:
>> On Mon, Feb 17, 2025 at 08:45:57PM +0100, Michal Luczaj wrote:
>>> On 2/17/25 12:18, Luigi Leonardi wrote:
>>>> On Fri, Feb 14, 2025 at 06:53:54PM +0100, Luigi Leonardi wrote:
>>>>> Hi all,
>>>>>
>>>>> This series contains two patches that are already available upstream:
>>>>>
>>>>> - The first commit fixes a use-after-free[1], but introduced a
>>>>> null-ptr-deref[2].
>>>>> - The second commit fixes it. [3]
>>>>>
>>>>> I suggested waiting for both of them to be merged upstream and then
>>>>> applying them togheter to stable[4].
>>>>>
>>>>> It should be applied to:
>>>>> - 6.13.y
>>>>> - 6.12.y
>>>>> - 6.6.y
>>>>>
>>>>> I will send another series for
>>>>> - 6.1.y
>>>>> - 5.15.y
>>>>> - 5.10.y
>>>>>
>>>>> because of conflicts.
>>>>>
>>>>> [1]https://lore.kernel.org/all/20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co/
>>>>> [2]https://lore.kernel.org/all/67a09300.050a0220.d7c5a.008b.GAE@google.com/
>>>>> [3]https://lore.kernel.org/all/20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co/
>>>>> [4]https://lore.kernel.org/all/2025020644-unwitting-scary-3c0d@gregkh/
>>>>>
>>>>> Thanks,
>>>>> Luigi
>>>>>
>>>>> ---
>>>>> Michal Luczaj (2):
>>>>>      vsock: Keep the binding until socket destruction
>>>>>      vsock: Orphan socket after transport release
>>>>>
>>>>> net/vmw_vsock/af_vsock.c | 12 +++++++++++-
>>>>> 1 file changed, 11 insertions(+), 1 deletion(-)
>>>>> ---
>>>>> base-commit: a1856aaa2ca74c88751f7d255dfa0c8c50fcc1ca
>>>>> change-id: 20250214-linux-rolling-stable-d73f0bed815d
>>>>>
>>>>> Best regards,
>>>>> -- Luigi Leonardi <leonardi@redhat.com>
>>>>>
>>>>
>>>> Looks like I forgot to add my SoB to the commits, my bad.
>>>>
>>>> For all the other stable trees (6.1, 5.15 and 5.10), there are some
>>>> conflicts due to some indentation changes introduced by 135ffc7 ("bpf,
>>>> vsock: Invoke proto::close on close()"). Should I backport this commit
>>>> too?  There is no real dependency on the commit in the Fixes tag
>>>> ("vsock: support sockmap"). IMHO, this would help future backports,
>>>> because of indentation conficts! Otherwise I can simply fix the patches.
>>>> WDYT?
>>>
>>> Just a note: since sockmap does not support AF_VSOCK in those kernels <=
>>> 6.1, backporting 135ffc7 would introduce a (no-op) callback function
>>> vsock_close(), which would then be (unnecessarily) called on every
>>> vsock_release().
>>>
>>
>> But this is the same behavior we have now upstream (without considering
>> sockmap), right?
>
>Oh, right, that's true.
>
>> Do you see any potential problems?
>
>No, nothing I can think of.
>
>Note however that the comment above vsock_close() ("Dummy callback required
>by sockmap. See unconditional call of saved_close() in sock_map_close().")
>becomes somewhat misleading :)
>

Yeah, we can mention in the commit description of the backport that we 
backport it just to reduce conflicts but sockmap features are not 
backported. I'd touch as less as possibile in the patch, otherwise IMHO 
is better to just fix the conflicts in the 2 patches.

Thanks,
Stefano


