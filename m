Return-Path: <stable+bounces-105540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94219FA216
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 20:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20112161D42
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43DA290F;
	Sat, 21 Dec 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL9r999G"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C2E13541B;
	Sat, 21 Dec 2024 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734808228; cv=none; b=Z026+B8aEdgtH6ZBORU15zL724gDu2/GRn3vjgtEQQicWR2F4akSXv5FAcfY7DLaIen49TWOyVidQfty1gN0y96xcG6rs822QXnXZpI/v12WzO31RL4zCyoGINNK/u7VzQPmVsVAFQJnnLvOweVom67xlwo0ba3WYx9STBi6ux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734808228; c=relaxed/simple;
	bh=1vCSKsrwRIcipEZJIKPCqWIAmgBtuik4Cc4Zpxa9jaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lU9Xx0ybphGb8Nf89ynP4MgOPGaxbHW4h5IsEs0ZQH4WEatyhzESH7hgpdLC9/Asq8+El2lLsMbY+4iw1XsoucQzlm1r//WqbByw4lNq6pdcQu/M/uUr2DPujT8NQGTe9dAWjTJhF/C3rnMCWa+5dM8efMwrtntzh4pWivhS914=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL9r999G; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5401c52000dso3238407e87.3;
        Sat, 21 Dec 2024 11:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734808225; x=1735413025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DICSLitDkSZdoKgSJ3JkSamUIfZXy0wB9Dy+tZ/JX4o=;
        b=LL9r999GEWso+CNW7a8ZwE7R4cjECSlcMXHjy8vGTfuXSONWVSkUdTQmjCyLfp4t5I
         VKjh7a0fuW2r0FbGx80SmR8UZUJtrMf6SfvcrduC95bUVJbayr7CQ7xWXvmwHyQh/Buh
         AnQ1xQSol4X08A9JE3w3f5COcybRxTgCMME+0GdzVkwUP0AjGawi23FSrYwxQm3iUh8B
         rj/jcETUrtCKPOSq80LB+J8XllMihrG3L/pP9/ArZIl6rePTmekOjdCZFNpELf6LmJMJ
         YwJsXEq0+7LGsPsPtBM/Epz4Ow+RAPSeP0tgv1f2FORYbSqLHonC8KScULVsWb6S3hxZ
         rwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734808225; x=1735413025;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DICSLitDkSZdoKgSJ3JkSamUIfZXy0wB9Dy+tZ/JX4o=;
        b=bkmp9rhMAKrWzJsbrwGVpFnX3xq8ZBDEq1h4NnGEVtMo4OZEo4PL30WYOIt9kHDGAq
         eNTr4H592DxvPja2lq/IeL4OqjuHEOKGLsqBLxfDBMKj3DUDt+2AAozIyS8UjHQ7Gh1G
         Y5iHNHBvgu0xZBpvV7kiqmMNC/nCVoHiOJZ5V1QykaM9LZjLfeH9GltPIAUEVzK0ppxe
         7FRcI+bgsGVYG4JMRJYcsX87M6XIBPWrJ8BO6tTOem3nlfpPAouDet2Zyh9tO+Kq97dE
         jbnEU/waBEo6bhKMy8VNZGM7VyHcpkNQK9VQR8y6zB4IUOrK0bVlGsI9v4eYCcCmh9M4
         2Yww==
X-Forwarded-Encrypted: i=1; AJvYcCUwm4iCUJrBdUtJ9zXSH8yUk8xvLw8tr8qPZzBV76gfLC39U3RUMNoUqbSgGMmnyjkpWa9sQhyPCFFLPvY=@vger.kernel.org, AJvYcCXwColhAob+GpxnjggynKeFyyPWuV1AJ/Cb+hR+Cn3WhJRjKaeuOYReUfR/UyefM2ELpAZpAFW4@vger.kernel.org
X-Gm-Message-State: AOJu0YxflbZQZXlpzTFWc4j9KMU6ndujsl2HP2wIenQgsi2P8Xv3Ippi
	aRYLsvpcdJI1cdcWPI798WSkmFkyUExS5Uo7zb8GE80Q8kAau4OfDKX4nJxjroe6ZdylzxnLc0Z
	NDmDjn/zWiMLsyQ11xbwAZk6oefE=
X-Gm-Gg: ASbGncvBBEjJ6Id2yCIQU/tlaoQAKSBa7dv45FGyINMR2f32gY3vq/Fn0mk5XijjIhu
	Rgb62ZULAzphlGuwtV3U1999TNpg8GlArL5hmbFot0JTcjAMcS6khdyiNOg53reh/D97B
X-Google-Smtp-Source: AGHT+IEe2LojPiPTBvWcFiJy0Wow6bjJvCnYTDrCzXg4UoYFG87UC6TJQDcIoRRxmiY1F2RYuqc9z090hwAo9aGKC5M=
X-Received: by 2002:a05:6512:2246:b0:542:2e04:edd1 with SMTP id
 2adb3069b0e04-5422e04f073mr879572e87.42.1734808224878; Sat, 21 Dec 2024
 11:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUWHU=oXOEj5wHTzxrw_wj1w5hTvqq8Ry400s0ZCJjTEZw@mail.gmail.com>
 <099d3a80-4fdb-49a7-9fd0-207d7386551f@citrix.com> <CA+icZUX98gQ54hePEWNauiU41XQV7qdKJx5PiiXzxy+6yW7hTw@mail.gmail.com>
 <CA+icZUW-i53boHBPt+8zh-D921XFbPb_Kc=dzdgCK1QvkOgCsw@mail.gmail.com>
 <90640a5d-ff17-4555-adc6-ae9e21e24ebd@citrix.com> <CA+icZUVo69swc9QfwJr+mDuHqJKcFUexc08voP2O41g31HGx5w@mail.gmail.com>
 <43166e29-ff2d-4a9d-8c1b-41b5e247974b@citrix.com> <CA+icZUUp9rgx2Dvsww6QbTGRZz5=mf75D0_KncwdgCEZe01-EA@mail.gmail.com>
 <CA+icZUV0HEF_hwr-eSovntfcT0++FBrQN-HbFL+oZtnKjJzLtA@mail.gmail.com>
