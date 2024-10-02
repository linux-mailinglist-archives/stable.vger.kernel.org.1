Return-Path: <stable+bounces-78633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D98698D13D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009131F22443
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C727E19F411;
	Wed,  2 Oct 2024 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D8UobE0I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737C18027
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865043; cv=none; b=blR8JXl7j14MkcuvFOR9ch+lwda+vLgxrcC4D4QOug1k2H2IrFRSB6MVqpJJfVfQqZV2LqT46JPhEV8MPY1C+atGo/Zw8wfklLiVV4z8MKfxgbwRqw+Xi8UzcmLkDl8jt58GFVtjBfm5GxY9a2jMaSkxjqw943omm2cpFdQVYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865043; c=relaxed/simple;
	bh=TcVVJVVcNHVb5F/zfxFteP67KouZyCcD3McH4vqhEII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouphdnXDGtSj66/dfqqXv/SKEfidFhTZmyHOD4FpIFRVbrfSczTw5BSYGHnmWHMAY+kEkyqsPaKuizgTRRO9BiujCe0LY6XnGdY2R7k4Ev7dLooe6MR+Iupn3ElZiQnRNDz4G3NhzjtKDuZRSRDi87YzFbnCy2a/jt9vlDA9jTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D8UobE0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DD3C4CECD;
	Wed,  2 Oct 2024 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727865043;
	bh=TcVVJVVcNHVb5F/zfxFteP67KouZyCcD3McH4vqhEII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8UobE0Izf0QD00Ef2+sGzH6nvDkJlFctUnMfR8G/IhclxYevRCaL9EwBnt8wLaH+
	 hpsZes1rLflp7OqOst8EPg3omFhcbV5UApKWIf7hKYYxr21sVkHJZBi4Kf7f88f6r2
	 210juU0W/Wjue/40Lp+Cbo2rxD7KSnUD6RwafSQU=
Date: Wed, 2 Oct 2024 12:30:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: dfirblog@gmail.com, stable@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Will Drewry <wad@chromium.org>
Subject: Re: FAILED: patch "[PATCH] dm-verity: restart or panic on an I/O
 error" failed to apply to 6.1-stable tree
Message-ID: <2024100204-mammogram-clumsily-4e70@gregkh>
References: <2024100247-friction-answering-6c42@gregkh>
 <93f37f10-e291-5c88-f633-9a61833a7103@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f37f10-e291-5c88-f633-9a61833a7103@redhat.com>

On Wed, Oct 02, 2024 at 12:25:11PM +0200, Mikulas Patocka wrote:
> Hi Greg
> 
> I would like to as you to drop this patch (drop it also from from 6.6, 
> 6.11 and others, if you already apllied it there).
> 
> Google engineeres said that they do not want to change the default 
> behavior.

Is it reverted somewhere?  I'd prefer to take the revert otherwise our
scripts will continue to want to apply this over time.

If there is no revert, well, we are just mirroring what is in Linus's
tree :)

thanks,

greg k-h

