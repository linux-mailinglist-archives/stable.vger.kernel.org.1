Return-Path: <stable+bounces-1259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED4B7F7EC4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF25D1C21400
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30EF33CFB;
	Fri, 24 Nov 2023 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="pwHPTH6F"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7872319AA;
	Fri, 24 Nov 2023 10:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1700850882; x=1701455682; i=rwarsow@gmx.de;
	bh=Z0sKSE9k2MBhD/p3zzvyLHNgYVL/IX9EG0njTrSSTAI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=pwHPTH6FgjUAm58943zV1byWWHxDa9IuZzDakysd4YeuI2YK3AafNHTpoGCfdJ1n
	 jkC/XPlVMCayXAsofq3tWY5ekZNL8MT+UMb0wZPiMZJxQ3RDN7e9IgpBX91Yn6VtI
	 e5j8nk+I41rhnSOvx+bCeql15fRS8urKVm9h48GXKndqXOLRvxmpeQHMPlFwgkIvy
	 YxIzSrUgjRk6MHs+jqOSe29bWQEnQ18wggX/qAKeNenV1DuD68EvPbGHfPQ2iCRgD
	 dvg+5C7IzwzjsbIdGRSDerTgjZPgKSZcvPDmykFlJ00H3xYeXHObAQLfTVWva1f/g
	 azsbXqnEO3H8tWPozw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([87.122.80.112]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSt8W-1qjvw41ADe-00UGYd; Fri, 24
 Nov 2023 19:34:42 +0100
Message-ID: <3d842616-34f1-4e75-977c-eb09bb70862d@gmx.de>
Date: Fri, 24 Nov 2023 19:34:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.6 000/530] 6.6.3-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:46C3qdJzyJxs5Ui5SHdIS1SqcikRIjiMyfznfiq/dx+f6x0rbnM
 AHwx1IHPAg4dbshKzFl7vBe8cETkaPFmYa0OuAyw1ogzSJhyrlDGyR56NBT3dgWV0yIOYY7
 n/gYuUWnVvnFp369JTSKjuiIqkd4JqKSSW3ewGv/+51VfwTHnJvu0VllDs8rt8SXpFdnris
 +Tuq9933qdH3lMVNkMVtg==
UI-OutboundReport: notjunk:1;M01:P0:8MRSnYosezI=;Z4N3UdgwMeEzhQWhgRZ5ut/tlWT
 HkTvezners/i9FSpVUdsdMR2APuiY/mt3yjOqnUoVCjuYMD0KnTNRq7E8KnDT6MG52FVZRAvr
 JNDb6LgNCDY5dpC4nEpMNXJKblctOGToo+2OG5YOPaiPtuNKv8XJ8U6PNHFj6DWEWo0ypye2R
 2LHo66ojaPivyVtTaSdt9xfm9cy2WzrHmhoCjTap9WsMmElkcaXbXS81f1ZQjKhpdXFXGbL6P
 t8i+t+kZOlZwlsCScZAVJKEcxYGgQ4CNoD1FPf1rg4NsD65m7Jb6ET5mmNyhW3fxyH0KCW+td
 HjW3nWUuD7GT0kOM7hSBQ6TXea+RkMmkfZZXG+wn3tLalwFF7y+yUDlqsoXbqUfySM9yuuYTV
 MUrs22g5KOnPUbogyC7+Jt2lkMGCA5ZdVMDD2FJEILs08P/zFVH5WKggUiQgMR0eOtk3QgsP+
 5X/T0ZAb7Fwy+Yh5oM7deMK0qngmDVsKhr5pE/TkOkCmnsCfEeRDTTqOPsn0+jJ+ujAK+cMh9
 QwLeYVysBYS3kuZaN+3+D8vwm5XsiSAyNMLNeoeTMdOQBSpqzAQB2h3pHbYzfL3r1JjKJetrR
 r4KNE62toge2fNlFMKMtI/iuhxK7i9sdH5YUg0gahZl8w1ovaf9clGaFMnSxrwKE5wI0g0u6Q
 KT5u2UpYc+a8C39shu44pTpAyAUsOnU87wh2e1u6hUtkGLFvH3oREaKZ/6NQylSsrAewYJZ3k
 m9vuX35ki5d/a0dwLlU36HfwOu4RWX56+9ZzagJw6/l4Z6Wmk9tCn+jZU/Ikt1tNvns66nd9C
 oSI+SDJsvulbWGi57ipGA/sH5n6nhlqnCME/67Ueg10xAWF+6BQn+1Jknf1YsMGpaEkvUe/sD
 N4g5HOdrEKuGZOtCVBrGWwuji9d3sWopiF0EwD1ilIrlPxBcjLrhgJTWUv+15YeNStsnOdhWK
 DiucKA==

Hi Greg

6.6.3-rc1

compiles, boots and runs[1] here on x86_64
(Intel Rocket Lake: i5-11400)

Thanks

[1] a vbox crash I first got known off today:
https://www.virtualbox.org/ticket/21898


Tested-by: Ronald Warsow <rwarsow@gmx.de>


