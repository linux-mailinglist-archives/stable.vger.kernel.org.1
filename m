Return-Path: <stable+bounces-73074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A652096C0B5
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D201C2281E
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D07D1DC1B5;
	Wed,  4 Sep 2024 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SoGoDrFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0E1DC1AF;
	Wed,  4 Sep 2024 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460415; cv=none; b=uzvI4606otfUrbq+tYhBcDOHE4HnCVqb0gRFojklpCUZQGydjyqXHFC/G10Qfbr1fF8Y5iDNdqKQ3Fc1VeRtmSuL7iUlgVLTTQCpafMqDOHHurL/yGy7fExLNxvjiJnDplm+DCO4bjDsh4YmmTN5yTFkSCojU1nGMw6dEARdP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460415; c=relaxed/simple;
	bh=ctp0CF6Z9/VL+pQf/KJdCo2bk9BFLCaFgnO/ngxm5AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLVp35uPnpcioPzlCsCALhIgyx/nYJ4Cv4fivB2bE/w3hAYF5kZwMriRDlrOA3zRme8YfDH+VPfE82+9KvjfnEnToLfuGrt6SmLUfqW2/LIb0fzQW3fyh7kg1hNmq4xogpSZMQJumDjPbBes5Uu/8dkpFYyV6ItunzlMczxj0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SoGoDrFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B63AC4CEC2;
	Wed,  4 Sep 2024 14:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460415;
	bh=ctp0CF6Z9/VL+pQf/KJdCo2bk9BFLCaFgnO/ngxm5AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SoGoDrFRld/PnQNtv8tQ55AdJOpycftxWhTRZkiAC3QY4R5qvjv3kiQbNie87Khoj
	 geF5+on0wXxgOP9Ma6zW7VMrjXeqtnc69clkkIx4LSmKgxFyOEgkWKT22mWcVyTMy3
	 KL/7AD9hnuBHbSyEnpUz6SBThtsDgjOYLGlbcrXc=
Date: Wed, 4 Sep 2024 16:32:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] mptcp: pr_debug: add missing \n at the end
Message-ID: <2024090452-remission-unpeeled-ddcd@gregkh>
References: <2024083020-quickness-xbox-e6f7@gregkh>
 <20240904110926.4090424-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904110926.4090424-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:09:27PM +0200, Matthieu Baerts (NGI0) wrote:
> commit cb41b195e634d3f1ecfcd845314e64fd4bb3c7aa upstream.
> 

Applied

