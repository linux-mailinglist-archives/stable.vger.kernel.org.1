Return-Path: <stable+bounces-123151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFCFA5B97A
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 07:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E959C1892811
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 06:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E671217719;
	Tue, 11 Mar 2025 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N8GWyhe3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95DA1C3C1C;
	Tue, 11 Mar 2025 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741676371; cv=none; b=CRo6gBI2agdYYe0cylaQL9R6bLArwCps9+spXLINo+rvUmonVtKpjAfRgX4/FDOaujj6GGy6FL8NKZyQnMiedv6j8w5c+JqeqwJdOGQTQcn1ANXmZpy8lr9vsPMRYXcq/A9fPBMTijqWbKIrSsdElgHGMUl1QeH7F1ITh7jGlSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741676371; c=relaxed/simple;
	bh=+qy3os88weZeL6J67prExXZz+5oBn86BhVCuf5i67E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gc40h9GaNrhqce+HecL0yE8hbYTILOaXXleVbtU2l95P3mOJQ3xgpEswMDgRJ1PVr1eRCZqjJnIzU7JoxGL27sZmVV7Mu5+G6kef3Zik5/vf830aZ9ol9ivA/jcLLzPsDjEg+r0pIv3W1+99z0IALJEFUoKB2rkC2piOm7lEETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N8GWyhe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98EDC4CEEA;
	Tue, 11 Mar 2025 06:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741676371;
	bh=+qy3os88weZeL6J67prExXZz+5oBn86BhVCuf5i67E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8GWyhe3OsEas7MImdqJu07utUZtJiujLs+fghyI9LZhv/NQb3aNLphzGYr6b8Mo2
	 EPJb9CGrWzysmO+MTSxyvx9nNCQfS0obztXINvQnNolHOGNE8HOTrc0xnL1z5xHo9+
	 G6/7UYIUM0qYoS0sKmTRH+dsgWAMfnvnJEUxl3z8=
Date: Tue, 11 Mar 2025 07:58:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Cameron Williams <cang1@live.co.uk>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: Add Brainboxes XC devices
Message-ID: <2025031103-spooky-venomous-7a85@gregkh>
References: <DB7PR02MB3802907A9360F27F6CD67AAFC4D62@DB7PR02MB3802.eurprd02.prod.outlook.com>
 <AM0PR02MB3793F5DE28571BED66028FDBC4D12@AM0PR02MB3793.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR02MB3793F5DE28571BED66028FDBC4D12@AM0PR02MB3793.eurprd02.prod.outlook.com>

On Tue, Mar 11, 2025 at 06:54:00AM +0000, Cameron Williams wrote:
> Cc'ing stable
> 
> Cc: stable@vger.kernel.org
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

