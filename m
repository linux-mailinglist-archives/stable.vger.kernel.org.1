Return-Path: <stable+bounces-106167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171CB9FCE0B
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 22:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EC33A029B
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 21:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F311474B7;
	Thu, 26 Dec 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NjgFtiKd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305CA18E1F;
	Thu, 26 Dec 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735249060; cv=none; b=iD+hIC/3RJeCsWIENmquzbJU6eVpqPytfPiiaDffA6Ms6poOIud5l6OokIERdwSJDoAop1dTWrAJrcttricw+vRe+VW9EUPEUxHfjZ6N/jm2RMAN+7VDq4aoxSKKLEPWDYSu6L0bVOFFr8z4hfjIyWvjxHX/v5a9Q8+94pst6MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735249060; c=relaxed/simple;
	bh=jFSXg/wQWBSsQPC8BzuCSlHXutjgx3MstOqNsihgMPk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZsqhFclS55uTc6aH6NqlSTuaxhrc8WrCfpl8Z/5FDNMzWa7B2ENn3sk0hOMyZQ3KDpCrbh9+GQW4/JcyMYXFz5PJBG+NErfhuKGbVXPRyiD/WA1KgCfJBw3BeHKlxdagNa3zb7ZgmCC71HSf7oHoj55DA/5a+G3de7rFA/H5tpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NjgFtiKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E25C4CED1;
	Thu, 26 Dec 2024 21:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735249059;
	bh=jFSXg/wQWBSsQPC8BzuCSlHXutjgx3MstOqNsihgMPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NjgFtiKdcXvr7sD42V8I4vRKoHlp8gn5U4/lu+Rw4on73KipXMxJSYtEMzPCLkWKJ
	 ADm37+1ehhyNJfKHVYytjBi75tH1oGE4LwiSq8K+jDW1JHZLf0ytK7Iulom8QKECNl
	 Xv60gEm1rxyyJMI0RWliMg++UznsghaIJutV6KQE=
Date: Thu, 26 Dec 2024 13:37:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: peterz@infradead.org, shile.zhang@linux.alibaba.com, mingo@kernel.org,
 rostedt@goodmis.org, jpoimboe@kernel.org, jserv@ccns.ncku.edu.tw,
 chuang@cs.nycu.edu.tw, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] scripts/sorttable: Fix orc_sort_cmp() to maintain
 symmetry and transitivity
Message-Id: <20241226133738.36561a6b556550a3f50fc5b3@linux-foundation.org>
In-Reply-To: <20241226140332.2670689-1-visitorckw@gmail.com>
References: <20241226140332.2670689-1-visitorckw@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Dec 2024 22:03:32 +0800 Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> The orc_sort_cmp() function, used with qsort(), previously violated the
> symmetry and transitivity rules required by the C standard.
> Specifically, when both entries are ORC_TYPE_UNDEFINED, it could result
> in both a < b and b < a, which breaks the required symmetry and
> transitivity. This can lead to undefined behavior and incorrect sorting
> results, potentially causing memory corruption in glibc
> implementations [1].
> 
> Symmetry: If x < y, then y > x.
> Transitivity: If x < y and y < z, then x < z.
> 
> Fix the comparison logic to return 0 when both entries are
> ORC_TYPE_UNDEFINED, ensuring compliance with qsort() requirements.
> 
> Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
> Fixes: 57fa18994285 ("scripts/sorttable: Implement build-time ORC unwind table sorting")
> Fixes: fb799447ae29 ("x86,objtool: Split UNWIND_HINT_EMPTY in two")

Two Fixes:, years apart.  This is problematic for stable tree
maintainers - what do they do if their kernel has one of the above
commits but not the other?

Can we please clarify this?  Which kernel version(s) need the fix?

Or perhaps this should have been presented as two separate patches.


