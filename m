Return-Path: <stable+bounces-181784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 367A4BA4D82
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 20:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7257BBFFD
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A175230DD22;
	Fri, 26 Sep 2025 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="niR0BRkz"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A272C2FFDD3;
	Fri, 26 Sep 2025 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910099; cv=none; b=lXR40pF6ZzC34SuG2yXkWUqmU+wa2LifR67sphjV2pQQsuah6kSRsyxrlEOxjt5zmOp/X08BGN4YrEM0JSGXsIyvV6wz9ifABPg8kiPYO4YytiD+X7trXGDTvdnRBb9tsk5ezAX7LHXwgOnbg1ejI1gYjHPlahY9lZ6Vb8EM12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910099; c=relaxed/simple;
	bh=WiG2nv4r6iepL7WNBmIbqyWOENNO/dStIImlpN2E67U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=n33CCNWSJyEeZn5u47zuVlHmu4Q6WguQ+kA/oKIO9+WBlLt6DPKompIct3blQ2RY+T/ke8UEbPzjErX/A+D+TNxrg5lbtun3UZVzul7sC7IbXiKr+FpxbgicH24ahCfNvMmDZL0W97NkYk+09GeClHGCA2Z6ALW0TBZgyAT31b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=niR0BRkz; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758910088; x=1759514888; i=markus.elfring@web.de;
	bh=WiG2nv4r6iepL7WNBmIbqyWOENNO/dStIImlpN2E67U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=niR0BRkzZArB6RzVN3WQONUAYnJrTm/uc67A8i8V2DuiF9DoxqFVFrtEU6tfOir8
	 13OCn3X4Hx/d+yD+lulqVUcx/ZYUg20OlBP4xDpD8Gznv8zKvUdmH8UjQm43ZtyCA
	 Ls8wF+mvGvKFelTsDsjBu9qiWmxOUFp4o1Oj3Ob+VIG1PooiEoO/S8Y66dIXR31Oi
	 4v8shJcL9lmY0D5ajasT019Z12FqNZv+PgBUsYYSaoBBxoP7Ml4hEk3DzvkpDuDD3
	 sA+W8F0sZDrX2uKx4ysXd9gmdZy8cXRAKLGOCHUQjzUnv2q2vhjR2rKY/q25xq05t
	 4Y6Z4E6EsnEfDX5fjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrwwJ-1uWSYn1SYH-00b8xF; Fri, 26
 Sep 2025 20:08:08 +0200
