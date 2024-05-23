Return-Path: <stable+bounces-45654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887358CD15D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43508283622
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A571487D0;
	Thu, 23 May 2024 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qPXoTi4M"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DE413C8FF;
	Thu, 23 May 2024 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464332; cv=none; b=bGpLQzMr1BKw+fhqIRLzQ+ob/EUmFJDrDtVQH6IW1Jrn3gXCbC2QElmoi2JTvie4YaOkLzP+tutyfLqgPf9d9Vn3X8wBz4A4lPBGDMbWDxmusjQlJGSgdISEwtquEHfan/Ee5/RcDbLU8psh3h4Yu0g3sz4q1mA7bdixh7LNXVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464332; c=relaxed/simple;
	bh=t+BMAGgGVYWb3TWQl8dOTOj/tYR/7eTfx9+KgXq0piQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds5gc86G2yhCTH8W3MQVsFmN1Sjpij9YNiklmHFNoT7dGGOjIUuaZtNUNm/8/0Thtoa297ekV7L+QiX08SIznRzyHbEEf4+GMtcwQJkq/OjMeBAcrm+FfGp6KHGnJymP/rwFmB/vFVz+/PiqTvpK33ZptBNiwfQOTsGryvkl/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qPXoTi4M; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 08ADB14C2DD;
	Thu, 23 May 2024 13:38:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716464329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UPBUNrmPRgLZO1cfVnj+pDwyoFMA4AC4qyOLHtYS/U=;
	b=qPXoTi4M5WqOx4aD34L9/u0oiRq3brYmaosDXbfCMPkcLS3C/dyS192+PWfzC3i/yeVDuG
	z0PWX9QmDAIV/Z+ZkIyyu3gsJ4DfJ1hLH+VDsDZKTQYaQH94XpFs4WaThXbsjGxINShYvO
	J0ZOHrDWqqRtKsgqHeoZojJ89egyCKwMU7ylorj4jQ5smfLxnXMuttJVtFsp1MFRmvlk3d
	yIng+CYdkxqJlHyHiW+m/+P6dE2b2rYydH2zx5I5YAoiLlE4QbuhYoXuc4ytmJ8mlbHmp4
	IkAnWkg4TQL8syWa1H2eTuNrmdMuFJ/O7njTWYZQ5YmkmP5lotgIjN3/mHtSPQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1a78be17;
	Thu, 23 May 2024 11:38:43 +0000 (UTC)
Date: Thu, 23 May 2024 20:38:28 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>,
	Jianyong Wu <jianyong.wu@arm.com>, stable@vger.kernel.org,
	Eric Van Hensbergen <ericvh@gmail.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: add missing locking around taking dentry fid list
Message-ID: <Zk8qtPVlhiJOZxek@codewreck.org>
References: <20240521122947.1080227-1-asmadeus@codewreck.org>
 <3116644.1xDzT5uuKM@silver>
 <Zk8MAFAWIUPlhGFe@codewreck.org>
 <2675095.dNBKFZOyUv@silver>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2675095.dNBKFZOyUv@silver>

Christian Schoenebeck wrote on Thu, May 23, 2024 at 12:05:44PM +0200:
> > I really think it's safe, but I do agree that it's hard to read, happy
> > to move the `h = &dentry->d_fsdata` inside the lock if you prefer -- it
> > compiles to the same code for me (x86_64/gcc 13.2.0)
> 
> No need, you can add my RB. Thanks for the clarification!
> 
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

Thanks!
I've fixed the typo in the commit message and queued it up in -next,
will send this patch and the trace uninit fix to Linus early next week.

-- 
Dominique Martinet | Asmadeus

