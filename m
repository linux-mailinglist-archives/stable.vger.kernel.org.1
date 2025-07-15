Return-Path: <stable+bounces-163034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E366BB06859
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 23:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41383AEA50
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 21:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BD32BE7D9;
	Tue, 15 Jul 2025 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZqG7N7O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945C2701CC;
	Tue, 15 Jul 2025 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613610; cv=none; b=XoLkIb+fY6CPFtCEPjHoDnO8gDIyfAReiSgODJvJ2l00+NoobzK6cROTCbTDP+4eDrDUtP+6cZDdl+zT7l1ZyLzjbj3f31iibQ1irSMnkh+y1OIhtF898whYth7Z/DD5y8wP+JowZjA0nHMiKMLWV/mCUptC4dhM8TOvwxsxi18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613610; c=relaxed/simple;
	bh=khdEgqxDuOKoD35VNxUVxDU3AJg8kgdeKW09pIcGcew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRcBjMJMujApuM+9dJp00Nd+IydpDaY8bARucJ1lGTTOtmGsanzYix6KyRk+mEyNbOrH9kZCyWrTWGf54sKai6aSrpgKL1vM0gkZSUCLJ1CSEvQoJmnJRNRM7q/SI1ER90vXaVhhgwDdnuBgkm7yhC/W6bPwtottj+btYypZRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZqG7N7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408F8C4CEF5;
	Tue, 15 Jul 2025 21:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752613609;
	bh=khdEgqxDuOKoD35VNxUVxDU3AJg8kgdeKW09pIcGcew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZqG7N7OxArEUOuI8NTNwypNNO7O68WmAJevyUi+yKg89Yy4vVN0b1nf3YJlr5Kfb
	 KTY9ma1t8bJOlRrOVEVYmQY7WakxOjdXdCtKTOEKdB0V9KvbmvNC0wiJLgrrQYyABD
	 9raGymSsHikKEqVs/RHaF7+uRmKq/IqUa8svzlwzL8qhwDBZs+GZWXjFtjt7fc679t
	 yZmpBuvWZ2bwlCpoRxamrBaB1/IVjDqtUFWkyExE5M5kEm93uJPGxxxPs4PbymEpsT
	 TaFDeXKtBRp8C02F79Q6JI1gihEIgpJWvrNSxB8bbwMJb1kIAGtMRK+rqc8v30FewN
	 qOM56y4G7stQg==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	brauner@kernel.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jack@suse.cz,
	jannh@google.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.6 000/111] 6.6.99-rc2 review
Date: Tue, 15 Jul 2025 23:06:37 +0200
Message-ID: <20250715210637.2340772-1-ojeda@kernel.org>
In-Reply-To: <20250715163542.059429276@linuxfoundation.org>
References: <20250715163542.059429276@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Jul 2025 18:37:11 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.99 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:12 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

