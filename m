Return-Path: <stable+bounces-237181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKibIqQe3WmsaAkAu9opvQ
	(envelope-from <stable+bounces-237181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:49:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F13EFE72
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A34B304B376
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766A3161BF;
	Mon, 13 Apr 2026 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htDO4oMg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nCm0IdyY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC0314D0D
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098796; cv=none; b=hRzL3TVenevMnrEWeV83vu/wJEXytIm0ysPSRY0bl7J/o++O/TW2H7To0vPjo9J9q14eTbSXHMlH7EbrPujOBzTOnPOMZfcSE7dtRtZVazjH5WvP7UyjytO1j6Hzx95bGkId8XlwWIGOmBi1L0wZtOL2ypOzop9GXU0qUsN0Ck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098796; c=relaxed/simple;
	bh=chmoZmOPdz8JE9W/6rS9Q7KoVVIpZZr66rPx9xp9BsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3cDJRCDUWXtQT7PzCAluud5h0qJVSNa9xPiOypDAgS1AJT0Yz9Y4uI+cb+pLXXL1DDvWuuXhTO09dSgqCStzbE5GdROs2+6SwMdD2SS4C7e4jG47CmcVr5+rL94PtGQj7E8fyZVBPlkmsoo5TPdHNrHYQCnXrJjqdFSFlljew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htDO4oMg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nCm0IdyY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776098794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1PPAOec4m3Xk8tVFNcRUtZ/nDnCQH6sVE60gTwlAeyg=;
	b=htDO4oMg2Uo9kmZkopVhtAqMtaNqgidY4hyH9l+altf//ZboOah8Q4KonEKedW2fSvCNCM
	ug/7NRSZ3PWT/10gqBYm+QIlizVLNjlT+WHSVH5w5RAwXPhB17a3h5uLpdTiyTHcYFMaSX
	dx5dnsQ4/xh/4XBnwpiPyXGb5ztv5rE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-09DLJFeXN_6QBX2IiOy9Rw-1; Mon, 13 Apr 2026 12:46:33 -0400
X-MC-Unique: 09DLJFeXN_6QBX2IiOy9Rw-1
X-Mimecast-MFC-AGG-ID: 09DLJFeXN_6QBX2IiOy9Rw_1776098793
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8954803bd74so46474696d6.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776098792; x=1776703592; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PPAOec4m3Xk8tVFNcRUtZ/nDnCQH6sVE60gTwlAeyg=;
        b=nCm0IdyYtOjNTVR5kNc3p7a9tDLYUUC1jlCtZR/vXV72SFpc3nQg8DFRiqTsteq2+1
         hvSUCb7ERLOC4oCFVya4o9swoLXTEUV7DnIEEZWm/j9BUbnroHQg2sX9KOIcjOift4JT
         lXPX3tZMjuD9T13T+C8ZiBigCQV12iSE/E4FHnQMQh7wHxAEQHihXxTUaJW+IP7gXMQY
         hT7x6YmMYDjQR2K0AJRTqPufNCsURo+5PpDU4e7uf4cytaqTN2N0NTrsv8mTsB37FmHK
         59zX0In2hy4dyQ/pOKiig4PsogkpnLy/CI3VOxlQZyjqtiq/28THEcUSTlLc1bF5xeWd
         dTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776098792; x=1776703592;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PPAOec4m3Xk8tVFNcRUtZ/nDnCQH6sVE60gTwlAeyg=;
        b=SDZYxLf8vSIfVKIuUHVhXD8DUPkTPLFMdkR+O/YC4xPjuaMkHg058T8C2ewueQtwat
         0r/SlWrlpTlrVGi1UAXAjPlhQDx3IERuJ9p3w4DZp+P+wZYS4e9ndYgsByVGQBSJembM
         znnU8hEhBe3phWdED3Z2Apbp2QZS7WztTY1Wy7Zn7sQ32XcWE8co7TWqG1Zhu6F0IVKT
         05dUmHak/NQNXQP0Larw0lam0pECFiB9zZUYhlfpBHuIjYuiu98QzDPt9cTUW+YQcSVw
         lkbzGM9awxJ3+PbmOxbSOtr9KtG1aX+ulFKkd+7mbuvNs6WYkIsLbnaGc5x1Y6D8CjVd
         TcBA==
X-Forwarded-Encrypted: i=1; AFNElJ/mNPCe27s/FhaK9cUSr6/U8SH7qNCoRAkIDr0EH1qdMdlzepXrcIb3lAndtpZDT8hICrKu49o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm1mBCFPQYBheDy6rL5YLN/22OqXdYt4zGbPNL7vq0Dfyk6Eb3
	fPYxisNcYYsm0JYhC40V0Jvp4wj65hz0T28sL7HEKMS9z6xHLx3/eSWQCPTHzgnA/FTAWnnYH4l
	s5kQB1rQpu7h4hQsgroD0VSRGwOFdBDd8dwJ3oxFyVaxMxoRUfQ/qLUynpQ==
X-Gm-Gg: AeBDietk+uJKK0bIlEDzLsJkJ8/WaQK2/FM56QJKcLs6oqDobN3c7X8iQ+UpulUlSnY
	LzVf69WIBEPtME1Rvs0W38v2Bd2BBfxdfwcxAPWp/jG1pwMRag71ZYXY4hijCtANlrGISK7nSH1
	RolkUSon6ScAGIb/XFJ6KZOPShW1kQifX0pzSFiRh6QDFnI/ZtHRQLcN50pQIEq9RJ7DmGvnc9A
	nr8zHKBKslVKhYIH5DYrWgLZuc36z3uXVwf36cgc9MNVDK1ij8xiDm0x6c4eS3Q/QwT9MJgCMyS
	CKeyDnTdkUkgc2F267ny4Zmst9fEpmrgTQ8bnqUDYIT34kNbYg0V0u5rVrPnxORwh8vOVAGiUBo
	P1cIlEXy4xFwAieqTxMfK3SfFD9pKbdADnfxZZClwqb+T0EKLHYQtn7Er
X-Received: by 2002:a05:6214:3118:b0:8ac:a1a8:43 with SMTP id 6a1803df08f44-8aca1a806ddmr100344976d6.52.1776098792419;
        Mon, 13 Apr 2026 09:46:32 -0700 (PDT)
X-Received: by 2002:a05:6214:3118:b0:8ac:a1a8:43 with SMTP id 6a1803df08f44-8aca1a806ddmr100344376d6.52.1776098791686;
        Mon, 13 Apr 2026 09:46:31 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a104ddsm96436786d6.14.2026.04.13.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:46:31 -0700 (PDT)
Date: Mon, 13 Apr 2026 12:46:29 -0400
From: Brian Masney <bmasney@redhat.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] clk: starfive: jh7110: fix memory leak in
 jh7110_reset_controller_register() error path