In-Reply-To: <CA+icZUV0HEF_hwr-eSovntfcT0++FBrQN-HbFL+oZtnKjJzLtA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sat, 21 Dec 2024 20:09:48 +0100
Message-ID: <CA+icZUV2=20qAqUmXBSfeechf_ObF-m71H7u9zAxGq5hz7k2-g@mail.gmail.com>
Subject: Re: [Linux-6.12.y] XEN: CVE-2024-53241 / XSA-466 and Clang-kCFI
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Jan Beulich <jbeulich@suse.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, 
	xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"

Run all SUCCESS tests on my selfmade kernel.

# xl info | egrep 'release|version|commandline|caps'
release                : 6.12.6-1-amd64-clang19-kcfi
version                : #1~trixie+dileks SMP PREEMPT_DYNAMIC 2024-12-19
hw_caps                :
bfebfbff:17bae3bf:28100800:00000001:00000001:00000000:00000000:00000100
virt_caps              : pv hvm hap shadow gnttab-v1 gnttab-v2
xen_version            : 4.17.4-pre
xen_caps               : xen-3.0-x86_64 hvm-3.0-x86_32 hvm-3.0-x86_32p
hvm-3.0-x86_64
xen_commandline        : placeholder vga=,keep noreboot

dileks@iniza:~/src/xtf/git$ sudo ./xtf-runner --host $( grep SUCCESS
../TESTS-SUCCESS | awk '{ print $1 }' )
...
Combined test results:
test-hvm32-invlpg~hap                    SUCCESS
test-hvm32-invlpg~shadow                 SUCCESS
test-hvm32pae-invlpg~hap                 SUCCESS
test-hvm32pae-invlpg~shadow              SUCCESS
test-hvm64-invlpg~hap                    SUCCESS
test-hvm64-invlpg~shadow                 SUCCESS
test-hvm64-lbr-tsx-vmentry               SUCCESS
test-hvm32-livepatch-priv-check          SUCCESS
test-hvm64-livepatch-priv-check          SUCCESS
test-pv64-livepatch-priv-check           SUCCESS
test-hvm32-lm-ts                         SUCCESS
test-hvm64-lm-ts                         SUCCESS
test-hvm32pae-memop-seg                  SUCCESS
test-hvm64-memop-seg                     SUCCESS
test-pv64-memop-seg                      SUCCESS
test-hvm32pae-nmi-taskswitch-priv        SUCCESS
test-pv64-pv-iopl~hypercall              SUCCESS
test-pv64-pv-iopl~vmassist               SUCCESS
test-hvm32-xsa-122                       SUCCESS
test-hvm32pae-xsa-122                    SUCCESS
test-hvm32pse-xsa-122                    SUCCESS
test-hvm64-xsa-122                       SUCCESS
test-pv64-xsa-122                        SUCCESS
test-hvm64-xsa-168~shadow                SUCCESS
test-hvm64-xsa-173~shadow                SUCCESS
test-pv64-xsa-182                        SUCCESS
test-hvm32-xsa-188                       SUCCESS
test-hvm32pae-xsa-188                    SUCCESS
test-hvm32pse-xsa-188                    SUCCESS
test-hvm64-xsa-188                       SUCCESS
test-pv64-xsa-188                        SUCCESS
test-hvm32-xsa-192                       SUCCESS
test-pv64-xsa-193                        SUCCESS
test-hvm64-xsa-195                       SUCCESS
test-pv64-xsa-212                        SUCCESS
test-pv64-xsa-213                        SUCCESS
test-hvm64-xsa-221                       SUCCESS
test-pv64-xsa-221                        SUCCESS
test-pv64-xsa-224                        SUCCESS
test-pv64-xsa-227                        SUCCESS
test-hvm64-xsa-231                       SUCCESS
test-pv64-xsa-231                        SUCCESS
test-hvm64-xsa-232                       SUCCESS
test-pv64-xsa-232                        SUCCESS
test-pv64-xsa-234                        SUCCESS
test-hvm32-xsa-239                       SUCCESS
test-pv64-xsa-255                        SUCCESS
test-pv64-xsa-259                        SUCCESS
test-pv64-xsa-260                        SUCCESS
test-hvm64-xsa-261                       SUCCESS
test-pv64-xsa-265                        SUCCESS
test-hvm64-xsa-269                       SUCCESS
test-hvm64-xsa-277                       SUCCESS
test-hvm64-xsa-278                       SUCCESS
test-pv64-xsa-279                        SUCCESS
test-pv64-xsa-286                        SUCCESS
test-pv64-xsa-296                        SUCCESS
test-pv64-xsa-298                        SUCCESS
test-hvm64-xsa-304                       SUCCESS
test-hvm64-xsa-308                       SUCCESS
test-pv64-xsa-316                        SUCCESS
test-hvm32-xsa-317                       SUCCESS
test-hvm32pae-xsa-317                    SUCCESS
test-hvm32pse-xsa-317                    SUCCESS
test-hvm64-xsa-317                       SUCCESS
test-pv64-xsa-317                        SUCCESS
test-pv64-xsa-333                        SUCCESS
test-pv64-xsa-339                        SUCCESS

No CFI related stuff in dmesg seen after running XFT tests.

Best regards,
-Sedat-

