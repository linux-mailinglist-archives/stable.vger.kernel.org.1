Return-Path: <stable+bounces-199983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95630CA3190
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 10:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC2AB300A270
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB8929346F;
	Thu,  4 Dec 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5nho4Pg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20221684B4
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841989; cv=none; b=BclfvJiAzcDwcl7XINkJm651fCJobFfP9Nc070FUmC2f2sHsZ7/R8GfDtD5WL0oTBk4QOa737s/KiOV+Km+5lxxxymtQSQiFHjctMTVNzAwRMSBVKYN74g4+bE63kImezFsGvBcVgYKa8JakxG4lvKtmSJYKP1Ipk8i6sQ8cZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841989; c=relaxed/simple;
	bh=Q9v18I5Pz/d6r8k3N3JDyNkzcOJh8vbDeuiz6CTejfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQU9Gs/B2x7V9MIdFIIgVEDPWoxyu3yQzZhhmskhKg/+GSXtpG92Y6dZMms3cBRCODAKn0JCLURchQJiAqVPeAknTICQnW2agaMmKQII7tNZOaz1YCjWIXNvrvl6zOC5RWn7d8tRM0R5MVcu45NaOWxznJp6Vc7eeL8h42dzRpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5nho4Pg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b73a9592fb8so207313166b.1
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 01:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764841986; x=1765446786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fCffPivS1b3q1QXuYl6EHeh/j6m+aWa04HljKNPKsIk=;
        b=S5nho4Pg9D9eu50KTN3dgcx2V4p7/nfUG8jQfGRnboZo+fHnMVh/kzMfvrZmYh+A7j
         Dktkr5/4tb+17ta5zK9HSwB1WonWExGwksYtoXmv6BvxR1o3JF1YeIrqE4Bognydsab6
         QsJCUibxPeA3pSuy0RA8utRBTKNaZCTv4hJ0DMaTb36bay4j/WYABQTwasw/YolFJWMM
         DO9Mx1QVuZCs97QaWBlFzDW2Lqjd9vMRFbzx0KLPNQ18+bpnqKEgjUg7hy7TLvThVU9o
         ZdjqZpNgiQtqlJQG2iDX6KLUkA8Vo1vwjAD5zJMv349QKsfdzfTEikvoF904m3Z6tX+9
         WFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764841986; x=1765446786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCffPivS1b3q1QXuYl6EHeh/j6m+aWa04HljKNPKsIk=;
        b=RjDJq0aNTEp5BTfSsH9yV594l93CH3DLNbQrVp3805937juDNRzRa35TAKjYd7PcBm
         QMH2cjvyhJywB7eJ6vYxtoZtLRA+jqEquhZjSIzvV8rPENsVk1qhPRk+0dUIHF9ABi09
         jrUo8u3gAY5EFDwjeMGPzuxOqJhGIcGRX3fzNE+cF5CjcxS/MBGY39zpvlrPMe3tYtG0
         McBVEMghwZyv9toG1rwWwKVIKsLelqD3ui57Of6XmFoc6hc/kT3p0b6RlnmbB41vHIWP
         3+giZsz93W2ZJDb0GkIk4Y9Hnu3EM8YKKxpdA+aVlJXjwYSMsx5LpkMijVEuDDvSqm7y
         IeNg==
X-Gm-Message-State: AOJu0YwvSgYt0+1bJZJj6C/gGJoDzvP04o7v9zyjE9lLQ1oz9cQ3nlW8
	7YNhXfnja1UcilXRSiNQh50QI/DIURRLtHoZGs8m3m66rjQ5Cqh1tEv2ocFvFYks3WX6bc8sGRg
	6B0ztbLnZRODKBH+x/yxa8JvG9FDb7I5iZB9xxkU=
X-Gm-Gg: ASbGncu3qOsQlLWyLJvtjxzopiyEObIuxX5t5iiQoJYA+Ierg/6SBamtBgZ24Llojlu
	OR4iFmiV4rRAwN4fVf1qw/2a5b4mtJJ1ccdbf0CYDsqXBeUzVFnn/ApJfruyqK7T0vsu2UIKPhJ
	Pd9HGHqkFxf4DKydSyxuZJUALNu5qYP/3cWz6S1u0ewu7OK1T6jVRZDwooBKiZaT2DjJlGeSeZR
	6sVFKtShzR1/Kle0m+UAIDVt3vPPKMeU0K3p+hfAMoDkVJ8ZV5cjUT3sem2woXX9i2lTwBJC/YQ
	6CAIjHETedcDNPj5lLrRisxP0vc=
X-Google-Smtp-Source: AGHT+IGvitW7WrxAwkxtX6N2JHmBRo3237P4d6J6+W0EmNImxtO8OJ0LUpuWC+9xUidMGrAoQqeGMZbWxH+7xYO43uQ=
X-Received: by 2002:a17:906:eecc:b0:b76:4a7c:27a5 with SMTP id
 a640c23a62f3a-b79eb6649ebmr225275566b.23.1764841985878; Thu, 04 Dec 2025
 01:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2XoE88ptwc9cG8U18gMPOd1nx8LfMtWn8Urtuu892LRJ8CFQ@mail.gmail.com>
 <2025120420-headache-tumble-c5aa@gregkh>
In-Reply-To: <2025120420-headache-tumble-c5aa@gregkh>
Reply-To: luoyonggang@gmail.com
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 4 Dec 2025 17:52:53 +0800
X-Gm-Features: AWmQ_bkFbFoq60bh_1MuBsuVmBlkfjiA03qCZnlmCWI3IpgS1-tcvfgWpsVsxWI
Message-ID: <CAE2XoE_nn_w0kqKq4wEBGMNYJiCkqgLNQD7cFQ1MuGcwX0bYYA@mail.gmail.com>
Subject: Re: kernel crash when use zstd compress 256gb qemu raw image file
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please contact the zfs developers, nothing we can do about this issue
> here, sorry.

Hi, I am not using zfs filesystem:

root@32core:~# lsblk -o PATH,FSTYPE,MOUNTPOINT
PATH                       FSTYPE      MOUNTPOINT
/dev/sda
/dev/sda1                  ntfs
/dev/mapper/pve-swap       swap        [SWAP]
/dev/mapper/pve-root       ext4        /
/dev/mapper/pve-data_tmeta
/dev/mapper/pve-data_tdata
/dev/mapper/pve-data-tpool
/dev/mapper/pve-data-tpool
/dev/mapper/pve-data
/dev/mapper/pve-data
/dev/nvme2n1
/dev/nvme2n1p1
/dev/nvme2n1p2             vfat        /boot/efi
/dev/nvme2n1p3             LVM2_member
/dev/nvme0n1
/dev/nvme0n1p1             ext4        /mnt/pve/asgard-2tb


/dev/nvme0n1p1             ext4        /mnt/pve/asgard-2tb

I am using /mnt/pve/asgard-2tb that is a ext4 filesystem, let's me
remove the zfs filesystem to try it again

>
> greg k-h



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

