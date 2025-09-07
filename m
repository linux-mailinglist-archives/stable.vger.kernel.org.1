Return-Path: <stable+bounces-178025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A3AB4795B
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 09:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F5A3BC565
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5D61E832E;
	Sun,  7 Sep 2025 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jIJDTOhK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD4EEBB
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757230850; cv=none; b=n1d0wiaA3HOHKv6GAZNHurVKyxNdfg0rnN08j0983ZmwSYXgTeXK7vzWH4qldkPjT/zIYMRqESw0US87eHbp2M/nvmXdIzYPAhog5K4ZPPiBtSZL2ivgsK5528rTPBEThzOTIcbvZ1NjTIOfT5cw51Yqt2bW1Qsc7zOuh3jZ6gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757230850; c=relaxed/simple;
	bh=682GWvt6Z32PM7meDL/zD3hurO2Q8EbIXOlfGHDsyoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmZnKRVhgKV1woMwlHt2k1ZyMBN0bIcgGgMKwCXzSE41OZCrXeA43BpnDj7fg/fOd4J/qfd9PCgT/Plni2U06dFiKoxIHcxUvXXTspxF5ILJF7Gcfb0RjaITZbKZfRIfO6jH2hoJHXGgsYo2AdIBpitnSfmDkcfSXU+yuL3pKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jIJDTOhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0DDC4CEF0;
	Sun,  7 Sep 2025 07:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757230849;
	bh=682GWvt6Z32PM7meDL/zD3hurO2Q8EbIXOlfGHDsyoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIJDTOhKDbufaMrnQy2aD+t8nLKW6aQ1yFfZkhYTrVpUPc8lQct+LDwlBJAHCng4j
	 yl5kRkGt/z+RdKUhdk30ZNbDie+hejsYgNAAqiB9jr1KbMekE/Cd4n+B22mj1XcisV
	 60modFdBE1aF/SZx/J7YR5Mnl42H3HRTuc7SNNoQ=
Date: Sun, 7 Sep 2025 09:40:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, vegard.nossum@oracle.com
Subject: Re: [PATCH 6.12.y 00/15] Backport few CVE fixes to 6.12.y
Message-ID: <2025090727-twerp-gawk-25f5@gregkh>
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>

On Fri, Sep 05, 2025 at 04:03:51AM -0700, Harshit Mogalapalli wrote:
> Hi stable maintainers,
> 
> I have tried backporting some fixes to stable kernel 6.12.y which also
> have CVE numbers and are fixing commits in 6.12.y.

Very nice, thanks for doing this!  All now queued up.

greg k-h

