Return-Path: <stable+bounces-104024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 599B39F0BD9
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7395E188AA77
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BACF1DF968;
	Fri, 13 Dec 2024 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z7Hrek00"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245731DF759;
	Fri, 13 Dec 2024 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091489; cv=none; b=eOnLQULIVwBUv/TszHq4pJF5bXkDRjm4MCczeAc3xHleS5l17qoG/XQaGQTaAHlsXQ9HKjJHhFYWoBfCVabkOYVvnzDK/xCvdbdgY9Rg7OntHqDCuCubmV1mD7CXpxUSULd/dfsOowRoKjJTerndT3GUFk+Ob5E68obBKJCr6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091489; c=relaxed/simple;
	bh=XRa0NN9ZBGQTVVvZGNqNy2ZYMuXiGE0Xj3UonEHebfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF2sW/nZpI0pTeJdEsvFifv2QUfZFFAnN8e8IZVFXAtHV77YUj19O/x0QGYNro8hVhrW01rm6nmKWktK2Pqpqd0rIUnHTMwsayKVJ60Q23VJGlIwQALGZ8T3u36Xk/0DOrb9iYBeTh2zW6ctkX7I7qVNF9Asv9au0psEjcxwgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z7Hrek00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F95C4CED6;
	Fri, 13 Dec 2024 12:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734091488;
	bh=XRa0NN9ZBGQTVVvZGNqNy2ZYMuXiGE0Xj3UonEHebfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7Hrek00UzzT0IRQQnb4IKAGvpLm8IK/ju3Sds0xiGjarmd0t5oYn9x5UaIBOYMWb
	 VRw2tIXJsPJ19KjZDZke+HF7mFVoQqDLFachlF+3+sKb629BHiLm1QpMar/4TPxbg5
	 wyZtnlUgkRj3z6yDUBwjILSfGPKHoecAwCUxvW9k=
Date: Fri, 13 Dec 2024 13:04:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Brian Gerst <brgerst@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 051/459] x86/stackprotector: Work around strict
 Clang TLS symbol requirements
Message-ID: <2024121337-mutiny-blazing-4636@gregkh>
References: <20241212144253.511169641@linuxfoundation.org>
 <20241212144255.537255677@linuxfoundation.org>
 <CAMj1kXGBhBj0H=vsn7C3POQwhxxqeELjD0+BDi88mySHF+GgEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGBhBj0H=vsn7C3POQwhxxqeELjD0+BDi88mySHF+GgEw@mail.gmail.com>

On Fri, Dec 13, 2024 at 08:41:13AM +0100, Ard Biesheuvel wrote:
> NAK
> 
> See other replies re this backport

Dropped from all queues now, thanks!

greg k-h

