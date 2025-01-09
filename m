Return-Path: <stable+bounces-108127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA2A07BA9
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 16:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4266D3AAEC6
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7E221D90;
	Thu,  9 Jan 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="M5gwJrmt"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F321CA16;
	Thu,  9 Jan 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435868; cv=none; b=ZPMXw9FfwgYE/sXx7ToWcvlylG/Sx+drADFZJHUaXH4XSJjDZ7oqexr6PIL0c8V4MNWlhTEJjzNIwn9wYZCP00nYbrLw4/S4O3rupweJYekJyPEr6JC+BeV6GFUWCI8kWdwQNrwowx0tiHnz0hAYmVMj0FKWWZQhDe0LRRPTSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435868; c=relaxed/simple;
	bh=JVRK4yMiDSt58v3XRHkpcXVcju2t3CuXdpZ0oWJ0eOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZJXRLol9dJkD2fyrcM45q/tgOyo8ChMp6yVO8OaiILAv9ck6uFn5yetTGu7CW3NtTxUxjflPuMEvTrc5AbiH/3GYGO/keQAbIcpxJdkOokSVCEChP481tda8GNDSX6uwG4T2pnURuY8l9JU5VaQfsx3SAEZvTrlxBOmLX1kF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=M5gwJrmt; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.14])
	by mail.ispras.ru (Postfix) with ESMTPSA id BC8F540762DE;
	Thu,  9 Jan 2025 15:17:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BC8F540762DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1736435862;
	bh=LLEFEZIMd49aFAdWsz+uvSWKvIDl4N9oi5MT+LJKDVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5gwJrmtsEpD2ESXkGqOmE+Znk8KC3MnjVhmlAmQoWWt0adVfproeNHvgGjpgHhNG
	 CDK6tJOmV3d84N3JkrqcmEWbeiDUBZk6V/ID1qyowSkw/o7+TvMyq32mMBpdX/6XFU
	 D0r725Ed5HrCrIxnEb0GjgHVLpE2IJTehhbBfKAQ=
Date: Thu, 9 Jan 2025 18:17:42 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jakub Kicinski <kuba@kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Ignat Korchagin <ignat@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP: handle NULL sock pointer in
 l2cap_sock_alloc
Message-ID: <2vj35et6apg2agzztklousifnzt4h2ne6vyjcvb6gxvvpamymu@liqydbn3jb57>
References: <20241217211959.279881-1-pchelkin@ispras.ru>
 <20250109-fbd0cb9fa9036bc76ea9b003-pchelkin@ispras.ru>
 <20250109071102.23a5205d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109071102.23a5205d@kernel.org>

On Thu, 09. Jan 07:11, Jakub Kicinski wrote:
> On Thu, 9 Jan 2025 10:47:12 +0300 Fedor Pchelkin wrote:
> > Urgh.. a bit confused about which tree the patch should go to - net or
> > bluetooth.
> > 
> > I've now noticed the Fixes commit went directly via net-next as part of a
> > series (despite "Bluetooth: L2CAP:" patches usually go through bluetooth
> > tree first). So what about this patch?
> 
> 7c4f78cdb8e7 went directly to net-next because it was a larger series touching
> multiple sub-subsystems:

Okay. So I'd expect Luiz to pick up the current patch then, thanks!

