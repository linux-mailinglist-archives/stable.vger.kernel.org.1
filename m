Return-Path: <stable+bounces-86983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027EB9A55E2
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 20:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B851D2828B1
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF3D196450;
	Sun, 20 Oct 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMKnxGO8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A711C36
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729449226; cv=none; b=UXCBN9TC/aQiCr/YzJmf8tT0UbL1dDIfSNcQW5ndfcNdWNEsdiTnrZTjZMNFdvr06W/5Toy+fZx0P9sufvUBg+6DaNJQJGS39ovgEpDZnGCH6GKtXV0U/Muuh6DLTMrYrYjaWNUzHxz2m1zGl4WegioLOKZRQ1hPYb403mxxleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729449226; c=relaxed/simple;
	bh=Nqe7c3elxaoL3Ducy+32RHiGEnA48JgHc3EXv6VkdpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCQCc57OshNWFYgDdaQYM3FC1T0pnPai1EpHdCZHbWXAEErXIZqdVEsZ7w51+lrQGz95jXPbWLAKd28EHqknbqZ3S9g4T7k1c3VSX4NmtyyDblJzD/BzE7EiX8tDzTjPpt0eaAVAw7dv9mQ+mo315jg5HGs+tsiP7XJ8zcEHJQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VMKnxGO8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a68480164so302371666b.3
        for <stable@vger.kernel.org>; Sun, 20 Oct 2024 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729449222; x=1730054022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T994nC3yKb+Vde4eYi7s6bjrifvvScOE1gioC/lb0eI=;
        b=VMKnxGO8fsq1xBCrQ+0wasvHT5H7XG6pve9Xc0r/krEb5vlzjesm5dEBF1JHcLKHWd
         3TB+abDS/tQLH5K1jMQjJm08Eyu4io8vZWFqutuH/S3RzHL7HJnW3EbgY+pFvz+0gpMZ
         crkdqFwaymXwD2R5cS03j6VR72NZl18wyS+7cB/A2ZxTI5GrvvmSPukWUraPRrDh5fkN
         WeqjZmxwbqq+5stne/iAZ1RVTR3N/fEb9+CmhGKXqvBKZ+cQuyw9FtsFzF0LxZNZQgXV
         URhpMkVWFElQPkNgo8vDlQ4f1tKgXarwo3w4mSCkyC+9n+TQzuSivA2BFpD6zV65Gxlc
         UQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729449222; x=1730054022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T994nC3yKb+Vde4eYi7s6bjrifvvScOE1gioC/lb0eI=;
        b=YeLkpp71+t9QvmF2FQaI7idgsrIRcMwuvWi1B7weIppdiZ7ZB+RVqT3MmxNOiw4oXm
         6F700UxeunFfvUbCEPHSD3oxMnWMQl0AbBqBeVS1fYD4BoHVooviGCaHOZ9/aYBNUkmf
         +ayK9lHzJq0TG4/t4oczk76W5UMWYj3uWRRRILDYKmKIc5eFmc8XhYP1jmVJJ8ny2UMQ
         r+bw0igIO+YO+uacKospegpUIkVG6PfzXZ8/KhaDirtnQTl+a1LgljRr6V9KfkP3fKbw
         fY9V9x0+LdhWvgWYgTcKjEp2fCZJavO5K2hFZLM7+VuNhBHN9MRp4Vsgnn3ZlVQefWrR
         eMJA==
X-Forwarded-Encrypted: i=1; AJvYcCUwYEM+8ua9DRpsZOMOhHecN1XSzQK/j/RRqbTDA58Lx0+6PMrWBuADMjFnj2sgxAHmtq7Jleg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzErGVSkZ0/50V1Tqfhzd57LnetVWhGiXceLcUgbGkLyPc22QC
	EhpHlUGfdoMzM+5kzslt3UuQMruNjQTvyeZc8s3iW860Qe+EMYDVjQYTkKcUZag=
X-Google-Smtp-Source: AGHT+IEW/bkiKIeYv00wJX7unb93upEKkXSwIi/EpqTz5JnI6FiznuZjmlrieCUDHdOFpHaIdx5xRw==
X-Received: by 2002:a17:907:3dac:b0:a9a:bed:e564 with SMTP id a640c23a62f3a-a9a69c9ea18mr1000571966b.48.1729449222014;
        Sun, 20 Oct 2024 11:33:42 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9159a208sm113360266b.206.2024.10.20.11.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 11:33:41 -0700 (PDT)
Message-ID: <2c5d3bc2-b2b2-430f-8387-70be8a53c14b@linaro.org>
Date: Sun, 20 Oct 2024 19:33:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] usb: typec: qcom-pmic-typec: use
 fwnode_handle_put() to release fwnodes
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241020-qcom_pmic_typec-fwnode_remove-v2-0-7054f3d2e215@gmail.com>
 <20241020-qcom_pmic_typec-fwnode_remove-v2-1-7054f3d2e215@gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241020-qcom_pmic_typec-fwnode_remove-v2-1-7054f3d2e215@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/10/2024 13:56, Javier Carrasco wrote:
> The right function to release a fwnode acquired via
> device_get_named_child_node() is fwnode_handle_put(), and not
> fwnode_remove_software_node(), as no software node is being handled.
> 
> Replace the calls to fwnode_remove_software_node() with
> fwnode_handle_put() in qcom_pmic_typec_probe() and
> qcom_pmic_typec_remove().
> 
> Cc: stable@vger.kernel.org
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> index 2201eeae5a99..73a159e67ec2 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> @@ -123,7 +123,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>   port_unregister:
>   	tcpm_unregister_port(tcpm->tcpm_port);
>   fwnode_remove:
> -	fwnode_remove_software_node(tcpm->tcpc.fwnode);
> +	fwnode_handle_put(tcpm->tcpc.fwnode);
>   
>   	return ret;
>   }
> @@ -135,7 +135,7 @@ static void qcom_pmic_typec_remove(struct platform_device *pdev)
>   	tcpm->pdphy_stop(tcpm);
>   	tcpm->port_stop(tcpm);
>   	tcpm_unregister_port(tcpm->tcpm_port);
> -	fwnode_remove_software_node(tcpm->tcpc.fwnode);
> +	fwnode_handle_put(tcpm->tcpc.fwnode);
>   }
>   
>   static const struct pmic_typec_resources pm8150b_typec_res = {
> 
Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

