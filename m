Return-Path: <stable+bounces-105241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7329F6F6F
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA751891D0A
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2066E1FBEB6;
	Wed, 18 Dec 2024 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGlNYo1f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D574A35949
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734557230; cv=none; b=pZ1+Rmx6EEqa2985/tkv11IrV+U5237hB+Sj+jZvgy8TdYqFpmeomJbguJroCc3IkeGOGSBsFsxPYwKdPRCQKRe9yhcZ2RR22W8G7J0hyzJ1tzKfA3+lh0ktPiEvbSe1IkI9IMtGgt2qfHVGCG4lfl0o+8fg/oAuJ1wwX8eIZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734557230; c=relaxed/simple;
	bh=eb1zZP6XCNfTXM0rxScFXNSHEVFrB1/Mrh78Lv8GZlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOLqlI49LH9FtUsJqsrCh1QTPWJhlF10dbWRBVGClXVRu4OylgMru0r1cfu71Q9YftQOlNGfw6XDXj+SGZqVECANYCJi6728sw6Gct/PeP+JtPLROpvWfQIDcTOB7ooLajPTV01CVuNgWmNR6RarNoKpv7/bxyVq/ucwl/nliHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGlNYo1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AC6C4CECD;
	Wed, 18 Dec 2024 21:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734557230;
	bh=eb1zZP6XCNfTXM0rxScFXNSHEVFrB1/Mrh78Lv8GZlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGlNYo1fyBS/RF+ho7RSYQi33LTUOBZOGZgrAXWuLFzhwRcnCKDFcUuhC0dBNVnQn
	 UFgkR9o+XTXIcrXxG7IFYugZcl5ReANXluvK8Ysfy8g/10h5aM/8M1mtlcDK6QX8qW
	 ++TCjEpt88k91weGVlJSngQEbSsnyaqVhq6ALL86tG6KVk5ghLUVTK9zIBm9EshDcr
	 ev6aQkUCjk1/GXINBvCiBx8WeoBa71YoxUSFXU1Rb2jngK4p1Kv7g+IUBu97Vegjq8
	 KQ2dDBQSwImR/snlPu0q8eTuCUWG0fms5wiUxtsNZCbvfpYBQ3J9ShadRhHHcYgCCA
	 HqK7+5PTB5eOA==
Date: Wed, 18 Dec 2024 13:27:07 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: chenchangcheng <ccc194101@163.com>
Cc: peterz@infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] objtool: add bch2_trans_unlocked_error to bcachefs
 noreturns.
Message-ID: <20241218212707.zjli7be5qtamdfkx@jpoimboe>
References: <20241218090507.289846-1-ccc194101@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218090507.289846-1-ccc194101@163.com>

On Wed, Dec 18, 2024 at 05:05:07PM +0800, chenchangcheng wrote:
> fs/bcachefs/btree_trans_commit.o: warning: objtool: bch2_trans_commit_write_locked.isra.0() falls through to next function do_bch2_trans_commit.isra.0()
> fs/bcachefs/btree_trans_commit.o: warning: objtool: .text: unexpected end of section
> ......
> fs/bcachefs/btree_update.o: warning: objtool: bch2_trans_update_get_key_cache() falls through to next function flush_new_cached_update()
> fs/bcachefs/btree_update.o: warning: objtool: flush_new_cached_update() falls through to next function bch2_trans_update_by_path()
> 
> Signed-off-by: chenchangcheng <ccc194101@163.com>

Thanks!

Peter, are you able to grab this one?

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

