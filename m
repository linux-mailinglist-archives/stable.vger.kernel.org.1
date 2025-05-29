Return-Path: <stable+bounces-148058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A705AC7918
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 08:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897CAA607AF
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 06:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C202566E2;
	Thu, 29 May 2025 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SBhAqlmI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365792561B9;
	Thu, 29 May 2025 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500604; cv=none; b=Md9oPsbp5PbkDRUOzBAWcmNDINDQNTmvhJObX0aXO9eFKoXKXF5QhUojeMKV7rSAppojUcN9tFa8o8ym5nKuTL1/gALMNL2nxvFxxuzjAsgvWbEtSo4ruwcu8w7ay3c+E7mMqG4MHqj3HHqamq8JxhMzx5ZvBpwZISRGdSYwUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500604; c=relaxed/simple;
	bh=GGqlCUz21l03/tnw7xm8s0ZwD1otA5LapH9Ieruosbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1nVZKT8+F+7Tdny0Td82MmzIpa9CMoJUPjzr5BFY4Bty27i/VDp3JrL6l1ls+hyUE7yIX1bC5Enp1DPDYxUiDjIcMc7lOd9N+TrLPW5NDtOPpsWCi/xS8mUQINLXatZZgUqKQv8NXzqZG2bTpv0mlFWbu9MlooFH/z9Q0pw74Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SBhAqlmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5739FC4CEE7;
	Thu, 29 May 2025 06:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748500603;
	bh=GGqlCUz21l03/tnw7xm8s0ZwD1otA5LapH9Ieruosbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBhAqlmIS8U0L9HBV1boFAwXBqSQQuuONR1+Od0x+byBckHrhlR78nC/0OdmD8GOw
	 vXH2z/LVQ2bHDIk+5vKODRBlwiPBJ2km8UGZkWXbQZh7HWOA+NRN2UN5LyqJ9UGBVg
	 jiS0wXmDMFjuPn5BEaMiQ8xN0UO3hGj/vAh5wm9E=
Date: Thu, 29 May 2025 08:36:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthew Sakai <msakai@redhat.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Ken Raeburn <raeburn@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14 588/783] dm vdo vio-pool: allow variable-sized
 metadata vios
Message-ID: <2025052928-manicotti-doing-9fbe@gregkh>
References: <20250527162513.035720581@linuxfoundation.org>
 <20250527162537.082726404@linuxfoundation.org>
 <ddd366de-3dc5-40af-bec5-9edf0c0720f7@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd366de-3dc5-40af-bec5-9edf0c0720f7@redhat.com>

On Tue, May 27, 2025 at 03:08:39PM -0400, Matthew Sakai wrote:
> 
> On 5/27/25 12:26 PM, Greg Kroah-Hartman wrote:
> > 6.14-stable review patch.  If anyone has any objections, please let me know.
> 
> There's no reason to take this patch for 6.14, it can just be dropped.
> 
> This patch adds a new interface, but the subsequent patches that use that
> interface are not being backported. So it won't hurt anything, but it's also
> useless in 6.14.

Now dropped from both queues, thanks for letting us know.

greg k-h

