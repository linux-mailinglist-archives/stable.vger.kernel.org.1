Return-Path: <stable+bounces-96067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882759E06E1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D02817296A
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32BF205E34;
	Mon,  2 Dec 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLHhOSnn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E503205E15;
	Mon,  2 Dec 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151362; cv=none; b=T3RjpTBekGxUytEe8Pc5/eOsg6VwVnQnCDFrLJRYy3acpU7u9q1p5kzeop/rx+HUgvXX8quULUVBENOik+9HMzhYf6FzqSObNRP/2dyHvbHPbsiCG+HC4BLtRYxG/zDH/1JdAUb1gvKpDA9NzxEBFW6QxJZ9114wF5lfj27srfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151362; c=relaxed/simple;
	bh=cYE5Ot0Q9fm8TsgKVoMSZh81shhBRL4HdSK0jaFZ/fg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjMJBHp7NHP7U1SkdqPOZO6T5ievWGGBulvDW2kIyPVPYJF15vNeGw+HOA2HGScMHo1TPSha4wudTv95Bbzyw3Jo5uKZeTgMu4FJRMlDqUPJ+Muc/wx4WzydB5h3eE4ptvIyG074EqrDM9TA0cv9efbzE5tWFvCrvH2qu0x4VQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLHhOSnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E43C4CED6;
	Mon,  2 Dec 2024 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733151362;
	bh=cYE5Ot0Q9fm8TsgKVoMSZh81shhBRL4HdSK0jaFZ/fg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NLHhOSnnmHVPg1loDiXb8a9X2Di7Y0qaMikfjzDGQd+0kxWUkvHVHVwHk3n+PSjoz
	 4DtJY6kqi3wm+VsjDGKKk+TtVu4BTsa6rKT63rBJQ7nDG1UegT82hyGOEjqDRkt6vf
	 cXtquVpJJ+Xd0BR5W16+wqAURenKZbA0flSI7MXYVFZBXEH8ZvXku+9zv5rC5WI7DV
	 acVirofz6dWEPpfK0d0SxL4cTVIJ3vEvNwj7SYvl/0jJR/FB/W65ndcNwKUkkSESbH
	 9zGnU87QTUNXnLS9Ohx5ohM2ZHZJiVAiD+ZbM5KFNsZWJcE7YEF9swmtgvIm0jD6AF
	 S/XwNwtzV713Q==
Date: Mon, 2 Dec 2024 06:56:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: 'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
Cc: David Laight <David.Laight@aculab.com>, Oliver Neukum
 <oneukum@suse.com>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Greg Thelen <gthelen@google.com>, John Sperbeck
 <jsperbeck@google.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Message-ID: <20241202065600.4d98a3fe@kernel.org>
In-Reply-To: <Z01xo_7lbjTVkLRt@atmark-techno.com>
References: <20241017071849.389636-1-oneukum@suse.com>
	<Z00udyMgW6XnAw6h@atmark-techno.com>
	<e53631b5108b4d0fb796da2a56bc137f@AcuMS.aculab.com>
	<Z01xo_7lbjTVkLRt@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 17:36:51 +0900 'Dominique MARTINET' wrote:
> The new check however no longer cares about the address globality, and
> just basically always renames the interface if the driver provided a
> mac ?

Any way we can identify those devices and not read the address from 
the device? Reading a locally administered address from the device
seems rather pointless, we can generate one ourselves.

> If that is what was intended, I am fine with this, but I think these
> local ppp usb interfaces are rather common in the cheap modem world.

Which will work, as long as they are marked appropriately; that is
marked with FLAG_POINTTOPOINT.

