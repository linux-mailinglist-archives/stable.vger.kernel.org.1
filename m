Return-Path: <stable+bounces-114887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D69A30840
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1097A4B50
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E191F3FD3;
	Tue, 11 Feb 2025 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="liIUTY+3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F161F3FC2
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268974; cv=none; b=tkeb1oBsNsm8yxcKSdQXM7OymaGWmf0Lrj7KkFM/28Q+aPPnFJCZmEXSrpN7Wf4ceGXKLu9is8zsCgLh3Me4Qp8NDmA4XXMHX1p5qOSfyV/QTzX8bKaMz72MPzgr3EeDHdh1T7/o/na6qhSqUS8zCDd8Eu9H8z7ZVKsOA2lVYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268974; c=relaxed/simple;
	bh=7ZqtHGTgQlaoWV5JHS4dW2g8wuESDYUux5BetaLKdVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDEjZJ1uiJ445h3a8DscuFii0pKDYLb9NklVB5RBt1mkywZH8dRWiOtvwyehRSdckIvAnELto+7GanpjUE3s2P+3O0nBNLx2aF79qcdEKJMh1tlX2/4UkLOZJah66vJ/PkGv4F/m+ZJ3XbzhnYRUP+uDYlPe5DMqrhDm9vmeOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=liIUTY+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24B4C4CEDD;
	Tue, 11 Feb 2025 10:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739268974;
	bh=7ZqtHGTgQlaoWV5JHS4dW2g8wuESDYUux5BetaLKdVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liIUTY+39H3PSBxu+LBYJWT7+5ZDsDxqQG9OJ5wsnsOspl4qp1DoLEXo0TtvCkcDG
	 0+dp+cG1GsPC+LNqEOGy0UTF2jZvqj4HtUE+qxwvxNn0W9IPD1ZSlxwEoLggICxps9
	 Lh0jegYTjq/amOnO3tXhdhvS6QN8+7pYe7MMUoKo=
Date: Tue, 11 Feb 2025 11:16:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: stable@vger.kernel.org, Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Jacob Soo <jacob.soo@starlabs.sg>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH stable-6.6 3/3] io_uring/rw: commit provided buffer state
 on async
Message-ID: <2025021156-fiction-shifter-3f49@gregkh>
References: <cover.1738772087.git.asml.silence@gmail.com>
 <cb9ec75521cc59ee1ab3119d8d28a8697cd9cae1.1738772087.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb9ec75521cc59ee1ab3119d8d28a8697cd9cae1.1738772087.git.asml.silence@gmail.com>

On Mon, Feb 10, 2025 at 03:21:38PM +0000, Pavel Begunkov wrote:
> [ upstream commit d63b0e8a628e62ca85a0f7915230186bb92f8bb4 ]

Wrong commit id :(

Let me figure out what went wrong here...

