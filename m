Return-Path: <stable+bounces-196682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B03C80141
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 12:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6F7C4E4A75
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 11:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BC12FB977;
	Mon, 24 Nov 2025 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oIVT5PyT"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0452B2FD7DE
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982331; cv=none; b=tvfvTPYHOQ5frJHdOPc2mfH9kaj/Nc4ZuqrLLck9Bfi2S53oP3IWZYmagD9aQNJzKEdxYXq/TjylEtw5FzLHPonfyGJtBeSCQD0XmkHzjrhRI9jYj7ge4s/PDgEeAc3puMUhoq0yMOozGymT9dYG1OUwG8z8nusH6jOiHKoh3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982331; c=relaxed/simple;
	bh=HLxi+FIBBBkDKSqw7AUhx4LCqx/Qy/jGeUPcs7H/RLw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GizxkBVnHHi10XiS2aC5R2/XKrzTvo1syCO195/S7lZQJHxDpOVYuorBHf66TlaIo02UOSSaMmHowjHeF/wBr83Xhta1lE5o5tF5rp9/oYpqrZ9nrEDHPc8Bo1QcCxXH53V3GkC1niRhURvI5IHiFIGXAMx03WCZGI9u1QmiyoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oIVT5PyT; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763982327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLxi+FIBBBkDKSqw7AUhx4LCqx/Qy/jGeUPcs7H/RLw=;
	b=oIVT5PyT/xDBZcDvNAZUozMpTcCjHbWruQ5lyqGwIxutrEB8vqu9zCghkqX5V2y3ukKznP
	c9ENU6hpOV/cdhNXiVHSdxswVQihfZN8mbhNBjPSORk3MgcZ28Mfufz8MkQh+1DF5MjOGq
	ECmwxXHkvdRjxmsesH4524hhuZyOOd4=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4] w1: therm: Fix off-by-one buffer overflow in
 alarms_store
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251111204422.41993-2-thorsten.blum@linux.dev>
Date: Mon, 24 Nov 2025 12:05:23 +0100
Cc: stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <43D258AA-1CE0-4C06-A75B-B593FAD3EBE1@linux.dev>
References: <20251111204422.41993-2-thorsten.blum@linux.dev>
To: David Laight <david.laight.linux@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Huisong Li <lihuisong@huawei.com>,
 Akira Shimahara <akira215corp@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

Hi Krzysztof,

On 11. Nov 2025, at 21:44, Thorsten Blum wrote:
> The sysfs buffer passed to alarms_store() is allocated with 'size + 1'
> bytes and a NUL terminator is appended. However, the 'size' argument
> does not account for this extra byte. The original code then allocated
> 'size' bytes and used strcpy() to copy 'buf', which always writes one
> byte past the allocated buffer since strcpy() copies until the NUL
> terminator at index 'size'.
>=20
> Fix this by parsing the 'buf' parameter directly using =
simple_strtoll()
> without allocating any intermediate memory or string copying. This
> removes the overflow while simplifying the code.
>=20
> Cc: stable@vger.kernel.org
> Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Compile-tested only.
>=20
> Changes in v4:
> - Use simple_strtoll because kstrtoint also parses long long =
internally
> - Return -ERANGE in addition to -EINVAL to match kstrtoint's behavior
> - Remove any changes unrelated to fixing the buffer overflow =
(Krzysztof)
> while maintaining the same behavior and return values as before
> - Link to v3: =
https://lore.kernel.org/lkml/20251030155614.447905-1-thorsten.blum@linux.d=
ev/
>=20
> Changes in v3:
> - Add integer range check for 'temp' to match kstrtoint() behavior
> - Explicitly cast 'temp' to int when calling int_to_short()
> - Link to v2: =
https://lore.kernel.org/lkml/20251029130045.70127-2-thorsten.blum@linux.de=
v/
>=20
> Changes in v2:
> - Fix buffer overflow instead of truncating the copy using strscpy()
> - Parse buffer directly using simple_strtol() as suggested by David
> - Update patch subject and description
> - Link to v1: =
https://lore.kernel.org/lkml/20251017170047.114224-2-thorsten.blum@linux.d=
ev/
> ---
> drivers/w1/slaves/w1_therm.c | 64 ++++++++++++------------------------
> 1 file changed, 21 insertions(+), 43 deletions(-)
> [...]

Could you take another look at v4?

Thanks,
Thorsten


