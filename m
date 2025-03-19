Return-Path: <stable+bounces-124894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D80A68914
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C99A167BC7
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E1E24FC1F;
	Wed, 19 Mar 2025 10:08:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950F204C18;
	Wed, 19 Mar 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378903; cv=none; b=gQZO/yFIAeAtSjhEt+v7yKj6NyBvODMPdejDT5XuuOsZgOa9vgw3vjUYy91WBDSWm3Ot/BhkHmCSUXT4l5ZgOqJpiAPT4vPgbtgQf69T8twfnS9CZkkkjDL/Ju1MUwHXxBT9JsAYAgdwpoJ3POTSo4680k6X0/R6ZK6jsQnkKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378903; c=relaxed/simple;
	bh=G/m8WkDUAHeIw005GTwrGMwEGiDo+qkupaHi6YgIVdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fA0E3uQ0QA5WwucnkMqrtrYCfudSSC567jpdd3tZ1FsG5ywJUqRjqKoDaoLzh33dtx7Wuc4be9vewZFa8HQz/3rlVOrSIX/yJY1hMqSEku1Ew7/tPITPNAWhxKCe1G7aKjtD94nkxFS/sMgaJsu7fKZ9FndmjxKheu+TdTGbZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4ZHkhK48YRz1sGWy;
	Wed, 19 Mar 2025 10:59:29 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4ZHkhK2Rhdz1qqm8;
	Wed, 19 Mar 2025 10:59:29 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id a9x4igNfRpZB; Wed, 19 Mar 2025 10:59:19 +0100 (CET)
X-Auth-Info: BtvBspTpARlf2pa1FYP5d/CgtfauwNSx4rPu46lT4z5VRogUyqMzVSh2riPgGubG
Received: from hawking (unknown [81.95.8.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 19 Mar 2025 10:59:18 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
  linux-m68k@lists.linux-m68k.org,  stable@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] m68k: Fix lost column on framebuffer debug console
In-Reply-To: <0fa5e203bb2f811e36e9711dfd461a8f760a1ed6.1742376675.git.fthain@linux-m68k.org>
	(Finn Thain's message of "Wed, 19 Mar 2025 20:31:15 +1100")
References: <cover.1742376675.git.fthain@linux-m68k.org>
	<0fa5e203bb2f811e36e9711dfd461a8f760a1ed6.1742376675.git.fthain@linux-m68k.org>
Date: Wed, 19 Mar 2025 10:59:16 +0100
Message-ID: <mvm1putgx3f.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Mär 19 2025, Finn Thain wrote:

> diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
> index 852255cf60de..d0d77b1adbde 100644
> --- a/arch/m68k/kernel/head.S
> +++ b/arch/m68k/kernel/head.S
> @@ -3400,6 +3400,7 @@ L(console_clear_loop):
>  
>  	movel	%d4,%d1				/* screen height in pixels */
>  	divul	%a0@(FONT_DESC_HEIGHT),%d1	/* d1 = max num rows */
> +	subil	#1,%d1				/* row range is 0 to num - 1 */

s/subil/subql/

> @@ -3546,15 +3547,14 @@ func_start	console_putc,%a0/%a1/%d0-%d7
>  	cmpib	#10,%d7
>  	jne	L(console_not_lf)
>  	movel	%a0@(Lconsole_struct_cur_row),%d0
> -	addil	#1,%d0
> -	movel	%d0,%a0@(Lconsole_struct_cur_row)
>  	movel	%a0@(Lconsole_struct_num_rows),%d1
>  	cmpl	%d1,%d0
>  	jcs	1f
> -	subil	#1,%d0
> -	movel	%d0,%a0@(Lconsole_struct_cur_row)
>  	console_scroll
> +	jra	L(console_exit)
>  1:
> +	addil	#1,%d0

s/addil/addql/

> @@ -3581,12 +3581,6 @@ L(console_not_cr):
>   */
>  L(console_not_home):
>  	movel	%a0@(Lconsole_struct_cur_column),%d0
> -	addql	#1,%a0@(Lconsole_struct_cur_column)
> -	movel	%a0@(Lconsole_struct_num_columns),%d1
> -	cmpl	%d1,%d0
> -	jcs	1f
> -	console_putc	#'\n'	/* recursion is OK! */
> -1:
>  	movel	%a0@(Lconsole_struct_cur_row),%d1
>  
>  	/*
> @@ -3633,6 +3627,23 @@ L(console_do_font_scanline):
>  	addq	#1,%d1
>  	dbra	%d7,L(console_read_char_scanline)
>  
> +	/*
> +	 *	Register usage in the code below:
> +	 *	a0 = pointer to console globals
> +	 *	d0 = cursor column
> +	 *	d1 = cursor column limit
> +	 */
> +
> +	lea	%pc@(L(console_globals)),%a0
> +
> +	movel	%a0@(Lconsole_struct_cur_column),%d0
> +	addil	#1,%d0

s/addil/addql/

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

