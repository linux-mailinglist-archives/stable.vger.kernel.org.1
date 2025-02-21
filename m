Return-Path: <stable+bounces-118562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452FFA3F0C9
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 10:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C23D16EE6E
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F252040B4;
	Fri, 21 Feb 2025 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="jg4iC6oJ"
X-Original-To: stable@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7652204864;
	Fri, 21 Feb 2025 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130981; cv=none; b=GRxYca+PwTm3QzJAXsH0f7vIA8s+9BZZLv0/3hWeQUHQbtcBdNkW0UPUD/5JZBFT1fIf8/pzhU1A0ol4pfWW8X9MshwofILkJAvTX3EHeQgF4o5/aC3VDXHzAbZxTnrBhK+a4wdNRLVjYk4l6LmQxCFztO1SrDNnNkZ948HL8wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130981; c=relaxed/simple;
	bh=t4ousF8r2RyUSzA58U9BWyu9ewPTfWsYIlsf3MdymZ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=QT4Eqc3Z7iRPH6RpB+/qbzRy6WQTaXvsgdfFwoS5Xl+D3lDz/Z1gHUIpGQwMXQe+5H7UrktitaxZeK0iGHRc5SgjvXXqRD7th47eXeuNPjhHVPDyDGIed6GO5UoG0jWmANFoo/DYuzoxUOrVqz/rAb9G/AX0LUU+RxYjeOLd0IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=jg4iC6oJ; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id F29F07D2E3;
	Fri, 21 Feb 2025 10:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1740130970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0YiigKNZBH5uzypDeZSmXVaUB8aAJhqjnPQJx8cxWY=;
	b=jg4iC6oJldbUJf4fxIA6mPzCw4XvmH1CY/R4p+h4TKBHVfFJq/mas9kokftMg0pDhbyLIg
	Z9U72/r4ARn5ZXQXsQl1rS32m4zfNkl+ZAEqnTifwiX9kBvIx26cK91bQfY15F7fMAbE/P
	BB3NLL+RtYnO/wfSkewn7lw7ND35IjI=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Feb 2025 10:42:40 +0100
Message-Id: <D7Y0XZ9ADBZH.1XP8NW6BIA1E5@pwned.life>
Subject: Re: [PATCH 6.13 000/258] 6.13.4-rc2 review
From: "Achill Gilgenast" <fossdd@pwned.life>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
 <srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <broonie@kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250220104500.178420129@linuxfoundation.org>
In-Reply-To: <20250220104500.178420129@linuxfoundation.org>

On Thu Feb 20, 2025 at 11:58 AM CET, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.4 release.
> There are 258 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.4-=
rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

LGTM. Tested with Alpine Linux on x86_64 and s390x.

Tested-By: Achill Gilgenast <fossdd@pwned.life>

