Return-Path: <stable+bounces-133105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5E6A91DF8
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66C33A8055
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDF724729B;
	Thu, 17 Apr 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBW204p0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA024503A
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896421; cv=none; b=QkaC/bC8ZInkgtGre8lz0STFNWVEYgbR6RQ5dI/EkSFX8G2edzyC8e2DIBMp1sWRAt32SWF3OlnWrZRnUbNwskztXnMaZ4LI6/H2CM7tTvdC1sa3iCdlS6uBGB7JaAwcndeI8UNsAgADj3PTnuTaXf6Cf/7dONFEGpBoQClbD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896421; c=relaxed/simple;
	bh=cobK7OBKxPZbEQA3jr13nGMXOOYbZuNKd3Pp5bzkph4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAYU/d1nuIWrjTLj6lD6KFkgDisQt9rDMm7kvXOcp1FO78yu9ps7m9lbHwSufa0C36178FsZkj7xBXu7+ybA2pgRchYzFRe/VWDCdVjSkDz55NcXP/gaJ0UScRP3Ub+DZ5nP4Q04nXocHE46EsK3BbqNrALdH4ZxIT1YNStiyNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBW204p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73347C4CEEE;
	Thu, 17 Apr 2025 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744896421;
	bh=cobK7OBKxPZbEQA3jr13nGMXOOYbZuNKd3Pp5bzkph4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBW204p0X8gSgliUHb/KBPGrIj3xcCPvJABbQ9QH3aa/mTPhG42lMI1YQtcV8jyOX
	 hpcXYutkd+5q1tBY3jDrhh5SIdosThxjp8PbFBlwgV11C3NnBn14kGShtedUo9woD6
	 D4gRsUcmTRDpkEMH7CEdoJctv/xrvycLNIi9sleA=
Date: Thu, 17 Apr 2025 15:19:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Zhe <zhe.he@windriver.com>
Cc: cve@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH vulns] scripts: Correct kernel tree variable name
Message-ID: <2025041758-stimulus-timothy-2e99@gregkh>
References: <20250417113641.273565-1-zhe.he@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417113641.273565-1-zhe.he@windriver.com>

On Thu, Apr 17, 2025 at 07:36:41PM +0800, He Zhe wrote:
> Signed-off-by: He Zhe <zhe.he@windriver.com>

Again, more words are better :)

thanks,

greg k-h

