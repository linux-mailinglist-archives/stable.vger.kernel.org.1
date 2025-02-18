Return-Path: <stable+bounces-116680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46793A39594
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 09:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EDF3AA9CF
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 08:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33EF202C4C;
	Tue, 18 Feb 2025 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYa339Nd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1971991B8
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867755; cv=none; b=uo883HkBN6aiK4MihSmViBPvH6kAVxbfkOoNBwa1aMQaEC7CwsNWOuJAK1QpHf1bf8GXotZuMJkixnNOYO5JKuPTd+/yfOm1FaEq6hrVN1axc/NP4rpAoMku4LPdpxOB66tO0rrdxOKtLry2VAhKOr29OnNifSjwZHosAh6AC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867755; c=relaxed/simple;
	bh=gqavqsH2PK5a8kO+h1a6YD82aiGZd6jbwwBUt+iSkuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QURGi4ZTwRpZy340+/242D4mXlkG01TIhwQY55d4mqKNaBpy4u0+1xH+jAM38LiD0c7LcRcQXjzFON9g8rs/8iO4RbnnGFjj3T/ZgJWn1TtbSi0t8ypU7bYiO36I5rVNo/GUCeq81ti46Ycqg3d7QD1eD7R3+zeRNDfVrp4joYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYa339Nd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739867752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVIoAbKNLOh7fxHfopR7vAYi4wXKjJS1fzK3nppqVqU=;
	b=AYa339NdxcRQtUZCK7NG2UzVQrEawPspugbGiyuyQvom2e3Zg2uGMFw6XBLbJMbD1YhBbp
	C3/+U9wuUsjHJJgV1Uj+R4T9fiUEfvKieqzt+7B/INwwPhPADQ+V+D9hw9Ssu75OP+HPDl
	8CydmWhJyhcHK/aK/sWDDdu6XChc7Gc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-ctwYmuUhMp6CWenBWezQAw-1; Tue, 18 Feb 2025 03:35:50 -0500
X-MC-Unique: ctwYmuUhMp6CWenBWezQAw-1
X-Mimecast-MFC-AGG-ID: ctwYmuUhMp6CWenBWezQAw_1739867749
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e02d16fea5so2997156a12.1
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 00:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867748; x=1740472548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVIoAbKNLOh7fxHfopR7vAYi4wXKjJS1fzK3nppqVqU=;
        b=KAdMGYzkdg48h7pmvtl8MGHoO2E+p9draLflodQViwENYf28D5nYZB4xibcrIbHLbZ
         0AyTH19o8PSb8V1MbIHXN/V0nLbzIhGNxJQLlPFDt3tw4gXPhuZj/P3Fa2D+C692Rm76
         NVH0On/uGBdRNEhNmBbAao/8oHEnBgOadSHQ47aYpG3h10VDE+6AUcMHlONFm6RMoEUE
         FouAPkUYH1TdvBmK0zpoliA4Lm/EnvAgSnRh0MVRxZ4hBX1k5RemQN63c9k763K5yTUH
         BsI5CN96EIiN3h76hRVKWkxtAm5OUXap1o4nvUNsG5+jAhepPMSVDv/ioYxbaO96r/tR
         ajwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSO8CD78rhGCCxbjSoYjVjHBOx1MIcO0OdfX51F8t4rdNi4m/j/W7T8BNX5x+AQf+ReOfUiXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0U3vmuEu87HSqaU2y7FaAVlrx271tAE9IKffyzJIXZj8USqb
	XRukCAfva1+KqiFrsxDVoAIys/UQ22jsenz6zljZ+dC9GhmOmHv7mYJrAu/QwB1eb2KkWVzjaSJ
	fVYMok1evPoRfOMrola2hYUF4kpnzToaLQfTT0jJJn5w6LZbCbPpmjbg5LyoUdQ==
X-Gm-Gg: ASbGncve2+bJS7psxdhbo8PbebOFgGqizflm2cPhrTSxxjy6ukXDpcMTuo9zZy/hMty
	zj8BbOkk+8EttM7Q3J6jMTcZyDHBSUBVktU3Te3vMIrWgCEeHm2nagJIIB4U7jnlxBsQuVMfa9g
	eDk1c3ynxVXiJagZaxiL8capmtic2Chx+5tX9yGLtzMX8tCqnsjxGYZwAG+KSXPGgWVb2YM2d/O
	RYNA3lvYmGvnKlONMTMChifBx3Dtyro3ScyKKfEGgE7P2zO+aEDLOiVz3dIgm0lCTIJa/fncnIS
	tLboVRfw27GPueHYeaUULGiN3umjFHc7m5VOMcruQzDpg61RUHLZCA==
