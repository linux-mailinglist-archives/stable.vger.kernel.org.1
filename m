Return-Path: <stable+bounces-196975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1120C886C7
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 08:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEE33B0BEE
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EE928D8DB;
	Wed, 26 Nov 2025 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1orhSFB+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F722AE7A;
	Wed, 26 Nov 2025 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764142165; cv=none; b=L4UGo26zWKmiV7qNwGKsWTC7tEcHXy3sz1CoXRuGUhxi1WY+gTJhrJIJVjaAnTX9+INkk6uygEkLzraWAWjCEQ407TiS4shi8FgQZZ5cKEzJLf/zYZz6EOiJjn3YC6u85IlKaN2JgRvZBMzikk63CS1DepIctF7aNLj4L8L9pEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764142165; c=relaxed/simple;
	bh=sMDC774epwJX9/x8lY8dZ4HarA6ILl6ZHIdd+B1sQms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb/qk04W1b3TsHxqisjIzprXc3aQsg87pf3SQSDIQRlOQRrAn9U9OiEw2ULTakiWdzxhkjSsRfzhDvx9JUFUUVoAzwsPBXaxTs/lIYXSceUJrWhhDsZyu6JfqdSUvuo8YLLSWzL/paLo19VoDZNw93iTrj47MK+uhKQIYPGOW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1orhSFB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53179C113D0;
	Wed, 26 Nov 2025 07:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764142164;
	bh=sMDC774epwJX9/x8lY8dZ4HarA6ILl6ZHIdd+B1sQms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1orhSFB+WFthuo/+DR1CVBHueOnzHccZPSNMTR4A6KZ+/8KQFaB6fMeJp8lGJFjoq
	 9sgVtlRNzwyLtk/vwDa1b23Swbsz7qoBQH3TuHgaojtBzNvFVTT4sRiKZNvzzfca68
	 0p+H6JymsXjd/fNyG7X1YDCyqrwLJ3ZGq5TidSCM=
Date: Wed, 26 Nov 2025 08:29:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y 1/2] Revert "block: Move checking GENHD_FL_NO_PART
 to bdev_add_partition()"
Message-ID: <2025112603-depict-thee-b774@gregkh>
References: <20251126072316.243848-1-gulam.mohamed@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126072316.243848-1-gulam.mohamed@oracle.com>

On Wed, Nov 26, 2025 at 07:23:15AM +0000, Gulam Mohamed wrote:
> This reverts commit 7777f47f2ea64efd1016262e7b59fab34adfb869.

What version is this series?

Always properly version your patches :(

