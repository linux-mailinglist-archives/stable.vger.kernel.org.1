Return-Path: <stable+bounces-41505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BECE8B3508
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903131C2139B
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D4714290A;
	Fri, 26 Apr 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVcPwbDb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F74214264F
	for <stable@vger.kernel.org>; Fri, 26 Apr 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126348; cv=none; b=R0/dDt80xwmLxwgBqAaiTmsEHClNf0G96tYzWQRfKi1zMiPAYPJ/vltH1EneQE10b5wbVg46f0MvAD7+6rBWxci3PaMQTWtKo/1mGqgMOw+SG5HEa36CgJWDrf49RBKX3wqBgR+G6kjSJriFSvGCe6CQ/4s9ipXsHlvD6Saiioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126348; c=relaxed/simple;
	bh=egV5kXaV6y7mx9BH/8FSu6IQkGTpRzfa1qgmgVtgxms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AwBpIoUen+n3+kPPg5HcoYEniN6hp9bYdRLgCKMAXwqf6yeMnzVV4tG4Dm3GA7IQD2Qfcw9GStYx7pqrAtnIN6Ygs65hYH/ON4n+3s0YxOD6aZnEv04f2PbSSoF5GEGxgrh9UA5SG7HrMUqc5bSzkdUANRcursDkX7wji0mAdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVcPwbDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9106DC113CD;
	Fri, 26 Apr 2024 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714126347;
	bh=egV5kXaV6y7mx9BH/8FSu6IQkGTpRzfa1qgmgVtgxms=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mVcPwbDbQorHeVYBzb//1c7lVzppmyy9/G3DEqnXNINcdE8nGFOJ+boYE4wA3ZQVt
	 6SAbi5ufyWOm1bGHLZUiooL2q+DHay00o7srrIozmryYxArMEApNQlbaLPXNjNg1xi
	 MsED+gFWiekupNWgBxJ59uCXkCrQuo2tM6oYxByqF2zh3ltQd3Lmu17+Ws0gHSvrQy
	 Pe0UrmEK9P5mfxpEouwmERd6zfwvwjJzVn4SWQLqHagxtafoxWkLWtXZwhizDYSpT5
	 JGuvnYoYBI0CThSM14vYbsONcWrZkOLf99Yx4z6bbUI86FGazr+j+Z6k9egM+eNQk5
	 3+Q5hoLGv9MuA==
Message-ID: <e890da3e6b47059a496f743623800223282d7984.camel@kernel.org>
Subject: Re: [6.6.y] "selftests/bpf: Add netkit to tc_redirect selftest"
 needs to be reverted
From: Geliang Tang <geliang@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Date: Fri, 26 Apr 2024 18:12:22 +0800
In-Reply-To: <2024042610-tiring-overdue-a6b5@gregkh>
References: <ea05dcf2a0417aa2068a4dfa61bd562a6e8127d6.camel@kernel.org>
	 <2024042610-tiring-overdue-a6b5@gregkh>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

cc stable@vger.kernel.org

On Fri, 2024-04-26 at 10:50 +0200, Greg Kroah-Hartman wrote:
> Hi,
>=20
> This is the friendly email-bot of Greg Kroah-Hartman's inbox.=C2=A0 I've
> detected that you have sent him a direct question that might be
> better
> sent to a public mailing list which is much faster in responding to
> questions than Greg normally is.
>=20
> Please try asking one of the following mailing lists for your
> questions:
>=20
> =C2=A0 For udev and hotplug related questions, please ask on the
> =C2=A0 linux-hotplug@vger.kernel.org=C2=A0mailing list
>=20
> =C2=A0 For USB related questions, please ask on the
> linux-usb@vger.kernel.org
> =C2=A0 mailing list
>=20
> =C2=A0 For PCI related questions, please ask on the
> =C2=A0 linux-pci@vger.kernel.org=C2=A0or linux-kernel@vger.kernel.org=C2=
=A0mailing
> =C2=A0 lists
>=20
> =C2=A0 For serial and tty related questions, please ask on the
> =C2=A0 linux-serial@vger.kernel.org=C2=A0mailing list.
>=20
> =C2=A0 For staging tree related questions, please ask on the
> =C2=A0 linux-staging@lists.linux.dev=C2=A0mailing list.
>=20
> =C2=A0 For general kernel related questions, please ask on the
> =C2=A0 kernelnewbies@nl.linux.org=C2=A0or linux-kernel@vger.kernel.org=C2=
=A0mailing
> =C2=A0 lists, depending on the type of question.=C2=A0 More basic, beginn=
er
> =C2=A0 questions are better asked on the kernelnewbies list, after readin=
g
> =C2=A0 the wiki at www.kernelnewbies.org.
>=20
> =C2=A0 For Linux stable and longterm kernel release questions or patches
> to
> =C2=A0 be included in the stable or longterm kernel trees, please email
> =C2=A0 stable@vger.kernel.org=C2=A0and Cc: the linux-kernel@vger.kernel.o=
rg
> =C2=A0 mailing list so all of the stable kernel developers can be
> notified.
> =C2=A0 Also please read Documentation/process/stable-kernel-rules.rst in
> the
> =C2=A0 Linux kernel tree for the proper procedure to get patches accepted
> =C2=A0 into the stable or longterm kernel releases.
>=20
> If you really want to ask Greg the question, please read the
> following
> two links as to why emailing a single person directly is usually not
> a
> good thing, and causes extra work on a single person:
> 	http://www.arm.linux.org.uk/news/?newsitem=3D11
> 	http://www.eyrie.org/~eagle/faqs/questions.html
>=20
> After reading those messages, and you still feel that you want to
> email
> Greg instead of posting on a mailing list, then resend your message
> within 24 hours and it will go through to him.=C2=A0 But be forewarned,
> his
> email inbox currently looks like:
> 	912 messages in /home/greg/mail/INBOX/
> so it might be a while before he gets to the message.
>=20
> Thank you for your understanding.
>=20
> The email triggering this response has been automatically discarded.
>=20
> thanks,
>=20
> greg k-h's email bot


