Return-Path: <stable+bounces-181421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3FEB93D87
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 03:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29D024E139B
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 01:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC824169A;
	Tue, 23 Sep 2025 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lvjxcrcj"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF42C187;
	Tue, 23 Sep 2025 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590893; cv=none; b=lxPIQrJt6mQfM2in2/UXOugFZ/RjmmIGqBijOFc5F0nWQvGRIuWAOlbaWEwWwoxTKW00QJp7rd87T0CBPUcZNFIIruSg2UvNeQqzQsPdVfw6Ub4SYEUKDghIiEe49bN5Gz6mqsUvhdU9rxGfIlNlCm/3PzWGvu8Ypwnt9/j02UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590893; c=relaxed/simple;
	bh=0ADWJisW8kO/3Dt31lZdQTFhoI6w1MXoIubeGL3UfrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqeVQp90z541xILw3Elqh8D/OY7mU6RqtGUrFUq2cYWDqR9TsiF95cl+FOCQBE6zEmMzaSkiS0NuGf2ttJHqbW+ZWLJuvoQClMO9spAlMTfTnZuZprmWNBc/TzZ1gO24DFS51e4p7fMdk6EXATtYjVcgHb0q4NtlrNYsU9Aa7k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lvjxcrcj; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=PqEYUudwG18jHMViGLX/jZq1TAjXJhfWsdIZilzljnk=;
	b=lvjxcrcjr4Vpxk9cLwZBp33jsJzsOaMgA98UdPTdegAAvpWFzXIs+FiJo37HRI
	iv7b32cfDz5FgzvUjb9VMPF57VBrskT9SxDw0uYgyscshgiL9L0lNez9kUByoZex
	pC3c3W3y6+CCV/Hyyrf8Xn7kMvumCXPLXAGTLNf3t+oJA=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnN4th99FosHheDA--.434S2;
	Tue, 23 Sep 2025 09:26:58 +0800 (CST)
Date: Tue, 23 Sep 2025 09:26:57 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jani.nikula@linux.intel.com, samasth.norway.ananda@oracle.com,
	simona@ffwll.ch, deller@gmx.de, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	George Kennedy <george.kennedy@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Shixiong Ou <oushixiong@kylinos.cn>, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org, Zsolt Kajtar <soci@c64.rulez.org>
Subject: Re: [PATCH] fbcon: Fix OOB access in font allocation
Message-ID: <aNH3YWKc7ZF7-clL@debian.debian.local>
References: <20250922134619.257684-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250922134619.257684-1-tzimmermann@suse.de>
X-CM-TRANSID:_____wDnN4th99FosHheDA--.434S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kry8GF1rtFWDuw4fXr1kZrb_yoW5JFyrpF
	WUGF13Wrs5tw43Ga1jgrWDZFy8Ww1kJryjgay2g3W5Zr9agwnxW34jkFWYga4fCr1DCry0
	yFyqqFya9as8uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcvtZUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiER7RamjR73-r6wAAsd

On Mon, Sep 22, 2025 at 03:45:54PM +0200, Thomas Zimmermann wrote:
> Commit 1a194e6c8e1e ("fbcon: fix integer overflow in fbcon_do_set_font")
> introduced an out-of-bounds access by storing data and allocation sizes
> in the same variable. Restore the old size calculation and use the new
> variable 'alloc_size' for the allocation.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 1a194e6c8e1e ("fbcon: fix integer overflow in fbcon_do_set_font")
> Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15020
> Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: George Kennedy <george.kennedy@oracle.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Qianqiang Liu <qianqiang.liu@163.com>
> Cc: Shixiong Ou <oushixiong@kylinos.cn>
> Cc: Kees Cook <kees@kernel.org>
> Cc: <stable@vger.kernel.org> # v5.9+
> Cc: Zsolt Kajtar <soci@c64.rulez.org>
> ---
>  drivers/video/fbdev/core/fbcon.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 5fade44931b8..c1c0cdd7597c 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2518,7 +2518,7 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
>  	unsigned charcount = font->charcount;
>  	int w = font->width;
>  	int h = font->height;
> -	int size;
> +	int size, alloc_size;
>  	int i, csum;
>  	u8 *new_data, *data = font->data;
>  	int pitch = PITCH(font->width);
> @@ -2551,10 +2551,10 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
>  		return -EINVAL;
>  
>  	/* Check for overflow in allocation size calculation */
> -	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &size))
> +	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &alloc_size))
>  		return -EINVAL;
>  
> -	new_data = kmalloc(size, GFP_USER);
> +	new_data = kmalloc(alloc_size, GFP_USER);
>  
>  	if (!new_data)
>  		return -ENOMEM;
> -- 
> 2.51.0

Reviewed-by: Qianqiang Liu <qianqiang.liu@163.com>

-- 
Best,
Qianqiang Liu


