Return-Path: <stable+bounces-28317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8773387DF7E
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 20:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3731F2136F
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 19:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654E81D555;
	Sun, 17 Mar 2024 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oKprQMQQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE61DA20
	for <stable@vger.kernel.org>; Sun, 17 Mar 2024 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710702405; cv=none; b=LCJDCQilGMFUonv/GEB8vyZhwO+aV0Z8fdlEuCsWpdMWoxjFfwhdPLaLIm9AoR1JXS+WchySvYahwnS24VapFXBAsYGtow6z1+JotiYWNbbv8NVtTxPXzU+5doSMKCmNd76OC/aIKpTJjkkd+vuFpLhRXeo5CFIjpvNszwJ+pUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710702405; c=relaxed/simple;
	bh=4XCheST/LKJqWA05qOf2kVtweoQltdhS0rlv54M9EMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avcDMIMWs55JbLoZvuW90etBXb6ghS5jqLSI8DaAvtJCy8/1wM84KHHew9tbMGwIG6E2wMzwU/9uavDFze1o81afufCzCfgbR501KpLiRQyjKQ363W/0nDovcRnc8AUI8Yv0+q6Wpvd29+RIc69pNgDcYHoENTRzhORNQLaN+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oKprQMQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E973DC433F1;
	Sun, 17 Mar 2024 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710702404;
	bh=4XCheST/LKJqWA05qOf2kVtweoQltdhS0rlv54M9EMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKprQMQQG8rrdDau3cbkucyMr8cd5bNgalarHwupTDcBQPEidsG2d6OGyHQpELi8z
	 sO/Qu0Jv0qZCZUOkaIQIg5fwBqJcXenRuXBko9VMmgPjXt13UNGi2Efkeoa3mvtZLb
	 GvOmKGjvWtiEZNFrHfEo8XiYmU0llmAtgHBBYdTE=
Date: Sun, 17 Mar 2024 20:06:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: stable@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v0 1/2] mfd: intel-lpss: Switch to generalized quirk table
Message-ID: <2024031728-stainless-showroom-1e79@gregkh>
References: <20240317010651.978346-1-alex.vinarskis@gmail.com>
 <20240317010651.978346-2-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317010651.978346-2-alex.vinarskis@gmail.com>

On Sun, Mar 17, 2024 at 02:06:50AM +0100, Aleksandrs Vinarskis wrote:
> Introduce generic quirk table, and port existing walkaround for select
> Microsoft devices to it. This is a preparation for
> QUIRK_CLOCK_DIVIDER_UNITY.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---

What is the git commit id of this and patch 2/2?

