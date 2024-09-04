Return-Path: <stable+bounces-73086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40AE96C0E2
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B9C1C22311
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620E1DA615;
	Wed,  4 Sep 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kvm5G1jJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C01D014A;
	Wed,  4 Sep 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460684; cv=none; b=GUooc06nKJ/+FoYE/kcnrNH7FuitkD50qkIFnG6EcIICRYXQTYquQ8bsStJ34baU2L090g6L2SpDRk0THGoeIsO6SvyFgC3xXAYjJA5Kz0e8ZWRbyghGIpYttVNpaYP1KdOVkzHGXc4+M8Nek/4YyTCYFRi2fuu8y04/7oAiMcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460684; c=relaxed/simple;
	bh=BazvklzWbyiNYDXcNbmU8q64MTPt0LIOhDJ+G0rOC7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndXMQWYSIjKMUF9ZNiTn9C8lKuDqNh5J5mj5mZ52GpstZdB/aOfYsqcCdlUpHmRknPx3hJQpDij/930qzHJJdaPIAIt19VDlgOdmx4gp8cJtuhSttWDNezipskvSNboAozon+r0oNwREvegf4HKvFljqaA93hfroS5KbkY9B4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kvm5G1jJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D87C4CEC2;
	Wed,  4 Sep 2024 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460684;
	bh=BazvklzWbyiNYDXcNbmU8q64MTPt0LIOhDJ+G0rOC7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvm5G1jJNr8G5cVlCPyx9riIIzC3psziv7u8Cnd5qXv0riIQwyHjdCXjy+WZf+/bU
	 JYJlGXHMV4Z1T3aOjIjuWU5KSGozZHkpH1iQtyR4+uNSAyA//J2re3OZc3od0EKNFS
	 4YZ8mb/B0fLpLI8u3ueT44V5E+mrwD8GKIROet/0=
Date: Wed, 4 Sep 2024 16:38:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: check re-re-adding ID 0
 signal
Message-ID: <2024090455-precook-unplanned-52b3@gregkh>
References: <2024083033-whoopee-visa-f9dd@gregkh>
 <20240904111500.4097532-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111500.4097532-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:15:01PM +0200, Matthieu Baerts (NGI0) wrote:
> commit f18fa2abf81099d822d842a107f8c9889c86043c upstream.

This did not apply :(

