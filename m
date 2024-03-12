Return-Path: <stable+bounces-27516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F2879CCF
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 21:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4511C21348
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE468142907;
	Tue, 12 Mar 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="ki+OoF2p"
X-Original-To: stable@vger.kernel.org
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [116.203.65.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52188142908
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.65.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275137; cv=none; b=oQ+wa6KvaPe65cYlq6MgKIPVHA3B7HsxP/4QaJ7EzixXrPTJa12iC6MJKMFzTIklIMKhjXQBWUqPOI6wCYo1pfPJcAcbXbMODmRUxhuppeadddplwCzvXUx7t7dZZrCvLCVqQWOO71+CVlrwFQnbGYrZUy9evsM9TDGSeYdReFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275137; c=relaxed/simple;
	bh=twDyd8XtyARuIynyt/yejmxOwEaYl4mikiQ2nZ8ASxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTYPM6VfJUYMspvKg9tWvfDWubkB4Nad/s08G2l7136PnOKdCvQgIM2aq78Bl2iYJZOaCpmB3dB8DAOSA/RbOp7RDW/efDPwgB1yswaOCRFUSH9BvYGQwJCx4zv3gGNqX6Ec/JBMBV6sBLQrud129MVUUz6RakGWnmJVOuijYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valentin-vidic.from.hr; spf=pass smtp.mailfrom=valentin-vidic.from.hr; dkim=pass (4096-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b=ki+OoF2p; arc=none smtp.client-ip=116.203.65.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valentin-vidic.from.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentin-vidic.from.hr
X-Virus-Scanned: Debian amavis at valentin-vidic.from.hr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=valentin-vidic.from.hr; s=2020; t=1710275127;
	bh=twDyd8XtyARuIynyt/yejmxOwEaYl4mikiQ2nZ8ASxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ki+OoF2puXZq6Mpv1iu4UgHO13gCDE8cGFD/nACB76sA+6nIVURpjnJIyORYvjr4V
	 gmikO6JWjwlOTX6wfOtyM2mbBnI9avBl05b2XbA6oSnlZcuCNA6zMArTwSYzmreEPg
	 tT7qhCAIWWWc0GHGiDX9LzCdyI4AZ3K/213dImwqRehAvjDvO0/n+6S7LePTNM9HfS
	 /OqP4ZlN2eEX83mcOc3JSFOOHbr+g4rZZ/fgdiSvP3nn5YvwCOANN5oAcaUlKXsiJA
	 hSA2eDXkNsOV/9XLzqdwmvV4u17kIwj/Iq2uX14a6iH/+GBxP7ijPyJNXYwVptZypP
	 K+SigrmqU0DHpgRwK91VjWR+fz8Kt5al1r3WayYPaHSAZXlUHlrIxKlJmMYGAeJ35u
	 HQkVjWgY7u+jHgutLfyT7ps1DL2H7VtA8j2t0PkJ/zUeTuaq2Y9E/uwbENmTbOX96X
	 ajXWHkixNop+bwcabDzpBMisv5++fSn1fBS/qrcTI2wF6zh/Lfe8T5rMXP2dBuH9g8
	 OsJdqVGKLFs4UAoaKPivZE7ScbCz1F465VboWLUt+JPbzyRu4FqE4IZssl7/eqLZS2
	 Hbb5BxClGplTZCl76XZasIAuTqViXjmMIaEy7tqSRKpSJJEoXTt5jjqt37JnLsb5v2
	 GpRDBlBZgscz8Hf/A88SoGYA=
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
	id EDBCA2D2EF; Tue, 12 Mar 2024 21:25:27 +0100 (CET)
Date: Tue, 12 Mar 2024 21:25:27 +0100
From: Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To: Alexander Aring <aahringo@redhat.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, stable@vger.kernel.org,
	joseph.qi@linux.alibaba.com, ocfs2-devel@oss.oracle.com,
	heming.zhao@suse.com
Subject: Re: [PATCH 2/2] dlm: fix off-by-one waiters refcount handling
Message-ID: <ZfC6NxRpmAFSNg79@valentin-vidic.from.hr>
References: <20240312170508.3590306-1-aahringo@redhat.com>
 <20240312170508.3590306-2-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312170508.3590306-2-aahringo@redhat.com>

On Tue, Mar 12, 2024 at 01:05:08PM -0400, Alexander Aring wrote:
> There was a wrong conversion to atomic counters in commit 75a7d60134ce
> ("fs: dlm: handle lkb wait count as atomic_t"), when
> atomic_dec_and_test() returns true it will decrement at first and
> then return true if it hits zero. This means we will mis a unhold_lkb()
> for the last iteration. This patch fixes this issue and if the last
> reference is taken we will remove the lkb from the waiters list as this
> is how it's supposed to work.
> 
> Cc: stable@vger.kernel.org
> Fixes: 75a7d60134ce ("fs: dlm: handle lkb wait count as atomic_t")
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

Tested-by: Valentin Vidić <vvidic@valentin-vidic.from.hr>

-- 
Valentin

