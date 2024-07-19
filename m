Return-Path: <stable+bounces-60627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D41EA937D67
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 22:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A251F221D9
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 20:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886F21487E9;
	Fri, 19 Jul 2024 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iT++jF5G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7CE148313;
	Fri, 19 Jul 2024 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421963; cv=none; b=ncjTg6AUlBoVV9W1yVn/rmAZWmFqhuAp9OU3rUfjPbr5rl2L0gAQsGAICuBKxsO0gMVwKrfi2QEZgEx3v8svINh/fGCubovEiRPkqksSITcTz15Xui4NaG87bi0f8C8opHv5U7s04PH9TFuvddEdIFRmhoUmEborWKa4qeykJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421963; c=relaxed/simple;
	bh=QOK2pCoIQiMzIlHTPXqV+QLCL9Kfe/Zu8kiWpcxuNXY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rYJIehq3vYrU29t1T8ew5GAGCD4rXaikJCwZyIWeITUg8qklC/hAiY4jsOWxxcrAVArNYMz5wbvysMQsRPpn4rw2Vo8j0vorFnW981TNLN1XJ8PJMgoUZqaQZ+FgFIwTrBU6T6GRKvDrZTLDaZ2ubgdHBXNHXt2nWfBXrX2tjeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iT++jF5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A587C4AF0C;
	Fri, 19 Jul 2024 20:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721421962;
	bh=QOK2pCoIQiMzIlHTPXqV+QLCL9Kfe/Zu8kiWpcxuNXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iT++jF5Gdg8P2k+AAs51bMXnWqYpIjAi4CQForo/ieRYvrkLmRHk76goT4NmikmpS
	 Nztb6rlULtBUoJydNfJeg2xIQkOaMxLwSAxnrsmxF5MZ6oDf4aVbWGNTYxAiyhXzmm
	 6ZKx+j0zwmaj5MbO4V56lYTAZEGn28Aur9aXJHmA=
Date: Fri, 19 Jul 2024 13:46:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, willy@infradead.org,
 jirislaby@kernel.org, surenb@google.com, riel@surriel.com, cl@linux.com,
 carnil@debian.org, ben@decadent.org.uk, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: huge_memory: use !CONFIG_64BIT to relax huge page
 alignment on 32 bit machines
Message-Id: <20240719134601.d9c0a61e5a58680868e39ae4@linux-foundation.org>
In-Reply-To: <e4e878901db1336c44ce17939c920119b9912fed.camel@debian.org>
References: <20240712155855.1130330-1-yang@os.amperecomputing.com>
	<e4e878901db1336c44ce17939c920119b9912fed.camel@debian.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jul 2024 11:19:24 +0200 Yves-Alexis Perez <corsac@debian.org> wr=
ote:

> On Fri, 2024-07-12 at 08:58 -0700, Yang Shi wrote:
> > Yves-Alexis Perez reported commit 4ef9ad19e176 ("mm: huge_memory: don't
> > force huge page alignment on 32 bit") didn't work for x86_32 [1].=A0 It=
 is
> > because x86_32 uses CONFIG_X86_32 instead of CONFIG_32BIT.
> >=20
> > !CONFIG_64BIT should cover all 32 bit machines.
>=20
> Hi,
>=20
> I've noticed that the patch was integrated into the -mm tree and next/mas=
ter.
> It's not yet in the first half of the merge window for 6.11 but do you kn=
ow if
> it's scheduled for rc1?

I put it in the mm-hotfixes branch since it's cc:stable.  I expect to=20
send the hotfixes to Linus next week.