X-Received: by 2002:a05:6402:530d:b0:5dc:5a34:1296 with SMTP id 4fb4d7f45d1cf-5e036065338mr12964107a12.16.1739867748492;
        Tue, 18 Feb 2025 00:35:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESvK6CPdyqxfwqwWYFA5PU5l3rVcaBZN10WtZ2CmxQDbvY3gKslc9mXX9LFvp0/bGwEfXMXw==
X-Received: by 2002:a05:6402:530d:b0:5dc:5a34:1296 with SMTP id 4fb4d7f45d1cf-5e036065338mr12964064a12.16.1739867747670;
        Tue, 18 Feb 2025 00:35:47 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270b17sm8290875a12.62.2025.02.18.00.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:35:47 -0800 (PST)
Date: Tue, 18 Feb 2025 09:35:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Luigi Leonardi <leonardi@redhat.com>, stable@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] vsock: fix use-after free and null-ptr-deref
Message-ID: <ez2wnwdos73pxbbxanbs5pe2nawvgablvjvrpqldcpbuwy7jz4@y6vnlty435un>
References: <20250214-linux-rolling-stable-v1-0-d39dc6251d2f@redhat.com>
 <f7lr3ftzo66sl6phlcygh4xx4spga4b6je37fhawjrsjtexzne@xhhwaqrjznlp>
 <cf0ef7bc-4da9-492a-bc43-0c3e83c48d02@rbox.co>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cf0ef7bc-4da9-492a-bc43-0c3e83c48d02@rbox.co>

On Mon, Feb 17, 2025 at 08:45:57PM +0100, Michal Luczaj wrote:
>On 2/17/25 12:18, Luigi Leonardi wrote:
>> On Fri, Feb 14, 2025 at 06:53:54PM +0100, Luigi Leonardi wrote:
>>> Hi all,
>>>
>>> This series contains two patches that are already available upstream:
>>>
>>> - The first commit fixes a use-after-free[1], but introduced a
>>> null-ptr-deref[2].
>>> - The second commit fixes it. [3]
>>>
>>> I suggested waiting for both of them to be merged upstream and then
>>> applying them togheter to stable[4].
>>>
>>> It should be applied to:
>>> - 6.13.y
>>> - 6.12.y
>>> - 6.6.y
>>>
>>> I will send another series for
>>> - 6.1.y
>>> - 5.15.y
>>> - 5.10.y
>>>
>>> because of conflicts.
>>>
>>> [1]https://lore.kernel.org/all/20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co/
>>> [2]https://lore.kernel.org/all/67a09300.050a0220.d7c5a.008b.GAE@google.com/
>>> [3]https://lore.kernel.org/all/20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co/
>>> [4]https://lore.kernel.org/all/2025020644-unwitting-scary-3c0d@gregkh/
>>>
>>> Thanks,
>>> Luigi
>>>
>>> ---
>>> Michal Luczaj (2):
>>>      vsock: Keep the binding until socket destruction
>>>      vsock: Orphan socket after transport release
>>>
>>> net/vmw_vsock/af_vsock.c | 12 +++++++++++-
>>> 1 file changed, 11 insertions(+), 1 deletion(-)
>>> ---
>>> base-commit: a1856aaa2ca74c88751f7d255dfa0c8c50fcc1ca
>>> change-id: 20250214-linux-rolling-stable-d73f0bed815d
>>>
>>> Best regards,
>>> -- Luigi Leonardi <leonardi@redhat.com>
>>>
>>
>> Looks like I forgot to add my SoB to the commits, my bad.
>>
>> For all the other stable trees (6.1, 5.15 and 5.10), there are some
>> conflicts due to some indentation changes introduced by 135ffc7 ("bpf,
>> vsock: Invoke proto::close on close()"). Should I backport this commit
>> too?  There is no real dependency on the commit in the Fixes tag
>> ("vsock: support sockmap"). IMHO, this would help future backports,
>> because of indentation conficts! Otherwise I can simply fix the patches.
>> WDYT?
>
>Just a note: since sockmap does not support AF_VSOCK in those kernels <=
>6.1, backporting 135ffc7 would introduce a (no-op) callback function
>vsock_close(), which would then be (unnecessarily) called on every
>vsock_release().
>

But this is the same behavior we have now upstream (without considering 
sockmap), right?

Do you see any potential problems?

Thanks,
Stefano


