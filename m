Return-Path: <stable+bounces-106226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527D29FD954
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 09:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE98C162E5A
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CE78F3B;
	Sat, 28 Dec 2024 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="f23nXzfb"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD9635;
	Sat, 28 Dec 2024 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735373272; cv=none; b=HLnUPUxpmabepFo3KicNBhEvwN9FZSzsWvS1QRMm9vQGAx5VWsPrYIGYv/Op5hvAHCv7neqj6RCwqwViZR6Ako1+vw/nxzcPy+K2VPxhcLnDsfMJr65hWdP5ro3ZrDfsh2g0ZyGnaR/BG9X1g6McEWqWwBsWlBiquMw+gm7RpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735373272; c=relaxed/simple;
	bh=W4cqmvkgjvdizbltkAWSDYjxyjTSzkqy6aWRrIbHAYU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gSmGR/sjqpSpMdWwR+TyKehushv0iSOr+fRhl+4QCueFhdi3cU4QENeczVaklSZG2CuPL98sUa4lou6iNXD/1A0xi603xFLJWMNSxU01+iwJhWv2vT+IIIRvwwZp+Jg/HTPxmPhEX1IoDxPboIO5ITJOELawDAPya1bGwr9bJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=f23nXzfb; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1735373251;
	bh=xVcctcqMSq6wBzsA9Abhm0VbXwe78XqSjhXnNtuZ3x8=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=f23nXzfboQeUEtrbJqVCbVtWT5I0XF/TL50jNS6soN36ajYrd+IwYTYzGcyDv5dPu
	 sEX0NOb9v7JPDwBxa23uazIA/Z8+LqOMN9P34tEuKxwVDn+7sI/pXBllK+deb/04p/
	 SqdaHHsK009ddcwnhw5TSv+z7QOQN82VqMy2fP0c=
X-QQ-mid: bizesmtpsz2t1735373250tm80vsz
X-QQ-Originating-IP: vB9aaO0K1v9nElreZX4QAy3aOzDJuiPW+lq78mCYYhc=
Received: from smtpclient.apple ( [223.160.206.179])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Dec 2024 16:07:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3484570747972476410
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: slab-out-of-bounds in snd_seq_oss_synth_sysex
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <A2D50A73-EF90-486F-9F5C-FFC4F0906A01@m.fudan.edu.cn>
Date: Sat, 28 Dec 2024 16:07:16 +0800
Cc: linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <13599E88-AAF1-4621-94BE-C621677D9298@m.fudan.edu.cn>
References: <2B7E93E4-B13A-4AE4-8E87-306A8EE9BBB7@m.fudan.edu.cn>
 <B1CA9370-9EFE-4854-B8F7-435E0B9276C6@m.fudan.edu.cn>
 <A2D50A73-EF90-486F-9F5C-FFC4F0906A01@m.fudan.edu.cn>
To: perex@perex.cz,
 tiwai@suse.com,
 vkoul@kernel.org,
 lars@metafoo.de,
 broonie@kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 masahiroy@kernel.org,
 andriy.shevchenko@linux.intel.com,
 arnd@arndb.de,
 yuehaibing@huawei.com,
 viro@zeniv.linux.org.uk,
 dmantipov@yandex.ru
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NAtipnnbTPeaOO1Yhm6Dzz/cFHU4VlJqv7ELD5anXwbV1hhL++fKfIqG
	7OAmNuS9VZGLvFrs0gO0fwkaEq4dd6aybS/9mNZcMHegr1iyDnAjkqCovtV5VSoJIpCWCxu
	cXH3jXS/Yu7omseQFtpocB1OlN5mCLXVfRpykwlwGTGz213sdKP75JcuFcvSsIIqumU20oT
	OHQsE2vT8DxNv5hGHIo9Nvgk+cwtp46XfPdXM96DCwkDPw5v1czxF7NsacrOoAaSwYMjdju
	/jtu3hm9gz2RBgRxeT06dvoWHaX9Lch3GGiHzi60i0t9VVVXsaRXfcyF4H+m4ROI31I1aI/
	NY+G16I+WD+hiwSMiDLzLWcEGsf9tNEnTHpvbzPYcSOUMjHtK0EMaX6ZrOpQlmszmCT9aW/
	ePZ8PdGmxiH4agkFmVSGUoeBfPyKwWmkiGDMvGK0ffSJ2ZQCEGjYXizlcNW42sls9Ay0d/s
	LxtlVmuCm7lqqOeQZbUASV4Bane3KPiTrtahxy6DNIZEyDKoOmsl6ri9u4jBZsY3zqCPG5Q
	ogozVjtYLY0aK6ghyn2EhgUt9JnJDNJtduTyrQN05O1GeHHm15wLkTUoO0sVwHR8dt5lIxU
	1lQLH8QdLdew+Gb03+rTobn6metCddGq+sz8oxQIKN7l8twbOJ1zgIruQ/LVhBd04jwi0Lu
	ot80C60UN9VqX0BVHLqFB73SYinBH0IeaRmD1Qsx6MDJVMPUr4iAfKaogBhn8lSuzMw+vW5
	6kq1Jg/vpCPE+iNvJP02s3lGdBwxCZftPszwViNQTA/SpFHopfxDGUjM0BTK+4CvvJpZWOG
	tTWwTeaYAMkQygYAhlsl8vD/Cg3MhJIXZ/s2f/aAYgtY2rIwFouS0Bzb6COkl7Ihhkz2aPG
	/MDg4nnhrRBqHdsbm5u0W2N1d6B/5OplrmIrRkOpgha+92eMqqxU2xIhkUYNn7Fy7wazNGL
	TQ7y8bb/+nfeXsUqQFfypLpX5GHxjzUHXEVLavzwyLxapu4IcktaNap47
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

