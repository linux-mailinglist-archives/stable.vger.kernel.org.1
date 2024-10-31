Return-Path: <stable+bounces-89438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D319B8161
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 18:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D42F1F25ED7
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 17:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4731F1BE87C;
	Thu, 31 Oct 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r4ETU20i"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E613A868
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396327; cv=none; b=e3E/VMyEnPosHQ5TRf9PxKHc2i8Kd9e8fRx4MbhX8YIoT51DVY/1lsp7R1AGNxCvL2qeuxuNeceZYLgOlrx6zBGHVDr0j6EF1XQM9yHpNxDpYKdb/8dTnkS2vLH861JFZ2lDkYEpRtkxj+oXlYol1GcGA/EP4Tgc+lhWU/OP9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396327; c=relaxed/simple;
	bh=IPcld0hQKwdB6CsOCHQQhe2GjL3kA7zuCBOllaLyo6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiP+ImwWYbzwoMBVOryPu0vb+JpoLLUXcLNnBecxuQdtDegZH1QUxtYjgbKXvlYDGM1C5PziuOvy2Q9AMK9M9+X8hYrHBHl0seYgq7JmLwcxG/q6PfeFHxY7Rhx9cWqleVrT4nr5uULtNv8FwSm/DJsXSRR32+Ci4abfYclbVo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r4ETU20i; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 31 Oct 2024 17:38:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730396321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcQ8rQtGoaKH20iLsnvPuYRlhz+MC0xyTGQjNl6Q/A0=;
	b=r4ETU20imG2SmMgmEufhZrpAX+ZK+jtIKZZ0O/5Dz0HTQPdNURvk3LRDfDFzkJiykI+un0
	bCgovqGIywpIsIvPLJedMVl+uTyXm7qsmZUQyunBSyV6ckIW6eml10vQjt5XetzgK8Tn32
	BANkx2QgKE8+3zApKgCJ8/fKQVRlngE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrei Vagin <avagin@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Alexey Gladkov <legion@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] ucounts: fix counter leak in inc_rlimit_get_ucounts()
Message-ID: <ZyPAmJqCB7EX-Pqh@google.com>
References: <20241031045602.309600-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031045602.309600-1-avagin@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 31, 2024 at 04:56:01AM +0000, Andrei Vagin wrote:
> The inc_rlimit_get_ucounts() increments the specified rlimit counter and
> then checks its limit. If the value exceeds the limit, the function
> returns an error without decrementing the counter.
> 
> Fixes: 15bc01effefe ("ucounts: Fix signal ucount refcounting")
> Tested-by: Roman Gushchin <roman.gushchin@linux.dev>
> Co-debugged-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Andrei Vagin <avagin@google.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Alexey Gladkov <legion@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrei Vagin <avagin@google.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

