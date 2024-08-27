Return-Path: <stable+bounces-70336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6372960A19
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62AD9282877
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69761B5308;
	Tue, 27 Aug 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1RPc8KYR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D11B5300
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761555; cv=none; b=BQcGbnj1DaHwgNlulwUXNOFr2jilTwI7qS02pIzrYQNqjFluIhvTVCTGVOb9w7Yg4+K/q0R/2exEJH4UAx3ARxVjdB/+JtWKHspr0Cseg729hiqGcFIf7w7BWTgGUKTPfhzuJZn//vBUnOkQ6s2EsapVHisCPd2wWkCZY6XA1lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761555; c=relaxed/simple;
	bh=ok/kM93fm29yr+xF/UEC60f3CL2gS0xO8PNMw4Vaw+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYZAgXlRVR7nQnnfNOYzouCDr3MwBCmJ63hAaXpQYdsN6el1srU5EcSKWKf4NDUUNHlou6YRHbMB9TgNjhr9j6Jj2YsMWbP6dkr7ZTSEVs2IecsgEVyksbrWb4hp2rMV0ZBL0patskJiOWq5jP2LMFmSUuFE7BeztXtvdimsvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1RPc8KYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47D2C61042;
	Tue, 27 Aug 2024 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724761555;
	bh=ok/kM93fm29yr+xF/UEC60f3CL2gS0xO8PNMw4Vaw+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1RPc8KYRBT2pgL4Khjy91RCHmaG8H06HuvlfNkVzWtjFsmx7VS1qLt5Kxto7R9Cyd
	 hDtp+jA2XPS4rNYWbTiTy5dPnpFN6gduOx+SA6/uCC+xXGwbEXZLHd6oseIp1NqAAN
	 vh+0RyJggAfrxkbmW6HYxhAIac7SbeXMbs03H7hU=
Date: Tue, 27 Aug 2024 14:25:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: stfrench@microsoft.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ksmbd: fix race condition between
 destroy_previous_session()" failed to apply to 6.10-stable tree
Message-ID: <2024082744-vowed-distaste-00aa@gregkh>
References: <2024082625-savior-clinic-1a91@gregkh>
 <CAKYAXd_MPF9WiFoOwnPBiPvwMKDjGJ4BX4u-UnGymFM4sp3YMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd_MPF9WiFoOwnPBiPvwMKDjGJ4BX4u-UnGymFM4sp3YMQ@mail.gmail.com>

On Tue, Aug 27, 2024 at 11:30:40AM +0900, Namjae Jeon wrote:
> On Mon, Aug 26, 2024 at 8:38 PM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.10-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> Could you please apply the attached backport patch for linux 6.10
> stable kernel ?

Now queued up, thanks.

greg k-h

