Return-Path: <stable+bounces-183357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B47BB89C5
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 07:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF61A189BE59
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 05:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325AA1DE887;
	Sat,  4 Oct 2025 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vqS+TO00"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C319F127;
	Sat,  4 Oct 2025 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759556787; cv=none; b=eZubKPBKprnrbEjB1EejSMbNyCeBkFQ3w4NDknFH0wis8k9JxwX1Tl03ZzILkhth9bdXA63wquMwE6++2H4Oai4oUD55KShmKFzteWt+cLgrsmJvE4uGybujurF5rcTVBK6Qi667sM5XWn5AJGDAeOsWXc/hoNFz7XBCN9ZdNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759556787; c=relaxed/simple;
	bh=lr0JYjIYAKp5wehBATp8ykgGfrMeMLZNv/WG1AhuRMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dll5kkeZfC3m0fkbAzly/RzcCuM2PgesJO4IuTCmWw01+ghRmWpq2/zVqkOejUhB7FUPry3htlhipJc2IOjUa+4Kk+v7CW1dJROlYZwZ8J1vAkDxODoay0S8YT46X2zCWUM6tDEhWv4ETWzXIZo2oG4P9tWzy7hM7bZ/YF/Y3vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vqS+TO00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FFCC4CEF1;
	Sat,  4 Oct 2025 05:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759556787;
	bh=lr0JYjIYAKp5wehBATp8ykgGfrMeMLZNv/WG1AhuRMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vqS+TO005cf5RtqKtS0QxIl0c0e9D6bEgDZHPX7cSfj4a6iC7emNFfTBAt79xuGmz
	 N1hf4MvD9RGrsETWUlcGcKRIh34+NXjJNhq8KDEZ2qqfwqSDmtIiZvwI2ezi1RrMf+
	 2bAozdBCLmkNtjRy6nBAEKzyTsivW2GcAffKUDKY=
Date: Sat, 4 Oct 2025 07:46:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] comedi: fix divide-by-zero in comedi_buf_munge()
Message-ID: <2025100459-say-tabloid-ed3a@gregkh>
References: <20251004011522.5076-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004011522.5076-1-kartikey406@gmail.com>

On Sat, Oct 04, 2025 at 06:45:22AM +0530, Deepanshu Kartikey wrote:
> 
> Hello Ian and maintainers,
> 
> Just a gentle ping on this patch. It's been 10 days since v2 was sent
> incorporating Ian's feedback to merge the chanlist_len check with the 
> existing early return.
> 
> Please let me know if any further changes are needed.

It's the middle of the merge window, I will get to these pending patches
when it ends in a week.

thanks,

greg k-h

