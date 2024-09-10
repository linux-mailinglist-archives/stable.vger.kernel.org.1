Return-Path: <stable+bounces-74147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCC972CD5
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015F928336C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AC0187FE8;
	Tue, 10 Sep 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iVO1zV6/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6F339AC
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959017; cv=none; b=uUL++z5XD3U9N3zNYnAXH9rQzNCvmK4YXg1Ib2ANFWn92nH+SUgv614WeNSedZ4Nfi8qiL9IGopxG7u04GlMS9KVfcGyQOJ8359MAP5rDZtIGmpu8h4d8xw9Mj9FzqMoAw1kP5Kr3Kqt33ooGYyeoPXfdKzP9Lnm0kNPDA2r0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959017; c=relaxed/simple;
	bh=IAmZTY+2tPSsYHRg0kAGJOWmzCqA6r7GTWL51BSsmpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWJYhensNxE3KhuAI44xW4QG8JnD6h/fJw2TV0lI71NifIo9t02WANI2lQgsTblvffc7VfWuisSDUtAemjn4vfeHv6qz/RKu3mSxxi0yw21P+rfMqtGje2iGTHvWI9f2swX3UUs3ICfQ+czvXvq1a7bE4eCvhz/Mcq/RemUxbGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iVO1zV6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91786C4CEC3;
	Tue, 10 Sep 2024 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725959017;
	bh=IAmZTY+2tPSsYHRg0kAGJOWmzCqA6r7GTWL51BSsmpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVO1zV6/boyZvwv5gxx2R4syJ7A9+nuKk+iUXo+BNuQGDd2n9TUXUqwpdrBjkKTzU
	 FzVrfhq1d11ZGwovoR8v1FgKC/AVGy8E2rmdyqZKdLCtBef9aed/zh84jp2nN53xJR
	 nzPTb1eowyY/g4UBhxNkckUUiRHlsR2SGdgvV72w=
Date: Tue, 10 Sep 2024 11:03:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: chenhuacai@kernel.org, chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] LoongArch: Use accessors to page table
 entries instead of" failed to apply to 6.10-stable tree
Message-ID: <2024091018-vaguely-strenuous-f8ae@gregkh>
References: <2024091025-freeway-unlocked-8c52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091025-freeway-unlocked-8c52@gregkh>

On Tue, Sep 10, 2024 at 10:55:25AM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Oops, nope, I got this to work in 6.10.y, but not in 6.6.y

