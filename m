Return-Path: <stable+bounces-73935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3E2970A1E
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 23:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7745F1C223DE
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 21:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7A3139D1E;
	Sun,  8 Sep 2024 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lDEf8crR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0729191
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725830180; cv=none; b=PoU6musnx/HksFnUMHcXWlIjCGhxDX2BhX98wBFrv2pmKUaxRSvF1xWTQt2gObDJhNlk8c/8akmTJzHgcFvguqzOQOb68cs/i4+Y6i0tAJ7UHMa2UDzzQH0jMFpKdby/1En5VbHZEmN0LHpXPPUY9mcnM2TLQMgPB20sezy8k7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725830180; c=relaxed/simple;
	bh=mZfw10enD+CG8qirkwrsrBVOZInk9QSrGmM7TFZPHGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvXa0YFuQGTAnKEtlr+4B0JTl/daJi2+rOQZS6aAzOQlQLS/bzblGbevNMULSgDwvRRc15ZrA7wgl6gjFW9xCoz9jajDENubxTzpCs9Zlk3AXs1dfALjV1g2Cxmm+v4Cw6YvfIzRUfXH8hI067R7ZbYo/icIa6nU6LKa/Igesws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lDEf8crR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBDFC4CEC3;
	Sun,  8 Sep 2024 21:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725830179;
	bh=mZfw10enD+CG8qirkwrsrBVOZInk9QSrGmM7TFZPHGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDEf8crR46lzhBk2TVgtBtnrZz3/xpB/GX+ELKL+4nAz+nC4M6LbfGi3h2zbmv8V8
	 gXT+DcQgSuanWWT241rHkkI38qPZC2WCM/9Z8XjQM7wCUkPX9ZmMV+KKSSZuINNmja
	 A1bbzzi+2yS51NVuNQ/ylHOTefpfunafSx1vbhgs=
Date: Sun, 8 Sep 2024 23:16:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Larysch <fl@n621.de>
Cc: stable@vger.kernel.org
Subject: Re: Please pick up "intel: legacy: Partial revert of field get
 conversion" for 6.6
Message-ID: <2024090806-cornhusk-junior-a921@gregkh>
References: <20240908202622.u5m6djorugknxfmi@n621.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908202622.u5m6djorugknxfmi@n621.de>

On Sun, Sep 08, 2024 at 10:26:22PM +0200, Florian Larysch wrote:
> The patch "intel: legacy: Partial revert of field get conversion"
> (commit ba54b1a276a6b69d80649942fe5334d19851443e in mainline) fixes a
> broken refactoring that prevents Wake-on-LAN from working on some e1000e
> devices.
> 
> v6.10 already includes that fix and v6.1 and earlier did not yet contain
> the offending refactoring, so it should only be necessary to apply this
> to 6.6.

Now queued up, thanks.

greg k-h

