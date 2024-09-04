Return-Path: <stable+bounces-73085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB696C0EC
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C631EB2B9AD
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE4D1DA2F1;
	Wed,  4 Sep 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XkgOQEz3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D791DB55A;
	Wed,  4 Sep 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460663; cv=none; b=CZiUAPeckIQRYtIGwcPETzoJoZz/A7rep7ri3+PIw5w0IO0L/7AQhz8DHxR2FQVSrzDq2G8UgHt5yo5TPYvW7p2sJ82ZzEJADLdKq8J0JgSLKlbvxFooEkKf8kTBEGG3vX4FiYDLmVKux/vkSkIL/GB84ap7QHBSumXOmr7Ic8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460663; c=relaxed/simple;
	bh=/6Kk2snAA69282+jf5obFBccOT+dpx3btBKUavS5LA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJfRQPN/WzBiSvjsP1yRw+1Ijrhn+Aj9q3o861a9GknffRJE0qhpf0ecFiKvtzLQ8xu8eHOx7T4n8mtnvPGHdMQUoiuYxYxy1EcSCNxlMAWyrjUGUSyuv6IdKa5zkLMFphSJJ6/4v4dewS0k3gZQuGJoStE3PC99jTjahzIMW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XkgOQEz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9EFC4CEC6;
	Wed,  4 Sep 2024 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460661;
	bh=/6Kk2snAA69282+jf5obFBccOT+dpx3btBKUavS5LA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkgOQEz3dPdhvv60XEhHEH6+9m4z2Q3GMZwX1Hm/0dgg5lZxcqb7sIMJUUkb5Jm0Y
	 GFZfcdHlLKNr3MWZfwE4+eSGk79KO6ooCtuOYlAECsYrurGW3Mlj8rkelQJqbsphgh
	 DzirGvzNJJMxL0IbDvCO6u6EFVoO5rCZX1kgjuZ0=
Date: Wed, 4 Sep 2024 16:37:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: cannot rm sf if closed
Message-ID: <2024090433-deviant-chaperone-50af@gregkh>
References: <20240904111548.4098486-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111548.4098486-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:15:48PM +0200, Matthieu Baerts (NGI0) wrote:
> commit e93681afcb96864ec26c3b2ce94008ce93577373 upstream.

Applied