>=20
>=20
>> 2024=E5=B9=B412=E6=9C=8825=E6=97=A5 13:37=EF=BC=8CKun Hu =
<huk23@m.fudan.edu.cn> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> Hello,
>>=20
>>> BUG: KASAN: slab-out-of-bounds in =
snd_seq_oss_synth_sysex+0x5d1/0x6c0 =
sound/core/seq/oss/seq_oss_synth.c:516
>>=20
>> We further analyzed the issue at line 516 in =
./sound/core/seq/oss/seq_oss_synth.c.=20
>> The slab-out-of-bounds crash occurs in line 509, when sysex->len =3D =
128. Specifically, the write operation to dest[0] accesses memory beyond =
the bounds of sysex->buf (128 byte).
>> To resolve this issue, we suggest adding 6 lines of code to validate =
the legality of the address write to sysex->buf before entering the =
loop:
>>=20
>> if (sysex->len >=3D MAX_SYSEX_BUFLEN) {=20
>>  sysex->len =3D 0;=20
>>  sysex->skip =3D 1;=20
>>  return -EINVAL;  /* Exit early if sysex->len is out of bounds */=20
>> }
>>=20
>> If you fix this issue, please add the following tag to the commit:
>> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
>>=20
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>> Thanks,
>> Kun Hu
>>=20
>>> 2024=E5=B9=B412=E6=9C=8824=E6=97=A5 19:16=EF=BC=8CKun Hu =
<huk23@m.fudan.edu.cn> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> Hello,
>>>=20
>>> When using fuzzer tool to fuzz the latest Linux kernel, the =
following crash
>>> was triggered.
>>>=20
>>> HEAD commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
>>> git tree: upstream
>>> Console =
output:https://drive.google.com/file/d/17oCyKDW_kNhSW5Bbvm23vnpD1eo0MHFi/v=
iew?usp=3Dsharing
>>> Kernel config: =
https://drive.google.com/file/d/1RhT5dFTs6Vx1U71PbpenN7TPtnPoa3NI/view?usp=
=3Dsharing
>>> C reproducer: =
https://drive.google.com/file/d/177HJht6a7-6F3YLudKb_d4kiPGd1VA_i/view?usp=
=3Dsharing
>>> Syzlang reproducer: =
https://drive.google.com/file/d/1AuP5UGGc47rEXXPuvjmCKgJ3d0U1P84j/view?usp=
=3Dsharing
>>>=20
>>>=20
>>> If you fix this issue, please add the following tag to the commit:
>>> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
>>>=20
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> BUG: KASAN: slab-out-of-bounds in =
snd_seq_oss_synth_sysex+0x5d1/0x6c0 =
sound/core/seq/oss/seq_oss_synth.c:516
>>> Write of size 1 at addr ff1100000588e288 by task syz-executor411/824
>>>=20
>>> CPU: 2 UID: 0 PID: 824 Comm: syz-executor411 Not tainted 6.13.0-rc3 =
#5
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
>>> Call Trace:
>>> <TASK>
>>> __dump_stack lib/dump_stack.c:94 [inline]
>>> dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
>>> print_address_description mm/kasan/report.c:378 [inline]
>>> print_report+0xcf/0x5f0 mm/kasan/report.c:489
>>> kasan_report+0x93/0xc0 mm/kasan/report.c:602
>>> snd_seq_oss_synth_sysex+0x5d1/0x6c0 =
sound/core/seq/oss/seq_oss_synth.c:516
>>> snd_seq_oss_process_event+0x46a/0x2620 =
sound/core/seq/oss/seq_oss_event.c:61
>>> insert_queue sound/core/seq/oss/seq_oss_rw.c:167 [inline]
>>> snd_seq_oss_write+0x261/0x7f0 sound/core/seq/oss/seq_oss_rw.c:135
>>> odev_write+0x53/0xa0 sound/core/seq/oss/seq_oss.c:168
>>> vfs_write fs/read_write.c:677 [inline]
>>> vfs_write+0x2e3/0x10f0 fs/read_write.c:659
>>> ksys_write+0x122/0x240 fs/read_write.c:731
>>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>> do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>=20
>=20

Hello,=20

Is this issue being considered and is it possible that the value of =
sysex->len in line 509 of the snd_seq_oss_synth_sysex function could =
exceed 127 and thus be out of bounds?

=E2=80=94=E2=80=94=E2=80=94
Best Regards,
Kun Hu=

