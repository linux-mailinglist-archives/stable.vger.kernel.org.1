Return-Path: <stable+bounces-253618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PCwM85MD2ptIgYAu9opvQ
	(envelope-from <stable+bounces-253618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 20:19:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F052F5AAF62
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 20:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C2E63057888
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC737DAAA;
	Thu, 21 May 2026 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Vlw8U4vd"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063D42C3268
	for <stable@vger.kernel.org>; Thu, 21 May 2026 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382093; cv=none; b=G6ofz6S73a2Jrkv7PPUs4ElvZK0DE03Edp1HcpqxUjzFNy8MqYH5DJyZbMjFIfPRJoU2fkHA4fdfC+2V772tIQctmr6/wuPe3F3jhZXUWr0qucR9NTrdsprxKzy3ls9K8GCK/y7ZP5OBY34k5xZXQr9OiLzBYwRqT/rzVo3vcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382093; c=relaxed/simple;
	bh=mAmTb2T8ftHOy6iLTScZ+I7+R10Qp/w9R5fTtaFOSbk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=a+MXeqWWG8XAswU3Nu3q1czUF7syqYBhXwbEBAXryck4FULXrAMixJHj46Ac4kPqCIrctV/B4mH2sli0jbLT7AtiLyaSlJjtkBU/274+p/CsH9Olb34ZUNOUAZS3FtAaSx9KREzSVno4yEQG6eYx7agkrvRaqTqhsuM7oXyel+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Vlw8U4vd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E52DC40E01B5;
	Thu, 21 May 2026 16:48:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uO4u8UBMyGfc; Thu, 21 May 2026 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1779382071; bh=mAmTb2T8ftHOy6iLTScZ+I7+R10Qp/w9R5fTtaFOSbk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Vlw8U4vdtKDLsh94rsswITcuGZ/DE4DSuYalZyWh+Re4pwwgzx2o4hgh1BZyOjDeu
	 2OF1HE2iFFPOejHRa2jTwWTldG4uqpiyVxfnrJSpuzLH/1ml6MfO4bVe0tm0quXY2+
	 SZ2GG+GmEAabLlfjw0vPCRLWr6oYfWcanYJ4ZIGvwCuyX0tmI+uxcLRCM5IEA73RP0
	 A5gNTeQn/xa4iwSmWmCRY0BLrWGQ5m9BRMSGQJDkC7SXjkcZ/TrZKxRCYLXf+MoshM
	 TtJtLR1bTHoJN1pFac6eGIN57L2caIVTCWHbLtmoOd59UQfQB/x3P9S5zacXs05f4P
	 YtUifdXkz2V6815IxvOqp6IPB2hRvBMMU/u8bmFKjizf84zn2o9xM9d3maEJ7H947G
	 sV/hncdT4g9dsyQPK/3pa6HffpHxT0oDvTinIkL0mgLNtq0H+FORMJrT3GRMwH4Piz
	 itcu/WL4zefvMfVw/gFXURncccEKP7lM9j/8BNLm6O2KquTk4XaKup4L3W7Jv9CfWL
	 vBW58d3uTRHOZzSVClVRX/rnU58f95I3q8GSzlaVixuuchim+vFkwX1Z6U4zHNd4f+
	 Bfv9rWAOIEWbGWhN3FvnCSxgCgKnx9vDeXC7bwAe6ItV2VnOxdLMLYZVV7aP3pCv2x
	 LAFoGClVr1RnxQd4uLA/YBbU=
Received: from ehlo.thunderbird.net (unknown [IPv6:2600:1700:38ca:c00:41e0:d6b9:36c2:bff7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE2ED40E01B3;
	Thu, 21 May 2026 16:47:47 +0000 (UTC)
Date: Thu, 21 May 2026 16:47:43 +0000
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>, Jan Ingvoldstad <frettled@gmail.com>
CC: stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Linux_5=2E15_bug_in_vdso=5Frea?=
 =?US-ASCII?Q?d=5Fcpunode=28=29_in_segment=2Eh_introd?=
 =?US-ASCII?Q?uced_in_2025=2C_commit_ac9c408ed?=
 =?US-ASCII?Q?19d535289ca59200dd6a44a6a2d6036?=
User-Agent: K-9 Mail for Android
In-Reply-To: <DB2B5B4C-200F-4C0C-B14F-F58E0CF4078F@alien8.de>
References: <CAEffzkxUELNHBzABxVmekE2C_MFuPyfbsvO33MXZy46pNRU7xQ@mail.gmail.com> <CAFULd4Z5vE7v37+4J5MLCttnG=cF0XX+Y_T0p1yeY36dL6i5Kw@mail.gmail.com> <DB2B5B4C-200F-4C0C-B14F-F58E0CF4078F@alien8.de>
Message-ID: <F51A475F-F50A-4DE2-A098-871047496301@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253618-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F052F5AAF62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On May 21, 2026 4:46:11 PM UTC, Borislav Petkov <bp@alien8=2Ede> wrote:
>+ stable

Now for real!

>
>
>On May 21, 2026 10:07:45 AM UTC, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>>Please see [1]=2E Patch 2/2 was not backportable, but was backported
>>after it was merged with 1/2 nevertheless=2E
>>
>>[1] https://lore=2Ekernel=2Eorg/lkml/CAFULd4aZYEi02cKeS1RAL66Qs149nLys8S=
JfTvfHuPH3FMXJeA@mail=2Egmail=2Ecom/
>>
>>Uros=2E
>>
>>On Thu, May 21, 2026 at 10:06=E2=80=AFAM Jan Ingvoldstad <frettled@gmail=
=2Ecom> wrote:
>>>
>>> Hello,
>>>
>>> In the following commit, a bug was introduced for older systems withou=
t older binutils versions:
>>>
>>> https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux=2Egit=
/commit/arch/x86/include/asm/segment=2Eh?id=3Dac9c408ed19d535289ca59200dd6a=
44a6a2d6036
>>>
>>> The commit states:
>>>
>>> =C2=ABUse RDPID insn mnemonic while at it as the minimum binutils vers=
ion of 2=2E30 supports it=2E=C2=BB
>>>
>>> This statement is incorrect, and results in a build error on older sys=
tems:
>>>
>>> =2E/arch/x86/include/asm/segment=2Eh:272: Error: no such instruction: =
`rdpid %rax'
>>>
>>> For Linux 5=2E15, the required minimum binutils version is 2=2E23, not=
 2=2E30 (https://www=2Ekernel=2Eorg/doc/html/v5=2E15/process/changes=2Ehtml=
); the requirement for 2=2E30 exists from 6=2E18 and up, so this bug likely=
 affects all longterm releases before 6=2E18=2E
>>>
>>> While reversing the patch does result in a successful build, I am conc=
erned that doing so introduces other bugs=2E Based on the commit descriptio=
n, it seems that the change *could* have been limited to changing "p" from =
int to long, and using the %k operand prefix?
>>>
>>> Could you please have a look at how your patch may be modified to be c=
ompatible with systems using the actual minimal binutils versions for 5=2E1=
0, 5=2E15, 6=2E1, 6=2E6, and 6=2E12?
>>> --
>>> Kind regards,
>>> Jan
>
>So why was the patch backported in the first place??
>
>


--=20
Small device=2E Typos and formatting crap

