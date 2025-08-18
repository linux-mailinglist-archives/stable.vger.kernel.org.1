Return-Path: <stable+bounces-171623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7975FB2AD69
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFAA566993
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DBC2E2286;
	Mon, 18 Aug 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcwzBIKY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E715326D69
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532351; cv=none; b=um7JSgiVmctKkKRCAdHrq4f3mDw+Vw44FswtPokb5iOIO+GGjGDEWB+RUBHG1TlB+fSK+anCgLRyUOgev/ct3MiAsRTyBnYY/R8455ahzmZdGc5fRbfXwJQx03ytfTwwRF29Iggp02cK6RXc3RZh7k4T+2LW66TIkzKEAhE+sRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532351; c=relaxed/simple;
	bh=dG+BJQGWzDVo/XKYNLITI1dyfKFEN5X6dQ/mmNXgokE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hxz8Bcc9nv5M1izMZmzfRweRAESPcTm3EMmdvPtzgGmmJj3C8MFwNWT+UWRmK5nh8f7cHB7hsmL3gWX1wuVk6iKq81lUIkCti6I66/n91kVNwBq8MioeFUERKDZ3B9yDjjxHAbBTRSOOS+ngD8BVqoCYTCTQsjxQ3zvLmpYxuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcwzBIKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD72C4CEEB
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755532350;
	bh=dG+BJQGWzDVo/XKYNLITI1dyfKFEN5X6dQ/mmNXgokE=;
	h=Date:To:From:Subject:From;
	b=tcwzBIKYE1plWBW92eFevUKuzlADYHxhkud8pUh5ffLZDjNyMzFtDq1yV5DTZMUH/
	 a0oeIj6JtWrVe26YMwg6jAMyOxRbdiMkKe641rP+JfwnwskzBe3jauE1hYjwvXSpDb
	 yPyi80P1vxBhOAZquEsCDRi/BGvbJ5WQnSsTj9bElEsmmU8DZmsOxKc0ZaJFdP0Zni
	 m7wjVAXDe3Va/qs5s9uqneVrFGRDzMcZjX7u/+6a2AAAz6UW9A/aLds1aQinQdsrS+
	 db2b3ESUCytA9T6nIAXAJdcRf7YR7d1y3wHmFmnPJq6vhOAHb9qX4HnnYFo3rbfPcj
	 Hts65P1V2c6UQ==
Message-ID: <96f62b2d-4d26-42ed-8528-e48b2d385341@kernel.org>
Date: Mon, 18 Aug 2025 10:52:29 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: PPC GPU hangs patch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Some GPU hangs are reported on PowerPC with some dGPUs.  This patch is 
reported [1] to improve them:

commit 0ef2803173f1 ("drm/amdgpu/vcn1: read back register after written")

The other VCN versions are already in 6.15.9, this one didn't come back 
though AFAICT.

Can you take it back to remaining stable trees?

[1] https://gitlab.freedesktop.org/drm/amd/-/issues/3787

Thanks,


