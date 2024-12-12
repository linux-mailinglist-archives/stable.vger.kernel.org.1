Return-Path: <stable+bounces-100900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D6F9EE625
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 13:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBBCF1889AD3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE26212B2E;
	Thu, 12 Dec 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lHfwwNq1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA431F7544
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004771; cv=none; b=YZLMgL5fLonhTKL1D1XhyIy7GT622XL6+nQ9h50Rw7sBAnOymCqOCgn+rDWJwlS2Md8PptZ/wrd536X8JnfqTlPDcgQuSLos+DZxq9XhDh5yVVcSEn4xcABqxHlNBheFYvf00HHQzRIXVNTA2QO59adwi8CGq8kf8Dd2cyOYTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004771; c=relaxed/simple;
	bh=/mg5mqQPyJIYFGOBSg6c0uGsfDSbn0RSyx0swSFIkd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eByWwBt32WhZegnXRKU+nVCtk9c3195miHU+8RolqAyPW7VvC2b9aB/Wj1+IgUQwtVY3PHP5cJlBgogg3wEvPYih2Qa6hBCrBDr+LxkDrOMuV1doX0rpG1lfZ8xEcjb2ekaa7Y9p5vOM1j5n8iGkZgmapGrirZSFq4WJAJ1vfv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lHfwwNq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9250C4CED4;
	Thu, 12 Dec 2024 11:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734004771;
	bh=/mg5mqQPyJIYFGOBSg6c0uGsfDSbn0RSyx0swSFIkd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHfwwNq1J7PgzlZllPLlQDuS6xIK1v9DfZnZGYY4zqofqgSpMwfag9yDwMM+MhXof
	 eFIQaVaWNFpjoJ6MSPEbYggAhGMYwyj+LYTccp5la+LLwnmUqJ+dzeagHyABDkdUeB
	 /nRIoKptGzOnNF0P+0DZT+2ZLigKy8QgLhKzitoY=
Date: Thu, 12 Dec 2024 12:59:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guocai.he.cn@windriver.com
Cc: juntong.deng@outlook.com, agruenba@redhat.com,
	majortomtosourcecontrol@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH V2][5.15.y] gfs2: Fix slab-use-after-free in
 gfs2_qd_dealloc
Message-ID: <2024121224-effort-gossip-aae9@gregkh>
References: <20241211081023.3365559-1-guocai.he.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211081023.3365559-1-guocai.he.cn@windriver.com>

On Wed, Dec 11, 2024 at 04:10:23PM +0800, guocai.he.cn@windriver.com wrote:
> From: Juntong Deng <juntong.deng@outlook.com>
> 
> commit 7ad4e0a4f61c57c3ca291ee010a9d677d0199fba upstream.

No it is not.

