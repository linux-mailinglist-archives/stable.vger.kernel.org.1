Return-Path: <stable+bounces-28297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B6F87D9C4
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 11:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84EFB20FDA
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9FD17565;
	Sat, 16 Mar 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsnX+/yC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89747E576
	for <stable@vger.kernel.org>; Sat, 16 Mar 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710584975; cv=none; b=kPgwDyjHAAHZVD/yxL44J/eFRce4y9/f7TIiwzQ342ph5luZ0nkAoxkPtSTYQrsl1XE81O4WkTu0iia1qj9GPEeiZPUibfJzpnd12psYoyUs6p1QDPOu6d3xIniP9Mf7EmFtMHkrIov6D9xU/6owmj5XVOgGybiXrHfa9/wENl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710584975; c=relaxed/simple;
	bh=LreSPlSFZ/tG4t5kcBIsr1wPZn0LtHoHa1btDJMQgz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjMyO3wYbjtu3BDtDK+I/u4eg580exQPylTuK1WawAej6K4ZF81gfBRzU/fx2IYeZfLwXsra0axA1EG4E6Cke4sN8ptNrEJo7QeX5/v6edgziZE42GL55ebfvBzODFCbzF4dQmnR+lQnNx7/0IWKdRxCjj45OnkjC+FWPgFtBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsnX+/yC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD315C433C7;
	Sat, 16 Mar 2024 10:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710584975;
	bh=LreSPlSFZ/tG4t5kcBIsr1wPZn0LtHoHa1btDJMQgz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsnX+/yCcSmLK64MGggnFHeKpBu2zPMguTQerbExHX43WakBUmLm2vUIz9jJeqOEL
	 I/S8Trn9uOlf6d3Ojx8zkU2vDLcOAixdZBmeUdY/SWcNMoJ4nIPpTLcg4sNrLaM1nf
	 cWCUytBL/yupR9SnulUWTeTuma28eBEBn214Vm4C7jfa249/tIqiMcRbhRigkhIzRg
	 7clfFNNGrxHpHo+5qaKkoNJLcWgwHwzitkMF2+8Q8azqd/qvQOetttldh1P+MshxIL
	 DDVuu7pUeLDkhbFf91hhtDLtwoi7C/tLrouAw8Q6nkO76YK6P+v3+s01YbJlYILJmU
	 ukH95FIvi0RFg==
Date: Sat, 16 Mar 2024 06:29:32 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@vger.kernel.org>
Subject: Re: Fwd: [PATCH 5.10/5.15] io_uring: fix registered files leak
Message-ID: <ZfV0jLKso1CF76sf@sashalap>
References: <3f17f1d9-9029-4d03-9b0a-9c500cce54e9@kernel.dk>
 <18c339f1-cd53-4939-aec1-04dbd50f7789@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <18c339f1-cd53-4939-aec1-04dbd50f7789@kernel.dk>

On Thu, Mar 14, 2024 at 10:15:18AM -0600, Jens Axboe wrote:
>Hi Greg/stable,
>
>Can you queue these up? Two patches for each stable kernel, all named
>appropriately.

I'll queue it up, thanks!

-- 
Thanks,
Sasha

