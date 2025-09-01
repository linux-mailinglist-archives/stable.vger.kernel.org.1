Return-Path: <stable+bounces-176837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C286B3E219
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 13:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026201A80FA9
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCB53218DC;
	Mon,  1 Sep 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q69e1590"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04D3218DA
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727811; cv=none; b=UGESelCDdlQcPwa6y4VSJSMaczOEdQs41cRQi/OrwPFR4SznFjE7DGnONfUIGvIbt/rLQlkEGq4XvCtHjeBFFA2R+Eg9vnVIKX2cuLl9uVWuZOLMWnCG4gEo3wBNxZc5deYYlmmdiHtTvpFqPca5qUqwfpHw2k6we+O5Rk7Evrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727811; c=relaxed/simple;
	bh=P0RiKDrkmO9V+O3LfToBu407g5za9qsFV/126B/t0XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYl0zL8mNqciIIaquaudi3iNjfSg8UpPY51mQsEozWUWQtayarJ8iF/x62+N9Vs1OH87DUCp+flPM/g1ci58Mo8SWpiZKQgz7Vc9UJCsCGeN+b0eg2Oi2qbKu/zQZo7wbYYgVqo+184grcW+MZXm7UjC1HWp619KQ5fOcVQ9pOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q69e1590; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8C7C4CEF0;
	Mon,  1 Sep 2025 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756727811;
	bh=P0RiKDrkmO9V+O3LfToBu407g5za9qsFV/126B/t0XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q69e1590cDtJPUM3bFNEXVkeVK07MD9CzoZftnolONfx2EtMJgbuf6O3XKJItrd2a
	 X3gwruFEJFVxRqL8W12evdGNPrX9VVI47/yA8tWA1xmDxKEl//VmO4h7Z6W1gP/Wnq
	 mk/2IQwVlC4YyVF6inPG6K6x26piT9k4MlwRFrZc=
Date: Mon, 1 Sep 2025 13:56:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org, hc105@poolhem.se
Subject: Re: UDF failures in 5.15
Message-ID: <2025090140-snowless-mandate-1857@gregkh>
References: <z7j65bmrb4apv63sudegcqaxxxrnja2i4fysjcpiects5gmue4@sapo53pogv25>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z7j65bmrb4apv63sudegcqaxxxrnja2i4fysjcpiects5gmue4@sapo53pogv25>

On Mon, Sep 01, 2025 at 12:20:50PM +0200, Jan Kara wrote:
> Hello,
> 
> Henrik notified me that UDF in 5.15 kernel is failing for him, likely
> because commit 1ea1cd11c72d ("udf: Fix directory iteration for longer tail
> extents") is missing 5.15 stable tree. Basically wherever d16076d9b684b got
> backported, 1ea1cd11c72d needs to be backported as well (I'm sorry for
> forgetting to add proper Fixes tag back then).

Now queued up, thanks!

greg k-h

