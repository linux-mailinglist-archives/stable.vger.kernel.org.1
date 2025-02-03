Return-Path: <stable+bounces-112050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AD2A26360
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 20:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02E43A0436
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 19:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1ED1D5CC4;
	Mon,  3 Feb 2025 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QCivfkLX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1431D516A
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610007; cv=none; b=A3634gq05HmRUknAfaCfZI5eTomEOqlV+SkRJHaRU4vni7rPVM1dUDHYDUUivcqOYvCJCQBXcHWt6EWuhGu6+rTreJEvyoIUTC5U3lx2n+Sb69nGnqDGK8rWIgfA9jTcpMk1ILYs3OWzRKe0agoz7Ynq/zH/O1olWe62yYtekQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610007; c=relaxed/simple;
	bh=S1QsEQbF0ofCgIF3XQQ6sVB/qDGdcscPk9LERjUf714=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg9FA60hE5XRheQxVwdo984pbuvtcEkXeI9Bld448pLc5y+3R7+fNf1fI/u4vdyA3IAKpv12C6YgcQnCUP0A7Yq2Gz9Hm0Fw/wrd6SUBPrhxHPavS7eLO/hwFgm1iEVkyXGu5shivK3XnTvVdxa6TxmQ9WMR88cZycyRNLSp6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QCivfkLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993C8C4CED2;
	Mon,  3 Feb 2025 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738610007;
	bh=S1QsEQbF0ofCgIF3XQQ6sVB/qDGdcscPk9LERjUf714=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCivfkLX9w6rB7f1tOK+kWn4k8TPWPnA+rVgylrMW9M9/8n/YuhfImIZof9adVe+q
	 C1jxDCoaC8pry3NpU82jVy7Vzd5S5uUfrsbp/Vq05S4ciLuX8kEJjBPzPsouNjmzcU
	 5ZzeR9DkYtLTOoufW1kU55mqqOsmsW7YK7BjCaCM=
Date: Mon, 3 Feb 2025 20:13:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Shubham Pushpkar -X (spushpka - E INFOCHIPS PRIVATE LIMITED at Cisco)" <spushpka@cisco.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [Fix CVE-2024-50217 in v6.6.y] [PATCH] btrfs: fix use-after-free
 of block device file in __btrfs_free_extra_devids()
Message-ID: <2025020348-reacquire-filtrate-6299@gregkh>
References: <20250203104254.4146544-1-spushpka@cisco.com>
 <2025020310-daydream-crop-4269@gregkh>
 <SA0PR11MB4701319AF5E422D47C4365C0D7F52@SA0PR11MB4701.namprd11.prod.outlook.com>
 <2025020300-operate-tag-f3d6@gregkh>
 <SA0PR11MB470126EB89552EDF95B010C8D7F52@SA0PR11MB4701.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR11MB470126EB89552EDF95B010C8D7F52@SA0PR11MB4701.namprd11.prod.outlook.com>

On Mon, Feb 03, 2025 at 06:45:55PM +0000, Shubham Pushpkar -X (spushpka - E INFOCHIPS PRIVATE LIMITED at Cisco) wrote:
> Thank you, Greg, for your feedback and for highlighting the importance
> of thorough testing. I apologize for any oversight in my previous
> submission. I will ensure that all future patches are rigorously
> tested before submission.

Again, they must be tested AND have a second signed-off-by from someone
else in your company when you resend them as proof of this testing by
both of you.

thanks,

greg k-h

