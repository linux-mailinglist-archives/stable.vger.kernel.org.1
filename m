Return-Path: <stable+bounces-73914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779A79707AE
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 15:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5658B21752
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D01494B4;
	Sun,  8 Sep 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C+Ct7pD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461563224;
	Sun,  8 Sep 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800824; cv=none; b=bmFmDHPrIGw02ioAJhmMAPn3MImCiEwdtKWnroM7ECZYHtoYwDM0oXb9eMFKlRbsuO8tcr1yFfT6cO1muoH4CyYkeaPA2jXkRd8XftDE5AGTbZHd+zRDkiF2pTC3In6zy8V9m/Jp2vc8IbOyh5FtUngQMguElyaTUZ4wFY/foSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800824; c=relaxed/simple;
	bh=UriSX0qWuv42Dyu+KkCqcJvWVqwru2yx6Uczxx+lZbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5ev8COE4TFmq8oMn3YkuU8TaQhd7dvHRvoPPKm9JIWBZrawdeFy8B4tiIoE3Fw6FYX9B+zhCfJp5a5W+HHwKjVVj2KwxVbF13Dneb/QahkrqmBe0rXdDQT1FsH80zCHK3Z+pc1ZnkxwY+6SFEhkiX89Vdb8G1zJKQg2afFGVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+Ct7pD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE48CC4CEC3;
	Sun,  8 Sep 2024 13:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800824;
	bh=UriSX0qWuv42Dyu+KkCqcJvWVqwru2yx6Uczxx+lZbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+Ct7pD1sV6TburUKXa+XmjEvzwfPm/gGevWOwl7nX9+GkOhPexKDZ85zUlzdQdPX
	 eH86K4PmmcRnOsD1z10hHhBI8VZ16fS29fCxkGh0NxBLjV4lOhIBFE4kzNKEqoJ62L
	 tCChkMakMEzWc2Xsq/Q+196BmvTciV55ooot8aZg=
Date: Sun, 8 Sep 2024 15:06:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.15.y] mptcp: pm: re-using ID of unused flushed subflows
Message-ID: <2024090839-passenger-preface-f0b7@gregkh>
References: <2024082642-google-strongman-27a7@gregkh>
 <20240906082853.1764704-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906082853.1764704-2-matttbe@kernel.org>

On Fri, Sep 06, 2024 at 10:28:54AM +0200, Matthieu Baerts (NGI0) wrote:
> commit ef34a6ea0cab1800f4b3c9c3c2cefd5091e03379 upstream.
> 

I think I've got all of these now, thanks!

greg k-h

