Return-Path: <stable+bounces-142036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8BAAADE94
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 14:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028AE1C40ABF
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 12:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22764269D1B;
	Wed,  7 May 2025 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iijmio-mail.jp header.i=henrich@iijmio-mail.jp header.b="y90CqXq6"
X-Original-To: stable@vger.kernel.org
Received: from hsmtpd-dty.xspmail.jp (hsmtpd-dty.xspmail.jp [210.130.137.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A30269813
	for <stable@vger.kernel.org>; Wed,  7 May 2025 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.137.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619548; cv=none; b=QojFZIr5JZZVKq+JxKCgSwUXqYD8dsu77UCp9OiJ8uv7TR2c906AxxZgcTjxGYeF9Mx1f0QjAJB8jln1pZ1balLhvGZxkyXAgWYUyrVAuiosYs5TwlbiY8At62GlRQXSIHzHVm/+AI89AaSIJ4oGb+k8MSrIAzlX0ftQDBU74Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619548; c=relaxed/simple;
	bh=Cv083FcG/7PvlrfWbh+9fEoEpT2GiCILD9E6lAG0rVY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YoP0XVdy3AZrF9lzaCaZXkSpIG7DoMNyqVfYSSejEcloQm0s9XzgiGZ6c4HvjMp+F+QjnWPjxcmIz5mlw2ipaEqTFqi15SvUxD1Ptkg7+zvfxqSN2MW8nbpxb3PaKy1e34aUDhcmIVNGZrUkKAZlArYDpJSFyuLpLC5oxBUjuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iijmio-mail.jp; spf=pass smtp.mailfrom=iijmio-mail.jp; dkim=pass (2048-bit key) header.d=iijmio-mail.jp header.i=henrich@iijmio-mail.jp header.b=y90CqXq6; arc=none smtp.client-ip=210.130.137.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iijmio-mail.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iijmio-mail.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1746615936;
	d=iijmio-mail.jp; s=x01; i=henrich@iijmio-mail.jp;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=PIPLwqGNgXYGIiir18PY9NcJ9TVPgdQPYwEebPwFF1g=;
	b=y90CqXq61Sg2IvEhdYY3UR+G5OcbpoDOTm4Zmj2oYi3f09OpnMvE1PqVrcVn403Kw8u+wSjDnD5kY
	 k2fmtFiKnJsVE3iUczfNve96dkMGJhPDzBa9pPus/Cs92VM/nhqriPOmORJo8cX/8qglLyU6cg8Jp8
	 8u52fqr3qMz/NlK9K0pORk+r+rrI8G7gHuHXeWrjuNar+q1mR7iwUWhz2VFWq/ymWXc9RbfJKa4Wv1
	 gZgvWqE031AiV/Jb1cmQw8K2FKFBq0nir9etaAESTVWYDytGyQRriA6MXXgR0FWPx8Wd6MUdi3ZFWx
	 VDrCbP1EXp5QZVJQHOnSYFw7AqpzvvQ==
X-Country-Code: JP
Received: from t14s (unknown [2409:12:b80:1600:5410:436b:3e69:1281])
	by hsmtpd-out-2.iij.cluster.xspmail.jp (Halon) with ESMTPSA (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	id 0e1a8799-44bb-48d1-862c-25ba41cfe1f7;
	Wed, 07 May 2025 20:05:36 +0900 (JST)
Date: Wed, 7 May 2025 20:05:33 +0900
From: Hideki Yamane <henrich@iijmio-mail.jp>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, Sergey Shtylyov
 <s.shtylyov@omp.ru>, Rob Herring <robh@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDg8K2bmln?= <ukleinek@debian.org>, h-yamane@sios.com
Subject: Re: [PATCH 6.1 150/167] of: module: add buffer overflow check in
 of_modalias()
Message-Id: <20250507200533.ac131fe0c774b23054b4261e@iijmio-mail.jp>
In-Reply-To: <20250429161057.791863253@linuxfoundation.org>
References: <20250429161051.743239894@linuxfoundation.org>
	<20250429161057.791863253@linuxfoundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 29 Apr 2025 18:44:18 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> commit cf7385cb26ac4f0ee6c7385960525ad534323252 upstream.
> 
> In of_modalias(), if the buffer happens to be too small even for the 1st
> snprintf() call, the len parameter will become negative and str parameter
> (if not NULL initially) will point beyond the buffer's end. Add the buffer
> overflow check after the 1st snprintf() call and fix such check after the
> strlen() call (accounting for the terminating NUL char).

 Thank you for catching this and push it to 6.1.y branch.

 And it seems that other older stable branches - linux-5.4.y, linux-5.10.y
 and linux-5.15.y can be updated with cherry-picking  
 5d59fd637a8af42b211a92b2edb2474325b4d488 

 Could you also review and apply it if it is okay, please?
 

-- 
Hideki Yamane <henrich@iijmio-mail.jp / debian.org | h-yamane@sios.com >

