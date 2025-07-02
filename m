Return-Path: <stable+bounces-159230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1A7AF1342
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 13:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8669817B8E1
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C3266584;
	Wed,  2 Jul 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="MvwW9RzL"
X-Original-To: stable@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DB266B5D
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454373; cv=none; b=ibxODu5Dk59Ybdn9vn/vbwbRrSWKPdl1Y/pdy07O3jIIfk2zuK9yALqskkoxVn15zohwAHIC1vW/nyxdE2xxLBYXMfHURa/8aerIf58ZhbOYkUFXmK6fiGMcYomDzt7NN0FIcvotJSK1eGg3rg51V5b0hJfwVoV82S1iOwBhsQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454373; c=relaxed/simple;
	bh=IkqPjtkMJMfbM11EiYHkCWXivObWAPVuZqrgJhNeZNQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BUZhOVVTnQal3cxGSNzJtpb2M9/i5W6VvfsVnvv9Uon4RMs1/rZc3bY8+vEJ5qNw4PFjb7060LcJaGekVQ2C1G64n5+mSCbPAeEljfCyiNyC0WSekF7lNp/GXYFVxU+CA+t/tKSK0d5gsLEQ8hB56BhBd4CVhXDaqJYz/fD9wBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=MvwW9RzL; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id EC7657D3B8;
	Wed,  2 Jul 2025 13:06:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1751454369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnbpDV7dzRLynZMzmAxrOSddhCdmoPd9hSilLoYzdPw=;
	b=MvwW9RzLQjYiSTR+e5ihGrSOKKnA31M8yY0kqBdyU29cnpWXbUbYH+XUHU8lVqziyQ3IKZ
	OqYRi+QLLi7psoEJoQb3okGJzcpw51aizzQ8legacALppqkw0tQTed0rV6AZdv7FdpVWX4
	QSBCDcgddidVJKmAgwlAVF8h2Z8zbLU=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Jul 2025 13:06:06 +0200
Message-Id: <DB1IR843JBIK.3MSLNRKVV1471@pwned.life>
Cc: <stable@vger.kernel.org>, <regressions@lists.linux.dev>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Achill Gilgenast"
 <fossdd@pwned.life>
Subject: Re: [REGRESSION] v6.12.35: (build) kallsyms.h:21:10: fatal error:
 execinfo.h: No such file or directory
From: "Achill Gilgenast" <fossdd@pwned.life>
To: "Natanael Copa" <ncopa@alpinelinux.org>,
 =?utf-8?q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250701141026.6133a3aa@ncopa-desktop>
 <CAA76j90io241-a+2SDLfAMHY2ro4x-Bstw4AxKDOU_izW9goYg@mail.gmail.com>
 <20250702124247.7540ec3a@ncopa-desktop>
In-Reply-To: <20250702124247.7540ec3a@ncopa-desktop>

On Wed Jul 2, 2025 at 12:42 PM CEST, Natanael Copa wrote:
> On Tue, 1 Jul 2025 19:07:32 +0200
> Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com> wrote:
>
>> Hello,
>
> Hi Sergio,
>
>>  Thanks for pointing that out. I was not aware of it.
>
> No worries. It happens. Just slightly unfortunate that it tickled down
> to stable branches before it got fixed.
>
> It is trivial to fix but I wonder what is the best way though. Achill
> proposed to use #ifdef HAVE_BACKTRACE_SUPPORT in
> tools/include/linux/kallsyms.h but it appears that this was included
> only for KSYM_NAME_LEN.

This would still not resolve the actual issue that execinfo.h is
included if built without backtrace support and kallsyms.h gets
included.

#ifdef HAVE_BACKTRACE_SUPPORT can be seen in other places in tools/,
where it is used exactly like I did in
https://lore.kernel.org/stable/20250622014608.448718-1-fossdd@pwned.life/.


