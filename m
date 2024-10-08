Return-Path: <stable+bounces-83083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61327995590
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 19:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2A4FB27A07
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864F1FA258;
	Tue,  8 Oct 2024 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Okmxnov0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C91FA244;
	Tue,  8 Oct 2024 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408204; cv=none; b=iwu6Cz+EL6Jls8xAZgkx9TFqQrxf+0HV84blPQvPusXgCUFqZS5ShjNGHsxEJzPMm0Kfdg6ViDUtvcPKxtviMQoEK8B+ReGJkcnXAuXk/lcxPGY5yLErErVTYiGUaZJbJJam2T7NEIMRLidyHOkJMRVuoyjkFc6yR8l3vqKjfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408204; c=relaxed/simple;
	bh=DuHTSfJlmC1hp6ca5DIHmFBllQ1ImR0t39fiVgQb/dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pl92zFXYKifT3if+3aqxyVoz2RD19eTNiKqV+QNZlHlPi8fCMfxJK7tS85DGEpJ+5wWfx/GWyUpndzFa3MEPejtQ16YQq/VLdq+2lVFNpwkZrCFTZk2obPlaWPPiwTOh/a7jdUpN9UxX0pDPVWkGDjN0t3Xe7p0C6yIHmtevQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Okmxnov0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082CFC4CEC7;
	Tue,  8 Oct 2024 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728408204;
	bh=DuHTSfJlmC1hp6ca5DIHmFBllQ1ImR0t39fiVgQb/dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Okmxnov0uc+NFjHx21W6Gujd1idTmAlVJsKNZ5flBTKyg3e6SCKt1bkihvDSzgj0g
	 X9vT0yttzVHPH8W+np1B28njjElN7rMLqW25WzUELP+/G1cZhbKWA/8lyoPpZY5bO1
	 pLGtxTDRnsX6Aeh5rZGPrASWKvFdamVVTVQXSrQNzMuov3n/MtMzLk2R6hbpjXoN52
	 /2bkkwOe9Gc1y0MNxAtVpKzpALeXqyNBRyu12jyVcb0AmO3g47ZZ1VBnvR6aG6iqUD
	 5im0/YICPqJ0WfUZN5qAvIRAx935V4w75fnN2E1Ol1f6lCsNQgH47WzzGg51v1hDgA
	 1SXsDVOpQjx0Q==
Date: Tue, 8 Oct 2024 10:23:20 -0700
From: Kees Cook <kees@kernel.org>
To: Zach Wade <zachwade.k@gmail.com>
Cc: tony.luck@intel.com, gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, lixingyang1@qq.com
Subject: Re: [PATCH] pstore: Fix uaf when backend is unregistered
Message-ID: <202410081019.0E9DE76A@keescook>
References: <2bf30957-ad04-473a-a72e-8baab648fb56@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bf30957-ad04-473a-a72e-8baab648fb56@gmail.com>

On Wed, Oct 09, 2024 at 01:10:14AM +0800, Zach Wade wrote:
> when unload pstore_blk, we will unlink the pstore file and
> set pos->dentry to NULL, but simple_unlink(d_inode(root), pos->dentry)
> may free inode of pos->dentry and free pos by free_pstore_private,
> this may trigger uaf. kasan report:

Thanks for this! I need to double check what happening here a bit more
closely, as maybe some ordering changed after a43e0fc5e913 ("pstore:
inode: Only d_invalidate() is needed")

> @@ -316,9 +316,10 @@ int pstore_put_backend_records(struct pstore_info *psi)
>  		list_for_each_entry_safe(pos, tmp, &records_list, list) {
>  			if (pos->record->psi == psi) {
>  				list_del_init(&pos->list);
> -				d_invalidate(pos->dentry);
> -				simple_unlink(d_inode(root), pos->dentry);
> +				unlink_dentry = pos->dentry;
>  				pos->dentry = NULL;
> +				d_invalidate(unlink_dentry);
> +				simple_unlink(d_inode(root), unlink_dentry);

But on the face of it, this does solve the UAF. I'll double-check that
this isn't a result of the mentioned commit.

-Kees

-- 
Kees Cook

