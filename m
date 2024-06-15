Return-Path: <stable+bounces-52264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F4909688
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 09:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6B11C21AE7
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 07:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E70A8C0B;
	Sat, 15 Jun 2024 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0W6aNMl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC502182BB
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718436723; cv=none; b=gV+DGVD1vXWu34raEHRXtT/c08WU5vh6/ixATIj4geRNyW2Tf+SB5qCUA0LXQY9XTRamiCQ7Azcdrdhz6Cup3UU1hbK6G2P1/aOSD89f77a5C7imFWHfPIi/D5VHg8kdljHMqOmx3VOKXZKhlPdNOAFLe0rErGU5Eh2ZT2Iy+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718436723; c=relaxed/simple;
	bh=L0RZOvRr0146a65l+Z/0N+aXl/WzENRc3Hc4/I/MwK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRgbFS6ADCyKugiJj+3b9SZ4EifbhX6UVP3+t5WSknUzGEPDuAzjD8Gg61U6VWxI9w+ESklyekTVYfTSo8rGTPAoytzp2RqIhXeDsPq/WoB//wg8WnKdLN3KV1rXWSjFtcM6e2mKOol1MGPNWskI/UkqkD9OGqHLrqp0scvZ8a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0W6aNMl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57c7681ccf3so3214942a12.2
        for <stable@vger.kernel.org>; Sat, 15 Jun 2024 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718436720; x=1719041520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFIgZ6Q7qFhQeTRm1XmtzW0iSIg1ChQv5pkU5SVP7uw=;
        b=a0W6aNMlgbL1Ye3EjVhwnhucgb3ruFP4fMO5NgwwL6D6anLoJ/HgF3mT881YP0f7IB
         a2YkB9XIJPa03gIGFNfrjbJuSxEHLt9vy3Q/hTNHafLLU+64+nPXDQQf4OWk6DxdT06/
         z2q9PyVLu7+hu1uX5AMlZEpjKF28ASeFN9bBEvbm5feB5paBpcMaDcIr5h0HSCN1ZCTs
         PwiahYbxCYj3KkAmtE5cY5czSuh1qQhORTKs27B44p3LdOeM5VSJH5FWy5l43FN2DHDy
         M8bsSxvpUzt1fetG9OGRxL6cugpeMqHGQyo6qj6OjvavtZSZn0YVdVZGgjMs1JbnnWpm
         ucbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718436720; x=1719041520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFIgZ6Q7qFhQeTRm1XmtzW0iSIg1ChQv5pkU5SVP7uw=;
        b=HNYbtP75MhngssNgSrRu2iYZvpF5AIneFxG+VeIg1jaBZZnK68pnjfX6l/JSKDk8Gc
         Sv/ti6ExuNFQcqqTn6yjJHWhgAWQEkefInpjKmaw7jBqYEpQtuZ3ED17CjONumQCLioK
         LsaDbaur0Z3WDz21ubbU4mhkDty20HE+6dnpROFCE7oXRU0IgfzSenQxbrQ7rCU8ig0o
         Lb1zPusthOhj6Md5fU7iZSvwwO1UdbawahBX37H935sjsVRLWx/R7yCt5SnPcP0iUu7m
         OOfT/J53WnpZKtDF7dKup0+rp8WS7IkGSwA1cAFA2jzw2YUCg6xFMRTZK9n9xiUObOCk
         3W9g==
X-Gm-Message-State: AOJu0YwfdttTYhQbs/P3f7/kTAYQrbpHbBpME+gZ4eL6iyHbhxnH/3ea
	kfmBvVSlwh1/1vkzTGHNNCzU+7bsnb3qu6xTTSW2ebqKPYitPckA
X-Google-Smtp-Source: AGHT+IEAaQlTeYtNrCmFH0xBI6YQN84MALuG3cv7bmBzXSYBqETd/ok6DAoFlzDqzMKnxKNtoBI4+w==
X-Received: by 2002:a50:9fe7:0:b0:57c:5b26:46e2 with SMTP id 4fb4d7f45d1cf-57cbd6a58cfmr2690212a12.31.1718436719594;
        Sat, 15 Jun 2024 00:31:59 -0700 (PDT)
Received: from Laptop-X1 ([147.229.117.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da07fsm3256370a12.23.2024.06.15.00.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 00:31:59 -0700 (PDT)
Date: Sat, 15 Jun 2024 09:31:57 +0200
From: Hangbin Liu <liuhangbin@gmail.com>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, petrm@nvidia.com,
	pabeni@redhat.com, kuba@kernel.org
Subject: Re: [PATCH 6.6.y 1/2] selftests/net: add lib.sh
Message-ID: <Zm1DbTQ01tm-471j@Laptop-X1>
References: <20240614065820.865974-1-po-hsu.lin@canonical.com>
 <20240614065820.865974-2-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614065820.865974-2-po-hsu.lin@canonical.com>

On Fri, Jun 14, 2024 at 02:58:19PM +0800, Po-Hsu Lin wrote:
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -4,9 +4,6 @@
>  ##############################################################################
>  # Defines
>  
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> -
>  # Can be overridden by the configuration file.
>  PING=${PING:=ping}
>  PING6=${PING6:=ping6}
> @@ -41,6 +38,7 @@ if [[ -f $relative_path/forwarding.config ]]; then
>  	source "$relative_path/forwarding.config"
>  fi
>  
> +source ../lib.sh
>  ##############################################################################
>  # Sanity checks
>  
> @@ -395,29 +393,6 @@ log_info()
>  	echo "INFO: $msg"
>  }
>  
> -busywait()
> -{
> -	local timeout=$1; shift
> -
> -	local start_time="$(date -u +%s%3N)"
> -	while true
> -	do
> -		local out
> -		out=$("$@")
> -		local ret=$?
> -		if ((!ret)); then
> -			echo -n "$out"
> -			return 0
> -		fi
> -
> -		local current_time="$(date -u +%s%3N)"
> -		if ((current_time - start_time > timeout)); then
> -			echo -n "$out"
> -			return 1
> -		fi
> -	done
> -}
> -

Hi Po-Hsu,

There are some selftest architecture issues with only this patch. We need
at least the following patch to fix it.

2114e83381d3 ("selftests: forwarding: Avoid failures to source net/lib.sh")

Thanks
Hangbin

