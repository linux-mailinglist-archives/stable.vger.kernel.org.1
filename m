Return-Path: <stable+bounces-73068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E81E96C0A2
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE6A28ADE0
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4781DB93C;
	Wed,  4 Sep 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EKJ76Kj4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242655C96;
	Wed,  4 Sep 2024 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460293; cv=none; b=t6m6Z40I9hP+kguYFCvyJg/Jc/fEGVQoriPfCH+2nLd4NYA7u9THRWLRHvRJIDSGQIOwA341i+36j5mbmu/+mqQh9H/kvqxdLTLQukx9eUuydW2K3FDTN4q1yGx9AukTMmDYEB6GsjKIgNzKkkFvlFVM1bRmnVwZW/tTNytb2Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460293; c=relaxed/simple;
	bh=kLlD5kPSRtACX8muxqZkh8AW6S4kiYITr1sQYcVtTZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFsjlVIQehwzjr1PLmV3MuGaEs90aV7MvGy3cKHmhObvHqV4zKmFDddoqy0xWwWv9kYAjgq/bOJGwE/WGDyM/VnqFyUI8iEIcJqmXGDmvq5U3W2aK5p6EY0zmjcNV1biiJ9BBmCjQp2jBZZKr3SnWFqXDfjomzloKQHUx59bEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EKJ76Kj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444CBC4CECA;
	Wed,  4 Sep 2024 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460292;
	bh=kLlD5kPSRtACX8muxqZkh8AW6S4kiYITr1sQYcVtTZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKJ76Kj47TiaPyd27hQjyjCglj2sOm9NwOa2W4BK0DOvZ5/3KsSlS4MEz0jEy+EKg
	 0gdnx8O7OYJf9be9sf5/8uWBNEnp4/TXjk26mYf1YfrBEDOV/CLNgp237vbyVpVP7N
	 oMAKrszV105hMqUd9cWtfk9uW4vM3X1dWctKh+Wo=
Date: Wed, 4 Sep 2024 16:31:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: check re-using ID of
 closed subflow
Message-ID: <2024090425-supernova-chomp-1d71@gregkh>
References: <2024082600-chokehold-shininess-0f20@gregkh>
 <20240904110510.4085066-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904110510.4085066-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:05:11PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 65fb58afa341ad68e71e5c4d816b407e6a683a66 upstream.
> 

Applied.

