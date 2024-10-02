Return-Path: <stable+bounces-80586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641098E0CD
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74571C23D35
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED241D0F6F;
	Wed,  2 Oct 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.co.uk header.i=andrew.shadura@collabora.co.uk header.b="HW86Wa3q"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC4F747F;
	Wed,  2 Oct 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886584; cv=pass; b=OyRLwn2ITvTVMJ07XJrfki0GEHSSsJMWOynfe2Vh6XT4LKd6VSqQmsd28Thukim2AMENiLyeoG0SzVAe7yrdx9+eW0ACFDDlW7RQKZW3m8sereFLutPAsKwdL4ThVLEsM82lKWPyTrvkx83hs/9sJ5Ek86pzC9WGBVpLbbfCqRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886584; c=relaxed/simple;
	bh=J7Oty3o/K3RrC/jrJ9NeNcBCMFHtxP3Bq1EaNprdJ/M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uh2Apt8zELb1XE3jcciGRX8jChsWUL9xHYf+DKgowql59Gn9LS1QxMCWU2AIOLL60zJ/i0ecCHrpY/jj2XQyAJwtybjkOvVRPU+XDWV5hPJ16XShCLMB1sRGgxWM1g47L6YDMQOYOcMZBPdQ3kN35D7liFXpueHmE+hJ9vtP54Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.co.uk; spf=pass smtp.mailfrom=collabora.co.uk; dkim=pass (1024-bit key) header.d=collabora.co.uk header.i=andrew.shadura@collabora.co.uk header.b=HW86Wa3q; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.co.uk
ARC-Seal: i=1; a=rsa-sha256; t=1727886564; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EzOUeQicp6nxxQhp8BIUW2/cQFmML5GpWG66Fyi8va5IA+GNHqpnH3zLUocTfVkH4cksEXCXdXn/37x+PTfZZIv3dDqSd/8Aj90LAnVaux41dhRmS/yeZXbb/Wv9rNJEnLGI7Ekyn8oIrtuKyTWY8kH6hy1S7lWqTdEGOvoDV78=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727886564; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GD6WWExqoFLh8h4694B5y/62qjyl+p80bzUUEQu9+3g=; 
	b=NdiTSMePjq0KiJSbLY9s1msX0rqSuSUOS4S+I3aXs1Z+EJyheeMn6nk/Pd5+Lf8CD7uON6c7TcImNM2pEwz6msfIWC0bfKGIhHpH54v72h/yUZAyvPCRXEbUV2HUFmsdYFpyrnqCwJU0NDc2xs8RcNHeeTHO/gP35LVqKdyQYwk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.co.uk;
	spf=pass  smtp.mailfrom=andrew.shadura@collabora.co.uk;
	dmarc=pass header.from=<andrew.shadura@collabora.co.uk>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727886564;
	s=zoho; d=collabora.co.uk; i=andrew.shadura@collabora.co.uk;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GD6WWExqoFLh8h4694B5y/62qjyl+p80bzUUEQu9+3g=;
	b=HW86Wa3qNg1aINouSYeGWLTtx1Dohez/BEZV3EudFYycK/UgLrjogPfyGuVkABs2
	6gmx77o7IHkTj1810zz5T6AvXe+SCsDgnERleDkQe5jKYCrW0gd2NEcBsKYryJwtQM2
	haPW4C/qlZtmf3Dxng9MVC1zDW8yNJnDhcMnAbPA=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 172788656284725.120871860829993; Wed, 2 Oct 2024 09:29:22 -0700 (PDT)
Date: Wed, 02 Oct 2024 18:29:22 +0200
From: Andrej Shadura <andrew.shadura@collabora.co.uk>
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: "linux-bluetooth" <linux-bluetooth@vger.kernel.org>,
	"Justin Stitt" <justinstitt@google.com>,
	"llvm" <llvm@lists.linux.dev>, "kernel" <kernel@collabora.com>,
	"George Burgess" <gbiv@chromium.org>,
	"stable" <stable@vger.kernel.org>
Message-ID: <1924e1095d0.c47411862290357.1483149348602527002@collabora.co.uk>
In-Reply-To: <20241002152227.GA3292493@thelio-3990X>
References: <20241002141217.663070-1-andrew.shadura@collabora.co.uk>
 <20241002152227.GA3292493@thelio-3990X>
Subject: Re: [PATCH] Bluetooth: Fix type of len in
 rfcomm_sock_{bind,getsockopt_old}()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Nathan,

On 02/10/2024 17:22, Nathan Chancellor wrote:
> Hi Andrej,
>=20
> On Wed, Oct 02, 2024 at 04:12:17PM +0200, Andrej Shadura wrote:
>> Commit 9bf4e919ccad worked around an issue introduced after an innocuous
>> optimisation change in LLVM main:
>>
>>> len is defined as an 'int' because it is assigned from
>>> '__user int *optlen'. However, it is clamped against the result of
>>> sizeof(), which has a type of 'size_t' ('unsigned long' for 64-bit
>>> platforms). This is done with min_t() because min() requires compatible
>>> types, which results in both len and the result of sizeof() being caste=
d
>>> to 'unsigned int', meaning len changes signs and the result of sizeof()
>>> is truncated. From there, len is passed to copy_to_user(), which has a
>>> third parameter type of 'unsigned long', so it is widened and changes
>>> signs again. This excessive casting in combination with the KCSAN
>>> instrumentation causes LLVM to fail to eliminate the __bad_copy_from()
>>> call, failing the build.
>>
>> The same issue occurs in rfcomm in functions rfcomm_sock_bind and
>> rfcomm_sock_getsockopt_old.

> Was this found by inspection or is there an actual instance of the same
> warning? For what it's worth, I haven't seen a warning from this file in
> any of my build tests.

We=E2=80=99ve seen build errors in rfcomm in the Chromium OS 4.14 kernel.

>> Change the type of len to size_t in both rfcomm_sock_bind and
>> rfcomm_sock_getsockopt_old and replace min_t() with min().
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 9bf4e919ccad ("Bluetooth: Fix type of len in {l2cap,sco}_sock_get=
sockopt_old()")

> I am not sure that I totally agree with this Fixes tag since I did not
> have a warning to fix but I guess it makes sense to help with
> backporting.

It=E2=80=99s a shame there isn=E2=80=99t a Complements: or Improves: tag :)

--=20
Cheers,
   Andrej


