Return-Path: <stable+bounces-136988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3593FAA00E4
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 05:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971A816DA54
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 03:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28626205E25;
	Tue, 29 Apr 2025 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV5Ahk1j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71971876;
	Tue, 29 Apr 2025 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898610; cv=none; b=qosIZX7PWCJ8JJDe9BmFEbKun0KHk5wGXeA+z4QzMdoEVctT73HSde0ozWwHCkzo4lulJ3IQ9I7WKg7S/eUTDDFZVKM6pbPdGwlm0Ez1fJFrg10oxG9Kq/Zj9M2Jh6qiAbjcwiom7CSqojjY4lzsL9nxPfLQL1L6JlpfAXdAyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898610; c=relaxed/simple;
	bh=YXGk8lAmrdjoZqFgLHxvo+rKzMZ4nvHw1bi4fVY8f6o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=e5ZqWLjVMwGsRNbVx9ydt5gWzDz4eDMAYVmHJGYPK1brEWWu7QkvDKBCe+4XBNX8efoBb/JsebYMfCHOwuE0BlA6/90sgMY391Sz/83rAEjZFoIMNuGn1Y0xHKbiqeiDCAqqEogyQVOhj0S0ewZ9MGELJh1UkRIpLL4JmJl8nXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV5Ahk1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E8AC4CEE3;
	Tue, 29 Apr 2025 03:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745898610;
	bh=YXGk8lAmrdjoZqFgLHxvo+rKzMZ4nvHw1bi4fVY8f6o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GV5Ahk1joCdmnd63iqgdtSrxlGGnvdV1Vs97OrPY7ntshGvBT112ON0IE83gUtUUb
	 KI/gK++gAOMIrTj6hDRDLaK52DmOfk9sg000CCQq37hxuL896WzSf1GOz4sbGVbr3D
	 DyqlW5ECsyzm/Qrhb1tMHdGNjZFQRD83gLrx3rfwwgyRsxvuPAdmOXLEQPV0KmZ/PG
	 KjZdUngAMV1LKJ8h2WzJD1t/poEOeFOtWm1HY/iCOq9LfZ9wHJ4dInxCS4P6iJD79v
	 m7xuILSTFRys6vcSJ8tn99537kEArLrZ5OoauMW8hfZ1uRUUzLfnOlzMhglWkGd+Oq
	 ewOqd3JUQPaWw==
Date: Mon, 28 Apr 2025 20:50:05 -0700
From: Kees Cook <kees@kernel.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 stable-commits@vger.kernel.org
CC: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 =?ISO-8859-1?Q?G=FCnther_Noack?= <gnoack@google.com>
Subject: =?US-ASCII?Q?Re=3A_Patch_=22hardening=3A_Disable_GCC_randstruct_for_C?=
 =?US-ASCII?Q?OMPILE=5FTEST=22_has_been_added_to_the_6=2E14-stable_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250429014846.406859-1-sashal@kernel.org>
References: <20250429014846.406859-1-sashal@kernel.org>
Message-ID: <120BD02C-8EA3-484F-81F5-6767B66C48A8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 28, 2025 6:48:46 PM PDT, Sasha Levin <sashal@kernel=2Eorg> wrote:
>This is a note to let you know that I've just added the patch titled
>
>    hardening: Disable GCC randstruct for COMPILE_TEST

Please don't backport this to any stable kernels=2E There is already a fix=
 in -next and the problem only exists due to a 6=2E15 landlock change=2E


--=20
Kees Cook

