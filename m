Return-Path: <stable+bounces-33918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E53893A17
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 12:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8938B21FE2
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05EA12E54;
	Mon,  1 Apr 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zDcEx9mS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199CFC17
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711966284; cv=none; b=h13J4HBAJdwf2e6YYghb5G46CDthSB1xJyclrarXj+s8qqFXrZN01kiOm6NP+jQpp3W33echoj5he1nYTuItTnkc75Fv/bFi/6ULzKL8WuRKgs68VHk8GadC8QOAQyiOZZf3r3umF1AYK4jxRknvC1DS39FDfF3YslmXJ5BRQT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711966284; c=relaxed/simple;
	bh=vrvwaMEgC2agYhGNqY4MhQfO0KPNx8m612B6WSLAlO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8SHC64dOf3WInRxxAsiKVYNHskkxnTyhVInYdiyoTcelgdRyHBGkpGLcWPVj+bPYE5W5bfu6EnwjQ3pWnzcoO/YjDnBRPRD8oBUPy1fq7YT3aUX4OXb8Gwvh5FpPkDAQD9KDFAjleuGzRTYglHrWiW36V1jL5gpgNYin7NBqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zDcEx9mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1671C433F1;
	Mon,  1 Apr 2024 10:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711966284;
	bh=vrvwaMEgC2agYhGNqY4MhQfO0KPNx8m612B6WSLAlO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zDcEx9mSM9d9jt5l51nxdS6rcDfrCsOtHBPLT3IyD+7O9nsANitUwcQI+SMPeLpVc
	 aUl3UrnjXFIWH+EOqtlQLDqOEV5SvxbTYArVcHQe2KR9WTkwg9gNiesHNuSbuntgcV
	 CXtqvm1RQU7fjFjqcyXQr8opFO8hi7baZt5yUye4=
Date: Mon, 1 Apr 2024 12:11:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] scsi: sd: Fix TCG OPAL unlock on system resume
Message-ID: <2024040114-mandatory-unlined-6819@gregkh>
References: <2024040127-defraud-ladle-60f4@gregkh>
 <20240401091804.1752629-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401091804.1752629-1-dlemoal@kernel.org>

On Mon, Apr 01, 2024 at 06:18:04PM +0900, Damien Le Moal wrote:
> Commit 0c76106cb97548810214def8ee22700bbbb90543 upstream.
> 

Now queued up, thanks.

greg k-h

