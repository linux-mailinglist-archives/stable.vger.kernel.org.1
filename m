Return-Path: <stable+bounces-105378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1D19F8835
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 23:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4E716A1D5
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8B41EE7A9;
	Thu, 19 Dec 2024 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1Ez3PI9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D333178F4A
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734649179; cv=none; b=eBskuE4VUC+FGgr19S/ZpyB2hU1GY+dEA3i39JZ3+ni0k3MFm3/nV9cuN9IKZCblad7w9lVH63ldGQ1HJ78LDM8u2SLLDOpv7mic8BtZimaOksQ/dYsXp3Dwj6Qq/ezRJuVy+/FJGXl74mDJB9JFHAJOr62WttKBFp0mKN8p1+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734649179; c=relaxed/simple;
	bh=MqKgAJ72dXKfIytmHorIwx0eff2S32HPHD7mstBargU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBCZVla5Nbk50JXfAs/3mDSeM/9fBiU9rYOFs+mHhAmONNyq3AoJO01pYr3nDWnuzsHJJvesAZQG9WD6mpUHevRKpluRglA6/qmmHgr+DTwP1FKe387YmZIFYbWu2zs/g5f9KebO+Ngo6fqYUXa+Xq5No6W+o03+C1sf7Up17hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1Ez3PI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41092C4CECE;
	Thu, 19 Dec 2024 22:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734649179;
	bh=MqKgAJ72dXKfIytmHorIwx0eff2S32HPHD7mstBargU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1Ez3PI9ai/9KawChthtHPfBDMmnHJ6uDjimflQ/4MmgOZe2n+/SyB2cFk9pz0Ga9
	 laXZqQEpjQaa6sD1rG7qKrR3flRIleOn031EqL6AQOCsbgF7a3E9LF2njuDGOePxUt
	 AGH2tGOsfWWdrqSmhbmU8SUU08lff0dHO0mZkxsQllKEMbv/RiWD4fq+8g+8cJbfj+
	 0skGhfP5oZFzkENi5/wZjZ4DO0Fce68z08Sm5/KyxBZocaSbgfTSNWcPzuX3wslw5y
	 HuWGbwdtkU/nn3Y54RNHEDG0CY1orWKQpQQ7wEI4HQMzMFUT+tQcyaJc3uRQjkLhux
	 yhyeG/sUbj9Kg==
Date: Thu, 19 Dec 2024 14:59:37 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: ccc194101@163.com
Cc: peterz@infradead.org, stable@vger.kernel.org,
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: Re: [PATCH] objtool: add bch2_trans_unlocked_error to bcachefs
 noreturns.
Message-ID: <20241219225937.7jjii4kg4hc3d5rm@jpoimboe>
References: <20241218212707.zjli7be5qtamdfkx@jpoimboe>
 <20241219055157.2754232-1-ccc194101@163.com>
 <20241219225859.fw6qugbyoagrx63a@jpoimboe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241219225859.fw6qugbyoagrx63a@jpoimboe>

On Thu, Dec 19, 2024 at 02:59:01PM -0800, Josh Poimboeuf wrote:
> On Thu, Dec 19, 2024 at 01:51:57PM +0800, ccc194101@163.com wrote:
> > hello,
> > 
> > You can use this new version to add fixes and modify the signed email address.
> 
> When updating a patch, please update the title with a new version
> number, e.g. "PATCH v2".

Also, if it's for upstream, please cc lkml.

-- 
Josh

