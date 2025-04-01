Return-Path: <stable+bounces-127290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C8DA774D9
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 08:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5197B1663DC
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 06:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD06E1CBE8C;
	Tue,  1 Apr 2025 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="efeKcHw8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7013BBC9
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743490788; cv=none; b=Wwog6PmF47FlMdRCrVJ6aJTGsuP6R8aeBOWbh+7zSng+cdB7QYHIIgabWNXPQYf45VUc1U08dEz5x3DV3huNQL1sL3L8+dQ77TajwwbQje0yHJyzmRx89FllbhALC0D0hRCOJzhUdC1xIUCTHGVh6t6ultX+S5z2zs/OWzrFEoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743490788; c=relaxed/simple;
	bh=59H+ZORauW6muC8w3y908XxrUhtVNPAe5WrZrGIoHBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ljxx1pcAD2jDDGImqc003S3KpeUjXrY2e0Tuw0YtbY/L6txSTnk+cWDUiWsiIFYLdwFp+YAmWc8V/A1cLV9lVbiVMhVwvwAGsAXiGwi2LT0nzyss+wkabCuaYqJEfjgqWtMyZrSDJ7j0jiEWDcy1gaN+WdFjXQroHE0/v2Vch0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=efeKcHw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3878C4CEE8;
	Tue,  1 Apr 2025 06:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743490788;
	bh=59H+ZORauW6muC8w3y908XxrUhtVNPAe5WrZrGIoHBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efeKcHw8cJXUxNV9RpNZS0BKqfN7MmXuXW8lLAm/lGTe/7sF70vgqAQknepuKSAyE
	 3l78O6E2rSgNLpMaRR3G4hWGAHi39u9SpET+ICfXJI7sKEYcg9tJULEUsmpmRGev2d
	 u6i+VBGH2KgvRgt0fWPcs28nLUFlSfzLSbqCABAc=
Date: Tue, 1 Apr 2025 07:58:21 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Kang, Wenlin" <Wenlin.Kang@windriver.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y 0/7] Backported patches to fix selftest tpdir2
Message-ID: <2025040149-polyester-coronary-45dc@gregkh>
References: <20250324071942.2553928-1-wenlin.kang@windriver.com>
 <DS0PR11MB6325BD9BB3C4B176CADD0472E1AC2@DS0PR11MB6325.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB6325BD9BB3C4B176CADD0472E1AC2@DS0PR11MB6325.namprd11.prod.outlook.com>

On Tue, Apr 01, 2025 at 03:01:19AM +0000, Kang, Wenlin wrote:
> Ping ......

Context-less pings in html format for a change you sent a week ago
during the middle of the merge window is not going to get you very far,
sorry.