Message-ID: <13b7276a-f151-4b03-9f90-847d4a4aa031@web.de>
Date: Fri, 26 Sep 2025 20:08:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johan Hovold <johan@kernel.org>, asahi@lists.linux.dev
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Sven Peter <sven@kernel.org>
References: <20250926143132.6419-2-johan@kernel.org>
Subject: Re: [PATCH 1/2] soc: apple: mailbox: fix device leak on lookup
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250926143132.6419-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WZ8kB1o/D1/0UFtoagz28tiEiEeNQi2zXY79gIdExpVZLRMhclx
 tvltvNdKGfw/8bmLyb6VRCsixvD3+uBn7Gqyt4QHC4pySbn44I2dxLSrDYEKNCWZH1zpxYD
 JVHT0u6YM9V8NYSpbSmmouTSlElwKquahn6YV2CVeChiIBjQ7WYOlc/WK5A0XEuRR1src0/
 VwTOUAxNG4U70mmdlvSGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Mum5dzn3L4=;BJKQFcqmAw2RfcwyXPvFMb74A1r
 ZdTO1QYTTgEgtoBP1Jk1i1UIO5iW+5yIfqMHQAFP5QQjEIV4XREqncT2o+B7F8mbylkuCBJkv
 na+jBC904FCCR+aO2wcV4G6msxlRfATDr2xrl4f9KBvSaoDCwnaFsuZ6nWW2tfQ6dHgPDx4Mx
 FTCzxT9BI90Y3SJFe+zOjE+gLEK95KOqHzgne83oU0od0mvUlCnBUOZuaFLNTanHSy/4Sv7mq
 AK8C02VpZPkT7sB9gNCKGPr1TwxEmEgdT0b+3dWE3udvYYqokXxXLTy0fys+VSZBKSpAepn6V
 vAefqPepu61XgJA/Wm5k7x1mJQbmHMKUoS3CWxh8rHyQpTxcoNvDYV4rlVDsBhKMRXrRaedBU
 qQ4JGh6yjkygpQbR/c9LzQ6cUQX9HsF4yESCJModCLKZI450EpyLOcVAajeuY+wBDbmFcbs4N
 215DHdL9lyUyjyQ6Su7a8SYU/LrHyhkBSh9XiLANfbSU1EsfCrPqpZimUydMZv1y/1OWCkOhy
 v0s97w3cmIOyUBQdibjtqnm7I2Me96kOFpxrnVdiO+x3qE1FSKC5cROzNxZ5Y0tAa4TqKeuDF
 9naEbZiEn5EEqUBvxzIBXHRy/foIHozYOjjFil2XdLCnJZ2NhwLmiZh9tKy//aSpkEnABYWi1
 0uj88SvyPpv6ojtuJ/+0HvDpxemSxT+kBEerkJpla43gAB4p4OkQGbfQ5puSSFz+9LBNt5tLR
 Cm3HoeAtinRbFgkHFsBQdHZo1YLEn2SFPzOJvxf/PudQ9LtfW/RsRYgj6M1nupHqC0oBb7U8N
 vhtisZ72C7cKJFmJ9bAFOTdM3dL13EKIxCmsrqiKD/BlTBT8VVXLlXCbXIaY/u+cGo6cJtUxJ
 3ktF48zWS1+26It21ci8ndDSUYv7T0Bg6FB44zcQrkID3NnBdMIRwwgF8vi71IO+40oB88K06
 NZiDuQXqV5YJvex+yX7079VXh5ZxTwrRLTE9aIEueMm9+VBeZc6ybcrDeAjCuKIcxN665MLCr
 23JOgW803xyfshifPrDoI9vNpViJcq5z9uqLkWNDJq28k1pcdvkGgERs7TDQlj0i5D4Pyzked
 Gk/9JDdKdGrQ7rsQpwOV+V0Zckh5gkTXtNKVMChULqUUqLtehAEnkcQhTLkX7DkbOw2zVzS24
 FVgKfZNFqHklPtR51V8GEfK/YuK2n4J/H8S699Rmxzh8UdWe1uADliYOCCNnfIY260ChzR2vw
 VX9IRi/JlubVSq8nCtEwgfxDkayf6s2CytwM50lkOEJm4Bm1V7qSpNHKCHFNi3xOZ7LiQHcFM
 h91IwU4Gm3rK6G3Ef1ISbZsi4l0aGEhZGqIkzUDK/OcH0UQcKEysMls7yzUigPfM7zvf9VoVo
 8TumnsLajAul94pw6AtWEGLOzyK1ld5/OWSCjJ8WhRaNp3YDH7rEVyaMtmv2IxTHu17tYGRrl
 mTgrRaLoTQ7hgJpCBuhlGPch2RDHiz1IgjNSYXRf+SfIV76nIU+Ept6VKAo4U4t7ocAXKkKB6
 B7q9mmJ1EzWmzgOPJbPKfc6l9orRITEiXXaPqV3uRKiUy6dNR/QBfTwl4U6pszVcsc1YDCb8N
 3ZpvEf3DUY0MiTavIoUVLE3lcMRJIIEuevmLVj7BWHdBc8tXxjUeAk2z2m1mRNh69swffqFGI
 SBMBcvWMux8Ux7uDR+TIAigqP7j4CLtNA0HdYtGaSEu68rfT3c30ePf1fu5/hXLTUjGzluFc/
 orFtyIlX/TNtQ2MdfittWuQ9oN5yv0LsK5gX2c+TmCwYS5X0X6s6Kpe2asJ94G5YUMZsMg6DT
 Ifunmy7TiobbfeGYAU+rDTmAEp7tSi4ZLNekVgXCWH7FV/yFKuyDHVslHl+irA+nB2GiOk0R2
 1VezgBx2cfGRu//2jOTnJKeitSFVXJ2rIFs7Arc+2SmJWH6KIBqtr07LITRYAW4kxIgBxY5S9
 uHcSIJrcfgVVl013iLZXakRYMm8fXFuh6zLdH37Ex7CdO3T8adYLOK5NPm67j6ZCK/CCxZK0v
 QmDqlfEnJbarepcjZv4n3lsY1x1FE92GnpEYInanijuNueGK44rx5vJOFZI8SPqecxb3IxZa/
 otiBcE7IsP0bglG1wV60bBVcX1uUPCb1Fku1FKmMNPjys3yqTTFZLdk7fCOQleTKJ+i4RzeE0
 lZCiMREC+o0FESGS4qzdLR/BWJKtLo+InIahpnbaH5Iyp/v81p8zmFQqt8xK4om1HgsNfK3cw
 CVbFw0wxIe5sLzPo0Ka//F8gkc6KsqTGXohnrJ5fwtOCuqtoNlaRe8zqtygmEbrmjGK8sazZ9
 xkKYpP8TiKzrQkhtpFWP+B2cEvC/bmRdrDlFx6QXr0KI4HxAirwelG9lGMMlZL/h0KsUxK8s2
 6gKpWNWL/iZrNE73vZb/Po31mOEVf6uCYR5sBDfL8IpnuEQy44yo4vYRy1czRF4JGIVwM07Sw
 Z4OMDUK7iXwUS0SvR6JY9T2hZ5jFuuGnm7+TIPyuYOOpRhl7eM3MY4vz0f9CtQ8pf5jAGqjVG
 3Sf23V/64aN0QdtdsIA34n+asxqv31vgAR9ftWJ9u49X2geyOsvXunupPKqItqTBVZym4uilr
 wXmXnjNMJMTASqFllbG1PMlfdw0Hz0Y3jgdmhvGzswokTKaBLA7ShidtEb+xeXVQQGdeAH9sh
 rcOEdNU9A6dNb6C8cRCV/3O6Fpz9abqEEyCqpxH912eUyKKI9zqHvg8gGbtKXlxTdGVsIpmt6
 YaW7ll7w849lQdYxhg5iuixGg0+T30rrv9jQWt/fIFQfSpwKG6J8Tfwopl3U0uOr7uJCSwKVY
 6jG/ukWY0+SgDTr6kH2RjzTNtAuo16niY7tun5ITQqbjHCAH9BG/EVsuVJDGf/QgSbbePLbRR
 e+K9ip3Jbv7JClk8Z4d7zBJOzpQ8g3hhsoEONhJZGuVWxjyBX+z1PrSH1WW40vSgCHflNl2rn
 QlgZhAbo/tPY6B5+sjpkeTsgu6CBn2nxpPwzPz5e7O0IThnYGg5fUCfqxEK067/JRQvbResqW
 p5tJNSRmRT0egntGWoqCMQaOh+lAph9cE/K0M9jW/TYlDg5UXycFpvqSbnBlBshQlkgg8/cRo
 /qcMJsLflS2/7/0AlLFcRXDOxIgEq3cGbrVZolfBryM6eb6MqtqMXNAS+avj8kV+EKQzaODvf
 gtpDYCcinOEbY7BAKB+zqD5MpvjiorqRDQMKghIeWKiS6XirBy22mDkQLxFXqll786QXFLmg2
 /M1ZZsNSR5GNzSttbpUrakx2d41Y6xUpghrzsbsnoTUb3hTHW94wag6Fs/wos2ecAqRLjO+EM
 cgIW7/kP5+kJ0EFlJJLtAmzPlvuUXm1St6gqgai+H/eKLTXsSHZg5T3lmYYTK1g78s2/pPLLK
 O+aBqk17ACLy8SGi4BK9SDPNrci72onqYRxSXekBxaUK4vmjH0b/FNTkkRz90xTXwg6wbBiF3
 6M2YplfznthjylNj13MaCl89Qb00KOm8dhc21ET8encYs07AZCFi/Ks6EbTjoLHZOHwFXfyzo
 tE2ubkdWWYvic3Sm0aQRYSb/IYHZw/I9ewENM0NivqUKqqmA5yeQs7zBSkVvrB/cTq6CYwrUZ
 pbFIWvo+TcOxj0vOEVj41HVz06T4+0agrbMZO3CSRb1v8SNPx8OnfpOBpyv27RT/gWXki3M/w
 Vvwp5vvjBJVWjmI/CdE/KMTpB7aUxITEBEeHv83L4rhn12kl98eiHVNOwra09GO0J5CPVk2rJ
 i/MahLOiH99LInGS4iB0f1wkD4C6oMblziqbq+QIIKSuODyY1OsS0TvaHdM7Qh/gnwPz5th2J
 jwpDZYQuDZ1rLw9FkjWwBKyHKSlCwTRjO+1sxESonHFsRBtORu+drc7FzBx3Z3oyM0OZAY0lf
 kmiXSIpC0peYxLIVohcBxNOPSgxr0X7eG3CKq6hpam8v/cv29mY5XssH7xxFvnfLnI+y6Vm/2
 3wp7en6a7CMFqhj3OfsAJ+rqa15VB7pr5xeMJVHzHl9+WLYkTrJStOHaZrz5iC+9+5IcQ+1JG
 DN/P5vu39nOjW+Homga9n/n5OJRo+XECeRBiLN9dJnnLITiNKRh2m3D6hS9XGLmfIv96gF53S
 lX/AELsJvuPiWwe70dn2Mv3Yd4awif1VS78os6/b1F8Iofu91fEVBD+oDw/MwbCytsFwS3b+8
 AUCWutJOilAJUCm4kC86Xm3a+3TATkEXB51UmGb5q28VE5h9g7QBCKhVzfIW1d8dnmlJIl+DG
 F62suV2w8efhCBGbnkMBkJZzZqAbig5h733swYCS+YTwLvZ06t9JAbiwiOjU/YNdm14rkXggK
 OBHmO4PmQJBlB7EDewvOsaYthOZGyVn4u+q5bq5EXBxVR/HOSWu70UiejeHrgVRyfRHmWZh8C
 1tLC7VNnaieELDiW7E4DOkivYr/LSf/fzw1eEQ28qH+4kG3MkqzwNgmkDCeVNXkHWUlk2LG3A
 Dykv8BghytAro16zGYW7oAFrbEh72CUezW3yL54+U21sNc7dW6LRohACcjqCeu8Am06834xui
 6+6u2byttlWQWXgEEsEVAcC66mDw9WciK6E+hvSawO2Dfcvk/WvhIOIE7B+nNJ6eEazzUVnCQ
 szJNg0VzXlVleQESsxNz7OpID5QIDK+m/HlX/AKdQa81GWj2ie1mMTaXrA+HoKJhaLi1HsUBL
 uO41cyCi7wRzlTUuC6m7WeL4Gp1yoaEIS+zRP4P1dHQZAN5vY2YsgTfmB9641ankPHqySZj0D
 b7U1jpVOiwvtnwUBcivuXfwLAKT3kgJWGNrIatjuRnnxss2SwK4A3ntzSBVS+BTxIev2OtGtU
 xKQcMLpKZB8GYfpo8BHrwlBosmNpAQ4KCrWH+N4mftNtQR2Cnu8mVfYWc2W1wM2tOkCD7GTIa
 WsscVxe5mMEapgmoOzvVzRdEAGehCy1vmkSKBC/qmofA=

> Make sure to drop the reference taken to the mbox platform device when
> looking up its driver data.
=E2=80=A6

How do you think about to increase the application of scope-based resource=
 management?
https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/device.h#L=
1180
https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/of.h#L138

Regards,
Markus

