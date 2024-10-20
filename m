Return-Path: <stable+bounces-86974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5389A5443
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 15:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA34A1C20336
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 13:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FE8192597;
	Sun, 20 Oct 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRZyw5aJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662319149F
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729430159; cv=none; b=JSs1K5GvybbTv49mZkwdkOKEwqkdLZ12h1whFJYo/CQGgzHH78mfBwM6GDA+VxeatS5Wk4Ionuse+96myPxc5Q8eFOx+l9NQNRmSYcWVVfPrWHkxx1fILVnpgzftYJEbW8KSg5yqyNI6pU2lTY8CBVSvLz+lRqDFRO7DVyPU4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729430159; c=relaxed/simple;
	bh=uKgjva+0ctCwkivt4M+aYeVvXG0QvbFTOwa82+8Ezoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/EtpU7E5d4EIm2p8gTfCmSuQRYYPFqTMM8WpgO6FCy15IrhxpV6Y/ilt53WhbRGQD+a6JWMUBSxwfMHaMdJajRglC/E7qHy+4WOWA1Uyo6ICfmKu9WMgg0KVlWinD8tmWeA7L5G9MtX1lznbl134TcJ89K7m6AEle1hhsur220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRZyw5aJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e7e73740so3205990e87.3
        for <stable@vger.kernel.org>; Sun, 20 Oct 2024 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729430156; x=1730034956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYwZIeGEIc7VnkIRXpz4d+bHytScBmaxexHgM4ooyL4=;
        b=SRZyw5aJZwxgCJteX331J+Ygei7AymiR84aR8o5Q7YN5BGBacHK88kqyr5ieXzFx+s
         GKb5nMNlUYnw+nNs4GgIkY1mp52Zt+J3HhYPDvjB3+NKW4VBg9GTeLDl2p7j+xTxuN+c
         5LvREnzVK8DDp5X3biwTPEs45WqYUpRoglTr/z3OPyZw4v0L3t4OxypzvIKQjMJC2VmS
         7InkRCQ7CLwckxh1xlQJJbKoNL0mhdlwblfhXe6RxkKU/4A0IuDQDaOrdYWfqr7PxK/z
         EdUB2kEHtB0JVJCsMk4LCwNuhF9hEZDPRpuH1PiWwR+ZXq92v3mjtckhGFwwM8PFNOKv
         P1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729430156; x=1730034956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYwZIeGEIc7VnkIRXpz4d+bHytScBmaxexHgM4ooyL4=;
        b=HbULmoptJ4D19tuFQ1SfBJ4/jvqwQY+gR30XTjujqda9Z9Sn4miFU5Ooja9s7T9WYP
         QH70b3Pj344Ye8hhjZuRyKFOl+BGjQ6olpDCg9AtxYNQUZ5hEffBa7ymbQsOUQVASl5E
         5IrvzW6IY7ZKQimeudj3OdZd89oJAsVDMLRI+bFu4q/R3hNygFuDUGv3vRPLo/lzN+AT
         RRVr8gUHQwznwFcUI6Wg6SuTIuXXgLia48sIpw6YD66QkhMkiburqogMHhWm/W/tdq6s
         bJFw0/VQwn5qQ6dl8lwc0gtTHTBXCuPgO1OokABBEXzIApD4g1Pj6hrwNqKyS4zPwyV2
         f7cA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ne4XS8ar6A7ti0MmqwuJI84RI9MmUJ38OUiv7vUmPgxpSGc/vNoKCWcKBjMUkqEnE8BTXW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBGo5PKDHbhnwlOTlm7kj4buVmdAiQ3dYlmwyA/U/RrQVTm2mx
	c1kBIIkZ57zFVTnqWTgyzXG9zwwCcWVciWii9eVoY5NtClnIfXfWZqBRzTXNg7E=
X-Google-Smtp-Source: AGHT+IELxOsBj0URcEerkg6VeNl2eSHEE8fsdZdOVwEJm1At+CtbZCT/15/LMiNV6gF6vzcZLfV0qA==
X-Received: by 2002:a05:6512:2399:b0:539:f7de:df6a with SMTP id 2adb3069b0e04-53a15459fc3mr4475921e87.52.1729430155912;
        Sun, 20 Oct 2024 06:15:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e55f5sm220175e87.34.2024.10.20.06.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:15:54 -0700 (PDT)
Date: Sun, 20 Oct 2024 16:15:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: qcom-pmic-typec: fix missing fwnode
 removal in error path
Message-ID: <hw2m5c5wakwm4jcihammegpuydm3cbhxyzaln4p57w6ybkaaea@fx6thktwjuty>
References: <20241020-qcom_pmic_typec-fwnode_remove-v2-0-7054f3d2e215@gmail.com>
 <20241020-qcom_pmic_typec-fwnode_remove-v2-2-7054f3d2e215@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020-qcom_pmic_typec-fwnode_remove-v2-2-7054f3d2e215@gmail.com>

On Sun, Oct 20, 2024 at 02:56:35PM +0200, Javier Carrasco wrote:
> If drm_dp_hpd_bridge_register() fails, the probe function returns
> without removing the fwnode via fwnode_handle_put(), leaking the
> resource.
> 
> Jump to fwnode_remove if drm_dp_hpd_bridge_register() fails to remove
> the fwnode acquired with device_get_named_child_node().
> 
> Cc: stable@vger.kernel.org
> Fixes: 7d9f1b72b296 ("usb: typec: qcom-pmic-typec: switch to DRM_AUX_HPD_BRIDGE")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

