Return-Path: <stable+bounces-87593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE489A6F59
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 18:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0C41C23CE6
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4881E5703;
	Mon, 21 Oct 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaL59EI5"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71B1E3780
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527744; cv=none; b=rxt9ncYltpQcyEeuNmTmuy/9Jpbhskrkm8MlGkbbESBU2c/WX2lpJmeWmMkg974U+Yf1gTJYfmKXnGNMev6mlYwJuno6//nvynvbLHI2m4dbsVY2aUqZqwVoFK3Cjqoax0VQAditv/r++SQQ06JmLkTHR1QimGNEWbZ36ujCOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527744; c=relaxed/simple;
	bh=OPwLm4KbXRPjPPUsnhN3viq6xYmj5UJS4BgPDBMUoO0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfYFLd6BYC1Vbi5K6yPrtTrXVwqAlRjP7oyS66rDcv7S7rs1TMkMEoEMYmGj02OYEb6Ret/5u/bQuyIOBShEGO60AgjqXtMwlycZhJtDy+WzyFYfW6i4HEAD4+e1ZvQAu17ejrLt6bUEL4iHO+DR8vkJKF9GpfqrmQiyyc93rpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaL59EI5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539ee1acb86so2632242e87.0
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 09:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729527741; x=1730132541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bhwla8+6KA+J2l2zXzoT/1T3zQj3xRspy+bneLu4x4=;
        b=JaL59EI5qZ3rv0Tc8U+WoY1BP0TBzfVXKPVqI+Bv+En7aA9h8MkatUfWxh925BruYB
         ohURbZuQAWtqSYqYb3gJMOH1gMeqLJPnWUtDBwNO+16xaRiVIyE4pyeXCkIaK7KeZIge
         yVmdiOxBs2B3fw/ZYrA52TtF8lX9LnKuswig1LswsZkRnubyoHXq/Oox6rR9OTN7VD4o
         rDO6UZdmBc/9bDF9b7jtaC6hlQOOm+bru9oDXABW7DQDux+hDvp85qWXrml6q29PrMK0
         88QY+lAa22BznYFWz6upuqhcpbY7csUB4zXZTpvspxiMlVpz3+ebmz4ROKk8sApVZD+P
         /Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729527741; x=1730132541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bhwla8+6KA+J2l2zXzoT/1T3zQj3xRspy+bneLu4x4=;
        b=wya6JVM34T2+ByAN0t8Ezlffigf6F8IgYIGfx1+3LsBeA9D3uAQsa7+CAW2DAjabHd
         VTm+7K537b7/HfzbDNUnPVHfGBhNQ2lby+UK6b/yDh5dFC0SAsG335fwzeWoNROeeK1t
         TNi2ysxDJOJ08+snCFwn4rblOnKT1jglc+itmhfjKMsNvktmn5zgXwlm6OdhazThPYOr
         4v+3kIiFZi3EcZCf9hcvp0lEpyPhA2rBZ+exFQ2u3G0r3cd8oljpxEMX2IaY6F171H7H
         aT/trR8OgYkTiympDWRvgkyIlCW93HM31XkY5f5nfNy5VVf3IgPAIRLF7d2WChZSe77r
         X7bg==
X-Forwarded-Encrypted: i=1; AJvYcCWGsXSxqwsb9dfFcNE9yYL55ggIIT7f0/3Hqg8Ob3be1UVGAHfIk3ILR+UVlEy5T43yeeKs5RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyCSSY51WYfPnFoz3CZmfA7ACET0LPV1cTte/xke5gpfYG5Jc
	ARaRU6XvkoolMad2XD52XHofxcIixHceGdbDsF9qSzkiBfwkmIcf
X-Google-Smtp-Source: AGHT+IG0ia65F5bFAoAh4IwlqxoYqOtesCPVPMKTH3oy6uQ69GOTbPfTqJEHKVXBSwaxhqJSuLqKMw==
X-Received: by 2002:a05:6512:308d:b0:536:55a8:6f78 with SMTP id 2adb3069b0e04-53a15219180mr5534266e87.17.1729527740521;
        Mon, 21 Oct 2024 09:22:20 -0700 (PDT)
Received: from pc636 (host-90-233-222-236.mobileonline.telia.com. [90.233.222.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243ecb4sm518168e87.247.2024.10.21.09.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:22:20 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 21 Oct 2024 18:22:17 +0200
To: Ben Greear <greearb@candelatech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.11 024/135] lib: alloc_tag_module_unload must wait for
 pending kfree_rcu calls
Message-ID: <ZxZ_uX0e1iEKZMk5@pc636>
References: <20241021102259.324175287@linuxfoundation.org>
 <20241021102300.282974151@linuxfoundation.org>
 <a4163f51-cc1a-0848-d0fd-e9b94dafc306@candelatech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4163f51-cc1a-0848-d0fd-e9b94dafc306@candelatech.com>

On Mon, Oct 21, 2024 at 09:16:43AM -0700, Ben Greear wrote:
> On 10/21/24 03:23, Greg Kroah-Hartman wrote:
> > 6.11-stable review patch.  If anyone has any objections, please let me know.
> 
> This won't compile in my 6.11 tree (as of last week), I think it needs more
> upstream patches and/or a different work-around.
> 
> Possibly that has already been backported into 6.11 stable and I just haven't
> seen it yet.
> 
Right. The kvfree_rcu_barrier() will appear starting from 6.12 kernel.

--
Uladzislau Rezki

