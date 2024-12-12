Return-Path: <stable+bounces-100860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0659EE206
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F8C18855E6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4994A20E014;
	Thu, 12 Dec 2024 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EucuRGds"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC3204C1D;
	Thu, 12 Dec 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993781; cv=none; b=OuIfBWmr+eOdLwn6CnI49TaY4luyZy0ZdSVAEVMV39VUCMQxoZqoxtvzqXpd0ajhCK4aZsM26X5ecFMdEM8f096FvLe3cSjDrPtDjuefekbHc+evqG1LG1irvk3yHBg/sx2h4outFbkrCyxZ51S40QFAqTJPRtjBKKte2kYzDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993781; c=relaxed/simple;
	bh=vZVEJ8/ByNgmoy9/yUsq9QG/rPpZKty0IW/qJpn3syw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p0XL1PqUtTSsPlNTqYWlG4JOUec1WKC2vOSK5z65Lf1xAkKsuOs1eSF9rpdKXa2uTgemakswSay1x7xJu+uUG/ULhDA1hk91ONoiSqJ6TLnKm511eXKrrW7xNg+azmYk+zaVSQnxjkmS13LgMN/c7sW2ahUBDvgIJaawrfsRMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EucuRGds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DE2C4CECE;
	Thu, 12 Dec 2024 08:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733993780;
	bh=vZVEJ8/ByNgmoy9/yUsq9QG/rPpZKty0IW/qJpn3syw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=EucuRGdszwZ/FLpdkg32a4JJeNbuh7hs06g+QxpQ7VUSA3ZYiod++rdsvJoYHKhmb
	 LbIC6gksWKzmEINI2TuKTWAVyfNJh07HDclYKAXjHvjY4IdwrL33RePpKnyfhseyO3
	 1z/sDiyToEb6aM0fAVFXZmfYJLExI2BJhUc40obpLDxIZJy5IrfsYzHF6XI5ZEq2Ra
	 RBJXV/bkURpP8zS00XYo3SNapj/48yPXGR8XHpBJPnxc1SUiRiSLeJfmYOcG6V7kOo
	 k+Zl5RSU8AHRMMCZuuzv/yCbBh2yn153fZnb6VwM3/sevPOWfIAg+JW9PFMKVSmOlZ
	 mar7H3PpMUbRw==
Date: Thu, 12 Dec 2024 09:56:17 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
cc: ulm@gentoo.org, helugang@uniontech.com, regressions@lists.linux.dev, 
    stable@vger.kernel.org, regressions@leemhuis.info, bentiss@kernel.org, 
    jeffbai@aosc.io, zhanjun@uniontech.com, guanwentao@uniontech.com
Subject: Re: "[REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works"
In-Reply-To: <7DAFE6DAA470985D+20241210030448.83908-1-wangyuli@uniontech.com>
Message-ID: <687qoq24-o1p4-519q-1r8p-s59680noorq3@xreary.bet>
References: <uikt4wwpw@gentoo.org> <7DAFE6DAA470985D+20241210030448.83908-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 10 Dec 2024, WangYuli wrote:

> Thanks to Jeffbai's reminder. And I apologize for the late reply to the b=
ug report
> by Ulrich M=C3=BCller.
>=20
> He Lugang has left our company, which explains why he hasn't responded to=
 your
> emails as they were sent to his old corporate email address.
>=20
> As his good friend, former colleague, and one of kernel maintainer for an=
other Linux
> distribution, I understand the urgency of this issue.
>=20
> I'm currently testing with the affected hardware and will provide a patch=
 soon.
>=20
> Regarding the temporary workaround for Gentoo, while reverting the previo=
us changes
> is a viable temporary solution, I'm committed to providing a more compreh=
ensive fix
> that supports both Lenovo ThinkPad L15 Gen 4 and Lenovo Y9000P 2024.
>=20
> Thank you all for your patience and understanding.

Thanks for looking into this. I have now queued the revert in=20
hid.git#for-6.13/upstream-fixes

--=20
Jiri Kosina
SUSE Labs


