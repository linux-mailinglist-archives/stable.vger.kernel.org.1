Return-Path: <stable+bounces-114702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99070A2F546
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F557A3814
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3476A255E23;
	Mon, 10 Feb 2025 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu+HhoRO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E5256C6B
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208517; cv=none; b=Z4WQaGjcJ0xWRmVjCo9gjAd0GDvO69AecX37gDodlvlkfT1YaozgnE2/U3CI0uuZu25Xk/llOyDxn2dK65KKClHShyc8MhhCOn+oamjbAZdw5Sgxpef+xtfMVCY7VuG1MLjA04yNyF1W4329TudmyshPSv/gFkgUAoyHJ0IbRUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208517; c=relaxed/simple;
	bh=LdzAotKJ7uWf+RH8Jbd5iMfSV5jQj4bqj6pbvN+Dl5A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FG2LbLV7KKXg34JDSxz+weH6vGKfRDlXIpRWHUNcBaL62R06mg4dVW+PDTaLZVdHRZtuDy2/sg/typNk3xJqNCKjkinP3c5KEAaUmNg/D2BnWlDrsTl77+L2t7OGq6032lK4H/BzkqhJzCeNT8UzxNRNE8IDnyi/G6knLp7EbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu+HhoRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC63C4CEE6;
	Mon, 10 Feb 2025 17:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739208516;
	bh=LdzAotKJ7uWf+RH8Jbd5iMfSV5jQj4bqj6pbvN+Dl5A=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gu+HhoROgk74hhXKb9nQnLQExalkd/2OrAR0hqrkncRsvuviEH7h3ANLsWnm0IoeD
	 6Vi2us7WQFNd/Os5peZnCJI1KainE6jmT5YBE7i4dtyxScAYdTcomPKj1cSSGVbZvP
	 Md5bRxR3n18ReBBPg9R33IVeQlQ7LrjSlYPfGVcEBT50MO0I91ban1ZEYekO+TXsD7
	 qz064wz954dI4zCvk07v4hI0mEXdS8mc7LkOvfhn3dNW6+bhGMOby4NEuuotJfLjSQ
	 y+YM1waTwe46PBU8SuuaOQjhTTbggaOH7SXvGKzwekn58R34XIMTwMaBjhdMXypze0
	 ycUJ2mJTFfp2A==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Feb 2025 19:28:30 +0200
Message-Id: <D7OXYNUO3XL2.2E2PL64Q9Z4KQ@kernel.org>
Cc: <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] tpm: Change to kvalloc() in
 eventlog/acpi.c" failed to apply to 6.1-stable tree
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <gregkh@linuxfoundation.org>, <andy.liang@hpe.com>, <ardb@kernel.org>,
 <stefanb@linux.ibm.com>, <tiwai@suse.de>
X-Mailer: aerc 0.20.1
References: <2025021024-rover-consensus-cde2@gregkh>
In-Reply-To: <2025021024-rover-consensus-cde2@gregkh>

On Mon Feb 10, 2025 at 5:00 PM EET, gregkh wrote:
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x a3a860bc0fd6c07332e4911cf9a238d20de90173
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021024-=
rover-consensus-cde2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Since this was with fresh HPE hardware and never seen otherwise,
do we want to backport? I don't see much utilitiritian value but
am open for other views too.

BR, Jarkko