Message-ID: <ad0d5fIAkjblQcIt@redhat.com>
References: <20260413143643.3002454-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413143643.3002454-1-lgs201920130244@gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-237181-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A3F13EFE72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Guangshuo,

I missed that you sent a new version. My same comment from the v2 still
applies. See below for details.

On Mon, Apr 13, 2026 at 10:36:43PM +0800, Guangshuo Li wrote:
> jh7110_reset_controller_register() allocates a jh71x0_reset_adev with
> kzalloc() and sets jh7110_reset_adev_release() as the release callback
> for its embedded auxiliary_device before calling auxiliary_device_init().
> 
> If auxiliary_device_init() fails, the function returns immediately
> without freeing the allocated rdev. The release callback is not
> available for this path, because it is only reached after a successful
> auxiliary_device_init(), for example when auxiliary_device_add() fails
> and auxiliary_device_uninit() is called.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review. Free rdev explicitly when
> auxiliary_device_init() returns an error.
> 
> Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v3:
>   - clarify the changelog to describe the exact failure path
>   - note that the issue was identified by a static analysis tool
>     developed by me and confirmed by manual review
>   - apologize for sending the initial public posting as v2 by mistake
> 
> v2:
>   - initial public posting; v1 was mistakenly skipped
> 
>  drivers/clk/starfive/clk-starfive-jh7110-sys.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> index 52833d4241c5..55cd0ccbdb84 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> @@ -360,8 +360,10 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>  	adev->id = adev_id;
>  
>  	ret = auxiliary_device_init(adev);
> -	if (ret)
> +	if (ret) {
> +		kfree(rdev);
>  		return ret;
> +	}
>  
>  	ret = auxiliary_device_add(adev);
>  	if (ret) {

There's actually another leak in the error path for
auxiliary_device_add(). I think this code should be
converted to devm_kzalloc().

There is no devm_kzalloc_obj() yet, however according to [1] that should
be coming soon.

[1] https://lore.kernel.org/lkml/20260330154108.GA3389518@killaraus.ideasonboard.com/

Brian


