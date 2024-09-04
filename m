Return-Path: <stable+bounces-73083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCE296C0DD
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1747B28482
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1D1DC05B;
	Wed,  4 Sep 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uDJqWbJs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691991DC049;
	Wed,  4 Sep 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460581; cv=none; b=phFSjUhfOt+K8dP+0oAFMB3Zhja/YBLA1asOKFH4714/dahfMJJZruxVCddxaF9WZW6UrTdiM5JY55OILFrdOroQMXUQMDHeKT3s99x7naxdL5w+SCXzL3QeUvYpiiVNfCjwpOUvBtkC2c9CkhCJpIH3ZTrt+sTTCt/rK08uBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460581; c=relaxed/simple;
	bh=JscwaFtVgmro38BtO6Os+mT0zsBI+dlxQb/wotG3NSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYiWqxpOBKG5auCZStzkg4te7sUFI+iim23x3VgJRLdm5F4T9mRgN/+NLyknNOAiiEvVO6uEHqe0G9FOh0YZqfItLIEDzwMDbeRV40gPfQo/OElD50eCJrPGYa1Rxy4FxJ4d7F8rnpcQ/qehwQCZI3Ajy89NZhrm/HZRTDg/xCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uDJqWbJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B713FC4CEC9;
	Wed,  4 Sep 2024 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460581;
	bh=JscwaFtVgmro38BtO6Os+mT0zsBI+dlxQb/wotG3NSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDJqWbJsdCcKVdcVDvVTK9veZLhFb3W8tCw/aO+Fexy+o2Bt7Y1eDXVImThprbaqG
	 cLl7/9M7bBH/cXg3F63e5oABfomjUnk+PJ18TRxnTNsBWsDYK2peaeC90Tl/DF318H
	 q2yMvhAdRzXTyqnGEkg+MGFNnZDjtpRUG6VfP1uA=
Date: Wed, 4 Sep 2024 16:36:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: check removing ID 0
 endpoint
Message-ID: <2024090414-wriggle-ravine-6775@gregkh>
References: <2024083009-escapable-arguable-125f@gregkh>
 <20240904111201.4093743-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111201.4093743-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:12:02PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 5f94b08c001290acda94d9d8868075590931c198 upstream.
> 

Applied

