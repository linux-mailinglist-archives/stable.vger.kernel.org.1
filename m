Return-Path: <stable+bounces-121415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A13A56DA7
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8861E3B294A
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7444923BD06;
	Fri,  7 Mar 2025 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="LoKSonDZ"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1023BCFE
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364823; cv=none; b=aoE7DpjbcL66lXmVA06RmwpiL1093ynMcbPVXPHnrhWVoJ531HS0BQ2hezsGd8y6+CHTyr44KLjZCu0ohblfea5wTnzqxaUuERwLfIM4NdwUELMvhzOUIgjZmto+jVjcoIA7bo0exS/xuftzmLibMetBQhNhdfIdYt9+Ra5JG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364823; c=relaxed/simple;
	bh=cUWpEdzQBdzS+0BbIueP3qXPSYmseoLozbXVQz6jaoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QO5AP9flv3bBY9MsCO+IVhzxi7xElHchdOkdIYnnA3sO5N/3te8k2rchR1ysRUP2Y6ioKkVrNu4gwm4ytiS/T6z5frvMMNsn8xM7+0FXUgBIl4IqDrzrTi4t77zgf/0E0bpoyWGzDcDu01QxC/YXmj+cR+L8QFl0Sp0WEjBUsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=LoKSonDZ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1944E259B8;
	Fri,  7 Mar 2025 17:26:53 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id maMZVv9Y-YPs; Fri,  7 Mar 2025 17:26:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741364812; bh=cUWpEdzQBdzS+0BbIueP3qXPSYmseoLozbXVQz6jaoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LoKSonDZabhezc1mIAE7qalPpIJotLXw9b3G7PeyyGlFvgHl2cXj1j2OXIbbe5RSs
	 vRVnz5tDhFRv5oHM+0uHqKQnaWv9ARWortJ9zUNOr3dtODtugAHLXAiNBaLQCTwxTJ
	 xoGUr2r77tMSJTtA21K69rmgrywOeqACXjcM6ATp7CBVOq7d1uAjQW0Sj7FWsuBB+d
	 i5jl5nnDE4LF5mQeFZPCA3Q+5ChWnLvyQxjtOvToD+G5i0C3oRZIkFECoD8UIHTbEK
	 MwzZ5UdhrfzwGgV3xL5maXqqSgrydhXSshn2kuTRQ/K4EpoqWWHWe0UZuZGHo+X4Rh
	 JxEfg7QSsapmw==
Message-ID: <d8b92026-2efb-4c74-a197-39b349a10d95@disroot.org>
Date: Fri, 7 Mar 2025 17:26:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Apply 3 commits for 6.13.y
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alyssa Ross <hi@alyssa.is>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 stable@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
References: <CANiq72kaO+YcvaHJLRrRw1=KteApRnRM0iPuSwgFkaCf2BR01w@mail.gmail.com>
 <eotqeb6tyriytvnkjignfkjnie5wb7nzcwjimahxmgnbzxcpmw@mhpoanbqzmiz>
 <CANiq72md_k9AK43tP9UOYyA9jAyC0y96e9Pqn5c8_-fqXh-Hyw@mail.gmail.com>
Content-Language: en-US
From: NoisyCoil <noisycoil@disroot.org>
In-Reply-To: <CANiq72md_k9AK43tP9UOYyA9jAyC0y96e9Pqn5c8_-fqXh-Hyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Miguel,

Please cc me too, I'm interested too.

Cheers!

