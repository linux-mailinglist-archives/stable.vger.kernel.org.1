Return-Path: <stable+bounces-124922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ECCA68E5E
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1191750B6
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC40170A11;
	Wed, 19 Mar 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uB0FE+xs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9539E29D0D;
	Wed, 19 Mar 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392801; cv=none; b=bKwRq9fVxXPh596bkvzgrsT7tSofHZvohyB033FszNvnlxAJ57mXaBFQtx++D4ndW0XiwJjqfr9hPcDxvJECeYRssaW/VUh3eUdr4oi5AH8Ury4JKtQeYsSZHRU24JCNk/t8QQ85REZmWB13gUImC/ApU3q1DgNr/aMQVigRMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392801; c=relaxed/simple;
	bh=KfSbPz6FmdSUvUw4EVRQf4vOhA7ElneTncradbjmTyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmI+thaTAiNrqQj+YeqKzG1+eh6ok0LO+nc1F71lesJibyOkVoY1WZsKVKv0MrqL9cvsTFP5Dlpn4TQHHmdeme5fngGyoqvK3xQIOj6bu3sjj51xEgTdqnls9jDBCLb5z8Xm+5LfjsJWDJWP1UJEAGD5YGXiajrzH9HRURR80h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uB0FE+xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E55C4CEE4;
	Wed, 19 Mar 2025 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742392801;
	bh=KfSbPz6FmdSUvUw4EVRQf4vOhA7ElneTncradbjmTyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uB0FE+xs6QXpQyRd3pF2cGQ0P9gi2BU6YLWCt0H23wRQdE0UNAnUznNjeRjMV1UsF
	 ikqL130qos3+oN73mEbBkS/+Z/9FPNKvfHXEvFpudy9LHlXbjIiMgr6ox1Nxnep4lz
	 YsiP6ddPXj+utwrl+bPN9pqnx6E+diuPPnhNhxpE=
Date: Wed, 19 Mar 2025 06:58:42 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, wagi@kernel.org,
	James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Patch "nvme-fc: do not ignore connectivity loss during
 connecting" has been added to the 6.13-stable tree
Message-ID: <2025031932-surround-hermit-4c93@gregkh>
References: <20250315133440.904579-1-sashal@kernel.org>
 <edd5aaf7-a6f0-4570-a640-6792ae0c57ed@flourine.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edd5aaf7-a6f0-4570-a640-6792ae0c57ed@flourine.local>

On Mon, Mar 17, 2025 at 09:14:15AM +0100, Daniel Wagner wrote:
> Hi Sasha,
> 
> On Sat, Mar 15, 2025 at 09:34:40AM -0400, Sasha Levin wrote:
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> This fix is unfortunately buggy (schedule in atomic context). There is a
> fixup patch which would be necessary alongside this patch:
> 
> f13409bb3f91 ("nvme-fc: rely on state transitions to handle connectivity
> loss")

Now queued up, thanks.

greg k-h

