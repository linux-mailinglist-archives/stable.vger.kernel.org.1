Return-Path: <stable+bounces-73073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D4896C0A6
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ABD28188E
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E5C1DC1AA;
	Wed,  4 Sep 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zHy02xB1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CE01DC18E;
	Wed,  4 Sep 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460322; cv=none; b=TU/nLQj+vJ4SwLy06F/DePvSSnlY8P5o8vyL00Jhd/76+DtpN3+NymCWnzfdusP1ovoKOSS6oShrWCJOiB3245WaafEl7W+mVtNC1aQAC0q1A7Bm+siZvpiA9jvuCUhYQQu6U/adnM66G0g3lo37yAcLB88X+zNo1yZ8JGFmvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460322; c=relaxed/simple;
	bh=qz0kWeFbaVN/+14ijPiwHkjTqdwdYyY3V1PRG/0trV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1pUBAnLSzLCtVM1ChWlqPO7aA22JydJpa6BBOIrL81XcsyQDu5Gg/DXqJWwX08clCxUwrO/L9H/k6YtSEKu5zpjoybcFm2YzpLQRLL71uLEyqZcT3mD6DhnfwIPns7v4mOwWe2oAvi8nqoa4Kys6InKpsYSrBNePTSQ9TGD2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zHy02xB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15DAC4CEC3;
	Wed,  4 Sep 2024 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460322;
	bh=qz0kWeFbaVN/+14ijPiwHkjTqdwdYyY3V1PRG/0trV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zHy02xB113xkzF8yu+njFmCWAHO97K2PmtdtwO7nJx3PrZhQRcTzOFK8bcj4TbFL1
	 NgkUCOwbWtSxbwlN2mrjECBdeTasZeP24aNDx1eOjHgPalxeBzouX+UGOwN3VIxXGc
	 dg44xUXrYwS+ZsT5YODr8UhwseFQv8AwGii9CAdQ=
Date: Wed, 4 Sep 2024 16:31:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] mptcp: pm: fullmesh: select the right ID later
Message-ID: <2024090455-yearning-liver-5eab@gregkh>
References: <2024082640-recognize-omega-3192@gregkh>
 <20240904105627.4074381-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904105627.4074381-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 12:56:28PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 09355f7abb9fbfc1a240be029837921ea417bf4f upstream.
> 

Applied

