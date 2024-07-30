Return-Path: <stable+bounces-62811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D594138C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF971C23571
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61C1A08A9;
	Tue, 30 Jul 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LR14OAu3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B864D1A08A6;
	Tue, 30 Jul 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347332; cv=none; b=k+iJal5R9SAd22XrUHaV2/Voqk6mX8D8cNZO0+ambe6yS2z2TIaQ/Rg1KL14Tk8b7PR0bLoGmJhouADWAAn0ngW8gS5Adw7JTkpaF1T/g01cJ9Yptmici+swrkbfrmLcOcLg5DINdBmubhNrdKxTF1VhnAQGp0aYw78fOWGuQWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347332; c=relaxed/simple;
	bh=50BPthe4sjyMCbljPz8m7n3HnAX3N/3AMHCFnXNBzkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFHZu/JSIordwUPto6gT1EjTMua7HMw7ernjVjNiuo2CUYSnluDtKUpjlwtkZRHZUvL7WJhMN0MI6KCFHqXKpYDe0j+LB1eGEaMtwdAHnEumpuELmawpkJi8yvvIaYp72XQExdiX9ZqYgozkVxTG4TNw9AH31MjbgX3PHK7OX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LR14OAu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D6BC32782;
	Tue, 30 Jul 2024 13:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722347332;
	bh=50BPthe4sjyMCbljPz8m7n3HnAX3N/3AMHCFnXNBzkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LR14OAu3Kzze+cpfZNjR5RjxG5xTQ563B+M4KxPtLsl2aw+808Yo1h6r152cFfZPy
	 6F6tpbjf8zHAmUDTBDBr/5rJk1v6gzqNGwkrf2PlmZdyd8ayXJ4zVAULfJb/GzmBv4
	 4GVZ7X46VrGE3/9eKDXV2TtJhxg0kYFhqnPeIG4A=
Date: Tue, 30 Jul 2024 15:48:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Erpeng Xu <xuerpeng@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, hildawu@realtek.com,
	wangyuli@uniontech.com, jagan@edgeble.ai, marcel@holtmann.org,
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, guanwentao@uniontech.com,
	luiz.von.dentz@intel.com
Subject: Re: [PATCH 6.6 2/3] Bluetooth: btusb: Add RTL8852BE device 0489:e125
 to device tables
Message-ID: <2024073043-worshiper-parmesan-8c4a@gregkh>
References: <20240729032444.15274-1-xuerpeng@uniontech.com>
 <91943E8F15E0C1C1+20240729032444.15274-2-xuerpeng@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91943E8F15E0C1C1+20240729032444.15274-2-xuerpeng@uniontech.com>

On Mon, Jul 29, 2024 at 11:22:53AM +0800, Erpeng Xu wrote:
> From: Hilda Wu <hildawu@realtek.com>
> 
> commit 284556dda6fbe73d1b73982215e1e6b13262e739 upstream

Not a valid git id :(

