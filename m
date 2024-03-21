Return-Path: <stable+bounces-28515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C16F881C09
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 05:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F63281D04
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 04:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D648B2BB1E;
	Thu, 21 Mar 2024 04:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="WYBAEEao"
X-Original-To: stable@vger.kernel.org
Received: from mr85p00im-ztdg06021701.me.com (mr85p00im-ztdg06021701.me.com [17.58.23.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426BA1BDF4
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 04:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710996838; cv=none; b=iRGXixIjGcyqpR8uX4qQaZoCUCz6HUI5FXt5Q+r/hIBU+cRehfj3ynuGXq8kgk12HitdcnkKwRr8P6F/J9EhVeY65lBr3glOVoUrytu5cUSrJX7MO1AAkNUmSxRepPegeoGitaBJL2hBZkF+v0mEq2LESdxlhFYkW3l/V3bEBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710996838; c=relaxed/simple;
	bh=kmIKewn0OS9jBtK0VejszCjBQ3tt+jG0o6bU6vJqHAY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qHQd80jWrbngWl2cxUkAfDcpQkK9O50K7lDnYe3gOlvQa3o0UKevasrZlOnqqX58C0E4OeZZe5I3hdS0Cqq+ZNwlbLArMmIpQvHWkVATWRKCKkdSGKtqqwU8cB3yRUxYGIDklWoVlrQ6Sq3UcndSiETEgOrDj/dkv1K3LK8XBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=WYBAEEao; arc=none smtp.client-ip=17.58.23.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1710996836; bh=+3hJM/vrryWqnRrbEBildsXcg7SPWAKSHMy2nbEpucI=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=WYBAEEao7veau/h+dkj5VkV+mLzEJu8UybYGkwgD5TSoAKhp7sPAkR5QvtLMl2wv7
	 45UIQZLM0/N2zfO5xBMX7gbZlT+g1EGm02IaGW7Hte6z5KH39+VlgiGse+P+HkSxTb
	 2F2XUFRJEyCT19/u+3Q9tCGGxLCBhq9sKLhk3+E/eQ4PQOmplKFxRtw/RN2tBIzMlw
	 Zao7gbEEnHisQC8jSL7+7DWRWjM09yvapJP+EtH0kZSUysrRT4tHgVfwxCTmtS+Bpc
	 nOBPCxD1SwaScoJWWq5XUFLYJsig5Cnb7VjnwfVKLyMlPbE57gdb5vvdHo9BooaRBN
	 6NQSM8bdiURbw==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021701.me.com (Postfix) with ESMTPSA id A1F652633222;
	Thu, 21 Mar 2024 04:53:54 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
From: Laine Taffin Altman <alexanderaltman@me.com>
In-Reply-To: <6857bb37-c4ee-4817-9b6a-e40e549b6402@proton.me>
Date: Wed, 20 Mar 2024 21:53:42 -0700
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 stable@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1F3C985-9CAE-4286-B236-4AF6C0918DB5@me.com>
References: <20240313230713.987124-1-benno.lossin@proton.me>
 <Zfh5DYkxNAm-mY_9@boqun-archlinux>
 <93FD9491-7E2D-4324-8443-0884B7CFC6EF@me.com>
 <ZfkW8rwpdRc_hJBU@Boquns-Mac-mini.home>
 <3FBC841A-968E-4AC5-83F0-E906C7EE85C3@me.com>
 <6857bb37-c4ee-4817-9b6a-e40e549b6402@proton.me>
To: Benno Lossin <benno.lossin@proton.me>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-Proofpoint-ORIG-GUID: 8t8BjbHkZ_z8T1oGI4ChJjWvYynAMZf7
X-Proofpoint-GUID: 8t8BjbHkZ_z8T1oGI4ChJjWvYynAMZf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_02,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403210031

On Mar 19, 2024, at 3:34=E2=80=AFAM, Benno Lossin =
<benno.lossin@proton.me> wrote:
> On 3/19/24 06:28, Laine Taffin Altman wrote:
>> On Mar 18, 2024, at 9:39=E2=80=AFPM, Boqun Feng =
<boqun.feng@gmail.com> wrote:
>>> On Mon, Mar 18, 2024 at 08:17:07PM -0700, Laine Taffin Altman wrote:
>>>> On Mar 18, 2024, at 10:25=E2=80=AFAM, Boqun Feng =
<boqun.feng@gmail.com> wrote:
>>>>> On Wed, Mar 13, 2024 at 11:09:37PM +0000, Benno Lossin wrote:
>>>>>> From: Laine Taffin Altman <alexanderaltman@me.com>
>>>>>>=20
>>>>>> It is not enough for a type to be a ZST to guarantee that zeroed =
memory
>>>>>> is a valid value for it; it must also be inhabited. Creating a =
value of
>>>>>> an uninhabited type, ZST or no, is immediate UB.
>>>>>> Thus remove the implementation of `Zeroable` for `Infallible`, =
since
>>>>>> that type is not inhabited.
>>>>>>=20
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and =
`init::zeroed` function")
>>>>>> Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
>>>>>> Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
>>>>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>>>>=20
>>>>> I think either in the commit log or in the code comment, there =
better be
>>>>> a link or explanation on "(un)inhabited type". The rest looks good =
to
>>>>> me.
>>>>=20
>>>> Would the following be okay for that purpose?
>>>>=20
>>>> A type is inhabited if at least one valid value of that type =
exists; a
>>>> type is uninhabited if no valid values of that type exist.  The =
terms
>>>> "inhabited" and "uninhabited" in this sense originate in type =
theory,
>>>> a branch of mathematics.
>>>>=20
>>>> In Rust, producing an invalid value of any type is immediate =
undefined
>>>> behavior (UB); this includes via zeroing memory.  Therefore, since =
an
>>>> uninhabited type has no valid values, producing any values at all =
for
>>>> it is UB.
>>>>=20
>>>> The Rust standard library type `core::convert::Infallible` is
>>>> uninhabited, by virtue of having been declared as an enum with no
>>>> cases, which always produces uninhabited types in Rust.  Thus, =
remove
>>>> the implementation of `Zeroable` for `Infallible`, thereby avoiding
>>>> the UB.
>>>>=20
>>>=20
>>> Yeah, this works for me. Thanks!
>>=20
>> Great!  Should it be re-sent or can the new wording be incorporated =
upon merge?
>=20
> I can re-send it for you again, or do you want to send it yourself?
> I think it is also a good idea to add a link to [1] in the code, since
> the above explanation is rather long and fits better in the commit
> message.
>=20

I=E2=80=99ll try and do it myself; thank you for sending the first round =
for me and illustrating procedures!  What =
Reviewed-By=E2=80=99s/Signed-Off-By's should I retain?

Thanks,
Laine

> --=20
> Cheers,
> Benno
>=20
> [1]: https://doc.rust-lang.org/nomicon/exotic-sizes.html#empty-types



