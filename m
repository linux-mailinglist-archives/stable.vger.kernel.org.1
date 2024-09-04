Return-Path: <stable+bounces-73070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A496C0B2
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37675B2822B
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98C21DB934;
	Wed,  4 Sep 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C6xU5ThJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DBC5C96;
	Wed,  4 Sep 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460305; cv=none; b=P/9M6OWDoFcGXyzaPqFzQ0YjFoEoyplHJlNU2cvvbCtB3bxtTTDXcbaHBvs7WSKUvimxmG+Eals+T7fbgzcS/Neek4P0rBZKPT8QstXRS4kehsnIUE7es+VtY0rblLaILvbkylck3H3V6aj0Ja3mwOPH9o7P1s6mgnoR5HgDsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460305; c=relaxed/simple;
	bh=OTq2nKJRnM68UDpMiKPMxqNcg5xUr8OikD/T3OxW0jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+yiWJOFqrJ5/sQeuJBPgNc8tixik51orM5H3I6aaympDSTsntnCfPzXhhvSZI0wzW0Qmgqds8mkwCMEDyFeJU5PdJ03bYzIZxDDZpE4tmYvnxZQQ/jy7jprzv3LZ7MYy35XE/lHuAKvpIllcOwqg1Z+eD/ElEhGCyWqHljPQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C6xU5ThJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB26C4CEC2;
	Wed,  4 Sep 2024 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460305;
	bh=OTq2nKJRnM68UDpMiKPMxqNcg5xUr8OikD/T3OxW0jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6xU5ThJnMIovN0t9xLp5TG+TLx2Sp/amVpWDkkIQ6JrlHYlf3Ni1UjH6McEARS3R
	 mxkyoqDN7P6QLGQgJLKaoXZKKjKFb5p9rtzBXpZErpfR27FG/wyNxbyv2D0RzXlPwB
	 gNrmb6xJdlmvhD60wJu7O+UbKjjVfTnUOYO9lRWA=
Date: Wed, 4 Sep 2024 16:31:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] mptcp: pm: avoid possible UaF when selecting endp
Message-ID: <2024090438-curvy-afterglow-7d1c@gregkh>
References: <2024082656-bamboo-skinless-9366@gregkh>
 <20240904105721.4075460-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904105721.4075460-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 12:57:22PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 48e50dcbcbaaf713d82bf2da5c16aeced94ad07d upstream.
> 

Applied

