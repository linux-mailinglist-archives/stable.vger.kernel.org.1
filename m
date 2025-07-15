Return-Path: <stable+bounces-163040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77193B068D0
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 23:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8915A50158F
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D9226E710;
	Tue, 15 Jul 2025 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g0As/wod"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0B26AD9;
	Tue, 15 Jul 2025 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616168; cv=none; b=XVBrSydo3uzgzPpyzYUoSYGTUfxHq/lBzkioU6CpMUE6RQpWFG5bp4dbAne9A77xedAR7sqaQ5wSGc0BDD3D0kKnpOOtXgVO4WYWFS/oCjDDGlmblA8pDQHCggkpMW+c5hZ15T7eNTraXsho4V1cG9TMmJMYr29jDzpgToooLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616168; c=relaxed/simple;
	bh=trlF5H1bYaM4dSNd149hpjrn6kkLss+dok8sk3g3LnM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=efDlp1vdlgF2gPTlg7EkLxFMsdGHNcEa2OGqx7qGuD26yINo9DkXNMaaX2fxGTzu+n0r2Wzlh0kRo/OWS57lS7QAk8ZbBEaSXlKVz9vGndb/BSQalkRI5poDIzSoKHnItkd39yYxp46aPrpYjSul/387D+L59uP5DwUW3Wd+ZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g0As/wod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788B8C4CEE3;
	Tue, 15 Jul 2025 21:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752616167;
	bh=trlF5H1bYaM4dSNd149hpjrn6kkLss+dok8sk3g3LnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g0As/woditO0fQse77Q8HOkzON0mKGPIbnLkXg9YXDDeJJ/Bc1sTvL4hQRNhpK/9h
	 CzH+FjOgrus4JTTGor4EBVSr6kAAINVr/VN30Lcyer4IpzqtCBVfolnNn0762NYj6e
	 FVp0WTxWjmZgJdF0throkVSeoLeysnr7r83OAhRg=
Date: Tue, 15 Jul 2025 14:49:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Stefan Roesch
 <shr@devkernel.io>, linux-mm@kvack.org, llvm@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/ksm: Fix -Wsometimes-uninitialized from clang-21 in
 advisor_mode_show()
Message-Id: <20250715144926.90546c48efc5f288cfde319e@linux-foundation.org>
In-Reply-To: <20250715-ksm-fix-clang-21-uninit-warning-v1-1-f443feb4bfc4@kernel.org>
References: <20250715-ksm-fix-clang-21-uninit-warning-v1-1-f443feb4bfc4@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 12:56:16 -0700 Nathan Chancellor <nathan@kernel.org> wrote:

> After a recent change in clang to expose uninitialized warnings from
> const variables [1], there is a warning from the if statement in
> advisor_mode_show().

I'll change this to "a false positive warning".

>   mm/ksm.c:3687:11: error: variable 'output' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>    3687 |         else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
>         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   mm/ksm.c:3690:33: note: uninitialized use occurs here
>    3690 |         return sysfs_emit(buf, "%s\n", output);
>         |                                        ^~~~~~
> 
> Rewrite the if statement to implicitly make KSM_ADVISOR_NONE the else
> branch so that it is obvious to the compiler that ksm_advisor can only
> be KSM_ADVISOR_NONE or KSM_ADVISOR_SCAN_TIME due to the assignments in
> advisor_mode_store().
> 
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -3682,10 +3682,10 @@ static ssize_t advisor_mode_show(struct kobject *kobj,
>  {
>  	const char *output;
>  
> -	if (ksm_advisor == KSM_ADVISOR_NONE)
> -		output = "[none] scan-time";
> -	else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
> +	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
>  		output = "none [scan-time]";
> +	else
> +		output = "[none] scan-time";
>  
>  	return sysfs_emit(buf, "%s\n", output);
>  }

Ho hum OK, but the code did deteriorate a bit.

static ssize_t advisor_mode_show(struct kobject *kobj,
				 struct kobj_attribute *attr, char *buf)
{
	const char *output;

	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
		output = "none [scan-time]";
	else
		output = "[none] scan-time";

	return sysfs_emit(buf, "%s\n", output);
}

Inconsistent with the other code which looks at this enum.  Previously
the code explicitly recognized that there are only two modes and that
became implicit.

Oh well, no big deal and we don't want clang builds erroring out like
this.


