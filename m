Return-Path: <stable+bounces-69330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D29954BE6
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 16:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B83B23E35
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF61C0DFE;
	Fri, 16 Aug 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="D9A3GZwF"
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB001BD4E4;
	Fri, 16 Aug 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817179; cv=none; b=FG0vLTO07X3tuzJVxhiUh9ttsl7D+GEuEl+c/pxQUhLc9OTHxeg/j5bAnqRd+lx+xrzWRnPc5/q5VU/LwD9D1mB4uNcViMibVivVD0XJRWMi7acB5NvZAsRdjBKJuQzvSk8WwxULMXJM/VkpOTqX3rKHIJJLZnauOmROnjIwL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817179; c=relaxed/simple;
	bh=QpO6GTw0iGnN6j2K6ioOCnIcoC3VCwqWs2F5D78yvmc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUVWNNrf7RI2gzvNUPhZvcsMEXFcY7XnAQE3x9TWmIqL6D5ObD8zClVXrn/ptBbs0khbx8U1sv426bfZotqPWodxV3OihXKT8qcQD72euyHefKUNzUvE3LKMo9sAdZ+zeL7pjqI22Yk8mwx8UlNd67mOW42FDMmNBdddfaK7F6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=D9A3GZwF; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Fri, 16 Aug 2024 16:06:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1723817176;
	bh=QpO6GTw0iGnN6j2K6ioOCnIcoC3VCwqWs2F5D78yvmc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=D9A3GZwFnZUwWAiynkc1yCp5qTzLzN8D8MDMbKc+0zWC/EZZ215jgdYeLMxTQin1b
	 iChYIWMYJc3RTTZ2623+t3z2kNFHbHJHyuKDTHtYRXlT/E3b473lgdicsi9aDrlFZE
	 bSIdNX0CPdAJ8PZ5OGxpLgWOqKGLp6lf1fgax3D50gelyewL3v4BUEa7B4z+ssvtW8
	 0W9AQamj5pcmsDNMXehpZrfFs45S27KFgyJ6MOuyFwkXinWF5UZ9GP0gS5MuvCJeuk
	 4RFdbOxDRf26HA+GHpB0+NG5/DSWdWGp7DA4k28kkR8BqX9j8v8yqo88oXcwsXlksC
	 8m9Ye7qUcmgxw==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.10 00/25] 6.10.6-rc2 review
Message-ID: <20240816140614.GC5407@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240816085226.888902473@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816085226.888902473@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.10.6 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Aug 2024 08:52:13 +0000.
> Anything received after that time might be too late.

Hi Greg

6.10.6-rc2 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

