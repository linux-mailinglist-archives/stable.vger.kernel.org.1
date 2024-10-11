Return-Path: <stable+bounces-83446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BC299A468
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 15:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4E81C2203F
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 13:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A2321791A;
	Fri, 11 Oct 2024 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HSyI4MX8"
X-Original-To: stable@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247D216A05;
	Fri, 11 Oct 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651991; cv=none; b=szSAx9SFCWuBgShAMfGRgDFNM6y2AXGa0wZD6zCNUgh+iWmezQDJaGpTOJuuX3FkUIQ4s4sLt1zf9eIYy7zUGssZVP59SRZh4J3Bx0UKwan3rslzHXOUWQD0fjWOH5I0XlaOXg7Q1OpThvZFDtaowXHx9nPtmpMKewbL9u/Ys1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651991; c=relaxed/simple;
	bh=osjr2zgGNKsivNJgMfsp/90b7WTPqgQGfwKKyQWSDwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c41lJrxfECGDG/tOhvkCCmd2yJ54BmY7FONtq+8w90aC7jWGuMWaJivIvsSTApFL4MNjabN+XJhAccSa30vx14m5MyNCU3mWeLO0ABCKSqs3TcbJR2EGJKfQVHfibE6qJs5GG7284Px5wNSB1Neqa0UL6WDjvBr+HKIjajbg/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HSyI4MX8; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5251220002;
	Fri, 11 Oct 2024 13:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728651987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CunMtJJ6/SzlbPyi0GCgaD8hlcTnVAq7qYmei3YWRTI=;
	b=HSyI4MX8HyDIvkQxea0g3u8DIEIepEhJGuZ2GO4ci88p7Ja3tow6uSMV6Ci6pgQksqxY7C
	0Sp9KPH9QB0+wHfpp8EGi9OS9gBzfmGysfRklGhWnUvbvfKqPsf5aW5XJsRIK9uSO+aZs1
	vUaw84pMvVPUF6e+2910VnYBCRxjzlAWypM5S+MQXTIzTjJKBhRablxkTqABW1iXbRtXBq
	lZ4q4Y3g7Bge+lugSTstYfaWdWa5zwOOFzlrBPOC49o4eWFFiCXmeBrp5ibAB6/oGG/IM1
	pJOXX6RRUQkk6R0rm++Bw8YSrksNnQtIleertVPPnz5zTkhGzQRC/QBXpahiVw==
Date: Fri, 11 Oct 2024 15:06:25 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] drm: logicvc: fix missing of_node_put() in
 for_each_child_of_node()
Message-ID: <Zwki0VC2hmSsguho@louis-chauvet-laptop>
Mail-Followup-To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20241011-logicvc_layer_of_node_put-v1-0-1ec36bdca74f@gmail.com>
 <20241011-logicvc_layer_of_node_put-v1-1-1ec36bdca74f@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-logicvc_layer_of_node_put-v1-1-1ec36bdca74f@gmail.com>
X-GND-Sasl: louis.chauvet@bootlin.com

On 11/10/24 - 01:11, Javier Carrasco wrote:
> Early exits from the for_each_child_of_node() loop require explicit
> calls to of_node_put() for the child node.
> 
> Add the missing 'of_node_put(layer_node)' in the only error path.
> 
> Cc: stable@vger.kernel.org
> Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controller")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-By: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>  drivers/gpu/drm/logicvc/logicvc_layer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
> index 464000aea765..52dabacd42ee 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_layer.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
> @@ -613,6 +613,7 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
>  
>  		ret = logicvc_layer_init(logicvc, layer_node, index);
>  		if (ret) {
> +			of_node_put(layer_node);
>  			of_node_put(layers_node);
>  			goto error;
>  		}
> 
> -- 
> 2.43.0
> 

