Return-Path: <stable+bounces-204309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11740CEB029
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 02:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41DF03019BF5
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 01:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A92D2D781B;
	Wed, 31 Dec 2025 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnVgs4Qx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610F19258E
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767145493; cv=none; b=PSKNC9fOyfuo545gYursN/zVkUtn8PFBTA0CN8rB7DlAzmy7UV4ftvBGvs0/PfTordAljDIoiY78zMNd7DqMmzttoX2XrgrujC1PZr0CObuyNrJHBrfdRtlUNAR2HdHCz84r7Oocosp8ThP/ZDU5WwzRjCRP9Jaat07eovJhyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767145493; c=relaxed/simple;
	bh=+kekd2j+0K3OqUgJbUsLjoOVXDKfpvYmOomqNxMnIzc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DROCah+YS2BngdhJXUyhtt5qQ1krm2ahCfRcX0k75rsqjDqxlfS1YvEa2yMUNkVDzrbnlv3FxIKWUg8PHP3/Ba5/HD1vYOQ8IJvRwE8XIky2/aQVkHv6CbJ1vXTMfSipEHhkX1oOp/p8iTzoF+/arIRSoKzpr0djBCRx8g6urNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnVgs4Qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B442C116C6;
	Wed, 31 Dec 2025 01:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767145492;
	bh=+kekd2j+0K3OqUgJbUsLjoOVXDKfpvYmOomqNxMnIzc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=EnVgs4QxI0S2CmlVa/QBWP4oYvFS2mghqWDmTPji9j2L5B7vf7TMQI03xwgFuHLPr
	 dM2A7eEOenlgozdlWrnwC9Bymqz9lNb+688TYZJyM5hAHQ228AKEqRCOmgBiiP2VTv
	 xuf/e3WiAQe8YID3VAOr+ILXHDUzFZOftr5GRpsxozUYtOk/OqzVt11j9MBXoOHK/t
	 ZUx0699xXY3SfIUG0KGEW/zItRcqhw3V3DnGf8P2wNUbsqSu4tWagpSMDHTyjnKGsW
	 EXgw1r/Ok8CNr2ACLeCthy8rQX1D7Av2yJQJoCSCIIuAe9JzMnNt9TUt6+XamsuY+P
	 bOtzQiLtSUw4g==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 31 Dec 2025 02:44:49 +0100
Message-Id: <DFC0SMRNXSCF.VFRFCASVMX5F@kernel.org>
Subject: Re: ba1b40ed0e34bab597fd90d4c4e9f7397f878c8f for 6.18.y
Cc: "Greg KH" <gregkh@linuxfoundation.org>, "Sasha Levin"
 <sashal@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 <stable@vger.kernel.org>, "Nouveau Dev" <nouveau@lists.freedesktop.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <CANiq72=ti75ex_M_ALcLiSMbfv6D=KA9+VejQhMm4hYERC=_dA@mail.gmail.com>
In-Reply-To: <CANiq72=ti75ex_M_ALcLiSMbfv6D=KA9+VejQhMm4hYERC=_dA@mail.gmail.com>

On Wed Dec 31, 2025 at 1:57 AM CET, Miguel Ojeda wrote:
> Cc'ing Danilo and Alexandre so that they can confirm they agree.

Good catch! Greg, Sasha: Please consider this commit for stable.

