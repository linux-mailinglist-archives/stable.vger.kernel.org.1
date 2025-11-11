Return-Path: <stable+bounces-193004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1499DC49E07
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C96F04E8A68
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C6320459A;
	Tue, 11 Nov 2025 00:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PlZmJHu+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159D1FA178
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 00:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821128; cv=none; b=I371s/xRFv7g3Lq38jYiekeHuDQM79bAnx/9/ca1+g657TDfZepZQaMr/V8WUy27PAOvrjuzVNerxHfdwk8RVPMigzypyuYQinBN+RazwEQvJNjS0PTYCDjXAiuqrX1dNiva+TW7kkw8Y0w6JIkJYH7CyUfXXqXc0p+LHgH8++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821128; c=relaxed/simple;
	bh=J+hsoF0kwijNG6yZ/jWrt7eten+qUN7pXdix3ETgoSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjVZCjpWlmbCtZyQlfa9b9Htt23Ui8RzFIlo/cw1e8qqhUepeYUAhtbMMXJ+0YuFQ/9FqC6iCl7C1TxiAKNYQYBobJPCQufWtr1tlGSXrTNJcv5PjcCvT26nZ6CsXAtuMMtcT/Clz9hHBexGB3JwuzUzxG1A6eYO8RJ7t+u/oDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlZmJHu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ABCC19421;
	Tue, 11 Nov 2025 00:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762821127;
	bh=J+hsoF0kwijNG6yZ/jWrt7eten+qUN7pXdix3ETgoSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PlZmJHu+v2nnEu2bCg8eMEXhtkk8IuyN3AdW8frv5GU9pbckRck0x7UOpr4oPLvZX
	 B1VJAWgHq94jQ3qQOciCNLiKwCqrgAG0Wx44lBOFJXhvq3dLomeRmOi1mCF/yhpZZH
	 AKjWlVBppOIZCJlceAdQ/4K/3beJvMM1CyPFeBwQ=
Date: Tue, 11 Nov 2025 09:32:05 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
	Samir M <samir@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH 6.17.y] kbuild: Strip trailing padding bytes from
 modules.builtin.modinfo
Message-ID: <2025111149-hydration-moonlike-8f4e@gregkh>
References: <2025111057-slick-manatee-7f63@gregkh>
 <20251110223818.3951521-1-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110223818.3951521-1-nathan@kernel.org>

On Mon, Nov 10, 2025 at 03:38:18PM -0700, Nathan Chancellor wrote:
> commit a26a6c93edfeee82cb73f55e87d995eea59ddfe8 upstream.
> 

Oops, missed your backport, please ignore the FAILED email, I'll take
this now.

greg k-h

