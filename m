Return-Path: <stable+bounces-12218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEBF8320B4
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 22:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0F5289A96
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 21:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897872E852;
	Thu, 18 Jan 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="aayS9Jld"
X-Original-To: stable@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2DF250EF
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705612109; cv=none; b=kbjmDGq5qBh/wU2Ndd7KCLxo0b9/vBkdtw7AIx8d3te7Elr4JPN3j+kFTWx7y42FSIztUTN+APaADW+Em7+PiRNYUrYCxRFZAFewT17nfXrNqHptZ8RQmVKwnv9gbLc/pP3ypUW5FLWKoBJjpkGwJLuMKrm3T/dihbIejuICj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705612109; c=relaxed/simple;
	bh=yoaXCZLTxdcf0hMRY/eUuyi/D4CQA02aZSSApyKwMf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fjYS+Je2AOty/vy+9WGTOJh/eU/jwZHY8CMwPUh+DPVvpkWQ+aMhgRYk2xF/+TMkF+tY857xStHUQfT9Z/UbkaKwNFY4uLdrdlmoLYtkrIuiYecxKaUGHYaHE90OU20vRM2Vn/XPPGVhQG0uS6vbZSLAqjXdKojmYS0+5/RlXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=aayS9Jld; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AC80C7A2D;
	Thu, 18 Jan 2024 21:08:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AC80C7A2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1705612106; bh=fDSeRX+YsPcg2SclbKtEH61vR1ItK45Qc5jXxd2tHhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aayS9JldwHalELvDxuNWpMdrsURvkuAHZHFdqKB/0nU0nqHO1YcYr2W5+Sn6IHd5/
	 shnIiVpsxOMP6cbaWUJG66NIzyG1if/uds7O5ps71kkpu71qfnAePr5rzKDJNKML34
	 KwR9CqoqZPE7FG1+cDD6DWwQCTOjqumkkj9nruJm2Hlps+LmXa6YkmmVHdgefzu+0O
	 KQwBqT9lOJAns4+O+2Q1Oi3vTf751JDGypYVE9x4x8qq3X1pFqzC/zbQsRfvR6tdLs
	 8316iZB1ECs9ntt7FF9HkPjGw6xMQWRN5U2FKLfeCjWoQ1ScgAXnHwx/nSwTeoUUfg
	 nUBkzvmkBzJEQ==
From: Jonathan Corbet <corbet@lwn.net>
To: gregkh@linuxfoundation.org, vegard.nossum@oracle.com, jani.nikula@intel.com
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] docs: kernel_feat.py: fix potential
 command injection" failed to apply to 6.1-stable tree
In-Reply-To: <2024011832-stadium-anew-7be3@gregkh>
References: <2024011832-stadium-anew-7be3@gregkh>
Date: Thu, 18 Jan 2024 14:08:25 -0700
Message-ID: <87jzo6wdrq.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<gregkh@linuxfoundation.org> writes:

> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x c48a7c44a1d02516309015b6134c9bb982e17008
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024011832-stadium-anew-7be3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Ah, this ran afoul of the Documentation/arch/ move.  It's fixable, but
maybe it's not worth the effort to do it; I'll come back to it if I get
a moment.

jon

