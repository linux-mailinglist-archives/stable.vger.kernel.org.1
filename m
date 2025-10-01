Return-Path: <stable+bounces-182978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BBABB1462
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 18:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE4E4A2830
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E5C287273;
	Wed,  1 Oct 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b="i6B1oG4o";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="owsr/EO9"
X-Original-To: stable@vger.kernel.org
Received: from e234-56.smtp-out.ap-northeast-1.amazonses.com (e234-56.smtp-out.ap-northeast-1.amazonses.com [23.251.234.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90652765E1
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759337040; cv=none; b=W1TjwvjdHwHndNCWBkI0YvtJYzYjZsc4JP8F5Aq42AaZ3PGboJ7hWDe0xyQuao8pAG4rVNwJLtyS7dDoxLxvZt875CLOimyPacYNWRjYN60VgEvJcDvXbGO1h697YtPga4NgXFKh4u57QhFgLUTchmURQu1fMAP72fqCfDWA1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759337040; c=relaxed/simple;
	bh=02DJTgg7RO/HtJdqajyCee2lzLj8JweT6saeG5gWmLI=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=FRaGznj2GAZf6rc+UqzvIlGC2qfhtEDYd38gV7m+wOUOWCHdhRPhJ0AAfg2QVsVqbaxw+QwtNIfjJYNEBUILv0TiELix0dDOZ0gbuFBGhXOvQ0UoV7f9tNttUx26+arCNU+hXxJRla0BtAy9jrdSRQbRWOwxS8H9Z0gE9wRpwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=send.mgml.me; dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b=i6B1oG4o; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=owsr/EO9; arc=none smtp.client-ip=23.251.234.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.mgml.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=mgml.me; t=1759337035;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=02DJTgg7RO/HtJdqajyCee2lzLj8JweT6saeG5gWmLI=;
	b=i6B1oG4ox3pSvV5BgrLRDXGGMYw40NVBrbvTBXPwqeH2dK3Id5KOc0lhn+11FIWE
	ZAOUW/InCuGmjg8dTduebQn0jJNlCcF9Q5aMEKtunTWWZrSmtrzrtaqwOXPuyJ5s/Ss
	vwL8UzxKLtGW/W0pkjqVKahDg9yfidgF7MOpjcxY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=suwteswkahkjx5z3rgaujjw4zqymtlt2; d=amazonses.com; t=1759337035;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=02DJTgg7RO/HtJdqajyCee2lzLj8JweT6saeG5gWmLI=;
	b=owsr/EO96qVHUGfLcu7iyIo1ByDKY/P2Yj0b8Sd94zBDu68ohuZQDf0ILYBa1Sdp
	RQuybwUP54AptRYVEzIzdtgpwS5QwGFFfL7O7IlG1dob2hHAQ0bdb4E0/L4BLTdQ1CL
	g/yHhMnjFQi8cfjblJRDSaO/E2aDdvyT9fdKkAig=
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <292570c0-4aca-4e1a-9ac6-70d377909ecf@kernel.org>
From: Kenta Akagi <k@mgml.me>
To: matttbe@kernel.org, gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: patches@lists.linux.dev, martineau@kernel.org, geliang@kernel.org, 
	kuba@kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.1 54/61] selftests: mptcp: connect: catch IO errors
 on listen side
Message-ID: <01060199a0a8b52b-34245f7d-9886-42c4-93ae-369dc547ccce-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 1 Oct 2025 16:43:55 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: ::1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2025.10.01-23.251.234.56

Hi Matthieu,

On 2025/10/01 16:56, Matthieu Baerts wrote:
> Hi Kenta,
>=20
> On 30/09/2025 17:30, Kenta Akagi wrote:
>> Hi,
>>
>> On 2025/09/23 4:29, Greg Kroah-Hartman wrote:
>>> 6.1-stable review =
patch.  If anyone has any objections, please let me know.
>>>
>>> ------------------
>>>
>>> From: "Matthieu Baerts (NGI0)" =
<matttbe@kernel.org>
>>>
>>> [ Upstream commit 14e22b43df25dbd4301351b88248=
6ea38892ae4f ]
>>>
>>> IO errors were correctly printed to stderr, and =
propagated up to the
>>> main loop for the server side, but the returned =
value was ignored. As a
>>> consequence, the program for the listener side =
was no longer exiting
>>> with an error code in case of IO issues.
>>>
>>> Because of that, some issues might not have been seen. But very likely,
>>> most issues either had an effect on the client side, or the file
>>> transfer was not the expected one, e.g. the connection got reset before
>>> the end. Still, it is better to fix this.
>>>
>>> The main consequence =
of this issue is the error that was reported by the
>>> selftests: the received and sent files were different, and the MIB
>>> counters were not printed. Also, when such errors happened during the
>>> 'disconnect' tests, the program tried to continue until the timeout.
>>>
>>> Now when an IO error is detected, the program exits directly with =
an
>>> error.
>>>
>>> Fixes: 05be5e273c84 ("selftests: mptcp: add =
disconnect tests")
>>> Cc: stable@vger.kernel.org
>>> Reviewed-by: Mat =
Martineau <martineau@kernel.org>
>>> Reviewed-by: Geliang Tang =
<geliang@kernel.org>
>>> Signed-off-by: Matthieu Baerts (NGI0) =
<matttbe@kernel.org>
>>> Link: https://patch.msgid.link/20250912-net-mptcp-=
fix-sft-connect-v1-2-d40e77cbbf02@kernel.org
>>> Signed-off-by: Jakub =
Kicinski <kuba@kernel.org>
>>> Signed-off-by: Sasha Levin <sashal@kernel.=
org>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>  tools/testing/selftests/net/mptcp/mptcp_connect.c |    7 =
++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> @@ -1005,6 +1005,7 @@ int main_loop_s(int listensock)
>>>  	struct pollfd polls;
>>>  	socklen_t salen;
>>>  	int remotesock;
>>> +	int err =3D 0;
>>>  	int fd =3D 0;
>>> =20
>>>  again:
>>> @@ -1036,7 +1037,7 @@ again:
>>> =20
>>>  		SOCK_TEST_TCPULP(remotesock=
, 0);
>>> =20
>>> -		copyfd_io(fd, remotesock, 1, true);
>>> +		err =3D copyfd_io(fd, remotesock, 1, true, &winfo);
>>
>> The winfo in function main_loop_s was added in
>> commit ca7ae8916043 =
("selftests: mptcp: mptfo Initiator/Listener")
>> but not present in v6.1.y=
.
>> As a result, mptcp selftests will fail to compile from v6.1.154.
>> I'm not sure whether I should send a revert patch, a patch that removes =
&winfo,
>> or ask for the prereq patch to be applied. So, I'm reporting it =
for now.
>=20
> Thank you for reporting the error!
>=20
> I think the best is a patch removing "&winfo": the goal of 14e22b43df25
> ("selftests: mptcp: connect: catch IO errors on listen side") is to stop
> in case of errors with copyfd_io(). No need to add commit ca7ae8916043
> ("selftests: mptcp: mptfo Initiator/Listener") as prereq.
>=20
> Do you plan to send such patch for v6.1, or do you prefer if I do it?

I would like to send it, but I don't know the following, so could you =
please tell me?

In a case like this, should I send a patch series of =
Revert that, and adjusted backport=20
patch that compilable?
Or can I fix it directly like below?

-               err =3D copyfd_io(fd,=
 remotesock, 1, true, &winfo);
+               err =3D copyfd_io(fd, =
remotesock, 1, true);

I checked stable-kernel-rules.html but I couldn't =
find it.

Thanks,
Akagi

>=20
> Cheers,
> Matt
> --=20
> Sponsored by the NGI0 Core fund.
>=20
>=20


