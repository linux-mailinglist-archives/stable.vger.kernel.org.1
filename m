Return-Path: <stable+bounces-83755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D868C99C4C6
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D47828482C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF0B15B13B;
	Mon, 14 Oct 2024 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+cvuAl+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7E6156C62
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896792; cv=none; b=UdyINS022lznm3W91jD5e/Z0MkrDDTME2261aLONyCQzBCmUo7/ythlJKIaWjgMIkr2hc5kOsSZLHS/eKvVeC23aubFMREdtXfyPRWGmi9684m6fwaFunL3oPRdHyYJetCPGgOuXnQKjLSPgY8m152xY1vJ6sOr2LUyenXpwJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896792; c=relaxed/simple;
	bh=/6AkSe9ZsMWGEegbX5mWdCWRk8oikiSE5pvH24z3A2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxqLIx36vFI2S3tmk2NvKYQsg1/buH6Nx6hJ6bxNDbi5Ao5ly9rLrVbYICPplrKvYS2avsVVLdZ2s1s+sQe9kz+GjrgsUS4Ys4v5CfiW1LAWQd1PhAMM1saz6bvqzf14ElQAUQ0dsgLiTe3cUl+yPEC/a/Uz5yJ2HYlERkUvuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S+cvuAl+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c949d60d84so3347288a12.1
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728896789; x=1729501589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ7N4NGsrBS9erfMRFf3mr/u/TsgsOX0nwQxEKrF5/8=;
        b=S+cvuAl+91joN9GXT+YyP9LFuzkI7splVK5fOl4dzdY3NNElizERuhq+rqx3AMIrK/
         mtaWUN4N0zWtjQlRQYOv/C34jeyK/V0ZtXMtjcHXOYFp3yVszwW2WvonnGzUQcGvAGPu
         apm/zW6+v/mrTkAp9n7dc6DuyeMOGw8O1v91YLser01r+URuwm1Iwm1fvwpLZfdr0Gka
         Q37hs2VLlxqVD8kLu789V5YCOkCzVdWWwZzSkKYGU9tizV/EE8SaH1tKPfJOVL2SNeQ1
         pAOaeIXZRyZ4C6WCtvaNS5Gw7K5lsL1HhlWMB54BUQD4o46nWmprd8oWfkb1+2rPHGGt
         0CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896789; x=1729501589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQ7N4NGsrBS9erfMRFf3mr/u/TsgsOX0nwQxEKrF5/8=;
        b=BzSKkVzdQXn7e/TKuMlDytVq7APVeDvs06qXmXWtzEonEi5AcVrh1NbsTCFmZZElkj
         Mlc/R/8chP7yS5dbGbAh2kkR0MYEZoLuB64QToZjl0mRAH3CFFdNIM04JsufiaXdnVtA
         WBxdFRE70qjGoWFWZ/MHJqbfR2FvQLpcgI3BHunNpq/Wvu4NdeBZg1GtR9hVhtS5xX8d
         M8OoCKrf/E0ZeNIzSmap/6pADDQn9+MbKDdHKxpOUF1bVCrIHnO3Mszy+Nmg9MOysH0u
         sMzJqQtyFvuML2rQgoxCaOgCXmOgGOR1GwtlMtCjyKwLqNGFqR5hyFuVROcUy5qODmrt
         3WnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmD00uQ9ggU6PLA4MS8lMrI50wXPxXLfrcVQysqRfYIn80kUOu4tq7ylPrnJYgft6caTBwk70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWYa+9Z+Dm3GMsQGlsDoZUZT7FAUCxZlMOIfoO/N1Wdf8BbtS
	ite4iEeUjwGYWvuvAs1/W2eSwDZyaD7G6yGL9LWeRnA9Re1Kq9vmmVfepHq2VWk=
X-Google-Smtp-Source: AGHT+IG3luq/hzR8Bl5xe7C7iS7FVcUq7MLtlNd/M/noM85vm/NAE/kbPKiFAuv1GvAh9JyzUb1NfA==
X-Received: by 2002:a05:6402:3207:b0:5c8:f905:9fe4 with SMTP id 4fb4d7f45d1cf-5c948d6a54fmr9188289a12.28.1728896789469;
        Mon, 14 Oct 2024 02:06:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d25e8sm4699269a12.4.2024.10.14.02.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 02:06:29 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:06:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: Fix missing refcount decrement in
 error path for fw_node
Message-ID: <63e1351e-d8f3-4b98-8abe-a2541f95281a@stanley.mountain>
References: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>
 <a4283afc-f869-4048-90b4-1775acb9adda@stanley.mountain>
 <47c7694c-25e1-4fe1-ae3c-855178d3d065@gmail.com>
 <767f08b7-be82-4b5e-bf82-3aa012a2ca5a@stanley.mountain>
 <8c0bbde9-aba9-433f-b36b-2d467f6a1b66@gmail.com>
 <20d12a96-c06b-4204-9a57-69a4bac02867@stanley.mountain>
 <a3a8418a-57f2-4f3e-80a3-011de2af1296@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a8418a-57f2-4f3e-80a3-011de2af1296@gmail.com>

On Mon, Oct 14, 2024 at 10:49:28AM +0200, Javier Carrasco wrote:
> In this particular case, and as Greg pointed out, that is not a real
> threat anyway. My digression comes to an end, and v2 is on its way.
> 

I mean the other thing that we would accept is if you moved the NULL check to
be the first thing after the declaration block...

regards,
dan carpenter


