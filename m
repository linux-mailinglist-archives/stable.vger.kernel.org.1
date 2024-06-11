Return-Path: <stable+bounces-50146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72BB9039A8
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 13:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E221C21D2C
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBD4179970;
	Tue, 11 Jun 2024 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.it header.i=@yahoo.it header.b="jsTF1bkN"
X-Original-To: stable@vger.kernel.org
Received: from sonic312-25.consmr.mail.ir2.yahoo.com (sonic312-25.consmr.mail.ir2.yahoo.com [77.238.178.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC2E57E
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103961; cv=none; b=URCAo6OXbnwF5tVRN3czM/ms2baHfZxRK4Nna4U0wYLL6f4TJr1mFArzg2LRejvIiWP6MtnvkR7n4UhHHe5UFMKKqzld7xnrr0VEARa/01m8B2bVNA5qxbQS93BcZ/ajQsVvm1c9hovZ2yoUxKL4jBJAbXo07aBt59DzCBe4v/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103961; c=relaxed/simple;
	bh=1NA9dzz8vModzUUzJwmum583xk1rUpj2Io8NVU7QGBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQ008GpZnKxK1MyCff2IGMZfU2tuTgMgZ+MjdxyC1BI36lFsHST4yHuqu7O5Z4CzoLNtdNUj5L8niL4HwXbArIKFpc5QoWB7ETwbw/Btlgz5dMiEd94tXHJd49U0K+3+ErA7Ds1izF7HoAr48eflGXqUEorrOs820K+Ly+DBd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.it; spf=pass smtp.mailfrom=yahoo.it; dkim=pass (2048-bit key) header.d=yahoo.it header.i=@yahoo.it header.b=jsTF1bkN; arc=none smtp.client-ip=77.238.178.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.it
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.it; s=s2048; t=1718103958; bh=p8JQgWGBCmtY8OiiUiT7+jtSYPgsSwI6b+DA+z+dfd0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jsTF1bkN20qwceUn5q3oOBtSxx15IJWLPjJ7KNCpVax8RoBvCmjPRDmIg8V1cfwF2q5QSXROY7OgbGJzf3hqMXdzyq9UhDHZBRlb85RN0uaghLk85y9jRGZgAHxDkP3tOMGgV7dOq5Ur/M2POoUlzGs4XM7zihDB0ca1krfHLn2LqR38ryU4vZ8TVmU1y1+icQXWXGCJ9VPeWGSPxrA7I68c6a0TbqENvZDncHhUIGNpVHWUju+BH881Tb52f/WqjiOXnM9emNBReaAKtR5JDKnpD0ex7yrUiqOdsknDA6rVcbc9U+Wl2nOjZq0cv20dmhCg1370IKSXeCux2Ni5qw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718103958; bh=X+6pABOS2JkVemNhW4tWFrj1qRhJ9Ibpv+BmL00hE9D=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YxTOleSuvfK0CQuRUrTfhE/qqStGXBS8p4bT/V+uVbOW8sMkt86N4V3EmsnsFdhXwybbXvbGStyifQztAI/YGBBOjFUZiT3onSJq4v04WGOdSl4hndai9HqKVjuijHuD4GHAzPqN0+oPbm/SMcFEvK6DU8CjfAoe7YExy/W9G1PPqeNCt3aOV5Cvo/Dm0897Cd+K8pPDC3LRPGlaOFpOgtDh5Oa5/QmooOsgTUqtTTki31ywxqlm/hIPwc7mWyXxzw1cwQaihKvTQduGPr+G59PedCP3moUKr9MW9iFbtRnbuCvr2Xrldzhkt4gfYEOXczahxAVDPAZ7fpJQ2CBT0g==
X-YMail-OSG: PDgjmSkVM1kSaqfCasnFWFQexruKTxhWu_A9ZdZaIegzQhAgU6NdYuVq_E3BbOs
 jL47mJyxTO.Qbo6oqJ0dh9A3erg4Yas.eh7FbsUBAiRCRdNzW.w5BC5l4VHmwMSFy61aUmY8K0fS
 oy7ESXRWaGQKDdkSkrBoSETprLcBHE7OZAJOLZyQBIFTR0UHsTH5CKrWuTfzEPK6hvl3DWqYAzpz
 O2JLwOhz9wDuuiKE__bAH4H56XkLf7qJVUR5tzKhbB7z.tiPDPOwQfWhBsuQQGqnGjKZ.QkUXs97
 dfLe96GhPdL6SqF9dobHJS9wXqWt4S2yKFZhgOXA84qVX2ZN77AJ30O19nLUfmNPpb9HmkXvBdAS
 zbLs5fWC5TySj82Ady9yedyRgHUq7Lj.w__emdYGaB4QpPLpwWLDwvfO3nisq7g7tLm9ziN8NzeQ
 agNj15M4Ofz08OI7ipq1h84cC09oRmeKuwCK9L1VjFn2FUE332zCtlkUW_uh61UutVTztxNjf7fe
 kITdYNTVmScHKe4Mfd0ucneiewTZi_NMmDneCafxqX_E1zngNQkRw8zPpFNqhR56GjYNGn0dwDuk
 SY4E9cfoI7l557JF8ChatlyfA44KvkX1BMPJ98IT963UEauaq2HPJs58bC_kKO5ts24qQDxpjFsF
 4uufGOKxeI2KwYZR_N1ERaQVIlS66aea7ItQeggr32DWStwN_U_DYWlIz6t8fXTLXZ6xVtQa_S39
 8tN0pSaV1ZmJdexcT06nWbpD1yrJMOGr.JGaBA0_VhRfma7lFOMKtmLiJ1H5qmw_iX_oAOEBanff
 4GNV0HLuwr5C7u.Pyk1VxeIAwZJCbH6XxDLln4OjYQHYRqQg2AeP7VDG5RK1gh9xtsUCzeYbfc0M
 YCSypbIOlFLEh_6Q5jFyC.0jeuarNL1SmGRkCneQCdGLgEdG5x1jzMhBYMxmoHPZNPw2b68FyNJ5
 up_K2F_hJrnwkDmn3oIholbSeHj.nATwLQr_.V1ItgROnSHWhEQVLpPmaydMttKWaY86e4Pr58PF
 BjDsc6Q1zpxhp9g_cVqCyYFMAqM6KjkF0aIAxV1DaPUQPLKsh8P9FjgMTF05K45w5jObHH177.kh
 ZdVTtIZvVDbi23inB_W_ShIRrw2hgUAfkVsLjOikqaE851.bTPT5Eay824KnEFP.Nt_KVXyI7_wv
 RM1FRRIsC9jk7AZJ9UDT3HPbC1dJkjXDMhYz0hzecgOSS3kINqitbeKqoY0g3gA362x4EJ.0LHYB
 mmCkKBa9AQZb7gwGIOpI0dtqPDKZnxQgJUMR3.YPR41OPlSE2xtttTX3rVbJQgG5cmCaD5QF6U6w
 Ztg3Yc64HOmMoGIrAbFh4hdynOVhgdhF9zOQWDfm.L0lpqYhLacoQ0WPdlCoZnwytaP5K8CDZWwD
 HiTpVG6D2071AwD1qJrEGH3_wztVVDhhgUY4xDusKqdx0S1AP1FCVs8iA.Wj3HFjcxk3L0DmR0Lj
 IaPjbvLpQkCiacJoCrYwXHiox5QEnCWM.l23Dkz0fP7HwpB1QOjG5GVc_J4T3P_Kpqmq3zNA0u2p
 R9aLiqFt5JPDN0JlCsWdo304QblkHeCFCR7VruUc7ajYDLaWyzEEQTQOq.76G3WgX6PHm_m5Emsw
 EBSyhQJ0CVug97hVnnbxV9UtCk4KRrH9tyyQJ7Y7QApVOcLM6lmHODL0K2WK1mafMRH8MImTyepZ
 gNEhRDLgsfxnL.T3WnrtKj90x8EUuksnis0WfHK_BVX_7AfriTlsvc2twNVV99PkqZdwaMc86KPV
 nRrLFniOvCwv5cEdp8exrmzvpmRT2AejJVOaHzZ5BdcCW7TtYRXZeJD8vEZlZ75lymXJnemtqyAU
 1GlvKIA5wParSWHAB.TVOPsyVhhc9PSk7undmIPczucgdp5y6TNcszdkb6OWxIWQahSdbvfJzpES
 DNAeCeatU8VuZ65r8ZY8vbnqLI3BnAWa8Rg2CvU8YjNvF079.PTKsF_3mgk9AM6BH5ID23kHC0PM
 FBZmspX1Xp6jdoCE0iBDbUUUnUclrNV.FhDyx8_kO95HvkQpPPzvXe9fyAsHHDGcgxUySwxcmD9O
 CFS7lmFlRux_UVAhBZvLer2SihSx8sBuM8u0aNjqCClSANUPcSEpEyiyWgsfA3E1DPqswMe1nlPJ
 7DYB3D.JXu.fkxhtccnAJnKF8V0NZg7gw.uQu0BsoNT.Vkx6nfP5Lx0jeEKcSBVFWq7wJ.BiIWoH
 IGN9AX3itopmAxVTGuWfuWaKnZXV7gEl0BDsvqksarO7je.znvk.OKpTs35mowuZds9s-
X-Sonic-MF: <giovannisantini93@yahoo.it>
X-Sonic-ID: a6298b29-922e-48d7-8f78-4ba4019e25c8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Tue, 11 Jun 2024 11:05:58 +0000
Received: by hermes--production-ir2-7b99fc9bb6-wsvcw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9323fb76226d7e80b4f18f94c07a8a98;
          Tue, 11 Jun 2024 10:55:48 +0000 (UTC)
Message-ID: <bed7da51-cf89-422d-84f7-cb3d89ffbe40@yahoo.it>
Date: Tue, 11 Jun 2024 12:55:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Segfault running a binary in a compressed folder
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 stable@vger.kernel.org
Cc: ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com,
 LKML <linux-kernel@vger.kernel.org>
References: <08d7de3c-d695-4b0c-aa5d-5b5c355007f8.ref@yahoo.it>
 <08d7de3c-d695-4b0c-aa5d-5b5c355007f8@yahoo.it>
 <0936a091-7a3a-40d7-8b87-837aed43966b@leemhuis.info>
Content-Language: en-US
From: Giovanni Santini <giovannisantini93@yahoo.it>
Autocrypt: addr=giovannisantini93@yahoo.it; keydata=
 xsBNBFWGlaoBCACcYYy4p5OpFH/zYyJ+DYGfr8m712ai0GpJ3hrY4ncmt+cHVYw0pHeR01j9
 t+dtJTwP3Br84E5z/0/mpg5J+LLEHDbAa5Gtal+ykIwtmfZ9N/GEEQvYAU691sCkk+hLSbDw
 vIKOZSMMCV2Ee5R1gY/cM+UBJVFy/DJi75crugb/Fs9OL19YPBR9YqOb1eoE99/5WTbJ8EFm
 Nq+oqSnp3O/7Uln96be3A3ri0a+njr6j1OXneE9NBLQbQx0VJnrTK0pv1oHJFT6fqs3Ar8BT
 tgvaTQ50Q7rBYeZE6o2m+A6tBeC2JGZYCIXXQBirHVktrsmIqy9pnfHxN7hyPuRM6qy7ABEB
 AAHNLUdpb3Zhbm5pIFNhbnRpbmkgPGdpb3Zhbm5pc2FudGluaTkzQHlhaG9vLml0PsLAfAQT
 AQgAJgIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheABQJYLYzQAhkBAAoJEE20cJYvrev1
 D2sH/R4girMykZt+hh6TdYl2RQCZnGd3+aFiL5bKWQH61uMPp2J/DU5ZarxVPBQVGW7vTRZB
 cgceYoC8lnzkWUzlLG9I0pU8VaY87CvwSauRg98L+6eiX42Hz+3xLKbzVT6azewmR47d4WcH
 CF59lin52O3MhMBSY7VoBEPI7w5tJAF80hzXACqi8cnt/yPI/jRE+NFiD+dUiDj0rRecKr5Q
 9z9+aEjfNiFNI8gkrjGwGerlDso7iOjmGlENY3hv0sP+9/Rq58J1Y+Wg4ACTj6s/vjpgcTQ1
 oJxkyoJbEtUVa+B6R6yc2BHECl+JdkDNohxfRMIN3IzJpIQzGaKNATVbaDLOwE0EWDdW/QEI
 AMvkCk1fA/6fXBRuNscDnDYRLSPoMx7tnjOv1Uub9iyFxr2v8B7DKrQq4R0WS4b2vITnsPZA
 WTWJQ4SE0Sx54QGPVjdMzJTMN2cw7y35lS5anYJlY31O89eMpCPDwp88jtq7LKE0Knq5pu/+
 pWFvfysSJkjrFOAKEGn2GEuT8G9BOplafmjyLXv6bwFViUGmNpaTrztlhBaunMDsluoVGg2F
 LPdCdBJpE/vzAOzxg8WkyV+LzPMrz178WTlM0YSCJ/9Ad7QlX0r0rpG3n+HGlhB2Y2hFQM2C
 SlyEstTvMuHQ0Oe5rjnSHxo3FjESknl0csmQmGkPed/DsKigVTeWiC0AEQEAAcLAXwQYAQgA
 CQUCWDdW/QIbDAAKCRBNtHCWL63r9aSjB/wNUBdHtV2j9UQgCpXVcHHA0VSVYSRfvDs0rVOk
 1whAHlg62TKQv2uTFlvn8/lml/Wp7gyW2RKTC9ZIpn3vbgjbW7DuwvjSqCvEt83czRime2jM
 h8URlFRrSFwfNifGxSXsERaH0b7/ae2zfIKRLGhep+/wikTYrItwmW+xXumBVRpkoaKDPy4d
 lhdUxx3EulaWJJgfywYWoieN1jMRcvBWsuexdMFODMPt872NDZhkqrOo+A3fneaELitZdjKq
 NpmY6C9etaRkDnjm70l2cP+RjWY1ahxFuwaOB3ZmNRe3VGyvPTUvdkwZdxaycLgVjEWUJEyq
 H3BYrE7EWk47q50Q
In-Reply-To: <0936a091-7a3a-40d7-8b87-837aed43966b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi Thorsten, nice to chat again!
I am sorry for the lack of information, this is my second bug report to 
the kernel; the first one was via Bugzilla and I filled more information.

Now, the missing information is:

OS: ArchLinux

Tested kernels: both latest Linux stable (6.9.3) and mainline (6.10rc3)

Regression: no, I believe that this issue has been present forever.
I realized it may have been compression-related only recently.
I do remember testing ntfs3 long ago and having the same issues with a 
Ruby vendoring folder.

Please let me know if you need more information!

Bests,

Giovanni

On 2024-06-11 12:04, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 11.06.24 11:19, Giovanni Santini wrote:
>> I am writing to report the issue mentioned in the subject.
>>
>> Essentially, when running an executable from a compressed folder in an
>> NTFS partition mounted via ntfs3 I get a segfault.
>>
>> The error line I get in dmesg is:
>>
>> ntfs3: nvme0n1p5: ino=c3754, "hello" mmap(write) compressed not supported
>>
>> I've attached a terminal script where I show my source, Makefile and how
>> the error appears.
> You CCed the regression and the stable list, but that looks odd, as you
> don't even mention which kernel version you used (or which worked).
> Could you clarify? And ideally state if mainline (e.g. 6.10-rc3) is
> affected as well, as the answer to the question "who is obliged to look
> into this" depends on it.
>
> Ciao, Thorsten

-- 
Giovanni Santini


