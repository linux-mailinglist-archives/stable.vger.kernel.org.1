Return-Path: <stable+bounces-164425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD44B0F16D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0EDAE04B9
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 11:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615502E0924;
	Wed, 23 Jul 2025 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f0Cc6fKV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4F428C5A5;
	Wed, 23 Jul 2025 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270731; cv=none; b=i70Rq8MALcKQZ7bBNushu39EkXnZ0VD3uAOYbVBLbAvKmsu/v6x7WbPwjBqS6agkIpqeEOkbWcmP17tI5v7RnJ669MUxdePzXFOueaQz6SmXBZLVtKlHKaKYOXqd9aTqlznAnI3B/Y7Vq2KK7hvzASOpR7Hxwy2r2ZfWIPQ2whk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270731; c=relaxed/simple;
	bh=DylwB64132MBZ4MXvSiKT9FwH5dBSY4xF8gB+INXBQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wxvhg8YRB0dfmdJhg3tUJTQRXTPt4EDWLs3LL9S4/LeAzcnOytWkfoQl10o4LBI+fRore10kye4aeqnsbRxzx08cj/0I0gzU/tnSDCOSFCOgrltrfCgiilI0UcsH4wPW42mrfy2TDhYSpoEi8yeA1swwfOePRunIwGblNzxHCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f0Cc6fKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146E2C4CEE7;
	Wed, 23 Jul 2025 11:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753270730;
	bh=DylwB64132MBZ4MXvSiKT9FwH5dBSY4xF8gB+INXBQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0Cc6fKVHabRyLXfXuVeZvZeMttqI/skUxMqJle9X/2pZo5yUhMXwMF1BvIZvteGr
	 W8EPYdJ4hU/EP5DT5zfHmAgi5Ong1j9xUTVm/5GImHsjUq+YAp4/lzBXTMFRGuCqaR
	 OVGspqjJrhkJimhpwb0Y3pXHdwO5PxmvyrDOeph4=
Date: Wed, 23 Jul 2025 13:38:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Pratt <mcpratt@pm.me>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>
Subject: Re: [PATCH 6.6 111/111] nvmem: layouts: u-boot-env: remove crc32
 endianness conversion
Message-ID: <2025072316-maimed-disaster-8c2e@gregkh>
References: <20250722134333.375479548@linuxfoundation.org>
 <20250722134337.561185968@linuxfoundation.org>
 <OtYC5V_o5aJvujD0QIBYfFMqHJbKopAZebvBnDZ398q36FII2UJGr-gWv2Z-ogM5GLwXLnmHjT0orC0RyuAbvPYG-P-EP82l14gy4pG7H-w=@pm.me>
 <2025072359-deranged-reclining-97ac@gregkh>
 <Sl8R4r1d5VEvkHFZH5VnOWX1hdLmCXgNBy-QeLBTB8tbrzrz4XLmRcf6AS4MxWBzAY0fl8ISERCaTh8hJVDkBgpV5NLjweTQLXKjpm9vyag=@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Sl8R4r1d5VEvkHFZH5VnOWX1hdLmCXgNBy-QeLBTB8tbrzrz4XLmRcf6AS4MxWBzAY0fl8ISERCaTh8hJVDkBgpV5NLjweTQLXKjpm9vyag=@pm.me>

On Wed, Jul 23, 2025 at 10:54:12AM +0000, Michael Pratt wrote:
> 
> Hi Greg,
> 
> I still see it says "moved from" instead of "to".

{sigh}

I just changed "after" to "before", and line-wrapped the thing, let me
go fix it up again...


